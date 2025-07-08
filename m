Return-Path: <linux-pwm+bounces-6782-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED190AFD527
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5197D480D4A
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FB02DD5EF;
	Tue,  8 Jul 2025 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bbq9SiIE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D927A2E1722
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995151; cv=none; b=CYvH8YuuEg3cQn1+gXjBBTNFgYbS+bSR8P8O0kOH8HZzfkGihFNnpUPgVXi6IKPRQvDyGk/9rZgIdO4toTcm1GNvalHaDJxLrIwFlG2ZGmaGOMXMDNCe5eB2pMU9HRAJj8cGLErl4fcZw1vFYRpO0X6BW5ovd/napMvg/CX07Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995151; c=relaxed/simple;
	bh=x/kV2pUi1Vzzcz7I1TfeXDKd8gGc8t2w3EP6DIPGv6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiQ9F63QNjpc0ozBZjMXwOpthdHiRroA5tdto9pvKpgCqB1+dijvQhZkbQFIzFaynSRZlBYoqOC7NVQCtBH9xqTuA2mMsn6wcvjvIr4HCUY7JMsqE7a76ye2lVMqe6boWeywm9I33zYdx9Kv2Pb+WY3axTXxSqpRaW78cJGJFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bbq9SiIE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so6337476a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995147; x=1752599947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJy/L3KF70Zdiqqmji/VZQ4AG3AZxAjhDs+q1gVtfqM=;
        b=bbq9SiIEdmbm8/3vXDKu9yEfYk8ts9SSpVjAdHysCYBIDEf+9FaF/O54brwXrdRNhM
         tSVElZFi91HT5YfhkZumEQ7FbAbGBtC/Vz/5LgVRX/wV3Zq80jbRUZw964nOmj4Di9b6
         deqdXk7B/X9jwitxNc39m8ksvJLsdO6/w6NteUcrcgi+2SCsb0WZ+bOktkvTHeBYjlco
         7dk3F316xxP9IY6nJHMjVP0Ez/1DyY1TntbzCr5y1NiO9LnMInwxpw5OKu5zDj1U5nuo
         wjfoAbjSvdxqzr4LSIpJbjzfUzBmw8jM3dkfLhmwsrgvJl72AJEf7Q3Aq4SyefCIhBbB
         7y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995147; x=1752599947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJy/L3KF70Zdiqqmji/VZQ4AG3AZxAjhDs+q1gVtfqM=;
        b=XkpWKPE4GriWaAsBRZWJ/M9FaxF1pJunzFB5Cve+bouwFJeRJMxI/x9WTJ4iLV57IY
         /5CxBaB67mu3+gGQbjF0N4vzrcVjfI9ipegB8lOmgvGlakB6EbKwlSF4uMcwGJMndUfL
         hDQuM5XpydHaJ+A9753bbHUkUZ/1FLjwQtV5xgYQl9dx10PeYSEIVJSP/HZKrKUNXnNg
         Ztm1ANGHlaOjYWVV+DQLjvFQz3DETVkSTpbZuaSKzb7JFg+Aj9haQkexgfkEiTXY0xpm
         6LMHIQO7dXxHd00Ig2UjCK/vYHx7nUfyLT1Qe/33AsyKE08qvmM/Csvrmi0bCIL1UqX+
         QvVw==
X-Gm-Message-State: AOJu0Yz3YEayFo7Cl/SU5dgH+9I8IxoQMZSo+QK061P8TfGMp3wrCUhB
	bOULBCZGz2gnTXNijFFw46Yge829U3UdOH36ljupGSp9ZT+0/fjykulKxYzo83Y2XJ0=
X-Gm-Gg: ASbGncu4hkCoLHijDcOIJ4J6APzT7+5lsbPU0AhjATmCQCx+pBKpw0RYij2+mOAFISV
	l8Hm1S9Cen37wc9OdteeqBr/od1I4P8Anv83N/58PnZFSNTM4E7Ghotq9rICQ7EaCuaqkzFsglL
	U3MXUQWnE4aHO+EixS8SgzQLbBEhfR7vlp/nfKljMnkAg5besFUs0F5ZwKea/6g/zl279SLv9lA
	/pq9Qump1r7dbl2it1OU5fubIMWYHTzKnCRjeRPabi9NVIb5ZjrdDAijJf/XkwHy/n5o3bg49CV
	MkmQ9hA+mGT24Tp1SJEMd9zMIoGY/NEalIFG7PNM06MzSlPboJufmyqDWXrLOi9Ub5DXO5QWFGi
	QjCepuQjoXGLffhnjskDU4DL8x7Px
