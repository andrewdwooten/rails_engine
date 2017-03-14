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

  it "finds a single record based on a when given an id" do
    customer = create(:customer)
    get "/api/v1/customers/find?id=#{customer.id}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["id"]).to eq(customer.id)
  end

  it "finds a single record based on a when given a first_name" do
    customer = create(:customer)
    get "/api/v1/customers/find?first_name=#{customer.first_name}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["first_name"]).to eq(customer.first_name)
  end

  it "finds a single record based on a when given a last_name" do
    customer = create(:customer)
    get "/api/v1/customers/find?last_name=#{customer.last_name}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["last_name"]).to eq(customer.last_name)
  end

  it "finds a single record based on a when given a created_at" do
    customer = create(:customer,
                      created_at: "2012-03-27 14:54:09 UTC")
    get "/api/v1/customers/find?created_at=#{customer.created_at}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["created_at"]).to eq(customer.created_at.as_json)
  end

  it "finds a single record based on a when given a updated_at" do
    customer = create(:customer,
                      updated_at: "2012-03-27 14:54:09 UTC")
    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query["updated_at"]).to eq(customer.updated_at.as_json)
  end

  it "finds all matches with a given first name" do
    customer_one = create(:customer, first_name: "Harambe")
    customer_two = create(:customer, first_name: "Harambe")
    get "/api/v1/customers/find_all?first_name=Harambe"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query[0]["first_name"]).to eq(customer_one.first_name)
    expect(query[1]["first_name"]).to eq(customer_two.first_name)
  end

  it "finds all matches with a given last name" do
    customer_one = create(:customer, last_name: "Hatter")
    customer_two = create(:customer, last_name: "Hatter")
    get "/api/v1/customers/find_all?last_name=Hatter"
    query = JSON.parse(response.body)
    #require 'pry'; binding.pry
    expect(response).to be_success
    expect(query[0]["last_name"]).to eq(customer_one.last_name)
    expect(query[1]["last_name"]).to eq(customer_two.last_name)
  end

  it "finds all matches when given created_at" do
    customer = create(:customer,
                      created_at: "2012-03-27 14:54:09 UTC")

    other_customer = create(:customer,
                            created_at: "2012-03-27 14:54:09 UTC")
    get "/api/v1/customers/find_all?created_at=#{customer.created_at}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query[0]["created_at"]).to eq(customer.created_at.as_json)
    expect(query[1]["created_at"]).to eq(other_customer.created_at.as_json)
  end

  it "finds all matches when given name and created_at" do
    customer = create(:customer,
                      updated_at: "2012-03-27 14:54:09 UTC")

    other_customer = create(:customer,
                            updated_at: "2012-03-27 14:54:09 UTC")
    get "/api/v1/customers/find_all?updated_at=#{customer.updated_at}"
    query = JSON.parse(response.body)

    expect(response).to be_success
    expect(query[0]["updated_at"]).to eq(customer.updated_at.as_json)
    expect(query[1]["updated_at"]).to eq(other_customer.updated_at.as_json) # here too
  end

  it "returns a random resource for customer" do
    customer_one = create(:customer, first_name: "Hiedi")
    customer_two = create(:customer, first_name: "Hildi")
    customer_three = create(:customer, first_name: "Harding")


    get "/api/v1/customers/random"
    query = JSON.parse(response.body)

    expect(response).to be_success
    id = query[0]["id"]
    customer = Customer.find(id).id

    expect(query[0]["id"]).to eq(customer)
  end
end
