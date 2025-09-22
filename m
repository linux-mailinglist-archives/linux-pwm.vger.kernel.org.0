Return-Path: <linux-pwm+bounces-7338-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A2EB8FD02
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Sep 2025 11:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC6D3B89A7
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Sep 2025 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5948B27EC80;
	Mon, 22 Sep 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tkKO+jN6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0B26E715
	for <linux-pwm@vger.kernel.org>; Mon, 22 Sep 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534219; cv=none; b=mmptS6zWeHh9UFbj2orUNozCvJmx/+r16cwhqTFMLbGjgCQmqOzXvDWIyUhf8kONE7tvtoOnoXX1hkr3mEo1gwC6E921WOaPVBOHtvoftO3C8wg8veyIm5gS8+iOvkADgdZ0rT2/UoHD+txEi2JXOq8VJsSxzTPsnU7zVS/5AZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534219; c=relaxed/simple;
	bh=u14lggk72SgVLq5MxcIr28etV1XylVlNq3Nx5pfJi6E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mf7yWvqDCeHBMr6Ala3Cn6gkxdpyOvl9LC1JFFb6IDxBLo73uonq+g+Mgaxk+9RcC1PNob/O67XqvLz0f+UdL+4Z4yBPUyYZb4zsz/O+Ny9s2+qEe4T2eIbS4HQaii76+nzdxxO8Q82WGNQ/bzad2w7PAJ5CvYZLzlop4ZX8lEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tkKO+jN6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so2926634f8f.3
        for <linux-pwm@vger.kernel.org>; Mon, 22 Sep 2025 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758534214; x=1759139014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfTu1mTwwPxyRwfVhpVW2utSO2AEnCaj9LpNZ42SIHc=;
        b=tkKO+jN6fpZPPuz19CpVcOQ9RkuFVV3nLijkzPPdqrYdmjo4qK3m+jtomAwbG2R4i9
         HCLZS1dThsZFi3EhFlYMCwQHK7/CIKmt3WdimCsMeH++muIJVprSndcOSg7yR92nNtBm
         PtBWP7N5o1DBfY0m2i8xEvD89HeNA84GhFZReYEJNa3kukR7vxmDvcwhhiA6eUAgHWLD
         9aJJaDaf+aj33ppp3sgugmEztXDPecZfNCqQbbmdYLrWxtTRidXhIMQGg316bEDfS2TZ
         6rGh1FoU1LEbafgzU2NVV8j3qh66M76ZclJ6JF7YYMzyG0BPWMhjTbCn1WPSzRpJZTB0
         wtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534214; x=1759139014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfTu1mTwwPxyRwfVhpVW2utSO2AEnCaj9LpNZ42SIHc=;
        b=Pn9KSAMklFlcefnFTWSlWg75PqB3xOBONDl+zm7jPZLAjf/LpgVXSxEy0M4KNUk2Xs
         DM2L9+bXJFDDT0XGO93bnO2KrKQsrx7hPJMmNCTMTa1MaZaUGpxexPtLadhRMXR5Plqz
         FOj/rWVpmNnU7Ac1e1HXmjaClA93Brbxd8jg0nO57VNlULrFbqV5KdCLfVISmbvC5AM9
         yMwjq2ksPT+lG4u1suCR+9+WqafEbVFzQhIQpfY5i8DqmsB228yfDZYVpbwiEL8enWVa
         MAk56mv7uf7cqAyucJevaKuB+YrmwWDLV8pLrQxNwqFckfRmNhza/UZw8AcARg81P493
         /lkA==
X-Gm-Message-State: AOJu0Ywk17qFrYVUn7ANH4fTXbm4SwQ8dcpMNXjapF8NMVODvMUnKboy
	lRMolG4ic7zN4G4EtjSm8iTGfdFGS1fHURGqIEAf56RI83spzA4AU1Hxpo5ZLUcmqWqljq3uIPg
	6jy7s
X-Gm-Gg: ASbGncvJRo5Ak4RD03heCmYTgkwbSrRW2VIzpbDZVQHh3bwhHJuEP9A5IRB6UfVkh+a
	FLaBUpLBYLiO11KhyO7NOcztP22N8V7OMIpYF27wnsySeSujp4Sep7JDsijYYtPDvdTUfFN/Pnc
	xJ9YLO87rZUEGQ21H6ZSNOX7STQVKlxiQ5IcUkW6CioDcMuFRwMtjXMkH5t5ksHPFGBLbyqQlkt
	ww5b4/0+hWLt73rJxDI8pCTZNpGFDGfbMcXTJhri3DY/CEbcx2XjwZW/IBEHRo4oJkjtz04kQg8
	vRB8JeYfm+yhG7aa/Yvoj5XoLzALrnWfPceL2QGJU4Z6IQywwn//1WwWpp43XT14OgGa7hdDzQV
	TLoAPULjLrFDYr1JN+GlE/DInhwYYN2plwSFdGiQdf5ir1mOzGYF5zURfSUdYPdeV
