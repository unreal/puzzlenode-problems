## BlueHawaii

This library provides an interface for parsing a JSON file of Rental
Properties and outputs a report of prices given a range of dates on
which the user wishes to stay.

## Usage

First make sure you have the required libraries

```ruby
gem install bundler
bundle install
```

In your script (like in the provided example.rb):

```ruby
require './blue_hawaii'

input_file = File.new('./input.txt')
rentals_file = File.new('./vacation_rentals.json')
puts PuzzleNode::BlueHawaii.report_from_file(input_file,rentals_file)
```

------

Jay Strybis
[website](http://strybis.com)
[github](http://github.com/unreal)
[twitter](http://twitter.com/jaywastaken)
