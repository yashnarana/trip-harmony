# frozen_string_literal: true

# UsersController handles user-specific actions such as viewing the user's profile,
# managing trip summaries, and updating user details. It processes and displays
# financial summaries for trips the user has created and participated in.
class UsersController < ApplicationController
  # Ensure the user is authenticated before accessing any actions
  before_action :authenticate_user!

  # GET /users/:id
  # Displays the user's profile and detailed financial summaries for trips they
  # created and trips they participated in.
  def show
    @user = current_user

    # Trips created by the user
    @user_created_trips = @user.created_trips
    # Trips the user is participating in
    @user_participating_trips = @user.participating_trips

    # Financial summaries for trips created by the user
    @created_trips_summary = {}
    # Financial summaries for trips the user is participating in
    @other_trips_summary = {}

    # Process trips created by the user
    @user_created_trips.each do |trip|
      next if trip.expenses.empty? # Skip trips without expenses

      # Initialize a summary for the trip
      trip_summary = { total_spent: 0, participants_owe: Hash.new(0), total_owe: 0, participants_pay: Hash.new(0) }

      # Calculate total spent by the user in the trip
      trip_summary[:total_spent] = trip.expenses.where(creator: @user).sum(:t_amount)

      # Calculate amounts owed by participants for this user's expenses
      trip.expenses.where(creator: @user).each do |expense|
        num_participants = expense.participants.count
        next if num_participants <= 0

        share_per_participant = (expense.t_amount / num_participants).round(2)
        expense.participants.each do |participant|
          trip_summary[:participants_owe][participant.email] += share_per_participant
        end
      end

      # Convert owed amounts to an array for easier rendering
      trip_summary[:participants_owe] = trip_summary[:participants_owe].map do |email, owed_amount|
        { email: email, owed_amount: owed_amount.round(2) }
      end

      # Process expenses in the trip not created by the user
      other_expenses = trip.expenses.where.not(creator: @user)
      total_owe = 0

      other_expenses.each do |expense|
        num_participants = expense.participants.count
        next if num_participants <= 0

        share_per_participant = (expense.t_amount / num_participants).round(2)
        trip_summary[:participants_pay][expense.creator.email] += share_per_participant
        total_owe += share_per_participant
      end

      trip_summary[:total_owe] = total_owe

      # Convert pay amounts to an array for easier rendering
      trip_summary[:participants_pay] = trip_summary[:participants_pay].map do |email, pay_amount|
        { email: email, pay_amount: pay_amount.round(2) }
      end

      @created_trips_summary[trip.id] = trip_summary
    end

    # Process trips the user is participating in
    @user_participating_trips.each do |trip|
      next if trip.expenses.empty? # Skip trips without expenses

      # Initialize a summary for the trip
      trip_summary = { total_spent: 0, participants_owe: Hash.new(0), total_owe: 0, participants_pay: Hash.new(0) }

      # Calculate total spent by the user in the trip
      trip_summary[:total_spent] = trip.expenses.where(creator: @user).sum(:t_amount)

      # Calculate amounts owed by participants for this user's expenses
      trip.expenses.where(creator: @user).each do |expense|
        num_participants = expense.participants.count
        next if num_participants <= 0

        share_per_participant = (expense.t_amount / num_participants).round(2)
        expense.participants.each do |participant|
          trip_summary[:participants_owe][participant.email] += share_per_participant
        end
      end

      # Convert owed amounts to an array for easier rendering
      trip_summary[:participants_owe] = trip_summary[:participants_owe].map do |email, owed_amount|
        { email: email, owed_amount: owed_amount.round(2) }
      end

      # Process expenses in the trip not created by the user
      other_expenses = trip.expenses.where.not(creator: @user)
      total_owe = 0

      other_expenses.each do |expense|
        num_participants = expense.participants.count
        next if num_participants <= 0

        share_per_participant = (expense.t_amount / num_participants).round(2)
        trip_summary[:participants_pay][expense.creator.email] += share_per_participant
        total_owe += share_per_participant
      end

      trip_summary[:total_owe] = total_owe

      # Convert pay amounts to an array for easier rendering
      trip_summary[:participants_pay] = trip_summary[:participants_pay].map do |email, pay_amount|
        { email: email, pay_amount: pay_amount.round(2) }
      end

      @other_trips_summary[trip.id] = trip_summary
    end
  end

  # GET /users/:id/edit
  # Renders the form for editing the user's profile
  def edit
    @user = current_user
  end

  # PATCH/PUT /users/:id
  # Updates the user's profile
  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_profile_path, notice: "Profile updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Strong parameters for user updates
  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
