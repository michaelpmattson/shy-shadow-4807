class PlotPlant < ApplicationRecord
  belongs_to :plot
  belongs_to :plant

  def self.plot_plant_by_ids(plot_id, plant_id)
    where(plot_id: plot_id, plant_id: plant_id).first
  end
end
