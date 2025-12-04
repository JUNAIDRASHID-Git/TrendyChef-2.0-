import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/app_colors.dart';

class RegionSelector extends StatelessWidget {
  final String selectedRegion;
  final ValueChanged<String> onRegionSelected; // callback

  const RegionSelector({
    super.key,
    required this.selectedRegion,
    required this.onRegionSelected,
  });

  final List<String> saudiRegions = const [
    "Riyadh",
    "Makkah",
    "Medina",
    "Eastern Province",
    "Asir",
    "Tabuk",
    "Hail",
    "Northern Borders",
    "Jazan",
    "Najran",
    "Al Bahah",
    "Al Jawf",
    "Qassim",
  ];

  void _showRegionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
        child: SizedBox(
          height: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Select Region",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.fontColor,
                  ),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: saudiRegions.length,
                  itemBuilder: (context, index) {
                    final region = saudiRegions[index];
                    return ListTile(
                      title: Text(region),
                      onTap: () {
                        onRegionSelected(region); // call parent callback
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Region :",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () => _showRegionDialog(context),
            child: Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.backGroundColor,
                borderRadius: BorderRadius.circular(19),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                selectedRegion.isEmpty ? "Select Region" : selectedRegion,
                style: const TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
