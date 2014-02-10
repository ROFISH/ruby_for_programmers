class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :handle
      t.text :body_text

      t.timestamps
    end
  end
end
