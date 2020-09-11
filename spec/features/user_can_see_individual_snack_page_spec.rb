# As a visitor
# When I visit a snack show page
# I see the name of that snack
#   and I see the price for that snack
#   and I see a list of locations with vending machines that carry that snack
#   and I see the average price for snacks in those vending machines
#   and I see a count of the different kinds of items in that vending machine.
require 'rails_helper'

RSpec.describe "snack show page" do
  it "can see the name of that snack" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    doritos = dons.snacks.create(name: "Doritos", price: 1.75)
    donuts = dons.snacks.create(name: "Donuts", price: 2.00)

    MachineSnack.create(machine_id: dons.id, snack_id: doritos.id)

    visit snack_path
  end

end
