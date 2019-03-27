require 'open-uri'

class Nokogiri::XML::Node
  def descendant_elements
    element_children.map { |kid| [kid, kid.descendant_elements] }.flatten
  end
end

class TagCountingService

  attr_writer :tag_index, :tags_flatten

  def initialize(document)
    @document = document
    @tags_two_dimentional_array = []
    @tags_flatten
    @tag_hash = Hash.new(0)
    @tag_index = []
  end

  def call
    open_url
    parse_page
    max_nested_tags_count
    create_tags
  end

  def open_url
    @doc = Nokogiri::HTML(open(@document.url))
  end

  def parse_page
    @doc.search(":not(html):not(body)").each do |n|
      @tags_two_dimentional_array << [ n.name, n.descendant_elements.size ]
    end
  end

  def max_nested_tags_count
    @tags_flatten = @tags_two_dimentional_array.flatten
    @tags_flatten.each_with_index { |value, index| @tag_hash[index] = value if value.is_a?(Integer) } #получаю хэш - ключ-индекс, значение-кол-во потомков
    @tag_index = @tag_hash.select{ |k, v| v == @tag_hash.values.max }.keys #нахожу индексы с максимальным кол-вом потомков
  end

  def create_tags
    tag = @tags_flatten
    count = @tags_flatten
    @tag_index.each { |index| @document.tags.build(title: tag[index-1], count: count[index])}
  end

end
