require 'rails_helper'

RSpec.describe User, type: :model do
  it { have_one(:profile).dependent(:destroy) }
  it { have_many(:favorites).dependent(:destroy) }
  it { have_many(:favorited_properties).through(:favorites).source(:property) }
end
