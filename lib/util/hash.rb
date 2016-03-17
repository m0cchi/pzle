module HashMethod
  refine Object do
    def hash?
      false
    end
  end

  refine Hash do
    def hash?
      true
    end
  end
end
