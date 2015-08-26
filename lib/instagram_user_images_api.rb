class InstagramUserImagesAPI
  def self.fetch(client, count = -1)
    images = []
    api_call_count = calculate_api_calls(client.user.counts.media, count)
    next_max_id = nil

    api_call_count.times do
      response = client.user_recent_media({ max_id: next_max_id })
      images += response
      next_max_id = response.pagination.next_max_id
    end

    return images if count == -1
    images[0..(count - 1)]
  end

  private

    def self.calculate_api_calls(user_total, requested = -1, max_per_call = 20)
      if requested == -1 || n >= user_total
        return (user_total / max_per_call.to_f).ceil
      end
      (requested / max_per_call.to_f).ceil
    end

end
