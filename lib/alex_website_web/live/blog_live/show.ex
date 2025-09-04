defmodule AlexWebsiteWeb.BlogLive.Show do
  use AlexWebsiteWeb, :live_view
  import Phoenix.Component

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    {:ok,
      socket
      |> assign(:slug, slug)
      |> assign(:page_title, "Blog Post - Alex Cosmas")
      |> assign_post()
    }
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  defp assign_post(socket) do
    case fetch_post_by_slug(socket.assigns.slug) do
      {:ok, post} ->
        socket
        |> assign(:post, post)
        |> assign(:page_title, "#{post["title"]} - Alex Cosmas")
        |> assign(:meta_description, post["description"])
        |> assign_related_posts()
      {:error, _reason} ->
        socket
        |> assign(:post, nil)
    end
  end

  defp assign_related_posts(socket) do
    case fetch_posts() do
      {:ok, all_posts} ->
        related_posts =
          all_posts
          |> Enum.filter(fn p -> p["slug"] != socket.assigns.post["slug"] end)
          |> Enum.take(3)

        assign(socket, :related_posts, related_posts)
      {:error, _reason} ->
        assign(socket, :related_posts, [])
    end
  end

  defp fetch_post_by_slug(slug) do
    try do
      {:ok, %{posts: [post]}} =
        GhostContent.config(:alex_website)
        |> GhostContent.get_post_by_slug(slug)

      # Transform Ghost post to match our expected format
      transformed_post = %{
        "title" => post.title,
        "slug" => post.slug,
        "description" => post.excerpt || post.meta_description,
        "date" => post.published_at,
        "readingTime" => "#{div(String.length(post.html || ""), 1500) + 1} min read",
        "tags" => Enum.map(post.tags || [], & &1.name),
        "featured" => post.featured,
        "thumbnail" => post.feature_image,
        "html" => post.html,
        "toc" => extract_toc(post.html)
      }

      {:ok, transformed_post}
    rescue
      _ -> {:error, :not_found}
    end
  end

  defp fetch_posts do
    try do
      {:ok, %{posts: posts}} =
        GhostContent.config(:alex_website)
        |> GhostContent.get_posts()

      # Transform Ghost posts to match our expected format
      transformed_posts = Enum.map(posts, fn post ->
        %{
          "title" => post.title,
          "slug" => post.slug,
          "description" => post.excerpt || post.meta_description,
          "date" => post.published_at,
          "readingTime" => "#{div(String.length(post.html || ""), 1500) + 1} min read",
          "tags" => Enum.map(post.tags || [], & &1.name),
          "featured" => post.featured,
          "thumbnail" => post.feature_image
        }
      end)

      {:ok, transformed_posts}
    rescue
      _ -> {:error, :connection_failed}
    end
  end

  defp extract_toc(html) when is_binary(html) do
    # Simple TOC extraction - find all h2 and h3 tags
    heading_regex = ~r/<h([2-3])[^>]*>(.*?)<\/h\1>/

    heading_regex
    |> Regex.scan(html, capture: :all_but_first)
    |> Enum.map(fn [level, content] ->
      # Remove any HTML tags from the heading content
      clean_content = Regex.replace(~r/<[^>]*>/, content, "")

      %{
        "level" => String.to_integer(level),
        "text" => clean_content,
        "id" => generate_id(clean_content)
      }
    end)
  end

  defp extract_toc(_), do: []

  defp generate_id(text) do
    text
    |> String.downcase()
    |> String.replace(~r/[^\w\s-]/, "")
    |> String.replace(~r/\s+/, "-")
  end

  defp format_date(date_string) when is_binary(date_string) do
    # Ghost CMS dates may include time and timezone info
    # Extract just the date part (YYYY-MM-DD) and parse it
    case Regex.run(~r/^(\d{4}-\d{2}-\d{2})/, date_string) do
      [_, date_part] ->
        case Date.from_iso8601(date_part) do
          {:ok, date} ->
            Calendar.strftime(date, "%B %d, %Y")
          _ ->
            date_string
        end
      _ ->
        date_string
    end
  end

  defp format_date(date_string), do: date_string
end
