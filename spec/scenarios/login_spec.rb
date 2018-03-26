

require_relative '../pages/login/login'
require_relative '../pages/main/home'
require_relative '../pages/login/reset_password'

describe('Login in application', :full_login) do
  before(:all) do
    # remover usuário no banco de dados
    # mongodb://usuario:senha@servidor:porta/banco_de_dados
  end

  describe('Success login', :login) do
    it('login with admin user') do |e|
      e.step('when I access login page') do
          puts 'when I access login page'
        login_page.load
      end
      e.step('and I fill the user and password to login') do
        puts 'and I fill the user and password to login'
        login_page.do_login($admin_user)
      end
      e.step('then I can see the home page') do
        puts 'then I can see the home page'
        # wait for load home page
        home.wait_until_home_menu_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
      end
      e.step('and I log out from application') do
        puts 'and I log out from application'
        home.logout
      end
    end
  end

  describe('Login Validations', :login_validations) do
    it('Login message validations') do |e|
      e.step('Given I have a user list and the message list') do
        puts 'Given I have a user list and the message list'
        @users = [
          { username: '', password: '123456asd' },
          { username: 'devmarcelo.user1@ringbyname.com', password: '' },
          { username: 'devmarcelo.user@ringbyname.com', password: '123456asd' },
          { username: 'devmarcelo.user1@ringbyname.com', password: '123456' }
        ]
        @expect_messages = [
          '× "Username": Value is required and can\'t be empty',
          '× "Password": Value is required and can\'t be empty',
          '× Sorry, that account is invalid. Please try again.',
          '× Sorry, the requested information could not be found.'
        ]
      end
      e.step('when I access login page') do
        puts 'when I access login page'
        login_page.load
      end

      e.step('and I validate the validations') do
        puts 'and I validate the validations'
        # login_page.do_login('', '123456asd')
        @validations = []
        @users.each do |u|
          login_page.do_login(u)
          @validations.push login_page.message.text
          login_page.close_message.click
        end
      end

      e.step('then I can see the validation message') do
        puts 'then I can see the validation message'
        expect(@validations).to eql @expect_messages
      end
    end
  end
  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
  end
end

describe('Reset Password', :resetPass) do
  user = 'devqc.user4@ringbyname.com'

  it('success reset password') do |e|
    e.step('when I access the reset password page') do
      puts 'when I access the reset password page'
      login_page.load
      login_page.access_reset_page
    end

    e.step('and I fill the user email and click in reset') do
      puts 'and I fill the user email and click in reset'
      reset.do_reset(user)
    end

    e.step('then I see the success message') do
      puts 'then I see the success message'
      expect(reset.message.text).to eql "× Password reset, email sent to: #{user}"
    end
  end

  describe('Reset password validations') do
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
        reset.do_reset('devmarcelo.user@ringbyname.coim ')
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
        reset.do_reset('devmarcelo.user@ringbyname.com ')
      end

      e.step('the I can see the correct validation message') do
        expect(reset.message.text).to eql '× Sorry, that user name cannot be found. Please try again.'
      end
    end
  end

  describe('Cancel password reset') do
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

  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
  end
end
