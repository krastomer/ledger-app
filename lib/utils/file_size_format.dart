String formatFileSize(int bytes) =>
    bytes < 1024 ? '$bytes B' : '${(bytes / 1024).ceil()} KB';
