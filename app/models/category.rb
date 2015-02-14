class Category < ActiveRecord::Base
  belongs_to :user
  has_many :records, dependent: :destroy

  validates :title, :amount, presence: true
  validates :amount, numericality: true
end
