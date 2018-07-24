class Supports::BookSupport
  def book_init
    @book = Book.new
  end

  def publishers
    @publishers ||= Publisher.all.by_name
  end

  def categories
    @categories ||= Category.all.by_name
  end
end
