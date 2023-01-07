class ApplicationController < ActionController::Base
    
    private
        def admin
            kanri="takaaki"
            return kanri
        end
        helper_method :admin

end
