require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

 
module FoodGeneratorApp
	class Application < Rails::Application
    	config.recipes = Elasticsearch::Persistence::Repository.new do
		  client Elasticsearch::Client.new url: 'http://localhost:9200', log: true
		  index :recipes
		  type  :data_record
		end

		config.ingredients = Elasticsearch::Persistence::Repository.new do
			client Elasticsearch::Client.new url: 'http://localhost:9200', log: true
			index :ingredients
			type  :data_record
		end

		config.relationships = Elasticsearch::Persistence::Repository.new do
		  client Elasticsearch::Client.new url: 'http://localhost:9200', log: true
		  index :relationships
		  type  :data_record
		end
	end
end


class DataRecord
  attr_reader :attributes

  def initialize(attributes={})
    @attributes = attributes
  end

  def to_hash
    @attributes
  end
end
