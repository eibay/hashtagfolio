class Instagetter
  attr_reader :client

  def initialize(user)
    @client = Instagram.client(access_token: user.instagram_access_token)
    @user = user
  end

  def cache_all
    images_by_user.each do |image_response|
      image_record = @user.images.find_or_initialize_by(instagram_id: image_response.id) do |i|
        i.link = image_response.link
        i.url_low_res = image_response.images.low_resolution.url
        i.url_thumb = image_response.images.thumbnail.url
        i.url = image_response.images.standard_resolution.url
        i.post_time = Time.at(image_response.created_time.to_i)
      end

      image_record.caption = image_response.caption.blank? ? "" : image_response.caption.text
      image_record.likes = image_response.likes[:count]

      if image_record.save
        image_record.tags.each do |tag|
          image_record.tags.delete(tag) unless image_response.tags.include? tag.name
        end

        image_response.tags.each do |tag|
          tag_record = Tag.find_or_create_by(name: tag)
          image_record.tags << tag_record unless image_record.tags.exists?(name: tag)
        end
      end
    end
    @user
  end

  def images_by_user(n = -1)
    images = []
    api_call_count = calculate_api_calls(n)
    next_max_id = nil
    api_call_count.times do
      response = @client.user_recent_media({ max_id: next_max_id })
      images += response
      next_max_id = response.pagination.next_max_id
    end
    images
  end

  private

    def calculate_api_calls(n = -1, max = 20)
      total_image_count = @client.user.counts.media
      if n == -1 || n >= total_image_count
        return (total_image_count / max.to_f).ceil
      end
      (n / max.to_f).ceil
    end

end
