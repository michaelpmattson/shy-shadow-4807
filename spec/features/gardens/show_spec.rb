require 'rails_helper'

RSpec.describe 'the garden show page' do
  context 'when i visit a garden show page' do
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

      visit "/gardens/#{@turing_garden.id}"
    end

    it 'has a list of plants that are included in that gardens plots' do
      save_and_open_page
      expect(page).to have_content(@banana_pepper.name)
      expect(page).to have_content(@beefsteak_tomato.name)
      expect(page).to have_content(@arugula.name)
      expect(page).to have_content(@butternut_squash.name)
      expect(page).to have_content(@leek.name)
      expect(page).to have_content(@carrot.name)
    end

    # it 'has no duplicate plants' do
    #
    # end

    it 'only includes plants that take less than 100 days' do
      expect(page).to_not have_content(@watermelon.name)
    end
  end
end
