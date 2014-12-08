class User < ActiveRecord::Base
	has_many :microposts
	validates :name,
						presence: true
	validates :email,
						presence: true
end
