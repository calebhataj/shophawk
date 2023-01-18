class Tempmat < ApplicationRecord
require 'csv'
require 'database_cleaner/active_record'

	
	def self.importmat
		DatabaseCleaner.clean_with(:truncation, :only => %w[tempmats]) #resets ID's
		items = []

		CSV.foreach('app/assets/csv/tempjobs.csv', 'r:iso-8859-1:utf-8', :quote_char => "|", headers: true) do |row|
			if row[0]
				items << {
			      	Job: row[0], 
			      	Material: row[1], 
			      	Vendor: row[2],
			      	Description: row[3],
			      	}
 			end
		end
	    Tempmat.import items
	end


end
