/**
 * @author: FTL
 * @date: 2019-12-22 18:50
 * @desc: 首页热门商品组件
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../pages/good_detail_page.dart';
import '../../routes/routers.dart';

class HomeHotWidget extends StatelessWidget {
  final List hotGoods;

  HomeHotWidget({Key key, @required this.hotGoods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[hotTitleContainer, _hotList()],
    );
  }

  Widget hotTitleContainer = Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.only(left: 10, bottom: 4, top: 3),
      alignment: Alignment.centerLeft,
      child: Text(
        "火爆专区",
        style: TextStyle(color: Color(0xffdf1581), fontSize: 16),
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffeeeeee)))));

  Widget _hotList() {
    if (hotGoods.length == 0) {
      return Text("");
    }

    List<Widget> listWidget = hotGoods.map((item) {
      return HomeHotItemWidget(
          goodsId: item['goodsId'],
          image: item['image'],
          name: item['name'],
          mallPrice: item['mallPrice'],
          price: item['price']);
    }).toList();

    return Wrap(
      spacing: 2,
      children: listWidget,
    );
  }
}

class HomeHotItemWidget extends StatelessWidget {
  final String goodsId;
  final String image;
  final String name;
  final double mallPrice;
  final double price;

  HomeHotItemWidget(
      {Key key,
      @required this.goodsId,
      @required this.image,
      @required this.name,
      @required this.mallPrice,
      @required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goPage(context, GoodDetailPage(goodId: goodsId));
      },
      child: Container(
        width: ScreenUtil().setWidth(372),
        color: Colors.white,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 3),
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: this.image,
              width: ScreenUtil().setWidth(375),
              placeholder: (context, url) {
                return Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.fill,
                  height: ScreenUtil().setHeight(315),
                );
              },
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text(
              this.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("￥${mallPrice}"),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "￥${price}",
                    style: TextStyle(
                        color: Colors.black26,
                        decoration: TextDecoration.lineThrough),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
