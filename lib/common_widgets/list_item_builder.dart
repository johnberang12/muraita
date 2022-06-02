
import 'package:flutter/material.dart';
import 'package:muraita_apps/common_widgets/empty_content.dart';


/////////////////////Generic widget////////////////////////////////
typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder({Key? key, required this.snapshot, required this.itemBuilder}) : super(key: key);
  final AsyncSnapshot<Iterable<T?>> snapshot;
  final ItemWidgetBuilder<T?> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if(snapshot.hasData) {
      final Iterable<T?>? items = snapshot.data;
      if(items!.isNotEmpty){
        return _buildList();
      } else {
        return const EmptyContent();
      }
    } else if (snapshot.hasError){
      return const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\nt load items right now',
      );
    }
    return const Center(child: CircularProgressIndicator(),);
  }

  Widget _buildList() {
    final Iterable<T?>? items = snapshot.data;

    return ListView.separated(
      itemCount: items!.length ,
        separatorBuilder: (context, index) => const Divider(thickness: 0.5,),
        itemBuilder: (context, index) {
        print('length is => ${items.length}');
        print(items.elementAt(index));
        // if(index == 0){
        //   return Container();
        // }
        print('index is $index');
        return itemBuilder(context, items.elementAt(index) );
        },
    );
  }

}
