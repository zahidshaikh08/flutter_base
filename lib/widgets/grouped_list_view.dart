// import 'dart:collection';
//
// import 'package:flutter/widgets.dart';
//
// class GroupedListView<T, E> extends StatefulWidget {
//   final E Function(T element) groupBy;
//   final Widget Function(E value) groupSeparatorBuilder;
//   final Widget Function(BuildContext context, T element) itemBuilder;
//   final Widget Function(BuildContext context, T element, int index) indexedItemBuilder;
//   final GroupedListOrder order;
//   final bool sort;
//   final bool useStickyGroupSeparators;
//   final Widget separator;
//   final List<T> elements;
//   final bool floatingHeader;
//   final Key key;
//   final ScrollController controller;
//   final Axis scrollDirection;
//   final bool primary;
//   final ScrollPhysics physics;
//   final bool shrinkWrap;
//   final EdgeInsetsGeometry padding;
//   final bool addAutomaticKeepAlives;
//   final bool addRepaintBoundaries;
//   final bool addSemanticIndexes;
//   final double cacheExtent;
//   final bool reverse;
//
//   GroupedListView({
//     @required this.elements,
//     @required this.groupBy,
//     @required this.groupSeparatorBuilder,
//     this.itemBuilder,
//     this.indexedItemBuilder,
//     this.order = GroupedListOrder.ASC,
//     this.sort = true,
//     this.useStickyGroupSeparators = false,
//     this.separator = const SizedBox.shrink(),
//     this.floatingHeader = false,
//     this.key,
//     this.scrollDirection = Axis.vertical,
//     this.controller,
//     this.primary,
//     this.physics,
//     this.shrinkWrap = false,
//     this.padding,
//     this.addAutomaticKeepAlives = true,
//     this.addRepaintBoundaries = true,
//     this.addSemanticIndexes = true,
//     this.cacheExtent,
//     this.reverse = false,
//   }) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _GroupedListViewState<T, E>();
// }
//
// class _GroupedListViewState<T, E> extends State<GroupedListView<T, E>> {
//   ScrollController _controller;
//   Map<String, GlobalKey> _keys = LinkedHashMap<String, GlobalKey>();
//   GlobalKey _groupHeaderKey;
//   List<T> _sortedElements = [];
//   GlobalKey _key = GlobalKey();
//   E _topElementIndex;
//   RenderBox headerBox;
//   RenderBox listBox;
//
//   @override
//   void dispose() {
//     _controller.removeListener(_scrollListener);
//     if (widget.controller == null) {
//       _controller.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     this._sortedElements = _sortElements();
//     return Stack(
//       key: _key,
//       alignment: Alignment.topCenter,
//       children: <Widget>[
//         ListView.builder(
//           key: widget.key,
//           scrollDirection: widget.scrollDirection,
//           controller: _getController(),
//           primary: widget.primary,
//           physics: widget.physics,
//           shrinkWrap: widget.shrinkWrap,
//           padding: widget.padding,
//           itemCount: _sortedElements.length * 2,
//           addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
//           addRepaintBoundaries: widget.addRepaintBoundaries,
//           addSemanticIndexes: widget.addSemanticIndexes,
//           cacheExtent: widget.cacheExtent,
//           reverse: widget.reverse,
//           itemBuilder: (context, index) {
//             int actualIndex = index ~/ 2;
//             if (index == 0) {
//               return Opacity(
//                 opacity: widget.useStickyGroupSeparators ? 0 : 1,
//                 child: widget.groupSeparatorBuilder(widget.groupBy(_sortedElements[actualIndex])),
//               );
//             }
//             if (index.isEven) {
//               E curr = widget.groupBy(_sortedElements[actualIndex]);
//               E prev = widget.groupBy(_sortedElements[actualIndex - 1]);
//               if (prev != curr) {
//                 return widget.groupSeparatorBuilder(widget.groupBy(_sortedElements[actualIndex]));
//               }
//               return widget.separator;
//             }
//             return _buildItem(context, actualIndex);
//           },
//         ),
//         _showFixedGroupHeader(),
//       ],
//     );
//   }
//
//   Container _buildItem(context, int actualIndex) {
//     GlobalKey key = GlobalKey();
//     _keys['$actualIndex'] = key;
//     return Container(
//         key: key,
//         child: widget.indexedItemBuilder == null
//             ? widget.itemBuilder(context, _sortedElements[actualIndex])
//             : widget.indexedItemBuilder(context, _sortedElements[actualIndex], actualIndex));
//   }
//
//   ScrollController _getController() {
//     _controller = widget.controller == null ? ScrollController() : widget.controller;
//     if (widget.useStickyGroupSeparators) {
//       _controller.addListener(_scrollListener);
//     }
//     return _controller;
//   }
//
//   _scrollListener() {
//     listBox ??= _key?.currentContext?.findRenderObject();
//     double listPos = listBox?.localToGlobal(Offset.zero)?.dy ?? 0;
//     headerBox ??= _groupHeaderKey?.currentContext?.findRenderObject();
//     double headerHeight = headerBox?.size?.height ?? 0;
//     double max = double.negativeInfinity;
//     String topItemKey = '0';
//     for (var entry in _keys.entries) {
//       var key = entry.value;
//       if (_isListItemRendered(key)) {
//         RenderBox itemBox = key.currentContext.findRenderObject();
//         double y = itemBox.localToGlobal(Offset(0, -listPos - 2 * headerHeight)).dy;
//         if (y <= 0 && y > max) {
//           topItemKey = entry.key;
//           max = y;
//         }
//       }
//     }
//     var index = int.parse(topItemKey);
//     if (index != _topElementIndex) {
//       E curr = widget.groupBy(_sortedElements[index]);
//       if (_topElementIndex != curr) {
//         setState(() {
//           _topElementIndex = curr;
//         });
//       }
//     }
//   }
//
//   List<T> _sortElements() {
//     List<T> elements = widget.elements;
//     if (widget.sort && elements.isNotEmpty) {
//       elements.sort((e1, e2) {
//         var compareResult;
//         if (widget.groupBy(e1) is Comparable) {
//           compareResult = (widget.groupBy(e1) as Comparable).compareTo(widget.groupBy(e2) as Comparable);
//         }
//         if ((compareResult == null || compareResult == 0) && e1 is Comparable) {
//           compareResult = (e1).compareTo(e2);
//         }
//         return compareResult;
//       });
//       if (widget.order == GroupedListOrder.DESC) {
//         elements = elements.reversed.toList();
//       }
//     }
//     return elements;
//   }
//
//   Widget _showFixedGroupHeader() {
//     _groupHeaderKey = GlobalKey();
//     if (widget.useStickyGroupSeparators && widget.elements.length > 0) {
//       _topElementIndex ??= widget.groupBy(_sortedElements[0]);
//       return Container(
//         key: _groupHeaderKey,
//         color: widget.floatingHeader ? null : Color(0xffF7F7F7),
//         width: widget.floatingHeader ? null : MediaQuery.of(context).size.width,
//         child: widget.groupSeparatorBuilder(_topElementIndex),
//       );
//     }
//     return Container();
//   }
//
//   bool _isListItemRendered(GlobalKey<State<StatefulWidget>> key) {
//     return key.currentContext != null && key.currentContext.findRenderObject() != null;
//   }
// }
//
// enum GroupedListOrder { ASC, DESC }
