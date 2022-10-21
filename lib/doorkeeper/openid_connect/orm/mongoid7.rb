# frozen_string_literal: true

require 'active_support/lazy_load_hooks'

module Doorkeeper
  module OpenidConnect
    module Orm
      module Mongoid7

        def initialize_models!
          super
          lazy_load do
            require 'doorkeeper/openid_connect/orm/mongoid7/access_grant'
            require 'doorkeeper/openid_connect/orm/mongoid7/request'

            if Gem.loaded_specs['doorkeeper'].version >= Gem::Version.create('5.5.0')
              Doorkeeper.config.access_grant_model.prepend Doorkeeper::OpenidConnect::AccessGrant
            else
              Doorkeeper::AccessGrant.prepend Doorkeeper::OpenidConnect::AccessGrant
            end
          end
        end

        def self.lazy_load(&block)
          ActiveSupport.on_load(:mongoid, {}, &block)
        end
      end
    end
  end

  if defined?(Orm::Mongoid7)
    Orm::Mongoid7.singleton_class.send :prepend, OpenidConnect::Orm::Mongoid7
  end
end
