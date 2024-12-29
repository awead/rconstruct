module Rconstruct
  class Client
    extend Forwardable

    def_delegators :@connection, :execute, :end_session!

    def initialize
      @connection = build_client
    end

    private

    def build_client
      client = Rcon::Client.new(host: ENV["RCON_HOST"], port: ENV["RCON_PORT"], password: ENV["RCON_PASSWORD"])
      client.authenticate!(ignore_first_packet: false)
      client
    end
  end
end
