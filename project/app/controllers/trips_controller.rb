# frozen_string_literal: true

# TripsController manages all actions related to trips, including creating, updating,
# deleting trips, and managing participants. It also handles displaying trip details
# and calculating summaries for participants' expenses, debts, and contributions.
class TripsController < ApplicationController
  # Ensure the user is authenticated before performing any actions
  before_action :authenticate_user!

  # Set the trip object for specific actions.
  before_action :set_trip, only: %i[show edit update destroy add_participant remove_participant]

  # GET /trips
  # Displays the trips created by the current user and trips the user is participating in
  def index
    @created_trips = current_user.created_trips
    @participating_trips = current_user.participating_trips
  end

  # GET /trips/:id
  # Displays the details of a trip, including expense summaries for all participants
  def show
    @user_debts_summary = {}
    @user_owes_summary = {}

    # Calculate expense details for each participant
    @trip.participants.each do |user|
      user_summary = { total_spent: 0, participants_owe: Hash.new(0), total_owe: 0, participants_pay: Hash.new(0) }

      # Calculate the total amount spent by the user
      user_summary[:total_spent] = user.created_expenses.where(trip_id: @trip.id).sum(:t_amount)

      # Calculate the amount owed by other participants for this user's expenses
      user.created_expenses.where(trip_id: @trip.id).each do |expense|
        num_participants = expense.participants.count
        next if num_participants <= 0

        share_per_participant = (expense.t_amount / num_participants).round(2)
        expense.participants.each do |participant|
          user_summary[:participants_owe][participant.email] += share_per_participant
        end
      end

      # Convert owed amounts to an array of hashes for display
      user_summary[:participants_owe] = user_summary[:participants_owe].map do |email, owed_amount|
        { email: email, owed_amount: owed_amount.round(2) }
      end

      @user_owes_summary[user.id] = user_summary
      total_owe = 0

      # Calculate the total amount this user owes for other participants' expenses
      user.participating_expenses.where(trip_id: @trip.id).each do |expense|
        num_participants = expense.participants.count
        next if num_participants <= 0

        share_per_participant = (expense.t_amount / num_participants).round(2)
        user_summary[:participants_pay][expense.creator.email] += share_per_participant
        total_owe += share_per_participant
      end

      user_summary[:total_owe] = total_owe

      # Convert pay amounts to an array of hashes for display
      user_summary[:participants_pay] = user_summary[:participants_pay].map do |email, pay_amount|
        { email: email, pay_amount: pay_amount.round(2) }
      end

      @user_debts_summary[user.id] = user_summary
    end
  end

  # GET /trips/new
  # Initializes a new trip object
  def new
    @trip = Trip.new
  end

  # POST /trips
  # Creates a new trip and adds the current user as a participant
  def create
    @trip = current_user.created_trips.build(trip_params)
    if @trip.save
      flash[:notice] = "Trip created successfully."
      @trip.participants << current_user
      redirect_to @trip
    else
      render :new
    end
  end

  # GET /trips/:id/edit
  # Renders the form for editing a trip
  def edit
    # Method renders view used the form for editing a trip.
  end

  # PATCH/PUT /trips/:id
  # Updates the details of a trip
  def update
    if @trip.update(trip_params)
      flash[:notice] = "Trip updated successfully."
      redirect_to @trip
    else
      render :edit
    end
  end

  # DELETE /trips/:id
  # Deletes a trip
  def destroy
    if @trip.destroy
      flash[:notice] = "Trip deleted successfully."
      redirect_to trips_path
    else
      flash[:alert] = "Failed to delete the trip."
    end
  end

  # POST /trips/:id/add_participant
  # Adds a user as a participant to the trip
  def add_participant
    @user = find_user_by_email

    if addable_participant?
      add_user_to_trip
      flash[:notice] = "User added as a participant."
    else
      flash[:alert] ||= "User is already a participant." if @trip.participants.include?(@user)
      flash[:alert] ||= "User not found."
    end

    redirect_to edit_trip_path(@trip)
  end

  # DELETE /trips/:id/remove_participant
  # Removes a user from the trip participants
  def remove_participant
    @user = find_user_by_email

    if removable_participant?
      remove_user_from_trip
      flash[:notice] = "User removed from the trip."
    else
      flash[:alert] = "User is not a participant or does not exist."
    end

    redirect_to @trip
  end

  private

  # Checks if the user can be removed from the trip
  def removable_participant?
    @user && @trip.participants.include?(@user)
  end

  # Removes the user from the trip participants
  def remove_user_from_trip
    user_trip = UserTrip.find_by(user_id: @user.id, trip_id: @trip.id)
    user_trip&.destroy
  end

  # Finds the trip by ID
  def set_trip
    @trip = Trip.find(params[:id])
  end

  # Strong parameters for trip attributes
  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :photo, :hotel, :trip, :check_in, participant_ids: [])
  end

  # Finds a user by their email
  def find_user_by_email
    User.find_by(email: params[:participant_email])
  end

  # Checks if the user can be added to the trip
  def addable_participant?
    @user && !@trip.participants.include?(@user)
  end

  # Adds the user to the trip participants
  def add_user_to_trip
    @trip.participants << @user
  end
end
