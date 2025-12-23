<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Place extends Model
{
    protected $fillable = [
        'place_type_id',
        'city_id',
        'name',
        'slug',
        'description',
        'address',
        'phone',
        'website_url',
        'opening_hours',
        'latitude',
        'longitude',
        'meta_title',
        'meta_description',
    ];

    protected $casts = [
        'latitude' => 'decimal:7',
        'longitude' => 'decimal:7',
    ];

    public function placeType(): BelongsTo
    {
        return $this->belongsTo(PlaceType::class);
    }

    public function city(): BelongsTo
    {
        return $this->belongsTo(City::class);
    }

    public function events(): HasMany
    {
        return $this->hasMany(Event::class);
    }

    public function favoritedByUsers(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'user_place_favorites')
            ->withTimestamps();
    }
}
