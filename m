Return-Path: <linux-pwm+bounces-8150-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLjuGBYonGl1AAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8150-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 11:12:38 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A4D174A13
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 11:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC6573051A81
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5120B361646;
	Mon, 23 Feb 2026 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x9Z6mM9a"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726B360722
	for <linux-pwm@vger.kernel.org>; Mon, 23 Feb 2026 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841318; cv=none; b=NrlkcDK316A66Cw0tchV2zp0GKBughpV0xRVZQaN1u0rHXaM4B0QPyXRAUxWBR+dyUoGIqyrb8nUuSLGeeHbr/HZaPtujao3QgcLQ5B8eIvHWbPOe1bB+PPoTVMf+mNSX0r2Ko2xOTBy3DzHV/ytfCMNoEfcreWlr2qsmY9w2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841318; c=relaxed/simple;
	bh=36uRj/yGgZFq6zKe4ExA/GGUiwSeasAUQSZStEmKulI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UqmqMW69EC/+sFK+1yMeDHz4lrCOMdJqzm3IOvPV5Nd1aGZTgVmitkxanZUkrtQNVgx5+Q9w4Gs1Uet1PX+0tnMtK+u9XQscSn1+5z4TOUwCzFTbPeXAzglUVyd3UHCA2reZ1VK+PlidcTQwoENI1pEAWcfpK5knaMvig/uHimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x9Z6mM9a; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837107e0a9so31777035e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 23 Feb 2026 02:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771841315; x=1772446115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqjAQx12kO7yn9LdoidneoYk/xISJkEpOFtnTwZu1xA=;
        b=x9Z6mM9aUeW6p7rPzDFLrbHskPS1OgEQPZTJU4Gz0DMBwWVYAuwnbvkxfrobD1OCwG
         7XoaFbhR4FUyKfJvovGYgqZbb1TDQgaSSixyxrjnNoWALut6fuVbuQPdo/k9gYZ9AipO
         ptRu/3ovTplJFzv8xqt7V9nnD8chXi+DsUYPn848lFwin9I+sMTHnYIp9QZCxpb2Xx14
         dZg4xv5ZU6sxfL5DUPekaCcefD+vqBivsri52kZk/UJ4ImZQkhZ5KJLOilsz5iLhbAG1
         aF/GMOk++n6EjwCao3I/VZC/w26qoX0BZ8ZEncdHeMLGevBN8Of/okYdea1JHYsK/Fce
         G0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841315; x=1772446115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqjAQx12kO7yn9LdoidneoYk/xISJkEpOFtnTwZu1xA=;
        b=JxSPqMaQ21Juy+qMH0yL+h30FuHnd/mMxGgiSRvbZB899+3TGjNYYkkH8N5tk8YHku
         o8y9HraQptD5NjmYYPib2Srw5K9OD/oH+QZRukOV6+YhclOi5kioHo0FTXbP6OQzSvvC
         9DeQTuC5no1dgjuBHT9NzV3t1taKmWaWJstWaZMhODrODIyKJ8I4H02xutQs225kaQCC
         Qgqu2mdxVsmPjF3u51T12ahAnr6rvzJg0ScfVKDWkj1A9ToW+9ELt7+VkSHuobwFDAuS
         n3AxGWaICv/Ph++o2iVL0rPvm+VYgKVGVzegWul5YoRVzAORmT2AujMCmmrJhn3z+q67
         o2TA==
X-Forwarded-Encrypted: i=1; AJvYcCUxF6tO7ASZQkiabwsha8bujk+qpaQ8IQ78WBvF+mO0eTgchcdcih31XN+V1uJZIlIvGDthP6OvXa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAdPf5Fjz50qvzJ6GKxIwjgL7EtWYm8Jz/MbQM5p3D5+JMBk+E
	j7rl+UaS29L2l30URWADWFqVhsA/bPebetTMPx7vGdPccr0gN81gEYtGvFI/j+ZzU4lRZw/fYre
	TRrhFDHnXjBi0PKNb8w==
X-Received: from wmqb9.prod.google.com ([2002:a05:600c:4e09:b0:483:6f09:9913])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34cb:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-483a95bef2amr119187925e9.10.1771841315177;
 Mon, 23 Feb 2026 02:08:35 -0800 (PST)
Date: Mon, 23 Feb 2026 10:08:25 +0000
In-Reply-To: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=36uRj/yGgZFq6zKe4ExA/GGUiwSeasAUQSZStEmKulI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpnCcgUsqqcMYjdDm7UHv8I5p4UEWxxC0fGy4J5
 el4buZGr6+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaZwnIAAKCRAEWL7uWMY5
 RnnuD/9/liVA8UJG+WSn8bROvceJNTmyceJ6rXLYcVmGqpJOk4jTuFu1rTGNw4NmJZwjyRkr6f3
 nqcjfE/k6I2/OOh5eKr4nunoY0BxzZ2n7VLcRuKU1sBKTcpCFOmLEhsYEC7BWYW8oROD3oXMJAJ
 VxH/5YsIZeZQYjVrRlwqkxLxT8qV0DFd5RJLhUdeaHQpwTf1lRN6PaMSkREkvM40Xamh+21zS+J
 /Wswc5gMzYG/bdjOQmoaunIqrs+Z6VShwf8+lVxCgh/KdXF9TwelJEw12IOpERw881MJNuGLNHW
 2SnNPNWSRArfppwbyMvO+aJsiUvW5YASeJIxzeRzzppHVhDonRCKJZ98t+XrpijkTAM1u03vJJx
 zQWGRbXbhl8VkB913eXVDc1GozBbpqpkPcm+W2UKiqIu8IYW+DgCT0CfDPxeh+57A9oKa3AwTY/
 YBTCYD2KAjkSIK7iWmd0XpCTw+Q/f2Bkrh7krhQ8PcUpi3CTNS9Dkry8ZWuduVf9A4cYQA+dI/g
 QTTtkf9I/u9r30jM37oq4Lp3U1UQj+21ngcbg8SuNWbDd3UuotqbNK7PXZdfFSw0SP3uun00I38
 ADs08uf+SJ2rNSKDWsLURv6SjHm5roDE/3vrVODsntZ10lSlAlopUKQv0b2zGlHBnxxk8ijXqiN u67oZuhxYAK4CgQ==
X-Mailer: b4 0.14.2
Message-ID: <20260223-clk-send-sync-v5-1-181bf2f35652@google.com>
Subject: [PATCH v5 1/3] rust: clk: implement Send and Sync
From: Alice Ryhl <aliceryhl@google.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	"=?utf-8?q?Uwe_Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8150-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,linux.intel.com,kernel.org,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: C9A4D174A13
X-Rspamd-Action: no action

These traits are required for drivers to embed the Clk type in their own
data structures because driver data structures are usually required to
be Send. Since the Clk type is thread-safe, implement the relevant
traits.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/clk.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 4059aff34d096264bc7f3c8bfcb39eb3f42725be..7abbd0767d8cff9f2561d1783a9a1d774a96d1fc 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -128,6 +128,13 @@ mod common_clk {
     #[repr(transparent)]
     pub struct Clk(*mut bindings::clk);
 
+    // SAFETY: It is safe to call `clk_put` on another thread than where `clk_get` was called.
+    unsafe impl Send for Clk {}
+
+    // SAFETY: It is safe to call any combination of the `&self` methods in parallel, as the
+    // methods are synchronized internally.
+    unsafe impl Sync for Clk {}
+
     impl Clk {
         /// Gets [`Clk`] corresponding to a [`Device`] and a connection id.
         ///

-- 
2.53.0.345.g96ddfc5eaa-goog


