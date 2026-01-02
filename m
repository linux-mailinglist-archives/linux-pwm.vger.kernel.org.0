Return-Path: <linux-pwm+bounces-7837-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8B8CEDFDA
	for <lists+linux-pwm@lfdr.de>; Fri, 02 Jan 2026 08:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BA49300E171
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Jan 2026 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD572D46C8;
	Fri,  2 Jan 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETdCK1Mo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419802D3226
	for <linux-pwm@vger.kernel.org>; Fri,  2 Jan 2026 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767340332; cv=none; b=BBwWv/axkGTGfADZQrDVyOt4jLvEOrK5Bd4qYHeI9i2TAvLGGKez8mI9xH/hCdcllKG+e7wG++k8i97yawrcjgka0OqG0HkGYnrgnEK2OsL39maN2uuBkeZRwZu66/bsvrVsf55kE/WDPz+UKmbDUC9+Dc3B8/SLS1Khgfv5NOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767340332; c=relaxed/simple;
	bh=PYqFtCJKewiwotOHkWKODCOViU3vbaITARfsgFWgfPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOORBI8HSHFEeCralNLtqTDvHuT2qrP5QSviTMKP7oAVmW1a+uT5vZ4kTjdCTAwphCw0wXfU/4boiS1lsdFFr/o+7JS6GUZ0p6BeueCLOBTv63I+9VPa77PnJvWGUy1EcT2i28idNstY+z2SrcKkQqIq+UgJHt/AeJxQy2TOKdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETdCK1Mo; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37b983fbd45so90815881fa.3
        for <linux-pwm@vger.kernel.org>; Thu, 01 Jan 2026 23:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767340327; x=1767945127; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GrDXAONfhMHnF8PgdBj6M4DUOiVSl4risTQaplS4W0=;
        b=ETdCK1MoFyeVcTxBTTKYbnMmfcHInxvKFDIbLfRDFMseCeSX9qF3BSoR4dSMgqWCM7
         gcAJ3L/7fvHK4syoJBl8ZlhNhvhNOvZlTTpgAGQRA5sTgTqJ3eTAVAksHt9s68ZtINBC
         onhefNY64mJAbfNFbFkA42XL1+GkYTRYqcplte+PeLMGSauoVRu4HFAWWt+UcyQZAfq5
         auibF6ne0A6AGwBS1bwdgD2xoZgDPEdoZtHlq68mKvNVJrXiiTpfPoGJq+gS8SmAMXQc
         JzAkLChcxF5gm5s1hShnGA/gOywLNrBeC2squIAPc7hgj2wB93tBycJNnVv9ApyL6Cbj
         mvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767340327; x=1767945127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1GrDXAONfhMHnF8PgdBj6M4DUOiVSl4risTQaplS4W0=;
        b=Fjlkx49SiCWemLpy7oU+mRZ+Ti+ZFbt8QiaTaLwxN7YqcBRApXw5tGoYXFpxl6kAs3
         UDcMEcDr0vfwUx9mCcWZHACaoNWPp0s8anPCrtUFCa98n+xTh04mktCki/Is4w6j+x9f
         0YDjjaE/3mzUp68PMJwCN0WHlItLk5f5yjTsUVdBxXflDYttgolf8iK1wDwzW0jNSxAn
         7r/2n3wiNYXuc+lhKLYpGzdvJpqOY/bFAUDFjP8IMgYFCJQv4+/EZiS4deEmSOLCoJFo
         /5oCmr4idCwDQ/eEPXczbrplhXvtJWdLIHIpW/rzADU+FL8B241EJ60O0uGsvCTzijnd
         uNJw==
X-Gm-Message-State: AOJu0YxzFuTFFr6SHdoNqmCJ2Axf898jnrlllzQMdjfsak3vU3SP21Q0
	FWtfFqjXes/9EDCSmGY9szGzyTdq/4a7vVpbTJ6zmfwXY6pCd5fI8j/W
