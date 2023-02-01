class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, null: false#null: false追加
      t.integer :followed_id, null: false#null: false追加

      t.timestamps
    end

    add_index :relationships, :follower_id #追加
    add_index :relationships, :followed_id #追加
    add_index :relationships,  [:follower_id, :followed_id], unique: true
  end
end
