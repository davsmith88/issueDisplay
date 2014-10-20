json.set! :workarounds do
	@issue_workarounds.each do |work|
		json.set! :id, work.id
		json.set! :content, work.description
	end
end