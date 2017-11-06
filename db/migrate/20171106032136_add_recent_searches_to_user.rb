class AddRecentSearchesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :recent_searches, :string, array: true, default: []
  end
end
