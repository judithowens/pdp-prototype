class RoleGroup < ApplicationRecord
    has_many :roles

    validates :name, presence: true
end
