Return-Path: <linux-pwm+bounces-7811-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 978FFCCC008
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Dec 2025 14:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EADAE302F187
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Dec 2025 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD3833FE05;
	Thu, 18 Dec 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rTX3urqp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C233F8BD
	for <linux-pwm@vger.kernel.org>; Thu, 18 Dec 2025 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064476; cv=none; b=UbVVZ4oKfFcIvFSTQpBRIoO/dweiWZHfLZ/7jJkVmco3C3lXG5tcGPpIdPiSF+36h2HIphRx0beRSbSkaoNY5s3OsdgiZtTEZ7Y4rdVwWbNg1WcT8uylNlfuQMC26VNlljNTZ3Iz+K/wZxAa3x/5xZonsbwdGfFJ5agMvXBdbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064476; c=relaxed/simple;
	bh=F1lcAFNww32YALWPOxbeZmA3ejiotHsR5mfwB5toNyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JZZ5xG82Jjc3WvemqBS2CM96yiMZFW7YNGX2XtfKfYqsqqtl34I596WFxrgxJLo/zsskDwnxuEt8jQw5bn5LdNII4KWPR0kMqr2XkC0utFO0vwbLV639024vhwtFUb7dQs9EVIYFALq/GjbeRABBmN+g93MJuywVki/Z3R4AApY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rTX3urqp; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64537824851so633522a12.1
        for <linux-pwm@vger.kernel.org>; Thu, 18 Dec 2025 05:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766064472; x=1766669272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPptdLMQzSRoeYj6Hrjl7dIAj/bZbKtg9ZgsU3qRcP4=;
        b=rTX3urqpBK9qP2PTRcf1RL/jXbbwNTuDxREnG4sVr2/pZ9M8WHReJlhZdbYxdCuV3D
         jso+sO2FDEqV7YO1l5+LmwMDCyv5Ykow4UhZjFybH+jC2WIxPF3PCQJMYV8xP4HiczFH
         Cf0dObKqmUPRT7ZWpzICyX7PEMa3V+UvmWJj3m7DLtPOVk/aeSX6SqyCVJN7iavG38lG
         Zk8jujUq6cYVI7cQbTYyke1EgN5e7ahJISUx3LfBoKcaapwk0ZGpq0ZfJ9NBpDG6hgz9
         NbljBh3JOxpZPhWSdw7dAbYu6yAH6nADpRrj2z+CLYKHxDJuYZoY80JzPpK+6ayg7q+N
         5HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766064472; x=1766669272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPptdLMQzSRoeYj6Hrjl7dIAj/bZbKtg9ZgsU3qRcP4=;
        b=iDTqaFZexLmPC9CBsFeQEQP+oPlSrmRjZ8MEHRuflA1FSVqBZMwCxt6gjMVt9s7394
         5XAgtGqlewpcFn/bqqSw/kmbPBddjEXk3KdQQk9QP3u8ipImJowvNZeYW322JdYvtbGx
         3Tm7StarTJmj72tYwIyvy2qQfBhrx4UOy695VYRTozPMUCbRyLtbwMNzbYIRqalM5u5M
         +qR5E9tVpUl1irONiW9P4qVbmfSN8m50u2d/j+ZyOhRsvo8Nq+c3M6fJ73/rpow+IRWo
         4QHAkG8T6NJd0sWcXdGxDqKMUWU1obPM/vDdXr9zKOs6Tfr0/E9zM8jcRfVcNuQy+Vu3
         6tjg==
X-Forwarded-Encrypted: i=1; AJvYcCU6pR4Urtv1VhjVPfoTlAzHoGIZSVQ5+AJx/vzs2MNS1S5C04zOoSt0t4Jw4tWB9dG1IXAmS/NyvDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+wq1UG/LNzpq32gM6lF9+Lu3FTB6h2QuNwmtr5p5vh3NnXfv
	CSnKEJkRy8HHHTwY/NPBKOmih+i949KEIdwdiGfRp4FSj2JpS8DdXvssrSpGU3lRzH30kaqeJnx
	fHV0UA9HnUDzIJJmlPw==
X-Google-Smtp-Source: AGHT+IEqPOft361pJTlpzbo4r1Az15cTuwMQEfh5KrGil6c5DKT9dTPisXdo2WdHWgmo3QB8gCSt51uaXvkVnKs=
X-Received: from edtb2.prod.google.com ([2002:aa7:c902:0:b0:64b:3f32:3786])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:510c:b0:649:aa2b:d34e with SMTP id 4fb4d7f45d1cf-649aa2bd4d5mr19796028a12.34.1766064472249;
 Thu, 18 Dec 2025 05:27:52 -0800 (PST)
Date: Thu, 18 Dec 2025 13:27:41 +0000
In-Reply-To: <20251218-clk-send-sync-v3-0-e48b2e2f1eac@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251218-clk-send-sync-v3-0-e48b2e2f1eac@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=F1lcAFNww32YALWPOxbeZmA3ejiotHsR5mfwB5toNyY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpRAFSWSny77iwIsGzKsSzrxHbWYGRidi4wKUj+
 ky0LI75Ss2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaUQBUgAKCRAEWL7uWMY5
 RvgbD/0e4oYtNdP81rAHg3z94FA3jXour1f/plwNgEk/ZamK57EcpX33mAyVLYHcizYsBAXobj8
 am8MyWvLYn6vpr7tx2LS7NZKRpaDdKtU8hLtv4kiTrUqlXTHc2gdDX+4bUPvbHaucO/SaM0cwhH
 YmdiCosFbFZKnHVwGbfbiOK0e/NfqRfDUckj/cxh4YB5cCtDV8FFyJ3kkDdAxM0dGs4OLipgI4h
 i5CMx4B1rrv2P9G/QlL/fSDjJ43XH4475E9YOsLEvPEhAYlLIYUzo/rE/Kaeu6PICY8hh1yy6Fv
 STETnhmW/mMc1h/YSnBddXnFklCoCMHGWZzwUNVhbINFR9wXTZ9dORQQEC/kQKrz3HB9mCUHavC
 AKTMK8M518WNFW/KmcpCQuCUV/QMzh53S1dqxnOGrFXOkyTT1J8DV7ILO1B1djcUFyYWghNR8Ip
 ghgLFaoKreKay09TC/pz6aQe6oegcfGdVHZeCwrF783LbaefHkCwnQxgq93CoWD4SaDxVdptyiU
 c3VFdxgQUkPGbHHH9zk5ct26cnzGalmVDInhx915An/XkyBHna1HZl1I7dkY5je4cJxn8iXJi9n
 ezwBfnj1zNVzI053FQL7sgbp13dOehoXQV30MffCZQ21N9huXxaq2USl3CSpqC1SP89Y7AVazfB RhbcohkXt0oVDGw==
X-Mailer: b4 0.14.2
Message-ID: <20251218-clk-send-sync-v3-2-e48b2e2f1eac@google.com>
Subject: [PATCH v3 2/3] tyr: remove impl Send/Sync for TyrData
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
implement these traits for TyrData. Thus remove the implementations.

The comment also mentions the regulator. However, the regulator had the
traits added in commit 9a200cbdb543 ("rust: regulator: implement Send
and Sync for Regulator<T>"), which is already in mainline.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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
2.52.0.351.gbe84eed79e-goog


