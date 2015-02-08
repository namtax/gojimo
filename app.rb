$:.unshift(File.expand_path('../lib', '__FILE__'))
$:.unshift(File.expand_path('../models', '__FILE__'))

require 'sinatra/base'
require 'haml'
require 'api_client'
require 'data_store'
require 'subject'
require 'qualification'

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
