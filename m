Return-Path: <linux-pwm+bounces-9160-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XtD+NK3WFWoSdAcAu9opvQ
	(envelope-from <linux-pwm+bounces-9160-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 19:21:49 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCEB5DA8C7
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 19:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F14CD307FC00
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5121F403EAB;
	Tue, 26 May 2026 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHPrMY1V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E440314E;
	Tue, 26 May 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815102; cv=none; b=fmwWKbLNvjeYz+8lf083k10M9dz3qy3tDBjlAbVe3FrA7juC77JedJWmFE7evML9ci82FU8EK4KgvW/TZij/bk0ISx/kkgkZWvqwIDip9NzI4ZGIy8/uAfeiNqwCa7iTlhjgEfczJmGQG/sp3yLzc/yN1fEbbJDhcEngTC/trJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815102; c=relaxed/simple;
	bh=rw34vtqykP3gLbod3ZqxjK1eri8oVxXKFkcTw3m/x34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ePTSencndcJRDI7bVs8E1o1FaxL6/gZnDakocebySzWR8d1NTIK1rmIb5opcHN6dMOT71I0O1/oY6ipDHcBfWdmHm5sekAhONeGxgLZE6WGMzEXmCzyKLc9zaiv4+hmjmnIoLq3ipzqJ+JcAWj3VkLVR10/AGfsoagc4kitIZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHPrMY1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD445C2BCB3;
	Tue, 26 May 2026 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779815101;
	bh=rw34vtqykP3gLbod3ZqxjK1eri8oVxXKFkcTw3m/x34=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=sHPrMY1VAxp5wJH1r2VQ9KfEVvnLNZZJjtnYVPdLtWtjVilALRPQ3W6eB3PQdorvp
	 GD9iTGMQFxVf11CHTaYY0rJEuzpIJpNe9ko0s2SxVi+R4gCTc8gEglAAp35hzmuPuj
	 jtMaQvWD1T/HD/gCZEGp/YNMlyu1DSt0rx04BztFoWwgdAhrG4CxKa8ugNYUMfanOl
	 E+CIey60UjnUfpa2L+aKgdyNfmTEWKSk2zoZSr4UbE5V7ustZiVAVV1JOK/NkWsesm
	 E8YQrkGLqWILBTd1XDfx2M+s/OSRWdtuizsX1Woz/6pXjhHBclgVkX3VdgyLn7fRxB
	 NoEQQTm4bvUvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB624CD5BD1;
	Tue, 26 May 2026 17:05:01 +0000 (UTC)
From: Maurice Hieronymus via B4 Relay <devnull+mhi.mailbox.org@kernel.org>
Subject: [PATCH 0/2] rust: clk: Add ExclusiveClk and use it in pwm-th1520
Date: Tue, 26 May 2026 19:04:56 +0200
Message-Id: <20260526-rate-exclusive-get-th1520-v1-0-34cf034e1764@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MOwqAMBBF0a3I1A4kQeNnK2IR9KkDopJEEcS9G
 yxPce9DAV4QqM0e8rgkyL4l6DyjYXHbDJYxmYwyVpXGsncRjHtYzyAXeEbkuOjSKK5s4ZqiGaF
 rUOoPj0nu/9317/sBXvSclWsAAAA=
X-Change-ID: 20260526-rate-exclusive-get-th1520-764a949de18e
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779815100; l=764;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=rw34vtqykP3gLbod3ZqxjK1eri8oVxXKFkcTw3m/x34=;
 b=PL6YfDGWIuf8evRDeF2cmn1l3faTN3bvFDtgClsXkELDWCCjTqreu+xhqpuXNB8YWUsdq/qPW
 fD3wuj/fp7dCDdADJUZhO9wLasJfLgNtJQeyXNQzGz2v/GHT2Tv0wQz
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-Endpoint-Received: by B4 Relay for mhi@mailbox.org/20260525 with
 auth_id=790
X-Original-From: Maurice Hieronymus <mhi@mailbox.org>
Reply-To: mhi@mailbox.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9160-lists,linux-pwm=lfdr.de,mhi.mailbox.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,redhat.com,samsung.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[mhi@mailbox.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5FCEB5DA8C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a Rust binding for clk_rate_exclusive_get() / clk_rate_exclusive_put()
and use it in pwm-th1520, which previously carried a TODO noting the
missing binding.

Based on pwm/for-next.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Maurice Hieronymus (2):
      rust: clk: Add ExclusiveClk wrapper for clk_rate_exclusive_get
      pwm: th1520: Lock clock rate with clk_rate_exclusive_get

 drivers/pwm/pwm_th1520.rs |  8 +++---
 rust/kernel/clk.rs        | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 5 deletions(-)
---
base-commit: 0e5e0db3e954b32a410ab4f74a4faac7a0e8889f
change-id: 20260526-rate-exclusive-get-th1520-764a949de18e

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>



