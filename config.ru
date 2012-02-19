$: << "."
$stdout.sync = true

require 'rack/ssl'
require 'faye'

require 'auth_ext'

use Rack::SSL unless ENV['SSL_OFF'] # set SSL_OFF in .env

faye_server = Faye::RackAdapter.new(:mount => '/faye',
                                    :timeout => 25,
                                    :extensions => [AuthExt.new])

run faye_server