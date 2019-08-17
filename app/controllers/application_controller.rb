class ApplicationController < ActionController::API
  before_action :set_current_user, except: [:fallback_index_html]
  before_action :authorize, except: [:fallback_index_html]

  def issue_token(payload)
      JWT.encode(payload, ENV['RAILS_SECRET'])
  end

  def decode_token(token)
      JWT.decode(token, ENV['RAILS_SECRET'])[0]
  end

  def get_token
      token = request.headers["Authorization"] || request.headers["Authorisation"]
      token == 'null' ? nil : token
  end

  def set_current_user
    token = get_token
    if token && token != 'null'
        decoded_token = decode_token(token)
        @current_user = User.find(decoded_token["user_id"])
    else 
        @current_user = nil
    end
  end

  def fallback_index_html
    render :file => 'public/index.html'
  end

  def logged_in
      !!@current_user
  end

  def authorize
      if !logged_in
          return render json: { error: 'you must be logged in'}, status: :unauthorized
      end
  end

  def fallback_index_html
    render :file => 'public/index.html' 
  end
  
end
