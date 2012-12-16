class Fixnum
  def prime?
    sq = Math.sqrt(self).floor
    for y in (2..sq)
      return false if self % y == 0
    end
  end
end