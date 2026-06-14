<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\Page;
use Illuminate\Http\Request;

class PageController extends Controller
{
    public function index()
    {
        $pages = Page::latest()->paginate(15);
        return view('cms::pages.index', compact('pages'));
    }

    public function create()
    {
        $templates = config('cms.page.templates', []);
        return view('cms::pages.create', compact('templates'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'title' => 'required|max:255',
            'slug' => 'required|max:255|unique:cms_pages,slug',
            'content' => 'nullable',
            'meta_title' => 'nullable|max:255',
            'meta_description' => 'nullable',
            'template' => 'nullable|max:100',
            'status' => 'boolean',
            'published_at' => 'nullable|date',
        ]);

        $data['author_id'] = $request->user()->id;
        $data['status'] = $request->boolean('status');
        $data['published_at'] = $request->published_at ?? now();

        Page::create($data);

        return redirect()->route('cms.pages.index')
            ->with('success', 'Page created successfully.');
    }

    public function edit(Page $page)
    {
        $templates = config('cms.page.templates', []);
        return view('cms::pages.edit', compact('page', 'templates'));
    }

    public function update(Request $request, Page $page)
    {
        $data = $request->validate([
            'title' => 'required|max:255',
            'slug' => 'required|max:255|unique:cms_pages,slug,' . $page->id,
            'content' => 'nullable',
            'meta_title' => 'nullable|max:255',
            'meta_description' => 'nullable',
            'template' => 'nullable|max:100',
            'status' => 'boolean',
            'published_at' => 'nullable|date',
        ]);

        $data['status'] = $request->boolean('status');

        $page->update($data);

        return redirect()->route('cms.pages.index')
            ->with('success', 'Page updated successfully.');
    }

    public function destroy(Page $page)
    {
        $page->delete();
        return redirect()->route('cms.pages.index')
            ->with('success', 'Page deleted successfully.');
    }
}
