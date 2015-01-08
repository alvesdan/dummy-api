module DummyApi
  module Fields
    class Name < DummyApi::Field

      def faker_class
        ::Faker::Name
      end

      def faker_method
        :name
      end
    end
  end
end
