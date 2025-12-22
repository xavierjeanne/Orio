export default function Home() {
  return (
    <main className="min-h-screen p-8">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-4xl font-bold mb-4">
          🎉 Orio - Agrégateur d&apos;événements
        </h1>
        <p className="text-xl text-gray-600 mb-8">
          Bienvenue dans votre future plateforme de découverte d&apos;événements !
        </p>
        
        <div className="grid md:grid-cols-2 gap-6">
          <div className="p-6 border rounded-lg">
            <h2 className="text-2xl font-semibold mb-3">✅ Phase 1 - En cours</h2>
            <ul className="space-y-2">
              <li>✓ Repo GitHub</li>
              <li>✓ Docker compose</li>
              <li>✓ Laravel API</li>
              <li>✓ Next.js</li>
            </ul>
          </div>
          
          <div className="p-6 border rounded-lg bg-gray-50">
            <h2 className="text-2xl font-semibold mb-3">🔜 À venir</h2>
            <ul className="space-y-2 text-gray-700">
              <li>• Auth + RBAC</li>
              <li>• Events + venues</li>
              <li>• Géolocalisation</li>
              <li>• Carte interactive</li>
              <li>• Scraper Python</li>
            </ul>
          </div>
        </div>
      </div>
    </main>
  )
}
