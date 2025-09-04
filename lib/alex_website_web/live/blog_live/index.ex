defmodule AlexWebsiteWeb.BlogLive.Index do
  use AlexWebsiteWeb, :live_view

  import Phoenix.HTML.Form
  import Phoenix.Component

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(:page_title, "Blog - Alex Cosmas")
      |> assign(:meta_description, "Read the latest insights and thoughts from Alex Cosmas on design, development, and product strategy.")
      |> assign(:search_query, "")
      |> assign(:selected_category, "")
      |> assign(:email, "")
      |> assign(:is_subscribing, false)
      |> assign(:subscription_message, nil)
      |> assign(:subscription_success, false)
      |> assign(:posts_per_page, 6)
      |> assign(:current_page, 1)
      |> assign_posts()
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Blog - Alex Cosmas")
  end

  @impl true
  def handle_event("search", %{"search_query" => search_query}, socket) do
    {:noreply,
      socket
      |> assign(:search_query, search_query)
      |> assign(:current_page, 1)
    }
  end

  @impl true
  def handle_event("select_category", %{"category" => category}, socket) do
    selected_category = if socket.assigns.selected_category == category, do: "", else: category

    {:noreply,
      socket
      |> assign(:selected_category, selected_category)
      |> assign(:current_page, 1)
    }
  end

  @impl true
  def handle_event("load_more", _, socket) do
    {:noreply, assign(socket, :current_page, socket.assigns.current_page + 1)}
  end

  @impl true
  def handle_event("subscribe", %{"email" => email}, socket) do
    # Simulate subscription process
    Process.send_after(self(), {:subscription_result, email, true}, 1000)

    {:noreply,
      socket
      |> assign(:is_subscribing, true)
      |> assign(:subscription_message, nil)
    }
  end

  @impl true
  def handle_info({:subscription_result, email, success}, socket) do
    message = if success do
      "Successfully subscribed! Check your email for confirmation."
    else
      "Something went wrong. Please try again."
    end

    {:noreply,
      socket
      |> assign(:is_subscribing, false)
      |> assign(:subscription_message, message)
      |> assign(:subscription_success, success)
      |> assign(:email, if(success, do: "", else: email))
    }
  end

  defp assign_posts(socket) do
    case fetch_posts() do
      {:ok, posts} ->
        socket
        |> assign(:posts, posts)
        |> assign_filtered_posts()
        |> assign_categories()
        |> assign_featured_post()
      {:error, _reason} ->
        socket
        |> assign(:posts, fallback_posts())
        |> assign_filtered_posts()
        |> assign_categories()
        |> assign_featured_post()
    end
  end

  defp assign_filtered_posts(socket) do
    %{posts: posts, search_query: search_query, selected_category: selected_category,
      current_page: current_page, posts_per_page: posts_per_page} = socket.assigns

    featured_post = Enum.find(posts, &(&1["featured"])) || List.first(posts)

    filtered_posts =
      posts
      |> Enum.filter(fn post ->
        post != featured_post
      end)
      |> filter_by_search(search_query)
      |> filter_by_category(selected_category)
      |> Enum.sort_by(fn post ->
        {:desc, parse_date(post["date"])}
      end)

    displayed_posts = Enum.take(filtered_posts, current_page * posts_per_page)
    has_more_posts = length(filtered_posts) > length(displayed_posts)

    socket
    |> assign(:filtered_posts, filtered_posts)
    |> assign(:displayed_posts, displayed_posts)
    |> assign(:has_more_posts, has_more_posts)
  end

  defp filter_by_search(posts, ""), do: posts
  defp filter_by_search(posts, search_query) do
    query = String.downcase(search_query)

    Enum.filter(posts, fn post ->
      title = String.downcase(post["title"] || "")
      description = String.downcase(post["description"] || "")
      tags = post["tags"] || []

      String.contains?(title, query) ||
      String.contains?(description, query) ||
      Enum.any?(tags, &String.contains?(String.downcase(&1), query))
    end)
  end

  defp filter_by_category(posts, ""), do: posts
  defp filter_by_category(posts, category) do
    Enum.filter(posts, fn post ->
      tags = post["tags"] || []
      Enum.member?(tags, category)
    end)
  end

  defp assign_categories(socket) do
    categories =
      socket.assigns.posts
      |> Enum.flat_map(fn post -> post["tags"] || [] end)
      |> Enum.uniq()
      |> Enum.sort()

    assign(socket, :categories, categories)
  end

  defp assign_featured_post(socket) do
    featured_post =
      socket.assigns.posts
      |> Enum.find(&(&1["featured"]))
      || List.first(socket.assigns.posts)

    assign(socket, :featured_post, featured_post)
  end

  defp parse_date(date_string) when is_binary(date_string) do
    # Ghost CMS dates may include time and timezone info
    # Extract just the date part (YYYY-MM-DD) and parse it
    case Regex.run(~r/^(\d{4}-\d{2}-\d{2})/, date_string) do
      [_, date_part] ->
        case Date.from_iso8601(date_part) do
          {:ok, date} -> date
          _ -> Date.utc_today()
        end
      _ ->
        Date.utc_today()
    end
  end

  defp parse_date(_), do: Date.utc_today()

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

  defp fallback_posts do
    [
      %{
        "title" => "Interactive Data Visualization Techniques",
        "slug" => "data-visualization",
        "description" => "Exploring modern approaches to creating engaging and informative data visualizations for complex datasets.",
        "date" => "2023-04-22",
        "readingTime" => "10 min read",
        "tags" => ["Development", "Data", "UX"],
        "featured" => true,
        "thumbnail" => "https://images.unsplash.com/photo-1551650975-87deedd944c3?w=400&h=240&fit=crop"
      },
      %{
        "title" => "The Future of Design Systems",
        "slug" => "design-systems",
        "description" => "How design systems are evolving to meet the needs of modern product teams and cross-platform experiences.",
        "date" => "2023-03-15",
        "readingTime" => "8 min read",
        "tags" => ["Design", "Systems", "Product"],
        "featured" => false,
        "thumbnail" => "https://images.unsplash.com/photo-1558655146-9f40138edfeb?w=400&h=240&fit=crop"
      }
    ]
  end
end
