require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end

  describe 'relationships' do
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks) }
  end

  describe "#average_snack_price" do
    it "returns average price of its snacks" do
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Mixed Drinks")

      doritos = dons.snacks.create(name: "Doritos", price: 1.00)
      donuts = dons.snacks.create(name: "Donuts", price: 2.00)

      dons.snacks << doritos
      dons.snacks << donuts

      expect(dons.average_snack_price).to eq(1.50)
    end
  end
end
