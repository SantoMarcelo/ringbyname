require_relative '../../../../pages/login/login'
require_relative '../../../../pages/main/home'
require_relative '../../../../pages/main/features/quick_call/quick_call'
require_relative '../../../../sections/main/features/quick_call'

 #require 'Mysql2'
        #:quick_call
describe('validate quick call feature', :quick_call) do
  before do
    
    system("mysql -h mysql.#{$environment}-php56.dev.ringbyname.com -u devroot -ptesttest -f < sql/insert_activities.sql")
    puts $?

    login_page.load
    login_page.do_login(get_admin())
    home.wait_until_home_features_visible
    home.wait_until_user_status_visible
    visit '#!/app/calls'
    # insert activities
    
  
  end
  describe('validate recent call list and dial pad', :call_list) do
    it('validate recent calls', :recent_calls) do |e|
      puts 'validate recent calls'
      @contact1 = {
        name: 'Test Contact 1',
        phone1: '12065081444',
        phone2: '2065081444',
        type: 'work'
      }
      @contact2 = {
        name: 'Test Contact 2',
        phone1: '2065081444',
        phone2: '12065081444',
        type: 'work'
      }
      @contact3 = {
        name: 'Test Contact 3',
        phone1: '12065081444',
        phone2: '2065081444',
        type: 'work'
      }
      e.step('when I on home page') do
        puts 'when I on home page'
        expect(page.text.include?('Call Presence'))
      end
      e.step('and I access a quick call page') do
        puts 'and I access a quick call page'
        quick_call.recent_calls.wait_for_call_list
        expect(quick_call.recent_calls.page_title.text).to eql 'Recent calls'
      end
      e.step('and I check the recent call list') do
        puts 'and I check the recent call list'
        expect(quick_call.validate_call_list(@contact1, 'outgoing-external-call')).to eql true
        expect(quick_call.validate_call_list(@contact1, 'activity-voicemail-insert')).to eql true
        expect(quick_call.validate_call_list(@contact1, 'incoming-external-call')).to eql true
        expect(quick_call.validate_call_list(@contact1, 'activity-callback-insert')).to eql true

        expect(quick_call.validate_call_list(@contact2, 'incoming-missed-call')).to eql true
        expect(quick_call.validate_call_list(@contact2, 'activity-voicemail-insert')).to eql true
        expect(quick_call.validate_call_list(@contact2, 'incoming-external-call')).to eql true

        expect(quick_call.validate_call_list(@contact3, 'incoming-missed-call')).to eql true
        expect(quick_call.validate_call_list(@contact3, 'incoming-external-call')).to eql true
        expect(quick_call.validate_call_list(@contact3, 'activity-voicemail-insert')).to eql true
      end
      e.step('when I try to mark as read an call item') do
        puts 'when I try to mark as read an call item'
        quick_call.mark_as_read(@contact1, 'activity-voicemail-insert')
      end
      e.step('then I should see the call item marked as read') do
        puts 'then I should see the call item marked as read'
        expect(home.message.text).to eql 'Activity marked as read'
        expect(quick_call.check_mark_as_read(@contact1, 'activity-voicemail-insert')).to eql false
        home.wait_until_message_invisible
      end
      e.step('when I try to dial by call list') do
        puts 'when I try to dial by call list'
        quick_call.do_call(@contact2, 'activity-voicemail-insert')
      end
      e.step('then I can see the confirmation message')do
        puts 'then I can see the confirmation message'
        home.wait_for_message
        expect(home.message.text).to eql 'Connecting you now'
        home.wait_until_message_invisible
      end
    end
    it('validate dial box', :dial_box) do |e|
      puts 'validate dial box'
      number_to_dial = 1234567890
      e.step('and I access a quick call page') do
        puts 'and I access a quick call page'
        quick_call.recent_calls.wait_for_call_list
        expect(quick_call.recent_calls.page_title.text).to eql 'Recent calls'
      end
      e.step('and I select dial box') do
        puts 'and I select dial box'
        quick_call.recent_calls.btn_dial_box.click
      end
      e.step('when I type a number to dial') do
        puts 'when I type a number to dial'
        quick_call.type_number_to_dial(number_to_dial)
      end
      e.step('then I can see the number in the number box') do
        puts 'then I can see the number in the number box'
        expect(quick_call.dial_pad.txt_phone_dial.value).to eql number_to_dial.to_s
      end
      e.step('when I eraser filled data') do
        puts 'when I eraser filled data'
        quick_call.eraser_data
      end
      e.step('then I can see the empty field') do
        puts 'then I can see the empty field'
        expect(quick_call.dial_pad.txt_phone_dial.value.empty?).to eql true
      end
      e.step('when I try to dial with empty field') do
        puts 'when I try to dial with empty field'
        quick_call.dial_pad.txt_phone_dial.set('')
        quick_call.dial_pad.btn_dial.click
      end
      e.step('then I can see the validation message') do
        puts 'then I can see the validation message'
        expect(quick_call.message.text).to eql 'Phone Number: Value is required and can\'t be empty'
      end
      e.step('when I try to dial with special caracters') do
        puts 'when I try to dial with special caracters'
        validate_number_to_dial = '**#*##'
        quick_call.type_number_to_dial(validate_number_to_dial)
        quick_call.dial_pad.btn_dial.click
      end
      e.step('then I can see the validation message') do
        puts 'then I can see the validation message'
        expect(quick_call.message.text).to eql 'Phone Number: Value is required and can\'t be empty'
        quick_call.eraser_data
      end
      e.step('when I dial by dial box') do
        puts 'when I dial by dial box'
        quick_call.type_number_to_dial(number_to_dial)
        quick_call.dial_pad.btn_dial.click
      end
      e.step('then I can see the confirmation message') do
        puts 'then I can see the confirmation message'
        expect(quick_call.message.text).to eql 'Connecting you now'
      end
      e.step('when I try to tap a number and press Enter to dial') do
        puts 'when I try to tap a number and press Enter to dial'
        quick_call.type_number_to_dial(number_to_dial)
        quick_call.dial_pad.txt_phone_dial.send_keys :enter
      end
      e.step('then I can see the confirmation message') do
        puts 'then I can see the confirmation message'
        expect(quick_call.message.text).to eql 'Connecting you now'
      end
    end
    after do
      Capybara.current_session.driver.quit
    end
  end
end