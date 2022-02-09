class Api::V1::TopicsController < ApplicationController
  
  # bugfix
  # Necessary until this is fixed:
  # google: rails 6 json "Error occurred while parsing request parameters"
  # https://github.com/rails/rails/issues/34244
  def process_action(*args)
    super
    rescue ActionDispatch::Http::Parameters::ParseError => exception
      render status: 400, json: { errors: [ exception.message ] }
  end
  # end of bugfix

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  before_action :set_topic, only: %i[ destroy ]
  
  def index
    topics = Topic.all.order(name: :asc)

    topics = topics.map do |topic| {
      name: topic.name,
      description: topic.description,
      show_on_dashboard: topic.show_on_dashboard,
      dashboard_name: topic.dashboard_name,
      dashboard_number_of_values: topic.dashboard_number_of_values
      }
    end

    render json: { topics: topics }.to_json, status: :ok
  end

  def create

    # @json = JSON.parse(request.body.read)
    @topic = Topic.new(topic_params)

    if @topic.save then
      render json: { name: @topic.name, created_at: @topic.created_at }, status: :ok
    else
      render json: { errors: @topic.errors }, status: :unprocessable_entity
    end
  end

  private

  	# Only allow a list of trusted parameters through.
    def topic_params
      params.permit(:api_key, :name, :description, :show_on_dashboard, :dashboard_name, :dashboard_number_of_values, :number_of_values_to_keep)
    end

    def set_topic
      api_key = request.headers[:HTTP_API_KEY] || params[:api_key]
      @topic = Topic.find_by!(api_key: api_key) rescue render_auth_error_response
    end  

    def render_invalid_sn_response
      render json: { error: 'Authorization error' }, status: :unprocessable_entity
    end

    def render_auth_error_response
      render json: { error: 'Authorization error' }, status: :unprocessable_entity
    end
end
