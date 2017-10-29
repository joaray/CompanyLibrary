class Book < ApplicationRecord
  has_many :loans

  STATUS_BORROWED = 1
  STATUS_RETURNED = 0

  validates :title, presence: true
  validates :author, presence: true


  def active?
    book_status == true
  end

  def to_borrow?
    loans.empty? || loans.last.status == STATUS_RETURNED
  end

  def to_return?(current_user)
    unless loans.empty?
      loans.last.status == STATUS_BORROWED && loans.last.user == current_user
    end
  end

end
