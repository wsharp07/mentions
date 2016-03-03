class CreateWebhooks < ActiveRecord::Migration[5.0]
  def change
    create_table :webhooks do |t|
      t.string :from, null: false
      t.string :to, null: false
      t.string :token, null: false

      t.timestamps
    end

    add_index :webhooks, :token, unique: true
  end
end
