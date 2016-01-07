# Kyle McCloskey - Bare ORM 

class User
	# Before using this code, have this table setup in DB
	# CREATE TABLE users(
	# id serial PRIMARY KEY,
	# 	fname VARCHAR(50),
	# 	lname VARCHAR(50),
	# 	email VARCHAR(50)
	# );
attr_accessor :fname, :lname, :email

def initialize(fname="", lname="", email="")
	puts "HELLO"
	@fname = fname
	@lname = lname
	@email = email
	`psql -d homeworktest -c "INSERT INTO users (fname, lname, email) VALUES ('#{fname}', '#{lname}', '#{email}')"`
end

def self.find(id)
	command = `psql -d homeworktest -c "SELECT * FROM users WHERE id = #{id}"`
	puts sql_results_parser command
end

def self.where(fname)
	command = `psql -d homeworktest -c "SELECT * FROM users WHERE fname = '#{fname}'"`
	puts sql_results_parser command
end

def self.all
	command = `psql -d homeworktest -c "SELECT * FROM users"`
	parsed = command.gsub("|", "").gsub("-", "").gsub("+", "")
	@parsed = parsed.split
	array1 = ["id", "fname", "lname", "email"]
	array2 = [@parsed]
		i = 0
	 	for i in 0...parsed.length
	 		array1.each do |x|
	 			puts x
	 		end
	 	end
	 	for i in 4...parsed.length
	 			array2.push(parsed[i])
	 	end
	all_hash = Hash[array1.zip(array2)]
	puts all_hash
end

def self.last
	command = `psql -d homeworktest -c "SELECT users FROM users ORDER BY id DESC LIMIT 1;"`
	puts sql_results_parser command
end

def self.first
	command = `psql -d homeworktest -c "SELECT users FROM users ORDER BY id ASC LIMIT 1;"`
	puts sql_results_parser command
end

def self.sql_results_parser(command)
		# This works on searches that return one item, working in the all method trying to figure out a way to display multiple
		parsed = command.split

		# Creating a variable after splitting the table into strings/an array?
		# We are turning the array1 into a static array that has id, fname, email, datecreated
		array1 = []
		array2 = []
		# The following function?method will go through the parsed table and pull each even string up to half the length of the array?-1
	 	# Then it will push that into an array. It will do the same for the second half which will be the values. 
	 	i = 0
	 	for i in 0...parsed.length/2
	 		if i%2==0
	 			array1.push(parsed[i])
	 		end
	 	end
	 	for i in parsed.length/2...parsed.length
	 		if i%2==0
	 			array2.push(parsed[i])
	 		end
	 	end
		my_hash = Hash[array1.zip(array2)]
		puts my_hash
	end

end
