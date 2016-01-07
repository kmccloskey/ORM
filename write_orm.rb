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
end

def save
	`psql -d homeworktest -c "INSERT INTO users (fname, lname, email) VALUES ('#{@fname}', '#{@lname}', '#{@email}')"`
end

def self.find(id)
	command = `psql -d homeworktest -c "SELECT * FROM users WHERE id = #{id}"`
	puts sql_results_parser(command)
end

def self.where(fname)
	command = `psql -d homeworktest -c "SELECT * FROM users WHERE fname = '#{fname}'"`
	puts sql_results_parser command
end

def self.all
	command = `psql -d homeworktest -c "SELECT * FROM users"`
	puts sql_results_parser(command)
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
		# Goes through each line of how the table would be represented in the console by \n
		# Sets num to zero
		num = 0
		# Sets the variable array1 to an empty array that will be filled later
		array1 = []
		# Loops through the results fed in from the SQL Command
		command.each_line do |line|
			# Increments num from 0 to 1 and will continue with each loop through
			num += 1
			# Removes the pipes and replaces them with nothing
			line.gsub!('|', '')
			# sets variable @a to line.split breaking each individual string apart and putting it on the next line
			@a = line.split
			# if the num is < 3 and the length of @a is less then four skip and go to the next line
			if num < 3 || @a.count <4
				# Skips the next line
				next
			end
			# sets the variable u to the contents of it's index (fname, lname, email)
       		u = User.new(@a[1], @a[2], @a[3])
       		# prints all three
       		# puts u.fname
       		# puts u.lname
       		# puts u.email
       		save(u)
       		array1.push(line)
        end
        puts array1
        return nil
    	
    end

end