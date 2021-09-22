class PlotPlantsController < ApplicationController
  def destroy
    plot_plant = PlotPlant.plot_plant_by_ids(params[:plot_id], params[:id])
    plot_plant.destroy
    redirect_to(plots_path)
  end
end
