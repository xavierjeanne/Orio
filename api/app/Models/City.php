<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class City extends Model
{
    protected $fillable = ['name', 'postal_code'];

    public function places(): HasMany
    {
        return $this->hasMany(Place::class);
    }
}
