Return-Path: <linux-pwm+bounces-7899-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A70B5D19DDD
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jan 2026 16:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10CD93030614
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jan 2026 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788923933ED;
	Tue, 13 Jan 2026 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0xhZ6ud"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DD136A02C
	for <linux-pwm@vger.kernel.org>; Tue, 13 Jan 2026 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317216; cv=none; b=AsD+4siYjZ4b6/eOS72Sm3eS4Sb4QfCmqYyw18B9FYaHGX4iOyLc183bf7atKBbRI3Ovrv1P9792s70PRzm0SMwu37ln/7GWR7oMRCRNHP6CzkZ+WZvYYut7vaxKnlH2zPeE0IYKIPbKM1p086Fx/lXi5oLQhUJHRKLgZmqoEOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317216; c=relaxed/simple;
	bh=5DE8fHUHNeug+88kGFo3S/QoXnkelD/PvswD8rGjIrM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=od0+37tK7/FnENzd52YfaqtuwK0eIHHsSPU017ZF00SkIilhvt5v7UJSSWjLGG8c5o1G/+W9sKeUvjx7ZL8MOmOcc08pglvZQK24zs0Wap9ziiZew3F8AN7PI660hUR4OYAtlohHKd27z1fYoRfHjsx5wbBRBS/NMnYaBCLE2zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I0xhZ6ud; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43284f60a8aso4350404f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 13 Jan 2026 07:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768317207; x=1768922007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=clahOJSyAVmCLVNVjHaJTlJ4hThwgbY6ylIwpTEN8h8=;
        b=I0xhZ6udPcaRNeEhWztS9BIlheYHH78ilQ0ssnqyG+aDyEtt2ZgRIJEFMXcZxmErFh
         Ej2OY3B9/C1PglWoh/3bi7ywKQ9Bu5WqQgOzme5UiIqNVRzyb/pQXdUnkO6Qmgkjtrt+
         VV8NK9cTKMs6OTRzWSN8SAXRtB9ypauip8DK5c77gK3x0M6AZ5GljGjFio4BWiy7IzkO
         OSIzEOHDw6GimKjcPKgT/IlhLE7eXigs3cSRMyYQcP+NVnhC02k7+z2xaiaE4vOvtQbp
         oq2p3JqOcIirjWXkhLjLJdZo5/nTn7RtXay4utXCAc9lv569lZArjJVIyxu8U2kfUKi3
         eAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768317207; x=1768922007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clahOJSyAVmCLVNVjHaJTlJ4hThwgbY6ylIwpTEN8h8=;
        b=ZA2/ZQtVqP93cWSJTfH+mHLklVAFIsqiHfKyxuTOLMHRnmQ3NeXp7yfJIbzMph3LC5
         ARNtoBvnz8Xb92mXE5sGX92ksAbQFedknanGDHyLojgb3p4rO7Y4SSGHxyNBKPC9UIHs
         75tFHHmf3EQzAhLaBP8wMJCnIL5LuGEf0rM+2/a6zBz0RqzckY5byo5qoztLOK3ESzlH
         YymNXZmyeAuxzKAgZvhh3lN6mGIU5w5Dc/nLhew5tCwJGqdp4xXrbgJg19ZiZU5aoGcz
         a4S/hsRUISdZmGa1BrIbT0rh7D/Jwho2d7ehSQJIM+DlLvkDuOsQuNcHzES219Nus6eQ
         EHjg==
X-Forwarded-Encrypted: i=1; AJvYcCU9jPpAeH0GX4DER5j+gXFhqC//tTSLUeBv+iadRC/klJV5WnpltBeWR5FW9VtjbhmaKTote99l9iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrsXiwTw8VcCon6KOB96W3pr0JyKrp+ioxxyd71fOkCKtNIGiD
	QWckjFjrHgslZ6yERMlyYobkw7BCEUnTZmV5j1CCeJjrjTK5NRdlYLxdWkxo4Cl+vlrxbYk2GyN
	E8IxI/VFVfObsy83mLA==
X-Google-Smtp-Source: AGHT+IFANjV4vLX5QPuJ5KpCs0Rj644PourkYIVXhMKZkYuRk0oEaR0gmzWWf8Xi/v74hg4ToVXO6AC9XE7qoTU=
X-Received: from wrbbs10.prod.google.com ([2002:a05:6000:70a:b0:430:a835:4ce8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1a8b:b0:432:84f9:95f4 with SMTP id ffacd0b85a97d-432c374f4a7mr27176145f8f.31.1768317206801;
 Tue, 13 Jan 2026 07:13:26 -0800 (PST)
Date: Tue, 13 Jan 2026 15:12:36 +0000
In-Reply-To: <20260113-clk-send-sync-v4-0-712bc7d94a79@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260113-clk-send-sync-v4-0-712bc7d94a79@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=5DE8fHUHNeug+88kGFo3S/QoXnkelD/PvswD8rGjIrM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpZmEQNNwQvfw9jQxuDNt4fC2n5Cfx+vcwSjcWB
 EjbHAg9hU2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaWZhEAAKCRAEWL7uWMY5
 RvRxEACuwFIesZvoHE5gK5RQaiufwGNORvDKEuP1GJmMebtB3qC4PmH2wFMguWvNpJTUKWU0D5d
 jdQ+ITMxKWDtDMpGzdoBMliByodTN5wwtvNZGIPaLLEUZ+uImdP1HlZ+5M03+eyQJOMs05GW7Zc
 TSlL6zpiv+54WAj40TJH1d5HPB0WLbITPscM6xHXaCvfaCMxSEcbqqDprp8VoDZ6zgZSeAIqc8v
 zVSXwizZxkbc9uGfqfyY6kGS2soNpo+IyeElYFqMNY4pR992VOqL1+37BbqF6BxAxLrtBwNoyBC
 KbUq7ZcC+1DqYAejPv1soQ+e+hcJK9X/dtfkBjW6GBe3B9P0Y6s7qEHIUqV7BSEvxOB/mIQ5UZ0
 rtRm3VEAOnA8v8E2oGTQazJ58ezoKWwB5L6muDTmHlSyEYQhVqNUNAVsxi61bWxCcuXPu9KmxgC
 LHI3zLNriAuors7Gzwlu7Ahzu/6yPgqwJ6ebzzMhWAwTKLvVRvIL7BbAMjEEfFofP9IEuyazi/l
 Up8zWnwYgaiqqLz/g9gxZdaF1h1dm0DWqMUCkAe0/o95w00/ZUtgyOkYMGdSqL8zyYHhS6K7/Qg
 NaPzd6f01DT77HGn2DEO6xOX2PbrAgvzU9PVSXxUEpt/0wR1I5PF2aS3brFDfpjwLpJ/0c2p8pf 28UFVHEynEoLnxg==
X-Mailer: b4 0.14.2
Message-ID: <20260113-clk-send-sync-v4-1-712bc7d94a79@google.com>
Subject: [PATCH v4 1/3] rust: clk: implement Send and Sync
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
2.52.0.457.g6b5491de43-goog


