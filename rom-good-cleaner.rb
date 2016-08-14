#!/usr/bin/ruby

require 'optparse'

filename = ''
replace = true
options = OptionParser.new do |opts|
	opts.banner = "Usage: swift-make-all-public.rb [options]"

	opts.on("-i", "--input-filename=NAME", "Input filename") do |name|
		filename = name
	end
	opts.on("-n", "--not-replace", "Input filename") do |name|
		replace = false
	end
	opts.on("-h", "--help", "Prints this help") do
		puts opts
		exit
	end
end

options.parse!
if filename == ''
	puts "Missing filename.\n---\n"
	puts options
	exit
end

preferred_codes = ['[!]', '[c]']
preferred_regions = ['(E)', '(U)']

filenames = Dir["#{filename}/*.zip"]
# puts "Processing '#{filenames}'..."
filenames.each do |name|
	# p name.scan(/\(.+?\)/)
	# p name.scan(/\[.+?\]/)
	short_name = name.split(/\(/).first
	# short_name = short_name.sub /\(.+?\)/, ''
	# short_name = short_name.sub /\[.+?\]/, ''
	# p short_name
	names = []
	filenames.each do |name2|
		names.push(name2) if name2.start_with?(short_name)
	end
	preferred_name = ''
	names.each do |name2|
		regions = name2.scan(/\(.+?\)/)
		codes = name2.scan(/\[.+?\]/)
		if (codes.include? '[!]') && (regions.include? "(U)")
			preferred_name = name2
			break
		elsif (codes.include? '[!]') && (regions.include? "(E)")
			preferred_name = name2
			break
		elsif (codes.include? '[!]') && (regions.include? "(UE)")
			preferred_name = name2
			break
		elsif (codes.include? '[!]') && (regions.include? "(A)")
			preferred_name = name2
			break
		elsif (codes.include? '[!]') && (regions.include? "(C)")
			preferred_name = name2
			break
		elsif (codes.include? '[!]') && ((regions.include? "(JUE)") || (regions.include? "(UEJ)") || (regions.include? "(UJE)") || (regions.include? "(EUJ)") || (regions.include? "(JEU)") || (regions.include? "(EJU)"))
			preferred_name = name2
			break
		elsif (codes.include? '[!]') && ((regions.include? "(JU)") || (regions.include? "(UJ)") || (regions.include? "(JE)") || (regions.include? "(EJ)"))
			preferred_name = name2
			break
		elsif (codes.include? '[!]') && (regions.include? "(Unl)")
			preferred_name = name2
			break
		elsif regions.include? "(J)"
			# puts "skipping #{name2}..."
		elsif regions.include? "(F)"
			# puts "skipping #{name2}..."
		elsif (codes.include? '[!]')
			preferred_name = name2
			break
		elsif (codes.include? '[a1]')
			preferred_name = name2
			break
		elsif (codes.include? '[a2]')
			preferred_name = name2
			break
		elsif (codes.include? '[c]')
			preferred_name = name2
			break
		elsif (codes.include? '[b1]')
			# puts "skipping #{name2}..."
		elsif (codes.include? '[b2]')
			# puts "skipping #{name2}..."
		elsif (codes.include? '[b3]')
			# puts "skipping #{name2}..."
		elsif (codes.include? '[b4]')
			# puts "skipping #{name2}..."
		elsif (codes.include? '[h1]')
			# puts "skipping #{name2}..."
		elsif (codes.include? '[h2]')
			# puts "skipping #{name2}..."
		elsif (codes.include? '[h3]')
			# puts "skipping #{name2}..."
		elsif (codes.include? '[h4]')
			# puts "skipping #{name2}..."
		elsif (codes.include? '[h5]')
			# puts "skipping #{name2}..."
		elsif codes.count == 0
			preferred_name = name2
			break
		elsif (regions.include? '(beta)')
			# puts "skipping #{name2}..."
		elsif (regions.include? '(Beta)')
			# puts "skipping #{name2}..."
		elsif (regions.include? '(Pre-Release)')
			# puts "skipping #{name2}..."
		else
			# p name2
		end
	end
	if preferred_name == ''
		# puts "---- Processing '#{name}'..."
		# puts names
	else
		 puts "mv \"#{preferred_name}\" ~/tmp/"
	end
end