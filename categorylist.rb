module Jekyll
  class CategoryList < Liquid::Tag
    def render(context)
      s = StringIO.new
      begin
        categories = context['site']['categories']
        unless categories.nil?
          s << "<ul>"
          sorted = {}
          post_count = context['site']['posts'].size.to_i
          categories.each do |cat|
            sorted[cat[0]] = cat[1].size
          end
          sorted = sorted.sort_by {|k,v| v}.reverse!
          sorted.each do |k,v|
            s << "<li><em>#{v}</em><a href=\"/blog/categories/#{k}\">#{k}</a><span style=\"width:#{v * 100 / post_count}%\">bar</span><div class=\"#{k}\"></div></li>"
          end
          s << "</ul>"
        end
      rescue => boom
        p boom
      end
      s.string
    end
  end
end

Liquid::Template.register_tag('category_list', Jekyll::CategoryList) 
