class Backupninja < Formula
  desc "Backup automation tool"
  homepage "https://0xacab.org/liberate/backupninja"
  url "https://0xacab.org/liberate/backupninja/-/archive/backupninja_upstream/1.2.2/backupninja-backupninja_upstream-1.2.2.tar.gz"
  sha256 "93ddc72f085d46145b289d35dac1d72e998c15bec1833db78e474b53c9768774"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(/^backupninja[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  no_autobump! because: :requires_manual_review

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c4c827a9411ff2c3dc6d7863d3d017d8a1a454aa4e86962ddb466cddccda773d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c4c827a9411ff2c3dc6d7863d3d017d8a1a454aa4e86962ddb466cddccda773d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c4c827a9411ff2c3dc6d7863d3d017d8a1a454aa4e86962ddb466cddccda773d"
    sha256 cellar: :any_skip_relocation, sonoma:        "e3da135ac62d1c231f98fecf22e9ebfe6b77cfb562568385560b4ee68d0cb060"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cdd11eabe08b52051efa9d4f5f0b32d85c08fb9a473ca54c021881144d0f212f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cdd11eabe08b52051efa9d4f5f0b32d85c08fb9a473ca54c021881144d0f212f"
  end

  depends_on "dialog"

  on_macos do
    depends_on "bash"
  end

  def install
    args = %W[
      --disable-silent-rules
      --sysconfdir=#{etc}
      --localstatedir=#{var}
    ]
    args << "BASH=#{Formula["bash"].opt_bin}/bash" if OS.mac?

    system "./configure", *args, *std_configure_args
    system "make", "install"
    (var/"log").mkpath
  end

  test do
    assert_match "root", shell_output("#{sbin}/backupninja -h", 3)
  end
end
