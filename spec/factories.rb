FactoryBot.define do
  factory :product do |p|
    sequence(:name) { |n| "Samsung Monitor ##{n}" }
    price { 100 }
    category { 'Electronics' }
  end
end
