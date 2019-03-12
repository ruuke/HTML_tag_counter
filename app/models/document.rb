class Document < ApplicationRecord
  has_many :tags, dependent: :destroy
end
