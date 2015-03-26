class Enums
  @hash = {}
  @last_call = nil

  class << self
    def map(enumerable, to:)
      @hash[enumerable] = to
    end

    def method_missing(name, *args, &block)
      if @hash.key? name
        @last_call = name
        Enums.new
      else
        super
      end
    end
  end

  def method_missing(name, *args, &block)
    if @hash[@last_call].include? name
      name
    else
      super
    end
  end
end
