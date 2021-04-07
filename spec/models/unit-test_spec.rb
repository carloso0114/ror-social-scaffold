require 'rails_helper'

# RSpec.describe User, type: :model do
#   it 'has none to begin with' do
#     expect(User.count).to eq 0
#   end

#   it 'has one after adding one' do
#     User.create(name: C , email: C@gmail.com, password: 123456, password_confirmation: 123456)
#     expect(User.count).to eq 1
#   end

#   it 'has none after one was created in a previous example' do
#     expect(User.count).to eq 0
#   end
# end

# RSpec.describe Attendance, type: :model do
#   it { should belong_to(:user) }
#   it { should belong_to(:event) }
# end

# RSpec.describe Event, type: :model do
#   it { should have_many(:attendances) }
#   it { should have_many(:attendees) }
#   it { should belong_to(:creator) }
# end

# RSpec.describe User, type: :model do
#   it { should have_many(:created_events) }
#   it { should have_many(:attendances) }
#   it { should have_many(:attended_events) }
# end

# RSpec.describe 'Sign in test', type: :feature do
#   before :each do
#     User.create(username: 'carlos')
#   end

#   it 'signs me in' do
#     visit login_path
#     within('.login-form') do
#       fill_in 'Username', with: 'carlos'
#     end
#     click_button 'Log in'
#     expect(current_path).to eq('/users/1')
#   end
# end

RSpec.describe 'Sign up test', type: :feature do
  it 'create new account' do
    visit new_user_registration_path
    within('.new_user') do
      fill_in 'Name', with: 'carlos'
      fill_in 'Email', with: 'carlos@gmail.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
    end
    click_button 'Sign up'
    expect(current_path).to eq('/')
  end

  it 'has one user after adding one' do
    visit new_user_registration_path
    within('.new_user') do
      fill_in 'Name', with: 'carlos'
      fill_in 'Email', with: 'carlos@gmail.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
    end
    click_button 'Sign up'
    expect(current_path).to eq('/')
    expect(User.count).to eq 1
  end
end

RSpec.describe 'Post test', type: :feature do
  it 'create new post' do
    visit new_user_registration_path
      within('.new_user') do
        fill_in 'Name', with: 'carlos'
        fill_in 'Email', with: 'carlos@gmail.com'
        fill_in 'Password', with: '123456'
        fill_in 'Password confirmation', with: '123456'
      end
      click_button 'Sign up'
      expect(current_path).to eq('/')
 
    visit root_path
    within('.new_post') do
      fill_in 'post_content', with: 'Work Please.'
    end
    click_button 'Save'
    expect(Post.count).to eq 1
  end
end


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


