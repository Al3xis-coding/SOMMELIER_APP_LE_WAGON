class Wine < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  validates :color, presence: true, inclusion: { in: %w[red white rosé yellow] }
end
