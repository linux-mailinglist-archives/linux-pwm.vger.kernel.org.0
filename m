Return-Path: <linux-pwm+bounces-9259-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zvmYCJp0ImqIXgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9259-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Jun 2026 09:02:50 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF532645BD0
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Jun 2026 09:02:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=JdHrpnDO;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=eYEFdiXU;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9259-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9259-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B21CF3031B6A
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2026 07:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC1A44D001;
	Fri,  5 Jun 2026 07:01:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D2137DE90;
	Fri,  5 Jun 2026 07:01:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642874; cv=none; b=M9mR4EU//e6Y2Pn9nKMppI6dQ4qCZwUnsV4S9u7MNpzSQYIMgsRGzDF6hezUTAL4LEry+f3JSGQ9DdSAp91AHFsakn9ztZjGvaghT/Y9iX7f8wOd9PymO1JDCfKl4MHysiniXoerrPOitIXcSaP0fOg7xkxeAXuHDjBuROYXvJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642874; c=relaxed/simple;
	bh=60xrDe66k4ro+KvVbaFJv2mj9P8kpFvqUKywbpSaqwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CfR/2rcHDALFb9cKk00kr9rjgGeBYSt+CCztkh6gDzZr5rLxhA0A3iJNZ/l1wC/8TV1HeZAz8G5T24SqUPXdjtlVVU3Y46OgvzrMVZvVomEUWfJwyTA3MsSUZlnP+rpuvUgFsQH/1zVv02abscmdnoyvWW7sAbtgJE3zUsf+B90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JdHrpnDO; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eYEFdiXU; arc=none smtp.client-ip=80.241.56.152
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gWsm66mFWz9vJQ;
	Fri,  5 Jun 2026 09:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780642871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5AisOK8s0MrDK37/TSGMnTNdk0xSn+SbMsbMUZ0nmfk=;
	b=JdHrpnDOYCj2thOK1j2uixDXieb+46nyuy9pggdoRq9ZmunnyGBU4yK4sQwIvzHXYpxMnU
	/jYA2ihhzuwJR9d2mhWdVOLRuYmfOCCBucoYXa5khSwDTK+GWNoeh0MkpJ9fqpdWLhGkqz
	ZjKRFTqNSHSseMskqKqmsS5e4nOgpKQue4rjiDG0kenW0Q2qx5m2SDCnaZQMXNP+JpXFlD
	GroEL7ugJNhbViNlNupCZyOUJqoMKXpnR91GYZyNUeddBAVFquBt38bgBWQivA4XRijC5r
	DaPoQHdXAqL3rJzQuazzo4JzVDQYihRXzuFmrtX08+gP0eKnMpjEbg7d9bn5WQ==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780642869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5AisOK8s0MrDK37/TSGMnTNdk0xSn+SbMsbMUZ0nmfk=;
	b=eYEFdiXUTttRaoD+Afyd77elgOXcd3PbYltjw5qY1wPSxqjrh0bAcBU4fi8ViG/wGiFoLL
	WLB95UAcV9UXQr7AmrW3OmfvHzbLVw2IzxSDelnbt4EIMddcPPNU7v+oM4+AxEgVEKdmUv
	AEhf0qkm0ASOCl0fsmfyH4ztqA5UDc47pAFHR8iZzNTLgJPGNcvKjvVX8U42QESQnIX6Iz
	BdcWageqTOo3PEwTcK9ysLezZjHQ4P2EgUWjUi8i8ivnHWGrQDYtnuP3Xr3q77hb+bcIU7
	ITtyQF7JJNn5kCWc4ZYqpXBIP8CbKST5L8+nkNQtsSCOWgX40kpsjR5H2+PPMQ==
Date: Fri, 05 Jun 2026 09:00:00 +0200
Subject: [PATCH v2 2/2] pwm: th1520: Lock clock rate with
 clk_rate_exclusive_get
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rate-exclusive-get-th1520-v2-2-695640bf7249@mailbox.org>
References: <20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org>
In-Reply-To: <20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780642818; l=1573;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=60xrDe66k4ro+KvVbaFJv2mj9P8kpFvqUKywbpSaqwI=;
 b=WGnFX7PcxbBDEWUXjmEwNTBR0kSfl2DufCpeg/+PtLA111qvEc4g/HvbvGFUtb8xe+w8VJkIJ
 ajVQyrtia3FCoSl7ss/PX3cylicvjwS9bby/KwyEGzgtYLN+c49u4L1
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: 0b9247bacab9cefd338
X-MBO-RS-META: 3b51q85kj4buq3xszfzwttb54czpc51w
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:mhi@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9259-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,redhat.com,samsung.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhi@mailbox.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailbox.org:mid,mailbox.org:dkim,mailbox.org:from_mime,mailbox.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF532645BD0

The driver derives period and duty cycle from the clock rate read at
probe, so a later rate change would silently miscompute waveforms.
Switch to the new ExclusiveClk wrapper to hold the rate for the lifetime
of the driver data and drop the corresponding TODO.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 drivers/pwm/pwm_th1520.rs | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index ddd44a5ce497..19e8621bc52c 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -22,7 +22,7 @@
 
 use core::ops::Deref;
 use kernel::{
-    clk::Clk,
+    clk::{Clk, ExclusiveClk},
     device::{Bound, Core, Device},
     devres,
     io::{
@@ -93,7 +93,7 @@ struct Th1520WfHw {
 struct Th1520PwmDriverData {
     #[pin]
     iomem: devres::Devres<IoMem<TH1520_PWM_REG_SIZE>>,
-    clk: Clk,
+    clk: ExclusiveClk,
 }
 
 impl pwm::PwmOps for Th1520PwmDriverData {
@@ -328,10 +328,8 @@ fn probe(
         let clk = Clk::get(dev, None)?;
 
         clk.prepare_enable()?;
+        let clk = clk.rate_exclusive_get()?;
 
-        // TODO: Get exclusive ownership of the clock to prevent rate changes.
-        // The Rust equivalent of `clk_rate_exclusive_get()` is not yet available.
-        // This should be updated once it is implemented.
         let rate_hz = clk.rate().as_hz();
         if rate_hz == 0 {
             dev_err!(dev, "Clock rate is zero\n");

-- 
2.51.2


