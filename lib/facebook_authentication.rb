require 'hashie/trash'
module FacebookAuthentication

  autoload :Graph, 'facebook_authentication/graph'

  def self.authenticate(auth_params)
    Graph.new(auth_params)
  end

end
