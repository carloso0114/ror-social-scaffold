require 'rails_helper'

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

RSpec.describe 'Sign in test', type: :feature do
  it 'checks that a new account holer can sign back in successfully' do
    visit new_user_registration_path
    within('.new_user') do
      fill_in 'Name', with: 'carlos'
      fill_in 'Email', with: 'carlos@gmail.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
    end
    click_button 'Sign up'
    expect(User.count).to eq 1

    visit root_path
    within('.nav') do
      click_link 'Sign out'
    end

    visit new_user_session_path
    within('.new_user') do
      fill_in 'Email', with: 'carlos@gmail.com'
      fill_in 'Password', with: '123456'
    end
    click_button 'Log in'
    expect(current_path).to eq('/')
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

RSpec.describe 'Comments test', type: :feature do
  it 'create new comment' do
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

    visit root_path
    within('.new_comment') do
      fill_in 'comment_content', with: 'Please Work.'
    end
    click_button 'Comment'
    expect(Comment.count).to eq 1
  end
end

RSpec.describe 'Likes test', type: :feature do
  it 'create new like' do
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

    visit root_path
    within('.post-liking') do
      click_link 'like'
    end

    expect(Like.count).to eq 1
  end
end

# rubocop:disable Metrics/BlockLength

RSpec.describe 'Confirm Friendship request', type: :feature do
  it 'accept friendship to check inverse row in friendship table' do
    visit new_user_registration_path
    within('.new_user') do
      fill_in 'Name', with: 'carlos'
      fill_in 'Email', with: 'carlos@gmail.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
    end
    click_button 'Sign up'
    visit root_path
    within('.nav') do
      click_link 'Sign out'
    end
    visit new_user_registration_path
    within('.new_user') do
      fill_in 'Name', with: 'carlos2'
      fill_in 'Email', with: 'carlos2@gmail.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
    end
    click_button 'Sign up'
    visit users_path
    within('.users-list') do
      click_link 'Add Friend'
    end
    visit root_path
    within('.nav') do
      click_link 'Sign out'
    end
    visit new_user_session_path
    within('.new_user') do
      fill_in 'Email', with: 'carlos@gmail.com'
      fill_in 'Password', with: '123456'
    end
    click_button 'Log in'
    visit users_path
    within('.users-list') do
      click_link 'Accept Friendship'
    end
    user = User.find_by(email: 'carlos@gmail.com')
    friend = User.find_by(email: 'carlos2@gmail.com')
    friends1 = Friendship.where('user_id = ? and friend_id= ?', user.id, friend.id)
    expect(friends1[0].confirmed).to be(true)
  end
end
# rubocop:enable Metrics/BlockLength
