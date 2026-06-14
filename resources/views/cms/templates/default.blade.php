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
    <div class="max-w-4xl mx-auto py-12 px-4">
        <h1 class="text-4xl font-bold mb-8">{{ $page->title }}</h1>
        <div class="prose max-w-none">
            {!! nl2br(e($page->content)) !!}
        </div>
    </div>
</body>
</html>
