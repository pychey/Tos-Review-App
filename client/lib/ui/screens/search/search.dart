import 'package:client/data/models/post.dart';
import 'package:client/services/post_service.dart';
import 'package:client/ui/screens/inspect_post/inspect_post.dart';
import 'package:client/ui/widgets/displays/review_post.dart';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<Post> _results = [];
  String? _selectedCategory;
  bool _isLoading = false;

  void _onSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() => _results = []);
      return;
    }
    setState(() => _isLoading = true);
    try {
      final results = await postService.searchPosts(query, category: _selectedCategory);
      setState(() => _results = results);
    } catch (e) {
      setState(() => _results = []);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (value) => _onSearch(value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, size: 30),
                    fillColor: const Color.fromARGB(255, 232, 223, 223),
                    filled: true,
                    hintText: "Search",
                    isDense: true,
                    hintStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                      borderSide: BorderSide(color: TosReviewColors.greyDark, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                      borderSide: BorderSide(color: TosReviewColors.primary, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                      borderSide: BorderSide(color: TosReviewColors.primary, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TosReviewSpacings.radius),
                      borderSide: BorderSide(color: TosReviewColors.primary, width: 2),
                    ),
                  ),
                  style: TosReviewTextStyles.body,
                ),
              ),
              const SizedBox(height: TosReviewSpacings.m),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [null, 'FOOD', 'BEAUTY', 'OTHER'].map((cat) {
                    final label = cat == null ? 'All' : cat[0] + cat.substring(1).toLowerCase();
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(label),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() => _selectedCategory = cat);
                          _onSearch(_searchController.text);
                        },
                        selectedColor: TosReviewColors.primary,
                        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: TosReviewSpacings.l),
              _isLoading
                ? Center(child: CircularProgressIndicator(color: TosReviewColors.primary))
                : _results.isEmpty
                  ? Center(child: Text('No results found', style: TosReviewTextStyles.body))
                  : GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _results.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final post = _results[index];
                        return ReviewPost(
                          onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InspectPost(postId: post.id)),
                          ),
                          post: post,
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}