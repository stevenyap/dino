module Dino
  module Components
    class RgbLed < BaseComponent
      attr_reader :red, :blue, :green

      # options = {board: my_board, pins: {red: red_pin, green: green_pin, blue: blue_pin}
      def after_initialize(options={})
        raise 'missing pins[:red] pin'   unless self.pins[:red]
        raise 'missing pins[:green] pin' unless self.pins[:green]
        raise 'missing pins[:blue] pin'  unless self.pins[:blue]

        pins.each do |color, pin|
          set_pin_mode(pin, :out)
          analog_write(pin, Board::LOW)
        end

        @red = @green = @blue = 0
      end

      [:red, :green, :blue].each do |primary|
        define_method("#{primary}=") do |cycle|
          raise 'Duty cycle must be between 0 to 255' unless cycle.between? 0, 255
          instance_variable_set("@#{primary}", cycle)
          write
        end
      end

      def rgb
        { red: @red, green: @green, blue: @blue }
      end

      def rgb=(red: @red, green: @green, blue: @blue)
        @red   = red
        @green = green
        @blue  = blue
        write
      end

      def off
        rgb = { red: 0, green: 0, blue: 0 }
      end

      def write
        analog_write(pins[:red],   @red)
        analog_write(pins[:green], @green)
        analog_write(pins[:blue],  @blue)
        rgb
      end
    end
  end
end
