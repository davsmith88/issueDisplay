require 'csv'

namespace :create do
	desc "create a lineup entry"
	task b: :environment do

		master_spec = ["3022125362","3022125555","3022125764","3022125842","3022125121","3022123243","3022122324"]
		temp = ["3022125362","3022125555","3022125764","3022125842","3022125121","3022123243","3022122324"]
		data = Hash["3022125362" => Hash["job_number" => 16151254, "cust_name" => "Arnotts"],
					"3022125555" => Hash["job_number" => 16151333, "cust_name" => "Signet"],
					"3022125764" => Hash["job_number" => 16151213, "cust_name" => "Parmalat"],
					"3022125842" => Hash["job_number" => 16151418, "cust_name" => "Jayco"],
					"3022125121" => Hash["job_number" => 16151415, "cust_name" => "Simplot"],
					"3022123243" => Hash["job_number" => 16151547, "cust_name" => "Lion Nathan"],
					"3022122324" => Hash["job_number" => 16161111, "cust_name" => "Pfd Food"]]
		# puts data
		# puts master_spec[rand(0...data.length)]
		


		file = File.new("data/lineups/#{Time.now.to_time.to_i}.csv", "w")
		["150", "160", "180"].each do |y|
		for i in 1..4
				puts y
				random_index = rand(0...temp.length)
				q = temp[random_index]
				temp.delete(q)
				pp temp
				b = data[q]
				file.puts "#{i},#{b["job_number"]},#{q},#{y},#{b["cust_name"]}"
			end
			temp = master_spec.clone
		end

		file.close
	end
end