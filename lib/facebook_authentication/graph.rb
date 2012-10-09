module FacebookAuthentication
  class Graph

    autoload :UserInfo, 'facebook_authentication/graph/user_info'
    autoload :Credentials, 'facebook_authentication/graph/credentials'

    attr_accessor :response, :credentials, :user_info, :errors, :provider

    def initialize(args)
      self.errors = []
      self.response=  HashWithIndifferentAccess.new(args)
      self.provider=  response[:provider]
      self.credentials= response[:credentials]
      self.user= response[:info]
      super(args)
    end

    def success?
      errors.empty?
    end

    alias :successful? :success?
    alias :valid? :success?

    def unsuccessful?
      errors.any?
    end

    def user
      @user_info
    end

    def user=(user_args)
      safe_attribute_assignment(:user_info, user_args)
    end

    def credentials=(credential_args)
      safe_attribute_assignment(:credentials, credential_args)
    end

    def auth_token
      credentials.token
    end

    private

      def safe_attribute_assignment(attrib,raw_value)
        raw_value = (raw_value || {}).merge!(invalid_object: true) if raw_value.nil? or raw_value.keys.empty?
        parse_klass = FacebookAuthentication::Graph.const_get(attrib.to_s.camelize) #=> parse_klass = FA::Graph.const_get("UserInfo")
        instance_variable_set("@#{attrib}",parse_klass.new(raw_value)) #=> ( @user_info , UserInfo.new(raw_value) )
      rescue NoMethodError => e_msg
        self.errors << [attrib, e_msg]
      end
  end
end
