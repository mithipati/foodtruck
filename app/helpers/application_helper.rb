module ApplicationHelper
  require 'rubygems'
  require 'base64'
  require 'cgi'
  require 'openssl'

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
    # signature_string = CGI.escape('include_entities=true&oauth_consumer_key=#{ENV["TWITTER_APIKEY"]}
    #                         &oauth_nonce=#{nonce2}
    #                         &oauth_signature_method=HMAC-SHA1
    #                         &oauth_timestamp=#{Time.now.to_i}
    #                         &oauth_token=#{ENV["TWITTER_TOKEN"]}
    #                         &oauth_version=1.0')

    # signature_base = 'GET&https%3A%2F%2Fapi.twitter.com%2F1.1%2Fstatuses%2F
                      #user_timeline.json%3Fscreen_name%3Dchilantrobbq%26count%3D50%26
                      #exclude_replies%3Dtrue%26include_rts%3Dfalse&' + signature_string

    signature_base = 'GET&https%3A%2F%2Fapi.twitter.com%2F1.1%2Fstatuses%2Fuser_timeline.json&count%3D50%26exclude_replies%3Dtrue%26include_rts%3Dfalse%26oauth_consumer_key%3D1PRk1eQAfgnpcUDVRutGag%26oauth_nonce%3D49ae78af4061020bbebe40943878dc8f%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1395530417%26oauth_token%3D351939371-K9tG5r0y1VO1MeaKipSwObNaQPo7QXdzqOL4RHa4%26oauth_version%3D1.0%26screen_name%3Dchilantrobbq'

    def prepare_access_token
      consumer = OAuth::Consumer.new(ENV["TWITTER_APIKEY"], ENV["TWITTER_SECRET"],
        { :site => "https://api.twitter.com",
          :scheme => :header
        })
      # now create the access token object from passed values
      token_hash = { :oauth_token => ENV["TWITTER_TOKEN"],
                     :oauth_token_secret => ENV["TWITTER_TOKEN_SECRET"]
                   }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
      return access_token
    end

    # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
    access_token = prepare_access_token
    # use the access token as an agent to get the home timeline
    response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")

    # Unirest.get url, headers: {"Authorization" => 'OAuth oauth_consumer_key=' + ENV["TWITTER_APIKEY"] + ',
    #   oauth_nonce="49ae78af4061020bbebe40943878dc8f",
    #   oauth_signature='+ signature +',
    #   oauth_signature_method="HMAC-SHA1",
    #   oauth_timestamp="1395530417",
    #   oauth_token='+ ENV["TWITTER_TOKEN"]+ ',
    #   oauth_version="1.0"'
    #   }
  end

end

# temporary signature base = jbOCoOLYFsl0EbWXrBfzRyYSIWc%3D
#'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{@truck.handle}&count=50&exclude_replies=true&include_rts=false'
# Authorization: OAuth oauth_consumer_key="1PRk1eQAfgnpcUDVRutGag",
# oauth_nonce="aa614e151a36bb32784bd3343eb69ff7",
# oauth_signature="x2arU7WHMa5poz2gcav4j88OtmM%3D",
# oauth_signature_method="HMAC-SHA1",
# oauth_timestamp="1395521309",
# oauth_token="", oauth_version="1.0"

# "Authorization" => "OAuth " +
#       "oauth_consumer_key=\'#{ENV['TWITTER_APIKEY']}\',
#         oauth_nonce=\'#{nonce}\',
#         oauth_signature=\'#{signature_base}\',
#         oauth_signature_method=\'HMAC-SHA1\',
#         oauth_timestamp=\'#{Time.now.to_i}\',
#         oauth_token=\'#{ENV['TWITTER_TOKEN']}\',
#         oauth_version=\'1.0\'
#     "


