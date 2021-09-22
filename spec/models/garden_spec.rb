require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  describe '#instance_methods' do
    describe '#display_plants' do
      before(:each) do
        @turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)

        @plot_25 = @turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
        @plot_26 = @turing_garden.plots.create!(number: 26, size: "Small", direction: "West")

        @banana_pepper = @plot_25.plants.create!(name: "banana pepper", description: "sweet and spicy", days_to_harvest: "50")
        @beefsteak_tomato = @plot_25.plants.create!(name: "beefsteak tomato", description: "big and juicy", days_to_harvest: "60")
        @arugula = @plot_25.plants.create!(name: "arugula", description: "green and fresh", days_to_harvest: "45")

        @butternut_squash = @plot_26.plants.create!(name: "butternut squash", description: "hearty delicious", days_to_harvest: "70")
        @leek = @plot_26.plants.create!(name: "leek", description: "add some flavor", days_to_harvest: "30")
        @carrot = @plot_26.plants.create!(name: "carrots", description: "what's up doc", days_to_harvest: "55")
        @banana_pepper_2 = @plot_26.plants.create!(name: "banana pepper", description: "sweet and spicy", days_to_harvest: "50")
        @watermelon = @plot_26.plants.create!(name: "watermelon", description: "big big big", days_to_harvest: "100")

        @plot_26.plants << @banana_pepper

        @display_plants = @turing_garden.display_plants
      end

      it 'should have all plants' do
        expect(@display_plants.first.name).to eq(@arugula.name)
        expect(@display_plants.last.name).to eq(@leek.name)
      end

      it 'should not have plants that take 100 days or more' do
        expectation = @display_plants.any? do |plant|
          plant.name == "#{@watermelon.name}"
        end

        expect(expectation).to eq(false)
      end
    end
  end
end
