class Ticket < ActiveRecord::Base
    belongs_to :user

    validates :title, :date, :artist, presence: true
end