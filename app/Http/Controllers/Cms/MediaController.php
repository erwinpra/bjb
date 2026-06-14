<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\Media;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class MediaController extends Controller
{
    public function index()
    {
        $media = Media::latest()->paginate(20);
        return view('cms::media.index', compact('media'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'file' => 'required|file|max:' . config('cms.upload.max_size'),
        ]);

        $file = $request->file('file');
        $disk = config('cms.upload.disk');
        $path = config('cms.upload.path');

        $fileName = time() . '_' . $file->getClientOriginalName();
        $filePath = $file->storeAs($path, $fileName, $disk);

        $media = Media::create([
            'name' => $file->getClientOriginalName(),
            'file_name' => $fileName,
            'mime_type' => $file->getMimeType(),
            'size' => $file->getSize(),
            'disk' => $disk,
            'path' => $filePath,
            'uploaded_by' => $request->user()->id,
        ]);

        if ($request->wantsJson()) {
            return response()->json(['media' => $media, 'url' => $media->url], 201);
        }

        return redirect()->route('cms.media.index')
            ->with('success', 'File uploaded successfully.');
    }

    public function destroy(Media $media)
    {
        Storage::disk($media->disk)->delete($media->path);
        $media->delete();

        return redirect()->route('cms.media.index')
            ->with('success', 'File deleted successfully.');
    }
}
