class MediaFileInputComponent < ViewComponent::Base
  renders_one :custom_label
  def initialize(id:, file_field: ,name:, value:, remove_attr_name:, label: nil, file_type: "image/*", action: nil, disabled: false, use_same_for_lock: nil, file_name: nil, input_tooltip: nil, error_message: nil, size_allowed: 10, download_link: nil, external_target: nil, external_action: nil)
    @id = id
    @file_field = file_field
    @name = name
    @value = value
    @remove_attr_name = remove_attr_name
    @label = label
    @file_type = file_type
    @action = action
    @disabled = disabled
    @use_same_for_lock = use_same_for_lock
    @file_name = file_name
    @input_tooltip = input_tooltip
    @error_message = error_message
    @size_allowed = size_allowed   # size in MB - default 10
    @download_link = download_link
    @external_target = external_target
    @external_action = external_action
  end

  def image_src
    case @file_type
    when ".zip"
      asset_path('v2/icons/ic_zip@2x.png')
    when "image/*"
      @value
    when ".ogg",".mp3",".wav", ".mp3, .wav"
      asset_path('v2/icons/ic_audio@2x.png')
    when ".qmg"
      asset_path('v2/icons/ic-qmg-format.svg')
    when ".pem"
      asset_path('v2/icons/pem.png')
    when ".rtf"
      asset_path('v2/icons/ic-rtf.svg')
    when ".rtfd, .zip"
      asset_path('v2/icons/ic_zip@2x.png')
    when ".scr"
      asset_path('v2/icons/ic-scr-file.svg')
    when "application/json"
      asset_path('v2/icons/ic-api.svg')
    when ".cer"
      asset_path('v2/icons/ic-cer-format.svg')
    when ".crt"
      asset_path('v2/icons/ic-crt-format.svg')
    when ".pem, .cer, .crt, .cert"
      asset_path('v2/icons/ic-file-format.svg')
    when ".sh"
      asset_path('v2/icons/sh-file.svg')
    when ".pem, .cer"
      asset_path('v2/icons/pem.png')
    else
      @value
    end
  end

  def label_name
    "allowed" if @name == "brand[lockscreen_wallpaper]"
  end

  def disabled_img
    "bs-ui-disabled" if @name == "brand[lockscreen_wallpaper]" && @disabled
  end

  def file_size_error_message
    @error_message || t('brands.errors.wallpaper_too_large')
  end

  def file_field_data
    {
      controller: "tooltip",
      bs_toggle: "bs-tooltip",
      bs_title: @input_tooltip,
      action: [
        "remove-attachment#onFileChange",
        "apple-byod-form#onInputAppCatalog",
        (@external_action if @external_action.present?)
      ].compact.join(" "),
      remove_attachment_target: "fileInput",
      apple_byod_form_target: "catalogSettingLogo",
      branding_target: ("fileInput" if @name == "brand[lockscreen_wallpaper]")
    }
  end
end
