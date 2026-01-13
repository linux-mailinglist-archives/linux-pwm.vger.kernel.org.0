Return-Path: <linux-pwm+bounces-7896-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AA6D19C64
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jan 2026 16:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B632D30055B9
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jan 2026 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4838381715;
	Tue, 13 Jan 2026 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oRXiX8if"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF936346E4C
	for <linux-pwm@vger.kernel.org>; Tue, 13 Jan 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317207; cv=none; b=ujaGV5FrMXpjYJmwzJ17dcwlQL147gqpPPRU3FO0IVSK7LlM41ydRhInoW0ASlspZ8EA+P3XbNac7RRagyD6IGww3spcTgpy7AjzcH2sgGC9q+nYrr7PPsR8ZKNc/sbAmXOSuB0v1ftzw74G/8ceWD4+OY2KmAhRDAXMTTyQ4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317207; c=relaxed/simple;
	bh=uKkVhBaphq3Yv4o1VV/s1jKOfUDc6KdF7Ew3LDTjeJI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nuyBefE8c7A1PsE7Rc78XHmOYZrAFMTfinudy0taL6M2PCTCQsOjwlLcbpd1HMEYsWzncu7PN1eE8pwBY8MUGkpvQMGhJD+Fvbc60lC6xRFAs/B5pZeEpcqOdzzzGlHVSvagpVYQgMD/Y0sRZ0TQ0mjagafeJ8xYcNjm7pZ0UQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oRXiX8if; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477c49f273fso77620825e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 13 Jan 2026 07:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768317204; x=1768922004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6N1TEsiPesyo6Bt0PZvnhVY3O3p5gV/3E/K/p2dHoxc=;
        b=oRXiX8ifzq46e+fVjY2/l2aphR1S8AN0ogGEBgNzOLcwAhuvt6H4Zn8/9STxZuywGZ
         cE3rNpUtDyU86Khmc/4JGeVc11llgq/hVQsgiivkdiDuI5W3ncPJJDoS9mmzJkrEuDAK
         EydVJoNellUJ4NAlBZn7odpTFKUHNVJr3TJ4qKjfDvDLuNIJnjm7OX0TJuqN94xuaeyy
         b5zUs0OtRmFt+1ObHZt08rXnQXvgfPGdpKLyudSGmF61zERsqdga00KrVsTuhh2IRd4f
         TmqMKO+LZE5yJp7lVFussQt0wG84SsfJUyTze01WygjrzGha9mBvMzypHIRRCwD/v6gb
         kgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768317204; x=1768922004;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6N1TEsiPesyo6Bt0PZvnhVY3O3p5gV/3E/K/p2dHoxc=;
        b=cdbINiJhGhXqu9qruPWK0HoxPSpbi002avw9iGf6SGm+xOpXhJVS8KO40+feeNCHLQ
         U9PkTmiqagYptk/01WhTy47R8edaXkbBlLMRn0ao7NPpynfkcfo9gGYnwENtDZnH0iqm
         TDFBMw5xWhlCfqyZRdoRpNl2CDQEPcyJITdInheFeSFAW9QtKDttqhiX1Q6uPJNs/VUa
         ZkGs07h8DJ/QvyqRETVK/3hZcE/pk3xxqsaq6uUKblz0hl/0gzOBaUiG5xc+PbndJdru
         qiagm5mtHxomsNrn38lkgtcbwqtYfhREori9Bi2ytpO3JwrdOIhkQRTUuNxywk1cVBGz
         WypQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBrtblOni/Vym69+gjxPbcX60UQHHP+DFPMXDCOa7gcy6KLyUeA7XeZM8xYu0xfDLyAKHEGfjDiUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBB2Yd+3l8+HXxp1eH1+Lquq3uCC12i2czGuChcdlgvPAd1ZE
	1mRfan0EdbWtHko0Gr1ZrOax+olsl+UACjR6TIsVl6KPPGWJk8LycVTgEbI3zMtgxB2/bQkfiUI
	W73npt8BqFx03R8eGnQ==
X-Google-Smtp-Source: AGHT+IHoXaO70n2FJmZP8Rd2OF/hvQHQN06mNSOik2NmPij5NQxkTvgCkvgal1N4XDc5+fSDkHKcsHUBNt57n8A=
X-Received: from wmim12.prod.google.com ([2002:a7b:cb8c:0:b0:47a:9f70:c329])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8119:b0:477:b0b9:3129 with SMTP id 5b1f17b1804b1-47d84b0a8dfmr237085685e9.3.1768317204383;
 Tue, 13 Jan 2026 07:13:24 -0800 (PST)
