<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use App\Resources\EventResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class EventController extends Controller
{
    /**
     * Display list of event
     *
     * @return void
     */
    public function index()
    {
        return EventResource::collection(
            Event::with(['category', 'place.city', 'tags'])
                ->where('start_date', '>', now())
                ->orderBy('start_date', 'asc')
                ->paginate(20)
        );
    }

    /**
     * Store a newly created event in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'date' => 'required|date',
            'location' => 'required|string|max:255',
            'category_id' => 'required|exists:categories,id',
        ]);

        $event = Event::create([
            'title' => $request->title,
            'description' => $request->description,
            'date' => $request->date,
            'location' => $request->location,
            'category_id' => $request->category_id,
            'organizer_id' => Auth::id(),
        ]);

        return new EventResource($event);
    }

    /**
     * Display the specified event.
     *
     * @return \App\Resources\EventResource
     */
    public function show(string $slug)
    {
        return new EventResource(
            Event::where('slug', $slug)->firstOrFail()
        );
    }
}
