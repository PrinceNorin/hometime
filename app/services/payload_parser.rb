module PayloadParser
  class NoParserError < RuntimeError; end

  # Register future parsers here. This can be extracted out into a separated
  # library and makes it configurable during the initialization phase.
  #
  # == Examples:
  #
  #   # config/initializers/payload_parser.rb
  #   PayloadParser.configure do |config|
  #     config.parser_classes = [
  #       ParserClass1,
  #       ParserClass2
  #     ]
  #   end
  PARSER_CLASSES = [
    PayloadParser::AirBnbParser,
    PayloadParser::BookingParser
  ]

  def self.discover(params)
    klass = PARSER_CLASSES.find { |klass| klass.match?(params) }
    klass.new(params) if klass
  end

  def self.discover!(params)
    if parser = discover(params)
      parser
    else
      raise NoParserError
    end
  end
end
