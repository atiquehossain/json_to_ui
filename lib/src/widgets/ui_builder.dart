import 'package:flutter/material.dart';

import '../../json_to_ui.dart';

class UIBuilder {
  static Widget parseJson(Map<String, dynamic> json) {
    return _buildWidget(json);
  }

  static Widget _buildWidget(Map<String, dynamic> config) {
    switch (config['type']) {
      case 'Scaffold':
        return Scaffold(
          backgroundColor: _parseColor(config['backgroundColor']),
          appBar: _buildAppBar(config['appBar']),
          body: _buildBody(config['body']),
        );
      case 'Container':
        return Container(
          decoration: _buildBoxDecoration(config['decoration']),
          padding: _buildEdgeInsets(config['padding']),
          margin: _buildEdgeInsets(config['margin']),
          child: _buildChild(config['child']),
        );
      case 'Column':
        return Column(
          mainAxisAlignment: _getMainAxisAlignment(config['mainAxisAlignment']),
          crossAxisAlignment: _getCrossAxisAlignment(config['crossAxisAlignment']),
          children: _buildChildren(config['children']),
        );
      case 'Row':
        return Row(
          mainAxisAlignment: _getMainAxisAlignment(config['mainAxisAlignment']),
          crossAxisAlignment: _getCrossAxisAlignment(config['crossAxisAlignment']),
          children: _buildChildren(config['children']),
        );
      case 'Text':
        return Text(
          config['text'] ?? '',
          style: _buildTextStyle(config['style']),
        );
      case 'Image':
        return CachedImage(
          imageUrl: config['url'],
          radius: config['radius']?.toDouble(),
        );
      default:
        return const SizedBox.shrink();
    }
  }


  static AppBar? _buildAppBar(Map<String, dynamic>? config) {
    if (config == null) return null;
    return AppBar(
      title: Text(config['title'] ?? ''),
      backgroundColor: _parseColor(config['backgroundColor']),
    );
  }

  static Widget _buildBody(dynamic bodyConfig) {
    if (bodyConfig is List) {
      return Column(children: _buildChildren(bodyConfig));
    }
    return _buildWidget(bodyConfig);
  }

  static List<Widget> _buildChildren(List<dynamic>? children) {
    return children?.map<Widget>((child) => _buildWidget(child)).toList() ?? [];
  }

  static Widget _buildChild(dynamic childConfig) {
    return childConfig != null ? _buildWidget(childConfig) : const SizedBox.shrink();
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

  static EdgeInsets _buildEdgeInsets(Map<String, dynamic>? paddingData) {
    if (paddingData == null) return EdgeInsets.zero;
    return EdgeInsets.only(
      top: paddingData['top']?.toDouble() ?? 0,
      left: paddingData['left']?.toDouble() ?? 0,
      right: paddingData['right']?.toDouble() ?? 0,
      bottom: paddingData['bottom']?.toDouble() ?? 0,
    );
  }



  static BoxDecoration? _buildBoxDecoration(Map<String, dynamic>? decorationData) {
    if (decorationData == null) return null;
    return BoxDecoration(
      color: _parseColor(decorationData['color']),
      borderRadius: _buildBorderRadius(decorationData['borderRadius']),
      border: _buildBorder(decorationData['border']),
    );
  }

  static BorderRadius? _buildBorderRadius(Map<String, dynamic>? borderRadiusData) {
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

}