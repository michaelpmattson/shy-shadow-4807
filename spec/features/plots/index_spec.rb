require 'rails_helper'

describe 'the plot index page' do
  context 'when i visit the plot index page' do
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

      visit '/plots'
    end

    it 'has a list of all the plot numbers' do
      expect(page).to have_content(@plot_25.number)
      expect(page).to have_content(@plot_26.number)
    end

    it 'has names of each plant under the plot number' do
      within "#plot-#{@plot_25.number}" do
        expect(page).to     have_content(@banana_pepper.name)
        expect(page).to     have_content(@beefsteak_tomato.name)
        expect(page).to     have_content(@arugula.name)
        expect(page).to_not have_content(@butternut_squash)
      end

      within "#plot-#{@plot_26.number}" do
        expect(page).to     have_content(@butternut_squash.name)
        expect(page).to     have_content(@leek.name)
        expect(page).to     have_content(@carrot.name)
        expect(page).to_not have_content(@banana_pepper)
      end
    end

    it 'has a link to remove plant next to each plant name' do
      save_and_open_page
      within "#plot-#{@plot_25.number}" do
        expect(page).to have_content(@banana_pepper.name)
      end

      within "#plant-#{@banana_pepper.id}" do
        click_link("Remove plant")
      end
      save_and_open_page
      expect(current_path).to eq('/plots')

      within "#plot-#{@plot_25.number}" do
        expect(page).to_not have_content(@banana_pepper.name)
      end

      expect(Plant.find(@banana_pepper.id)).to eq(@banana_pepper)
    end
  end
end

# User Story 2, Remove a Plant from a Plot
# As a visitor
# When I visit a plot's index page
# Next to each plant's name
# I see a link to remove that plant from that plot
# When I click on that link
# I'm returned to the plots index page
# And I no longer see that plant listed under that plot
# (Note: you should not destroy the plant record entirely)
