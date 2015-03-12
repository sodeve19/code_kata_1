class MarkupLanguage
  def initialize
    @html = ""
    @tab1 = 0
    @tab2 = 0
    @i = 0
  end

  def first_tab
    @tab1 += 1
    @tab2 = @tab1 + 1
    "\t"*@tab1
  end

  def no_increment_tab
    "\t"*@tab1
  end

  def second_tab
    @tab2 -= 1
    "\t"*@tab2
  end

  def document(&block)
    instance_eval(&block)
    puts @html
  end

  def body(&block)
    puts "<html>\n#{first_tab}<body>"
    yield
    #first_tab
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
    unless block_given?
      if @i == 0
        print "#{first_tab}<li>"
        print text  
        puts "</li> "
        @i += 1
      else 
        print "#{no_increment_tab}<li>"
        print text  
        puts "</li> "
      end
    end
    @tab2 = @tab1
  end 
end


MarkupLanguage.new.document do
  body do
    div id: 'container', class: 'nav' do
        list class:'pretty' do
          item 'item 1'
          item 'item 2'
          item 'item 3'
          item 'item 3'
          item 'item 3'
        end
    end
  end
end 