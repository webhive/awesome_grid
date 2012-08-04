# encoding: utf-8
require 'rubygems'
require 'bundler'

Bundler.setup

require 'active_support'
require 'action_pack'
require 'action_view'
require 'action_controller'
require 'active_record'

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/awesome_grid'))

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each {|f| require f}

module AwesomeGridSpecHelper
  include ActionPack
  include ActionView::Context if defined?(ActionView::Context)
  include ActionController::RecordIdentifier
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::ActiveRecordHelper if defined?(ActionView::Helpers::ActiveRecordHelper)
  include ActionView::Helpers::ActiveModelHelper if defined?(ActionView::Helpers::ActiveModelHelper)
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::AssetTagHelper
  include ActiveSupport
  include ActionController::PolymorphicRoutes if defined?(ActionController::PolymorphicRoutes)

  include AwesomeGrid::Helpers::GridHelper

  def self.included(base)
    base.class_eval do
      attr_accessor :output_buffer
      def protect_against_forgery?
        false
      end
    end
  end

  def mock_everything
    @posts = []
    10.times do |i|
      post = ::Post.new
      post.stub!(:class).and_return(::Post)
      post.stub!(:to_label).and_return("Post #{i}")
      post.stub!(:title).and_return("Post #{i}")
      post.stub!(:id).and_return(i)
      post.stub!(:new_record?).and_return(false)
      post.stub!(:errors).and_return(mock('errors', :[] => nil))
      post.stub!(:to_key).and_return(nil)
      post.stub!(:persisted?).and_return(nil)
      @posts << post
    end
  end

  class ::Post
    extend ActiveModel::Naming if defined?(ActiveModel::Naming)
    include ActiveModel::Conversion if defined?(ActiveModel::Conversion)

    def id
    end

    def persisted?
    end
  end

end
