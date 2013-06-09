class Store::Product < ActiveRecord::Base
  attr_accessible :available_count, :name, :popis, :sold_count

  has_and_belongs_to_many :categories
end
