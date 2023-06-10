import 'package:flutter/material.dart';

import 'package:todo/constants.dart' as Constants;

import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _theList = ['Купить что-то','Купить что-то, где-то, зачем-то, но зачем не очень понятно','Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обр, но точно чтобы показать как обр показать как обр','Купить что-то'];
    return Scaffold(
      backgroundColor: const Color(Constants.lightBackPrimary),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            snap: false,
            floating: true,
            expandedHeight: 88.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 16.0, top: 48.0, bottom: 16.0),
              title: Text(
                'Мои дела',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: Constants.titleFontSize,
                  height: Constants.titleFontHeight,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(left: 60.0, top: 2.0, bottom: 16.0),
            //       child: SizedBox(
            //         height: 24,
            //         child: Text(
            //           'Выполнено —',
            //           style: TextStyle(
            //             color: Color(Constants.lightLabelTertiary),
            //           ),
            //         ),
            //       ),
            //     ),
            //     Container(
            //       margin: EdgeInsets.symmetric(horizontal: 8),
            //       height: 8,
            //       decoration: BoxDecoration(
            //         color: Colors.amberAccent,
            //         borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            //       ),
            //     )
            //   ]
            // ),
            child: Padding(
              padding: EdgeInsets.only(left: 60.0, top: 2.0, bottom: 16.0),
              child: SizedBox(
                height: 24,
                child: Text(
                  'Выполнено —',
                  style: TextStyle(
                    color: Color(Constants.lightLabelTertiary),
                  ),
                ),
              ),
            )
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.black26 : Colors.black12,
                    // decoration: BoxDecoration(
                    //   color: Colors.black26,
                    //   borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    // ),
                  child: ClipRect(
                    child: Dismissible(
                      key: new ObjectKey(_theList[index]),
                        //child: Center(child: Text('$index', textScaleFactor: 5),),
                      onDismissed: (DismissDirection direction) {
                        //setState(() {
                        _theList.removeAt(index);
                        //this.reIndex();
                        //});
                        direction == DismissDirection.endToStart
                            ? print("favourite")
                            : print("remove");
                      },

                      background: Container(
                        color: const Color(Constants.lightColorRed),
                        // decoration: BoxDecoration(
                        //   color: const Color(Constants.lightColorRed),
                        //   borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                        // ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: SvgPicture.asset(
                            Constants.delete,
                            semanticsLabel: 'delete',
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                                Color(Constants.lightColorWhite),
                                BlendMode.srcIn
                            ),
                          ),
                        ),
                        // child: ListTile(
                        //   // leading: const Icon(
                        //   //   Icons.delete,
                        //   //   color: Colors.white, size: 36.0
                        //   // )
                        //   leading: SvgPicture.asset(
                        //       Constants.delete,
                        //       semanticsLabel: 'delete',
                        //       fit: BoxFit.scaleDown,
                        //       colorFilter: ColorFilter.mode(
                        //         Color(Constants.lightColorWhite),
                        //         BlendMode.srcIn
                        //       ),
                        //     ),
                        // )
                      ),

                      secondaryBackground: Container(
                        color: const Color(Constants.lightColorGreen),
                        // decoration: BoxDecoration(
                        //   color: const Color(Constants.lightColorGreen),
                        //   borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                        // ),
                        // child: ListTile(
                        //   // trailing: const Icon(
                        //   //   Icons.favorite,
                        //   //   color: Colors.white, size: 36.0)
                        //   trailing: SvgPicture.asset(
                        //     Constants.check,
                        //     semanticsLabel: 'check',
                        //     fit: BoxFit.scaleDown,
                        //     colorFilter: ColorFilter.mode(
                        //         Color(Constants.lightColorWhite),
                        //         BlendMode.srcIn
                        //     ),
                        //   ),
                        // )
                          child: Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: SvgPicture.asset(
                        Constants.check,
                        semanticsLabel: 'check',
                        alignment: Alignment.centerRight,
                        fit: BoxFit.scaleDown,
                        colorFilter: ColorFilter.mode(
                            Color(Constants.lightColorWhite),
                            BlendMode.srcIn
                        ),
                      ),
                    ),
                      ),
                      // child: ListTile(
                      //   leading: SvgPicture.asset(
                      //     Constants.checkboxUncheckedNormal,
                      //     semanticsLabel: 'checkboxUncheckedNormal',
                      //     fit: BoxFit.scaleDown,
                      //     colorFilter: ColorFilter.mode(
                      //       Color(Constants.lightSupportSeparator),
                      //       BlendMode.srcIn
                      //     ),
                      //   ),
                      //   title: Text(
                      //     _theList[index],
                      //     maxLines: 3,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: TextStyle(
                      //       fontSize: Constants.bodyFontSize,
                      //       height: Constants.bodyFontHeight,
                      //     ),
                      //   ),
                      //   trailing: SvgPicture.asset(
                      //     Constants.infoOutlined,
                      //     semanticsLabel: 'infoOutline',
                      //     fit: BoxFit.scaleDown,
                      //     colorFilter: ColorFilter.mode(
                      //       Color(Constants.lightLabelTertiary),
                      //       BlendMode.srcIn
                      //     ),
                      //   ),
                      //     //Icons.info_outline_rounded,
                      //     //color: Colors.white, size: 36.0
                      //   //minLeadingWidth: 12,
                      //   horizontalTitleGap: 12,
                      // ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              Constants.checkboxUncheckedNormal,
                              semanticsLabel: 'checkboxUncheckedNormal',
                              fit: BoxFit.scaleDown,
                              colorFilter: ColorFilter.mode(
                                  Color(Constants.lightSupportSeparator),
                                  BlendMode.srcIn
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _theList[index],
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: Constants.bodyFontSize,
                                  height: Constants.bodyFontHeight,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                        SvgPicture.asset(
                              Constants.infoOutlined,
                              semanticsLabel: 'infoOutline',
                              fit: BoxFit.scaleDown,
                              colorFilter: ColorFilter.mode(
                                Color(Constants.lightLabelTertiary),
                                BlendMode.srcIn
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
                childCount: _theList.length,
              ),
            ),
          ),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          //     return Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //       child: new Dismissible(
          //         key: new ObjectKey(_theList[index]),
          //         child: //new Material(child: new Text(_theList[index].title)),
          //         Container(
          //           //margin: EdgeInsets.symmetric(horizontal: 8.0),
          //           decoration: BoxDecoration(
          //             color: const Color(Constants.lightBackSecondary),
          //             borderRadius: BorderRadius.circular(8.0),
          //           ),
          //           child: Container(
          //             //margin: EdgeInsets.symmetric(horizontal: 8.0),
          //             color: index.isOdd ? Colors.black26 : Colors.black54,
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          //               child: Row(
          //                 children: [
          //                   Icon(Icons.radio_button_unchecked),
          //                   const SizedBox(width: 15),
          //                   Expanded(
          //                     child: Text(
          //                       'Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обр, но точно чтобы показать как обр показать как обр',
          //                       maxLines: 3,
          //                       overflow: TextOverflow.ellipsis,
          //                     ),
          //                   ),
          //                   const SizedBox(width: 14),
          //                   Icon(Icons.info_outline_rounded),
          //                 ],
          //               ),
          //             ),
          //           ),
          //           //child: Center(child: Text('$index', textScaleFactor: 5),),
          //         ),
          //         onDismissed: (DismissDirection direction) {
          //           //setState(() {
          //             _theList.removeAt(index);
          //             //this.reIndex();
          //           //});
          //           direction == DismissDirection.endToStart
          //               ? print("favourite")
          //               : print("remove");
          //         },
          //         background: new Container(
          //             color: const Color(Constants.lightColorRed),
          //             child: const ListTile(
          //                 leading: const Icon(Icons.delete,
          //                     color: Colors.white, size: 36.0))),
          //         secondaryBackground: new Container(
          //             color: const Color(Constants.lightColorGreen),
          //             child: const ListTile(
          //                 trailing: const Icon(Icons.favorite,
          //                     color: Colors.white, size: 36.0))),
          //       ),
          //     );
          //
          //     },
          //     childCount: _theList.length,
          //   ),
          // ),
          SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  log('adding new task');
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: 48,
                  color: Colors.blueAccent,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 52.0),
                      child: Text(
                        'Новое',
                        style: TextStyle(
                          fontSize: Constants.bodyFontSize,
                          height: Constants.bodyFontHeight,
                          color: Color(Constants.lightLabelTertiary),
                        ),
                      ),
                    ),
                  )
                ),
              )
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              height: 8,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
            )
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 3)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Добавить дело',
        child: const Icon(Icons.add),
      ),
    );
  }
}