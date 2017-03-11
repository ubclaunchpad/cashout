class UsdNet < ApplicationRecord
  belongs_to :user

  validates :net, presence: true, allow_nil: false

end
