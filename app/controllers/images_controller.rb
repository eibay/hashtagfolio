class ImagesController < ApplicationController
  before_action :check_logged_in, only: [:index, :search, :search_results]

  def index
    @images = current_user.images.order(post_time: :desc).limit(24)

    respond_to do |format|
      format.html
      format.json { render json: @images.to_json(methods: :tag_list) }
    end
  end

  def search
    @query = params[:query]

    respond_to do |format|
      format.html
    end
  end

  def search_results
    tag_names = params[:query].to_s.scan(/\w+/)
    tag_records = []
    tag_names.each do |tag_name|
      tag_records << Tag.find_or_create_by(name: tag_name.downcase)
    end

    @images = current_user.images.select { |image| (tag_records - image.tags).empty? }

    respond_to do |format|
      format.json { render json: @images.to_json(methods: :tag_list) }
    end
  end
end
