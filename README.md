Unscramble
========

We're gonna write a program that can unscramble a word. Like the individual "Jumble" puzzles in the newspaper.

    > ./unscramble cofer
    force
    > ./unscramble sasewe
    seesaw
    
Basic guidelines:

1. A scrambled or jumbled word has only one valid answer.
2. Use the contents of `/usr/share/dict/words` as a dictionary.

To start:

1. Create a directory based on the name of your implementation language (e.g. `languages/C`)
2. Create a simple `Rakefile` that has, at a minimum, a `build` task within your language's namespace (e.g. `C:build`).  You should check the environment and fail fast if dependencies aren't met.
3. Create your implementation and run `rake` from the project root.

### Example Rakefile

```ruby
namespace :C do
  task :check do
    `which cc`
    raise "Please ensure that you have a valid C compiler" unless $?.success?
  end

  task :build => :check do
    path = File.dirname(__FILE__)
    `cd #{path}; make unscramble`
  end
end
```

