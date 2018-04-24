require 'uri'

module Hawker
  class Mapper
    MAPPINGS = {
      /(http|https):\/\/(www.|)github.com\/[a-zA-Z0-9_]*/ => Hawker::Drivers::Github,
      /(http|https):\/\/(www.|)instagram.com\/[a-zA-Z0-9_]*/ => Hawker::Drivers::Instagram,
      /(http|https):\/\/(www.|)twitter.com\/[a-zA-Z0-9_]*/ => Hawker::Drivers::Twitter,
      /(http|https):\/\/(www.|)vimeo.com\/[a-zA-Z0-9_]*/ => Hawker::Drivers::Vimeo,
      "default" => Hawker::Drivers::Default
    }.freeze

    # Maps the given URL to the driver class
    #
    # @return [Object]
    def self.map(url, response)
      driver_mappings = MAPPINGS.find { |key, value| url.match(key) }
      driver = driver_mappings.nil? ? MAPPINGS["default"] : driver_mappings.last

      driver.new(response)
    end
  end
end
