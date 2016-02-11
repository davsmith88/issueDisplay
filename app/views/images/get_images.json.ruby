# needs to have the image url in the 
q = []
@images.each do |item|
	puts item.picture.url(:thumb)
	a = {}
	a[:id] = item.id
	a[:name] = item.name
	a[:imgUrl] = item.picture.url(:thumb)
	a[:totalCount] = @imgCount
	q.push(a)
end
q.to_json
