module Api
  class ProductResource < JSONAPI::Resource
    attributes :name, :price, :category

    attribute :date_added, delegate: :created_at
    attribute :date_updated, delegate: :updated_at

    def self.updatable_fields(context)
      super - [:name]
    end
  end
end
