module ApplicationHelper
  def nav_link(link_text, link_path, html_options = {})
    class_name = current_page?(link_path) ? 'active' : nil

    content_tag(:li, :class => [class_name, 'nav-item']) do
      link_to link_text, link_path, class: html_options[:class] || 'nav-link'
    end
  end

  def flash_class(level)
    level = level.to_sym
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-danger"
    when :alert then "alert alert-danger"
    end
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = 'CoinGenius'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 100 })
    size = options[:size]
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    img_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=identicon"
    image_tag(img_url, class: "gravatar", :size => "#{size/2}x#{size/2}")
  end

  def logo_image(url)
    "//logo.clearbit.com/#{url}"
  end

end
