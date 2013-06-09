class Translation < ActiveRecord::Base
  attr_accessible :base, :en, :location, :sk



  def self.get(location,lang)
    result = Translation.find_all_by_location([location,"all"])
    result = *result
    result ||= {}
    translations = Hash.new
    result.each do |part|
      translations[part.base.downcase]=part[lang]
    end
    translations
  end

  def self.make(word,records,location="all")
    # puts "--------------------------"
    # puts records
    # puts "--------------------------"
    unless records.has_key?(word.downcase)
      new_word=Translation.new
      new_word.base = word
      new_word.location= location
      new_word.save
      new_word.base
    else
      unless records[word.downcase]
        word       
      else
        records[word.downcase]
      end
    end
  end

end
