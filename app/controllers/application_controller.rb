class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :prepare_markdown_renderer
  helper_method :current_nakama

  protected

  def current_nakama
    @current_nakama ||= current_user&.nakama
  end

  private

  def prepare_markdown_renderer
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                        space_after_headers: true,
                                        no_intra_emphasis: true)
  end
end
