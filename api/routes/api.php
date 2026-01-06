<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\EventController;
use App\Http\Controllers\Api\FavoriteController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {
    // Public routes
    Route::post('/login', [AuthController::class, 'login']);

    /**
     * Events (Public)
     */
    Route::get('/events', [EventController::class, 'index']);
    Route::get('/events/{slug}', [EventController::class, 'show']);

    // Protected routes
    Route::middleware('auth:sanctum')->group(function () {
        Route::get('/me', [AuthController::class, 'me']);
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::get('/favorites', [FavoriteController::class, 'index']);
        Route::post('/favorites/{event}', [FavoriteController::class, 'store']);
        Route::delete('/favorites/{event}', [FavoriteController::class, 'destroy']);

        /*
        |--------------------------------------------------------------------------
        | EVENTS (ORGANIZER / ADMIN)
        |--------------------------------------------------------------------------
        */
        Route::middleware('role:admin|organizer')->group(function () {
            Route::post('/events', [EventController::class, 'store']);
            Route::put('/events/{event}', [EventController::class, 'update']);
            Route::delete('/events/{event}', [EventController::class, 'destroy']);
        });
    });
});
