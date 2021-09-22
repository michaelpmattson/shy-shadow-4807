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

  context 'plant sorting' do
    before(:each) do
      @turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)

      @plot_25 = @turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
      @plot_26 = @turing_garden.plots.create!(number: 26, size: "Small", direction: "West")
      @plot_27 = @turing_garden.plots.create!(number: 27, size: "Small", direction: "North")
      @plot_28 = @turing_garden.plots.create!(number: 28, size: "Small", direction: "South")
      @plot_29 = @turing_garden.plots.create!(number: 28, size: "Small", direction: "Skyward")

      @banana_pepper    = Plant.create!(name: "banana pepper", description: "sweet and spicy", days_to_harvest: "50")
      @beefsteak_tomato = Plant.create!(name: "beefsteak tomato", description: "big and juicy", days_to_harvest: "60")
      @arugula          = Plant.create!(name: "arugula", description: "green and fresh", days_to_harvest: "45")
      @butternut_squash = Plant.create!(name: "butternut squash", description: "hearty delicious", days_to_harvest: "70")
      @leek             = Plant.create!(name: "leek", description: "add some flavor", days_to_harvest: "30")
      @carrot           = Plant.create!(name: "carrots", description: "what's up doc", days_to_harvest: "55")

      @plot_25.plants << @banana_pepper
      @plot_26.plants << @banana_pepper
      @plot_27.plants << @banana_pepper
      @plot_28.plants << @banana_pepper
      @plot_29.plants << @banana_pepper

      @plot_25.plants << @leek
      @plot_26.plants << @leek
      @plot_27.plants << @leek
      @plot_28.plants << @leek

      @plot_25.plants << @carrot
      @plot_27.plants << @carrot
      @plot_28.plants << @carrot

      @plot_25.plants << @beefsteak_tomato
      @plot_28.plants << @beefsteak_tomato

      @plot_25.plants << @arugula

      visit "/gardens/#{@turing_garden.id}"
    end

    xit 'sorts plants by how often they appear, most to least' do
      expect(@banana_pepper.name).to    appear_before(@leek.name)
      expect(@leek.name).to             appear_before(@carrot.name)
      expect(@carrot.name).to           appear_before(@beefsteak_tomato.name)
      expect(@beefsteak_tomato.name).to appear_before(@arugula.name)
    end
  end
end


# Extension,
# As a visitor
# When I visit a garden's show page,
# Then I see the list of plants is sorted by the number of plants that appear in any of that garden's plots from most to least
# (Note: you should only make 1 database query to retrieve the sorted list of plants)
