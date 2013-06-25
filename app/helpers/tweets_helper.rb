module TweetsHelper
    def twitter_image_for(tweet, options = { size: 50 })
    size = options[:size]
    url = tweet.twitteruser.profile_image_url
    image_tag(url, class: "gravatar")
  end
end
