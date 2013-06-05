class Group < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :rights

  def self.get_rights(group_name)
  	group = Group.find_by_name(group_name)
  	group_rights = []
  	group.rights.each do |right| 
  		name = right.name
  		sha_name = Digest::SHA1.hexdigest(name)
  		group_rights.append(sha_name)
  	end
  	return group_rights
  end
end
