# Notes for Assessment 109

### Local Variable Scope

* Local variables are not accessible to methods unless they are passed in as parameters

This produces an error: undefined local variable or method `local_variable`

```ruby
local_variable

def my_method
  puts local_variable
end

my_method
```