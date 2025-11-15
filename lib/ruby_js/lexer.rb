# frozen_string_literal: true

require "strscan"
require_relative 'token'
require_relative 'source/location'

module RubyJS
  class Lexer
    # A mapping of keywords to their token types.
    KEYWORDS = {
      "def" => :tDEF,
      "end" => :tEND,
      "if" => :tIF,
    }.freeze

    def initialize(source)
      @scanner = StringScanner.new(source)
      @line = 1
      @column = 1
      @offset = 0
    end

    def tokenize
      tokens = []
      until @scanner.eos?
        tokens << next_token
      end
      tokens.compact
    end

    private

    def next_token
      return if scan_ignorable_content

      location = Source::Location.new(@line, @column, @offset)

      token = if (value = @scanner.scan(/"[^"]*"/))
                Token.new(:tSTRING, value, location)
              elsif (value = @scanner.scan(/\d+/))
                Token.new(:tINTEGER, value, location)
              elsif (value = @scanner.scan(/[a-zA-Z_][a-zA-Z0-9_]*/))
                type = KEYWORDS.fetch(value, :tIDENTIFIER)
                Token.new(type, value, location)
              elsif (value = @scanner.scan(%r{[\(\)=+\-\*/]}))
                # Simple single-character operators
                type = case value
                       when "(" then :tLPAREN
                       when ")" then :tRPAREN
                       when "=" then :tEQ
                       when "+" then :tPLUS
                       when "-" then :tMINUS
                       when "*" then :tSTAR
                       when "/" then :tSLASH
                       end
                Token.new(type, value, location)
              else
                # For now, raise an error on unknown characters
                raise "Unknown character: #{@scanner.peek(1)}"
              end

      update_location(token.value)
      token
    end

    def scan_ignorable_content
      anything_scanned = false
      loop do
        scanned = @scanner.scan(/\s+/) || @scanner.scan(/#.*/)
        break unless scanned
        update_location(scanned)
        anything_scanned = true
      end
      anything_scanned
    end

    def update_location(scanned)
      return unless scanned

      newlines = scanned.count("\n")
      if newlines > 0
        @line += newlines
        @column = scanned.length - scanned.rindex("\n")
      else
        @column += scanned.length
      end
      @offset += scanned.bytesize
    end
  end
end
