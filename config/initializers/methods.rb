def to_slug(param)
  
  # prepare the initial string
  ret = param.to_s.strip.downcase
  
  #blow away apostrophes
  ret.gsub! /['`]/, ""

  # @ --> at, and & --> and
  ret.gsub! /\s*@\s*/, " at "
  ret.gsub! /\s*&\s*/, " and "

  # replace all non alphanumeric, periods with dash
  ret.gsub! /\s*[^A-Za-z0-9\.]\s*/, '-'

  # replace underscore with dash
  ret.gsub! /[-_]{2,}/, '-'

  # convert double dashes to single
  ret.gsub! /-+/, "-"

  # strip off leading/trailing dash
  ret.gsub! /\A[-\.]+|[-\.]+\z/, ""

  ret
end
