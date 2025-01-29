import 'package:flutter/material.dart';

class UIBuilder {
  static Widget parseJson(Map<String, dynamic> json) {
    if (json['type'] == 'Scaffold') {
      return Scaffold(
        backgroundColor: _parseColor(json['backgroundColor']),
        appBar: _buildAppBar(json['appBar']),
        body: _buildBody(json['body']),
      );
    }
    return const SizedBox.shrink();
  }

  static AppBar? _buildAppBar(Map<String, dynamic>? appBarData) {
    if (appBarData == null) return null;
    return AppBar(
      backgroundColor: _parseColor(appBarData['backgroundColor']),
      title: Text(
        appBarData['title']['text'] ?? 'Default Title',
        style: _buildTextStyle(appBarData['title']['style']),
      ),
    );
  }

  static Widget _buildBody(Map<String, dynamic>? bodyData) {
    if (bodyData == null) return const SizedBox.shrink();
    switch (bodyData['type']) {
      case 'Column':
      case 'Row':
        return _buildFlexLayout(bodyData);
      case 'Center':
        return bodyData['child'] != null ? Center(child: _buildChildWidget(bodyData['child'])) : const SizedBox.shrink();
      case 'Container':
        return _buildContainer(bodyData);
      default:
        return const SizedBox.shrink();
    }
  }

  static Widget _buildContainer(Map<String, dynamic> containerData) {
    return Container(
      padding: _buildEdgeInsets(containerData['padding']),
      margin: _buildEdgeInsets(containerData['margin']),
      decoration: _buildBoxDecoration(containerData['decoration']),
      child: _buildChildWidget(containerData['child']),
    );
  }

  static BoxDecoration? _buildBoxDecoration(Map<String, dynamic>? decorationData) {
    return decorationData == null ? null : BoxDecoration(
      color: _parseColor(decorationData['color']),
      borderRadius: _buildBorderRadius(decorationData['borderRadius']),
      border: _buildBorder(decorationData['border']),
    );
  }

  static BorderRadius? _buildBorderRadius(Map<String, dynamic>? borderRadiusData) {
    return borderRadiusData == null ? null : BorderRadius.circular(borderRadiusData['radius']?.toDouble() ?? 0);
  }

  static Border? _buildBorder(Map<String, dynamic>? borderData) {
    return borderData == null ? null : Border.all(
      color: _parseColor(borderData['color']) ?? Colors.black,
      width: borderData['width']?.toDouble() ?? 1.0,
    );
  }

  static Widget _buildFlexLayout(Map<String, dynamic> flexData) {
    List<Widget> childrenWidgets = (flexData['children'] as List).map((child) => _buildChildWidget(child)).toList();
    return flexData['type'] == 'Column'
        ? Column(
      crossAxisAlignment: _getCrossAxisAlignment(flexData),
      mainAxisAlignment: _getMainAxisAlignment(flexData),
      children: childrenWidgets,
    )
        : Row(
      crossAxisAlignment: _getCrossAxisAlignment(flexData),
      mainAxisAlignment: _getMainAxisAlignment(flexData),
      children: childrenWidgets,
    );
  }

  static CrossAxisAlignment _getCrossAxisAlignment(Map<String, dynamic> flexData) {
    switch (flexData['crossAxisAlignment']) {
      case 'center': return CrossAxisAlignment.center;
      case 'stretch': return CrossAxisAlignment.stretch;
      default: return CrossAxisAlignment.start;
    }
  }

  static MainAxisAlignment _getMainAxisAlignment(Map<String, dynamic> flexData) {
    switch (flexData['mainAxisAlignment']) {
      case 'center': return MainAxisAlignment.center;
      case 'spaceBetween': return MainAxisAlignment.spaceBetween;
      default: return MainAxisAlignment.start;
    }
  }




  static Widget _buildChildWidget(Map<String, dynamic> childData) {
    switch (childData['type']) {
      case 'Text': return Text(childData['text'] ?? 'Default Text', style: _buildTextStyle(childData['style']));
      case 'Padding': return Padding(padding: _buildEdgeInsets(childData['padding']), child: _buildChildWidget(childData['child']));
      case 'CircleAvatar': return CircleAvatar(radius: childData['radius']?.toDouble());
      case 'SizedBox': return SizedBox(height: childData['height']?.toDouble(), width: childData['width']?.toDouble());
      case 'ElevatedButton': return ElevatedButton(onPressed: childData['onPressed'] != null ? () => debugPrint(childData['onPressed'][0]) : null, style: _buildButtonStyle(childData['style']), child: _buildChildWidget(childData['child']));
      default: return const SizedBox.shrink();
    }
  }

  static EdgeInsets _buildEdgeInsets(Map<String, dynamic>? paddingData) {
    return EdgeInsets.only(
      top: paddingData?['top']?.toDouble() ?? 0,
      left: paddingData?['left']?.toDouble() ?? 0,
      right: paddingData?['right']?.toDouble() ?? 0,
      bottom: paddingData?['bottom']?.toDouble() ?? 0,
    );
  }

  static ButtonStyle? _buildButtonStyle(Map<String, dynamic>? styleData) {
    if (styleData == null) return null;
    return ElevatedButton.styleFrom(
      backgroundColor: _parseColor(styleData['backgroundColor']),
      padding: EdgeInsets.symmetric(vertical: styleData['padding']['vertical']?.toDouble() ?? 0, horizontal: styleData['padding']['horizontal']?.toDouble() ?? 0),
    );
  }

  static Color? _parseColor(String? colorString) {
    return colorString == null ? null : Color(int.parse(colorString.replaceFirst('#', '0xff')));
  }

  static TextStyle? _buildTextStyle(Map<String, dynamic>? styleData) {
    return styleData == null ? null : TextStyle(
      color: _parseColor(styleData['color']),
      fontSize: styleData['fontSize']?.toDouble(),
      fontWeight: _parseFontWeight(styleData['fontWeight']),
    );
  }

  static FontWeight? _parseFontWeight(String? fontWeight) {
    switch (fontWeight) {
      case 'bold': return FontWeight.bold;
      case 'w500': return FontWeight.w500;
      default: return FontWeight.normal;
    }
  }
}
