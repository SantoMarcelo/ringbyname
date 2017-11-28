

require_relative 'pages/login_page'
require_relative 'pages/home_page'

describe('Login in application', :inprogress) do
  before(:all) do
    # remover usuário no banco de dados
    # mongodb://usuario:senha@servidor:porta/banco_de_dados
  end

  describe('Success login' ) do
    it('login with admin user') do |e|
      
      e.step 'when I access login page' do
        login_page.load
      end

      e.step'and I fill the user and password to login' do
        login_page.do_login('devqc.user4@ringbyname.com', '123456asd')
      end

      e.step 'the I can see the home page' do
        expect(page.title).to eql "RingByName"
      end
    end
  end

  describe('Login Validations') do
    it('validate empty user') do |e|

      e.step 'when I access login page' do
        login_page.load
      end
      
      e.step 'and I don´t fill the username and try to login' do
        login_page.do_login('', '123456asd')
      end
 
      e.step 'then I can see the validation message' do
        expect(login_page.message.text).to eql ("× Sorry, that account is invalid. Please try again.")
      end
    end

    it('validate empty password') do |e|
      
      e.step 'when I access login page' do
        login_page.load
      end
            
      e.step 'when I don´t fill the password and try to login' do
        login_page.do_login('devqc.user4@ringbyname.com', '')
      end
      
      e.step 'then I can see the validation message' do
        expect(login_page.message.text).to eql ("× Sorry, the requested information could not be found.")
      end

    end

    it('validate incorrect user') do |e|
      
      e.step 'when I access login page' do
        login_page.load
      end
            
      e.step 'when I try to login with a incorrect user' do
        login_page.do_login('devqc.user@ringbyname.com', '123456asd')
      end
      
      e.step 'then I can see the validation message' do
        expect(login_page.message.text).to eql ("× Sorry, that account is invalid. Please try again.")
      end

    end

    it('validate incorrect password') do |e|
      
      e.step 'when I access login page' do
        login_page.load
      end
            
      e.step 'when I try to login with incorrect password' do
        login_page.do_login('devqc.user4@ringbyname.com', '123456')
      end
      
      e.step 'then I can see the validation message' do
        expect(login_page.message.text).to eql ("× Sorry, the requested information could not be found.")
      end

    end

  end

    

  after(:each) do |e|
    e.attach_file('screenshot', get_screenshot)
    Capybara.current_session.driver.quit
  end

end
 
# # Você precisa informar seu email.
# Você precisa informar uma senha.
# select elemento from html where tipo=input
# and name='registerPassword'

# $('tipo_do_lemento[atributo=valor]');

# $('input[name=registerPassword]');

# <div name="registerPassword">
# <input name="registerPassword">

# ID dinamico => regex ou expressão regular
# * => busca um elemento que contem o valor
# $ => termina com
# ^ => começa com
# $('button[id*=signup]');
