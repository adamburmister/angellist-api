module AngellistApi
  class Client
    module Messages
      def get_messages(options={})
        get("1/messages", options)
      end

      def thread_item(id, options)
        get("1/messages/#{id}", options)
      end

      def send_message(options={})
        post("1/messages", options)
      end
    end
  end
end
