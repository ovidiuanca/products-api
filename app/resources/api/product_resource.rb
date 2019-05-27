module Api
  class ProductResource < JSONAPI::Resource
    attributes :name, :price, :category

    attribute :date_added, delegate: :created_at
    attribute :date_updated, delegate: :updated_at
  end
end
