require 'ostruct'
require 'spec_helper'
require 'byebug'

# test process inspired by automatic/omniauth-automatic
# file should not be considered a complete spec yet

describe OmniAuth::Strategies::Younility do
  let(:access_token) { double('AccessToken', options: {}) }
  let(:parsed_response) { double('ParsedResponse') }
  let(:response) { double('Response', parsed: parsed_response) }
  let(:app) { lambda { |r| [200, '', ['Yo']] } }
  let(:the_uid_response) { '123' }

  subject { described_class.new(app) }

  before(:each) do
    OmniAuth.config.test_mode = true
    subject.stub(:access_token).and_return(access_token)
  end

  context "client options" do
    it "returns the #site" do
      expect(subject.options.client_options.site).to eq('https://app.younility.com')
    end

    it "returns the #authorize_url" do
      expect(subject.options.client_options.authorize_url).to eq('/api/oauth/authorize')
    end

    it "returns the #token_url" do
      expect(subject.options.client_options.token_url).to eq('/api/oauth/token')
    end
  end

  describe "auth params" do
    let(:response_params) do
      {
        'user' => {
          'id'          => '123',
        },
        'access_token'  => '123',
        'refresh_token' => 'abcd',
        'expires_in'    => 34345,
        'token_type'    => 'Bearer'
      }
    end

    before(:each) do
      access_token.stub(:params).and_return response_params
      access_token.stub(:token).and_return '123'
      access_token.stub(:expires?).and_return true
      access_token.stub(:refresh_token).and_return 'abcd'
      access_token.stub(:expires_in).and_return 34345
      access_token.stub(:expires_at).and_return 12345
    end

    context "#raw_info" do
      it "should return user info" do
        access_token.should_receive(:get).with('/api/v0/whoami').and_return(response)
        subject.raw_info.should eq(parsed_response)
      end
    end

    it "returns the uid" do
      expected = '123'
      access_token.should_receive(:get).with('/api/v0/whoami').and_return(response)
      # byebug
      parsed_response.should_receive(:[]).with('id').and_return(the_uid_response)
      expect(subject.uid).to eq(expected)
    end

    describe "info hash" do
      let(:parsed_response) do
        {
          "id"                      => "123",
          "name"                    => "Lester Tester",
          "email"                   => "lester@example.com",
          "default_organization_id" => "987",
          "default_role"            => "admin"
        }
      end

      it "returns the info hash" do
        expected = {
          'id'                      => '123',
          'name'                    => 'Lester Tester',
          'email'                   => 'lester@example.com',
          'default_organization_id' => '987',
          'default_role'            => 'admin'
        }
        access_token.should_receive(:get).with('/api/v0/whoami').and_return(response)
        expect(subject.info).to eq(expected)
      end
    end

    describe "auth hash" do
      let(:parsed_response) do
        {
          "provider"=>"younility",
          "uid"=>"123",
          "info"=>
            {
              "id"                      => "123",
              "email"                   => "lester@example.com",
              "name"                    => "Lester Tester",
              "default_organization_id" => "987",
              "default_role"            => "admin"
            },
          "credentials"=>
            {
              "token"         => "123",
              "refresh_token" => "abcd",
              "expires_at"    => 12345,
              "expires"       => true
            },
          "extra"=>{}
        }
      end

      it "returns the auth hash" do
        expected = {
          "provider" => "younility",
          "uid" => nil, # apparently doesn't come in our auth_hash
          "info" =>
            {
              "id"                      => nil,
              "email"                   => nil,
              "name"                    => nil,
              'default_organization_id' => nil,
              'default_role'            => nil
            },
          "credentials"=>
            {
              "token"         => "123",
              "refresh_token" => "abcd",
              "expires_at"    => 12345,
              "expires"       => true
            },
          "extra"=>{}
        }
        access_token.should_receive(:get).with('/api/v0/whoami').and_return(response)
        expect(subject.auth_hash.to_hash).to eq(expected)
      end
    end

    it "returns the credentials hash" do
      expected = {
        'token'         => '123',
        'refresh_token' => 'abcd',
        'expires_at'    => 12345,
        'expires'       => true
      }
      expect(subject.credentials).to eq(expected)
    end
  end

end
