# float16cr

This shard provides a Float16 type (implementing the IEEE 754 binary16 type), which can be used like any other float.

Internally, the Float16 math operations convert the Float16 to a Float32, run the operation and convert it back.

You should avoid using math operations directly. Rather use this type to convert to other floating types:

```crystal
# io is some unknown IO
f16 = io.read_bytes(Float16, IO::ByteFormat::BigEndian)
f64 = f16.to_f64
```

## Installation

1. Add the dependency to your `shard.yml`:
   
   ```yaml
   dependencies:
     float16cr:
       gitlab: BlobCodes/float16cr
   ```

2. Run `shards install`

## Usage

```crystal
require "float16cr"

# Use Float16 like any other float
# Note that Float16 literals are not supported, you'll have to convert from other types.

f16 = 0.12.to_f16
puts f16 * 10 # => 1.2
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://gitlab.com/BlobCodes/float16cr/-/forks/new>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [BlobCodes](https://gitlab.com/BlobCodes) - creator and maintainer
