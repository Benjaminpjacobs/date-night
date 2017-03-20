class Node
  attr_accessor :data, :left, :right

  def initialize(data, left=nil, right=nil)
    @data = data
    @left = left
    @right = right
  end
  
  # def tail
  #   if self.next.nil?
  #     return self
  #   else
  #     self.next.tail
  #   end
  # end
end