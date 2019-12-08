module Resque
  module Failure
    module NotificationRecipient
      def recipients
        # TODO: consider how to set email recipients
        ['user1@example.com']
      end
    end
  end
end
