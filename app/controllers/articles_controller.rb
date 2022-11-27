class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show destroy]
  before_action :set_search, only: :index
  # before_action { @pagy_locale = 'ru' }

  # GET /articles
  def index
    flash.now[:notice] = "Вы искали #{query}" unless params[:query].blank?
    # Возвращаем найденные статьи с учетом параметров пагинации.
    @pagy, @articles = pagy_elasticsearch_rails(@articles_pagy_search)
    render :index, locals: { query: }
  end

  # GET /articles/new
  def new
    @article = Article.new # Создаем статью
    @article.texts.build # Текст статьи
  end

  # GET|POST /articles/1/1 # Просмотр статьи и версий.
  def show
    # Версии сортируем, ids не обязательно возвращает по возрастанию.
    @texts = @article.texts.order(:id)
    current = params[:page] || (@texts.ids.index(@article.active_text_id) + 1)
    @pagy, @texts = pagy(@texts, items: 1, page: current)
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: 'Cтатья была успешно создана.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Статья была успешно удалена' }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  # Return Elasticseach when search or all
  def set_search
    search = "#{query}*"
    @articles_pagy_search = params[:query].present? ? Article.pagy_search(search).records : Article.pagy_search('*').records
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:id, :author, :title, :version, :status, :changed_on,
                                    texts_attributes: %i[text changed_on archive])
  end

  # Sanitize query & strip
  def query
    params[:query].blank? ? '' : helpers.sanitize(params[:query]).strip
  end

  # !!! Pagy::OverflowError don't catch negative page number, => Elasticsearch::Transport::Transport::Errors::BadRequest
  def pagy_elasticsearch_rails_get_vars(_collection, vars)
    vars[:page] = 1 if params[:page].to_i <= 0
    super
  end
end
