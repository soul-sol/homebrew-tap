class AgentWatch < Formula
  desc "Check agent exit codes and result bodies; markers are diagnostic"
  homepage "https://github.com/soul-sol/agent-watch"
  url "https://github.com/soul-sol/agent-watch/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "fdc8af8b82a463036170a8bb6f4ea2d0832f547e7a2395263a70ecdeea074688"
  license "MIT"

  def install
    bin.install "worker_watch.sh"     => "agent-watch"
    bin.install "worker_launch.sh"    => "agent-launch"
    bin.install "worker_preflight.sh" => "agent-preflight"
    doc.install "README.md"
  end

  test do
    log  = testpath/"done.log"
    exitf = testpath/"done.exit"
    log.write "work\ntokens used\n1,234\n"
    exitf.write "0\n"
    # A zero exit code returns a completion candidate; the marker is diagnostic only.
    assert_match "DONE", shell_output("#{bin}/agent-watch w 999999 #{log} codex #{exitf}")

    markerless = testpath/"markerless.log"
    markerless.write "Implemented requested fix; verification passed.\n"
    # A missing marker is not STALL; read the result body before accepting DONE.
    assert_match "DONE", shell_output("#{bin}/agent-watch w 999999 #{markerless} codex #{exitf}")

    # STALL requires unavailable evidence, here a missing exit-code record.
    assert_match "STALL", shell_output("#{bin}/agent-watch w 999999 #{markerless} codex #{testpath}/missing.exit", 2)
  end
end
