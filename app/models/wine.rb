class Wine < ApplicationRecord
  belongs_to :user
  belongs_to :chat
  validates :color, presence: true, inclusion: { in: :%[red white rosé yellow] }
end
