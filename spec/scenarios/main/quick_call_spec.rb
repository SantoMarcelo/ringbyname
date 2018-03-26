require_relative '../../pages/login/login'
require_relative '../../pages/main/home'
require_relative '../../pages/main/features/quick_call/quick_call'
require_relative '../../sections/main/features/quick_call'

 #require 'Mysql2'

describe('validate quick call feature', :home_quick_call_feature) do
  before do
    login_page.load
    login_page.do_login($admin_user)
   
    home.wait_until_home_menu_visible
    home.wait_until_user_status_visible
    visit ('#!/app/calls')
    
    # user_mysql = 'devroot'
    # pass_mysql = 'testtest'
    # host_mysql = 'mysql.marcelo-php56.dev.ringbyname.com'
    # database_mysql = 'ringbyname'

    # db = Mysql.new(user_mysql, pass_mysql, host_mysql)
    # db_select = db.select_db(database_mysql)
    # sql_query = db.query('SELECT * FROM crm_opportunity')
    # listar = sql_query.fetch_fields
    # listar.each do |lista|
    #   puts lista.name 
    # end
  end
  describe('validate recent call list', :call_list) do
    it('validate recent calls', :recent_calls) do |e|
      puts 'validate recent calls'
      @user = {name: 'DEV UAT',
        phone: '12065081444',
        type: 'work'}
        @user2 = {name: 'Test Contact 3',
          phone: '2065081444',
          type: 'work'}
      # e.step('when I on home page') do
      #   puts 'when I on home page'
      #   expect(page.text.include?('Call Presence'))
      # end
      e.step('and I access a quick call page') do
        puts 'and I access a quick call page'
        quick_call.recent_calls.wait_for_call_list
        expect(quick_call.recent_calls.page_title.text).to eql 'Calls List'
      end
      e.step('and I check the recent call list') do
        puts 'and I check the recent call list'
       # expect(quick_call.validate_call_list(@user, 'department-callback')).to eql true
        expect(quick_call.validate_call_list(@user2, 'incoming-external-call')).to eql true
      #   expect(quick_call.validate_call_list(@user, 'outgoing-external-call')).to eql true
      #   expect(quick_call.validate_call_list(@user, 'voicemail-insert')).to eql true
      #   expect(quick_call.validate_call_list(@user, 'activity-callback')).to eql true
      #   expect(quick_call.validate_call_list(@user, 'department-voicemail')).to eql true
       end
      e.step('when I try to mark as read an call item') do
        puts 'when I try to mark as read an call item'
        puts quick_call.recent_calls.mark_as_read.length
        quick_call.mark_as_read(@user2, 'incoming-external-call')
        sleep 10
      end
      # e.step('then I should see the call item marked as read') do
      #   puts 'then I should see the call item marked as read'
      #   #quick_call.wait_for_confirm_mark_as_read
      #   expect(home.message.text).to eql 'Activity marked as read'
      #   sleep 3
      #   #quick_call.check_mark_as_read(@user2, 'incoming-external-call')
      # end
      # e.step('when I try to dial by ') do
      # end
    end
    it('validate dial box', :dial_box) do |e|
      puts 'validate dial box'
      number_to_dial = 1234567890
      e.step('when I on home page') do
        puts 'when I on home page'
        expect(page.text.include?('Call Presence'))
      end
      e.step('and I access a quick call menu') do
        puts 'and I access a quick call menu'
        quick_call.home_menu.quick_call.click
        quick_call.recent_calls.wait_for_call_list
      end
      e.step('and I select dial box') do
        puts 'and I select dial box'
        quick_call.recent_calls.btn_dial_box.click
      end
      e.step('when I type a number to dial')do
        puts 'when I type a number to dial'
        quick_call.type_number_to_dial(number_to_dial)
      end
      e.step('then I can see the number in the number box')do
        puts 'then I can see the number in the number box'
        expect(quick_call.dial_pad.txt_phone_dial.value).to eql number_to_dial.to_s
      end
      e.step('when I eraser filled data')do
        puts 'when I eraser filled data'
        quick_call.eraser_data
      end
      e.step('then I can see the empty field')do
        puts 'then I can see the empty field'
        expect(quick_call.dial_pad.txt_phone_dial.value.empty?).to eql true
      end
      e.step('when I try to dial with empty field')do
        puts 'when I try to dial with empty field'
        quick_call.dial_pad.txt_phone_dial.set("")
        quick_call.dial_pad.btn_dial.click
      end
      e.step('then I can see the validation message')do
        puts 'then I can see the validation message'
        expect(quick_call.message.text).to eql 'Phone Number: Value is required and can\'t be empty'
      end
      e.step('when I try to dial with special caracters')do
        puts 'when I try to dial with special caracters'
        validate_number_to_dial = '**#*##'
        quick_call.type_number_to_dial(validate_number_to_dial)
        quick_call.dial_pad.btn_dial.click
      end
      e.step('then I can see the validation message')do
        puts 'then I can see the validation message'
        expect(quick_call.message.text).to eql 'Phone Number: Value is required and can\'t be empty'
        quick_call.eraser_data
      end
      e.step('when I dial by dial box')do
        puts 'when I dial by dial box'
        quick_call.type_number_to_dial(number_to_dial)
        quick_call.dial_pad.btn_dial.click
      end
      e.step('then I can see the confirmation message')do
        puts 'then I can see the confirmation message'
        expect(quick_call.message.text).to eql 'Connecting you now'
      end
      
    end
  end
end