X-Google-Smtp-Source: AGHT+IGKgDeOCnxSxEaLEVfeuHMLXp20OoBCpJ6pdVsqLQ6SfEYOrccPnMmm+XQF+eGThm7Vaizd/g==
X-Received: by 2002:a05:6000:310f:b0:3ec:d7c4:25d5 with SMTP id ffacd0b85a97d-3ee8600f73dmr11028142f8f.50.1758534213655;
        Mon, 22 Sep 2025 02:43:33 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46d1c97a87csm39986415e9.20.2025.09.22.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:43:33 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Drop unused function pwm_apply_args()
Date: Mon, 22 Sep 2025 11:43:28 +0200
Message-ID: <20250922094327.1143944-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=u14lggk72SgVLq5MxcIr28etV1XylVlNq3Nx5pfJi6E=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGjRGkCg3o+lEGLEy4P/0LFWY7y4aSbAfy8cwJogSK4rN/f5b 4kBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJo0RpAAAoJEI+A+1h9Ev5Oya8IAJJD Sg7lGDMjSmkA0mxfpz2aoWgEPbgtEf1dK6XGHdY2/gnRt9Ltmcn+FOv1C91J+ctJCAioA68AKnM W2SxNsZDrajW5adcZ3HiDuQ0EsU/NKwCqfcZig5IdhsOCxCz6nZOlKL1JG8Is12/CHyeOkpi2aS 1iTcxP3m9OiKwU2hTwDcrA6lzQYZaB2rCNROKJD4y+pQyTTXXxKLmGwsONXeNtRRN5zriTcBrdq gTQQ/c4XF6bm2FFZO7cohwAuNRhsO088k0kCwoi90auhGqil7Kzt7BVE/5DdtjSmidc7pwfOJ8j le6+Qn9BY43/VFq9SHLl9cw5832Y6wdVkip5TM4=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The function pwm_apply_args() was introduced with the concept of atomic
PWM configuration and needed for drivers not using this concept yet. Now
all drivers are converted accordingly and so no callers are left which
allows to remove this function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

as of v6.17-rc7 there is still one caller left
(drivers/video/backlight/mp3309c.c), but commit 2720c87b7621
("backlight: mp3309c: Drop pwm_apply_args()") that is currently in next
scheduled to go into v6.18-rc1 removes that last user. So this patch
isn't ready for the upcoming merge window yet.

Best regards
Uwe

 include/linux/pwm.h | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 8cafc483db53..164d82cca215 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -608,39 +608,6 @@ devm_fwnode_pwm_get(struct device *dev, struct fwnode_handle *fwnode,
 }
 #endif
 
-static inline void pwm_apply_args(struct pwm_device *pwm)
-{
-	struct pwm_state state = { };
-
-	/*
-	 * PWM users calling pwm_apply_args() expect to have a fresh config
-	 * where the polarity and period are set according to pwm_args info.
-	 * The problem is, polarity can only be changed when the PWM is
-	 * disabled.
-	 *
-	 * PWM drivers supporting hardware readout may declare the PWM device
-	 * as enabled, and prevent polarity setting, which changes from the
-	 * existing behavior, where all PWM devices are declared as disabled
-	 * at startup (even if they are actually enabled), thus authorizing
-	 * polarity setting.
-	 *
-	 * To fulfill this requirement, we apply a new state which disables
-	 * the PWM device and set the reference period and polarity config.
-	 *
-	 * Note that PWM users requiring a smooth handover between the
-	 * bootloader and the kernel (like critical regulators controlled by
-	 * PWM devices) will have to switch to the atomic API and avoid calling
-	 * pwm_apply_args().
-	 */
-
-	state.enabled = false;
-	state.polarity = pwm->args.polarity;
-	state.period = pwm->args.period;
-	state.usage_power = false;
-
-	pwm_apply_might_sleep(pwm, &state);
-}
-
 struct pwm_lookup {
 	struct list_head list;
 	const char *provider;

base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
prerequisite-patch-id: cda85684d26aeec0471141f107a0978da7190aae
-- 
2.51.0


