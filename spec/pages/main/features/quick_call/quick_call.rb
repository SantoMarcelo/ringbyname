require_relative '../../../../sections/main/features/quick_call'

class QuickCall < Home

  section :recent_calls, Sections::QuickCall, '.rbn-dropdown-content'
  section :dial_pad, Sections::QuickCall, '.dial-pad-container'


  def type_number_to_dial(number)
    number_to_dial = number.to_s.split(//)
    number_to_dial.each do |n|
      dial_pad.dial_pad_numbers.each do |u|
        u.click if u.text.include?(n)
      end
    end
  end

  def eraser_data
    number = dial_pad.txt_phone_dial.value.to_s
    i=0
    while i<number.length do
      dial_pad.btn_eraser.click
      i +=1
    end
  end

  def validate_call_list(user)
    recent_calls.call_list.each do |u|
      # true if u.text.include?(user[:name])  
      # break
      puts user
      puts "######"
      puts u.text
      true if u.text.include?(user)  
      
    end
    false
  end
end