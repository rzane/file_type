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

- [`docx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`pptx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`xlsx`](https://en.wikipedia.org/wiki/Office_Open_XML)
- [`doc`](https://en.wikipedia.org/wiki/Compound_File_Binary_Format)
- [`ppt`](https://en.wikipedia.org/wiki/Compound_File_Binary_Format)
- [`xls`](https://en.wikipedia.org/wiki/Compound_File_Binary_Format)
- [`pdf`](https://en.wikipedia.org/wiki/Portable_Document_Format)
- [`epub`](https://en.wikipedia.org/wiki/EPUB)
- [`mobi`](https://en.wikipedia.org/wiki/Mobipocket)
- [`odt`](https://en.wikipedia.org/wiki/OpenDocument)
- [`ods`](https://en.wikipedia.org/wiki/OpenDocument)
- [`odp`](https://en.wikipedia.org/wiki/OpenDocument)
- [`rtf`](https://en.wikipedia.org/wiki/Rich_Text_Format)

#### Image

- [`jpg`](https://en.wikipedia.org/wiki/JPEG)
- [`png`](https://en.wikipedia.org/wiki/Portable_Network_Graphics)
- [`apng`](https://en.wikipedia.org/wiki/APNG) - Animated Portable Network Graphics
- [`gif`](https://en.wikipedia.org/wiki/GIF)
- [`webp`](https://en.wikipedia.org/wiki/WebP)
- [`flif`](https://en.wikipedia.org/wiki/Free_Lossless_Image_Format)
- [`cr2`](https://fileinfo.com/extension/cr2) - Canon Raw image file (v2)
- [`cr3`](https://fileinfo.com/extension/cr3) - Canon Raw image file (v3)
- [`orf`](https://en.wikipedia.org/wiki/ORF_format) - Olympus Raw image file
- [`arw`](https://en.wikipedia.org/wiki/Raw_image_format#ARW) - Sony Alpha Raw image file
- [`dng`](https://en.wikipedia.org/wiki/Digital_Negative) - Adobe Digital Negative image file
- [`nef`](https://www.nikonusa.com/en/learn-and-explore/a/products-and-innovation/nikon-electronic-format-nef.html) - Nikon Electronic Format image file
- [`rw2`](https://en.wikipedia.org/wiki/Raw_image_format) - Panasonic RAW image file
- [`raf`](https://en.wikipedia.org/wiki/Raw_image_format) - Fujifilm RAW image file
- [`tif`](https://en.wikipedia.org/wiki/Tagged_Image_File_Format)
- [`bmp`](https://en.wikipedia.org/wiki/BMP_file_format)
- [`icns`](https://en.wikipedia.org/wiki/Apple_Icon_Image_format)
- [`jxr`](https://en.wikipedia.org/wiki/JPEG_XR)
- [`psd`](https://en.wikipedia.org/wiki/Adobe_Photoshop#File_format)
- [`dmg`](https://en.wikipedia.org/wiki/Apple_Disk_Image)
- [`ico`](https://en.wikipedia.org/wiki/ICO_(file_format))
- [`bpg`](https://bellard.org/bpg/)
- [`jp2`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000
- [`jpm`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000
- [`jpx`](https://en.wikipedia.org/wiki/JPEG_2000) - JPEG 2000
- [`heic`](https://nokiatech.github.io/heif/technical.html)
- [`cur`](https://en.wikipedia.org/wiki/ICO_(file_format))
- [`ktx`](https://www.khronos.org/opengles/sdk/tools/KTX/file_format_spec/)
- [`avif`](https://en.wikipedia.org/wiki/AV1#AV1_Image_File_Format_(AVIF)) - AV1 Image File Format
- [`dcm`](https://en.wikipedia.org/wiki/DICOM#Data_format) - DICOM Image File

#### Video

- [`mp4`](https://en.wikipedia.org/wiki/MPEG-4_Part_14#Filename_extensions)
- [`mkv`](https://en.wikipedia.org/wiki/Matroska)
- [`webm`](https://en.wikipedia.org/wiki/WebM)
- [`mov`](https://en.wikipedia.org/wiki/QuickTime_File_Format)
- [`avi`](https://en.wikipedia.org/wiki/Audio_Video_Interleave)
- [`mpg`](https://en.wikipedia.org/wiki/MPEG-1)
- [`ogv`](https://en.wikipedia.org/wiki/Ogg)
- [`ogm`](https://en.wikipedia.org/wiki/Ogg)
- [`flv`](https://en.wikipedia.org/wiki/Flash_Video)
- [`mts`](https://en.wikipedia.org/wiki/.m2ts)
- [`mj2`](https://en.wikipedia.org/wiki/Motion_JPEG_2000) - Motion JPEG 2000
- [`3gp`](https://en.wikipedia.org/wiki/3GP_and_3G2#3GP) - Multimedia container format defined by the Third Generation Partnership Project (3GPP) for 3G UMTS multimedia services
- [`3g2`](https://en.wikipedia.org/wiki/3GP_and_3G2#3G2) - Multimedia container format defined by the 3GPP2 for 3G CDMA2000 multimedia services
- [`m4v`](https://en.wikipedia.org/wiki/M4V) - MPEG-4 Visual bitstreams
- [`m4p`](https://en.wikipedia.org/wiki/MPEG-4_Part_14#Filename_extensions) - MPEG-4 files with audio streams encrypted by FairPlay Digital Rights Management as were sold through the iTunes Store
- [`f4v`](https://en.wikipedia.org/wiki/Flash_Video) - ISO base media file format used by Adobe Flash Player
- [`f4p`](https://en.wikipedia.org/wiki/Flash_Video) - ISO base media file format protected by Adobe Access DRM used by Adobe Flash Player

#### Audio

- [`mp1`](https://en.wikipedia.org/wiki/MPEG-1_Audio_Layer_I) - MPEG-1 Audio Layer I
- [`mp2`](https://en.wikipedia.org/wiki/MPEG-1_Audio_Layer_II)
- [`mp3`](https://en.wikipedia.org/wiki/MP3)
- [`aac`](https://en.wikipedia.org/wiki/Advanced_Audio_Coding) - Advanced Audio Coding
- [`ogg`](https://en.wikipedia.org/wiki/Ogg)
- [`oga`](https://en.wikipedia.org/wiki/Ogg)
- [`spx`](https://en.wikipedia.org/wiki/Ogg)
- [`opus`](https://en.wikipedia.org/wiki/Opus_(audio_format))
- [`flac`](https://en.wikipedia.org/wiki/FLAC)
- [`wav`](https://en.wikipedia.org/wiki/WAV)
- [`mid`](https://en.wikipedia.org/wiki/MIDI)
- [`qcp`](https://en.wikipedia.org/wiki/QCP)
- [`amr`](https://en.wikipedia.org/wiki/Adaptive_Multi-Rate_audio_codec)
- [`aif`](https://en.wikipedia.org/wiki/Audio_Interchange_File_Format)
- [`ape`](https://en.wikipedia.org/wiki/Monkey%27s_Audio) - Monkey's Audio
- [`wv`](https://en.wikipedia.org/wiki/WavPack) - WavPack
- [`mpc`](https://en.wikipedia.org/wiki/Musepack) - Musepack (SV7 & SV8)
- [`dsf`](https://dsd-guide.com/sites/default/files/white-papers/DSFFileFormatSpec_E.pdf) - Sony DSD Stream File (DSF)
- [`voc`](https://wiki.multimedia.cx/index.php/Creative_Voice) - Creative Voice File
- [`ac3`](https://www.atsc.org/standard/a522012-digital-audio-compression-ac-3-e-ac-3-standard-12172012/) - ATSC A/52 Audio File
- [`m4a`](https://en.wikipedia.org/wiki/M4A) - Audio-only MPEG-4 files
- [`m4b`](https://en.wikipedia.org/wiki/M4B) - Audiobook and podcast MPEG-4 files, which also contain metadata including chapter markers, images, and hyperlinks
- [`f4a`](https://en.wikipedia.org/wiki/Flash_Video) - Audio-only ISO base media file format used by Adobe Flash Player
- [`f4b`](https://en.wikipedia.org/wiki/Flash_Video) - Audiobook and podcast ISO base media file format used by Adobe Flash Player
- [`it`](https://wiki.openmpt.org/Manual:_Module_formats#The_Impulse_Tracker_format_.28.it.29) - Audio module format: Impulse Tracker
- [`s3m`](https://wiki.openmpt.org/Manual:_Module_formats#The_ScreamTracker_3_format_.28.s3m.29) - Audio module format: ScreamTracker 3
- [`xm`](https://wiki.openmpt.org/Manual:_Module_formats#The_FastTracker_2_format_.28.xm.29) - Audio module format: FastTracker 2

#### Font

- [`ttf`](https://en.wikipedia.org/wiki/TrueType)
- [`otf`](https://en.wikipedia.org/wiki/OpenType)
- [`woff`](https://en.wikipedia.org/wiki/Web_Open_Font_Format)
- [`woff2`](https://en.wikipedia.org/wiki/Web_Open_Font_Format)
- [`eot`](https://en.wikipedia.org/wiki/Embedded_OpenType)

#### Archive

- [`zip`](https://en.wikipedia.org/wiki/Zip_(file_format))
- [`tar`](https://en.wikipedia.org/wiki/Tar_(computing)#File_format)
- [`rar`](https://en.wikipedia.org/wiki/RAR_(file_format))
- [`gz`](https://en.wikipedia.org/wiki/Gzip)
- [`bz2`](https://en.wikipedia.org/wiki/Bzip2)
- [`7z`](https://en.wikipedia.org/wiki/7z)
- [`xz`](https://en.wikipedia.org/wiki/Xz)
- [`ar`](https://en.wikipedia.org/wiki/Ar_(Unix))
- [`Z`](https://fileinfo.com/extension/z)
- [`lz`](https://en.wikipedia.org/wiki/Lzip)
- [`cfb`](https://en.wikipedia.org/wiki/Compound_File_Binary_Format)
- [`cab`](https://en.wikipedia.org/wiki/Cabinet_(file_format))
- [`lzh`](https://en.wikipedia.org/wiki/LHA_(file_format)) - LZH archive

#### Application

- [`indd`](https://en.wikipedia.org/wiki/Adobe_InDesign#File_format)
- [`skp`](https://en.wikipedia.org/wiki/SketchUp) - SketchUp
- [`blend`](https://wiki.blender.org/index.php/Dev:Source/Architecture/File_Format)
- [`ics`](https://en.wikipedia.org/wiki/ICalendar#Data_format) - iCalendar

#### Executable

- [`exe`](https://en.wikipedia.org/wiki/.exe)
- [`rpm`](https://fileinfo.com/extension/rpm)
- [`xpi`](https://en.wikipedia.org/wiki/XPInstall)
- [`msi`](https://en.wikipedia.org/wiki/Windows_Installer)
- [`deb`](https://en.wikipedia.org/wiki/Deb_(file_format))

#### Other

- [`ogx`](https://en.wikipedia.org/wiki/Ogg)
- [`swf`](https://en.wikipedia.org/wiki/SWF)
- [`sqlite`](https://www.sqlite.org/fileformat2.html)
- [`nes`](https://fileinfo.com/extension/nes)
- [`crx`](https://developer.chrome.com/extensions/crx)
- [`mxf`](https://en.wikipedia.org/wiki/Material_Exchange_Format)
- [`wasm`](https://en.wikipedia.org/wiki/WebAssembly)
- [`xml`](https://en.wikipedia.org/wiki/XML)
- [`glb`](https://github.com/KhronosGroup/glTF) - GL Transmission Format
- [`pcap`](https://wiki.wireshark.org/Development/LibpcapFileFormat) - Libpcap File Format
- [`lnk`](https://en.wikipedia.org/wiki/Shortcut_%28computing%29#Microsoft_Windows) - Microsoft Windows file shortcut
- [`alias`](https://en.wikipedia.org/wiki/Alias_%28Mac_OS%29) - macOS Alias file
- [`mie`](https://en.wikipedia.org/wiki/Sidecar_file) - Dedicated meta information format which supports storage of binary as well as textual meta information
- [`shp`](https://en.wikipedia.org/wiki/Shapefile) - Geospatial vector data format
- [`arrow`](https://arrow.apache.org) - Columnar format for tables of data
- [`ps`](https://en.wikipedia.org/wiki/Postscript)
- [`eps`](https://en.wikipedia.org/wiki/Encapsulated_PostScript) - Encapsulated PostScript
- [`pgp`](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) - Pretty Good Privacy
- [`stl`](https://en.wikipedia.org/wiki/STL_(file_format)) - Standard Tesselated Geometry File Format (ASCII only)

## Contributing

Most files can be detected with a single binary pattern match. To contribute support for new file type:

1. Find an example file. Please make sure you have the rights to use this file.
2. Register the fixture in `test/file_type_test.exs`.
3. Write some code to detect the file's type in `lib/file_type/magic.ex`.
4. Update the `README` to include a mention of your new file format.
5. Send a pull request!

Please note that this library is _not_ intended to detect text-based file formats like CSV, JSON, etc.

## Prior Art

- [file/file](https://github.com/file/file) - The canonical file-type detection library.
- [sindresorhus/file-type](https://github.com/sindresorhus/file-type) - This library is mostly just a port
  of that library.
- [minad/mimemagic](https://github.com/minad/mimemagic) - A popular Ruby library for doing the same thing.
