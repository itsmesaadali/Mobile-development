import 'package:flutter/material.dart';
import '../services/location_service.dart';
import '../services/api_service.dart';
import '../services/camera_service.dart';

class AddActivityScreen extends StatefulWidget {
  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  String? base64Image;
  String locationText = "Locating...";

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  // ------------------------
  // Load GPS Location (Web)
  // ------------------------
  void _loadLocation() async {
    String loc = await LocationService.getLocationWeb();
    setState(() => locationText = loc);
  }

  // ------------------------
  // Pick Image (Web Camera)
  // ------------------------
  void _pickImage() async {
    final img = await CameraService.pickImageWeb();
    if (img != null) {
      setState(() {
        base64Image = img;
      });
    }
  }

  // ------------------------
  // Save Activity
  // ------------------------
  void _saveActivity() async {
    if (base64Image == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please upload an image")));
      return;
    }

    await ApiService.createActivity(
      image: base64Image!,
      location: locationText,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Activity Saved")));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Activity")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LOCATION
            Text("Location: $locationText", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),

            // IMAGE PREVIEW
            base64Image != null
                ? Container(
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black26),
                    ),
                    child: Image.network(base64Image!, fit: BoxFit.cover),
                  )
                : Container(
                    height: 220,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text("No Image Selected"),
                  ),

            SizedBox(height: 20),

            // PICK IMAGE BUTTON
            ElevatedButton(onPressed: _pickImage, child: Text("Upload Image")),

            SizedBox(height: 20),

            // SAVE BUTTON
            ElevatedButton(
              onPressed: _saveActivity,
              child: Text("Save Activity"),
            ),
          ],
        ),
      ),
    );
  }
}
