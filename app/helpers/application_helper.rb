module ApplicationHelper
  # Extracted from https://github.com/thoughtbot/flutie/blob/master/app/helpers/page_title_helper.rb
  def page_title(options = {})
    app_name = options[:app_name] || Rails.application.class.to_s.split('::').first
    page_title_symbol = options[:page_title_symbol] || :page_title
    separator = options[:separator] || ' : '

    if content_for?(page_title_symbol)
      [app_name, content_for(page_title_symbol)].join(separator)
    else
      app_name
    end
  end

  # Extracted from https://github.com/thoughtbot/flutie/blob/master/app/helpers/body_class_helper.rb
  def body_class(options = {})
    extra_body_classes_symbol = options[:extra_body_classes_symbol] || :extra_body_classes
    qualified_controller_name = controller.controller_path.gsub('/','-')
    basic_body_class = "#{qualified_controller_name} #{qualified_controller_name}-#{controller.action_name}"

    if content_for?(extra_body_classes_symbol)
      [basic_body_class, content_for(extra_body_classes_symbol)].join(' ')
    else
      basic_body_class
    end
  end
end
