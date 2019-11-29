class Role < ApplicationRecord
    has_many :users
    belongs_to :role_group

    validates :name, presence: true
end
