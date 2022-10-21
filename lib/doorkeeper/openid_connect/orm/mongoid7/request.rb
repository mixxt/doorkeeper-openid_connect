# frozen_string_literal: true

module Doorkeeper
  module OpenidConnect
    class Request
      include Mongoid::Document
      include Mongoid::Timestamps

      field :nonce, type: String
      field :access_grant_id, type: String

      validates :nonce, :access_grant_id, presence: true

      if Gem.loaded_specs['doorkeeper'].version >= Gem::Version.create('5.5.0')
        belongs_to :access_grant,
                   class_name: Doorkeeper.config.access_grant_class.to_s,
                   inverse_of: :openid_request
      else
        belongs_to :access_grant,
                   class_name: 'Doorkeeper::AccessGrant',
                   inverse_of: :openid_request
      end

      index({ nonce: 1 })
    end
  end
end
