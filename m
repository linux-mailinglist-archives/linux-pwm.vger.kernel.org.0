Return-Path: <linux-pwm+bounces-7897-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E0BD19C76
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jan 2026 16:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B372F3012784
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jan 2026 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6602F3921F5;
	Tue, 13 Jan 2026 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dj+qPv+j"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806438E100
	for <linux-pwm@vger.kernel.org>; Tue, 13 Jan 2026 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317212; cv=none; b=QvM1jwAuTZHhDQCK4o+uGqCPZsJWsfcDv2xD+6IguhinajnFdBP93tyC8C4DgVguJ5b9gj9vH18aIqR5qlkgy+Q3lBjqHkG+E7Pu5zVFszokHyEJhONN/ZUz0UqJZw/0Gxw/u4iVYA7WwQubbMOVrE+p6IWMSsSbuRd0dg7tWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317212; c=relaxed/simple;
	bh=gBgvzdGxsZJ9P+o4TYuYZOZRWaJW6R3le+1fCyVi18I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WcS8iftmy+ThonMTnewUE9k6ggkRlGLkSCq0muteoGZi5W8IMwwZ5xrec/y7ACuZPJN4DOkSG+tBmE0QkOtY+DtccUjBrodScaPoK8lgbcT7Stsy2SgA3ndqIm5z4CPmjZSN7dgMwAVTwKU5uvBJuLaLPAHWnf5x/0D5if6iWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dj+qPv+j; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d28e7960fso78405125e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 13 Jan 2026 07:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768317209; x=1768922009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+856FUFrQ1uMLS1oGlG8WJLskHLLy9o2M4Kx5xq+7BM=;
        b=Dj+qPv+jJqupyZRP7Wj37/5EsQU+bNFiakmdCA3aNZJS6iapgb4zKg/sYzUB+oIrSG
         tc8/6UBQBj5CWJnRY73jLigb6vZBJ7m5N4onkJ4PNZ/VXaI0uF6ckckOw9mzuoNlrFm7
         sbtnnrEt4L8kY8VMQeTjYfkwAb31SHZtOLHs/mR6faOCZSS4TtTl8uMyBep+om0FkIQc
         C1rm+TsNue6AhtOQ3NrKV07mQT8624VGrnGC9VK48ne34gXjfU7PX1aXQa+tp561eDJY
         G6TNBaH8fX9vEqPpVCDZfKPU6BNOk+2f6EBQ2baWfVjwLsWbKwbu7cFEZ8LHpbyYiFXf
         fHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768317209; x=1768922009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+856FUFrQ1uMLS1oGlG8WJLskHLLy9o2M4Kx5xq+7BM=;
        b=PRThVFiinXdkXEkcvfLPSsZfG3MQwhzCR+jxk6qGlk5ExUaUiKEqiDTtlXb0tJKUhd
         3uOtVOc2iYXRqzRuU3MasEX1GvXe6hhyLXxzW2LgsPWDm0PfZ+QOuUx+NI1b/6yAgfl1
         FwHrf+imDK/tcVs4lc/8leFA9tTXtdtNANHrVzzTKJL+tkNq6P2Alh1td8qVS2Kn1HJr
         n8UhPvZ/uLPjH37btXEB7SDmZzSLGGEGHTTk3eOpjc6JDEm8Pf5d/ToPjFuUjxuk8baE
         0QLOXLE6Cc8BOFjKMKoFcYvRLy1JBikIk0MJ4KeSSeQPS3SqNCGQzxbFJ6goJOEGd0lC
         ReqA==
X-Forwarded-Encrypted: i=1; AJvYcCW7dmHuQDbfb1W+2RUNl2BLo+Y0QEfuNdQltp2tnqovjqzJxqthQ2ZFPhH8GqKaNsCXuRQ/fTGy3ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWu9VPJadGc5uGI25NhAUBh2orNsQZC1r5HKHF3QxzjPcZxdOI
	QJE61NSBIHR6NvaCMztmw6tnUEV6PPdDgm8lqDBBlYcSOm8dMRu5xap1HlOp9xnaQyuxwkmIHlj
	7YgNvzH3oTaNVbhVE0g==
