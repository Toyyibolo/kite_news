import 'package:hive/hive.dart';
import 'package:kite_news/data/models/article_model.dart';
import 'package:kite_news/data/models/domain_model.dart';
import 'package:kite_news/data/models/perspective_model.dart';

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
  final String humanitarianImpact;
  final String economicImplications;
  final String futureOutlook;
  final String businessAngleText;
  final List<String> businessAnglePoints;
  final List<String> travelAdvisory;
  final String destinationHighlights;
  final String culinarySignificance;
  final String leagueStandings;
  final String diyTips;
  final String designPrinciples;
  final String userExperienceImpact;
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
    required this.humanitarianImpact,
    required this.economicImplications,
    required this.futureOutlook,
    required this.businessAngleText,
    required this.businessAnglePoints,
    required this.travelAdvisory,
    required this.destinationHighlights,
    required this.culinarySignificance,
    required this.leagueStandings,
    required this.diyTips,
    required this.designPrinciples,
    required this.userExperienceImpact,
    required this.industryImpact,
    required this.technicalSpecifications,
    required this.articles,
    required this.domains,
  });

  factory Cluster.fromJson(Map<String, dynamic> json) {
    return Cluster(
      clusterNumber: json['clusterNumber'] as int? ?? 0,
      uniqueDomains: json['uniqueDomains'] as int? ?? 0,
      numberOfTitles: json['numberOfTitles'] as int? ?? 0,
      category: json['category'] as String? ?? '',
      title: json['title'] as String? ?? '',
      shortSummary: json['shortSummary'] as String? ?? '',
      didYouKnow: json['didYouKnow'] as String? ?? '',
      talkingPoints: (json['talkingPoints'] as List<dynamic>? ?? []).cast<String>(),
      quote: json['quote'] as String? ?? '',
      quoteAuthor: json['quoteAuthor'] as String? ?? '',
      quoteSourceUrl: json['quoteSourceUrl'] as String? ?? '',
      quoteSourceDomain: json['quoteSourceDomain'] as String? ?? '',
      location: json['location'] as String? ?? '',
      perspectives: (json['perspectives'] as List<dynamic>? ?? [])
          .map((e) => Perspective.fromJson(e as Map<String, dynamic>))
          .toList(),
      emoji: json['emoji'] as String? ?? '',
      geopoliticalContext: json['geopoliticalContext'] as String? ?? '',
      historicalBackground: json['historicalBackground'] as String? ?? '',
      humanitarianImpact: json['humanitarianImpact'] as String? ?? '',
      economicImplications: json['economicImplications'] as String? ?? '',
      futureOutlook: json['futureOutlook'] as String? ?? '',
      businessAngleText: json['businessAngleText'] as String? ?? '',
      businessAnglePoints: (json['businessAnglePoints'] as List<dynamic>? ?? []).cast<String>(),
      travelAdvisory: (json['travelAdvisory'] as List<dynamic>? ?? []).cast<String>(),
      destinationHighlights: json['destinationHighlights'] as String? ?? '',
      culinarySignificance: json['culinarySignificance'] as String? ?? '',
      leagueStandings: json['leagueStandings'] as String? ?? '',
      diyTips: json['diyTips'] as String? ?? '',
      designPrinciples: json['designPrinciples'] as String? ?? '',
      userExperienceImpact: json['userExperienceImpact'] as String? ?? '',
      industryImpact: (json['industryImpact'] as List<dynamic>? ?? []).cast<String>(),
      technicalSpecifications: json['technicalSpecifications'] as String? ?? '',
      articles: (json['articles'] as List<dynamic>? ?? [])
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
      domains: (json['domains'] as List<dynamic>? ?? [])
          .map((e) => Domain.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ClusterAdapter extends TypeAdapter<Cluster> {
  @override
  final int typeId = 1;

  @override
  Cluster read(BinaryReader reader) {
    return Cluster(
      clusterNumber: reader.readInt(),
      uniqueDomains: reader.readInt(),
      numberOfTitles: reader.readInt(),
      category: reader.readString(),
      title: reader.readString(),
      shortSummary: reader.readString(),
      didYouKnow: reader.readString(),
      talkingPoints: reader.readList().cast<String>(),
      quote: reader.readString(),
      quoteAuthor: reader.readString(),
      quoteSourceUrl: reader.readString(),
      quoteSourceDomain: reader.readString(),
      location: reader.readString(),
      perspectives: reader.readList().cast<Perspective>(),
      emoji: reader.readString(),
      geopoliticalContext: reader.readString(),
      historicalBackground: reader.readString(),
      humanitarianImpact: reader.readString(),
      economicImplications: reader.readString(),
      futureOutlook: reader.readString(),
      businessAngleText: reader.readString(),
      businessAnglePoints: reader.readList().cast<String>(),
      travelAdvisory: reader.readList().cast<String>(),
      destinationHighlights: reader.readString(),
      culinarySignificance: reader.readString(),
      leagueStandings: reader.readString(),
      diyTips: reader.readString(),
      designPrinciples: reader.readString(),
      userExperienceImpact: reader.readString(),
      industryImpact: reader.readList().cast<String>(),
      technicalSpecifications: reader.readString(),
      articles: reader.readList().cast<Article>(),
      domains: reader.readList().cast<Domain>(),
    );
  }

  @override
  void write(BinaryWriter writer, Cluster obj) {
    writer.writeInt(obj.clusterNumber);
    writer.writeInt(obj.uniqueDomains);
    writer.writeInt(obj.numberOfTitles);
    writer.writeString(obj.category);
    writer.writeString(obj.title);
    writer.writeString(obj.shortSummary);
    writer.writeString(obj.didYouKnow);
    writer.writeList(obj.talkingPoints);
    writer.writeString(obj.quote);
    writer.writeString(obj.quoteAuthor);
    writer.writeString(obj.quoteSourceUrl);
    writer.writeString(obj.quoteSourceDomain);
    writer.writeString(obj.location);
    writer.writeList(obj.perspectives);
    writer.writeString(obj.emoji);
    writer.writeString(obj.geopoliticalContext);
    writer.writeString(obj.historicalBackground);
    writer.writeString(obj.humanitarianImpact);
    writer.writeString(obj.economicImplications);
    writer.writeString(obj.futureOutlook);
    writer.writeString(obj.businessAngleText);
    writer.writeList(obj.businessAnglePoints);
    writer.writeList(obj.travelAdvisory);
    writer.writeString(obj.destinationHighlights);
    writer.writeString(obj.culinarySignificance);
    writer.writeString(obj.leagueStandings);
    writer.writeString(obj.diyTips);
    writer.writeString(obj.designPrinciples);
    writer.writeString(obj.userExperienceImpact);
    writer.writeList(obj.industryImpact);
    writer.writeString(obj.technicalSpecifications);
    writer.writeList(obj.articles);
    writer.writeList(obj.domains);
  }
}
