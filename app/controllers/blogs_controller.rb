class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :publish]

  require 'benchmark'
   # GET /blogs or /blogs.json
  def index
    # We measure the time taken to fetch the published blogs
    @benchmark_result = Benchmark.realtime do
      @blogs = Blog.published.to_a # .to_a forces the query to execute now
    end
    
    # Optional: Share result in the console or response headers
    puts "Index API Benchmark: #{@benchmark_result} seconds"
  end

  # GET /blogs/1 or /blogs/1.json
  def show
    # @blog is already set by the callback
    # Requirement: Only show if published
    render_not_found unless @blog.published?
  end

  def drafts
    @blogs = Blog.where(published: false) # The internal list
    render :index # Reuse the index view!
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        PublishBlogJob.set(wait: 1.hour).perform_later(@blog.id)
        format.html { redirect_to @blog, notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    # blog_params is the 'Strong Parameter' method we defined
    if @blog.update(blog_params)
      redirect_to @blog, notice: "Blog was successfully updated."
    else
      # status: :unprocessable_entity is important for Turbo/Modern Rails
      render :edit, status: :unprocessable_entity 
    end
  end
  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy!

    respond_to do |format|
      format.html { redirect_to blogs_path, notice: "Blog was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def publish
    BlogPublisher.new(@blog).call
    redirect_to @blog
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params.expect(:id))
    end

    def render_not_found
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :body)
    end
end
