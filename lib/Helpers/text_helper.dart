import 'package:flutter/material.dart';

extension TextHelpers on String {
  // text length limit
  String limitLength(int maxLength) {
    if (length <= maxLength) {
      return this;
    } else {
      return '${substring(0, maxLength)}...';
    }
  }

  // to snake case
  String toSnakeCase() {
    return replaceAllMapped(RegExp(r'[A-Z]'), (match) {
      return '_${match.group(0)!.toLowerCase()}';
    }).replaceAll(RegExp(r'^_'), '');
  }

  // to camel case
  String toCamelCase() {
    return toSnakeCase().replaceAllMapped(RegExp(r'(_\w)'), (match) {
      return match.group(0)!.toUpperCase().substring(1);
    });
  }

  // to pascal case
  String toPascalCase() {
    return replaceAll(' ', '_').toCamelCase().replaceFirstMapped(RegExp(r'\w'),
        (match) {
      return match.group(0)!.toUpperCase();
    });
  }

  // to folder name
  String toFolderName() {
    // if more than one word take the first word
    // captlize the first letter
    return split(' ').first.toPascalCase();
  }

  // flutter file name
  String toFlutterFileName() {
    return toPascalCase().replaceAllMapped(RegExp(r'([A-Z])'), (match) {
      return '_${match.group(0)!.toLowerCase()}';
    }).replaceAll(RegExp(r'^_'), '');
  }

  // return Icon for file type
  IconData getIcon() {
    switch (this) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'txt':
        return Icons.article;
      case 'zip':
      case 'rar':
        return Icons.archive;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
      case 'webp':
        return Icons.image;
      case 'mp3':
      case 'wav':
      case 'flac':
      case 'aac':
      case 'ogg':
        return Icons.audiotrack;
      case 'mp4':
      case 'mkv':
      case 'avi':
      case 'mov':
      case 'flv':
      case 'wmv':
        return Icons.movie;
      default:
        return Icons.insert_drive_file;
    }
  }
}
