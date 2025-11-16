# frozen_string_literal: true

require "ruby_js"

RSpec.describe "RubyJS Compiler End-to-End" do
  it "compiles a simple arithmetic expression to JavaScript" do
    source = "1 + 2 * 3"
    js_code = RubyJS::Driver.compile(source)
    expect(js_code).to eq("(1 + (2 * 3))")
  end

  it "compiles a program with multiple statements" do
    source = "5\n10 + 2"
    js_code = RubyJS::Driver.compile(source)
    expect(js_code).to eq("5;\n(10 + 2)")
  end

  it "compiles a simple method definition" do
    source = "def foo(); 42; end"
    js_code = RubyJS::Driver.compile(source)
    # For now, we don't have a JS representation of method defs,
    # so we expect the body's expression.
    expect(js_code).to eq("42")
  end
end
