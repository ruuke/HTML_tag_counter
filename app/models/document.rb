class Document < ApplicationRecord
  has_many :tags, dependent: :destroy
  belongs_to :user

  validates :url, presence: true
end
