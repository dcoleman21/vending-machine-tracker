require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  it "sees the name of all of the snacks and their price" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    doritos = dons.snacks.create(name: "Doritos", price: 1.75)
    donuts = dons.snacks.create(name: "Donuts", price: 2.00)

    MachineSnack.create(machine_id: dons.id, snack_id: doritos.id)

    visit machine_path(dons)

    expect(page).to have_content("#{dons.location} Vending Machine")
    expect(page).to have_content(doritos.name)
    expect(page).to have_content(doritos.price)
    expect(page).to have_content(donuts.name)
    expect(page).to have_content(donuts.price)
  end

  it "sees an average price for all of the sancks in that machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    doritos = dons.snacks.create(name: "Doritos", price: 1.75)
    donuts = dons.snacks.create(name: "Donuts", price: 2.00)

    MachineSnack.create(machine_id: dons.id, snack_id: doritos.id)

    visit machine_path(dons)

    expect(page).to have_content("#{dons.location} Vending Machine")
    expect(page).to have_content(doritos.name)
    expect(page).to have_content(doritos.price)
    expect(page).to have_content(donuts.name)
    expect(page).to have_content(donuts.price)
    expect(page).to have_content(dons.average_snack_price)
  end
end
