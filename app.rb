$:.unshift(File.expand_path('../lib', '__FILE__'))
$:.unshift(File.expand_path('../models', '__FILE__'))

require 'sinatra/base'
require 'haml'
require 'api_client'
require 'configuration'
require 'data_store'
require 'qualification'
require 'pathname'
require 'subject'

class Gojimo < Sinatra::Base
  get '/' do
    @qualifications = Qualification.all
    haml :index
  end

  get '/:qual' do
    @qualification = Qualification.find(params['qual'])
    haml :qual
  end
end
