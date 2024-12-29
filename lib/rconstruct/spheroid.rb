module Rconstruct
  class Spheroid
    attr_reader :x_range, :y_range, :z_range, :radius, :block_type, :hollow, :x, :y, :z

    def initialize(args)
      @block_type = args[:block_type]
      @hollow = args[:hollow]
      @radius = args[:radius]
      @x = args[:x]
      @x_range = args[:x_range]
      @y = args[:y]
      @y_range = args[:y_range]
      @z = args[:z]
      @z_range = args[:z_range]
    end

    def render
      y_range.each do |y_pos|
        x_range.each do |x_pos|
          z_range.each do |z_pos|
            distance = Math.sqrt((x - x_pos)**2 + (y - y_pos)**2 + (z - z_pos)**2)
            if (distance <= radius && distance > radius - 1 && hollow) || (distance <= radius && !hollow)
              client.execute("fill #{x_pos} #{y_pos} #{z_pos} #{x_pos} #{y_pos} #{z_pos} #{block_type}")
            end
          end
        end
      end

      client.end_session!
    end

    def hollow?
      !(hollow == false)
    end

    def client
      @client ||= Client.new
    end
  end
end
