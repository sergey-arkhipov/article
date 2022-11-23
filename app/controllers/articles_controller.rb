class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :set_search, only: :index

  # GET /articles or /articles.json
  def index
    @pagy, @articles = pagy_elasticsearch_rails(@articles, items: 5)
    render :index, locals: { query: params[:query]}
  end

  # GET /articles/1 or /articles/1.json
  def show; end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    render :edit, locals: { edit: 'edit' }
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if check_params(@article, article_params) && gets_version(@article, article_params).save
        format.html { redirect_to article_url(@article), notice: 'Article version was successfully created.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def check_params(article, article_params)
    if article.text == article_params['text']

      article.errors.add(:text, 'Нет изменений для сохранения')
      return false
    end
    true
  end

  def gets_version(article, article_params)
    article_orig = Article.find(article.id)
    article_version = article_orig.dup
    article_version.text = article_params['text']
    article_version.changed_on = DateTime.current
    article_version.version = article_orig.version + 1
    article_version
  end

  # Return Elasticseach when search or all
  def set_search
    @articles = if params[:query].present?
                  search = "#{helpers.sanitize(params[:query])}*"
                  Article.pagy_search(search).records
                else
                  Article.pagy_search('*').records
                end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.fetch(:article, {}).permit(:author, :title, :text, :version, :status, :changed_on)
  end
end
