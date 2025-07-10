Return-Path: <linux-pwm+bounces-6816-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7FAB00905
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 18:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685C95C42D8
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595872F004F;
	Thu, 10 Jul 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rNfc9Uyc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85D271441
	for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165439; cv=none; b=nMrUbHAcY44JWzek91dqi4MrrEFuQ/PUsT8RHofXrBNvX41pfnPB6qRLEwIT5MD4/jPRRV/c5MjtHxGiHlwYcYBT00ZzJHA1XB2kNTrWlNsQqaaXhqsAz9hyiITQai1ynKmDDKxfYETxI+zCUpDZwTn5wJa8NPVrXAmLd+Z6wfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165439; c=relaxed/simple;
	bh=jOMELxbdXu94+iU1SXke2q4/fB9rAtm8W7mQtcZVjSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UOLp6M3Jw8iRTzO6roASSv68rlmlnrGGzfH8WErArYuV+9bbM6rERYgMZm3mFlDWOl4mtTLrefMjpda7pLB8xSFJRIoT5KRFCrGWdgUCHmUo1ZnfJ6iZvwhXfKrpYQUSG/uNDtiHXRMDvhbA3BXxapcDE8fP0Vc9iBfLhruKdfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rNfc9Uyc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso225244766b.0
        for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752165434; x=1752770234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EXXln8ztUf98iIGf/7dfBRdET9nYoY4W5NiVmN7viz4=;
        b=rNfc9UycF36N2QuzRgnAPWCfvvXPXoejoZFjOeazkieXAUg0hBHDY3XOZEaJnm77WS
         aWCMFbdXn0+tc87FsCRtrf22cRxWpxVSh3lwFJXAhYjmynqd8l+d3nUu1IbQKWRqBeZ9
         Gm67Hi0hJNLgeHCL+38NHsz9lmSIWxuQBhKDgRyNmxXaWtl3tMSB9cntRnJWaqu6Z4E4
         RWykATDjEbncBRyoeey0nDDXRZkX7myAvcRwTKS+hXcXR07t7Hv5kg1aFzjzRtQpSAgS
         0S9c7SO6AnwOOqbHUpJ7oYOuRBXsoir+SrI8LUDudJqOtHyTEDyfTm/BM8hIbRZaCbUX
         S46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752165434; x=1752770234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXXln8ztUf98iIGf/7dfBRdET9nYoY4W5NiVmN7viz4=;
        b=HNKaMCYBJ/RFgLim9c9YzdWNV/0j6FlSnNbLM6F5VJ4hKZ+zYxCBDWpZUvJDMlTutP
         cyq609eLzM19Yo1fsbfR/8IiykcMYBI0UWhoXPm5HZp/UPvD+dEcIgrjxna0+mI2HQL3
         ZqrOHRvk1GB9PphRxL2aneZMQ9ZAgdrTgB45AB8BwO6lOGYwfpXFwANxn6/SD7tucS5i
         6KzTTzL3I6jgkajVyr8zr2eFqdeVJWdjIDB1gh601a+eTOXVnOYVTm/mrnqypUdMGWOO
         dg5S2EAvQq9I/aMFMos7VFQYkd0cqQFfyi+o/V190Tw52V4zLMFLtjXCu6KP+8Ko/T1h
         0syg==
X-Gm-Message-State: AOJu0YwnvwqwWOqBsoXl0ZH+JlehoR9dekk2lQ8smBIRXALFQEcJ4vuq
	rsvWhQ39ZvuM3nP1iAHuO+ba8TYzJ2wwZwPja6ZrkS+Qu8MWikFVVTFvRjNPzhWnEIg=
