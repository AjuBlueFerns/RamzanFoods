import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/views/bloc/search/search_bloc.dart';
import 'package:crocurry/views/bloc/search/search_event.dart';
import 'package:crocurry/views/bloc/search/search_state.dart';
import 'package:crocurry/views/screens/components/common_loader.dart';
import 'package:crocurry/views/screens/home/views/components/products/product_card.dart';
import 'package:crocurry/views/screens/components/pagination_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

/// screenf or searching products in remote db
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String textToSearch = "";
  // final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        leadingWidth: 50,
        centerTitle: false,
        actions: const [
          SizedBox(width: defaultPadding),
        ],
        titleSpacing: 0,
        title: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
          padding: const EdgeInsets.all(defaultPadding / 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: defaultPadding / 2),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  textToSearch = controller.text;
                  fetchProducts(page: "1");
                },
                child: SvgPicture.asset(
                  "assets/icons/Search.svg",
                  height: 24,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).textTheme.bodyLarge!.color!,
                      BlendMode.srcIn),
                ),
              ),
              const SizedBox(width: defaultPadding / 2),
              Expanded(
                child: TextField(
                  onSubmitted: (value) {
                    textToSearch = value;
                    fetchProducts(page: "1");
                  },
                  controller: controller,
                  autofocus: true,
                  decoration: const InputDecoration(
                    fillColor: Colors.transparent,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return state.searchResults.isEmpty
                ? state.isLoading
                    ? CommonLoader(
                        height: context.screenHeight,
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Spacer(),
                          // SizedBox(height: 100),
                          Center(
                            child: Lottie.asset(
                                'assets/lotties/no-results.json',
                                height: 200),
                          ),
                          const Text(
                              'No Items or Please type something to search'),
                          const Spacer(),
                          const Spacer(),
                        ],
                      )
                : GridView.builder(
                    reverse: false,
                    shrinkWrap: false,
                    itemCount: state.searchResults.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: defaultPadding,
                      crossAxisSpacing: defaultPadding,
                      childAspectRatio: 0.66,
                    ),
                    itemBuilder: (context, index) {
                      var product = state.searchResults[index];
                      if (product.productId == "loading") {
                        return PaginationLoader(
                          callApi: index == state.searchResults.length - 1,
                          apiCall: () {
                            context.read<SearchBloc>().add(PerformSearch(
                                  text: textToSearch,
                                ));
                          },
                        );
                      }

                      return ProductCard(
                        productModel: product,
                        stock: product.qtyInStock!,
                        image: product.imagePath!,
                        brandName: product.mainCategory!,
                        title: product.customTitle!,
                        price: product.productMrp!.toDouble(),
                        priceAfterDiscount: product.discountedPrice!.toDouble(),
                        discountpercent:
                            product.offerDiscountPercent!.toDouble(),
                        press: () async {
                          CommonFunctions.navigateToProductDetails(
                              context, product);
                        },
                      );
                    });
          },
        ),
      ),
    );
  }

  void fetchProducts({String? page}) async {
    context
        .read<SearchBloc>()
        .add(PerformSearch(text: textToSearch, page: page));
  }
}
