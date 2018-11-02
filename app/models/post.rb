# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, :dependent => :destroy
  validates :message, presence: true, length: { minimum: 1 }
end
