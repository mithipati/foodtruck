module ApplicationHelper
  require 'rubygems'



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

  def twitterclient
    @client = Twitter.configure do |config|
        config.consumer_key = ENV["CONSUMER_KEY"]
        config.consumer_secret = ENV["CONSUMER_SECRET"]
        config.oauth_token = ENV["ACCESS_TOKEN"]
        config.oauth_token_secret = ENV["ACCESS_SECRET"]
    end
  end

end
