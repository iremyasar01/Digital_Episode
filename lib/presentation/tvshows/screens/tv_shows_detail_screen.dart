
/*
class TvShowDetailsScreen extends StatefulWidget {
  final int seriesId;

  const TvShowDetailsScreen({super.key, required this.seriesId});

  @override
  State<TvShowDetailsScreen> createState() => _TvShowDetailsScreenState();
}

class _TvShowDetailsScreenState extends State<TvShowDetailsScreen> {
  final TVRepository _tvRepository = TVRepository();
  late Future<List<Season>> _seasonsFuture;

  @override
  void initState() {
    super.initState();
    _seasonsFuture = _tvRepository.getSeasons(widget.seriesId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder<List<Season>>(
        future: _seasonsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Failed to load seasons: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No seasons available."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final season = snapshot.data![index];
                return ListTile(
                  
              
                  title: Text(season.name),
                  subtitle: Text('${season.episodeCount} episodes'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EpisodeScreen(
                          seriesId: widget.seriesId,
                          seasonNumber: season.seasonNumber,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
*/