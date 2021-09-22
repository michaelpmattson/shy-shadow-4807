require 'rails_helper'

RSpec.describe PlotPlant, type: :model do
  describe 'relationships' do
    it { should belong_to :plot }
    it { should belong_to :plant }
  end

  describe '.class_methods' do
    before(:each) do
      @turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)

      @plot_25 = @turing_garden.plots.create!(number: 25, size: "Large", direction: "East")

      @banana_pepper = Plant.create!(name: "banana pepper", description: "sweet and spicy", days_to_harvest: "50")

      @plot_plant = PlotPlant.create!(plot_id: @plot_25.id, plant_id: @banana_pepper.id)
    end

    describe 'plot_plant_by_ids(plot_id, plant_id)' do
      it 'finds plot plant by ids' do
        expect(PlotPlant.plot_plant_by_ids(@plot_25.id, @banana_pepper.id)).to eq(@plot_plant)
      end
    end
  end
end
