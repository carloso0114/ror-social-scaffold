module LikesHelper
  def num_of_likes(post)
    Like.where(post_id: post).length
  end
end
