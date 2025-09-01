defmodule AlexWebsiteWeb.BlogLive.Index do
  use AlexWebsiteWeb, :live_view

  def mount(_params, _session, socket) do
    case fetch_posts() do
      {:ok, posts} ->
        {:ok, assign(socket, :posts, posts)}
      {:error, _reason} ->
        {:ok, assign(socket, :posts, [])}
    end
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto px-4 py-8">
      <h1 class="text-4xl font-bold mb-8">Blog</h1>
      
      <div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        <%= for post <- @posts do %>
          <article class="bg-white rounded-lg shadow-md overflow-hidden">
            <%= if post.feature_image do %>
              <img src={post.feature_image} alt={post.title} class="w-full h-48 object-cover" />
            <% end %>
            <div class="p-6">
              <h2 class="text-xl font-bold mb-2">
                <.link navigate={~p"/blog/#{post.slug}"} class="hover:text-blue-600">
                  <%= post.title %>
                </.link>
              </h2>
              <%= if post.excerpt do %>
                <p class="text-gray-600 mb-4"><%= post.excerpt %></p>
              <% end %>
              <div class="text-sm text-gray-500">
                <%= Calendar.strftime(post.published_at, "%B %d, %Y") %>
              </div>
            </div>
          </article>
        <% end %>
      </div>
      
      <%= if @posts == [] do %>
        <div class="text-center py-12">
          <p class="text-gray-600">No blog posts found. Please check your Ghost CMS configuration.</p>
        </div>
      <% end %>
    </div>
    """
  end

  defp fetch_posts do
    try do
      {:ok, %{posts: posts}} =
        GhostContent.config(:alex_website)
        |> GhostContent.get_posts()
      
      {:ok, posts}
    rescue
      _ -> {:error, :connection_failed}
    end
  end
end
