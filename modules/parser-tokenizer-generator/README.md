<p align="center">
    <h1 align="center">Compiler Toolkit</h1>
    <p align="center">(Almost) Everything you need to create your own programming language</p>
</p>

# Introduction

Every need a tokenizer or a parser, but you realized you use Godot? SO you needed to implement `flex` and `bison` manually? Fred no more!

# Tokenizer Generator

Creates a tokenizer, a program that takes a string and spits out tokens which contains chunks of text.

## Example Usage

```gdscript
class_name FMLTokenizer
extends RefCounted

const TokenMatcher = Tokenizer.TokenMatcher
const Token = Tokenizer.Token

enum TokenType {
  FUNC_NAME,
  COMMA,
  LEFT_BRACKET,
  RIGHT_BRACKET,
  STRING
}

var _tokenizer: Tokenizer
func _init():
  tokenizer = Tokenizer.new([
   # Possibly incomplete string
   TokenMatcher.new("(['\"])((?!\\1).)*?\\1", _create_string_token),
   # Function Names
   TokenMatcher.new('[A-Za-z_]+', func(t): return Token.new(TokenType.FUNC_NAME, t)),
   # Operators
   TokenMatcher.new('[(),]', _create_op_token),
   # Comment
   TokenMatcher.new('#[^\n]*', func(_t): pass ),
   # Space do nothing to ignore space
   TokenMatcher.new(" ", func(_t): pass )
  ])
```

# Parser Generator

The algorithm used for this particular parser generator is LALR(1). It's not as good as Earley's parsing, but i'll do the job

## Example Usage

```gdscript
class_name FMLParser
extends RefCounted

# Assume TokenType is an enum after tokenization
const f = TokenType.FUNC_NAME
const l_brac = TokenType.LEFT_BRACKET
const r_brac = TokenType.RIGHT_BRACKET
const s = TokenType.STRING
const comma = TokenType.COMMA

# Shorthand
const Grammar= Parser.Grammar

var parser: Parser
func _init():
  var grammars: Array[Grammar] = [
   Grammar.new(
     "S", ["F"],
     _create_start_node
   ),
   Grammar.new(
     "S", [Parser.EMPTY],
     func(_t): return _create_start_node(null)
   ),
   Grammar.new(
     "F", [f, l_brac, "A", r_brac],
     _create_func_node
   ),
   Grammar.new("A", [s, comma, "A"], func(t): return t[0] + t[2]),
   Grammar.new("A", ["F", comma, "A"], func(t): return t[0] + t[2]),
   Grammar.new("A", [s], func(t): return [_create_value_node(t)]),
   Grammar.new("A", ["F"], func(t): return [t[0]]),
   Grammar.new("A", [LALRParser.EMPTY], func(_t): pass ),
  ]
  parser = Parser.new(grammars, [f, l_brac, r_brac, s, comma])
```

If you want to have an empty grammar, use `Parser.EMPTY` for representing epsilon.
