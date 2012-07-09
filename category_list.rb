module Jekyll
  class CategoryList < Liquid::Tag
    def render(context)
      s = StringIO.new
      begin
        categories = context['site']['categories']
        unless categories.nil?
          post_count = context['site']['posts'].size.to_i
          categories.sort_by { |cat, posts| posts.size }
            .reverse()
            .each do |cat, posts|
               s << "<li><em>#{posts.size}</em><a href=\"/blog/categories/#{cat}\">#{cat}</a><span style=\"width:#{posts.size * 100 / post_count}%\">bar</span><div class=\"#{cat}\"></div></li>"
            end
        end
      rescue => boom
        p boom
      end
      "<ul>#{s.string}</ul>"
    end
  end
end

Liquid::Template.register_tag('category_list', Jekyll::CategoryList) 
