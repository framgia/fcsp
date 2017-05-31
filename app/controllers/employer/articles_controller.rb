class Employer::ArticlesController < Employer::BaseController
  load_and_authorize_resource

  def index
    params[:type] = "time_show" unless params[:type]
    params[:sort] = "DESC" unless params[:sort]
    @articles = Article.select(:id, :title, :description, :time_show)
      .search_form(params[:search], params[:type], params[:sort])
      .page(params[:page]).per Settings.article.page
    @total = @articles.size if params[:search] && params[:search] != ""

    if request.xhr?
      render json: {
        html_article: render_to_string(partial: "articles/article",
          locals: {articles: @articles}, layout: false),
          pagination_article: render_to_string(partial: "articles/paginate",
          layout: false)
      }
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def show
  end

  def new
    @article = Article.new
    @article.images.build
  end

  def create
    @article = Article.new article_params
    @article.time_show = Time.now unless @article.time_show?
    if @article.save
      flash[:success] = t ".created"
      redirect_to employer_company_articles_path(@company)
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update_attributes article_params
      if params[:show_time] == "1"
        @article.update_attributes time_show: Time.now
      end
      flash[:success] = t ".update"
      redirect_to employer_company_articles_path(@company)
    else
      flash[:danger] = t ".fail"
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:success] = t ".delete"
    redirect_to employer_company_articles_path(@company)
  end

  private

  def article_params
    params.require(:article).permit Article::ATTRIBUTES
  end
end
