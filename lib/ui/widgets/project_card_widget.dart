part of 'widget.dart';

class ProjectCardWidget extends StatelessWidget {
  final String title;
  final String projectId;
  final int objectCount;
  final int photoCount;
  final int videoCount;

  const ProjectCardWidget({
    super.key,
    required this.title,
    required this.projectId,
    required this.objectCount,
    required this.photoCount,
    required this.videoCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: CIPSColor.borderColor),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.business, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              projectId,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: CIPSColor.textSecondaryColor),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle,
                        size: 16, color: CIPSColor.textSecondaryColor),
                    const SizedBox(width: 4),
                    Text(
                      '$objectCount Jumlah objek',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: CIPSColor.textSecondaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Icon(Icons.photo,
                        size: 16, color: CIPSColor.textSecondaryColor),
                    const SizedBox(width: 4),
                    Text('$photoCount Foto',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: CIPSColor.textSecondaryColor)),
                    const SizedBox(width: 16),
                    Icon(Icons.videocam,
                        size: 16, color: CIPSColor.textSecondaryColor),
                    const SizedBox(width: 4),
                    Text(
                      '$videoCount Video',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: CIPSColor.textSecondaryColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CIPSColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Tambah Foto',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: CIPSColor.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Tambah Video',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: CIPSColor.primaryColor)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
