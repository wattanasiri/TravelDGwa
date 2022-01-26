/*
 *  Copyright 2020 Chaobin Wu <chaobinwu89@gmail.com>
 *  
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import 'dart:ui';

import 'package:flutter/material.dart';

import '../item.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';

/// Convex shape is fixed center.
class FixedTabStyle extends InnerBuilder {
  /// Index of the centered convex shape.
  final int convexIndex;

  /// Create style builder.
  FixedTabStyle({
    required List<TabItem> items,
    required Color activeColor,
    required Color color,
    required this.convexIndex,
  }) : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var c = active ? activeColor : color;
    var style = ofStyle(context);
    var item = items[index];
    var textStyle = style.textStyle(c, item.fontFamily);

    if (index == convexIndex) {
      var item = items[convexIndex];
      return Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            AnimatedContainer(
              width: active ? style.layoutSize * 1.2 : style.layoutSize,
              height: active ? style.layoutSize * 1.2 : style.layoutSize,
              curve: Curves.easeInOutCubicEmphasized,
              duration: const Duration(milliseconds: 600),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff64ECC7),
                  border: active ? Border.all(width: 10, color: Color(0xff00FFB9)) : null
                ),
                child: BlendImageIcon(
                  active ? item.activeIcon ?? item.icon : item.icon,
                  color: Color(0xffFFFFFF),
                  size: style.activeIconSize,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: active ? 0 : 10,
            ),
            Text(item.title ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFFF4DC)
                )
            )
          ],
        ),
      );
    }

    var noLabel = style.hideEmptyLabel && hasNoText(item);
    var icon = BlendImageIcon(
      active ? item.activeIcon ?? item.icon : item.icon,
      size: style.iconSize,
      color: item.blend ? (c) : null,
    );
    var children = noLabel
        ? <Widget>[icon]
        : <Widget>[icon, Text(item.title ?? '', style: textStyle)];
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: children,
      ),
    );
  }

  @override
  bool fixed() {
    return true;
  }
}
