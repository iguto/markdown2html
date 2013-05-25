#!/usr/bin/env ruby
require 'redcarpet'
require 'pygments'

# css files
code_css = "https://raw.github.com/iguto/markdown2html/master/code.css"
base_css = "https://raw.github.com/iguto/markdown2html/master/github.css"

# from https://github.com/vmg/redcarpet
class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygments.highlight(code, :lexer => language)
  end
	
	def doc_header()
		header = "<html><header>
<link rel='stylesheet' href=#{code_css} />
<link rel='stylesheet' href=#{base_css} />
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
  :hard_wrap => true
}

#STDOUT.write Redcarpet::Markdown.new(HTMLwithPygments.new(render_extensinos),

render = HTMLwithPygments.new(render_extensinos)
#puts Redcarpet::Markdown.new(render, parse_extensions).render(ARGF.read)
markdown = Redcarpet::Markdown.new(render, parse_extensions)
puts markdown.render(ARGF.read)
#puts Redcarpet::Markdown.new(render, parse_extensions).render(ARGF.read)
