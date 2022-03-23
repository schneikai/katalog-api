#
# Compare two JSON strings for similarity and but ignore timestamp fields
#
# Makes it easy to compare two JSON string in a Rails Integration test
# that contain AR created_at/updated_at timestamps. You don't need to
# freeze time or mess around with JSON strings.
#
# Compare two JSON strings. Notice the different created_at timestamp of the two strings
#
#   expected_json = '[{"id":1,"created_at":"2022-03-22T16:22:06.623Z"}]'
#   actual_json = '[{"id":1,"created_at":"2023-04-23T17:23:07.624Z"}]'
#   JsonCompareWithoutTimestamps.new(expected_json, actual_json).equal?
#   => true
#
# This can be used in a Integration test via the +assert_equal_json+ test helper
#
#   class PhotoTest < ActionDispatch::IntegrationTest
#     include JsonCompareWithoutTimestamps::TestHelper
#
#     test 'it gets index' do
#       create :photo
#       get '/api/v1/photos'
#       assert_response :success
#       assert_equal_json '[{"id":1,"title":"Foo","created_at":"2022-03-22T16:22:06.623Z","updated_at":"2022-03-22T16:22:06.623Z"}]', response.body
#     end
#   end
#

class JsonCompareWithoutTimestamps
  module TestHelper
    #
    # Compare two JSON strings for similarity while ignoring timestamp fields
    #
    # @param [String] exp the expected JSON string
    # @param [String] act the actual JSON string
    #
    def assert_equal_json(exp, act)
      compare = JsonCompareWithoutTimestamps.new(exp, act)
      equal = compare.equal?
      assert equal, compare.errors.join("\n").presence || ''
    end
  end

  # @return [Array<String>] list of error messages
  attr_reader :errors

  #
  # Returns new instance
  #
  # @param [String] exp the expected JSON string
  # @param [String] act the JSON string to compare for equality
  #
  def initialize(exp, act)
    @exp = exp
    @act = act
    @errors = []
    @timestamp_keys = %w[created_at updated_at]
  end

  #
  # Check equality of JSON strings
  #
  # @return [Boolean] +true+ if JSON strings where equal, +false+ otherwise
  #
  def equal?
    exp_parsed = parse_json(@exp)
    act_parsed = parse_json(@act)

    # Return if parsing errors
    return false if errors?

    exp_without_timestamps = check_and_remove_timestamps(exp_parsed).to_json
    act_without_timestamps = check_and_remove_timestamps(act_parsed).to_json

    # Return if errors during check and remove timestamps
    return false if errors?

    is_equal = exp_without_timestamps == act_without_timestamps
    @errors << "JSON strings do not match!\n-#{@exp}\n+#{@act}" unless is_equal
    is_equal
  end

  #
  # Check if errors are present
  #
  # @return [Boolean] +true+ if errors present, +false+ otherwise
  #
  def errors?
    @errors.any?
  end

  private

  #
  # Parse the given JSON string
  #
  # @param [String] json the JSON string you want to parse
  #
  # @return [Hash] the parsed JSON
  #
  def parse_json(json)
    parse_json_times = ActiveSupport.parse_json_times
    ActiveSupport.parse_json_times = true
    begin
      ActiveSupport::JSON.decode(json)
    ensure
      ActiveSupport.parse_json_times = parse_json_times
    end
  rescue StandardError => e
    @errors << "Failed to parse '#{json}' as JSON: Error: #{e.message}"
  end

  #
  # Checks the given JSON for timestamp keys, checks if they are
  # actually a timestamp and removes them.
  #
  # It will add errors to the +errors+ collection if a required
  # timestamp field is not found or doesn't contain a timestamp.
  #
  # @param [Hash] parsed_json the parsed JSON
  #
  # @return [Hash] the parsed JSON with timestamps removed
  #
  def check_and_remove_timestamps(parsed_json) # rubocop:disable Metrics/MethodLength
    parsed_json_without_timestamp = []

    (parsed_json.instance_of?(Array) ? parsed_json : [parsed_json]).each do |ent|
      entry = ent.deep_dup
      @timestamp_keys.each do |key|
        timestamp = entry.delete(key)
        if timestamp.blank?
          @errors << "Expected attr '#{key}' not found!"
        elsif !timestamp.instance_of?(ActiveSupport::TimeWithZone)
          @errors << "Expected timestamp in '#{key}' but found: #{timestamp}"
        end
      end
      parsed_json_without_timestamp << entry
    end

    parsed_json.instance_of?(Array) ? parsed_json_without_timestamp : parsed_json_without_timestamp.first
  end
end
