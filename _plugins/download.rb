# module Jekyll
#   class Download < Liquid::Tag
#   include ApplicationHelper
#   def initialize(tag_name, variables, tokens)

#       @variables = variables.split("|")

#       @text = @variables[0]
#       @file_name = @variables[1]

#       super
#   end

#   def render(context)

#       # This is where i use context[@theme_id.strip] to get the variable of "settings.theme.id"
#       # content = CodeFile.find_by(hierarchy: 'snippet', name: @file_name.to_s, theme_id: context[@theme_id.strip])

#       # @menu ||= Menu.find_by_slug(@text)

#       # context.merge('menu' => @menu)

#       # Liquid::Template.parse(content.code).render(context)
#       "<a href='#{file_name}' download>#{text}</a>"
#   end

# end
# end

module Jekyll
  class DownloadTag < Liquid::Tag

    def initialize(tag_name, variables, tokens)
      super
      @variables = variables.split("|")

      @text = @variables[0]
      @file_name = @variables[1]
      @download_as = @variables.size > 2 ? "download='#{@variables[2].strip!}'" : "download"
    end

    def render(context)
      "<a href='#{@file_name}' #{@download_as}>#{@text} <i class='fa fa-download'></i></a>"
    end
  end
end

Liquid::Template.register_tag('download', Jekyll::DownloadTag)
