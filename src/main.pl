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

# Define the ImGui colors mapping based on enum values and color definitions
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

# Define the input data
my $font_defs = {
    defs => [
        { name => "roboto-regular", sizes => [16, 18, 20, 24, 28, 32, 36, 48] },
    ]
};

# Transform the data using map
my @font_size_pairs = map {
    my $name = $_->{name};
    map { { name => $name, size => $_ } } @{ $_->{sizes} };
} @{ $font_defs->{defs} };


my $font_defs_json = encode_json(\@font_size_pairs);
my $theme_json = encode_json(\%theme2);

# Create a new instance
my $ffi = FFI::Platypus->new( api => 1 );
$ffi->lib('./libxframesshared.so');

# Define types
$ffi->type('(void)->void' => 'OnInitCb');
$ffi->type('(int, string)->void' => 'OnTextChangedCb');
$ffi->type('(int, int)->void' => 'OnComboChangedCb');
$ffi->type('(int, float)->void' => 'OnNumericValueChangedCb');
$ffi->type('(int, int)->void' => 'OnBooleanValueChangedCb');
$ffi->type('(int, opaque, int)->void' => 'OnMultipleNumericValuesChangedCb');
$ffi->type('(int)->void' => 'OnClickCb');


my $on_init = $ffi->closure(sub {
});

my $on_text_changed = $ffi->closure(sub {
    my ($id, $text) = @_;
    print "Text changed: ID=$id, Text=$text\n";
});

my $on_combo_changed = $ffi->closure(sub {
    my ($id, $selected_index) = @_;
    print "Combo changed: ID=$id, Selected=$selected_index\n";
});

my $on_numeric_value_changed = $ffi->closure(sub {
    my ($id, $value) = @_;
    print "Numeric value changed: ID=$id, Value=$value\n";
});

my $on_boolean_value_changed = $ffi->closure(sub {
    my ($id, $state) = @_;
    print "Boolean value changed: ID=$id, State=$state\n";
});

my $on_multiple_numeric_values_changed = $ffi->closure(sub {
    my ($id, $values_ptr, $num_values) = @_;
    # Dereference the float array (you may need XS helper code for this)
    print "Multiple numeric values changed: ID=$id, NumValues=$num_values\n";
});

my $on_click = $ffi->closure(sub {
    my ($id) = @_;
    print "Button clicked: ID=$id\n";
});

# Attach the `init` function
$ffi->attach(
    init => [
        'opaque',  # assetsBasePath
        'opaque',  # rawFontDefinitions
        'opaque',  # rawStyleOverrideDefinitions
        'OnInitCb',
        'OnTextChangedCb',
        'OnComboChangedCb',
        'OnNumericValueChangedCb',
        'OnBooleanValueChangedCb',
        'OnMultipleNumericValuesChangedCb',
        'OnClickCb'
    ] => 'void'
);

my $base_assets_path = './assets';

# my($base_assets_path_ptr, $base_assets_path_size) = scalar_to_buffer $base_assets_path;
# my($font_defs_json_ptr, $font_defs_json_size) = scalar_to_buffer $font_defs_json;
# my($theme_json_ptr, $theme_json_size) = scalar_to_buffer $theme_json;

my $base_assets_path_ptr = strdup $base_assets_path;
my $font_defs_json_ptr = strdup $font_defs_json;
my $theme_json_ptr = strdup $theme_json;


# Call the `init` function
init(
    $base_assets_path_ptr,
    $font_defs_json_ptr,
    $theme_json_ptr,
    $on_init,
    $on_text_changed,
    $on_combo_changed,
    $on_numeric_value_changed,
    $on_boolean_value_changed,
    $on_multiple_numeric_values_changed,
    $on_click
);

# print "Press enter to quit";
# my $user_input = <STDIN>;

# Set a timer that fires every 1 second
my $timer = AnyEvent->timer(
    after    => 1,        # First execution after 1 second
    interval => 1,        # Repeat every 1 second
    cb       => sub {
        print "Timer triggered!\n";
    },
);

# Keep the event loop running
AnyEvent->condvar->wait;
