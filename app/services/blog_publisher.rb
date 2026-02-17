class BlogPublisher
    def initialize(blog)
      @blog = blog
    end
  
    def call
      @blog.update(published: true)
    end
  end