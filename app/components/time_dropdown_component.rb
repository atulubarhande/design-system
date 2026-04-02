class TimeDropdownComponent < ViewComponent::Base
  attr_reader :minutes_slot, :minutes_interval, :end_time, :times_array_for

  # When both start time and end time are selected simultaneously, 
  # this component performs validation:
  # - For end time: Disable options where time is greater than or equal to the selected start time.
  # - For start time: Disable options where time is less than or equal to the selected end time.

  def initialize(name: nil, minutes_slot: nil, minutes_interval: nil, end_time: false, minutes_from_midnight: false, selected: nil, value: nil, use_24_hour_format: false, promt_message: nil, id: SecureRandom.uuid,
      validate_from_to: false, data: Hash.new, selected_time: nil, same_time_not_allowed: false, disabled: nil )
    @name = name
    @minutes_slot = minutes_slot
    @minutes_interval = minutes_interval
    @end_time = end_time
    @times_array_for = []
    @minutes_from_midnight = minutes_from_midnight
    @selected = selected
    @value = value
    @use_24_hour_format = use_24_hour_format
    @promt_message = promt_message
    @id = id
    @validate_from_to = validate_from_to  # validate start and end time 
    @data = data
    @selected_time = selected_time
    @same_time_not_allowed = same_time_not_allowed # start time != end time
    @disabled = disabled
    setup_times_array
  end

  private

  def setup_times_array
    if minutes_slot
      generate_times_with_slot
    else
      generate_default_times
    end

    if end_time && !@times_array_for.include?("23:59") && !@times_array_for.include?("11:59 PM")
      @times_array_for.push("23:59") if @use_24_hour_format
      @times_array_for.push("11:59 PM") unless @use_24_hour_format
    end
  end

  def generate_times_with_slot
    minutes_slot_int = minutes_slot.to_i
    am_pm = @use_24_hour_format ? nil : ['AM', 'PM']

    (0...1440).step(minutes_slot_int) do |i|
      hour = (i / 60).to_i
      minute = (i % 60).to_s.rjust(2, '0')

      if @use_24_hour_format
        formatted_hour = hour.to_s.rjust(2, '0')
        @times_array_for.push("#{formatted_hour}:#{minute}")
      else
        formatted_hour = format_hour(hour)
        period = hour < 12 ? 'AM' : 'PM'
        @times_array_for.push("#{formatted_hour}:#{minute} #{period}")
      end
    end
  end

  def generate_default_times
    hours = @use_24_hour_format ? (0..23).map { |h| h.to_s.rjust(2, '0') } : %w[12 01 02 03 04 05 06 07 08 09 10 11]
    minutes = minutes_interval || ['00']
    am_pm = @use_24_hour_format ? nil : ['AM', 'PM']

    am_pm&.each do |period|
      hours.each do |hour|
        minutes.each do |minute|
          @times_array_for.push("#{hour}:#{minute} #{period}")
        end
      end
    end

    if @use_24_hour_format
      hours.each do |hour|
        minutes.each do |minute|
          @times_array_for.push("#{hour}:#{minute}")
        end
      end
    end
  end

  def format_hour(hour)
    return '12' if hour == 0 || hour == 12
    (hour % 12).to_s.rjust(2, '0')
  end

  def custom_data
    if @validate_from_to || @same_time_not_allowed
      @data.merge(action: "time-dropdown#onTimeChange time-dropdown#disableInvalidTimes")
    else
      @data.merge(action: "time-dropdown#onTimeChange")
    end 
  end

  def disabled_options
    disabled_options_arr = []

    @times_array_for.each do |time|
      # Enable all options first (this will be done by not adding it to the disabled list initially)
      # Disable if same time is not allowed and the time matches the selected time
      if @same_time_not_allowed && time == @selected_time
        disabled_options_arr << time
      end
    
      if @validate_from_to
        # option_time = Time.parse(time)
        # option_time = new_time.strftime("%I:%M %p") # Parsing option time
    
        if @end_time
          # For end time: disable options where option_time <= selected_time
          # Disable all end times that are less than or equal to selected end time
          if @selected_time && Time.parse(time) <= Time.parse(@selected_time)
            disabled_options_arr << time
          end
        else
          # For start time: disable options where option_time >= selected_time
          # Disable all start times that are greater than or equal to selected start time
          if @selected_time && Time.parse(time) >= Time.parse(@selected_time)
            disabled_options_arr << time
          end
        end
      end
    end
    disabled_options_arr
  end
end
