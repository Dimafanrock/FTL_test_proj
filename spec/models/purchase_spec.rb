require 'rails_helper'

RSpec.describe Purchase, type: :model do

  describe "Associations" do
    it { should belong_to(:user) }   
  end

  it 'validates purchase category_name' do
    should validate_presence_of :category_name
  end
  it 'validates purchase price' do
    should validate_presence_of :price
  end
  it 'validates purchase buy_at' do
    should validate_presence_of :buy_at
  end
  
end
