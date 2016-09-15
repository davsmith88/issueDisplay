require 'csv'

namespace :import do
	desc "Import users from csv"
	task lineups: :environment do
		# get filenames of csv files in folder 'data/lineups'
		# get most recent file with time stamp
		# migrate that data

		filenames = Dir["data/lineups/*.csv"]
		t = []
		filenames.each do |f|
			timestamp = f.slice(13, 10)
			t.push(timestamp)
		end
		file = File.join Rails.root, "data/lineups/#{t.max}.csv" #gets the most recent file
		# create the entry in the data base for filename, time
		# will have to check the file name is not in the database already
		CSV.foreach(file) do |row|
			pos_num, job_num, mas_spec, machine, cust = row
			Lineup.create(position_number: pos_num, job_number: job_num, master_spec: mas_spec, machine: machine, cust_name: cust, timestamp: t.max)
			puts "created"
		end
	end
end