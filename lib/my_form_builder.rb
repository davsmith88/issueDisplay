class MyFormBuilder < ActionView::Helpers::FormBuilder
	include ActionView::Helpers::TagHelper
	include ActionView::Helpers::CaptureHelper
	include ActionView::Helpers::TextHelper

	attr_accessor :output_buffer

	%w(email_field text_field password_field text_area date_field).each do |form_method|
		define_method(form_method) do |*args|
			attribute = args[0]
			options = args[1] || {}
			options[:label] ||= attribute
			options[:class] = "form-control"
			label_text ||= options.delete(:label).to_s.titleize
			label_options ||= {}
			new_class = "form-group"
			if errors_on?(attribute)
				new_class = "form-group has-error"
				# label_options[:class] = "error"
				# options[:class] = "form-control error"
			end
			label_options[:class] = "col-sm-2 control-label"
			content_tag(:div, class: new_class) do
				label(:name, label_text, class: "col-sm-2 control-label") +
				content_tag(:div,class: "col-sm-10") do
					super(attribute, options) +
					errors_for_field(attribute)
				end
			end
		end
	end

	def file_field(a, b)
		label = b[:label]
		b.delete(:label)
		content_tag(:div, class: "form-group") do
			label(:name, label, class: "col-sm-2 control-label") +
			content_tag(:div, class: "col-sm-10") do
				super(a, b) + errors_for_field(a)
			end
		end
	end

	def submit(text, options={})
		# options[:class] ||= "button radius expand"
		label = options[:label].to_s.titleize
		options.delete(:label)
		wrapper({label: label}) do
			super(text, options)
		end
	end

	def select(name, values, options={}, h_options={})
		n = h_options[:label].to_s.titleize
		h_options.delete(:label)
		wrapper({label: n}) do
			super(name, values, options, h_options)
		end
	end

	def wrapper(options={}, &block)
		content_tag(:div, class: "form-group") do

			label(:name, options[:label], class: "col-sm-2 control-label") +

			content_tag(:div, capture(&block), class: "col-sm-10")
		end
	end
	def errors_on?(attribute)
		object.errors[attribute].size > 0
	end
	def errors_for_field(attribute, options={})
		return "" if object.errors[attribute].empty?
		content_tag(:p, object.errors[attribute].to_sentence.capitalize, class: "text-danger")
	end
end