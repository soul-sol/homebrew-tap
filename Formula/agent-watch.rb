class AgentWatch < Formula
  desc "Tell DONE, FAILED and STALL apart when a coding agent exits"
  homepage "https://github.com/soul-sol/agent-watch"
  url "https://github.com/soul-sol/agent-watch/archive/refs/tags/v1.tar.gz"
  sha256 "ec7d89b85599a1daeb115a5c212e484077b2c811f70f5fbebeb5374941dcb86c"
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
    # A finished run with a zero exit code and a completion marker must be DONE.
    assert_match "DONE", shell_output("#{bin}/agent-watch w 999999 #{log} codex #{exitf}")

    stall = testpath/"stall.log"
    stall.write "work\nplease approve this plan\n"
    # No marker means the process stopped without finishing; the gate must not pass it.
    assert_match "STALL", shell_output("#{bin}/agent-watch w 999999 #{stall} codex #{exitf}", 2)
  end
end
