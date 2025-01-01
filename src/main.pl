use FFI::Platypus;
use FFI::Platypus::Buffer;
use FFI::Platypus::Memory;
use JSON;
use AnyEvent;

my %ImGuiCol = (
    Text => 0,
    TextDisabled => 1,
    WindowBg => 2,
    ChildBg => 3,
    PopupBg => 4,
    Border => 5,
    BorderShadow => 6,
    FrameBg => 7,
    FrameBgHovered => 8,
    FrameBgActive => 9,
    TitleBg => 10,
    TitleBgActive => 11,
    TitleBgCollapsed => 12,
    MenuBarBg => 13,
    ScrollbarBg => 14,
    ScrollbarGrab => 15,
    ScrollbarGrabHovered => 16,
    ScrollbarGrabActive => 17,
    CheckMark => 18,
    SliderGrab => 19,
    SliderGrabActive => 20,
    Button => 21,
    ButtonHovered => 22,
    ButtonActive => 23,
    Header => 24,
    HeaderHovered => 25,
    HeaderActive => 26,
    Separator => 27,
    SeparatorHovered => 28,
    SeparatorActive => 29,
    ResizeGrip => 30,
    ResizeGripHovered => 31,
    ResizeGripActive => 32,
    Tab => 33,
    TabHovered => 34,
    TabActive => 35,
    TabUnfocused => 36,
    TabUnfocusedActive => 37,
    PlotLines => 38,
    PlotLinesHovered => 39,
    PlotHistogram => 40,
    PlotHistogramHovered => 41,
    TableHeaderBg => 42,
    TableBorderStrong => 43,
    TableBorderLight => 44,
    TableRowBg => 45,
    TableRowBgAlt => 46,
    TextSelectedBg => 47,
    DragDropTarget => 48,
    NavHighlight => 49,
    NavWindowingHighlight => 50,
    NavWindowingDimBg => 51,
    ModalWindowDimBg => 52,
    COUNT => 53,
);

my %theme2Colors = (
    darkestGrey      => "#141f2c",
    darkerGrey       => "#2a2e39",
    darkGrey         => "#363b4a",
    lightGrey        => "#5a5a5a",
    lighterGrey      => "#7A818C",
    evenLighterGrey  => "#8491a3",
    black            => "#0A0B0D",
    green            => "#75f986",
    red              => "#ff0062",
    white            => "#fff",
);

my %theme2 = (
    colors => {
        $ImGuiCol{Text}              => [$theme2Colors{white}, 1],
        $ImGuiCol{TextDisabled}      => [$theme2Colors{lighterGrey}, 1],
        $ImGuiCol{WindowBg}          => [$theme2Colors{black}, 1],
        $ImGuiCol{ChildBg}           => [$theme2Colors{black}, 1],
        $ImGuiCol{PopupBg}           => [$theme2Colors{white}, 1],
        $ImGuiCol{Border}            => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{BorderShadow}      => [$theme2Colors{darkestGrey}, 1],
        $ImGuiCol{FrameBg}           => [$theme2Colors{black}, 1],
        $ImGuiCol{FrameBgHovered}    => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{FrameBgActive}     => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{TitleBg}           => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{TitleBgActive}     => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{TitleBgCollapsed}  => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{MenuBarBg}         => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{ScrollbarBg}       => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{ScrollbarGrab}     => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{ScrollbarGrabHovered} => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{ScrollbarGrabActive} => [$theme2Colors{darkestGrey}, 1],
        $ImGuiCol{CheckMark}         => [$theme2Colors{darkestGrey}, 1],
        $ImGuiCol{SliderGrab}        => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{SliderGrabActive}  => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{Button}            => [$theme2Colors{black}, 1],
        $ImGuiCol{ButtonHovered}     => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{ButtonActive}      => [$theme2Colors{black}, 1],
        $ImGuiCol{Header}            => [$theme2Colors{black}, 1],
        $ImGuiCol{HeaderHovered}     => [$theme2Colors{black}, 1],
        $ImGuiCol{HeaderActive}      => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{Separator}         => [$theme2Colors{darkestGrey}, 1],
        $ImGuiCol{SeparatorHovered}  => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{SeparatorActive}   => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{ResizeGrip}        => [$theme2Colors{black}, 1],
        $ImGuiCol{ResizeGripHovered} => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{ResizeGripActive}  => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{Tab}               => [$theme2Colors{black}, 1],
        $ImGuiCol{TabHovered}        => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{TabActive}         => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{TabUnfocused}      => [$theme2Colors{black}, 1],
        $ImGuiCol{TabUnfocusedActive} => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{PlotLines}         => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{PlotLinesHovered}  => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{PlotHistogram}     => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{PlotHistogramHovered} => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{TableHeaderBg}     => [$theme2Colors{black}, 1],
        $ImGuiCol{TableBorderStrong} => [$theme2Colors{lightGrey}, 1],
        $ImGuiCol{TableBorderLight}  => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{TableRowBg}        => [$theme2Colors{darkGrey}, 1],
        $ImGuiCol{TableRowBgAlt}     => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{TextSelectedBg}    => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{DragDropTarget}    => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{NavHighlight}      => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{NavWindowingHighlight} => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{NavWindowingDimBg} => [$theme2Colors{darkerGrey}, 1],
        $ImGuiCol{ModalWindowDimBg} => [$theme2Colors{darkerGrey}, 1],
    },
);

