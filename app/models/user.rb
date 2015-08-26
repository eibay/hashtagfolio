class User < ActiveRecord::Base
  has_many :albums, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :instagram_id, uniqueness: true
  validates :instagram_access_token, :instagram_id, presence: true

  def display_name
    name.blank? ? instagram_username : name
  end

  def sync_images(instagram_response)
    local_ids = images.pluck(:instagram_id)
    remote_ids = instagram_response.map { |i| i.id }
    local_ids.each do |local_id|
      Image.find_by(instagram_id: local_id).destroy unless remote_ids.include?(local_id)
    end
    
    instagram_response.each do |image_response|
      image_record = images.find_or_initialize_by(instagram_id: image_response.id) do |i|
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
  end
end
