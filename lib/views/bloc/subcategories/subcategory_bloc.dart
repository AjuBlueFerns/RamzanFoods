import 'package:crocurry/domain/use_cases/product/get_subcategories.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/subcategories/subcategory_event.dart';
import 'package:crocurry/views/bloc/subcategories/subcategory_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcategoryBloc extends Bloc<SubcategoryEvent, SubcategoryState> {
  SubcategoryBloc() : super(SubcategoryState()) {
    on(getSubCategories);
    on(updateSelectedIndex);
  }

  Future<void> getSubCategories(
      FetchSubcategories event, Emitter<SubcategoryState> emit) async {
    emit(state.copyWith(isLoading: true));

    final details = await locator<GetSubCategories>().call(event.category);

    emit(state.copyWith(isLoading: false, subcategoryList: details.$1 ?? []));
  }

  Future<void> updateSelectedIndex(
      UpdateSubCategoryIndex event, Emitter<SubcategoryState> emit) async {
    emit(state.copyWith(index: event.index));
  }
}
