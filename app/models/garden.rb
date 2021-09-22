class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def display_plants
    plants.select(:name).order(:name).distinct.where('plants.days_to_harvest < 100')
  end
end
