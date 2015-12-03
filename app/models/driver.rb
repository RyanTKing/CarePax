class Driver < ActiveRecord::Base
	validates :plate, presence: true, length: { maximum: 6 }
	validates :make, length: { maximum: 255 }
	validates :model, length: { maximum: 255 }
	validates :year, length: { maximum: 4 }
	VALIDATE_COLOR_REGEX = [a-z]+
	validates :color, length: { maximum: 40 },
		format: { with: VALIDATE_COLOR_REGEX }
	validates :status, length: { maximum: 40 }
end
