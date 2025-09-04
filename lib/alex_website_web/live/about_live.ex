defmodule AlexWebsiteWeb.AboutLive do
  use AlexWebsiteWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "About Me")}
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
              <.link navigate={~p"/about"} class="text-sm text-gray-900 font-medium">About</.link>
              <.link navigate={~p"/now"} class="text-sm text-gray-600 hover:text-gray-900 transition-colors relative">
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
            <div class="inline-block p-1 bg-gradient-to-r from-purple-500 to-pink-500 rounded-full mb-8">
              <div class="w-32 h-32 bg-gray-200 rounded-full flex items-center justify-center">
                <span class="text-2xl font-bold text-gray-600">AC</span>
              </div>
            </div>
            <h1 class="text-4xl md:text-5xl font-bold mb-6 bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
              Hello, I'm Alex
            </h1>
            <p class="text-xl text-gray-600 max-w-2xl mx-auto leading-relaxed">
              I'm a passionate designer and developer with over 5 years of experience creating beautiful, functional websites and applications. My approach combines creative design thinking with technical expertise to deliver exceptional user experiences.
            </p>
          </div>

          <!-- Skills Section -->
          <div class="mb-16">
            <h2 class="text-3xl font-bold mb-8 text-center">My Skills</h2>
            <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
              <div class="p-6 bg-gradient-to-br from-blue-50 to-indigo-50 rounded-2xl border border-blue-100">
                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mb-4">
                  <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.75 17L9 20l-1 1h8l-1-1-.75-3M3 13h18M5 17h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                  </svg>
                </div>
                <h3 class="font-semibold text-gray-900 mb-2">UI/UX Design</h3>
                <p class="text-sm text-gray-600">Creating intuitive and beautiful user interfaces</p>
              </div>

              <div class="p-6 bg-gradient-to-br from-green-50 to-emerald-50 rounded-2xl border border-green-100">
                <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mb-4">
                  <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"></path>
                  </svg>
                </div>
                <h3 class="font-semibold text-gray-900 mb-2">Front-end Development</h3>
                <p class="text-sm text-gray-600">Building responsive and performant web applications</p>
              </div>

              <div class="p-6 bg-gradient-to-br from-purple-50 to-pink-50 rounded-2xl border border-purple-100">
                <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center mb-4">
                  <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z"></path>
                  </svg>
                </div>
                <h3 class="font-semibold text-gray-900 mb-2">Responsive Design</h3>
                <p class="text-sm text-gray-600">Ensuring great experiences across all devices</p>
              </div>

              <div class="p-6 bg-gradient-to-br from-orange-50 to-red-50 rounded-2xl border border-orange-100">
                <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                  <svg class="w-6 h-6 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17v4a2 2 0 002 2h4M15 5l4 4"></path>
                  </svg>
                </div>
                <h3 class="font-semibold text-gray-900 mb-2">Brand Identity</h3>
                <p class="text-sm text-gray-600">Developing cohesive visual brand experiences</p>
              </div>

              <div class="p-6 bg-gradient-to-br from-teal-50 to-cyan-50 rounded-2xl border border-teal-100">
                <div class="w-12 h-12 bg-teal-100 rounded-lg flex items-center justify-center mb-4">
                  <svg class="w-6 h-6 text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h1.5a.5.5 0 01.5.5v1a1.5 1.5 0 003 0v-1a.5.5 0 01.5-.5H16m-6 4h4"></path>
                  </svg>
                </div>
                <h3 class="font-semibold text-gray-900 mb-2">Motion Design</h3>
                <p class="text-sm text-gray-600">Adding life and personality through animation</p>
              </div>
            </div>
          </div>

          <!-- Philosophy Section -->
          <div class="text-center mb-16">
            <div class="max-w-3xl mx-auto">
              <h2 class="text-3xl font-bold mb-8">My Philosophy</h2>
              <p class="text-lg text-gray-600 leading-relaxed mb-8">
                I believe in creating work that not only looks great but also solves real problems for users. Every project is an opportunity to make someone's day a little easier, a little more enjoyable, or a little more meaningful.
              </p>
              <p class="text-lg text-gray-600 leading-relaxed">
                When I'm not designing or coding, you can find me hiking, reading, or experimenting with new creative tools. I'm always eager to learn and push the boundaries of what's possible.
              </p>
            </div>
          </div>

          <!-- CTA Section -->
          <div class="text-center">
            <div class="p-8 bg-gradient-to-br from-purple-50 to-pink-50 rounded-2xl border border-purple-100">
              <h2 class="text-2xl font-bold mb-4 text-gray-900">Let's Work Together</h2>
              <p class="text-gray-600 mb-6">Ready to bring your vision to life?</p>
              <.link navigate={~p"/contact"} class="inline-flex items-center px-6 py-3 text-white font-medium rounded-full bg-gradient-to-r from-purple-500 to-pink-500 hover:shadow-lg hover:shadow-purple-500/25 transform hover:-translate-y-0.5 transition-all duration-300">
                Get in Touch
                <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path>
                </svg>
              </.link>
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
