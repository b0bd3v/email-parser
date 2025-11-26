module EmailParser
  class Base
    attr_reader :mail

    def initialize(mail)
      @mail = mail
    end

    def parse
      raise NotImplementedError, "Subclasses must implement the parse method"
    end

    private

    def value(regex)
      mail.body.to_s.match(regex)&.[](1)&.strip
    end
  end
end
