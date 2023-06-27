# frozen_string_literal: true

require "faraday"
require "multi_json"

# @private
module Faraday
  module BellPepperErrors
    # @private
    class Middleware < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do |response|
          case response[:status].to_i
          when 400
            raise BellPepper::BadRequest, error_message_400(response)
          when 404
            raise BellPepper::NotFound, error_message_400(response)
          when 500
            raise BellPepper::InternalServerError, error_message_500(response, "Something is technically wrong.")
          when 502
            raise BellPepper::BadGateway, error_message_500(response, "The server returned an invalid or incomplete response.")
          when 503
            raise BellPepper::ServiceUnavailable, error_message_500(response, "Crossref is rate limiting your requests.")
          when 504
            raise BellPepper::GatewayTimeout, error_message_500(response, "504 Gateway Time-out")
          end
        end
      end

      def initialize(app)
        super app
        @parser = nil
      end

      private

      def error_message_400(response)
        "\n   #{response[:method].to_s.upcase} #{response[:url]}\n   Status #{response[:status]}#{error_body(response[:body])}"
      end

      def error_body(body)
        if !body.nil? && !body.empty? && body.is_a?(String)
          if json?(body)
            body = ::MultiJson.load(body)
            if body["message"].nil?
              body = nil
            else
              body = body["message"]
            end
          end
        end

        if body.nil?
          nil
        else
          ": #{body}"
        end
      end

      def error_message_500(response, body = nil)
        "#{response[:method].to_s.upcase} #{response[:url]}: #{[response[:status].to_s + ":", body].compact.join(" ")}"
      end

      def json?(string)
        MultiJson.load(string)
        true
      rescue MultiJson::ParseError
        false
      end
    end
  end
end

