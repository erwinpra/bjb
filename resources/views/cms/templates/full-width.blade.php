<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ $page->meta_title ?: $page->title }} - {{ config('app.name') }}</title>
    <meta name="description" content="{{ $page->meta_description }}">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white font-sans antialiased">
    <div class="w-full">
        <div class="bg-gray-900 text-white py-16 px-4 text-center">
            <h1 class="text-5xl font-bold">{{ $page->title }}</h1>
        </div>
        <div class="max-w-6xl mx-auto py-12 px-4">
            <div class="prose max-w-none">
                {!! nl2br(e($page->content)) !!}
            </div>
        </div>
    </div>
</body>
</html>
