require File.expand_path('lib/facebook_authentication')
require 'json'
require 'active_support'
require 'active_support/dependencies'
require 'active_support/core_ext/hash/indifferent_access'

describe FacebookAuthentication do
  let(:auth_result){FacebookAuthentication.authenticate(oauth_params)}

  context "without authlogic parameters" do
    let(:oauth_params){ nil }
    it "is impossible" do
      auth_result.success?.should_not be
    end
  end

  context "with invalid autlogic parameters" do
    let(:oauth_params){ {bogus: true} }
    it "should be unsuccessful response" do
      auth_result.success?.should_not be
    end
  end

  context "on a new user with valid auth params" do
    let(:oauth_params){ JSON::parse(File.open(File::dirname(__FILE__) << '/fb_response','r').read) }

    it "should return a facebookgraph response" do
     expect {
       auth_result.is_a?(FacebookAuthentication::FacebookGraph)
     }.to be
    end

    it "should return a valid facebookgraph response" do
     expect {
       auth_result.success?
     }.to be
    end

    context "returns enough data for a valid user" do

      it "should have a first name" do
        auth_result.user.first_name.should be
      end

      it "should have a last name" do
        auth_result.user.last_name.should be
      end

      it "should have an email" do
        auth_result.user.email.should be
      end

      it "should have a location" do
        auth_result.user.location.should be
      end
    end
  end
end
