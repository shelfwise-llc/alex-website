#!/usr/bin/env node

import * as esbuild from 'esbuild'
import { readFileSync } from 'fs'

const args = process.argv.slice(2)
const watch = args.includes('--watch')
const deploy = args.includes('--deploy')

const loader = {
  '.js': 'jsx',
  '.ts': 'tsx',
}

const plugins = [
  {
    name: 'phoenix-paths',
    setup(build) {
      build.onResolve({ filter: /^~/ }, (args) => {
        return {
          path: args.path.slice(1),
          namespace: 'phoenix-paths'
        }
      })
    }
  }
]

// JavaScript build configuration  
const jsOptions = {
  entryPoints: ['js/app.js'],
  bundle: true,
  target: 'es2020',
  outdir: '../priv/static/assets',
  external: ['*.png', '*.jpg', '*.jpeg', '*.gif', '*.svg'],
  minify: deploy,
  sourcemap: watch ? 'inline' : false,
  loader: loader,
  plugins: plugins
}

if (watch) {
  // Watch mode
  let jsCtx = await esbuild.context(jsOptions)
  await jsCtx.watch()
  
  console.log('👀 Watching for changes...')
  
  // Keep the process running
  process.stdin.resume()
} else {
  // Build mode
  try {
    await esbuild.build(jsOptions)
    console.log('✅ Assets built successfully!')
  } catch (error) {
    console.error('❌ Build failed:', error)
    process.exit(1)
  }
}
