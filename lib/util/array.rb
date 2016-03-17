module ArrayMethod
  refine Object do
    def array?
      false
    end

    def tag?
      false
    end
  end

  refine Array do
    def array?
      true
    end

    def tag?
      self[0].class == Symbol
    end
  end
end
