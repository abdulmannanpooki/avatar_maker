import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class CustomizerBody extends StatelessWidget {
  final AvatarMakerController avatarMakerController;
  final AvatarMakerThemeData theme;
  final void Function(
    PropertyItem newSelectedItem,
    PropertyCategoryIds categoryId,
  ) onTapOption;
  final bool Function(PropertyCategoryIds categoryId, String itemId)?
      isItemLocked;
  final Widget? lockWidget;
  final void Function(PropertyCategoryIds categoryId, String itemId)?
      onTapLockedItem;

  const CustomizerBody({
    required this.avatarMakerController,
    required this.theme,
    required this.onTapOption,
    this.isItemLocked,
    this.lockWidget,
    this.onTapLockedItem,
  });

  /// Check if a category is a color category
  bool _isColorCategory(PropertyCategoryIds categoryId) {
    return categoryId == PropertyCategoryIds.SkinColor ||
        categoryId == PropertyCategoryIds.HairColor ||
        categoryId == PropertyCategoryIds.OutfitColor ||
        categoryId == PropertyCategoryIds.FacialHairColor;
  }

  /// Get the color from an item's value (hex code or SVG fill)
  Color? _getColorFromItem(PropertyItem item, PropertyCategoryIds categoryId) {
    final value = item.value;

    // For HairColor, OutfitColor, FacialHairColor - value is hex code
    if (categoryId == PropertyCategoryIds.HairColor ||
        categoryId == PropertyCategoryIds.OutfitColor ||
        categoryId == PropertyCategoryIds.FacialHairColor) {
      if (value.startsWith('#')) {
        final hex = value.replaceFirst('#', '');
        return Color(int.parse('FF$hex', radix: 16));
      }
    }

    // For SkinColor - extract fill color from SVG
    if (categoryId == PropertyCategoryIds.SkinColor) {
      final fillMatch = RegExp(r'fill="(#[A-Fa-f0-9]{6})"').firstMatch(value);
      if (fillMatch != null) {
        final hex = fillMatch.group(1)!.replaceFirst('#', '');
        return Color(int.parse('FF$hex', radix: 16));
      }
    }

    return null;
  }

  /// Build a horizontal row of square SVG tiles for style categories
  Widget _buildStyleRow(CustomizedPropertyCategory propertyCategory) {
    final selectedItem =
        avatarMakerController.selectedOptions[propertyCategory.id] ??
            propertyCategory.properties!.first;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: theme.primaryBgColor,
        borderRadius: BorderRadius.circular(40),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: theme.scrollPhysics,
        itemCount: propertyCategory.properties!.length,
        itemBuilder: (context, index) {
          final item = propertyCategory.properties![index];
          final isSelected = item.id == selectedItem.id;
          final isLocked =
              isItemLocked?.call(propertyCategory.id, item.id) ?? false;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: isLocked
                  ? () => onTapLockedItem?.call(propertyCategory.id, item.id)
                  : () => onTapOption(item, propertyCategory.id),
              child: Stack(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(color: Color(0xFFE91E63), width: 3)
                          : null,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SvgPicture.string(
                        avatarMakerController.getComponentSVG(
                            propertyCategory.id, index),
                        fit: BoxFit.cover,
                        placeholderBuilder: (context) => Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    ),
                  ),
                  if (isLocked)
                    lockWidget ??
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build a horizontal row with icon + color circles for color categories
  Widget _buildColorRow(CustomizedPropertyCategory propertyCategory) {
    final selectedItem =
        avatarMakerController.selectedOptions[propertyCategory.id] ??
            propertyCategory.properties!.first;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: theme.primaryBgColor,
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // Category icon
          SvgPicture.asset(
            propertyCategory.iconFile!,
            package: 'avatar_maker',
            height: 28,
            colorFilter: ColorFilter.mode(
              theme.unselectedIconColor,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          // Color circles
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: theme.scrollPhysics,
              itemCount: propertyCategory.properties!.length,
              itemBuilder: (context, index) {
                final item = propertyCategory.properties![index];
                final isSelected = item.id == selectedItem.id;
                final isLocked =
                    isItemLocked?.call(propertyCategory.id, item.id) ?? false;
                final color =
                    _getColorFromItem(item, propertyCategory.id) ?? Colors.grey;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: isLocked
                        ? () =>
                            onTapLockedItem?.call(propertyCategory.id, item.id)
                        : () => onTapOption(item, propertyCategory.id),
                    child: Stack(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: Colors.white, width: 3)
                                : null,
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: color.withValues(alpha: 0.5),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    )
                                  ]
                                : null,
                          ),
                        ),
                        if (isLocked)
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build rows for each displayed category
    final rows = <Widget>[];

    for (final propertyCategory
        in avatarMakerController.displayedPropertyCategories) {
      if (_isColorCategory(propertyCategory.id)) {
        rows.add(_buildColorRow(propertyCategory));
      } else {
        rows.add(_buildStyleRow(propertyCategory));
      }
      rows.add(const SizedBox(height: 12));
    }

    // Remove the last SizedBox
    if (rows.isNotEmpty) {
      rows.removeLast();
    }

    return Container(
      // decoration: theme.boxDecoration,
      // clipBehavior: Clip.hardEdge,
      child: Container(
        // color: theme.secondaryBgColor,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: rows,
        ),
      ),
    );
  }
}
