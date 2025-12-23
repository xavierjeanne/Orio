<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class FavoriteController extends Controller
{
    /**
     * Display a listing of the user's favorite events.
     */
    public function index(Request $request)
    {
        $user = $request->user();
        $favorites = $user->favoriteEvents()->with('category')->get();

        return response()->json($favorites, Response::HTTP_OK);
    }

    /**
     * Add an event to the user's favorites.
     */
    public function store(Request $request, Event $event)
    {
        $user = $request->user();
        $user->favoriteEvents()->syncWithoutDetaching([$event->id]);

        return response()->json(['message' => 'Event added to favorites.'], Response::HTTP_CREATED);
    }

    /**
     * Remove an event from the user's favorites.
     */
    public function destroy(Request $request, Event $event)
    {
        $user = $request->user();
        $user->favoriteEvents()->detach($event->id);

        return response()->json(['message' => 'Event removed from favorites.'], Response::HTTP_OK);
    }
}
