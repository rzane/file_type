# FileType

[![github.com](https://img.shields.io/github/workflow/status/rzane/file_type/Build.svg)](https://github.com/rzane/file_type/actions?query=workflow%3ABuild)
[![coveralls.io](https://img.shields.io/coveralls/github/rzane/file_type.svg)](https://coveralls.io/github/rzane/file_type)
[![hex.pm](https://img.shields.io/hexpm/v/file_type.svg)](https://hex.pm/packages/file_type)
[![hex.pm](https://img.shields.io/hexpm/dt/file_type.svg)](https://hex.pm/packages/file_type)
[![hex.pm](https://img.shields.io/hexpm/l/file_type.svg)](https://hex.pm/packages/file_type)
[![github.com](https://img.shields.io/github/last-commit/rzane/file_type.svg)](https://github.com/rzane/file_type/commits/master)

This package can be used to detect the MIME type and canonical extension by looking for [magic numbers](https://en.wikipedia.org/wiki/Magic_number_(programming)#Magic_numbers_in_files). It works by reading a small amount of data from the file (~256 bytes) and binary pattern matching against it's contents.

[API Documentation](https://hexdocs.pm/file_type/FileType.html)

## Usage

Detecting a file's type:

```elixir
iex> FileType.from_path("profile.png")
{:ok, {"png", "image/png"}}

iex> FileType.from_path("contract.docx")
{:ok, {"docx", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"}}
```

Detect a file's type from an IO:

```elixir
iex> {:ok, file} = File.open("profile.png", [:read, :binary])
{:ok, file}

iex> FileType.from_io(file)
{:ok, {"png", "image/png"}}
```

## Installation

The package can be installed by adding `file_type` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:file_type, "~> 0.1.0"}
  ]
end
```

## Supported types

#### Document

- [`docx`](https://en.wikipedia.org/wiki/Office_Open_XML) - Microsoft Word Open XML Document
- [`pptx`](https://en.wikipedia.org/wiki/Office_Open_XML) - PowerPoint Open XML Presentation
- [`xlsx`](https://en.wikipedia.org/wiki/Office_Open_XML) - Microsoft Excel Open XML Spreadsheet
- [`doc`](https://en.wikipedia.org/wiki/Compound_File_Binary_Format) - Microsoft Word Document
- [`ppt`](https://en.wikipedia.org/wiki/Compound_File_Binary_Format) - PowerPoint Presentation
- [`xls`](https://en.wikipedia.org/wiki/Compound_File_Binary_Format) - Excel Spreadsheet
- [`pdf`](https://en.wikipedia.org/wiki/Portable_Document_Format) - Portable Document Format File
- [`epub`](https://en.wikipedia.org/wiki/EPUB) - Open eBook File
- [`mobi`](https://en.wikipedia.org/wiki/Mobipocket) - Mobipocket eBook
- [`odt`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument Text Document
- [`ods`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument Spreadsheet
- [`odp`](https://en.wikipedia.org/wiki/OpenDocument) - OpenDocument Presentation
- [`rtf`](https://en.wikipedia.org/wiki/Rich_Text_Format) - Rich Text Format File

#### Image

- [`jpg`](https://en.wikipedia.org/wiki/JPEG) - JPEG Image
- [`png`](https://en.wikipedia.org/wiki/Portable_Network_Graphics) - Portable Network Graphic
- [`apng`](https://en.wikipedia.org/wiki/APNG) - Animated Portable Network Graphic
- [`gif`](https://en.wikipedia.org/wiki/GIF) - Graphical Interchange Format File
- [`webp`](https://en.wikipedia.org/wiki/WebP) - WebP Image
- [`flif`](https://en.wikipedia.org/wiki/Free_Lossless_Image_Format) - Free Lossless Image Format File
- [`cr2`](https://fileinfo.com/extension/cr2) - Canon Raw Image File
- [`cr3`](https://fileinfo.com/extension/cr3) - Canon Raw 3 Image File
- [`orf`](https://en.wikipedia.org/wiki/ORF_format) - Olympus RAW File
- [`arw`](https://en.wikipedia.org/wiki/Raw_image_format#ARW) - Sony Digital Camera Image
- [`dng`](https://en.wikipedia.org/wiki/Digital_Negative) - Digital Negative Image File
- [`nef`](https://www.nikonusa.com/en/learn-and-explore/a/products-and-innovation/nikon-electronic-format-nef.html) - Nikon Electronic Format RAW Image
- [`rw2`](https://en.wikipedia.org/wiki/Raw_image_format) - Panasonic RAW Image
- [`raf`](https://en.wikipedia.org/wiki/Raw_image_format) - Fuji RAW Image File
- [`tif`](https://en.wikipedia.org/wiki/Tagged_Image_File_Format) - Tagged Image File
- [`bmp`](https://en.wikipedia.org/wiki/BMP_file_format) - Bitmap Image File
- [`icns`](https://en.wikipedia.org/wiki/Apple_Icon_Image_format) - macOS Icon Resource File
- [`jxr`](https://en.wikipedia.org/wiki/JPEG_XR) - JPEG XR Image
- [`psd`](https://en.wikipedia.org/wiki/Adobe_Photoshop#File_format) - Adobe Photoshop Document
- [`dmg`](https://en.wikipedia.org/wiki/Apple_Disk_Image) - Apple Disk Image
- [`ico`](https://en.wikipedia.org/wiki/ICO_(file_format)) - Icon File
- [`bpg`](https://bellard.org/bpg/) - BPG Image
- [`jp2`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000 Core Image File
- [`jpm`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000 Compound Image File Format
- [`jpx`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000 Image File
- [`heic`](https://nokiatech.github.io/heif/technical.html) - High Efficiency Image Format
- [`cur`](https://en.wikipedia.org/wiki/ICO_(file_format)) - Windows Cursor
- [`ktx`](https://www.khronos.org/opengles/sdk/tools/KTX/file_format_spec/) - Khronos Texture
- [`avif`](https://en.wikipedia.org/wiki/AV1#AV1_Image_File_Format_(AVIF)) - AV1 Image
- [`dcm`](https://en.wikipedia.org/wiki/DICOM#Data_format) - DICOM Image

#### Video

- [`mp4`](https://en.wikipedia.org/wiki/MPEG-4_Part_14#Filename_extensions) - MPEG-4 Video File
- [`mkv`](https://en.wikipedia.org/wiki/Matroska) - Matroska Video File
- [`webm`](https://en.wikipedia.org/wiki/WebM) - WebM Video File
- [`mov`](https://en.wikipedia.org/wiki/QuickTime_File_Format) - Apple QuickTime Movie
- [`avi`](https://en.wikipedia.org/wiki/Audio_Video_Interleave) - Audio Video Interleave File
- [`mpg`](https://en.wikipedia.org/wiki/MPEG-1) - MPEG Video File
- [`ogv`](https://en.wikipedia.org/wiki/Ogg) - Ogg Video File
- [`ogm`](https://en.wikipedia.org/wiki/Ogg) - Ogg Media File
- [`flv`](https://en.wikipedia.org/wiki/Flash_Video) - Flash Video File
- [`mts`](https://en.wikipedia.org/wiki/.m2ts) - AVCHD Video File
- [`mj2`](https://en.wikipedia.org/wiki/Motion_JPEG_2000) - Motion JPEG 2000 Video Clip
- [`3gp`](https://en.wikipedia.org/wiki/3GP_and_3G2#3GP) - 3GPP Multimedia File
- [`3g2`](https://en.wikipedia.org/wiki/3GP_and_3G2#3G2) - 3GPP2 Multimedia File
- [`m4v`](https://en.wikipedia.org/wiki/M4V) - iTunes Video File
- [`m4p`](https://en.wikipedia.org/wiki/MPEG-4_Part_14#Filename_extensions) - iTunes Music Store Audio File
- [`f4v`](https://en.wikipedia.org/wiki/Flash_Video) - Flash MP4 Video File
- [`f4p`](https://en.wikipedia.org/wiki/Flash_Video) - Adobe Flash Protected Media File

#### Audio

- [`mp1`](https://en.wikipedia.org/wiki/MPEG-1_Audio_Layer_I) - MPEG-1 Layer 1 Audio File
- [`mp2`](https://en.wikipedia.org/wiki/MPEG-1_Audio_Layer_II) - MPEG Layer II Compressed Audio File
- [`mp3`](https://en.wikipedia.org/wiki/MP3) - MP3 Audio File
- [`aac`](https://en.wikipedia.org/wiki/Advanced_Audio_Coding) - Advanced Audio Coding File
- [`ogg`](https://en.wikipedia.org/wiki/Ogg) - Ogg Vorbis Audio File
- [`oga`](https://en.wikipedia.org/wiki/Ogg) - Ogg Vorbis Audio File
- [`spx`](https://en.wikipedia.org/wiki/Ogg) - Ogg Vorbis Speex File
- [`opus`](https://en.wikipedia.org/wiki/Opus_(audio_format)) - Opus Audio File
- [`flac`](https://en.wikipedia.org/wiki/FLAC) - Free Lossless Audio Codec File
- [`wav`](https://en.wikipedia.org/wiki/WAV) - WAVE Audio File
- [`mid`](https://en.wikipedia.org/wiki/MIDI) - MIDI File
- [`qcp`](https://en.wikipedia.org/wiki/QCP) - PureVoice Audio File
- [`amr`](https://en.wikipedia.org/wiki/Adaptive_Multi-Rate_audio_codec) - Adaptive Multi-Rate Codec File
- [`aif`](https://en.wikipedia.org/wiki/Audio_Interchange_File_Format) - Audio Interchange File Format
- [`ape`](https://en.wikipedia.org/wiki/Monkey%27s_Audio) - Monkey's Audio Lossless Audio File
- [`wv`](https://en.wikipedia.org/wiki/WavPack) - WavPack Audio File
- [`mpc`](https://en.wikipedia.org/wiki/Musepack) - Musepack Compressed Audio File
- [`dsf`](https://dsd-guide.com/sites/default/files/white-papers/DSFFileFormatSpec_E.pdf) - Delusion Digital Sound File
- [`voc`](https://wiki.multimedia.cx/index.php/Creative_Voice) - Creative Labs Audio File
- [`ac3`](https://www.atsc.org/standard/a522012-digital-audio-compression-ac-3-e-ac-3-standard-12172012/) - Audio Codec 3 File
- [`m4a`](https://en.wikipedia.org/wiki/M4A) - MPEG-4 Audio File
- [`m4b`](https://en.wikipedia.org/wiki/M4B) - MPEG-4 Audiobook File
- [`f4a`](https://en.wikipedia.org/wiki/Flash_Video) - Adobe Flash Protected Audio File
- [`f4b`](https://en.wikipedia.org/wiki/Flash_Video) - Extension Not Found
- [`it`](https://wiki.openmpt.org/Manual:_Module_formats#The_Impulse_Tracker_format_.28.it.29) - Impulse Tracker Module
- [`s3m`](https://wiki.openmpt.org/Manual:_Module_formats#The_ScreamTracker_3_format_.28.s3m.29) - ScreamTracker 3 Module
- [`xm`](https://wiki.openmpt.org/Manual:_Module_formats#The_FastTracker_2_format_.28.xm.29) - Fasttracker 2 Extended Module

#### Font

- [`ttf`](https://en.wikipedia.org/wiki/TrueType) - TrueType Font
- [`otf`](https://en.wikipedia.org/wiki/OpenType) - OpenType Font
- [`woff`](https://en.wikipedia.org/wiki/Web_Open_Font_Format) - Web Open Font Format File
- [`woff2`](https://en.wikipedia.org/wiki/Web_Open_Font_Format) - Web Open Font Format 2.0 File
- [`eot`](https://en.wikipedia.org/wiki/Embedded_OpenType) - Embedded OpenType Font

#### Archive

- [`zip`](https://en.wikipedia.org/wiki/Zip_(file_format)) - Zipped File
- [`tar`](https://en.wikipedia.org/wiki/Tar_(computing)#File_format) - Consolidated Unix File Archive
- [`rar`](https://en.wikipedia.org/wiki/RAR_(file_format)) - WinRAR Compressed Archive
- [`gz`](https://en.wikipedia.org/wiki/Gzip) - Gnu Zipped Archive
- [`bz2`](https://en.wikipedia.org/wiki/Bzip2) - Bzip2 Compressed File
- [`7z`](https://en.wikipedia.org/wiki/7z) - 7-Zip Compressed File
- [`xz`](https://en.wikipedia.org/wiki/Xz) - XZ Compressed Archive
- [`ar`](https://en.wikipedia.org/wiki/Ar_(Unix)) - Midtown Madness Data File
- [`Z`](https://fileinfo.com/extension/z) - Unix Compressed File
- [`lz`](https://en.wikipedia.org/wiki/Lzip) - Lzip Compressed File
- [`cfb`](https://en.wikipedia.org/wiki/Compound_File_Binary_Format) - Compound Binary File
- [`cab`](https://en.wikipedia.org/wiki/Cabinet_(file_format)) - Windows Cabinet File
- [`lzh`](https://en.wikipedia.org/wiki/LHA_(file_format)) - LZH Compressed File

#### Application

- [`indd`](https://en.wikipedia.org/wiki/Adobe_InDesign#File_format) - Adobe InDesign Document
- [`skp`](https://en.wikipedia.org/wiki/SketchUp) - SketchUp Document
- [`blend`](https://wiki.blender.org/index.php/Dev:Source/Architecture/File_Format) - Blender 3D Data File
- [`ics`](https://en.wikipedia.org/wiki/ICalendar#Data_format) - Calendar File

#### Executable

- [`exe`](https://en.wikipedia.org/wiki/.exe) - Windows Executable File
- [`rpm`](https://fileinfo.com/extension/rpm) - Red Hat Package Manager File
- [`xpi`](https://en.wikipedia.org/wiki/XPInstall) - Cross-platform Installer Package
- [`msi`](https://en.wikipedia.org/wiki/Windows_Installer) - Windows Installer Package
- [`deb`](https://en.wikipedia.org/wiki/Deb_(file_format)) - Debian Software Package

#### Other

- [`ogx`](https://en.wikipedia.org/wiki/Ogg) - Ogg Vorbis Multiplexed Media File
- [`swf`](https://en.wikipedia.org/wiki/SWF) - Shockwave Flash Movie
- [`sqlite`](https://www.sqlite.org/fileformat2.html) - SQLite Database File
- [`nes`](https://fileinfo.com/extension/nes) - Nintendo (NES) ROM File
- [`crx`](https://developer.chrome.com/extensions/crx) - Chrome Extension
- [`mxf`](https://en.wikipedia.org/wiki/Material_Exchange_Format) - Material Exchange Format File
- [`wasm`](https://en.wikipedia.org/wiki/WebAssembly) - WebAssembly Binary File
- [`xml`](https://en.wikipedia.org/wiki/XML) - XML File
- [`glb`](https://github.com/KhronosGroup/glTF) - STK Globe File
- [`pcap`](https://wiki.wireshark.org/Development/LibpcapFileFormat) - Packet Capture Data
- [`lnk`](https://en.wikipedia.org/wiki/Shortcut_%28computing%29#Microsoft_Windows) - Windows Shortcut
- [`alias`](https://en.wikipedia.org/wiki/Alias_%28Mac_OS%29) - macOS Alias
- [`mie`](https://en.wikipedia.org/wiki/Sidecar_file) - Meta Information Encapsulation
- [`shp`](https://en.wikipedia.org/wiki/Shapefile) - Shapes File
- [`arrow`](https://arrow.apache.org) - Arrow Columnar Format
- [`ps`](https://en.wikipedia.org/wiki/Postscript) - PostScript File
- [`eps`](https://en.wikipedia.org/wiki/Encapsulated_PostScript) - Encapsulated PostScript File
- [`pgp`](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) - PGP Security Key
- [`stl`](https://en.wikipedia.org/wiki/STL_(file_format)) - Stereolithography File

## Contributing

### Benchmark

```elixir
$ mix benchmark
```

### Adding New File Type

Most files can be detected with a single binary pattern match. To contribute support for new file type:

1. Find an example file. Please make sure you have the rights to use this file.
2. Register the fixture in `test/file_type/integration_test.exs`.
3. Write some code to detect the file's type in `lib/file_type/magic.ex`.
4. Update the `README` to include a mention of your new file format.
5. Send a pull request!

Please note that this library is _not_ intended to detect text-based file formats like CSV, JSON, etc.

## Prior Art

- [file/file](https://github.com/file/file) - The canonical file-type detection library.
- [sindresorhus/file-type](https://github.com/sindresorhus/file-type) - This library is mostly just a port
  of that library.
- [minad/mimemagic](https://github.com/minad/mimemagic) - A popular Ruby library for doing the same thing.
