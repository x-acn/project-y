class Template
  attr_reader :title, :filename, :thumbnail #, :filename, :path, :areas
  
  def initialize(filename, title, thumbnail)
    @filename, @title, @thumbnail = filename, title, thumbnail
  end
  
  class << self
    extend ActiveSupport::Memoizable
    
    def all
      template_conf = YAML.load_file("#{Rails.root}/config/templates.yml")
      template_conf["templates"].map do |templ|
        self.new(templ["filename"], templ["title"], templ["thumbnail"])
      end
    end
    memoize :all
    
    def default_filename
      template_conf = YAML.load_file("#{Rails.root}/config/templates.yml")
      template_conf["default"]
    end
    
    #def find(theme, filename)
    #  all(theme.to_s).select{|t| t.filename.eql? filename.to_s}.first
    #end
    #memoize :find
    
  end
  
end