X-Google-Smtp-Source: AGHT+IGmHpal9o9kYRCqeudE5OGpHQsDJxQXH71nc/uK+vHzcbqRlM1R9M+yj/rHy+PL0q1Xd9tRxUhXRg/AaE8=
X-Received: from wmkn12.prod.google.com ([2002:a7b:c5cc:0:b0:47b:e2d9:2e56])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f8c:b0:477:7d94:5d0e with SMTP id 5b1f17b1804b1-47d84b40955mr245818705e9.27.1768317208607;
 Tue, 13 Jan 2026 07:13:28 -0800 (PST)
Date: Tue, 13 Jan 2026 15:12:37 +0000
In-Reply-To: <20260113-clk-send-sync-v4-0-712bc7d94a79@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113-clk-send-sync-v4-0-712bc7d94a79@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=gBgvzdGxsZJ9P+o4TYuYZOZRWaJW6R3le+1fCyVi18I=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpZmEQ3m0NLVAdMWPcGPUsnYIg3W5r/sNDHFFhx
 Dkr8r8Oc/GJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaWZhEAAKCRAEWL7uWMY5
 RvfEEACjTscIGJhJynFAKM6GeR0pshAjNruRsL1XI2fjXIhSE+SSnT4iB2E59xTIcS3M+nwv0oR
 lptUt2zMowQ0JNWnWfMlhYHwaSgd7j+IBwQOVbs8KFtzuMLrLQD1PpJmYQYsx9aIlzyb5uPIF+p
 6I7+cnay5Xpoc6yv21NhJ1/WW77v+u3zgxTMoY6eyuF7ItHn0gI12TPn5TDUyqba8oE7XCAEiz5
 DY7lo6vCuKHJHY/ysoW1cIN/3CLRBTgof4w8crzoLDnO26t1/55uZ6xRyhgkVNrWfpuKTpOFW+R
 AES7YP3VLCq2TMXhF9XeJ/ZqiDJFo2sawCja+1APoWHLnZRPL7Yn4JhxuD0vg9JpdjyEEGQk1LJ
 eNCsvUE1AsYAHWajubBONw1i0Zp9grMM2d+rkKCESW7cmqCNVBTEMUekH/wzc8r4N4FJSRq5Gen
 a/jBA/914TYhFX3ld9WgYBN1nrvIur9CJdr3CwZZmc1y6cAwUw21Fnh77pJF5/CRK2VXR1UPL4Y
 epuqg2O56ZCBKBG24sLv0yZ2FylVV1jXkBGC0sPytS+Zw26BczE2hM1tgQ0JaDOKKFTGWLF2x6Z
 1h9mybuFKl/JaZmCCV/9SPM03m6WMzhmRV/Xnv6AGxM6KuU/VWAMbEPsCuoc0Po791vKHzbbfCd 1qJ4UwkULxYnX9A==
X-Mailer: b4 0.14.2
Message-ID: <20260113-clk-send-sync-v4-2-712bc7d94a79@google.com>
Subject: [PATCH v4 2/3] tyr: remove impl Send/Sync for TyrData
From: Alice Ryhl <aliceryhl@google.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	"=?utf-8?q?Uwe_Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Now that clk implements Send and Sync, we no longer need to manually
implement these traits for TyrData. Thus remove the implementations.

The comment also mentions the regulator. However, the regulator had the
traits added in commit 9a200cbdb543 ("rust: regulator: implement Send
and Sync for Regulator<T>"), which is already in mainline.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/tyr/driver.rs | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 0389c558c0367522471ea78fcf72a6b58c4a3650..09711fb7fe0b1c83b72bffba06f5a76c53244f4d 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -53,18 +53,6 @@ pub(crate) struct TyrData {
     pub(crate) gpu_info: GpuInfo,
 }
 
-// Both `Clk` and `Regulator` do not implement `Send` or `Sync`, but they
-// should. There are patches on the mailing list to address this, but they have
-// not landed yet.
-//
-// For now, add this workaround so that this patch compiles with the promise
-// that it will be removed in a future patch.
-//
-// SAFETY: This will be removed in a future patch.
-unsafe impl Send for TyrData {}
-// SAFETY: This will be removed in a future patch.
-unsafe impl Sync for TyrData {}
-
 fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
     regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
 

-- 
2.52.0.457.g6b5491de43-goog


