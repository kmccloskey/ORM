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
		return sql_results_parser command
	end

	def self.sql_results_parser(command)
		# Goes through each line of how the table would be represented in the console by \n
		num = 0
		command.each_line do |line|
        # prints the line then moves to the next one it will do this for each line
        line.gsub!('|', '')
       		if num == 4
        		@a = line.split
        		puts @a
        	end
    	num += 1
 	    end
    	u = User.new(fname:@a[1], lname:@a[2], email:@a[3])
    	puts u
	end

end