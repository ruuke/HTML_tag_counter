require 'open-uri'

class TagCountingService

  def initialize(document)
    @document = document
    @tags = []
  end

  def call
    doc = Nokogiri::HTML(open(@document.url))

    doc.search('*').each do |tag|
      @tags << tag.name
    end

    tag_counter
  end

  def tag_counter
    tags_frequency = @tags.inject( Hash .new(0)) { |result, tag|
                                    result.update({ tag => 1 }) { |key, old_value, new_value|
                                    old_value + new_value } }

    tags_frequency.each do |tag, value|
      @document.tags.create(title: tag, count: value)
    end
  end 

end
