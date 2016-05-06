require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # OmniAuth OAuth2 Strategy for Younility API
    class Younility < OmniAuth::Strategies::OAuth2
      option :name, "younility"

      if ENV['SITE_URL'].present?
        url = ENV['SITE_URL']
      else
        url = 'https://app.younility.com'
      end

      option :client_options, {
        site:           url,
        authorize_url:  '/api/oauth/authorize',
        token_url:      '/api/oauth/token'
      }

      def authorize_params
        super.tap do |params|
          params[:response_type] = 'code'
          params[:client_id] = client.id
          params[:redirect_uri] ||= callback_url
        end
      end

      def request_phase
        super
      end

      uid do
        raw_info['id']
      end

      info do
        {
          'id'                      => raw_info['id'],
          'name'                    => raw_info['name'],
          'email'                   => raw_info['email'],
          'verified_email'          => raw_info['verified_email'],
          'default_organization_id' => raw_info['default_organization_id'],
          'default_role'            => raw_info['default_role']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v0/whoami').parsed
      end

      def build_access_token
        token_params = {
          code:           request.params['code'],
          redirect_uri:   callback_url,
          client_id:      client.id,
          client_secret:  client.secret,
          grant_type:     'authorization_code'
        }
        client.get_token token_params
      end

    end
  end
end
