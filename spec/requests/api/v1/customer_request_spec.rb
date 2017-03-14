require "rails_helper"

describe "Customer API" do
  it "displays all customers" do
    create_list(:customer, 50)
    get "/api/v1/customers"

    expect(response).to be_success
  end

  it "displays a single customer" do
    customer = create(:customer)
    get "/api/v1/customers/#{customer.id}"

    expect(response).to be_success
  end

  it "finds a single record based on a passed in id" do
    customer = create(:customer)
    get "/api/v1/customers/find?id=#{customer.id}"
    query = JSON.parse(response.body)
    require 'pry'; binding.pry
    expect(response).to be_success
    expect(query["id"]).to eq(customer.id)
  end
end
