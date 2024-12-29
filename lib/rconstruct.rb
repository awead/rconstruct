# frozen_string_literal: true

require "rcon"
require "forwardable"

require "rconstruct/client"
require "rconstruct/cylinder"
require "rconstruct/spheroid"
require "rconstruct/hemisphere"
require "rconstruct/sphere"
require "rconstruct/subway"
require "rconstruct/version"

module Rconstruct
  class Error < StandardError; end

  Coordinate = Struct.new(:x, :y, :z)
end
