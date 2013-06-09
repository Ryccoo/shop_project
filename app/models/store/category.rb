class Store::Category < ActiveRecord::Base
  attr_accessible :belongs_to, :name

  has_and_belongs_to_many :products
end
