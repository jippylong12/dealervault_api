# frozen_string_literal: true

RSpec.describe DealervaultApi do
  before(:all) do
    @client = DealervaultApi::Client.new('USER_EMAIL', 'SUBSCRIPTION_KEY')
  end

  it "has a version number" do
    expect(DealervaultApi::VERSION).not_to be nil
  end

  it "can get data_set" do
    data = @client.delivery.data_set('REQUEST_ID', 500)
    puts data['records'][..10]
  end

  it "can get create delivery" do
    data = @client.delivery.create('PROGRAM_ID_DVV12345', 'ROOFTOP_ID_DVD12345', 'FILE_TYPE', 'TYPE')
    puts data
  end

  it "can get feeds" do
    data = @client.delivery.feeds('REQUEST_ID', DateTime.new(2021, 8,1))
    puts data
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
