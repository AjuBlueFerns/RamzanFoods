import 'package:crocurry/views/screens/components/common_loader.dart';
import 'package:flutter/material.dart';

class PaginationLoader extends StatefulWidget {
  const PaginationLoader({
    super.key,
    // required this.searchText,
    required this.callApi,
    required this.apiCall,
  });
  // final String searchText;
  final bool callApi;
  final VoidCallback apiCall;

  @override
  State<PaginationLoader> createState() => _PaginationLoaderState();
}

class _PaginationLoaderState extends State<PaginationLoader> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        fetchProducts(context);
      }
    });
    super.initState();
  }

  Future<void> fetchProducts(BuildContext context) async {
    if (context.mounted) {
      if (widget.callApi) {
        widget.apiCall.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const CommonLoader();
  }
}
