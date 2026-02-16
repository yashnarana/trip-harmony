json.extract! expense, :id, :description, :t_amount, :expense_date, :categories, :created_at, :updated_at, :trip_id
json.url expense_url(expense, format: :json)
