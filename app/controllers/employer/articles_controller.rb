class Employer::ArticlesController < Employer::BaseController
  before_action :load_article, except: [:index, :new, :create]

  def index
    @article_presenter = ArticlePresenter.new @company, params

    if request.xhr?
      render json: {
        html_article: render_to_string(partial: "articles",
          locals: {articles: @article_presenter.articles,
          total: @article_presenter.total, company: @company},
          layout: false),
        pagination_article: render_to_string(partial: "articles/paginate",
          locals: {articles: @article_presenter.articles}, layout: false)
      }
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def new
    @article = @company.articles.new
    @article.images.build
  end

  def create
    @article = @company.articles.build article_params
    @article.time_show = Time.zone.now unless @article.time_show?

    if @article.save
      flash[:success] = t ".created"
      redirect_to employer_company_articles_path @company
    else
      flash.now[:danger] = t ".fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @article.time_show > Time.zone.now && params[:show_time] == "now"
      params[:article][:time_show] = Time.zone.now
    end

    if @article.update_attributes article_params
      flash[:success] = t ".update"
      redirect_to employer_company_articles_path @company
    else
      flash.now[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = t ".delete"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to employer_company_articles_path @company
  end

  private

  def article_params
    params.require(:article).permit Article::ATTRIBUTES
  end

  def load_article
    return if @article = @company.articles.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to employer_company_articles_path @company
  end
end
