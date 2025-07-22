import 'package:crocurry/domain/use_cases/product/get_categories.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/categories/category_event.dart';
import 'package:crocurry/views/bloc/categories/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState()) {
    on(getCategories);
  }

  Future<void> getCategories(
      FetchCategories event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(
      isLoading: true,
      id: "",
    ));

    final details = await locator<GetProductCategories>().call();
    var list = details.$1 ?? [];
    // var id = state.selectedCategoryId.isEmpty
    //     ? list.first.mainCategoryId
    //     : state.selectedCategoryId;
    emit(state.copyWith(
      isLoading: false,
      categoryList: list,
      // id: list.first.mainCategoryId!,
      // id: state.selectedCategoryId.isEmpty
      //     ? list.first.mainCategoryId
      //     : state.selectedCategoryId,
    ));
  }

}
