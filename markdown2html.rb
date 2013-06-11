#!/usr/bin/env ruby
require 'redcarpet'
require 'pygments'

# css files
$base_css = "http://clc-iguto.com/~masahiro/css/old_github.css"
#$base_css = "http://clc-iguto.com/~masahiro/css/github.css"
$code_css = "http://clc-iguto.com/~masahiro/css/code.css"

# from https://github.com/vmg/redcarpet
#class HTMLwithPygments < Redcarpet::Render::HTML
class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygments.highlight(code, :lexer => language)
  end
	
	def doc_header()
		header = "<html><header>
<link rel='stylesheet' type='text/css' href=#{$code_css} />
<link rel='stylesheet' type='text/css' href=#{$base_css} />
</header><body>"

	end

	def doc_footer()
		"<!-- here is footer from doc_footer() -->
</body></html>"
	end
end

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
