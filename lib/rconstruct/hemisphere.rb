module Rconstruct
  class Hemisphere < Spheroid
    def self.draw(x:, y:, z:, radius:, block_type:, hollow: true)
      x_range = (x - radius..x + radius)
      y_range = (y..y + radius)
      z_range = (z - radius..z + radius)

      args = {
        block_type: block_type,
        hollow: hollow,
        radius: radius,
        x: x,
        x_range: x_range,
        y: y,
        y_range: y_range,
        z: z,
        z_range: z_range
      }

      new(args).render
    end
  end
end
