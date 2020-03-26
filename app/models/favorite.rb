class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Array.new
  end

  def total_count
    @contents.size
  end

  def add_pet(id)
    if @contents.exclude? id.to_s
      @contents << id.to_s
    end
  end

  def remove_pet(id)
    @contents.delete(id.to_s)
  end

end
