import 'package:flutter/material.dart';

import 'package:todo/constants.dart' as Constants;

import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _theList = ['Купить что-то','Купить что-то','Купить что-то','Купить что-то','Купить что-то, где-то, зачем-то, но зачем не очень понятно','Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать как обр, но точно чтобы показать как обр показать как обр','Купить что-то','Купить что-то','Купить что-то','Купить что-то','Купить что-то','Купить что-то','Купить что-то','Купить что-то','Купить что-то','Купить что-то','Купить что-то'];
    //List<String> _theList = ['1','2','3','4','5','6','7','8','9','10','11','12','13',];
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
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                  return Card(
                    color: Color(Constants.lightBackSecondary),
                    //color: Colors.amberAccent,
                    semanticContainer: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    elevation: 4,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          child: ListView.builder(
                            //padding: EdgeInsets.only(top: 8),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: _theList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                  key: Key(_theList[index]),
                                  onDismissed: (DismissDirection direction) {
                                    print(index);
                                    //_theList.removeAt(index);
                                    print(index);
                                    //this.reIndex();
                                    direction == DismissDirection.endToStart
                                        ? print("favourite")
                                        : print("remove");
                                    print(_theList);
                                  },

                                  // confirmDismiss: (DismissDirection direction) async {
                                  //     setState(() {
                                  //       _theList.removeAt(index);
                                  //     //this.reIndex();
                                  //     });
                                  //
                                  //   print(index);
                                  //   direction == DismissDirection.endToStart
                                  //       ? print("favourite")
                                  //       : print("remove");
                                  //   print(_theList);
                                  //   return true;
                                  // },

                                  background: Container(
                                    color: const Color(Constants.lightColorGreen),
                                    // decoration: BoxDecoration(
                                    //   color: const Color(Constants.lightColorRed),
                                    //   borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                                    // ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 24.0),
                                      child: SvgPicture.asset(
                                        Constants.check,
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
                                    color: const Color(Constants.lightColorRed),
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
                                        Constants.delete,
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

                                  child: Container(
                                    //color: index.isOdd ? Colors.black26 : Colors.black12,
                                    child: Padding(
                                      padding: index == 0
                                        ? const EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 12)
                                        : const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                      // padding: EdgeInsets.only(
                                      //   left: 16,
                                      //   top: index == 0
                                      //     ? 20
                                      //     : 12,
                                      //   right: 16,
                                      //   bottom: 12
                                      // ),
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
                                );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            log('adding new task');
                          },
                          child: Container(
                              margin: EdgeInsets.only(bottom: 8),
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
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
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