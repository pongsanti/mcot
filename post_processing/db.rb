require 'sequel'

URL = ENV['DB_PATH']

DB = Sequel.connect("sqlite://#{URL}")

require 'model/t'