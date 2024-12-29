module Rconstruct
  class Cylinder
    def self.draw(x:, y:, z:, radius:, height:, block_type:, hollow: true)
      args = {
        block_type: block_type,
        hollow: hollow,
        radius: radius,
        height: height,
        x: x,
        y: y,
        z: z
      }

      new(args).render
    end

    attr_reader :radius, :block_type, :hollow, :height, :x, :y, :z

    def initialize(args)
      @block_type = args[:block_type]
      @hollow = args[:hollow]
      @radius = args[:radius]
      @height = args[:height]
      @x = args[:x]
      @y = args[:y]
      @z = args[:z]
    end

    def render
      (0...height).each do |y_pos|
        (-radius..radius).each do |x_pos|
          (-radius..radius).each do |z_pos|
            if (x_pos**2 + z_pos**2 <= radius**2 && !hollow) ||
                ((x_pos**2 + z_pos**2 <= radius**2) && (x_pos**2 + z_pos**2 > (radius - 1)**2) && hollow)

              world_x = x + x_pos
              world_y = y + y_pos
              world_z = z + z_pos

              client.execute("fill #{world_x} #{world_y} #{world_z} #{world_x} #{world_y} #{world_z} #{block_type}")
            end
          end
        end
      end
    end

    def hollow?
      !(hollow == false)
    end

    def client
      @client ||= Client.new
    end
  end
end
