class KiteNews {
  final String category;
  final int timestamp;
  final int read;
  final List<Clusters> clusters;

  KiteNews({
    this.category = '',
    this.timestamp = 0,
    this.read = 0,
    this.clusters = const [],
  });

  factory KiteNews.fromJson(Map<String, dynamic>? json) {
    if (json == null) return KiteNews();

    return KiteNews(
      category: json['category'] as String? ?? '',
      timestamp: json['timestamp'] as int? ?? 0,
      read: json['read'] as int? ?? 0,
      clusters: (json['clusters'] as List?)?.map((v) => Clusters.fromJson(v)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'category': category,
    'timestamp': timestamp,
    'read': read,
    'clusters': clusters.map((v) => v.toJson()).toList(),
  };
}

class Clusters {
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
  final List<Perspectives> perspectives;
  final String emoji;
  final String geopoliticalContext;
  final String historicalBackground;
  final List<String> internationalReactions;
  final String humanitarianImpact;
  final String economicImplications;
  final List<String> timeline;
  final String futureOutlook;
  final List<KeyPlayer> keyPlayers;
  final String technicalDetails;
  final String businessAngleText;
  final List<String> businessAnglePoints;
  final List<String> userActionItems;
  final List<dynamic> scientificSignificance;
  final List<dynamic> travelAdvisory;
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
  final List<Articles> articles;
  final List<Domains> domains;

  Clusters({
    this.clusterNumber = 0,
    this.uniqueDomains = 0,
    this.numberOfTitles = 0,
    this.category = '',
    this.title = '',
    this.shortSummary = '',
    this.didYouKnow = '',
    this.talkingPoints = const [],
    this.quote = '',
    this.quoteAuthor = '',
    this.quoteSourceUrl = '',
    this.quoteSourceDomain = '',
    this.location = '',
    this.perspectives = const [],
    this.emoji = '',
    this.geopoliticalContext = '',
    this.historicalBackground = '',
    this.internationalReactions = const [],
    this.humanitarianImpact = '',
    this.economicImplications = '',
    this.timeline = const [],
    this.futureOutlook = '',
    this.keyPlayers = const [],
    this.technicalDetails = '',
    this.businessAngleText = '',
    this.businessAnglePoints = const [],
    this.userActionItems = const [],
    this.scientificSignificance = const [],
    this.travelAdvisory = const [],
    this.destinationHighlights = '',
    this.culinarySignificance = '',
    this.performanceStatistics = const [],
    this.leagueStandings = '',
    this.diyTips = '',
    this.designPrinciples = '',
    this.userExperienceImpact = '',
    this.gameplayMechanics = const [],
    this.industryImpact = const [],
    this.technicalSpecifications = '',
    this.articles = const [],
    this.domains = const [],
  });

  factory Clusters.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Clusters();

    return Clusters(
      clusterNumber: json['cluster_number'] as int? ?? 0,
      uniqueDomains: json['unique_domains'] as int? ?? 0,
      numberOfTitles: json['number_of_titles'] as int? ?? 0,
      category: json['category'] as String? ?? '',
      title: json['title'] as String? ?? '',
      shortSummary: json['short_summary'] as String? ?? '',
      didYouKnow: json['did_you_know'] as String? ?? '',
      talkingPoints: (json['talking_points'] as List?)?.cast<String>() ?? [],
      quote: json['quote'] as String? ?? '',
      quoteAuthor: json['quote_author'] as String? ?? '',
      quoteSourceUrl: json['quote_source_url'] as String? ?? '',
      quoteSourceDomain: json['quote_source_domain'] as String? ?? '',
      location: json['location'] as String? ?? '',
      perspectives: (json['perspectives'] as List?)?.map((v) => Perspectives.fromJson(v)).toList() ?? [],
      emoji: json['emoji'] as String? ?? '',
      geopoliticalContext: json['geopolitical_context'] as String? ?? '',
      historicalBackground: json['historical_background'] as String? ?? '',
      internationalReactions: (json['international_reactions'] as List?)?.cast<String>() ?? [],
      humanitarianImpact: json['humanitarian_impact'] as String? ?? '',
      economicImplications: json['economic_implications'] as String? ?? '',
      timeline: (json['timeline'] as List?)?.cast<String>() ?? [],
      futureOutlook: json['future_outlook'] as String? ?? '',
      keyPlayers: (json['key_players'] as List?)?.map((v) => KeyPlayer.fromJson(v)).toList() ?? [],
      technicalDetails: json['technical_details'] as String? ?? '',
      businessAngleText: json['business_angle_text'] as String? ?? '',
      businessAnglePoints: (json['business_angle_points'] as List?)?.cast<String>() ?? [],
      userActionItems: (json['user_action_items'] as List?)?.cast<String>() ?? [],
      scientificSignificance: json['scientific_significance'] as List? ?? [],
      travelAdvisory: json['travel_advisory'] as List? ?? [],
      destinationHighlights: json['destination_highlights'] as String? ?? '',
      culinarySignificance: json['culinary_significance'] as String? ?? '',
      performanceStatistics: json['performance_statistics'] as List? ?? [],
      leagueStandings: json['league_standings'] as String? ?? '',
      diyTips: json['diy_tips'] as String? ?? '',
      designPrinciples: json['design_principles'] as String? ?? '',
      userExperienceImpact: json['user_experience_impact'] as String? ?? '',
      gameplayMechanics: json['gameplay_mechanics'] as List? ?? [],
      industryImpact: (json['industry_impact'] as List?)?.cast<String>() ?? [],
      technicalSpecifications: json['technical_specifications'] as String? ?? '',
      articles: (json['articles'] as List?)?.map((v) => Articles.fromJson(v)).toList() ?? [],
      domains: (json['domains'] as List?)?.map((v) => Domains.fromJson(v)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'cluster_number': clusterNumber,
    'unique_domains': uniqueDomains,
    'number_of_titles': numberOfTitles,
    'category': category,
    'title': title,
    'short_summary': shortSummary,
    'did_you_know': didYouKnow,
    'talking_points': talkingPoints,
    'quote': quote,
    'quote_author': quoteAuthor,
    'quote_source_url': quoteSourceUrl,
    'quote_source_domain': quoteSourceDomain,
    'location': location,
    'perspectives': perspectives.map((v) => v.toJson()).toList(),
    'emoji': emoji,
    'geopolitical_context': geopoliticalContext,
    'historical_background': historicalBackground,
    'international_reactions': internationalReactions,
    'humanitarian_impact': humanitarianImpact,
    'economic_implications': economicImplications,
    'timeline': timeline,
    'future_outlook': futureOutlook,
    'key_players': keyPlayers.map((v) => v.toJson()).toList(),
    'technical_details': technicalDetails,
    'business_angle_text': businessAngleText,
    'business_angle_points': businessAnglePoints,
    'user_action_items': userActionItems,
    'scientific_significance': scientificSignificance,
    'travel_advisory': travelAdvisory,
    'destination_highlights': destinationHighlights,
    'culinary_significance': culinarySignificance,
    'performance_statistics': performanceStatistics,
    'league_standings': leagueStandings,
    'diy_tips': diyTips,
    'design_principles': designPrinciples,
    'user_experience_impact': userExperienceImpact,
    'gameplay_mechanics': gameplayMechanics,
    'industry_impact': industryImpact,
    'technical_specifications': technicalSpecifications,
    'articles': articles.map((v) => v.toJson()).toList(),
    'domains': domains.map((v) => v.toJson()).toList(),
  };
}

class Perspectives {
  final String text;
  final List<Sources> sources;

  Perspectives({this.text = '', this.sources = const []});

  factory Perspectives.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Perspectives();

    return Perspectives(
      text: json['text'] as String? ?? '',
      sources: (json['sources'] as List?)?.map((v) => Sources.fromJson(v)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'sources': sources.map((v) => v.toJson()).toList(),
  };
}

class Sources {
  final String name;
  final String url;

  Sources({this.name = '', this.url = ''});

  factory Sources.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Sources();

    return Sources(
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'url': url,
  };
}

class Articles {
  final String title;
  final String link;
  final String domain;
  final String date;
  final String image;
  final String imageCaption;

  Articles({
    this.title = '',
    this.link = '',
    this.domain = '',
    this.date = '',
    this.image = '',
    this.imageCaption = '',
  });

  factory Articles.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Articles();

    return Articles(
      title: json['title'] as String? ?? '',
      link: json['link'] as String? ?? '',
      domain: json['domain'] as String? ?? '',
      date: json['date'] as String? ?? '',
      image: json['image'] as String? ?? '',
      imageCaption: json['image_caption'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'link': link,
    'domain': domain,
    'date': date,
    'image': image,
    'image_caption': imageCaption,
  };
}

class KeyPlayer {
  final String name;
  final String role;

  KeyPlayer({this.name = '', this.role = ''});

  factory KeyPlayer.fromJson(Map<String, dynamic>? json) {
    if (json == null) return KeyPlayer();

    return KeyPlayer(
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'role': role,
  };
}

class Domains {
  final String name;
  final String favicon;

  Domains({this.name = '', this.favicon = ''});

  factory Domains.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Domains();

    return Domains(
      name: json['name'] as String? ?? '',
      favicon: json['favicon'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'favicon': favicon,
  };
}
