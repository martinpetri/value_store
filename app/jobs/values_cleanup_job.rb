class ValuesCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    
    # Topic.all.each do |topic|
    #   topic.values.where('created_at < ?', topic.values.last(topic.number_of_values_to_keep).first.created_at).destroy_all
    # end

  end
end
