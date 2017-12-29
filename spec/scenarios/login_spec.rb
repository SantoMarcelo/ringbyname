

require_relative '../pages/login'
require_relative '../pages/home/home'
require_relative '../pages/reset_password'

describe('Login in application', :inprogress) do
  before(:all) do
    # remover usuário no banco de dados
    # mongodb://usuario:senha@servidor:porta/banco_de_dados
  end

  describe('Success login', :login) do
    it('login with admin user') do |e|
      e.step 'when I access login page' do
        login_page.load
      end

      e.step 'and I fill the user and password to login' do
        login_page.do_login($marcel_admin_user)
      end

      e.step 'then I can see the home page' do
        # wait for load home page
        home.wait_until_home_menu_visible
        expect(login_page.current_url).to end_with '/#!/app/welcome-page'
      end

      Capybara.current_session.driver.quit
    end
  end

  describe('Login Validations', :loginValidations) do
    it('validate empty user') do |e|
      e.step 'when I access login page' do
        login_page.load
      end

      e.step 'and I don´t fill the username and try to login' do
        login_page.do_login('', '123456asd')
      end

      e.step 'then I can see the validation message' do
        expect(login_page.message.text).to eql '× Sorry, that account is invalid. Please try again.'
      end
    end

    it('validate empty password') do |e|
      e.step 'when I access login page' do
        login_page.load
      end

      e.step 'when I don´t fill the password and try to login' do
        login_page.do_login('devmarcelo.user1@ringbyname.com', '')
      end

      e.step 'then I can see the validation message' do
        expect(login_page.message.text).to eql '× Sorry, the requested information could not be found.'
      end
    end

    it('validate incorrect user') do |e|
      e.step 'when I access login page' do
        login_page.load
      end

      e.step 'when I try to login with a incorrect user' do
        login_page.do_login('devmarcelo.user@ringbyname.com', '123456asd')
      end

      e.step 'then I can see the validation message' do
        expect(login_page.message.text).to eql '× Sorry, that account is invalid. Please try again.'
      end
    end

    it('validate incorrect password') do |e|
      e.step 'when I access login page' do
        login_page.load
      end

      e.step 'when I try to login with incorrect password' do
        login_page.do_login('devmarcelo.user1@ringbyname.com', '123456')
      end

      e.step 'then I can see the validation message' do
        expect(login_page.message.text).to eql '× Sorry, the requested information could not be found.'
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
      login_page.load
      login_page.access_reset_page
    end

    e.step('and I fill the user email and click in reset') do
      reset.do_reset(user)
    end

    e.step('then I see the success message') do
      expect(reset.message.text).to eql "× Password reset, email sent to: #{user}"
    end
  end

  describe('Reset password validations') do
    it('validate empty email') do |e|
      e.step('when I acces th reset password page') do
        login_page.load
        login_page.access_reset_page
      end

      e.step('and dont fill the email field') do
        reset.do_reset(' ')
      end

      e.step('the I can see the correct validation message') do
        expect(reset.message.text).to eql '× Please enter a valid e-mail address.'
      end
    end

    it('validate invalid email') do |e|
      e.step('when I acces th reset password page') do
        login_page.load
        login_page.access_reset_page
      end

      e.step('and I fill invalid email') do
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
