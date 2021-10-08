class Book < ApplicationRecord
  belongs_to :user

  validates :title, presense: true
  validates :body, presense: true, length: {maximum: 200}
end
