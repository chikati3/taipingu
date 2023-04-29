class Game < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :answer, presence: true
end
