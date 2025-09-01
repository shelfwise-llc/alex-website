defmodule AlexWebsiteWeb.BlogLive.Show do
  use AlexWebsiteWeb, :live_view

  def mount(%{"slug" => slug}, _session, socket) do
    case fetch_post_by_slug(slug) do
      {:ok, post} ->
        {:ok, assign(socket, post: post, page_title: post.title)}
      {:error, :not_found} ->
        {:ok, push_navigate(socket, to: ~p"/blog")}
      {:error, _reason} ->
        {:ok, assign(socket, post: nil, page_title: "Post Not Found")}
    end
  end

  def render(assigns) do
    ~H"""
    <%= if @post do %>
      <article class="container mx-auto px-4 py-8 max-w-4xl">
        <%= if @post.feature_image do %>
          <img 
            src={@post.feature_image} 
            alt={@post.title} 
            class="w-full h-64 md:h-96 object-cover rounded-lg mb-8" 
          />
        <% end %>
        
        <header class="mb-8">
          <h1 class="text-4xl md:text-5xl font-bold mb-4"><%= @post.title %></h1>
          
          <div class="flex items-center text-gray-600 mb-4">
            <time datetime={@post.published_at}>
              <%= Calendar.strftime(@post.published_at, "%B %d, %Y") %>
            </time>
            <%= if @post.reading_time do %>
              <span class="mx-2">•</span>
              <span><%= @post.reading_time %> min read</span>
            <% end %>
          </div>
          
          <%= if @post.excerpt do %>
            <p class="text-xl text-gray-700 leading-relaxed"><%= @post.excerpt %></p>
          <% end %>
        </header>
        
        <div class="ghost-blog-content prose prose-lg max-w-none">
          <%= raw(@post.html) %>
        </div>
        
        <%= if @post.tags && length(@post.tags) > 0 do %>
          <footer class="mt-12 pt-8 border-t">
            <div class="flex flex-wrap gap-2">
              <%= for tag <- @post.tags do %>
                <span class="inline-block bg-gray-100 text-gray-800 px-3 py-1 rounded-full text-sm">
                  <%= tag.name %>
                </span>
              <% end %>
            </div>
          </footer>
        <% end %>
        
        <div class="mt-8">
          <.link navigate={~p"/blog"} class="text-blue-600 hover:text-blue-800">
            ← Back to Blog
          </.link>
        </div>
      </article>
    <% else %>
      <div class="container mx-auto px-4 py-8 text-center">
        <h1 class="text-4xl font-bold mb-4">Post Not Found</h1>
        <p class="text-gray-600 mb-8">The blog post you're looking for doesn't exist.</p>
        <.link navigate={~p"/blog"} class="text-blue-600 hover:text-blue-800">
          ← Back to Blog
        </.link>
      </div>
    <% end %>
    """
  end

  defp fetch_post_by_slug(slug) do
    try do
      {:ok, %{posts: [post]}} =
        GhostContent.config(:alex_website)
        |> GhostContent.get_post_by_slug(slug)
      
      {:ok, post}
    rescue
      _ -> {:error, :not_found}
    end
  end
end