X-Gm-Gg: ASbGncuA4YQ/flLyGxvXtUA4s7WDJNEntAtiMaivpAZgw2GctLUVPLfz0uYp1aalI1q
	9N+uuitdSP6ONUItpm9x9qcxRLEIJsbJTBWKY/b6Dc/RyexqyHcXU4cjrZ5ehFwSkDqlAwCjZG3
	j5oHr+KOq4d7cYSeWDnjdShPsn7y5GOtvpUBloN81WfQzMbia9Lw2a3+ImOZiEX8LdRNlijYV5Z
	tBP2JNsRbEyQ/yD31yL4X61cwMKkcNfou/qD51X8kUV8ULOLaKYmfG+N8jIF4dRWjvzRuHCqRUz
	DzUV6IjprttfNdMXCbcaK2uIJlXP/OzLzRGy88eecvdoSfj3xVQUWOLbu4kvTJqMN3yMmLPi3oi
	PpVR4Y9uAKuWsGCpwA9gf8Y/hvzwG
X-Google-Smtp-Source: AGHT+IELCUQ3D7o2E5fa6UZqXD1pU9+ZigPXm/NvY6HpZba0l8NVyN/8SJFdzxrZo+ZkOm2dFqnVfg==
X-Received: by 2002:a17:907:84a:b0:ae3:c777:6e5e with SMTP id a640c23a62f3a-ae6e241e145mr464296066b.19.1752165434105;
        Thu, 10 Jul 2025 09:37:14 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae6e82646a5sm159267166b.90.2025.07.10.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:37:13 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	John Crispin <john@phrozen.org>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] pwm: mediatek: Fix duty and period setting
Date: Thu, 10 Jul 2025 18:37:04 +0200
Message-ID: <20250710163705.2095418-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2748; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=jOMELxbdXu94+iU1SXke2q4/fB9rAtm8W7mQtcZVjSc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBob+wxnYMcBKyG/Wij6Oow0CKXmGRmtySGPvJB9 Ogiq55xVeyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG/sMQAKCRCPgPtYfRL+ TqNfCACtwiv10W+Q7wOKif88ZIoxirsO+zClSsoYXkMw4ui3aWkEWGIEHio7LkX3Xx4MXI7yhj6 U+VvShsnQpqAq1+QKAxxxFYZ3HqI6/KjTXMf+vN37DMZrQNP8Ulvr3eiPOtQ8Sx4a4TNJMC1Yc2 aamAnmOd8eCg166EpsBGABrOaSw6oWa0kjmv593gDCcF+uHn6fMd0j9S2MIrMCF1sELwKMp0g6k PVbr0pGUHUv6lTuJ7Ngdm/nHSOYMKlpBAYKrC4uYt37YKV2H5HDD//3WAl162g0CuPQes69OFGH ZeVRLJyWMgOXqjanoT58DURN2ijBnhHuV7fNKzl/sHYRu7Ba
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The period generated by the hardware is

	((PWMDWIDTH + 1) << CLKDIV) / freq)

according to my tests with a signal analyser and also the documentation.

The current algorithm doesn't consider the `+ 1` part and so configures
slightly too high periods. The same issue exists for the duty cycle
setting. So subtract 1 from both the register values for period and
duty cycle. If period is 0, bail out, if duty_cycle is 0, just don't set
bit 15 in the CON register.

Note that the handling for duty_cycle == 0 is only based on
experimentation; I don't have access to the documentation and so not
setting bit 15 is just a guess that seems to work in practise.

Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

given this problem is more than 8 years old, I won't bother Linus with
this patch before v6.16, but still add a Cc: for stable when committing.
Would be great to get some feedback from people who have access to the
documentation to confirm that the bit 15 handling is sane (or propose a
better alternative).

Best regards
Uwe

 drivers/pwm/pwm-mediatek.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 6777c511622a..80e322f02512 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -150,7 +150,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(resolution, clk_rate);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
-	while (cnt_period > 8191) {
+	if (!cnt_period)
+		return -EINVAL;
+
+	while (cnt_period > 8192) {
 		resolution *= 2;
 		clkdiv++;
 		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
@@ -173,9 +176,16 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
-	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
+
+	if (cnt_duty) {
+		pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
+		pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period - 1);
+		pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty - 1);
+	} else {
+		pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, clkdiv);
+		pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period - 1);
+		pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, 0);
+	}
 
 out:
 	pwm_mediatek_clk_disable(chip, pwm);

base-commit: a582469541a3f39bed452c50c5d2744620b6db02
-- 
2.49.0


