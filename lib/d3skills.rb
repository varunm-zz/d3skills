require "d3skills/version"
require 'open-uri'

module D3skills
	def self.get_skills(hero_type, level)
		name = hero_type      #"Barbarian"
		hero_level = level      #"55"
		page = Nokogiri::HTML(open("http://www.diablowiki.net/" + name + "_skills"))

		skills = {}


		page.css('table').each do |table|
			unless table.nil?

				## finds the tables with 4 columns
				if table.css('tr').css('td').length == 4

					## The skill name is usually the title of first link (which is an image) in the row
					name = table.css('tr').css('a')[0]['title'].strip

					## The level is found in the text of the third table data in the row
					level = table.css('tr').css('td')[2].text.strip

					# make a new array if this skill level has been encountered for the first time
					skills[level] = [] if skills[level].nil?

					skills[level] << name
				end
			end
		end
		skills_unlocked = skills[hero_level]
		if skills_unlocked == nil
			puts "No skill unlocked"
		else
			puts skills_unlocked
		end
	end
end