X-Gm-Gg: AY/fxX4UDFbxfhAHV+5i1V+guuo5NIIvAPdVlgZBN/5GBa+V+RUoI53v2r++orljzeW
	//+vbcsMqoRKgmsyxot3B4XEGbzU2KRGWBdwMyAKv8MiYpU6OZc0KYtPRUL8iKjDlcjPzF2I0qX
	EF/WGP3zaRmZk36zM6EmuAqqs5plWpeNqiZui0whjwrMBT4y34+iEo9Lgdi0qfdSyEU6S6gX4Xf
	1C4tSFaiZ158/euPQTvMFpxO2OH7EjCkUxfGJu3tZZrBDWkjHMQRX6A+jHsljuN1if3WFpsq9t8
	KEp9a8Zm3W5IkcxOAK6ZuW48mXoa0NdcuaH2rYEsdUsLxmXaAnP3SRBuq5faTxdxLzhhaBDG0Gk
	k5tD1tZmVdm7ddnjLCG6URTQh7Yik4AOUDeqx9iDa8EP/HHRJaSmTAPyxpWdFqmj/gooWuLy+2K
	MXqiASaUkE60j2NeSBg1P9qipxqS/19iy3PJkov7h3YpI9z9nqd32AZjo=
X-Google-Smtp-Source: AGHT+IHZBBGt5sKspmgCfNLehnDSWf+0n62iK2Sq8KrVSTfY8+ZnEykfoNZ0znpWjPtd8Ie+jPvN8A==
X-Received: by 2002:a05:651c:c8a:b0:378:e097:e16e with SMTP id 38308e7fff4ca-3812167c644mr123565041fa.36.1767340326940;
        Thu, 01 Jan 2026 23:52:06 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com ([83.245.248.13])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-381224de35bsm107688061fa.7.2026.01.01.23.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 23:52:05 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Fri, 02 Jan 2026 09:51:41 +0200
Subject: [PATCH v2 1/2] rust: pwm: Fix potential memory leak on init error
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-pwm-rust-v2-1-2702ce57d571@gmail.com>
References: <20260102-pwm-rust-v2-0-2702ce57d571@gmail.com>
In-Reply-To: <20260102-pwm-rust-v2-0-2702ce57d571@gmail.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kari Argillander <kari.argillander@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767340323; l=1349;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=PYqFtCJKewiwotOHkWKODCOViU3vbaITARfsgFWgfPk=;
 b=89gkDf+zZZ6JvqrUEtN9svv3pRzZGZqV8d1YP6ws29DFXx5WFdB/t4HAng0JNcH5B2TDaXUmu
 ki/e0mshDXDCcXPSOYqwQprgpqFr4BYKGEpCkPdJqDen4a9Rbhzk70W
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

When initializing a PWM chip using pwmchip_alloc(), the allocated device
owns an initial reference that must be released on all error paths.

If __pinned_init() were to fail, the allocated pwm_chip would currently
leak because the error path returns without calling pwmchip_put().

Fixes: 7b3dce814a15 ("rust: pwm: Add Kconfig and basic data structures")
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 rust/kernel/pwm.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 2dd72a39acb5..4f683158fc08 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -607,7 +607,11 @@ pub fn new<'a>(
         let drvdata_ptr = unsafe { bindings::pwmchip_get_drvdata(c_chip_ptr) };
 
         // SAFETY: We construct the `T` object in-place in the allocated private memory.
-        unsafe { data.__pinned_init(drvdata_ptr.cast())? };
+        unsafe { data.__pinned_init(drvdata_ptr.cast()) }.inspect_err(|_| {
+            // SAFETY: It is safe to call `pwmchip_put()` with a valid pointer obtained
+            // from `pwmchip_alloc()`. We will not use pointer after this.
+            unsafe { bindings::pwmchip_put(c_chip_ptr) }
+        })?;
 
         // SAFETY: `c_chip_ptr` points to a valid chip.
         unsafe {

-- 
2.43.0