X-Google-Smtp-Source: AGHT+IHroZ3E2ueYcv/ykrcydfGYdpV+n9RhqQG8ovV8RP98ja814/uxg/sHrKNwX279I/CMgKWuSQ==
X-Received: by 2002:a05:6402:270e:b0:601:d77f:47d9 with SMTP id 4fb4d7f45d1cf-60fd64e4342mr13991766a12.5.1751995147361;
        Tue, 08 Jul 2025 10:19:07 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60fca667676sm7535174a12.7.2025.07.08.10.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:19:07 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 3/8] pwm: mediatek: Rework parameters for clk helper function
Date: Tue,  8 Jul 2025 19:18:33 +0200
Message-ID:  <bca271889c7ccc2ad21528ddcaeadd3ec8c64a7e.1751994509.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
References: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2960; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=x/kV2pUi1Vzzcz7I1TfeXDKd8gGc8t2w3EP6DIPGv6U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVLwGKq2tDc2GXhlZ576n8L2IgZ0AoIKBUxhT LRdiZsNW7KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1S8AAKCRCPgPtYfRL+ TjucCACta+Vji7mCKuCdVypWv9+EdHf31FpXE1Q7z0Lsn/2cRsPnamnnC/5YX7X/vHmYt5vmbiV U+irmzTAb/DmrKZPtcyUBDaNIBURYwbhFD+aroOi1gScrMZ9LZcGmPV0F4u9q/NLlCptqNIhGrD MFm44+cBdVEmghdxBUQ4jM/OgIl7/inks2r8ftOX98kJX8ozTbrqs/5ep0UzQyJYi8Qcg9lh1UV 0L4NJ9l7UZYZDvR64+g6+tq9s9hbMAZY8b5DGy2UfGPpa0kol4UXG4+VIvIIoBODtgxWZoD5KIS RwUDEPJA4ZmGZuO3WJwt2402rF2hwCh/NTT0hVgLPKSqiF4x
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Convert pwm_mediatek_clk_enable() and pwm_mediatek_clk_disable() to take
lower level parameters. This enables these functions to be used in the next
commit when there is no valid pwm_chip and pwm_device yet.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 4e2a27b02c80..8cc61a835cd5 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -65,10 +65,9 @@ to_pwm_mediatek_chip(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static int pwm_mediatek_clk_enable(struct pwm_chip *chip,
-				   struct pwm_device *pwm)
+static int pwm_mediatek_clk_enable(struct pwm_mediatek_chip *pc,
+				   unsigned int hwpwm)
 {
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	int ret;
 
 	ret = clk_prepare_enable(pc->clk_top);
@@ -79,7 +78,7 @@ static int pwm_mediatek_clk_enable(struct pwm_chip *chip,
 	if (ret < 0)
 		goto disable_clk_top;
 
-	ret = clk_prepare_enable(pc->clk_pwms[pwm->hwpwm]);
+	ret = clk_prepare_enable(pc->clk_pwms[hwpwm]);
 	if (ret < 0)
 		goto disable_clk_main;
 
@@ -93,12 +92,10 @@ static int pwm_mediatek_clk_enable(struct pwm_chip *chip,
 	return ret;
 }
 
-static void pwm_mediatek_clk_disable(struct pwm_chip *chip,
-				     struct pwm_device *pwm)
+static void pwm_mediatek_clk_disable(struct pwm_mediatek_chip *pc,
+				     unsigned int hwpwm)
 {
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-
-	clk_disable_unprepare(pc->clk_pwms[pwm->hwpwm]);
+	clk_disable_unprepare(pc->clk_pwms[hwpwm]);
 	clk_disable_unprepare(pc->clk_main);
 	clk_disable_unprepare(pc->clk_top);
 }
@@ -121,7 +118,7 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u64 resolution;
 	int ret;
 
-	ret = pwm_mediatek_clk_enable(chip, pwm);
+	ret = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
 	if (ret < 0)
 		return ret;
 
@@ -168,7 +165,7 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
 out:
-	pwm_mediatek_clk_disable(chip, pwm);
+	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
 
 	return ret;
 }
@@ -179,7 +176,7 @@ static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	u32 value;
 	int ret;
 
-	ret = pwm_mediatek_clk_enable(chip, pwm);
+	ret = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
 	if (ret < 0)
 		return ret;
 
@@ -199,7 +196,7 @@ static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	value &= ~BIT(pwm->hwpwm);
 	writel(value, pc->regs);
 
-	pwm_mediatek_clk_disable(chip, pwm);
+	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
 }
 
 static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.49.0


