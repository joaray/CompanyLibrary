class AddStatusToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :book_status, :boolean, default: true
  end
end
