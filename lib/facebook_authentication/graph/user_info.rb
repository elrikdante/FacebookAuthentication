module FacebookAuthentication
  class Graph
    class UserInfo < Hashie::Trash
      property :email
      property :name
      property :first_name
      property :last_name
      property :urls
      property :profile_image, from: :image
      property :location
      property :nickname
      property :description
      property :verified
    end
  end
end
