# frozen_string_literal: true

require 'csv'
require 'time'

require_relative 'passenger'
require_relative 'trip'
require_relative 'driver'

module RideShare
  class TripDispatcher
    attr_reader :drivers, :passengers, :trips

    def initialize(directory: './support')
      @passengers = Passenger.load_all(directory: directory)
      @trips = Trip.load_all(directory: directory)
      @drivers = Driver.load_all(directory: directory)
      connect_trips
    end

    def self.request_trip(passenger_id)
      #trip.new (
      #       id:,
      #       driver: nil, #could helper find_driver method --> @drivers.find { |driver| driver.status == :AVAILABLE }
      #       driver_id: nil,
      #       passenger: nil, -->does this auto assingn? or we do self.find_passenger?
      #       passenger_id: nil, #passenger_id
      #       start_time:, Time.now
      #       end_time:, nil
      #       cost: nil,
      #       rating:
      #     )
      #
      # call another method on driver --> go to driver to write that instance method to change the status
    end

    def find_passenger(id)
      Passenger.validate_id(id)
      @passengers.find { |passenger| passenger.id == id }
    end

    def find_driver(id)
      Driver.validate_id(id)
      @drivers.find { |driver| driver.id == id }
    end

    def inspect
      # Make puts output more useful
      "#<#{self.class.name}:0x#{object_id.to_s(16)} \
              #{trips.count} trips, \
              #{drivers.count} drivers, \
              #{passengers.count} passengers>"
    end

    private

    def connect_trips
      @trips.each do |trip|
        passenger = find_passenger(trip.passenger_id)
        driver = find_driver(trip.driver_id)
        trip.connect(passenger, driver)
      end

      trips
    end
  end
end
