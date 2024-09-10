import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class VideoPickerScreen extends StatefulWidget {
  @override
  _VideoPickerScreenState createState() => _VideoPickerScreenState();
}

class _VideoPickerScreenState extends State<VideoPickerScreen> {
  File? _videoFile;
  VideoPlayerController? _videoPlayerController;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _initializeVideoPlayer();
      });
    }
  }

  Future<void> _initializeVideoPlayer() async {
    if (_videoFile != null) {
      _videoPlayerController = VideoPlayerController.file(_videoFile!)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController!.play();
        });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Picker"),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickVideo,
            child: Text("Pick Video from Gallery"),
          ),
          SizedBox(height: 20),
          _videoPlayerController != null && _videoPlayerController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController!),
                )
              : Text("Pick a video to play"),
        ],
      ),
      floatingActionButton: _videoPlayerController != null
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _videoPlayerController!.value.isPlaying
                      ? _videoPlayerController!.pause()
                      : _videoPlayerController!.play();
                });
              },
              child: Icon(
                _videoPlayerController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )
          : null,
    );
  }
}
