class AddFileToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :file, :string
  end
end
