module Resque
  module Failure
    module NotificationRecipient
      def recipients
        yml_path = Rails.root.join('config/mail.yml')
        return unless File.exist?(yml_path)

        options = YAML.load_file(yml_path)[Rails.env]
        options['recipients']
      end
    end
  end
end
