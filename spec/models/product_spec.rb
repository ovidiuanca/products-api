require 'rails_helper'

RSpec.describe Product, type: :model do
  subject {
    described_class.new(name: 'Samsung Monitor 24',
                        price: 250,
                        category: Product::ELECTRONICS)
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil

    expect(subject).to_not be_valid
  end

  it 'is not valid without a price' do
    subject.price = nil

    expect(subject).to_not be_valid
  end

  it 'is not valid without a category' do
    subject.category = nil

    expect(subject).to_not be_valid
  end
end
