import 'package:flutter/material.dart';

class UIBuilder {
  static Widget parseJson(Map<String, dynamic> json) {
    if (json.containsKey('type')) {
      switch (json['type']) {
        case 'Scaffold':
          return Scaffold(
            backgroundColor: _parseColor(json['backgroundColor']),
            appBar: json.containsKey('appBar')
                ? _buildAppBar(json['appBar'])
                : null,
            body: json.containsKey('body')
                ? _buildBody(json['body'])
                : const Center(child: Text('No body content')),
          );
        default:
          return const SizedBox.shrink();
      }
    }
    return const SizedBox.shrink();
  }

  static AppBar _buildAppBar(Map<String, dynamic> appBarData) {
    return AppBar(
      backgroundColor: _parseColor(appBarData['backgroundColor']),
      title: Text(
        appBarData['title']['text'] ?? 'Default Title',
        style: _buildTextStyle(appBarData['title']['style']),
      ),
    );
  }

  static Widget _buildBody(Map<String, dynamic> bodyData) {
    if (bodyData['type'] == 'Column' || bodyData['type'] == 'Row') {
      return _buildFlexLayout(bodyData);
    } else if (bodyData['type'] == 'Center') {
      final child = bodyData['child'];
      if (child != null) {
        return Center(child: _buildChildWidget(child));
      }
    } else if (bodyData['type'] == 'Container') {
      return _buildContainer(bodyData);
    } else if (bodyData['type'] == 'Padding') {
      return Padding(
        padding: _buildEdgeInsets(bodyData['padding']),
        child: _buildChildWidget(bodyData['child']),
      );
    }
    return const SizedBox.shrink();
  }

  static Widget _buildContainer(Map<String, dynamic> containerData) {
    return Container(
      padding: _buildEdgeInsets(containerData['padding']),
      margin: _buildEdgeInsets(containerData['margin']),
      decoration: _buildBoxDecoration(containerData['decoration']),
      child: _buildChildWidget(containerData['child']),
    );
  }

  static BoxDecoration? _buildBoxDecoration(
      Map<String, dynamic>? decorationData) {
    if (decorationData == null) return null;
    return BoxDecoration(
      color: _parseColor(decorationData['color']),
      borderRadius: _buildBorderRadius(decorationData['borderRadius']),
      border: _buildBorder(decorationData['border']),
    );
  }

  static BorderRadius? _buildBorderRadius(
      Map<String, dynamic>? borderRadiusData) {
    if (borderRadiusData == null) return null;
    return BorderRadius.circular(borderRadiusData['radius']?.toDouble() ?? 0);
  }

  static Border? _buildBorder(Map<String, dynamic>? borderData) {
    if (borderData == null) return null;
    return Border.all(
      color: _parseColor(borderData['color']) ?? Colors.black,
      width: borderData['width']?.toDouble() ?? 1.0,
    );
  }

