class Supports::CopySupport
  def books
    @books ||= Book.all.book_info
  end
end