my $base_font_defs = {
    defs => [
        { name => "roboto-regular", sizes => [16, 18, 20, 24, 28, 32, 36, 48] },
    ]
};

my @font_size_pairs = map {
    my $name = $_->{name};
    map { { name => $name, size => $_ } } @{ $_->{sizes} };
} @{ $base_font_defs->{defs} };

my $font_defs = {
    defs => \@font_size_pairs
};

my $font_defs_json = encode_json($font_defs);
# my $theme_json = encode_json($theme2{colors});
my $theme_json = encode_json(\%theme2);

my $ffi = FFI::Platypus->new( api => 2 );
$ffi->lib('./libxframesshared.so');

$ffi->type('(void)->void' => 'OnInitCb');
$ffi->type('(int, string)->void' => 'OnTextChangedCb');
$ffi->type('(int, int)->void' => 'OnComboChangedCb');
$ffi->type('(int, float)->void' => 'OnNumericValueChangedCb');
$ffi->type('(int, int)->void' => 'OnBooleanValueChangedCb');
$ffi->type('(int, opaque, int)->void' => 'OnMultipleNumericValuesChangedCb');
$ffi->type('(int)->void' => 'OnClickCb');


my $on_init = $ffi->closure(sub {
});
$on_init->sticky;

my $on_text_changed = $ffi->closure(sub {
    my ($id, $text) = @_;
    print "Text changed: ID=$id, Text=$text\n";
});
$on_text_changed->sticky;

my $on_combo_changed = $ffi->closure(sub {
    my ($id, $selected_index) = @_;
    print "Combo changed: ID=$id, Selected=$selected_index\n";
});
$on_combo_changed->sticky;

my $on_numeric_value_changed = $ffi->closure(sub {
    my ($id, $value) = @_;
    print "Numeric value changed: ID=$id, Value=$value\n";
});
$on_numeric_value_changed->sticky;

my $on_boolean_value_changed = $ffi->closure(sub {
    my ($id, $state) = @_;
    print "Boolean value changed: ID=$id, State=$state\n";
});
$on_boolean_value_changed->sticky;

my $on_multiple_numeric_values_changed = $ffi->closure(sub {
    my ($id, $values_ptr, $num_values) = @_;
    # Dereference the float array (you may need XS helper code for this)
    print "Multiple numeric values changed: ID=$id, NumValues=$num_values\n";
});
$on_multiple_numeric_values_changed->sticky;

my $on_click = $ffi->closure(sub {
    my ($id) = @_;
    print "Button clicked: ID=$id\n";
});
$on_click->sticky;

# Attach the `init` function
$ffi->attach(
    init => [
        'string',  # assetsBasePath
        'string',  # rawFontDefinitions
        'string',  # rawStyleOverrideDefinitions
        'OnInitCb',
        'OnTextChangedCb',
        'OnComboChangedCb',
        'OnNumericValueChangedCb',
        'OnBooleanValueChangedCb',
        'OnMultipleNumericValuesChangedCb',
        'OnClickCb'
    ] => 'void'
);

my $base_assets_path = '../assets';

# my($base_assets_path_ptr, $base_assets_path_size) = scalar_to_buffer $base_assets_path;
# my($font_defs_json_ptr, $font_defs_json_size) = scalar_to_buffer $font_defs_json;
# my($theme_json_ptr, $theme_json_size) = scalar_to_buffer $theme_json;

# my $base_assets_path_ptr = strdup $base_assets_path;
# my $font_defs_json_ptr = strdup $font_defs_json;
# my $theme_json_ptr = strdup $theme_json;


print $base_assets_path . "\n";
print $theme_json . "\n";

# Call the `init` function
init(
    $base_assets_path,
    $font_defs_json,
    $theme_json,
    $on_init,
    $on_text_changed,
    $on_combo_changed,
    $on_numeric_value_changed,
    $on_boolean_value_changed,
    $on_multiple_numeric_values_changed,
    $on_click
);

my $timer = AnyEvent->timer(
    after    => 1,        
    interval => 1,       
    cb       => sub {
        print "Timer triggered!\n";
    },
);

# Keep the event loop running
AnyEvent->condvar->wait;
