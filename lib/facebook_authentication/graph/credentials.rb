module FacebookAuthentication
  class Graph
    class Credentials < Hashie::Trash
      property :token
      property :expires
    end
  end
end
