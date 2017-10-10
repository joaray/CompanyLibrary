class AddReferenceToLoans < ActiveRecord::Migration[5.1]
  def change
    add_reference :loans, :user, index: true, foreign_key: true
    add_reference :loans, :book, index: true, foreign_key: true
  end
end
