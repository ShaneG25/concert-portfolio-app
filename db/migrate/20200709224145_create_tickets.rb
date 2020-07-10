class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.string :date
      t.string :artist
      t.belongs_to :user
    end
  end
end
