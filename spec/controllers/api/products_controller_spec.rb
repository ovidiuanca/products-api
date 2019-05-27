require 'rails_helper'

RSpec.describe Api::ProductsController do
  describe 'GET #index' do
    let!(:products) { FactoryBot.create_list(:product, 5) }

    it 'should return all products' do
      get :index

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(json_response['data'].length).to eq(5)
    end

    it 'should return the products filtered by name' do
      get :index, params: { filter: { name: products.first.name } }

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(json_response['data'].length).to eq(1)
      expect(json_response['data'][0]['attributes']['name']).to eq(products.first.name)
    end
  end

  describe 'GET #show' do
    let!(:product) { FactoryBot.create(:product) }

    before do
      get :show, params: { id: product.id }
    end

    it 'should return the proper product' do
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(json_response['data']['id'].to_i).to eq(product.id)
    end
  end

  describe 'POST #create' do
    context 'when params are valid' do
      let(:params) do
        {
          "data": {
            "type": "products",
            "attributes": {
              "name": "Thinking Fast and Slow",
              "price": 20,
              "category": "Books"
            }
          }
        }
      end

      before do
        request.env['CONTENT_TYPE'] = 'application/vnd.api+json'
        post :create, params: params
      end

      it 'should return the previously created product' do
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(201)
        expect(json_response['data']['attributes']['name']).to eq('Thinking Fast and Slow')
        expect(json_response['data']['attributes']['price']).to eq(20)
        expect(json_response['data']['attributes']['category']).to eq('Books')
      end
    end

    context 'when params are not valid' do
      let(:params) do
        {
          "data": {
            "attributes": {
              "name": "Thinking Fast and Slow",
              "price": 20,
              "category": "Books"
            }
          }
        }
      end

      before do
        request.env['CONTENT_TYPE'] = 'application/vnd.api+json'
        post :create, params: params
      end

      it 'should return bad request' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when product attributes are missing' do
      let(:params) do
        {
          "data": {
            "type": "products",
            "attributes": {
              "name": "Thinking Fast and Slow",
            }
          }
        }
      end

      before do
        request.env['CONTENT_TYPE'] = 'application/vnd.api+json'

        post :create, params: params
      end

      it 'should return unprocessable entity' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT #update' do
    let(:product) { FactoryBot.create(:product,
                                      name: 'Thinking Fast and Slow',
                                      price: 100,
                                      category: 'Books') }
    context 'when update params are valid' do
      let(:params) do
        {
          "id": product.id,
          "data": {
            "type": "products",
            "id": product.id,
            "attributes": {
              "price": 15,
              "category": "Electronics"
            }
          }
        }
      end

      before do
        request.env['CONTENT_TYPE'] = 'application/vnd.api+json'
        put :update, params: params
      end

      it 'should return product with changed property' do
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response['data']['attributes']['price']).to eq(15)
        expect(json_response['data']['attributes']['category']).to eq('Electronics')
      end
    end

    context 'when update params are not valid' do
      let(:params) do
        {
          "id": product.id,
          "data": {
            "type": "products",
            "id": product.id,
            "attributes": {
              "name": "Clean Code"
            }
          }
        }
      end

      before do
        request.env['CONTENT_TYPE'] = 'application/vnd.api+json'
        put :update, params: params
      end

      it 'should return bad request' do
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:product) { FactoryBot.create(:product) }

    before do
      delete :destroy, params: { id: product.id }
    end

    it 'should delete the specified product' do
      expect(response).to have_http_status(204)
      expect(Product.count).to eq(0)
    end
  end
end
