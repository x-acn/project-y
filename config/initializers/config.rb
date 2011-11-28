module Config
  DOMAIN = ENV["DOMAIN"] || "projectx.me"
  RESERVED_SUBDOMAINS = ["www"]
  RESERVED_SUBDOMAINS_REGEX = /^(www)?$/
end
