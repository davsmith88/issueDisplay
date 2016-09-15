class PagesController < ApplicationController
	authorize_resource :class => false
	def show
		if valid?
			render template: "pages/#{params[:page]}"
		else
			render file: "public/404.html", status: :not_found
		end
	end

	def valid?
		File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
	end
end
