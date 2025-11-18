Return-Path: <linux-pwm+bounces-7639-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5065C6B0B1
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Nov 2025 18:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A74854E6CCE
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Nov 2025 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA88D349AE6;
	Tue, 18 Nov 2025 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SHdXbM+D"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9AC346FA8
	for <linux-pwm@vger.kernel.org>; Tue, 18 Nov 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487797; cv=none; b=qRet8gJu2aHpBqSSrNY8WpxUE2qbbjQFQc0PGXg28LEDxc+SayITKbpTCGcUkxfvS18jAGmdihh+bSj7Uns7GKz/RPvakwzbeyQEJQ3SeDj3j/dtSBxYaDJ5gZYevwhPXcRcaEnkQEAWnKS3gLiwXUxG3Lv+LkeSBo7aoNEOKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487797; c=relaxed/simple;
	bh=oIj7BI1LHbab5CnzVOti3hZl7tEaf589+lY3XlHR6Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EX+B2PbupmmakOZz7hLv/bKBh3W71cidD4xPZBqtl24ES97drUYEId0exmOCsQIs9pqYX91AM0kZfGXmGxl58DiqJPM3HTXbuGVTcTbGFjFIGveSVh60GX1AqOSfOAu3kqz9Y+OXYQmRTelylasoMmE15n74Lqbp8VyYgbZ2ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SHdXbM+D; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b2dc17965so4713670f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 18 Nov 2025 09:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763487791; x=1764092591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2TOQhq9/NUebQebI2xcMlL9PDdj3FqsNrvxWPOAcGyE=;
        b=SHdXbM+DoT0GeqhPeDGowoh8YSUBIW/M1ntBEx75S4ndvqUpaJQvaQE6NYYDf5V71k
         iNsXEUbeDjXfT4M/pD61bM931p0usPuNaXcssuZc2R8Z5q/gzyr/cW7sFbUZs/hRP3AT
         m3J/8EBoGg363P96vatZJmiWKF2jl9Pe0zxtbuaOoNOrlNxrOtoyaS2BgzrwAi8norFr
         kogrDdrlSdXmfWrO7J+NkjQOUlD+UpLf0V5fKqadKS9e7mkqmG+E9t0pEz9PgbJkwluJ
         LZiME3u1p6n2Gu/xIAZ7eFjoYEVuhi/IwVnpw08Edxj0MNV8exDFmduFdKcXtbOMax9o
         NgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763487791; x=1764092591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TOQhq9/NUebQebI2xcMlL9PDdj3FqsNrvxWPOAcGyE=;
        b=jOlhqu0wguriqsjhNFLApq3mPoiXJ5I731HZ+f/vnQWuMcL0NxH7gj7+XZK1h43BNu
         gQ/oSowosClINFz7XV4DcWWviqFT8uYt1FJW3MekSZyxmBOgY+K28s4BzlZf7BtFXUjV
         RBGfmL+7Hd28JVIL+on6IWSBDnJi++Z7wAAu0XEKa0LPWYXqLMLC9Ajhgwaw4dGYVCtm
         Xe7fKlHLMMk4rN0RGY0bYkBYXsf9BWcY6F1+5ymQQX2m5hCCZn1cUNnKEW6s4p/ApFKU
         mHXDK9cMHVuRPXUlrQfAIfl28CRYdvXGG9J0YQIE9XQajiuFDGYpbiqEiJO7Kkx4uz0E
         ULpQ==
X-Gm-Message-State: AOJu0YynpJIAyMSd2T1uFC/uvm4APBHc+FhvPO+b9YSZnbfx0xAipKEU
	tH0y2Vw8tS9PLggandgBHFb1L2C5oNlW6aKeaM4ql8UDOeJz8ACRdcXs9POIQoixT+evcdSSR+V
	G9QV9
X-Gm-Gg: ASbGncuj0qYiBOTJcY1D1mph4VdQ38prmbf0Bw6UIcM80KGH81URNTg0xS4htpMsvBY
	CkrG6UGJgWa6LBLnvDQ4nip25MwIo0o0yxqoxU4kGCsv5eOiYOXLE0TnrhdjH6NbiqQckHjRcaL
	s1Q2sBQRKctuDUArC8j7vPKaptvqPc9/+1xy2KQqTLJ5FC8u9g0DqzO1Nr2v3WI/qOTmKdsF4Ww
	W0BBREgrn9WKCNHLcZHsYZq69tJO39u/9vv3/uRqIFmyKZ48fery/j78OtN+UQdUoMGycW13AXg
	vH2tQEzJV0Wv9MU7YZ6xFl8+xvPHgmE4EbnZ5ebJ9T/x6tlK1rsTHlgHDG4g8yv5NL5KvMAlK6P
	Kawg82AwAHqKLXMJpQW4gWNQqzz18maTfFLF/zDKE8utr2Lse5aj9EpjBHwv6MJPjLpKuaQ0Rxb
	yj7UcNSfqej4q/Kz7JZwnS1I7WBdtz4DX34jHQvSCiSik0/IkOTJrNuIK660xsKFqeK+ay6en1r
	Y1YoY7JIbbZEGydJpENc22X
