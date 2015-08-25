class Instagetter
  attr_reader :client

  def initialize(user)
    @client = Instagram.client(access_token: user.instagram_access_token)
  end

  def images_tagged(tag, n = -1)
    images_and_tags(n).select { |image| image[:tags].include? tag }
  end

  def user_details
    user = @client.user
    {
      username: user.username,
      full_name: user.full_name,
      profile_picture: user.profile_picture
    }
  end

  private

    def images_and_tags(n = -1)
      posts_by_user(n).map do |image|
        {
          image: image.images.standard_resolution,
          tags: image.tags,
          caption: (image.caption.blank? ? "" : image.caption.text)
        }
      end
    end

    def posts_by_user(n = -1)
      posts = []
      api_call_count = calculate_api_calls(n)
      next_max_id = nil
      api_call_count.times do
        response = @client.user_recent_media({ max_id: next_max_id })
        posts += response
        next_max_id = response.pagination.next_max_id
      end
      posts
    end

    def calculate_api_calls(n = -1, max = 20)
      total_post_count = @client.user.counts.media
      if n == -1 || n >= total_post_count
        return (total_post_count / max.to_f).ceil
      end
      (n / max.to_f).ceil
    end
end
