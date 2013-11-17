class ItemAvailability
  attr_accessor :max_adults, :item, :quantity

  def initialize args
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def ==(other_object)
    item == other_object.item &&
    max_adults == other_object.max_adults &&
    quantity == other_object.quantity
  end
end