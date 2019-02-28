

require_relative '../pages/login/login'
require_relative '../pages/main/home'
require_relative '../pages/login/reset_password'
# :full_login
describe('Login in application', :master) do
  before(:all) do
    # remover usuário no banco de dados
    # mongodb://usuario:senha@servidor:porta/banco_de_dados
  end

  describe('Success login', :success_login) do
    it('login with admin setup') do |e|
      e.step('when I access login page') do
          puts 'when I access login page'
        login_page.load
      end
      e.step('and I fill the setup and password to login') do
        puts 'and I fill the setup and password to login'
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
    end

  end

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
  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
  end
end

describe('Reset Password', :Reset_password) do
  before do
        @user1 = get_admin()
  end
  describe('Success to try reset password',:success_reset_password) do
    it('success reset password') do |e|
      e.step('when I access the reset password page') do
        puts '  when I access the reset password page'
        login_page.load
        login_page.access_reset_page
      end
      e.step('and I fill the setup email and click in reset') do
        puts '  and I fill the setup email and click in reset'
        reset.do_reset(@user1[:email])
      end
      e.step('then I see the success message') do
        puts '  then I see the success message'
        expect(reset.message.text).to eql "× Password reset, email sent to: #{@user1[:email]}"
      end
      e.step('and I have to login with new password') do
        puts '  and I have to login with new password'
        new_password = get_reseted_password()
        @user1[:password] = new_password
        login_page.load
        login_page.do_login(@user1)
        home.wait_until_home_features_visible
        home.wait_until_user_status_visible
        expect(page).to have_content('Call Presence')
      end
    end
    after() do
      Capybara.current_session.driver.quit
    end
  end
  describe('Reset password validations', :reset_password_validations) do
    it('validate empty email') do |e|
        e.step('when I acces th reset password page') do
          puts 'when I acces th reset password page'
          login_page.load
          login_page.access_reset_page
        end
  
        e.step('and dont fill the email field') do
          puts 'and dont fill the email field'
          reset.do_reset(' ')
        end
  
        e.step('the I can see the correct validation message') do
          puts 'the I can see the correct validation message'
          expect(reset.message.text).to eql '× Please enter a valid e-mail address.'
        end
    end
    it('validate invalid email') do |e|
        e.step('when I acces th reset password page') do
          puts 'when I acces th reset password page'
          login_page.load
          login_page.access_reset_page
        end
  
        e.step('and I fill invalid email') do
          puts 'and I fill invalid email'
          reset.do_reset('devmarcelo.setup@ringbyname.coim ')
        end
  
        e.step('the I can see the correct validation message') do
          expect(reset.message.text).to eql '× Sorry, that e-mail address is invalid. Please try again.'
        end
    end
    it('validate incorrect email') do |e|
        e.step('when I acces th reset password page') do
          login_page.load
          login_page.access_reset_page
        end
  
        e.step('and I fill incorrect email') do
          reset.do_reset('devmarcelo.setup@ringbyname.com ')
        end
  
        e.step('the I can see the correct validation message') do
          expect(reset.message.text).to eql '× Sorry, that setup name cannot be found. Please try again.'
        end
    end
  end
  describe('Cancel password reset', :cancel_reset_password) do
    it('validate cancel password reset') do |e|
        e.step('when I acces th reset password page') do
          login_page.load
          login_page.access_reset_page
        end
  
        e.step('and I click in Cancel link ') do
          reset.cancel_reset_password
        end
  
        e.step('the I can return to login page') do
          expect(login_page).to be_displayed
          expect(login_page.current_url).to end_with '/#!/auth/login'
        end
    end
  end
  after() do
    set_user_data( @user1)
  end
end

