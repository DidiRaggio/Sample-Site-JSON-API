# class DataWorker
# 	include Sidekiq::Worker
# 	include Sidetiq::Schedulable
# 	sidekiq_options retry: false
# 	# recurrence { daily.hour_of_day(23) }

# 	def perform
# 		require 'quandl'
# 		bulkdestination = './bulk_eod_files'
# 		FileUtils.mkdir_p(bulkdestination)
# 		Quandl::ApiConfig.api_key = ENV['API_KEY']
# 		Quandl::ApiConfig.api_version = ENV['API_VERSION']
# 		#Polling of Quandl is working for the partial DB
# 		# Quandl::Database.get('EOD').bulk_download_to_file('./bulk_eod_files', params: {download_type: 'partial'})
# 		Quandl::Database.get('EOD').bulk_download_to_file('./bulk_eod_files')
# 		puts "Eod database has been downloaded form quandl"
# 		UnZipper.perform_async
# 	end

	

# end

 


# class UnZipper
# 	include Sidekiq::Worker
# 	sidekiq_options retry: false
# 	def perform
# 		require 'zip'
# 		file_path   = Dir["./bulk_eod_files/*.zip"].first
# 		puts file_path
		
# 		destination = "./unzipped-eod"
# 		FileUtils.mkdir_p(destination)

# 		  Zip::File.open(file_path) do |zip_file|
		  	
# 		    zip_file.each do |f|
		    	
# 		      fpath = File.join(destination, f.name)
# 		      zip_file.extract(f, fpath) unless File.exist?(fpath)
# 		      	# CSVParser.perform_async(fpath)
# 		      	puts "zippfile file path"
# 		      	puts fpath
# 		   	end
# 		   end
# 		puts "Unzipper has run"
# 		# Deletes the zip file to economize memory usage, can be commented out to save the zipped file
# 		File.delete(file_path) if File.exist?(file_path)
# 		puts "CSVParser should run next..."
# 		# CSVParser can be delayed to spread out work
# 		CSVParser.perform_in((0).seconds)
# 	end

# end



# class CSVParser
# 	include Sidekiq::Worker
# 	# include Sidetiq::Schedulable
# 	sidekiq_options retry: false
# 	def perform
# 		require 'csv'
# 		require 'active_record'
# 		require 'date'
# 		reference_date = Date.new(1999/01/01)
# 		csv_path = Dir["./unzipped-eod/*.csv"].first


# 		counter = 0
# 		lines = []

# 		IO.foreach(csv_path) do |line|

# 			lines << line
# 			if lines.size >= 100000

# 				ActiveRecord::Base.transaction do
# 					CSV.parse(lines.join) do |item|
# 						stockticker_symbol, date, unadjusted_open, unadjusted_high, unadjusted_low, unadjusted_close, unadjusted_volume, dividends, splits, adjusted_open, adjusted_high, adjusted_low, adjusted_close, adjusted_volume = item



# 							bulk = Eod.create!(
# 										stockticker_symbol: stockticker_symbol, 
# 										date: date, 
# 										unadjusted_open: unadjusted_open,
# 										unadjusted_high: unadjusted_high,
# 										unadjusted_low: unadjusted_low,
# 										unadjusted_close: unadjusted_close,
# 										unadjusted_volume: unadjusted_volume,
# 										dividends: dividends,
# 										splits: splits,
# 										adjusted_open: adjusted_open,
# 										adjusted_high: adjusted_high,
# 										adjusted_low: adjusted_low,
# 										adjusted_close: adjusted_close,
# 										adjusted_volume: adjusted_volume
# 								)
# 							puts "#{stockticker_symbol} - #{date} - #{bulk.errors.full_messages.join(",")}" if bulk.errors.any?
# 							counter += 1 if bulk.persisted?

					
# 					end

# 				end

# 				lines = []
# 			end

# 		end
# 		puts "CSVParser has run, CSVChunk should run next"
# 		#Deletes csv file to save memory, this can be commented out to save teh csv file
# 		File.delete(csv_path) if File.exist?(csv_path)
# 	end

# end