class User < ActiveRecord::Base
  has_many :albums

  def all_images
    client = Instagram.client access_token: instagram_access_token
    total_post_count = client.user.counts.media
    api_call_count = (total_post_count / 20.0).ceil
    images = []
    next_max_id = nil
    api_call_count.times do
      response = client.user_recent_media({ max_id: next_max_id })
      images << response.map { |image| { image: image.images.standard_resolution, tags: image.tags } }
      next_max_id = response.pagination.next_max_id
    end
    images.flatten
  end
end
