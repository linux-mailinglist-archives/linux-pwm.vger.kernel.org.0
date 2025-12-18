Return-Path: <linux-pwm+bounces-7810-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7975DCCC01A
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Dec 2025 14:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A740D30C12A6
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Dec 2025 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846DF33F8D7;
	Thu, 18 Dec 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2bThxjz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B433FE00
	for <linux-pwm@vger.kernel.org>; Thu, 18 Dec 2025 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064474; cv=none; b=PWwdTtuTN2ORAO6CMSUBQGw+r8JGLMiu3hdP+iZSSavAd5J/rHYQLZDYhgoEEzmV49Kz6oBEEgG2j0Ny2pyjaMuTsqD1Yvia7ASeAENfGisyYCIHZQV4z2RUIL+NjTNoyaNZT8w5EOCAGtbGJEF8PhJuI9ASk0AQAYYiRNgxd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064474; c=relaxed/simple;
	bh=GfyAuLsrs0QXvlLECZS+Ag8ZW62Fz2Y2rspmoop5J3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SckD2d+8pyhvEJPM/zlct1JYgzkn7qvYgOyKPKzWXMA30K8u2rIjM4jh0l8w1d37qq8UM6f7dfOQaYPEGvqgxIh72/7F7G8ribUl+4v/qeVOcXdhqSU+5NOm6nZZbxpfXPcRbTm+IB6KE1nhSf5Rt8a6pylvz+gMGO96l/ZlYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2bThxjz; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso6923585e9.0
        for <linux-pwm@vger.kernel.org>; Thu, 18 Dec 2025 05:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766064470; x=1766669270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jK28JFeXstDuyy0FEYnFWM4ECthU7/SRvZ+Uc2K8TMM=;
        b=o2bThxjzPnLXU9L9oDeGhOZkES3GeRTi1zL3NrEGaNdq5jkqWT6YufCyA5opuTtGEv
         02oZOcKKVPzPb46XSEH/6HgYmoFn7eNtH7QHv7VUaAbf6JphZnkBv2nWSls+eo8D9fiZ
         0phoA9jebLIq1vz0AeUAgYhIrIL28aBA7b3L4U0/HKp8Pm+b5ofzMi0xjqMk+5RE8QIT
         UYvW76TLJ8tiMGG0gZDR6yG0Xf0xK2pTrzeV82VfHuE5IYEQD4K0cW/YQS9P/BwNi5k9
         /AmJ/4K1dD20yGEL71Z9pOKA4bvSpm5v8dlk5+WWJrgD9bB+LDB5oe6tXmjgVOyhxHwU
         vS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766064470; x=1766669270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jK28JFeXstDuyy0FEYnFWM4ECthU7/SRvZ+Uc2K8TMM=;
        b=OqOlctC5OLRqmC9SkyDUedUcVfQPXX69Hmj5G70QeiFs5tyZRIQI7a6bl8coPx1ug4
         f11SLAa2QC/zatMmbyXnAIsBpuXWhiWsql3gyXZwc0bwui8sNfWflkPdKy18V/n/4udh
         BNVeEBeFtf6x+krMekKS3AXPIEDzNGcO/81i6POngSr6Wply/mMQLYD5ZJoD1UL084ZL
         qkG4qk1oLW0gfvcFKMz9dv300fef7K272P12mMivtqie6OKrO0Y/e2RXl/4a+Nh1vaMI
         LBUbPwEIuT0GvDtciTA5E5aCTWyP9k56K2buPpSUwO32WUW9E/fl6r8SmsjFHDjz0YpR
         89lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSrn90G48dcbwllKF0tYp2mj3fmH7Gap5paPQ3DKUWmgsT8dQur6gx4RHLNpsEekgrRFol4DJ0e9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFT9FD0D0k0O0yvfQ3hJAT0fIW7hP3J2OgbPBu/RxTib7R3Xmn
	FfPJjwAC38IgDCCSioUDAMnuhiwRHjQ0ofacXopThvhzJujicU57/Kp7bgIBethll7pGXFxahPk
	D/mSdRLiAAh7lZ17L0A==
X-Google-Smtp-Source: AGHT+IE3mV0hHlOMpYVWIjAwdmvo5jE0L9sBOpWL6XsbMzQezjxagjqpMFllYAiylsVjD8lLgu0n6vRFRAWYICM=
X-Received: from wmgp21.prod.google.com ([2002:a05:600c:2055:b0:477:afa:d217])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3104:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-47a8f906dd3mr228600355e9.17.1766064470141;
 Thu, 18 Dec 2025 05:27:50 -0800 (PST)
Date: Thu, 18 Dec 2025 13:27:40 +0000
In-Reply-To: <20251218-clk-send-sync-v3-0-e48b2e2f1eac@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251218-clk-send-sync-v3-0-e48b2e2f1eac@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=GfyAuLsrs0QXvlLECZS+Ag8ZW62Fz2Y2rspmoop5J3s=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpRAFSGE9hInQJ93qtSDZ6USDztanUVRXYt7zuZ
 u/M3OKN66SJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaUQBUgAKCRAEWL7uWMY5
 RpjnEACSGceY2rPEdAJ9IM0nAQ/WAryJFpSfxt+WLrj3iN4p5BmgrDdLtUBRaFYTYqcli8hAS05
 YJwMVlfRAd6iFo4DaO3eqnrvZQRPSaBmxegr8FhHpfv8XSaez94scQlMk6FrcSlvrA6Ee4Gtlwp
 l+ilXpbYOyAubw6GpjlWswSHxKOg0QwnWCzW2KwjpbXJnfLQ5fH4lcncuzMfaAkPvCFV4t1y2KV
 kaWXQIWrkEvVGzZJssbmxCb1PvSE6oyjcy3TzBBSM/E1t9jJSdXBS+NfHM5gMDUErPaSO224COW
 ei9hJ+Rb2IfKuZtQ9gud09brWgGvjaOVaiC9LM5c3bNNygut/rL2sqBDf0eUnTjZZ4hl4T7zj9w
 q/VO+QeTNdEDV8AfXeYCZs11q9X+mpJK3MYCF7ZLQsBZFOiaSgTwrF5Q7PSXXxL860gZaGED9so
 hqtSPCzOrli9/mHqIoHfLoSPuUaf2bxTBaNboLD+d8kdD2+h9FLLvMhgGVhXYhEUmOsBKZC9MlN
 DwpN5R2dUuDE7iXXAi9r6a3YRd7J5IHGfhXALODtLYLu7bdkcna8Ggb35wgjrid9IfeQf9eEdVQ
 9zkYMJevx5Tf5DKTw7VxZGkTJHxKfsL+G8+CcVjptxDvHWl4UkCa+/HLohudluaxij+Yf/xnesA vfDaSFT0gn04/pQ==
X-Mailer: b4 0.14.2
Message-ID: <20251218-clk-send-sync-v3-1-e48b2e2f1eac@google.com>
Subject: [PATCH v3 1/3] rust: clk: implement Send and Sync
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

These traits are required for drivers to embed the Clk type in their own
data structures because driver data structures are usually required to
be Send. Since the Clk type is thread-safe, implement the relevant
traits.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/clk.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index c1cfaeaa36a22be2e3180b1e9142bb608ab276ea..d192fbd97861212d738d24510eebcd99c9177f2c 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -129,6 +129,13 @@ mod common_clk {
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
2.52.0.351.gbe84eed79e-goog


