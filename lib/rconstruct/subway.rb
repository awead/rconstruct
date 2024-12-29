module Rconstruct
  class Subway
    AscendingCoordinate = Struct.new(:x, :y, :z)

    ##
    # Use the coordinates for the mid-point of the tunnel.
    #
    def self.draw(x:, y:, z:, length:, direction: :north, attitude: :level, roof: "stone")
      origin = if [:north, :south].include?(direction)
        Coordinate.new((x - 2), y, z)
      else
        Coordinate.new(x, y, (z - 2))
      end

      new(
        origin: origin,
        length: length,
        direction: direction,
        attitude: attitude,
        roof: roof
      ).render
    end

    attr_reader :length, :direction, :attitude, :roof

    def initialize(length:, direction:, attitude:, roof:, origin: Coordinate.new)
      @origin = origin
      @length = length
      @direction = direction
      @attitude = attitude
      @roof = roof
      render
    end

    def render
      (1..length).map do |inc|
        origin = build_origin(inc)
        case direction
        when :north
          ZAxis.new(origin, inc, client, (origin.z - inc), roof).render
        when :south
          ZAxis.new(origin, inc, client, (origin.z + inc), roof).render
        when :east
          XAxis.new(origin, inc, client, (origin.x + inc), roof).render
        when :west
          XAxis.new(origin, inc, client, (origin.x - inc), roof).render
        else
          raise ArgumentError.new("Bad direction")
        end
      end

      client.end_session!
    end

    private

    def build_origin(inc)
      case attitude
      when :up
        AscendingCoordinate.new(@origin.x, @origin.y + inc, @origin.z)
      when :down
        AscendingCoordinate.new(@origin.x, @origin.y - inc, @origin.z)
      else
        @origin
      end
    end

    def client
      @client ||= Client.new
    end

    class ZAxis
      attr_reader :origin, :inc, :client, :offset, :roof

      def initialize(origin, inc, client, offset, roof)
        @origin = origin
        @inc = inc
        @client = client
        @offset = offset
        @roof = roof
      end

      def render
        build_frame
        add_base
        add_rails
        add_power
        add_lamp
        add_ceiling
      end

      def build_frame
        client.execute("fill #{origin.x} #{origin.y - 1} #{offset} #{origin.x + 4} #{origin.y + 3} #{offset} #{roof}")
        client.execute("fill #{origin.x + 1} #{origin.y} #{offset} #{origin.x + 3} #{origin.y + 2} #{offset} air")
      end

      def add_base
        client.execute("fill #{origin.x} #{origin.y - 1} #{offset} #{origin.x + 4} #{origin.y - 2} #{offset} stone")
      end

      def add_rails(type = nil)
        type ||= "rail"

        client.execute("fill #{origin.x + 1} #{origin.y} #{offset} #{origin.x + 1} #{origin.y} #{offset} #{type}")
        client.execute("fill #{origin.x + 3} #{origin.y} #{offset} #{origin.x + 3} #{origin.y} #{offset} #{type}")
      end

      def add_power
        return unless (inc % 5 == 0) || origin.is_a?(AscendingCoordinate)

        add_rails("powered_rail")
        client.execute("fill #{origin.x + 1} #{origin.y - 1} #{offset} #{origin.x + 1} #{origin.y - 1} #{offset} redstone_block")
        client.execute("fill #{origin.x + 3} #{origin.y - 1} #{offset} #{origin.x + 3} #{origin.y - 1} #{offset} redstone_block")
      end

      def add_lamp
        return unless inc % 5 == 0

        client.execute("fill #{origin.x + 2} #{origin.y - 1} #{offset} #{origin.x + 2} #{origin.y - 1} #{offset} redstone_lamp")
      end

      def add_ceiling
        return unless inc % 10 == 0

        client.execute("fill #{origin.x + 2} #{origin.y + 3} #{offset} #{origin.x + 2} #{origin.y + 3} #{offset} glass")
      end
    end

    class XAxis
      attr_reader :origin, :inc, :client, :offset, :roof

      def initialize(origin, inc, client, offset, roof)
        @origin = origin
        @inc = inc
        @client = client
        @offset = offset
        @roof = roof
      end

      def render
        build_frame
        add_base
        add_rails
        add_power
        add_lamp
        add_ceiling
      end

      def build_frame
        client.execute("fill #{offset} #{origin.y - 1} #{origin.z} #{offset} #{origin.y + 3} #{origin.z + 4} #{roof}")
        client.execute("fill #{offset} #{origin.y} #{origin.z + 1} #{offset} #{origin.y + 2} #{origin.z + 3} air")
      end

      def add_base
        client.execute("fill #{offset} #{origin.y - 1} #{origin.z} #{offset} #{origin.y - 2} #{origin.z + 4} stone")
      end

      def add_rails(type = nil)
        type ||= "rail"

        client.execute("fill #{offset} #{origin.y} #{origin.z + 1} #{offset} #{origin.y} #{origin.z + 1} #{type}")
        client.execute("fill #{offset} #{origin.y} #{origin.z + 3} #{offset} #{origin.y} #{origin.z + 3} #{type}")
      end

      def add_power
        return unless (inc % 5 == 0) || origin.is_a?(AscendingCoordinate)

        add_rails("powered_rail")
        client.execute("fill #{offset} #{origin.y - 1} #{origin.z + 1} #{offset} #{origin.y - 1} #{origin.z + 1} redstone_block")
        client.execute("fill #{offset} #{origin.y - 1} #{origin.z + 3} #{offset} #{origin.y - 1} #{origin.z + 3} redstone_block")
      end

      def add_lamp
        return unless inc % 5 == 0

        client.execute("fill #{offset} #{origin.y - 1} #{origin.z + 2} #{offset} #{origin.y - 1} #{origin.z + 2} redstone_lamp")
      end

      def add_ceiling
        return unless inc % 10 == 0

        client.execute("fill #{offset} #{origin.y + 3} #{origin.z + 2} #{offset} #{origin.y + 3} #{origin.z + 2} glass")
      end
    end
  end
end
