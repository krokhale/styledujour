module ApplicationHelper

  def script_template(*args)
    name    = args.first
    options = args.second || {}
    id      = options[:id] || "backbone_templates_#{controller_name}_#{name}"
    locals  = options[:locals] || {}
    partial = options[:partial] || "#{controller_name}/#{name}"
    id = id.camelize(:lower)
    content_tag(:script, :type => "text/template", :id => id) do
      render :partial => partial, :locals => locals
    end
  end

  
  def title_page
    'Styledujour'
  end
end
