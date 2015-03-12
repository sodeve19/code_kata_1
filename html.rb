class MarkupLanguage
  def initialize
    @html = ""
  end

  def document(&block)
    instance_eval(&block)
    puts @html
  end

  def body(&block)
    puts "<html>\n\t<body>"
    puts &block
    puts "\t</body>\n</html>"
  end 

  def div(id)
  end
end

MarkupLanguage.new.document do
  body do 
    div id: 'container' do
      list class: ‘pretty’ do
        item “item 1”
        item “item 2”
      end
    end
  end
end