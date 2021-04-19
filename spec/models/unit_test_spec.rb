require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:likes) }
  it { should have_many(:friendships) }
  it { should have_many(:inverse_friendships) }
end

RSpec.describe Post, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:comments) }
  it { should have_many(:likes) }
end

RSpec.describe Like, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:post) }
end

RSpec.describe Friendship, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:friend) }
end

RSpec.describe Comment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:post) }
end
