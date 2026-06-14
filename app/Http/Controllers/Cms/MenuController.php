<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\Menu;
use App\Models\Cms\MenuItem;
use Illuminate\Http\Request;

class MenuController extends Controller
{
    public function index()
    {
        $menus = Menu::withCount('items')->get();
        return view('cms::menus.index', compact('menus'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|max:255',
            'slug' => 'required|max:255|unique:cms_menus,slug',
            'description' => 'nullable',
        ]);

        Menu::create($data);

        return redirect()->route('cms.menus.index')
            ->with('success', 'Menu created.');
    }

    public function edit(Menu $menu)
    {
        $menu->load('items.children');
        $pages = \App\Models\Cms\Page::published()->pluck('title', 'slug');
        return view('cms::menus.edit', compact('menu', 'pages'));
    }

    public function update(Request $request, Menu $menu)
    {
        $data = $request->validate([
            'name' => 'required|max:255',
            'slug' => 'required|max:255|unique:cms_menus,slug,' . $menu->id,
            'description' => 'nullable',
        ]);

        $menu->update($data);

        return redirect()->route('cms.menus.index')
            ->with('success', 'Menu updated.');
    }

    public function destroy(Menu $menu)
    {
        $menu->delete();
        return redirect()->route('cms.menus.index')
            ->with('success', 'Menu deleted.');
    }

    public function addItem(Request $request, Menu $menu)
    {
        $data = $request->validate([
            'label' => 'required|max:255',
            'url' => 'nullable|max:500',
            'route' => 'nullable|max:255',
            'parent_id' => 'nullable|exists:cms_menu_items,id',
            'icon' => 'nullable|max:100',
            'target' => 'nullable|max:20',
            'order' => 'nullable|integer|min:0',
            'status' => 'boolean',
        ]);

        $data['menu_id'] = $menu->id;
        $data['status'] = $request->boolean('status', true);
        $data['order'] = MenuItem::where('menu_id', $menu->id)->max('order') + 1;

        MenuItem::create($data);

        return redirect()->route('cms.menus.edit', $menu)
            ->with('success', 'Menu item added.');
    }

    public function updateItem(Request $request, MenuItem $item)
    {
        $data = $request->validate([
            'label' => 'required|max:255',
            'url' => 'nullable|max:500',
            'route' => 'nullable|max:255',
            'parent_id' => 'nullable|exists:cms_menu_items,id',
            'icon' => 'nullable|max:100',
            'target' => 'nullable|max:20',
            'order' => 'nullable|integer|min:0',
            'status' => 'boolean',
        ]);

        $data['status'] = $request->boolean('status', true);
        $item->update($data);

        return redirect()->route('cms.menus.edit', $item->menu_id)
            ->with('success', 'Menu item updated.');
    }

    public function destroyItem(MenuItem $item)
    {
        $menuId = $item->menu_id;
        $item->delete();
        return redirect()->route('cms.menus.edit', $menuId)
            ->with('success', 'Menu item deleted.');
    }
}
