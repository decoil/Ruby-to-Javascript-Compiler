# frozen_string_literal: true

module RubyJS
  # Base class for all RubyJS errors.
  class Error < StandardError; end

  # An error raised by the Lexer, indicating a problem with tokenization.
  class LexerError < Error
    # @return [Source::Location] The location in the source code where the error occurred.
    attr_reader :location

    def initialize(message, location)
      super("#{message} at #{location.line}:#{location.column}")
      @location = location
    end
  end

  # An error raised by the Parser, indicating a syntactic problem.
  class ParserError < Error
    # @return [Source::Location] The location in the source code where the error occurred.
    attr_reader :location

    def initialize(message, location)
      super("#{message} at #{location.line}:#{location.column}")
      @location = location
    end
  end
end
