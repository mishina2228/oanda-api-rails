class EurJpyM1CandleJob
  @queue = :normal

  def self.perform(params = {})
    params = params.with_indifferent_access
    p 'Hello Resque!'
  end
end
