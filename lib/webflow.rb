# frozen_string_literal: true

require 'active_support/inflector'

require_relative "webflow/base"
require_relative "webflow/version"

module Webflow
  class ClientError < StandardError; end
end

## Define classes for each Webflow model

[ 'Site', 'Page', 'Form', 'Asset', 'AssetFolder',
  'Collection', 'Item' ].each do |klass_name|
    Webflow.const_set(klass_name, Class.new(Webflow::Base))
end

## Define associations

class Webflow::Site
  def assets
    load_assoc :assets
  end

  def collections
    load_assoc :collections
  end

  def pages
    load_assoc :pages
  end

  def forms
    load_assoc :forms
  end
end

class Webflow::Collection
  def items
    load_assoc :items
  end
end
