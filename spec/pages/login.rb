
class Login < SitePrism::Page

    
    set_url $url
    element :txt_user, 'input[data-ng-model="data.username"]'
    element :txt_password, 'input[data-ng-model="data.password"]'
    element :btn_submit, 'button[data-ng-click="login($event)"]'
    element :link_reset_pass, 'a[ui-sref="auth.reset-password"]'
    element :message, '.alert-danger'

    def do_login(user, password)
       self.txt_user.set user
       self.txt_password.set password
       self.btn_submit.click
    end

    def access_reset_page 
        self.link_reset_pass.click
    end

end

# tipo de Padrão de projeto => Page Object