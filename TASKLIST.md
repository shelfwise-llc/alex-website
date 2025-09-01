# Alex Website - Ghost CMS Integration Task List

## Project Overview
Integrating Ghost CMS as a headless content management system with the existing Phoenix/Elixir website (alex_website).

---

## ✅ Completed Tasks

### 1. Set up Ghost locally ✓
- **Status**: COMPLETED
- **Details**: Ghost v6.0.6 installed locally using Ghost CLI
- **Location**: `/home/alex/personal/ghost-cms/`
- **Access**: http://localhost:2368
- **Admin Panel**: http://localhost:2368/ghost/

### 2. Phoenix Project Setup ✓
- **Status**: COMPLETED  
- **Details**: Added ghost_content dependency to existing Phoenix project
- **Dependencies Added**:
  - `{:ghost_content, "~> 0.1.0"}` 
  - `{:httpoison, "~> 2.2.3"}` (dependency)
- **Phoenix Project**: `/home/alex/personal/V1/alex_website/`

### 3. Basic Phoenix-Ghost Integration ✓
- **Status**: COMPLETED
- **Details**: 
  - Added Ghost configuration to `config/config.exs`
  - Created blog routes (`/blog` and `/blog/:slug`)
  - Created `BlogLive.Index` and `BlogLive.Show` LiveViews
  - Added Ghost content CSS styling
  - Fixed compilation issues with gettext

---

## 🟡 Pending Tasks

### 4. Configure Ghost as headless CMS
- **Status**: IN PROGRESS
- **Next Steps**:
  - [ ] Complete Ghost admin setup at http://localhost:2368/ghost/
  - [ ] Create admin account with email: alexcosmasotieno@gmail.com
  - [ ] Set up custom integration in Ghost admin
  - [ ] Get Content API Key from Ghost
  - [ ] Update Phoenix config with real API key

### 5. Test Ghost-Phoenix Integration
- **Status**: PENDING
- **Next Steps**:
  - [ ] Create sample blog posts in Ghost
  - [ ] Test API connectivity from Phoenix
  - [ ] Verify blog index page works at `/blog`
  - [ ] Verify individual post pages work at `/blog/:slug`

### 6. Set up email configuration
- **Status**: PENDING
- **Details**: Configure Gmail SMTP for Ghost notifications
- **Requirements**: 
  - Gmail app password for alexcosmasotieno@gmail.com
  - Ghost mail configuration

### 7. Create Docker/Podman setup
- **Status**: PENDING
- **Details**: Create containerized setup for production
- **Files needed**:
  - `docker-compose.yml` for Ghost + Phoenix
  - `Dockerfile` for Phoenix app
  - Environment configuration

### 8. Production deployment
- **Status**: PENDING
- **Details**: Deploy to Contabo server (alex@38.242.219.222)
- **Domain**: alexcosmas.com
- **Requirements**:
  - Production Ghost instance
  - Phoenix app deployment
  - SSL/HTTPS setup
  - Environment variables

---

## ❌ Issues to Address

### 1. Node.js Version Management
- **Issue**: Ghost CLI requires specific Node.js versions
- **Current**: Using asdf with Node.js 22.13.1 in ghost-cms directory
- **Impact**: Need to ensure consistent Node.js version across environments

### 2. Gettext Configuration
- **Issue**: Fixed compilation errors by replacing gettext() calls with strings
- **Status**: RESOLVED (temporary fix)
- **Note**: Should properly configure gettext translations for production

### 3. Missing Docker Setup
- **Issue**: Docker not available in WSL environment
- **Impact**: Need alternative containerization approach or Docker setup
- **Solution**: Install Docker Desktop with WSL2 integration OR use Podman

---

## 🎯 Next Immediate Actions

1. **Set up Ghost Admin** (5 mins)
   - Visit http://localhost:2368/ghost/
   - Create admin account
   - Get API key

2. **Test Integration** (10 mins)
   - Update Phoenix config with real API key
   - Create test blog post in Ghost
   - Start Phoenix server and test `/blog` endpoint

3. **Push Code** (2 mins)
   - Git commit current changes
   - Push to upstream repository

---

## 📝 Environment Details

- **Local Ghost**: http://localhost:2368 (running)
- **Phoenix Dev Server**: http://localhost:4000 (ready to start)
- **Domain**: alexcosmas.com
- **Email**: alexcosmasotieno@gmail.com
- **Server**: alex@38.242.219.222 (Contabo)

---

## 🔧 Technical Stack

- **Backend**: Elixir/Phoenix with LiveView
- **CMS**: Ghost v6.0.6 (headless)
- **Database**: PostgreSQL (Phoenix), SQLite (Ghost local)
- **Deployment**: Contabo VPS
- **Containerization**: Docker/Podman (planned)

---

*Last Updated: September 1, 2025*
