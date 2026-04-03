import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity ? article;
  const ArticleWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: .circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(127, 0, 0, 0), 
                spreadRadius: 1,  
                blurRadius: 3,   
                offset: const Offset(0, 3), 
              ),
            ],
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            spacing: 10,
            children: [
              _buildImage(context),
              Expanded(child: _buildArticleInfo()),
            ],
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    final imageUrl = article?.urlToImage;

    if (imageUrl == null || imageUrl.isEmpty) {
      return _buildPlaceholder();
    }

    return SizedBox(
      height: 130,
      width: 180,
      child: ClipRRect(
        borderRadius: .circular(10),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder();
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildArticleInfo(){
    return Column(
      children: [
        Text(article!.title ?? ''),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return SizedBox(
      height: 200,
      width: 200,
      child: Container(
        color: Colors.black12,
        child: const Icon(Icons.image_search_rounded, color: Colors.grey),
      ),
    );
  }
}