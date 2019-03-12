require 'open-uri'

class TagCountingService

  def initialize(document)
    @document = document
    @tags = Hash.new(0)
  end

  def call
    open_url
    parse_page
    create_tags
  end

  def open_url
    @doc = Nokogiri::HTML(open(@document.url))
  end

  def parse_page
    @doc.search('*').each do |tag|
      @tags[tag.name] += 1
    end
  end

  def create_tags
    @tags.each { |tag, count| @document.tags.create(title: tag, count: count)}
  end

end
