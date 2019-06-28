module PaginateHelper
  class LinkRenderer < WillPaginate::ActionView::LinkRenderer
    protected

    def page_number(page)
      unless page == current_page
        link(page, page, :rel => rel_value(page))
      else
        link(page, "#", :class => 'active')
      end
    end

    def gap
      text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
      %(<li class="disabled active"><a>#{text}</a></li>)
    end

    def next_page
      num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
      previous_or_next_page(num, @options[:next_label], 'next')
    end

    def previous_or_next_page(page, text, classname)
      chevron = ' '
      if classname == 'previous_page'
        chevron = ' fa-chevron-left '
      elsif classname == 'next'
        chevron = ' fa-chevron-right '
      end

      puts chevron

      if page
        link(text, page, {:class => classname}, chevron )
      else
        link(text, "#", {:class => classname + ' disabled'}, chevron)
      end
    end

    def html_container(html)
      tag(:div, tag(:ul, html, :class => "pagination"), container_attributes)
    end

    private

    def link(text, target, attributes = {}, chevron = '')
      if target.is_a? Fixnum
        attributes[:rel] = rel_value(target)
        target = url(target)
      end

      unless target == "#"
        attributes[:href] = target
      end

      puts chevron

      classname = attributes[:class]
      attributes.delete(:classname)
      attributes[:class] = [attributes[:class], chevron]
      tag(:li, tag(:a, text, attributes), :class => classname)
    end
  end
end