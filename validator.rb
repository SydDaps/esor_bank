module Validate
  def take_phone_number
    age = 0
    valid = false
    until valid == true do
      puts "  Enter Phone number :"
      age = gets 
      number = age.chomp.match(/\D+/)
      if number == nil and age.chomp.length == 10
        return age.chomp
        valid = true
      else
        puts "please check number and enter again!"
        next
      end
    end
  end

  def take_age 
    age = 0
    valid = false
    until valid == true do
      puts "  Enter Age:"
      age = gets 
      number = age.chomp.match(/\D+/)
      if number == nil
        return age.chomp
        valid = true
      else
        puts "Invalid input check and enter again!"
        next
      end
    end
  end

  def take_pin
    pin_1 = 0
    pin_2 = 0
    valid = false
    until valid == true do
      puts "Enter pin :"
      pin_1 = gets 
      puts "Confirm pin :"
      pin_2 = gets 
    
      if pin_1.chomp == pin_2.chomp
        return pin_1.chomp
        valid = true
      else
        puts "Pins do not match enter again!"
        next
      end
    end
  end
end