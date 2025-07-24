# Lightweight Language Compiler

A minimal compiler written in Ruby that translates a simple functional language into JavaScript. This project demonstrates the core concepts of language compilation including lexical analysis, parsing, and code generation.

## Overview

This compiler implements a complete pipeline from source code to executable JavaScript:

1. **Tokenization** - Breaks source code into meaningful tokens
2. **Parsing** - Builds an Abstract Syntax Tree (AST) from tokens  
3. **Code Generation** - Transforms the AST into JavaScript code

## Language Syntax

The compiler supports a simple functional language with the following features:

### Function Definitions
```ruby
def function_name(arg1, arg2)
  # function body
end
```

### Supported Expressions
- **Integer literals**: `42`, `123`
- **Variable references**: `x`, `variable_name`
- **Function calls**: `add(1, 2)`, `multiply(x, y)`

### Example Program
```ruby
def f(x, y)
  add(x, y)
end
```

This compiles to:
```javascript
function add(x, y) { return x + y };
function f(x,y) { return add(x,y) };
console.log(f(1,2));
```

## Usage

1. Create a source file (e.g., `test.src`) with your program:
   ```ruby
   def f(x, y)
     add(x, y)
   end
   ```

2. Run the compiler:
   ```bash
   ruby compiler.rb
   ```

3. The compiler outputs JavaScript code that can be executed in any JavaScript environment.

## Architecture

### Tokenizer
- Converts raw source code into a stream of tokens
- Recognizes keywords (`def`, `end`), identifiers, integers, and punctuation
- Uses regular expressions for pattern matching

### Parser  
- Implements a recursive descent parser
- Builds an Abstract Syntax Tree (AST) from tokens
- Supports the grammar for function definitions and expressions

### Generator
- Traverses the AST and generates equivalent JavaScript code
- Handles code generation for all supported node types
- Produces clean, readable JavaScript output

### AST Node Types
- `DefNode` - Function definitions
- `CallNode` - Function calls  
- `VarRefNode` - Variable references
- `IntegerNode` - Integer literals

## Files

- `compiler.rb` - Main compiler implementation
- `test.src` - Example source file (you need to create this)

## Example Output

Given the input program:
```ruby
def f(x, y)
  add(x, y)  
end
```

The compiler generates:
```javascript
function add(x, y) { return x + y };
function f(x,y) { return add(x,y) };
console.log(f(1,2));
```

## Limitations

- Only supports single function definitions per file
- Limited expression types (integers, variables, function calls)
- No support for complex control flow (if/else, loops)
- No type checking or advanced error handling
- Assumes `add` function is available in runtime

## Future Enhancements

- Support for multiple function definitions
- Additional data types (strings, booleans)
- Control flow statements (if/else, while loops)
- Better error reporting with line numbers
- Type checking and validation
- More comprehensive standard library

## Requirements

- Ruby (any recent version)
- A JavaScript runtime for executing the generated code (Node.js, browser, etc.)

## Contributing

This is a educational project demonstrating compiler basics. Feel free to fork and extend with additional language features!

## License

MIT License - feel free to use this code for learning and experimentation.
