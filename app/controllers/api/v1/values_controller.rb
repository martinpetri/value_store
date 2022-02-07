class Api::V1::ValuesController < ApplicationController
  
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

  before_action :set_topic

  def create

    values = @json_params["values"]
    values.each do |v|
      @topic.values.create(value: v)
    end

    dashboard_values = @topic.values.order(created_at: :asc).last(@topic.dashboard_number_of_values)
    dashboard_data =  { "topic": @topic.name,
                        "labels": dashboard_values.map { |v| v.created_at },
                        "values": dashboard_values.map { |v| v.value }
                      }.to_json

    ActionCable.server.broadcast "dashboard_channel", dashboard_data
    
    render json: { results: values.count.to_s + ' value(s) successfully saved.'}, status: :ok
  end

  def index

    number = @json_params[:number] || 1
    values = @topic.values.order(created_at: :asc).last(number)
    values = values.map do |value|
      { value: value.value, created_at: value.created_at.to_formatted_s(:number) }
    end

    render json: { values: values }.to_json, status: :ok
  end

  def show
  end

  private

    def set_topic
      @json_params = JSON.parse(request.body.read)
      @topic = Topic.find_by!(name: @json_params["topic"]) rescue render_not_found_response
    end

    def value_params
      params.permit(:topic, :values[], :number)
    end

    def render_unprocessable_entity_response(exception)
      render json: exception.record.errors, status: :unprocessable_entity
    end

    def render_not_found_response()
      render json: { error: 'Can not find topic' }, status: :not_found
    end

end