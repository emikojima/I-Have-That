class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :detail
      t.integer :user_id
    end
  end
end
