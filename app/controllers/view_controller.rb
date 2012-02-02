class ViewController < ApplicationController
  helper_method :liked?

	before_filter :get_facebook_data

  def show
    logger.info @fbdata.to_s
	end

  private
	def base64_url_decode(str)
    str += '=' * (4 - str.length.modulo(4))
    Base64.decode64(str.tr('-_','+/'))
  end
  
  def get_facebook_data
    return @fbdata if @fbdata
    if params[:signed_request]
      @fbdata = JSON.parse(base64_url_decode(params[:signed_request].split('.')[1]))
    else
      @fbdata = {
        "page" => {
          "liked" => true
        }
      }
    end
  end

  def liked?
    get_facebook_data["page"]["liked"]
  end
end
