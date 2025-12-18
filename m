Return-Path: <linux-pwm+bounces-7812-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30685CCC026
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Dec 2025 14:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B839B30E397D
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Dec 2025 13:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86A1340A72;
	Thu, 18 Dec 2025 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TV8A1nRc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764BF30C37A
	for <linux-pwm@vger.kernel.org>; Thu, 18 Dec 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064477; cv=none; b=J+8V38DaDH3n80L1PZEVR6S1/mJ9m0LUN7zqTrnnh421V1i8beXOTT7VOGnZjZWbUM2oc5KAP2f539ealo0tsUXKhdNL+QY90x0FDFT6mGKde/NEQpEIKcGLhOa4GXWPsFF3QxA8PBxXubNz8OSMxzYLpZZLavnEk3EKq2dqLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064477; c=relaxed/simple;
	bh=hJ1r8AWFe6vjamRRbSdgVoDTTorMAE8/5j325qhqRPo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hVE0bWlcZPAxTTo1UTLB+AnnaEnTRqKwS/C6LF3CgIqiog+Jx7ShczCn4Oue5MaP9vGHPWRDFPod+R0HnT6KkNII9OAaDwu+MgqeSXnvz7x3wsJJROBJzNIaxMzgiRa5dUpHrw51AW7cvU+mFaLbe7Ul6IHpKTUtdJoEL+zLw8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TV8A1nRc; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso14593525e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 18 Dec 2025 05:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766064474; x=1766669274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qz+Ave0Rr+pYsqesYd5D1VozD7cgPG0dKKZRCf4yYNk=;
        b=TV8A1nRcz/oC96zAeVzo+zhJTtGBd9/2eCnDphSgBveSFMm9fszeVyRBUtQ3ntEzod
         hnNKJVDK2bJ+3uPAL+oNrVrJbiMFzoDTkgec+Lf5yo4bJ0a5XmWOY9T4+yJQITL+trR1
         LIOn/XzrrMQ9+fric3Fs1oFgu2azoq2iv65g76q2Li/uVZuWAP/6nmZwyHhx4Z6YKoyk
         Bue13NiY9/5IVUXhXmnowqryEJ+gtk3W6Z98vCrbXDe63ttS9oHRmLJjnQHQ+YvUi5MJ
         NVt1pxjsPgNyQ2mXlfdd8oJnv3LCxv40X5w8qhmHjn2ND08tzqxHv6Bs3sjH+mxnVtbP
         BDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766064474; x=1766669274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qz+Ave0Rr+pYsqesYd5D1VozD7cgPG0dKKZRCf4yYNk=;
        b=EkMtBf4MfMl69NV965CMFioVXSU3grMZS7PO01iDttlEMaw1XAgqYd5L3fTv/DUPXE
         n//LR5RCOmC6GgB8Zn8Ya9nZUCNwT2l/VFBFXzEYqKllR784EEjePqTwx3+7TesVAvow
         5e99TKBeGth3A/Lt0pm/ZKCfsNrv8kIFMhwfdxOg3swJ7rp9r0B5mODlu+1ZLjNGRpMs
         iHd7MYaRCorTIuy6BoMrgvhpvnLttjInCXpp/emiH9IKZcqzG9WBCFuEf+wWOYXJVDpU
         6SPxRHKtZTpLO6+IraqXsrE2Q0WTtmLAPZpto6b65KRmVq70HVOMt/gqe2uKe5SWYVNr
         AhHg==
X-Forwarded-Encrypted: i=1; AJvYcCXTJMg7PH7Jn/bm9jyOhbRO1WbjpSxRBdYKwDhEnpvv9UfMEzVJ9oXvQWjxTVCfzogeRD6i51cFl/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gef7ht+COl0XmrGxRrgUSL34hG9B9BLUrzSZYNq8Cbi9za7z
	1OYCNk1TKtfCti4lCfMQStULcgUfjiLM2ZuwvHQMNgXH4PHpa4T4ZkeAdt7Fd7ZBb0s+awD6qjt
	cedkdgeTQ3DEZjOZ7UQ==
