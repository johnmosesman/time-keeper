class Category < ActiveRecord::Base
  belongs_to :user
  has_many :records, dependent: :destroy

  validates :title, :amount, presence: true
  validates :amount, numericality: true

  def record_for_today
    today = Date.today.beginning_of_day..Date.today.end_of_day
    records.where(created_at: today)
  end

  def records_for_last_week
    range = (Date.today.beginning_of_day - 1.week)..Date.today.end_of_day
    records.where(created_at: range)
  end
end
