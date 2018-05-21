module StringExtension
	def to_regex
		slashes = self.gsub(/\\\//,'').count ?/
		if (slashes != 2)
			return /#{Regexp.quote self}/
		end
		return nil  unless (self.match? /\A\/.+\/[xim]*\z/)
		string, options_str = self.match(/\A\/(.+)\/(.?+)\z/).to_a[1 .. -1]
		options = (
			(options_str.include?(?x) ? Regexp::EXTENDED   : 0) |
			(options_str.include?(?i) ? Regexp::IGNORECASE : 0) |
			(options_str.include?(?m) ? Regexp::MULTILINE  : 0)
		)
		options = nil  if (options == 0)
		return Regexp.new(string, options)
	end
end

class String
	include StringExtension
end
