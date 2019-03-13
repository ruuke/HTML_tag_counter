class Document < ApplicationRecord
  has_many :tags, dependent: :destroy

  validates :url, presence: true
end
