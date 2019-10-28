class Qualification < ApplicationRecord
    belongs_to :user

    validates :user_id, presence: true
    validates :name, presence: true, length: { in: 3..45 }
    validates :awarded_date, presence: true, timeliness: { on_or_before: :today, type: :date }
    validates_date :expiry_date, after: :awarded_date, message: 'must be after the awarded date', unless: -> { expiry_date.blank? }

    has_one_attached :certificate
end
