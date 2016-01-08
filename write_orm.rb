# Kyle McCloskey - Bare ORM 
class User
	# create db homeworktest
	# Before using this code, have this table setup in DB
	# CREATE TABLE users(
	# id serial PRIMARY KEY,
	# 	fname VARCHAR(50),
	# 	lname VARCHAR(50),
	# 	email VARCHAR(50)
	# );
	attr_accessor :fname, :lname, :email

	def initialize(fname="", lname="", email="")
		@fname = fname
		@lname = lname
		@email = email
	end

	# Used to create a new users in the database
	def self.save(fname="", lname="", email="")
		@fname = fname
		@lname = lname
		@email = email
		# Takes the arguements passed into save and adds them into the database by arg value
		`psql -d homeworktest -c "INSERT INTO users (fname, lname, email) VALUES ('#{@fname}', '#{@lname}', '#{@email}')"`
		puts "You created a new User"
	end

	# Used to find a user by id
	def self.find(id)
		# searches the database who's id is = to the arguement entered
		command = `psql -d homeworktest -c "SELECT * FROM users WHERE id = #{id}"`
		# sets the result to x
		x = sql_results_parser(command)
		# returns x
		x[0]
	end

	# Searches for a user by their first name
	def self.where(fname)
		command = `psql -d homeworktest -c "SELECT * FROM users WHERE fname = '#{fname}'"`
		x = sql_results_parser(command)
		x[0]
	end

	# Shows all the users in the database
	def self.all
		command = `psql -d homeworktest -c "SELECT * FROM users"`
		sql_results_parser(command)
	end

	# Shows the last user in the databse
	def self.last
		command = `psql -d homeworktest -c "SELECT users FROM users ORDER BY id DESC LIMIT 1;"`
		x = sql_results_parser(command)
		x[0]
	end

	# Shows the first user in the database
	def self.first
		command = `psql -d homeworktest -c "SELECT users FROM users ORDER BY id ASC LIMIT 1;"`
		x = sql_results_parser(command)
		x[0]
	end

	#Deletes all users from the database
	def self.destroy_all
		`psql -d homeworktest -c "DELETE FROM users"`
		puts "You've deleted all users from the database"
	end

	#Deletes a user by it's id
	def self.destroy(id)
		# searches the database who's id is = to the arguement entered
		`psql -d homeworktest -c "DELETE FROM users WHERE id = #{id}"`
		puts "You deleted User# #{id}"
	end

	# All other commands feed to this method to parse the information
	def self.sql_results_parser(command)
		# Goes through each line of how the table would be represented in the console by \n
		# Sets the variable array1 to an empty array that will be filled later
		array1 = []

		# Sets num to zero
		num = 0
		# Loops through the results fed in from the SQL Command
		command.each_line do |line|
			# Increments num from 0 to 1 and will continue with each loop through
			num += 1
			# Removes the pipes and replaces them with nothing
			line.gsub!('|', '')
			# sets variable @a to line.split breaking each individual string apart and putting it on the next line
			@a = line.split
			# if the num is < 3 and the length of @a is less then four skip and go to the next line
			if num < 3 || @a.count < 4
				# Skips the next line
				next
			end
			# sets the variable u to the contents of it's index (fname, lname, email)
	      	u = User.new(@a[1], @a[2], @a[3])
	       	array1.push(u)
	        end
	    return array1
	end
end