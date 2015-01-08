module DummyApi
  module Fields
    class Email < DummyApi::Field

      def faker_class
        ::Faker::Internet
      end

      def faker_method
        :email
      end
    end
  end
end
