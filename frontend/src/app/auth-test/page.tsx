'use client';

import { useState } from 'react';

interface User {
  id: number;
  name: string;
  email: string;
  role: {
    id: number;
    name: string;
  };
}

export default function AuthTestPage() {
  const [email, setEmail] = useState('admin@orio.fr');
  const [password, setPassword] = useState('password');
  const [token, setToken] = useState<string | null>(null);
  const [user, setUser] = useState<User | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000';

  const handleLogin = async () => {
    console.log('🔐 handleLogin called');
    setLoading(true);
    setError(null);
    
    try {
      console.log('📡 Fetching:', `${API_URL}/api/v1/login`);
      const response = await fetch(`${API_URL}/api/v1/login`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: JSON.stringify({ email, password }),
        credentials: 'omit', // Important: ne pas envoyer de cookies
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || 'Login failed');
      }

      setToken(data.token);
      setUser(data.user);
      setError(null);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : 'Login failed');
      setToken(null);
      setUser(null);
    } finally {
      setLoading(false);
    }
  };

  const handleGetUser = async () => {
    if (!token) {
      setError('No token available');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const response = await fetch(`${API_URL}/api/v1/me`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        credentials: 'omit',
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || 'Failed to get user');
      }

      setUser(data.user);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : 'Failed to get user');
    } finally {
      setLoading(false);
    }
  };

  const handleLogout = async () => {
    if (!token) {
      setError('No token available');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const response = await fetch(`${API_URL}/api/v1/logout`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        credentials: 'omit',
      });

      if (!response.ok) {
        throw new Error('Logout failed');
      }

      setToken(null);
      setUser(null);
      setError(null);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : 'Logout failed');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 p-8">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-3xl font-bold mb-8">🔐 Test Sanctum Authentication</h1>

        {/* Status */}
        <div className="mb-6 p-4 bg-white rounded-lg shadow">
          <h2 className="text-xl font-semibold mb-2">Status</h2>
          <p className="text-sm">
            <strong>API URL:</strong> {API_URL}
          </p>
          <p className="text-sm">
            <strong>Authentifié:</strong>{' '}
            {token ? (
              <span className="text-green-600">✓ Oui</span>
            ) : (
              <span className="text-red-600">✗ Non</span>
            )}
          </p>
          {token && (
            <div className="mt-2">
              <p className="text-xs text-gray-600 break-all">
                <strong>Token:</strong> {token.substring(0, 50)}...
              </p>
            </div>
          )}
        </div>

        {/* Error Display */}
        {error && (
          <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-lg">
            <p className="text-red-600">❌ {error}</p>
          </div>
        )}

        {/* User Display */}
        {user && (
          <div className="mb-6 p-4 bg-green-50 border border-green-200 rounded-lg">
            <h3 className="font-semibold mb-2">👤 Utilisateur connecté:</h3>
            <p><strong>ID:</strong> {user.id}</p>
            <p><strong>Nom:</strong> {user.name}</p>
            <p><strong>Email:</strong> {user.email}</p>
            <p><strong>Rôle:</strong> {user.role.name}</p>
          </div>
        )}

        {/* Login Form */}
        {!token && (
          <div className="mb-6 p-6 bg-white rounded-lg shadow">
            <h2 className="text-xl font-semibold mb-4">Connexion</h2>
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium mb-1">Email</label>
                <input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  placeholder="admin@orio.fr"
                />
              </div>
              <div>
                <label className="block text-sm font-medium mb-1">Mot de passe</label>
                <input
                  type="password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  placeholder="password"
                />
              </div>
              <button
                onClick={handleLogin}
                disabled={loading}
                className="w-full bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 disabled:bg-gray-400"
              >
                {loading ? 'Connexion...' : 'Se connecter'}
              </button>
            </div>
            <div className="mt-4 p-3 bg-gray-50 rounded text-sm">
              <p className="font-semibold mb-1">Comptes de test:</p>
              <ul className="text-xs space-y-1">
                <li>👑 <strong>Admin:</strong> admin@orio.fr / password</li>
                <li>🎪 <strong>Organizer:</strong> organizer@orio.fr / password</li>
              </ul>
            </div>
          </div>
        )}

        {/* Actions */}
        {token && (
          <div className="mb-6 p-6 bg-white rounded-lg shadow">
            <h2 className="text-xl font-semibold mb-4">Actions</h2>
            <div className="space-y-2">
              <button
                onClick={handleGetUser}
                disabled={loading}
                className="w-full bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 disabled:bg-gray-400"
              >
                {loading ? 'Chargement...' : '🔄 Rafraîchir les infos utilisateur'}
              </button>
              <button
                onClick={handleLogout}
                disabled={loading}
                className="w-full bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 disabled:bg-gray-400"
              >
                {loading ? 'Déconnexion...' : '🚪 Se déconnecter'}
              </button>
            </div>
          </div>
        )}

        {/* API Endpoints Info */}
        <div className="p-6 bg-white rounded-lg shadow">
          <h2 className="text-xl font-semibold mb-4">📡 Endpoints API testés</h2>
          <ul className="space-y-2 text-sm">
            <li className="p-2 bg-gray-50 rounded">
              <strong>POST</strong> /api/v1/login
            </li>
            <li className="p-2 bg-gray-50 rounded">
              <strong>GET</strong> /api/v1/me (protégé)
            </li>
            <li className="p-2 bg-gray-50 rounded">
              <strong>POST</strong> /api/v1/logout (protégé)
            </li>
          </ul>
        </div>
      </div>
    </div>
  );
}
