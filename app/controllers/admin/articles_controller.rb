class Admin::ArticlesController < Admin::BaseController
  load_and_authorize_resource

  def index
    if params[:search].present?
      @articles = Article.search_form(params[:search])
        .select(:id, :title, :description, :content, :time_show)
        .order(time_show: :desc)
        .page(params[:page]).per Settings.article.page
      @total = @articles.size
    else
      @articles = Article.select(:id, :title, :description, :content,
        :time_show).order(created_at: :desc)
        .page(params[:page]).per Settings.article.page
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
    if @article.save
      flash[:success] = t ".created"
      redirect_to admin_articles_path
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update_attributes article_params
      flash[:success] = t ".update"
      redirect_to admin_articles_path
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:success] = t ".delete"
    redirect_to admin_articles_path
  end

  private

  def article_params
    params.require(:article).permit Article::ATTRIBUTES
  end
end
