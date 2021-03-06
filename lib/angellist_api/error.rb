module AngellistApi
  # Custom error class for rescuing from all AngellistApi errors
  class Error < StandardError
    attr_reader :http_headers

    # Initializes new Error object
    #
    # @param [String] message
    # @param [Hash] http_headers
    # @return [AngellistApi::Error]
    def initialize(message, http_headers)
      @http_headers = Hash[http_headers]
      super message
    end

    # @return [Time]
    def ratelimit_reset
      Time.at(@http_headers.values_at('x-ratelimit-reset', 'X-RateLimit-Reset').detect{|value| value}.to_i)
    end

    # @return [Integer]
    def ratelimit_limit
      @http_headers.values_at('x-ratelimit-limit', 'X-RateLimit-Limit').detect{|value| value}.to_i
    end

    # @return [Integer]
    def ratelimit_remaining
      @http_headers.values_at('x-ratelimit-remaining', 'X-RateLimit-Remaining').detect{|value| value}.to_i
    end

    # @return [Integer]
    def retry_after
      [(ratelimit_reset - Time.now).ceil, 0].max
    end
  end
end
