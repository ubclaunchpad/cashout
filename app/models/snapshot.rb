class Snapshot < ApplicationRecord
  belongs_to :user

  validates :USD, presence: true, allow_nil: false
  validates :CAD, presence: true, allow_nil: false
  validates :EUR, presence: true, allow_nil: false
  validates :JYP, presence: true, allow_nil: false
  validates :GBP, presence: true, allow_nil: false
  validates :CHF, presence: true, allow_nil: false
  validates :AUD, presence: true, allow_nil: false
  validates :ZAR, presence: true, allow_nil: false

end
