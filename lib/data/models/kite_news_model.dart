class KiteNews {
  final String category;
  final int timestamp;
  final int read;
  final List<Cluster> clusters;

  KiteNews({
    required this.category,
    required this.timestamp,
    required this.read,
    required this.clusters,
  });

  factory KiteNews.fromJson(Map<String, dynamic> json) {
    return KiteNews(
      category: json['category'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      read: json['read'] ?? 0,
      clusters: (json['clusters'] as List?)
          ?.map((e) => Cluster.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class Cluster {
  final int clusterNumber;
  final int uniqueDomains;
  final int numberOfTitles;
  final String category;
  final String title;
  final String shortSummary;
  final String didYouKnow;
  final List<String> talkingPoints;
  final String quote;
  final String quoteAuthor;
  final String quoteSourceUrl;
  final String quoteSourceDomain;
  final String location;
  final List<Perspective> perspectives;
  final String emoji;
  final String geopoliticalContext;
  final String historicalBackground;
  final dynamic internationalReactions;
  final String humanitarianImpact;
  final String economicImplications;
  final dynamic timeline;
  final String futureOutlook;
  final List<dynamic> keyPlayers;
  final dynamic technicalDetails;
  final String businessAngleText;
  final List<String> businessAnglePoints;
  final dynamic userActionItems;
  final List<dynamic> scientificSignificance;
  final List<String> travelAdvisory;
  final String destinationHighlights;
  final String culinarySignificance;
  final List<dynamic> performanceStatistics;
  final String leagueStandings;
  final String diyTips;
  final String designPrinciples;
  final String userExperienceImpact;
  final List<dynamic> gameplayMechanics;
  final List<String> industryImpact;
  final String technicalSpecifications;
  final List<Article> articles;
  final List<Domain> domains;

  Cluster({
    required this.clusterNumber,
    required this.uniqueDomains,
    required this.numberOfTitles,
    required this.category,
    required this.title,
    required this.shortSummary,
    required this.didYouKnow,
    required this.talkingPoints,
    required this.quote,
    required this.quoteAuthor,
    required this.quoteSourceUrl,
    required this.quoteSourceDomain,
    required this.location,
    required this.perspectives,
    required this.emoji,
    required this.geopoliticalContext,
    required this.historicalBackground,
    required this.internationalReactions,
    required this.humanitarianImpact,
    required this.economicImplications,
    required this.timeline,
    required this.futureOutlook,
    required this.keyPlayers,
    required this.technicalDetails,
    required this.businessAngleText,
    required this.businessAnglePoints,
    required this.userActionItems,
    required this.scientificSignificance,
    required this.travelAdvisory,
    required this.destinationHighlights,
    required this.culinarySignificance,
    required this.performanceStatistics,
    required this.leagueStandings,
    required this.diyTips,
    required this.designPrinciples,
    required this.userExperienceImpact,
    required this.gameplayMechanics,
    required this.industryImpact,
    required this.technicalSpecifications,
    required this.articles,
    required this.domains,
  });

  factory Cluster.fromJson(Map<String, dynamic> json) {
    return Cluster(
      clusterNumber: json['clusterNumber'] ?? 0,
      uniqueDomains: json['uniqueDomains'] ?? 0,
      numberOfTitles: json['numberOfTitles'] ?? 0,
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      shortSummary: json['shortSummary'] ?? '',
      didYouKnow: json['didYouKnow'] ?? '',
      talkingPoints: (json['talkingPoints'] as List?)?.cast<String>() ?? [],
      quote: json['quote'] ?? '',
      quoteAuthor: json['quoteAuthor'] ?? '',
      quoteSourceUrl: json['quoteSourceUrl'] ?? '',
      quoteSourceDomain: json['quoteSourceDomain'] ?? '',
      location: json['location'] ?? '',
      perspectives: (json['perspectives'] as List?)
          ?.map((e) => Perspective.fromJson(e))
          .toList() ??
          [],
      emoji: json['emoji'] ?? '',
      geopoliticalContext: json['geopoliticalContext'] ?? '',
      historicalBackground: json['historicalBackground'] ?? '',
      internationalReactions: json['internationalReactions'],
      humanitarianImpact: json['humanitarianImpact'] ?? '',
      economicImplications: json['economicImplications'] ?? '',
      timeline: json['timeline'],
      futureOutlook: json['futureOutlook'] ?? '',
      keyPlayers: json['keyPlayers'] ?? [],
      technicalDetails: json['technicalDetails'],
      businessAngleText: json['businessAngleText'] ?? '',
      businessAnglePoints:
      (json['businessAnglePoints'] as List?)?.cast<String>() ?? [],
      userActionItems: json['userActionItems'],
      scientificSignificance: json['scientificSignificance'] ?? [],
      travelAdvisory: (json['travelAdvisory'] as List?)?.cast<String>() ?? [],
      destinationHighlights: json['destinationHighlights'] ?? '',
      culinarySignificance: json['culinarySignificance'] ?? '',
      performanceStatistics: json['performanceStatistics'] ?? [],
      leagueStandings: json['leagueStandings'] ?? '',
      diyTips: json['diyTips'] ?? '',
      designPrinciples: json['designPrinciples'] ?? '',
      userExperienceImpact: json['userExperienceImpact'] ?? '',
      gameplayMechanics: json['gameplayMechanics'] ?? [],
      industryImpact: (json['industryImpact'] as List?)?.cast<String>() ?? [],
      technicalSpecifications: json['technicalSpecifications'] ?? '',
      articles: (json['articles'] as List?)
          ?.map((e) => Article.fromJson(e))
          .toList() ??
          [],
      domains: (json['domains'] as List?)
          ?.map((e) => Domain.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class Article {
  final String title;
  final String link;
  final String domain;
  final DateTime date;
  final String image;
  final String imageCaption;

  Article({
    required this.title,
    required this.link,
    required this.domain,
    required this.date,
    required this.image,
    required this.imageCaption,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      link: json['link'] ?? '',
      domain: json['domain'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime(1970, 1, 1),
      image: json['image'] ?? '',
      imageCaption: json['imageCaption'] ?? '',
    );
  }
}

class Domain {
  final String name;
  final String favicon;

  Domain({
    required this.name,
    required this.favicon,
  });

  factory Domain.fromJson(Map<String, dynamic> json) {
    return Domain(
      name: json['name'] ?? '',
      favicon: json['favicon'] ?? '',
    );
  }
}

class Perspective {
  final String text;
  final List<Source> sources;

  Perspective({
    required this.text,
    required this.sources,
  });

  factory Perspective.fromJson(Map<String, dynamic> json) {
    return Perspective(
      text: json['text'] ?? '',
      sources: (json['sources'] as List?)
          ?.map((e) => Source.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class Source {
  final String name;
  final String url;

  Source({
    required this.name,
    required this.url,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
