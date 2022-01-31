class Topic < ApplicationRecord
    has_many :values, dependent: :destroy
    
    validates :name, uniqueness: { message: "Topic name already exists" }
    before_validation :set_api_key
    
    attribute :dashboard_number_of_values, :integer, default: 10
    attribute :show_on_dashboard, :boolean, default: false

    def set_api_key
        if not self.api_key.present?
            self.api_key = SecureRandom.base58(64)
        end
    end

end