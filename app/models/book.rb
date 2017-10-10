class Book < ApplicationRecord
  has_many :loans

  STATUS_BORROWED = 1
  STATUS_RETURNED = 0

  validates :title, presence: true
  validates :author, presence: true


  def to_borrow?
    loans.empty? || loans.last.status == STATUS_RETURNED
  end

  def to_return?
    unless loans.empty?
      loans.last.status == STATUS_BORROWED
    end
  end

end
