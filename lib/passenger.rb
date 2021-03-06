require_relative 'csv_record'

module RideShare
  class Passenger < CsvRecord
    attr_reader :name, :phone_number, :trips

    def initialize(id:, name:, phone_number:, trips: [])
      super(id)

      @name = name
      @phone_number = phone_number
      @trips = trips
    end

    def add_trip(trip)
      @trips << trip
    end

    def net_expenditures
      return nil if @trips.empty?
      total = 0
      @trips.each do |trip| #why didn't this work with .reduce?
        if trip.cost.nil?
          puts "There is a trip in progress that will not be included in total."
          next
        end

        total += trip.cost
      end
      return total
    end

    def total_time_spent  #in progress trip is 0 so that the total is returned without it
      return 0 if @trips.empty?
      @trips.reduce(0){ |total_time, trip| total_time + trip.duration}
    end

    private

    def self.from_csv(record)
      return new(
        id: record[:id],
        name: record[:name],
        phone_number: record[:phone_num]
      )
    end
  end
end
