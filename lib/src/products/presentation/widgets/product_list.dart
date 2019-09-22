import 'package:flutter/material.dart';
import 'package:torii_shopping/src/common/blocs/BlocProvider.dart';
import 'package:torii_shopping/src/products/presentation/widgets/product_item.dart';
import 'package:torii_shopping/src/search/presentation/blocs/search_products_bloc.dart';
import 'package:torii_shopping/src/search/presentation/state/search_products_state.dart';

class ProductList extends StatelessWidget {
  ScrollController _scrollController;

  SearchProductsBloc bloc;

  ProductList() {
    _scrollController = new ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bloc.loadMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SearchProductsBloc>(context);

    return StreamBuilder<SearchProductsState>(
      stream: bloc.state,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildSearchResults(context, snapshot.data);
        } else if (snapshot.hasError) {
          return Text(
            "${snapshot.error}",
            overflow: TextOverflow.ellipsis,
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildSearchResults(BuildContext context,
      SearchProductsState state) {
    return Container(
      child: ListView.separated(
        controller:_scrollController,
        separatorBuilder: (context, index) =>
            Divider(
              color: Colors.grey,
            ),
        itemCount: state.result.items.length + 1,
        itemBuilder: (context, index) {
          return buildItem(index, state);
        },
      ),
      color: Colors.white,
    );
  }

  Widget buildItem(int index, SearchProductsState state) {
    if (index == state.result.items.length && state.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (index < state.result.items.length) {
      return Center(
          child: ProductItem(product: state.result.items[index]));
    } else {
      return Column();
    }
  }
}
