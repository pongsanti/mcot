require 'sequel'

URL = ENV['DB_PATH']

DB = Sequel.sqlite.connect(database: URL)
