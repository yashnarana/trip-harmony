class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.string :description
      t.float :t_amount
      t.date :expense_date
      t.string :categories

      t.timestamps
    end
  end
end
