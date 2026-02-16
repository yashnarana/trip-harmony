# frozen_string_literal: true

# ExpensesController handles the creation, management, and association of expenses
# with trips and participants. It supports CRUD operations (create, read, update,
# delete) for expenses, as well as the ability to manage participants for each
# expense. This controller ensures expenses are properly linked to their trips
# and enforces relationships between users, trips, and expenses.
class ExpensesController < ApplicationController
  # Use callbacks to set up common resources for actions
  before_action :set_expense, only: %i[show edit update destroy add_participant remove_participant]
  before_action :set_trip, only: %i[new create edit update]

  # GET /expenses or /expenses.json
  # Displays a list of all expenses
  def index
    @expenses = Expense.all
  end

  # GET /expenses/1 or /expenses/1.json
  # Displays the details of a specific expense
  def show
    # Method renders view used for displaying an individual trip.
  end

  # GET /expenses/new
  # Initializes a new expense object associated with the current trip
  def new
    @expense = @trip.expenses.build
  end

  # GET /expenses/1/edit
  # Fetches the expense for editing
  def edit
    # Method renders view used the form for editing a trip.
  end

  # POST /expenses or /expenses.json
  # Creates a new expense and associates it with the current trip and user
  def create
    # Build and save the expense
    @expense = current_user.created_expenses.build(expense_params)
    @expense.trip = @trip
    if @expense.save
      handle_participants
      flash[:notice] = "Expense created successfully!"
      redirect_to @expense
    else
      # Render the 'new' view if the save fails
      render :new
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  # Updates the details of an existing expense
  def update
    if @expense.update(expense_params)
      flash[:notice] = "Expense updated successfully!"
      redirect_to @expense
    else
      render :edit
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  # Deletes an expense and redirects to the expenses list
  def destroy
    @expense.destroy
    flash[:notice] = "Expense deleted successfully!"
    redirect_to expenses_url
  end

  # POST /expenses/1/add_participant
  # Adds a user as a participant to the expense
  def add_participant
    @user = find_user_by_email

    if participant_addable?
      add_user_to_expense
      flash[:notice] = "User added as a participant."
    end

    redirect_to @expense
  end

  # DELETE /expenses/1/remove_participant
  # Removes a user from the expense participants
  def remove_participant
    @user = User.find(params[:participant_id])

    if @expense.participants.include?(@user)
      @expense.participants.delete(@user)
      flash[:notice] = "User removed from participants."
    else
      flash[:alert] = "User is not a participant."
    end

    redirect_to @expense
  end

  private

  # Checks whether the user can be added as a participant to the expense
  def participant_addable?
    return false if @user.nil?
    return flash[:notice] = "User is already a participant." if @expense.participants.include?(@user)
    return flash[:notice] = "User is not a participant in the trip." if @expense.trip.participants.exclude?(@user)

    true
  end

  # Finds a user by the provided email
  def find_user_by_email
    User.find_by(email: params[:participant_email]).tap do |user|
      flash[:alert] = "User not found." if user.nil?
    end
  end

  # Adds the user to the expense's participants
  def add_user_to_expense
    @expense.participants << @user
  end

  # Handles the addition of all trip participants to the expense if specified
  def handle_participants
    return unless params[:expense][:include_all_trip_participants] == "1"

    @expense.participants << @trip.participants
  end

  # Finds the expense based on the ID parameter
  def set_expense
    @expense = Expense.find(params[:id])
  end

  # Sets the trip either from the expense or based on the trip_id parameter
  def set_trip
    @trip = @expense.trip if @expense
    @trip ||= Trip.find(params[:trip_id]) if params[:trip_id]
  end

  # Strong parameters to allow only permitted attributes for expenses
  def expense_params
    params.require(:expense).permit(:description, :t_amount, :expense_date, :categories, :trip_id)
  end
end
