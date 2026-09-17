import 'package:flutter/material.dart';

void main() {
  runApp(const DigitalArtSpaceApp());
}

class DigitalArtSpaceApp extends StatelessWidget {
  const DigitalArtSpaceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Art Space',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey[900] ?? Colors.black,
          brightness: Brightness.light,
        ),
      ),
      home: const ArtSpaceScreen(),
    );
  }
}

// Artwork model
class Artwork {
  final String title;
  final String artist;
  final int year;
  final String imagePath;

  Artwork({
    required this.title,
    required this.artist,
    required this.year,
    required this.imagePath,
  });
}

class ArtSpaceScreen extends StatefulWidget {
  const ArtSpaceScreen({Key? key}) : super(key: key);

  @override
  State<ArtSpaceScreen> createState() => _ArtSpaceScreenState();
}

class _ArtSpaceScreenState extends State<ArtSpaceScreen> {
  // Sample artwork data - replace with your own images
  late List<Artwork> artworks;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    artworks = [
      Artwork(
        title: 'Still Life of Blue Rose and Other Flowers',
        artist: 'Owen Scott',
        year: 2021,
        imagePath: 'assets/artwork1.jpeg',
      ),
      Artwork(
        title: 'Abstract Composition',
        artist: 'Jane Doe',
        year: 2022,
        imagePath: 'assets/artwork2.jpeg',
      ),
      Artwork(
        title: 'Landscape Series',
        artist: 'John Smith',
        year: 2020,
        imagePath: 'assets/artwork3.jpeg',
      ),
      Artwork(
        title: 'Digital Dreams',
        artist: 'Alex Johnson',
        year: 2023,
        imagePath: 'assets/artwork4.jpg',
      ),
    ];
  }

  void nextArtwork() {
    setState(() {
      currentIndex = (currentIndex + 1) % artworks.length;
    });
  }

  void previousArtwork() {
    setState(() {
      currentIndex = (currentIndex - 1 + artworks.length) % artworks.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentArt = artworks[currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Artwork Wall
              Expanded(
                child: _buildArtworkWall(currentArt),
              ),
              const SizedBox(height: 24),
              // Artwork Descriptor
              _buildDescriptor(currentArt),
              const SizedBox(height: 24),
              // Display Controller
              _buildController(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArtworkWall(Artwork currentArt) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey[300]!, width: 8),
      ),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Image.asset(
          currentArt.imagePath,
          fit: BoxFit.contain, // Changed from cover to contain to show full artwork
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_not_supported, size: 50, color: Colors.grey[400]),
                  const SizedBox(height: 8),
                  Text('Image not found', style: TextStyle(color: Colors.grey[400])),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Section 2: Artwork Descriptor
  Widget _buildDescriptor(Artwork currentArt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentArt.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          '${currentArt.artist} (${currentArt.year})',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  // Section 3: Display Controller
  Widget _buildController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: previousArtwork,
          child: const Text('Previous'),
        ),
        ElevatedButton(
          onPressed: nextArtwork,
          child: const Text('Next'),
        ),
      ],
    );
  }
}