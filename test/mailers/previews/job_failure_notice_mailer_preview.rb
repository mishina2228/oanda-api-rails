# Preview all emails at http://localhost:3000/rails/mailers/job_failure_notice_mailer
class JobFailureNoticeMailerPreview < ActionMailer::Preview
  def alert
    exception = OandaAPI::RequestError.new('An error as occured while processing response.')
    backtrace = [
      '..lib/oanda_api/client/client.rb:124:in `rescue in execute_request`',
      '..lib/oanda_api/client/client.rb:107:in `execute_request`'
    ]
    exception.set_backtrace(backtrace)
    JobFailureNoticeMailer.with(to: 'test_to@example.com', exception: exception).alert
  end
end
