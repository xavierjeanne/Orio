<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Role;
use App\Models\Category;
use App\Models\Tag;
use App\Models\City;
use App\Models\PlaceType;
use App\Models\Place;
use App\Models\Event;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Roles
        $adminRole = Role::firstOrCreate(['name' => 'admin']);
        $organizerRole = Role::firstOrCreate(['name' => 'organizer']);
        $userRole = Role::firstOrCreate(['name' => 'user']);

        // Users
        $admin = User::firstOrCreate(
            ['email' => 'admin@orio.fr'],
            [
                'name' => 'Admin User',
                'password' => bcrypt('password'),
                'role_id' => $adminRole->id,
            ]
        );

        $organizer = User::firstOrCreate(
            ['email' => 'organizer@orio.fr'],
            [
                'name' => 'Organizer',
                'password' => bcrypt('password'),
                'role_id' => $organizerRole->id,
            ]
        );

        // Categories
        $categories = [
            ['name' => 'Concerts', 'slug' => 'concerts'],
            ['name' => 'Théâtre', 'slug' => 'theatre'],
            ['name' => 'Sport', 'slug' => 'sport'],
            ['name' => 'Expositions', 'slug' => 'expositions'],
            ['name' => 'Conférences', 'slug' => 'conferences'],
            ['name' => 'Festivals', 'slug' => 'festivals'],
        ];

        foreach ($categories as $category) {
            Category::firstOrCreate(
                ['slug' => $category['slug']],
                [
                    'name' => $category['name'],
                    'meta_title' => 'Événements ' . $category['name'],
                    'meta_description' => 'Découvrez tous les événements de ' . $category['name'],
                ]
            );
        }

        // Tags
        $tags = ['rock', 'jazz', 'classique', 'gratuit', 'famille', 'outdoor', 'indoor', 'weekend'];
        foreach ($tags as $tagName) {
            Tag::firstOrCreate(
                ['slug' => $tagName],
                ['name' => ucfirst($tagName)]
            );
        }

        // Cities
        $cities = [
            ['name' => 'Paris', 'postal_code' => '75000'],
            ['name' => 'Lyon', 'postal_code' => '69000'],
            ['name' => 'Marseille', 'postal_code' => '13000'],
            ['name' => 'Toulouse', 'postal_code' => '31000'],
            ['name' => 'Nice', 'postal_code' => '06000'],
        ];

        foreach ($cities as $city) {
            City::firstOrCreate(
                ['name' => $city['name']],
                ['postal_code' => $city['postal_code']]
            );
        }

        // Place Types
        $placeTypes = [
            ['name' => 'Salle de concert', 'slug' => 'salle-concert'],
            ['name' => 'Théâtre', 'slug' => 'theatre'],
            ['name' => 'Stade', 'slug' => 'stade'],
            ['name' => 'Musée', 'slug' => 'musee'],
            ['name' => 'Parc', 'slug' => 'parc'],
            ['name' => 'Bar/Club', 'slug' => 'bar-club'],
        ];

        foreach ($placeTypes as $type) {
            PlaceType::firstOrCreate(
                ['slug' => $type['slug']],
                ['name' => $type['name']]
            );
        }

        // Places
        $concertHall = Place::firstOrCreate(
            ['slug' => 'olympia-paris'],
            [
                'place_type_id' => PlaceType::where('slug', 'salle-concert')->first()->id,
                'city_id' => City::where('name', 'Paris')->first()->id,
                'name' => 'Olympia',
                'description' => 'Salle de spectacle mythique parisienne',
                'address' => '28 Boulevard des Capucines, 75009 Paris',
                'phone' => '01 47 42 25 49',
                'website_url' => 'https://www.olympiahall.com',
                'latitude' => 48.870556,
                'longitude' => 2.326944,
            ]
        );

        // Events
        $concertCategory = Category::where('slug', 'concerts')->first();
        $rockTag = Tag::where('slug', 'rock')->first();

        $event = Event::firstOrCreate(
            ['slug' => 'concert-rock-olympia'],
            [
                'user_id' => $organizer->id,
                'category_id' => $concertCategory->id,
                'place_id' => $concertHall->id,
                'title' => 'Concert de Rock',
                'description' => 'Une soirée exceptionnelle de rock au coeur de Paris',
                'start_date' => now()->addDays(7),
                'end_date' => now()->addDays(7)->addHours(3),
                'status' => 'published',
                'meta_title' => 'Concert de Rock à l\'Olympia',
                'meta_description' => 'Ne manquez pas ce concert exceptionnel',
            ]
        );

        // Attach tags if not already attached
        if (!$event->tags()->where('tags.id', $rockTag->id)->exists()) {
            $event->tags()->attach($rockTag);
        }

        $this->command->info('Database seeded successfully!');
    }
}
