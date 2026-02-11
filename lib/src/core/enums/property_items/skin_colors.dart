import "package:avatar_maker/src/core/models/property_item.dart";

/// List of all the accessories skin colors by default.
enum SkinColors implements PropertyItem {
  Tanned("""
  <g id="SkinColor/Tanned" mask="url(#mask-6)" fill="#FD9841">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  Yellow("""
  <g id="SkinColor/Yellow" mask="url(#mask-6)" fill="#F8D25C">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  White("""
  <g id="SkinColor/White" mask="url(#mask-6)" fill="#FFDBB4">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>  """),
  Peach("""
  <g id="SkinColor/Pale" mask="url(#mask-6)" fill="#EDB98A">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g> 
  """),
  Brown("""
  <g id="SkinColor/Brown" mask="url(#mask-6)" fill="#D08B5B">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  DarkBrown("""
  <g id="SkinColor/DarkBrown" mask="url(#mask-6)" fill="#AE5D29">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g> 
  """),
  Porcelain("""
  <g id="SkinColor/Porcelain" mask="url(#mask-6)" fill="#FFE8D0">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  Honey("""
  <g id="SkinColor/Honey" mask="url(#mask-6)" fill="#E0AC69">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  Olive("""
  <g id="SkinColor/Olive" mask="url(#mask-6)" fill="#C68642">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  Espresso("""
  <g id="SkinColor/Espresso" mask="url(#mask-6)" fill="#8D5524">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  Almond("""
  <g id="SkinColor/Almond" mask="url(#mask-6)" fill="#C4956A">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  Black("""
  <g id="SkinColor/Black" mask="url(#mask-6)" fill="#614335">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  Ebony("""
  <g id="SkinColor/Ebony" mask="url(#mask-6)" fill="#4A2912">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """);

  final String svg;

  const SkinColors(this.svg);

  String get label => this.name;

  String get id => "SkinColor/$name";

  String get value => this.svg;
}
