class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :prepare_markdown_renderer

  private

  def prepare_markdown_renderer
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                        space_after_headers: true,
                                        no_intra_emphasis: true)
  end
end
