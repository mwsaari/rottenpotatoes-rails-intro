module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def sort_title
    flash[:notice] = "Sort Header"
  end
  
  def sort_release
    flash[:notice] = "Sort Release"
  end
end
