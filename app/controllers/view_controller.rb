class ViewController < ApplicationController
	before_filter :get_facebook_data
  
  def show
    
	end

  private
	def base64_url_decode(str)
    str += '=' * (4 - str.length.modulo(4))
    Base64.decode64(str.tr('-_','+/'))
  end
  
  def get_facebook_data
    if params[:fake]
      @fbdata = {
        "page" => {
          "liked" => (params[:liked] == "true")
        }
      }
    else
      @fbdata = JSON.parse(base64_url_decode(params[:signed_request].split('.')[1]))
    end
    @liked = @fbdata["page"]["liked"]
  end
end
