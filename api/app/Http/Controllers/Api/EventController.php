<?php

namespace App\Http\Controllers\Api;

use App\Models\Event;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Resources\EventResource;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

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
     *
     * @param  \Illuminate\Http\Request  $request
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
     * @param  string  $slug
     * @return \App\Resources\EventResource
     */
    public function show(string $slug)
    {
        return new EventResource(
            Event::where('slug', $slug)->firstOrFail()
        );
    }
}