X-Google-Smtp-Source: AGHT+IEJ4tBZLVuUh7LHukSgFzWill2oPQ+ipSS7ojnOPYmnhEr7THEN7v+AAfwFvCW29131mcz8zA==
X-Received: by 2002:a05:6000:2890:b0:42b:3ad7:fdd4 with SMTP id ffacd0b85a97d-42b5933e3a6mr18867946f8f.3.1763487791363;
        Tue, 18 Nov 2025 09:43:11 -0800 (PST)
Received: from localhost (p200300f65f0267081cfc29f03d015de2.dip0.t-ipconnect.de. [2003:f6:5f02:6708:1cfc:29f0:3d01:5de2])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42b53f0b617sm32888594f8f.31.2025.11.18.09.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:43:11 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Bart Tanghe <bart.tanghe@thomasmore.be>,
	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH] pwm: bcm2835: Make sure the channel is enabled after pwm_request()
Date: Tue, 18 Nov 2025 18:43:02 +0100
Message-ID: <20251118174303.1761577-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=oIj7BI1LHbab5CnzVOti3hZl7tEaf589+lY3XlHR6Zw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpHLAn1e6DjjpJlZPDote1zeo2WdPwn2zIysZtq ZCXLW29UoGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaRywJwAKCRCPgPtYfRL+ TuPgB/9I13/obGtiNWPBLi8Y6qUhmZRNkPCgMy7wiW2UoVnpTlKnbrdLuHUIj1jIJVsjW6iPBoS VuUmJokSEF7gdGpKJtLnyG6sYUi8DeqcF52gML5P6Uhdq0KP7oonnn8lIqKIPTsWqorrffEsRQy B3zuADWr31Lxpbg4pLHHeAIWFQddS+EZ4UV+3bMOL4Ly3JGehrQT1zgSaekAPC0dWt0EKT1zZA7 /ojoAmsCU0Fb6ep35kB+NRqb/vDuyPvowbtBxMQcqC/TMVe/XYj2fu+ccjpqqHtBqAHKHEZFdJU KJyPyQ25eR67l651rL1KvFqf3poZy5d2d8G5cYMb6B6dAJyR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .free callback cleared among others the enable bit PWENx in the
control register. When the PWM is requested later again this bit isn't
restored but the core assumes the PWM is enabled and thus skips a
request to configure the same state as before.

To fix that don't touch the hardware configuration in .free(). For
symmetry also drop .request() and configure the mode completely in
.apply().

Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-bcm2835.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 578e95e0296c..532903da521f 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -34,29 +34,6 @@ static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static int bcm2835_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
-	u32 value;
-
-	value = readl(pc->base + PWM_CONTROL);
-	value &= ~(PWM_CONTROL_MASK << PWM_CONTROL_SHIFT(pwm->hwpwm));
-	value |= (PWM_MODE << PWM_CONTROL_SHIFT(pwm->hwpwm));
-	writel(value, pc->base + PWM_CONTROL);
-
-	return 0;
-}
-
-static void bcm2835_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
-	u32 value;
-
-	value = readl(pc->base + PWM_CONTROL);
-	value &= ~(PWM_CONTROL_MASK << PWM_CONTROL_SHIFT(pwm->hwpwm));
-	writel(value, pc->base + PWM_CONTROL);
-}
-
 static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			     const struct pwm_state *state)
 {
@@ -102,6 +79,9 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* set polarity */
 	val = readl(pc->base + PWM_CONTROL);
 
+	val &= ~(PWM_CONTROL_MASK << PWM_CONTROL_SHIFT(pwm->hwpwm));
+	val |= PWM_MODE << PWM_CONTROL_SHIFT(pwm->hwpwm);
+
 	if (state->polarity == PWM_POLARITY_NORMAL)
 		val &= ~(PWM_POLARITY << PWM_CONTROL_SHIFT(pwm->hwpwm));
 	else
@@ -119,8 +99,6 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static const struct pwm_ops bcm2835_pwm_ops = {
-	.request = bcm2835_pwm_request,
-	.free = bcm2835_pwm_free,
 	.apply = bcm2835_pwm_apply,
 };
 

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.47.3


