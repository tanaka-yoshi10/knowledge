module ApplicationHelper
  def markdown_to_html(text)
    markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true, xhtml: true),
                                       autolink: true,
                                       space_after_headers: true,
                                       no_intra_emphasis: true,
                                       fenced_code_blocks: true,
                                       tables: true,
                                       lax_html_blocks: true,
                                       strikethrough: true

    markdown.render(text).html_safe unless text.blank?
  end

  def avatar_url(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def avatar_image_tag(user, size)
    link_to image_tag(avatar_url(user, size)), user
  end
end
