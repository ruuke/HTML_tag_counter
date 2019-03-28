require 'open-uri'

class TagCountingService

  attr_writer :tag_index, :tags_flatten

  def initialize(document)
    @document = document
    @tags_2d_array = []
  end

  def call
    open_url
    parse_page
    max_nested_tag
    create_tags
  end

  private

  def open_url
    @doc = Nokogiri::HTML(open(@document.url))
  end

  def parse_page
    @doc.search(":not(html):not(body)").each do |tag|
      @tags_2d_array << [ tag.name, get_child_count(tag) ]
    end
  end

  def get_child_count(elem)
    children = elem.element_children
    return 0 unless children && children.count > 0
    child_count = children.count
    children.each do |child|
      child_count += get_child_count(child)
    end
    child_count
  end

  def max_nested_tag
    @tag = @tags_2d_array.max_by(&:last) #@tags_2d_array.each_with_object( {} ) { |(key, value), out| ( out[value] ||= [] ) << key }
  end

  def create_tags
    @document.tags.build(title: @tag[0], count: @tag[1]) #title: @tags[@tags.keys.max], count: @tags.keys.max
  end

end
