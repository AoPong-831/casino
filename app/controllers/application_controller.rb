class ApplicationController < ActionController::Base
    
    private
        def admin#管理者nameの設定
            kanri="takaaki"
            return kanri
        end
        helper_method :admin
        
        def header_user(a)#headerにログイン時のアカウント情報を載せるため
            user_t = User.find_by(name: a)
            return user_t
        end
        helper_method :header_user

end
