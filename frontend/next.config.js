/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  output: process.env.NODE_ENV === 'production' ? 'standalone' : undefined, // standalone uniquement en production
  env: {
    API_URL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000',
  },
  // Configuration pour le hot-reload dans Docker sur Windows
  webpack: (config, { dev }) => {
    if (dev) {
      config.watchOptions = {
        poll: 1000, // Vérifie les changements toutes les secondes
        aggregateTimeout: 300,
      }
    }
    return config
  },
}

module.exports = nextConfig
