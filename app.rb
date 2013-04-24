require 'sinatra/base'
require 'sinatra/assetpack'
require 'rack/ssl'
require 'webrick/https'
require 'openssl'

class App < Sinatra::Base
  use Rack::SSL

  set :root, File.dirname(__FILE__)

  register Sinatra::AssetPack
  assets {
    js :application, ['/js/*.js' ]
    css :application, [ '/css/*.css' ]
  }

  get '/' do
    erb :index
  end

end

Rack::Server.start(
  :config             => 'config.ru',
  :Port               => 8443,
  :Logger             => WEBrick::Log::new($stderr, WEBrick::Log::DEBUG),
  :SSLEnable          => true,
  :SSLVerifyClient    => OpenSSL::SSL::VERIFY_NONE,
  :SSLCertificate     => OpenSSL::X509::Certificate.new(  File.open("server.crt").read),
  :SSLPrivateKey      => OpenSSL::PKey::RSA.new(          File.open("server.key").read),
  :SSLCertName        => [ [ "US",WEBrick::Utils::getservername ] ],
)
