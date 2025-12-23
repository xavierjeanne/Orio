interface Event {
  id: number;
  title: string;
  slug: string;
  description: string;
  start_date: string;
  end_date: string;
  status: string;
  category: {
    id: number;
    name: string;
    slug: string;
  };
  place: {
    id: number;
    name: string;
    address: string;
    city: string;
  };
  tags: Array<{
    id: number;
    name: string;
    slug: string;
  }>;
}

interface ApiResponse {
  data: Event[];
  links: {
    first: string;
    last: string;
    prev: string | null;
    next: string | null;
  };
  meta: {
    current_page: number;
    total: number;
  };
}

async function getEvents(): Promise<ApiResponse> {
  const res = await fetch('http://api:8000/api/v1/events', {
    cache: 'no-store',
  });
  
  if (!res.ok) {
    throw new Error('Failed to fetch events');
  }
  
  return res.json();
}

export default async function Home() {
  let events: Event[] = [];
  let error = null;

  try {
    const data = await getEvents();
    events = data.data;
  } catch (e) {
    error = e instanceof Error ? e.message : 'An error occurred';
  }

  return (
    <main className="min-h-screen p-8 bg-gray-50">
      <div className="max-w-6xl mx-auto">
        <header className="mb-8">
          <h1 className="text-4xl font-bold mb-2 text-gray-900">
            🎉 Orio - Agrégateur d&apos;événements
          </h1>
          <p className="text-xl text-gray-600">
            Découvrez les événements à venir près de chez vous
          </p>
        </header>

        {error && (
          <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
            <p className="font-bold">Erreur</p>
            <p>{error}</p>
          </div>
        )}

        <div className="mb-6">
          <h2 className="text-2xl font-semibold mb-4">Événements à venir</h2>
          
          {events.length === 0 && !error ? (
            <p className="text-gray-600">Aucun événement à afficher pour le moment.</p>
          ) : (
            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
              {events.map((event) => (
                <article 
                  key={event.id}
                  className="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow"
                >
                  <div className="p-6">
                    <div className="flex items-start justify-between mb-3">
                      <span className="inline-block px-3 py-1 text-sm font-semibold text-white bg-blue-500 rounded-full">
                        {event.category.name}
                      </span>
                      <span className="text-xs text-gray-500">
                        {new Date(event.start_date).toLocaleDateString('fr-FR')}
                      </span>
                    </div>
                    
                    <h3 className="text-xl font-bold mb-2 text-gray-900">
                      {event.title}
                    </h3>
                    
                    <p className="text-gray-600 mb-4 line-clamp-2">
                      {event.description}
                    </p>
                    
                    <div className="border-t pt-4">
                      <div className="flex items-center text-sm text-gray-500 mb-2">
                        <span className="mr-2">📍</span>
                        <span>{event.place.name}, {event.place.city}</span>
                      </div>
                      
                      {event.tags && event.tags.length > 0 && (
                        <div className="flex flex-wrap gap-2">
                          {event.tags.map((tag) => (
                            <span 
                              key={tag.id}
                              className="px-2 py-1 text-xs bg-gray-100 text-gray-600 rounded"
                            >
                              {tag.name}
                            </span>
                          ))}
                        </div>
                      )}
                    </div>
                  </div>
                </article>
              ))}
            </div>
          )}
        </div>
      </div>
    </main>
  );
}
        
