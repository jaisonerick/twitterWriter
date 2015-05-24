require 'bundler/setup'
require 'sidekiq'

require_relative '../lib/twitter_watcher'

TwitterWatcher::Application.setup