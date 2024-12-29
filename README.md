# Rconstruct

Builds shapes in Minecraft using rcon.

## Installation

Currently used with a Minecraft docker image.

## Usage

With a compose:

```
dc exec rcon bin/console
```

Then draw things:

```
Rconstruct::Sphere.draw(x: -414, y: -30, z: 7, radius: 10, block_type: "stone") 
Rconstruct::Hemisphere.draw(x: -424, y: -45, z: 17, radius: 10, block_type: "stone") 
```

## Development

```
dc exec rcon rspec
```

## Contributing

```
dc exec rcon standardrb
```

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rconstruct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
