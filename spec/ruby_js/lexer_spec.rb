# frozen_string_literal: true

require "ruby_js"

RSpec.describe RubyJS::Lexer do
  describe "#tokenize" do
    it "tokenizes a simple function definition" do
      source = "def foo() end"
      lexer = RubyJS::Lexer.new(source)
      tokens = lexer.tokenize

      expected_tokens = [
        RubyJS::Token.new(:tDEF, "def", RubyJS::Source::Location.new(1, 1, 0)),
        RubyJS::Token.new(:tIDENTIFIER, "foo", RubyJS::Source::Location.new(1, 5, 4)),
        RubyJS::Token.new(:tLPAREN, "(", RubyJS::Source::Location.new(1, 8, 7)),
        RubyJS::Token.new(:tRPAREN, ")", RubyJS::Source::Location.new(1, 9, 8)),
        RubyJS::Token.new(:tEND, "end", RubyJS::Source::Location.new(1, 11, 10)),
      ]

      expect(tokens.map(&:type)).to eq(expected_tokens.map(&:type))
      expect(tokens.map(&:value)).to eq(expected_tokens.map(&:value))
      expect(tokens.map(&:location)).to eq(expected_tokens.map(&:location))
    end

    it "handles identifiers and integers" do
      source = "my_var = 123"
      lexer = RubyJS::Lexer.new(source)
      tokens = lexer.tokenize

      expected_tokens = [
        RubyJS::Token.new(:tIDENTIFIER, "my_var", RubyJS::Source::Location.new(1, 1, 0)),
        RubyJS::Token.new(:tEQ, "=", RubyJS::Source::Location.new(1, 8, 7)),
        RubyJS::Token.new(:tINTEGER, "123", RubyJS::Source::Location.new(1, 10, 9)),
      ]

      expect(tokens.map(&:type)).to eq(expected_tokens.map(&:type))
    end

    it "tokenizes arithmetic operators" do
      source = "1 + 2 - 3 * 4 / 5"
      lexer = RubyJS::Lexer.new(source)
      types = lexer.tokenize.map(&:type)

      expect(types).to eq([:tINTEGER, :tPLUS, :tINTEGER, :tMINUS, :tINTEGER, :tSTAR, :tINTEGER, :tSLASH, :tINTEGER])
    end

    it "tokenizes double-quoted strings" do
      source = 'x = "hello world"'
      lexer = RubyJS::Lexer.new(source)
      tokens = lexer.tokenize

      expect(tokens[2].type).to eq(:tSTRING)
      expect(tokens[2].value).to eq('"hello world"')
    end

    it "ignores single-line comments" do
      source = <<~RUBY
        x = 1 # this is a comment
        y = 2
      RUBY
      lexer = RubyJS::Lexer.new(source)
      types = lexer.tokenize.map(&:type)

      expect(types).to eq([:tIDENTIFIER, :tEQ, :tINTEGER, :tIDENTIFIER, :tEQ, :tINTEGER])
    end

    it "correctly tracks line and column numbers with comments and strings" do
      source = <<~RUBY
        # comment
        x = "hello"
        y = 2
      RUBY
      lexer = RubyJS::Lexer.new(source)
      tokens = lexer.tokenize

      x_token = tokens[0]
      expect(x_token.location.line).to eq(2)
      expect(x_token.location.column).to eq(1)

      hello_token = tokens[2]
      expect(hello_token.location.line).to eq(2)
      expect(hello_token.location.column).to eq(5)

      y_token = tokens[3]
      expect(y_token.location.line).to eq(3)
      expect(y_token.location.column).to eq(1)
    end
  end
end
