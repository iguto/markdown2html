#!/usr/bin/env ruby
require 'redcarpet'
require 'pygments'
require 'json'

# from https://github.com/vmg/redcarpet
#class HTMLwithPygments < Redcarpet::Render::HTML
class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygments.highlight(code, :lexer => language)
  end
	
	def doc_header()
		jfile = "#{File.dirname(__FILE__)}/css_file.json"
		css_json = File.read(jfile)
		csss = JSON.parse(css_json)
		css_link=""
		csss["css"].each do |css|
			css_link << "<link rel='stylesheet' type='text/css' href=#{css} />\n"
		end

		header = "<html><header>
#{css_link}
</header><body>"
	end

	def doc_footer()
		"<!-- here is footer from doc_footer() -->
</body></html>"
	end
end

=begin
parse_extensions = {
  :no_intra_emphasis => true,
  :tables => true,
  :fenced_code_blocks => true,
  :autolink => true
}

render_extensinos = {
  :hard_wrap => true,
	:with_toc_data => true
}

#STDOUT.write Redcarpet::Markdown.new(HTMLwithPygments.new(render_extensinos),

render = HTMLwithPygments.new()#render_extensinos)
#puts Redcarpet::Markdown.new(render, parse_extensions).render(ARGF.read)
html_toc = Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC)
markdown = Redcarpet::Markdown.new(render, parse_extensions)
md_file = ARGF.read.delete('[TOC]')
puts html_toc.render(md_file)
puts markdown.render(md_file)
#puts Redcarpet::Markdown.new(render, parse_extensions).render(ARGF.read)
=end

