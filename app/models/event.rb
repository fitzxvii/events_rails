class Event < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :attendees
  has_many :users, through: :attendees
  
  validates :name, :city, :state, :date, presence: true
  validate :date_validation
  
  private 
    def date_validation
      unless date == nil
        errors.add(:date, 'must be on a future date') if date <= Date.today
      end
    end
end
