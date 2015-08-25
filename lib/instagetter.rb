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
        i.url_low_res = image_response.images.low_resolution
        i.url_thumb = image_response.images.thumbnail
        i.url = image_response.images.standard_resolution
        i.post_time = Time.at(image_response.created_time.to_i)
      end

      image_record.caption = image_response.caption.blank? ? "" : image_response.caption.text
      image_record.likes = image_response.likes[:count]

      if image_record.save
        image_record.tags.each do |tag|
          tag_record
          if !image_response.tags.include? tag.name
            image_record.tags.delete(Tag.find_by(name: tag.name))
          end
        end

        image_response.tags.each do |tag|
          tag_record = Tag.find_or_create_by(name: tag)
          image_record.tags << tag_record unless image_record.tags.include?(tag_record)
        end
      end
    end
    @user
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

  def images_and_tags(n = -1)
    images_by_user(n).map do |image|
      {
        image: image.images.standard_resolution,
        tags: image.tags,
        caption: (image.caption.blank? ? "" : image.caption.text)
      }
    end
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
