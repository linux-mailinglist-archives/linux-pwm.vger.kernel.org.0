Return-Path: <linux-pwm+bounces-7508-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C06AC149A8
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 13:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3F64628E8
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 12:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEFC32D437;
	Tue, 28 Oct 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ePtLi+yZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951D16DC28
	for <linux-pwm@vger.kernel.org>; Tue, 28 Oct 2025 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654200; cv=none; b=NmOfaGA2zIp88g2hcUZlqg6oxTcoO4bvWgMT0u6JWWcFwXqfNXqf4P7Dlm9ROzzlb/uSdiJs9Xv6F0Ttxi3l78Mvs5myidMJpsIiiSoE8rZLktKiXU25gePIN1scNlYAPS2gACNrWPcXkC1UDhb3IwZW35OCvAh8YXNm/KK+xqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654200; c=relaxed/simple;
	bh=8Xqwyli/NjSoeTHuFfY0OyFe14DIb0UjzfhJgHde4Tk=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type:
	 References; b=guofzfeYs9NfT65leXyvSov37GB5Kl12HhvVqpxT0+WE6KfYKP7oE5eVvzhnvogZ80Y3Oy7RmTQajYJfnv/3s/D7JH8eRYRFnfRIJzSkudLUzISErxx4ZsAwfmga4G/uaTXKCcVaSPGuTfYFsFKsBrSvJ00Kd8Glai2/W18kTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ePtLi+yZ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251028122316euoutp02d949a8446e817abc92cd64009519b9ba~ypyhehZxe0166901669euoutp02w
	for <linux-pwm@vger.kernel.org>; Tue, 28 Oct 2025 12:23:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251028122316euoutp02d949a8446e817abc92cd64009519b9ba~ypyhehZxe0166901669euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761654196;
	bh=Jf/xisGgKKrfoTZqLlk9KCwMEgqafBF+UVNf9SDfM/0=;
	h=From:Subject:Date:To:Cc:References:From;
	b=ePtLi+yZBa45Z6llcrrDe1LA4v3KT3cBAih1OMsFuudiNnlhC0UF2y823h09oCQeE
	 qq0adg0b8qf79v1m2JSS4qOLA2/3CjrR9msei/CwIXYnAtHANgym+qgnS+XPeXSfey
	 rThellpIR8YWq5p1NXv9ufRZHqv/uZkqwQlSSaZY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5~ypyg5Mq3g0079300793eucas1p1o;
	Tue, 28 Oct 2025 12:23:15 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251028122314eusmtip2b41c21bf57cd2df99166eb249c16d3ee~ypygBMKKr0665606656eusmtip24;
	Tue, 28 Oct 2025 12:23:14 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH 0/4] Introduce import_ns support for Rust
Date: Tue, 28 Oct 2025 13:22:31 +0100
Message-Id: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIe1AGkC/yWN2w6DIAxAf8XwvBoh6pxP+4/FLAjVkQVw1Fti/
	PehvvW0J6cbIwwGidXJxgLOhox3EfgtYeojXY9gdGQmMlHwTFQwLPbdmRUJlJIP3YrynhcVi/4
	Q8DxE/dVcHPA3xeR4LZlFInkm6+QK8hLCRCM4XMcjDYsPX+N66KSDzgcgdPrgOZoZyEJ3Is8KL
	Vr9JGlpcn2qvD3et5IQ4mzNWCdzmfIKguKs2fc/Gj/itOUAAAA=
X-Change-ID: 20251028-pwm_fixes-cca9db267458
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,  Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,  Danilo Krummrich
	<dakr@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>,  Drew
	Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5
X-EPHeader: CA
X-CMS-RootMailID: 20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5
References: <CGME20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5@eucas1p1.samsung.com>

This series addresses build warnings reported by `modpost` for the Rust
PWM driver (`pwm_th1520`) in linux-next:

WARNING: modpost: module pwm_th1520 uses symbol pwmchip_release from
namespace PWM, but does not import it.

These warnings occur because Rust modules, like C modules, need to
declare their dependencies on C symbols exported to specific namespaces
(using `EXPORT_SYMBOL_NS` in C). This is done by embedding
"import_ns=<NAMESPACE>" tags into the module's `.modinfo` section, which
`modpost` verifies.  The C macro `MODULE_IMPORT_NS()` handles this, but
the Rust `module!` macro lacked equivalent functionality.

This series introduces the necessary support:

Patch 1 extends the core `module!` macro in `rust/macros/module.rs`
to parse an optional `imports_ns: [...]` field and generate the required
`import_ns` tags in the `.modinfo` section.

Patch 2 adds a convenience macro `module_pwm_platform_driver!` to
`rust/kernel/pwm.rs`. This macro wraps the standard
`module_platform_driver!` and automatically adds `imports_ns: ["PWM"]`,
simplifying module declaration for PWM driver authors.

Patch 3 updates the `pwm_th1520` driver to use the new helper macro,
fixing the build warnings.

Patch 4 includes a minor clippy style fix for the `pwm_th1520` driver.

Thanks to Stephen Rothwell for reporting the build warnings.

---
Michal Wilczynski (4):
      rust: macros: Add support for 'imports_ns' to module!
      rust: pwm: Add module_pwm_platform_driver! macro
      pwm: th1520: Use module_pwm_platform_driver! macro
      pwm: th1520: Fix clippy warning for redundant struct field init

 drivers/pwm/pwm_th1520.rs |  4 ++--
 rust/kernel/pwm.rs        | 23 +++++++++++++++++++++++
 rust/macros/module.rs     |  8 ++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)
---
base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
change-id: 20251028-pwm_fixes-cca9db267458
prerequisite-message-id: 20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com
prerequisite-patch-id: bddf445f74431c647c134eabb3eb029374455a2e
prerequisite-patch-id: 6fbf1d04b8ca1c72362d7f3a4e420be8f95a44a8
prerequisite-patch-id: d4adae5b56cd13089bfa070bc4bd3bbc6f50b097
prerequisite-patch-id: c1a631eb7a5d8f1d8dfdae847e8b32e8d5ea95d8
prerequisite-patch-id: 6c2a0d316d9d0aa99346cb12afe4b9dc5ac217db
prerequisite-patch-id: 4a05412207606f8df51db0068c4f57785b02a271
prerequisite-patch-id: e0a0d54562e883b07cbe9c5b3721687de5b4ea55

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


