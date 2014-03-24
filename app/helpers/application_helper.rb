module ApplicationHelper
  require 'rubygems'
  require 'base64'
  require 'cgi'
  require 'openssl'
  require 'hmac-sha1'


  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def reponse_for(truck)
    @truck.handle
  end



  def uni_get
    url = 'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=chilantrobbq&count=50&exclude_replies=true&include_rts=false'
    nonce = rand(36**32).to_s(36)
    nonce2 = rand(36**32).to_s(36)
    time = ((Time.parse(Time.now.to_s)).to_i).to_s
    # signature_string = CGI.escape('include_entities=true&oauth_consumer_key=#{ENV["TWITTER_APIKEY"]}
    #                         &oauth_nonce=#{nonce2}
    #                         &oauth_signature_method=HMAC-SHA1
    #                         &oauth_timestamp=#{Time.now.to_i}
    #                         &oauth_token=#{ENV["TWITTER_TOKEN"]}
    #                         &oauth_version=1.0')

    # signature_base = 'GET&https%3A%2F%2Fapi.twitter.com%2F1.1%2Fstatuses%2F
    #                   user_timeline.json%3Fscreen_name%3Dchilantrobbq%26count%3D50%26
    #                   exclude_replies%3Dtrue%26include_rts%3Dfalse&' + signature_string

    signature_base = 'GET&https%3A%2F%2Fapi.twitter.com%2F1.1%2F
                      statuses%2Fuser_timeline.json&count%3D50%26
                      exclude_replies%3Dtrue%26include_rts%3Dfalse%26
                      oauth_consumer_key%3D' + ENV["TWITTER_APIKEY"] + '%26
                      oauth_nonce%3D686b5be522f72769898cfc75730ebf39%26
                      oauth_signature_method%3DHMAC-SHA1%26
                      oauth_timestamp%3D1395672194%26
                      oauth_token%3D'+ ENV["TWITTER_TOKEN"]+'%26
                      oauth_version%3D1.0%26
                      screen_name%3Dchilantrobbq'

    signing_key = ENV["TWITTER_SECRET"] + '&' + ENV["TWITTER_TOKEN_SECRET"]

    osig = CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1',signing_key, signature_base)}\n"))
    hmac = HMAC::SHA1.new(signing_key)
    hmac.update(signature_base)
    osig2 = CGI.escape(Base64.encode64("#{hmac.digest}\n"))

    # def prepare_access_token
    #   consumer = OAuth::Consumer.new(ENV["TWITTER_APIKEY"], ENV["TWITTER_SECRET"],
    #     { :site => "https://api.twitter.com",
    #       :scheme => :header
    #     })
    #   # now create the access token object from passed values
    #   token_hash = { :oauth_token => ENV["TWITTER_TOKEN"],
    #                  :oauth_token_secret => ENV["TWITTER_TOKEN_SECRET"]
    #                }
    #   access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
    #   return access_token
    # end

    # # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
    # access_token = prepare_access_token
    # # use the access token as an agent to get the home timeline
    # response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")

    Unirest.get url, headers: {"Authorization" => 'OAuth oauth_consumer_key=' + ENV["TWITTER_APIKEY"] + ',
      oauth_nonce="686b5be522f72769898cfc75730ebf39",
      oauth_signature="pvLfBGCLrzTMMT%2Fywmp93jNIldE%3D",
      oauth_signature_method="HMAC-SHA1",
      oauth_timestamp="1395672194",
      oauth_token='+ ENV["TWITTER_TOKEN"]+ ',
      oauth_version="1.0"'
      }
  end

end

# Authorization: OAuth oauth_consumer_key="1PRk1eQAfgnpcUDVRutGag",
#                 oauth_nonce="686b5be522f72769898cfc75730ebf39",
#                 oauth_signature="pvLfBGCLrzTMMT%2Fywmp93jNIldE%3D",
#                 oauth_signature_method="HMAC-SHA1",
#                 oauth_timestamp="1395672194",
#                 oauth_token="351939371-K9tG5r0y1VO1MeaKipSwObNaQPo7QXdzqOL4RHa4",
#                 oauth_version="1.0"
