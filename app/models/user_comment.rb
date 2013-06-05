class UserComment < ActiveRecord::Base
  belongs_to :user
  attr_accessible :author, :text, :author_id

  validates :text,			:presence => :true
  validates :author, 		:presence => :true
  validates :author_id,	:presence => :ture

  default_scope order('created_at DESC')
end
