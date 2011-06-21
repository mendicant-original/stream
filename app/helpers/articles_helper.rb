require 'uri'

module ArticlesHelper
  def url_host(url)
    URI.parse(url).host
  end
end