X-Google-Smtp-Source: AGHT+IGlOhSMahMSUEguAwn167F6Fbjkcu8ZrI+51vEqMqCJE+3S5hQDbdF4w5Iw7QzwlTk2wDuRew3DnOxTRuQ=
X-Received: from wmpc42.prod.google.com ([2002:a05:600c:4a2a:b0:477:40c1:3e61])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45cd:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47be29c60fdmr30005265e9.10.1766064473619;
 Thu, 18 Dec 2025 05:27:53 -0800 (PST)
Date: Thu, 18 Dec 2025 13:27:42 +0000
In-Reply-To: <20251218-clk-send-sync-v3-0-e48b2e2f1eac@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251218-clk-send-sync-v3-0-e48b2e2f1eac@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=hJ1r8AWFe6vjamRRbSdgVoDTTorMAE8/5j325qhqRPo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpRAFSiykIxnKvVV7ampJwe+hiZPH4dlKVVfNC2
 bRMusCRGIiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaUQBUgAKCRAEWL7uWMY5
 Rs5ND/9lBcHvvP1F2jrlMF7zlcbzolVf/Ik/QcXkh9CEtamti0oWtsfXPKvcrmdowiTh3qqTeOG
 d1pcYkv8At0D62DBbQJID40ZEj2jC53yyQTl+JbIxQgkPKYKW/7tiZ/YZ5l4Be6z2ypAJGa6jlu
 7P+IO8CGeyODkeDgL0U2tMGXuoKl6vJ9s93DzDVlYt3L2Dx6cpR55jWVWkBfziIoGS9Eei+zk7Z
 4ylYtbeoBKVsKs4Ix3y89qYWygDe/wXz0aRIGoDHBiJpBl2ppjbCEhP0PWGQra7A3KUayfL2KYF
 zmZLGvVKljUBMKcuQTuQUJN31zFt6WU2+ASxRD7tU+8u2vwrGOoiHDCS5fwLhJ12/F3DBE2H4eL
 vVgQ+jd6O8L4xD7oC1Z77SciJgITmTJCFM/W1W4jBGkk9AFU6+XIyzMnWryfADATfwgdGytDQIu
 F8KCpPdYrWW3vo38v9f5rhole5bvAC9Eh3vo2PyGcGLpjIqimDbqTsLCSvJmm/yQa0TbMqIXp5a
 ya9OwwArkL66kUK/YcdhJDrrJZXsHnkTxjYNekN0UfUNnAkWUl7AO9hiAu/V0GLq7YAfVjeSoGl
 4Gq54cB6CKjvPxv7GEqVbzEqyOnzjEJ8wCcU96VlVrvDrX57llCh1ppRHSozowXpxgScpJ/166f Mej0UG+6YnuMTlQ==
X-Mailer: b4 0.14.2
Message-ID: <20251218-clk-send-sync-v3-3-e48b2e2f1eac@google.com>
Subject: [PATCH v3 3/3] pwm: th1520: remove impl Send/Sync for Th1520PwmDriverData
From: Alice Ryhl <aliceryhl@google.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	"=?utf-8?q?Uwe_Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Now that clk implements Send and Sync, we no longer need to manually
implement these traits for Th1520PwmDriverData. Thus remove the
implementations.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/pwm/pwm_th1520.rs | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index e3b7e77356fc2492077c519073e861beb3e44df9..043dc4dbc6232020195c7b73fad302bbb69652df 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -97,21 +97,6 @@ struct Th1520PwmDriverData {
     clk: Clk,
 }
 
-// This `unsafe` implementation is a temporary necessity because the underlying `kernel::clk::Clk`
-// type does not yet expose `Send` and `Sync` implementations. This block should be removed
-// as soon as the clock abstraction provides these guarantees directly.
-// TODO: Remove those unsafe impl's when Clk will support them itself.
-
-// SAFETY: The `devres` framework requires the driver's private data to be `Send` and `Sync`.
-// We can guarantee this because the PWM core synchronizes all callbacks, preventing concurrent
-// access to the contained `iomem` and `clk` resources.
-unsafe impl Send for Th1520PwmDriverData {}
-
-// SAFETY: The same reasoning applies as for `Send`. The PWM core's synchronization
-// guarantees that it is safe for multiple threads to have shared access (`&self`)
-// to the driver data during callbacks.
-unsafe impl Sync for Th1520PwmDriverData {}
-
 impl pwm::PwmOps for Th1520PwmDriverData {
     type WfHw = Th1520WfHw;
 

-- 
2.52.0.351.gbe84eed79e-goog


