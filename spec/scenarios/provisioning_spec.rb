
require_relative '../pages/login/login'
require_relative '../pages/main/home'
require_relative '../pages/login/reset_password'


describe('User provisioning', :user_provisioning) do
  before(:all) do
    # remover usuário no banco de dados
    # mongodb://usuario:senha@servidor:porta/banco_de_dados
  end

  describe('provisioning an setup', :provisioning) do
    it('Provisioning add setup') do |e|
      e.step('when when I provisioning a new setup') do
        puts 'when when I provisioning a new setup'
        provisioning
        puts "end provisioning"
      end
=begin
      e.step('then I should see this setup on the R!') do
        puts 'and I fill the setup and password to login'
        login_page.load
        login_page.do_login(get_admin())
      end
      e.step('then I can see the home page') do
        puts 'then I can see the home page'
        # wait for load home page
        home.wait_until_home_features_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
      end
      e.step('and I log out from application') do
        puts 'and I log out from application'
        sleep 3
        home.logout
      end
=end
    end

  end
=begin

  describe('Login Validations', :login_validations) do
    before do
      @users1 = {
          username: '',
          password: '123456asd'
      }
      @users2 = {
          username: 'devmarcelo.user1@ringbyname.com',
          password: ''
      }
      @users3 = {
          username: 'devmarcelo.setup@ringbyname.com',
          password: '123456asd'
      }
      @users4 = {
          username: 'devmarcelo.user1@ringbyname.com',
          password: '123456'
      }

    end
    it('Login message validations') do |e|
      e.step('when I access login page') do
        puts '  when I access login page'
        login_page.load
      end
      e.step('when I try to login with empty username') do
        puts '  when I try to login with empty username'
        expect(page).to have_content('Sign In')
        login_page.do_login(@users1)
      end
      e.step('then I have to see the validation message') do
        puts '  then I have to see the validation message'
        login_page.has_message?
        expect(page).to have_css('.alert-danger')
        expect(login_page.message.text).to eql '"Username": Value is required and can\'t be empty'
        login_page.close_message.click
      end
      e.step('when I try to login with empty password') do
        puts '  when I try to login with empty password'
        login_page.do_login(@users2)
      end
      e.step('then I have to see the validation message') do
        puts '  then I have to see the validation message'
        login_page.has_message?
        expect(page).to have_css('.alert-danger')
        expect(login_page.message.text).to eql '"Password": Value is required and can\'t be empty'
        login_page.close_message.click
      end
      e.step('when I try to login with wrong username') do
        puts '  when I try to login with wrong username'
        login_page.do_login(@users3)
      end
      e.step('then I have to see the validation message') do
        puts '  then I have to see the validation message'
        login_page.has_message?
        expect(page).to have_css('.alert-danger')
        expect(login_page.message.text).to eql 'Sorry, you have entered invalid credentials. Please try again.'
        login_page.close_message.click
      end
      e.step('when I try to login with wrong password') do
        puts ' when I try to login with wrong password'
        login_page.do_login(@users4)
      end
      e.step('then I have to see the validation message') do
        puts '  then I have to see the validation message'
        login_page.has_message?
        expect(page).to have_css('.alert-danger')
        expect(login_page.message.text).to eql 'Sorry, you have entered invalid credentials. Please try again.'
        login_page.close_message.click
      end
    end
  end
=end
  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
  end
end