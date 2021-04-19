class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def confirm_friend
    update_attribute(:confirmed, true)
    Friendship.create(friend_id: user_id,
                      user_id: friend_id,
                      confirmed: true)
  end
<<<<<<< HEAD
end
=======
end
>>>>>>> dfd40787ec89632655941e67fead2ce3a44ed8a7
