# PuzzleNode

## #8 Best Scrabble Opening

This library determines the best opening move in Scrabble based on the
JSON-provided board, dictionary and tiles.

## Usage

First make sure you have the required libraries

```ruby
gem install bundler
bundle install
```

In your script (like in the provided example.rb):

```ruby
require './scrabble'

input_file = File.new('./INPUT.json')
puts PuzzleNode::Scrabble.solve(input_file)
```

## Tests

```
rspec spec
```

------

Jay Strybis
[website](http://strybis.com)
[github](http://github.com/unreal)
[twitter](http://twitter.com/jaywastaken)
