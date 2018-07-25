class Supports::BookSupport
  def publishers
    @publishers ||= Publisher.all.by_name
  end

  def categories
    @categories ||= Category.all.by_name
  end
end
