defmodule AlexWebsite.MixProject do
  use Mix.Project

  def project do
    [
      app: :alex_website,
      version: "0.1.0",
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      releases: releases(),
      # Dialyzer configuration
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        ignore_warnings: ".dialyzer_ignore.exs"
      ],
      # Test coverage configuration
      preferred_cli_env: [
        quality: :test,
        "quality.ci": :test,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {AlexWebsite.Application, []},
      extra_applications: [
        :logger,
        :runtime_tools,
        :ueberauth,
        :ueberauth_identity,
        :guardian
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Phoenix Framework and essentials
      {:phoenix, "~> 1.7.10"},
      {:dns_cluster, "~> 0.1.1"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.20.1"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.2"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},

      # Email
      {:swoosh, "~> 1.3"},
      {:finch, "~> 0.13"},

      # Authentication & Authorization
      {:argon2_elixir, "~> 3.0"},
      {:ueberauth, "~> 0.10.0"},
      {:ueberauth_identity, "~> 0.4.0"},
      {:guardian, "~> 2.3"},

      # Development tools
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.31.0", only: :dev, runtime: false},
      {:sobelow, "~> 0.14", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18", only: :test},
      {:hackney, "~> 1.18"},
      {:tidewave, "~> 0.4", only: :dev},

      # Ghost CMS integration
      {:ghost_content, "~> 0.1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp releases do
    [
      alex_website: [
        include_executables_for: [:unix],
        applications: [
          runtime_tools: :permanent
        ],
        steps: [:assemble, :tar]
      ]
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],

      # Asset management aliases
      "assets.setup": ["cmd bun install --cwd assets"],
      "assets.build": ["cmd --cd assets bun run build"],
      "assets.deploy": ["cmd --cd assets bun run deploy", "phx.digest"],

      # Quality check aliases
      quality: [
        "compile --all-warnings --warnings-as-errors",
        "test",
        "format",
        "credo --strict",
        "sobelow --verbose",
        "dialyzer --ignore-exit-status"
      ],
      "quality.ci": [
        "compile --all-warnings --warnings-as-errors",
        "test --slowest 10",
        "format --check-formatted",
        "credo --strict",
        "sobelow --exit",
        "dialyzer"
      ],
      "test.coverage": ["coveralls.html"]
    ]
  end
end
