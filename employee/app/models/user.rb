class User < ActiveRecord::Base
validates :name, :email, :age, :salary, :department, presence: true
end
