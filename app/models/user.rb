class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

    validates :username, presence: true, uniqueness: true

    has_many :purchases
    has_many :snapshots
    has_many :usd_net
    has_one :portfolio
end