  static Widget _buildFlexLayout(Map<String, dynamic> flexData) {
    List<Widget> childrenWidgets = [];
    if (flexData.containsKey('children')) {
      final children = flexData['children'];
      for (var child in children) {
        childrenWidgets.add(_buildChildWidget(child));
      }
    }

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
      case 'start':
        return CrossAxisAlignment.start;
      case 'end':
        return CrossAxisAlignment.end;
      case 'center':
        return CrossAxisAlignment.center;
      case 'stretch':
        return CrossAxisAlignment.stretch;
      case 'baseline':
        return CrossAxisAlignment.baseline;
      default:
        return CrossAxisAlignment.start;
    }
  }

  static MainAxisAlignment _getMainAxisAlignment(Map<String, dynamic> flexData) {
    switch (flexData['mainAxisAlignment']) {
      case 'start':
        return MainAxisAlignment.start;
      case 'end':
        return MainAxisAlignment.end;
      case 'center':
        return MainAxisAlignment.center;
      case 'spaceBetween':
        return MainAxisAlignment.spaceBetween;
      case 'spaceAround':
        return MainAxisAlignment.spaceAround;
      case 'spaceEvenly':
        return MainAxisAlignment.spaceEvenly;
      default:
        return MainAxisAlignment.start;
    }
  }

  static Widget _buildChildWidget(Map<String, dynamic> childData) {
    switch (childData['type']) {
      case 'Text':
        return Text(
          childData['text'] ?? 'Default Text',
          style: _buildTextStyle(childData['style']),
        );
      case 'Padding':
        return Padding(
          padding: _buildEdgeInsets(childData['padding']),
          child: _buildChildWidget(childData['child']),
        );
      case 'CircleAvatar':
        return CircleAvatar(
          backgroundImage: childData['backgroundImage'] != null &&
                  childData['backgroundImage']['type'] == 'NetworkImage'
              ? NetworkImage(childData['backgroundImage']['url'])
              : null,
          radius: childData['radius']?.toDouble(),
        );
      case 'Column':
      case 'Row':
        return _buildFlexLayout(childData);
      case 'SizedBox':
        return SizedBox(
          height: childData['height']?.toDouble(),
          width: childData['width']?.toDouble(),
        );
      case 'Switch':
        return Switch(
          value: childData['value'] ?? false,
          onChanged: (bool newValue) {},
        );
      case 'Checkbox':
        return Checkbox(
          value: childData['value'] ?? false,
          onChanged: (bool? newValue) {},
        );
      case 'TextField':
        return TextField(
          decoration: InputDecoration(
            hintText: childData['hintText'],
          ),
        );
      case 'Image':
        return Image.network(childData['url']);
      case 'ListView':
        return _buildListView(childData['child']);/**//**/
      case 'SingleChildScrollView':
        return SingleChildScrollView(child: _buildChildWidget(childData['child']));
      case 'ElevatedButton':
        return ElevatedButton(
          onPressed: childData['onPressed'] != null
              ? () => debugPrint(childData['onPressed'][0])
              : null,
          style: _buildButtonStyle(childData['style']),
          child: _buildChildWidget(childData['child']),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  static EdgeInsets _buildEdgeInsets(Map<String, dynamic>? paddingData) {
    if (paddingData == null) return EdgeInsets.zero;
    return EdgeInsets.only(
      top: paddingData['top']?.toDouble() ?? 0,
      left: paddingData['left']?.toDouble() ?? 0,
      right: paddingData['right']?.toDouble() ?? 0,
      bottom: paddingData['bottom']?.toDouble() ?? 0,
    );
  }

  static ButtonStyle? _buildButtonStyle(Map<String, dynamic>? styleData) {
    if (styleData == null) return null;
    return ElevatedButton.styleFrom(
      backgroundColor: _parseColor(styleData['backgroundColor']),
      padding: styleData['padding'] != null
          ? EdgeInsets.symmetric(
              vertical: styleData['padding']['vertical']?.toDouble() ?? 0,
              horizontal: styleData['padding']['horizontal']?.toDouble() ?? 0,
            )
          : null,
      shape: styleData['shape'] != null &&
              styleData['shape']['type'] == 'RoundedRectangleBorder'
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  styleData['shape']['borderRadius']?.toDouble() ?? 0),
            )
          : null,
    );
  }

  static Color? _parseColor(String? colorString) {
    if (colorString == null) return null;
    return Color(int.parse(colorString.replaceFirst('#', '0xff')));
  }

  static TextStyle? _buildTextStyle(Map<String, dynamic>? styleData) {
    if (styleData == null) return null;
    return TextStyle(
      color: _parseColor(styleData['color']),
      fontSize: styleData['fontSize']?.toDouble(),
      fontWeight: _parseFontWeight(styleData['fontWeight']),
      fontStyle: styleData['fontStyle'] == 'italic' ? FontStyle.italic : null,
    );
  }

  static FontWeight? _parseFontWeight(String? fontWeight) {
    switch (fontWeight) {
      case 'bold':
        return FontWeight.bold;
      case 'w500':
        return FontWeight.w500;
      default:
        return null;
    }
  }

  static Widget _buildListView(Map<String, dynamic> listViewData) {
    List<Widget> childrenWidgets = [];
    if (listViewData.containsKey('children')) {
      final children = listViewData['children'];
      for (var child in children) {
        childrenWidgets.add(_buildChildWidget(child));
      }
    }

    return ListView(
      children: childrenWidgets,
    );
  }
}
