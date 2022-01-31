class PagesController < ApplicationController
  def index
    @topics = Topic.where(show_on_dashboard: true)
  end
end
