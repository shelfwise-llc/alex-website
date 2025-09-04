defmodule AlexWebsiteWeb.NowLive do
  use AlexWebsiteWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "What I'm Doing Now")}
  end

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-white text-gray-900" style="font-family: 'Inter', sans-serif;">
      <!-- Navigation -->
      <nav class="fixed top-0 left-0 right-0 bg-white/80 backdrop-blur-md border-b border-gray-100 z-50">
        <div class="max-w-6xl mx-auto px-6 py-4">
          <div class="flex items-center justify-between">
            <.link navigate={~p"/"} class="text-lg font-medium tracking-tight bg-gradient-to-r from-purple-500 to-pink-500 bg-clip-text text-transparent">AC</.link>
            <div class="hidden md:flex items-center space-x-8">
              <.link navigate={~p"/work"} class="text-sm text-gray-600 hover:text-gray-900 transition-colors">Work</.link>
              <.link navigate={~p"/about"} class="text-sm text-gray-600 hover:text-gray-900 transition-colors">About</.link>
              <.link navigate={~p"/now"} class="text-sm text-gray-900 font-medium relative">
                <span>Now</span>
                <div class="absolute -top-1 -right-2 w-2 h-2 bg-green-400 rounded-full animate-pulse"></div>
              </.link>
              <.link navigate={~p"/blog"} class="text-sm text-gray-600 hover:text-gray-900 transition-colors">Blog</.link>
              <.link navigate={~p"/contact"} class="px-4 py-2 text-sm font-medium text-white rounded-full bg-gradient-to-r from-purple-500 to-pink-500 hover:shadow-lg hover:shadow-purple-500/25 transform hover:-translate-y-0.5 transition-all duration-300">Contact</.link>
            </div>
          </div>
        </div>
      </nav>

      <!-- Main Content -->
      <main class="pt-24 pb-16">
        <div class="max-w-4xl mx-auto px-6">
          <!-- Hero Section -->
          <div class="text-center mb-16">
            <div class="inline-flex items-center px-4 py-2 bg-green-50 border border-green-200 rounded-full text-green-700 text-sm font-medium mb-6">
              <div class="w-2 h-2 bg-green-500 rounded-full animate-pulse mr-2"></div>
              Last updated: <%= Date.utc_today() |> Calendar.strftime("%B %d, %Y") %>
            </div>
            <h1 class="text-4xl md:text-5xl font-bold mb-6 bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
              What I'm Doing Now
            </h1>
            <p class="text-xl text-gray-600 max-w-2xl mx-auto leading-relaxed">
              A glimpse into my current projects, learning journey, and life priorities. Inspired by Derek Sivers' 
              <a href="https://nownownow.com" target="_blank" class="text-purple-600 hover:text-purple-700 underline">Now page movement</a>.
            </p>
          </div>

          <!-- Current Projects -->
          <div class="mb-16">
            <h2 class="text-3xl font-bold mb-8 flex items-center">
              <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center mr-3">
                <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path>
                </svg>
              </div>
              Current Projects
            </h2>
            
            <div class="grid md:grid-cols-2 gap-6">
              <div class="p-6 bg-gradient-to-br from-blue-50 to-indigo-50 rounded-2xl border border-blue-100">
                <h3 class="text-xl font-semibold text-gray-900 mb-3">Phoenix LiveView Portfolio</h3>
                <p class="text-gray-600 mb-4">Building a modern portfolio website using Phoenix LiveView with Ghost CMS integration. Migrating from Nuxt.js to explore Elixir's capabilities for real-time web applications.</p>
                <div class="flex flex-wrap gap-2">
                  <span class="px-2 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Phoenix</span>
                  <span class="px-2 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Elixir</span>
                  <span class="px-2 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">Ghost CMS</span>
                </div>
              </div>

              <div class="p-6 bg-gradient-to-br from-green-50 to-emerald-50 rounded-2xl border border-green-100">
                <h3 class="text-xl font-semibold text-gray-900 mb-3">Data Visualization Dashboard</h3>
                <p class="text-gray-600 mb-4">Developing an interactive analytics dashboard for client projects. Focusing on making complex data accessible through intuitive visualizations and real-time updates.</p>
                <div class="flex flex-wrap gap-2">
                  <span class="px-2 py-1 bg-green-100 text-green-700 text-xs rounded-full">D3.js</span>
                  <span class="px-2 py-1 bg-green-100 text-green-700 text-xs rounded-full">React</span>
                  <span class="px-2 py-1 bg-green-100 text-green-700 text-xs rounded-full">TypeScript</span>
                </div>
              </div>
            </div>
          </div>

          <!-- Learning -->
          <div class="mb-16">
            <h2 class="text-3xl font-bold mb-8 flex items-center">
              <div class="w-8 h-8 bg-purple-100 rounded-lg flex items-center justify-center mr-3">
                <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                </svg>
              </div>
              Currently Learning
            </h2>
            
            <div class="grid md:grid-cols-3 gap-6">
              <div class="p-6 bg-gradient-to-br from-purple-50 to-pink-50 rounded-2xl border border-purple-100">
                <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mb-4">
                  <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path>
                  </svg>
                </div>
                <h3 class="font-semibold text-gray-900 mb-2">Elixir & OTP</h3>
                <p class="text-sm text-gray-600">Diving deep into functional programming concepts and the Actor model for building fault-tolerant systems.</p>
              </div>

              <div class="p-6 bg-gradient-to-br from-orange-50 to-red-50 rounded-2xl border border-orange-100">
                <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                  <svg class="w-6 h-6 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                  </svg>
                </div>
                <h3 class="font-semibold text-gray-900 mb-2">Machine Learning</h3>
                <p class="text-sm text-gray-600">Exploring ML applications in web development, particularly for data analysis and user experience personalization.</p>
              </div>

              <div class="p-6 bg-gradient-to-br from-teal-50 to-cyan-50 rounded-2xl border border-teal-100">
                <div class="w-12 h-12 bg-teal-100 rounded-lg flex items-center justify-center mb-4">
                  <svg class="w-6 h-6 text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9v-9m0-9v9m0 9h9M3 12a9 9 0 019-9"></path>
                  </svg>
                </div>
                <h3 class="font-semibold text-gray-900 mb-2">Web3 & Blockchain</h3>
                <p class="text-sm text-gray-600">Understanding decentralized technologies and their potential impact on user privacy and data ownership.</p>
              </div>
            </div>
          </div>

          <!-- Personal -->
          <div class="mb-16">
            <h2 class="text-3xl font-bold mb-8 flex items-center">
              <div class="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center mr-3">
                <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                </svg>
              </div>
              Life & Personal
            </h2>
            
            <div class="grid md:grid-cols-2 gap-6">
              <div class="p-6 bg-gray-50 rounded-2xl">
                <h3 class="text-xl font-semibold text-gray-900 mb-4">Reading</h3>
                <div class="space-y-3">
                  <div class="flex items-start">
                    <div class="w-2 h-2 bg-green-500 rounded-full mt-2 mr-3 flex-shrink-0"></div>
                    <div>
                      <p class="font-medium text-gray-900">Programming Phoenix LiveView</p>
                      <p class="text-sm text-gray-600">By Bruce Tate & Sophie DeBenedetto</p>
                    </div>
                  </div>
                  <div class="flex items-start">
                    <div class="w-2 h-2 bg-yellow-500 rounded-full mt-2 mr-3 flex-shrink-0"></div>
                    <div>
                      <p class="font-medium text-gray-900">The Design of Everyday Things</p>
                      <p class="text-sm text-gray-600">By Don Norman</p>
                    </div>
                  </div>
                </div>
              </div>

              <div class="p-6 bg-gray-50 rounded-2xl">
                <h3 class="text-xl font-semibold text-gray-900 mb-4">Current Focus</h3>
                <ul class="space-y-3 text-gray-600">
                  <li class="flex items-center">
                    <svg class="w-4 h-4 text-green-500 mr-3" fill="currentColor" viewBox="0 0 20 20">
                      <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                    </svg>
                    Building better work-life balance
                  </li>
                  <li class="flex items-center">
                    <svg class="w-4 h-4 text-green-500 mr-3" fill="currentColor" viewBox="0 0 20 20">
                      <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                    </svg>
                    Regular hiking and outdoor activities
                  </li>
                  <li class="flex items-center">
                    <svg class="w-4 h-4 text-green-500 mr-3" fill="currentColor" viewBox="0 0 20 20">
                      <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                    </svg>
                    Contributing to open source projects
                  </li>
                  <li class="flex items-center">
                    <svg class="w-4 h-4 text-green-500 mr-3" fill="currentColor" viewBox="0 0 20 20">
                      <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                    </svg>
                    Learning to play guitar
                  </li>
                </ul>
              </div>
            </div>
          </div>

          <!-- Location & Availability -->
          <div class="text-center">
            <div class="p-8 bg-gradient-to-br from-purple-50 to-pink-50 rounded-2xl border border-purple-100">
              <h2 class="text-2xl font-bold mb-4 text-gray-900">Where I Am</h2>
              <p class="text-gray-600 mb-2">📍 Currently based in Nairobi, Kenya</p>
              <p class="text-gray-600 mb-6">🌍 Available for remote collaborations worldwide</p>
              
              <div class="inline-flex items-center px-4 py-2 bg-green-100 text-green-700 rounded-full text-sm font-medium">
                <div class="w-2 h-2 bg-green-500 rounded-full mr-2"></div>
                Open for new opportunities
              </div>
            </div>
          </div>
        </div>
      </main>

      <!-- Footer -->
      <footer class="border-t border-gray-100 px-6 py-8">
        <div class="max-w-6xl mx-auto flex flex-col sm:flex-row items-center justify-between text-sm text-gray-500">
          <div><%= Date.utc_today.year %> Alex Cosmas. All rights reserved.</div>
          <div class="flex items-center space-x-6 mt-4 sm:mt-0">
            <a href="https://twitter.com/alexcosmas" target="_blank" class="hover:text-gray-900 transition-colors">
              <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"/>
              </svg>
            </a>
            <a href="https://github.com/alexcosmas" target="_blank" class="hover:text-gray-900 transition-colors">
              <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
              </svg>
            </a>
            <a href="https://linkedin.com/in/alexcosmas" target="_blank" class="hover:text-gray-900 transition-colors">
              <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
              </svg>
            </a>
          </div>
        </div>
      </footer>
    </div>
    """
  end
end
