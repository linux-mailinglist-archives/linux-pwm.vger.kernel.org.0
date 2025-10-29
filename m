Return-Path: <linux-pwm+bounces-7531-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 030F6C1CBE7
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 19:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 681614E04D5
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06B33F361;
	Wed, 29 Oct 2025 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiBQPina"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E862FBDF3;
	Wed, 29 Oct 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761998; cv=none; b=urd/HDmYSbFrTPhuOfa6bFhiGwq/bNgcH7q3uhHNG/ds0u0iDW+t6alVgQIr3QKH4fO+RUciDT8dSTJTJAZpInSkjh1WI4Iuc3dlHXuhscBUAxDT2oVTSF3K6Nw+yVa3XsRbsaK/bo8HXA9sgSzhzN6dwIEl4mAhvKgegWR9z/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761998; c=relaxed/simple;
	bh=N96ksOH8Ew4fqM5Q6PU+k0xcS/HzqCdKtC6Q9u3X2NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krAvRy4clzzsVmEUw/2KPbGJYrnhTmL3QXAyyXSOiwXaePjH15SWZ1AdOnMcjSzIfuuOxy379i34uon/ppw3XP8P3IckN4xcDKIkHJmitpMFC66xwZYMnfMqkuOUVUr0LxQjEsVDsj+pldhqaqJ7RoOk2hizmoVNpLr+oUaC6OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiBQPina; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C879C4CEFB;
	Wed, 29 Oct 2025 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761761997;
	bh=N96ksOH8Ew4fqM5Q6PU+k0xcS/HzqCdKtC6Q9u3X2NM=;
	h=From:To:Cc:Subject:Date:From;
	b=MiBQPinaYQ/xa+vyjI9AiELAmHPFPnKSQEsOxxS+zRIWznFHhX0XiH6NEr657+GzQ
	 vXgud8uWntdwnC1ohFZZ245fosmUee61jkVGFl9ZuAz9N8kcYRB5LZIbq6DiTDebiD
	 CErZba3tt/uH3WgkYPM4b+oTmXBbcfIYbYUZIKN8RO99lbFXcmGZ0KR4b8XKSxm57P
	 64Q8g5Nd5nXN6/eoOEphZ6JYTHwL1kOD5UWRItG7mehDN+jzjY2WnK+FrDD2+LptGg
	 3Wq1W9ely9vdXpgrUrY5uMCDyHddsGhkOya9MGiuEPehm5hPvytI5y4MW+nFFH52o/
	 21lreO4LodCfQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] pwm: fix broken intra-doc link
Date: Wed, 29 Oct 2025 19:19:40 +0100
Message-ID: <20251029181940.780629-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`rustdoc` reports a broken intra-doc link:

    error: unresolved link to `Devres::register`
       --> rust/kernel/pwm.rs:722:11
        |
    722 | /// via [`Devres::register`]. This ties the lifetime of the PWM chip registration
        |           ^^^^^^^^^^^^^^^^ no item named `Devres` in scope
        |
        = note: `-D rustdoc::broken-intra-doc-links` implied by `-D warnings`
        = help: to override `-D warnings` add `#[allow(rustdoc::broken_intra_doc_links)]`

Thus fix it.

Fixes: a3d5a2b8da94 ("rust: pwm: Add complete abstraction layer")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
If you usually rebase your tree, please feel free to do so instead. Thanks!

 rust/kernel/pwm.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 79fbb13cd47f..84000192209d 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -714,7 +714,7 @@ unsafe impl<T: PwmOps + Sync> Sync for Chip<T> {}
 /// A resource guard that ensures `pwmchip_remove` is called on drop.
 ///
 /// This struct is intended to be managed by the `devres` framework by transferring its ownership
-/// via [`Devres::register`]. This ties the lifetime of the PWM chip registration
+/// via [`devres::register`]. This ties the lifetime of the PWM chip registration
 /// to the lifetime of the underlying device.
 pub struct Registration<T: PwmOps> {
     chip: ARef<Chip<T>>,

base-commit: 04a698c800c25149f9aa379250e78f737adeb3f1
--
2.51.2

