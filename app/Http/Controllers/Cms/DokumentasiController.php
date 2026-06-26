<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;

class DokumentasiController extends Controller
{
    public function index()
    {
        $files = $this->getMdFiles();
        $content = '';
        $activeFile = null;
        return view('cms::dokumentasi.index', compact('files', 'content', 'activeFile'));
    }

    public function show($file)
    {
        $files = $this->getMdFiles();
        $activeFile = $file;
        $content = '';

        $path = base_path($file);
        if (file_exists($path)) {
            $parsedown = new \Parsedown();
            $content = $parsedown->text(file_get_contents($path));
        }

        return view('cms::dokumentasi.index', compact('files', 'content', 'activeFile'));
    }

    protected function getMdFiles()
    {
        $mdFiles = [];
        $basePath = base_path();
        $patterns = ['README.md', 'ALUR_PROSES.md'];

        foreach ($patterns as $pattern) {
            $path = $basePath . '/' . $pattern;
            if (file_exists($path)) {
                $mdFiles[] = [
                    'name' => $pattern,
                    'label' => $this->getLabel($pattern),
                    'path' => $pattern,
                ];
            }
        }

        $globFiles = glob($basePath . '/*.md');
        foreach ($globFiles as $fullPath) {
            $filename = basename($fullPath);
            if (!in_array($filename, $patterns)) {
                $mdFiles[] = [
                    'name' => $filename,
                    'label' => $this->getLabel($filename),
                    'path' => $filename,
                ];
            }
        }

        return $mdFiles;
    }

    protected function getLabel($filename)
    {
        $labels = [
            'README.md' => '📖 Dokumentasi Aplikasi',
            'ALUR_PROSES.md' => '🔄 Alur Proses',
        ];
        return $labels[$filename] ?? str_replace('.md', '', $filename);
    }
}
