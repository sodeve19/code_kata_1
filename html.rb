class MarkupLanguage
  def initialize
    @html = ""
    @tab = 0
  end

  def first_tab
    @tab += 1
    "\t"*@tab
  end

  def second_tab
    @tab -= 1
    "\t"*@tab
  end

  def document(&block)
    instance_eval(&block)
    puts @html
  end

  def body(&block)
    puts "<html>\n#{first_tab}<body>"
    yield
    first_tab
    puts "#{second_tab}</body>\n</html>"
  end 

  def div(properties, &block)
    print "#{first_tab}<div "
    (properties.each { |key, value| print key.to_s + "='" + value.to_s + "' " }).to_s
    puts ">"
    yield
    puts "#{second_tab}</div>"
  end

  def list(properties, &block)
    print "#{first_tab}<ul "
    (properties.each { |key, value| print key.to_s + "='" + value.to_s + "' " }).to_s
    puts ">"
    yield
    puts "#{second_tab}</ul>"
  end

  def item(text, &block)
    print "#{first_tab}<li>"
    second_tab
    print text  
    puts "</li> "
  end 
end


MarkupLanguage.new.document do
  body do
    div id: 'container', class: 'nav' do
        list class:'pretty' do
          item 'item 1'
          item 'item 2'
        end
    end
  end
end 


# MarkupLanguage.new.document do
#   body do 
#     div id: 'container' do
#       list class: ‘pretty’ do
#         item “item 1”
#         item “item 2”
#       end
#     end
#   end
# end