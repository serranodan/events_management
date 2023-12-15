# Rails Guide

# Open rails server
rails server

# Open rails console
rails console

# Return multiple records
User.all
User.where(student: 'student')

# Delete all record
User.all.destroy_all

# Return 1 record
User.first
User.last
User.find(1)
User.find_by(email: 'student@example.com')

# Delete 1 record
User.find(1).destroy

# Add column to table
rails g migration add_status_to_reservations
rails db:migrate
# Restart server after migration

# Revert migration
rails db:rollback


# Reset database
# Note: shutdown server, exit console and disconnect pgAdmin server
rails db:reset

# pgAdmin location
Development -> Databases -> Schemas -> Tables
  -> Right Click Table -> View Edit/Data -> All rows