Date: Tue, 13 Jan 2026 15:12:35 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAORgZmkC/3XMQQ6CMBCF4auYrh0znZZYXXkP46KUARqRGmqIh
 HB3CwuNGJfvJd8/isid5yiOm1F03PvoQ5uG3m6Eq21bMfgibUFIGR5Qg2uuELktIA6tA+VKuy8
 1S8ckkrl3XPrn0jtf0q59fIRuWPK9nN9/pV6CBG0KJKUIOTenKoSq4Z0LNzGnenpziYRrToCgt c0zpSyj0T9cfThJs+YqcdYmJ6ZSsnVffJqmF9R+xfwpAQAA
X-Change-Id: 20250904-clk-send-sync-3cfa7f4e1ce2
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=uKkVhBaphq3Yv4o1VV/s1jKOfUDc6KdF7Ew3LDTjeJI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpZmELFbghZxWZ7vaaZvAKoZIouMjeMx/D5VtYF
 y/dj/EnouKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaWZhCwAKCRAEWL7uWMY5
 RkUiD/9LHMHZPK8MfjH8P7x1+RzDmIXcOknAAS7n4m+VzrOjWzYSNqifU29O+VSt/W2ByxeTzYT
 aS1g2+Knt0WvtdmrmjV9Oi8vVsvlvJBWxBDtYFz8JW0c1m9w9+PUR2prE63e9bhpaF9ZK4jtN9F
 LMiiOZoqtCep7C+0aLHtunxvrUdJg39W8HXc0/RMJXv0iv9KImXAeuk0Gk/WV9npuZxU1AWMVV8
 W2zKm7ZD2cAB8V5JVSrh0LHN8lpMGSWU38mzd4N/0c662gulPBXsY47rbyj+ieUCU1e7Xb4rq5B
 XIC8Mu1AgLO0cM5Yr6G1Z1v09A1OECpW2F76vg16IFCNsCP5LNcYx2QE9SJh/dszq6riDB7N58q
 tZkOXDELeZ4++DyyRgnTGh+f07jh89dg9v77g/B+USWQm/jZ9P1VRFHJfhkdjjKmSCZuidXUx0U
 aHVaDuZcRBdGpZz0lGsO6868mSmdNYqR+PMcjDTiFqa2n2HRQCvdJybEcQoQGCmTgkxNLaicwR+
 0UDy8ZXpzI/D8WLlV/EyKHrvutrSXsAv1f3SEOvqzrq8WgsKNhrKiH+GHnyuGjAnCz1JmMumvTf
 0KM745KlQEWD2wlcWYm6yXD7EPEXhU+/gLRvZKu7c5b9rnjPGb90UJbYFFOb2UmYeVz9Imn43fN yqmFT6fOTRmLMfg==
X-Mailer: b4 0.14.2
Message-ID: <20260113-clk-send-sync-v4-0-712bc7d94a79@google.com>
Subject: [PATCH v4 0/3] Implement Send and Sync for clk
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
	linux-pwm@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="utf-8"

The Clk type is thread-safe, so let's mark it as thread-safe in the type
system. This lets us get rid of hacks in drivers.

For Stephen's clk tree.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v4:
- Pick up Reviewed-by tags.
- Link to v3: https://lore.kernel.org/r/20251218-clk-send-sync-v3-0-e48b2e2f1eac@google.com

Changes in v3:
- Rebase on v6.19-rc1.
- Pick up tags.
- Add fix for pwm driver as well.
- Link to v2: https://lore.kernel.org/r/20251020-clk-send-sync-v2-0-44ab533ae084@google.com

Changes in v2:
- Rebase on v6.18-rc1.
- Add patch to tyr driver.
- Link to v1: https://lore.kernel.org/r/20250904-clk-send-sync-v1-1-48d023320eb8@google.com

---
Alice Ryhl (3):
      rust: clk: implement Send and Sync
      tyr: remove impl Send/Sync for TyrData
      pwm: th1520: remove impl Send/Sync for Th1520PwmDriverData

 drivers/gpu/drm/tyr/driver.rs | 12 ------------
 drivers/pwm/pwm_th1520.rs     | 15 ---------------
 rust/kernel/clk.rs            |  7 +++++++
 3 files changed, 7 insertions(+), 27 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20250904-clk-send-sync-3cfa7f4e1ce2

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


