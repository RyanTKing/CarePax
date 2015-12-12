class Driver < ActiveRecord::Base
  belongs_to :user

  validates :plate, presence: true, length: { is: 6 }
  validates :make, presence: true
  validates :model, presence: true
  validates :model, presence: true
  validates :year, presence: true
end
