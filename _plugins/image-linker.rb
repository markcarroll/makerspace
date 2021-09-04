Jekyll::Hooks.register :posts, :pre_render do |post, payload|
  post.content.gsub!(/^!\[(.*)\]\(([^\)]+)\)((?:{:[^}]+})*)/, "\n<a href=\"{{ page.dir }}\\2\" class=\"lightgallery-link\" data-sub-html=\"\\1\">\n![\\1]({{ page.dir }}\\2)\\3{:data-src=\"{{ page.dir }}\\2\"}\n</a>")
  # post.content.gsub!(/\[(.*)\]\(([^\)]+)!!\)/, "<a href=\"\\2\" download>\\1</a>")
  # post.content.gsub!(/\[(.*)\]\(!(.*?)!([^\)]+)\)((?:{:[^}]+})*)/, "<a href=\"\\3\" download=\"\\2\">\\1</a>")
end