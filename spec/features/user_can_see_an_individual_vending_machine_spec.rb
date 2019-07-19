require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  scenario 'I see all the vending machines snacks along with their price and average' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    burger = dons.snacks.create!(name: "White Castle Burger", price: 3.50)
    pop_rocks = dons.snacks.create(name: "Pop Rocks", price: 1.50)
    cheetos = dons.snacks.create(name: "Flaming Hot Cheetos", price: "2.50")

    visit machine_path(dons)

    expect(page).to have_content(burger.name)
    expect(page).to have_content(number_to_currency(burger.price))

    expect(page).to have_content(pop_rocks.name)
    expect(page).to have_content(number_to_currency(pop_rocks.price))

    expect(page).to have_content(cheetos.name)
    expect(page).to have_content(number_to_currency(cheetos.price))

    expect(page).to have_content(number_to_currency((cheetos.price) + (burger.price) + (pop_rocks.price)) / 3)

  end
end
