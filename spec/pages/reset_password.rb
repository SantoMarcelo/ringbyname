
class Reset_Password < SitePrism::Page
    element :txt_reset_email, 'input[data-ng-model="data.email"]'
    element :btn_reset, 'button[data-ng-click="resetPassword($event)"]'
    element :link_cancel, 'a[ui-sref="auth.login"]'
    element :message, '.alert-success p.nomargin'

    def do_reset(email)
        self.txt_reset_email.set email
        self.btn_reset.click 
    end

    def cancel_reset_password 
        self.link_cancel.click
    end

end

