module UpdaterHelper
  require 'open-uri'

  # @return version number or nil
  def latest_diaspora_version
    dir = Rails.application.config.diaspora[:directory]
    feed = Rails.application.config.diaspora[:atomfeed]
    rss = SimpleRSS.parse open(feed)
    id = rss.items.first.id

    /\/v([\d\.]+?)$/.match(id)[1]
  end
end
