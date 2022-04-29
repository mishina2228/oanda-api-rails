# frozen_string_literal: true

module JobFailureNoticeMailerSupport
  def sample_exception
    exception = OandaAPI::RequestError.new('An error as occured while processing response.')
    backtrace = [
      '..lib/oanda_api/client/client.rb:124:in `rescue in execute_request`',
      '..lib/oanda_api/client/client.rb:107:in `execute_request`'
    ]
    exception.set_backtrace(backtrace)
    exception
  end
end
