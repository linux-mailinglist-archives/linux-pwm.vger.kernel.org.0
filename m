Return-Path: <linux-pwm+bounces-6899-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254CBB13F5C
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jul 2025 18:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02CDD7A24DB
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jul 2025 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376F48479;
	Mon, 28 Jul 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RGwYGdJD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A21C1F0C
	for <linux-pwm@vger.kernel.org>; Mon, 28 Jul 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718438; cv=none; b=qOqvGtWeKZ5Ub8FztzkVWLYaunEJXEsSbxy2cr0V17F5X7raMfi7r8s4B+bbGko78HC63J0frFJ0eMVjGWogQW/CCPKAcRQIbN/FxEw2A5QqOingZfssSi69HVJcGUoh7QEGK6MeulykhCEWCrdL4OzTzkgaYSEyRY8T37d1sCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718438; c=relaxed/simple;
	bh=r70JoWPBMkSGg8Q7MTFwRHQvEblM9zt7/MoS5rUeNI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5GykQPNPpUsjmmbE/L86cZNBCzdTuz1rlYiueHfjUDlCXhgQjEibK/KVckenQUSPHAEmC9QHz+rQmdV2otJD6TWpV6tr+ifjWJIIRXnd8MuzJizT0XZIhFP5pBW2XGS71WDPFeXoVoRJ5wZEBdPEUix1uK10glcOJ0bvSTd4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RGwYGdJD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso700518166b.0
        for <linux-pwm@vger.kernel.org>; Mon, 28 Jul 2025 09:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753718433; x=1754323233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEkkBMb35T0v1dnQ8fcl1xdudts5aOTCZdXsRa2DHbs=;
        b=RGwYGdJDMlD52pKomCmUdsZk1yY/UWXSUYtpEL3vPco4IWKjFDZZfYgFzurKrqjjbb
         I2/KiNv3l56PGdwKr9YdWRzXfRxIbqUK1nOi7YnhZrUF+zjR5yszo4RoP5haCttvTRmG
         Rh9whiR5eTDxorwaSJ2/EZJsmLnoNZ7PyzPMzg5wD8AoHAURio7niJ988L4wrgrN5ECG
         mk8KKqo0/oJlc9qHT8qAUxbSy4PX29GDVZI8+vC9sQ+pSGxKFpZiYjbM35dWgaCJh8Fc
         2bwskxsRBd/mMjHFoabOB+izsPRS8qPEXpYokCxUmccl/6d1t7dVQ/GyzbfJcKuFoioE
         sJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718433; x=1754323233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEkkBMb35T0v1dnQ8fcl1xdudts5aOTCZdXsRa2DHbs=;
        b=SwqDaVbNYyvpxZwBuuEb6Ryf6pG7wvHVYexORDO1387hQAzN8wVk90qrqF8n597UBR
         qc0p1H1aJgMtJ1fLsJ29xlOVq1hcFiiaMh8iT/0p0lwGqeLssy1w/xRM/d7KAkWgZFYD
         0Fl0zwNQwxCzinfN+Wd5U1RJL0xDpu0WpA5m1eodpwFsgwf79xeHgHnHoDm3P9oGxcus
         Ww08bDEIgxiX1irsXwfvXL4nc6FHlnzQ2fnR/cCu2zOOI7HioCkSKMf9kxuTBITQ3LC8
         5qnm+ufT84LbsQ0YS0ZD36Vv1+ZMSboEeEQ0kRmyfPkgqb1bBYB8vd/XqgeTgw26u/2A
         Agsg==
X-Gm-Message-State: AOJu0Yw2L9r2IdWcOuNKSiaCfmxMfZ8tqRw5xSnDw1UdJzLkusCwSBxk
	LvD86zTsF4DtCLwkQbiK9iM46talHz5sESgZTRljTw4/spn8yjBC53ScEnubBl4agZc=
X-Gm-Gg: ASbGnctpd1PncNh3BDZE4/7QqujhmQ9fGBA5t1yAxwA4Vwk56BdV0XicjJZ8QmDY+Q8
	9+ASXs7IUCSznJxcxtsJ8hqWKnF1hB/4XUgD7uJNW1FQdXYRsR8tbnCssSIj+Gpw5Y47BCKWFnI
	GLjL1yhPTuMVHAj2z0lTKyBD2LHD7flw1Bh1txcr4m463B3syNA3XtJAi5Rbr7JakJOHykHb/XE
	mf7MrQjr24H3OgoxFsnUdmvMuEYz8ya0qG0nYgx4zpP0EZw/0c55bBlQt6RIszVmSL8zTetkfO9
	5rXY55iCc+S3eI2djjIzlpjjL4EngQ6FIUP7VP4jA2QZAgv9qpYAf8v3EFTVxx8a8Mzvq4MSDfc
	504YBMkvrY1w1lwNV96Lj+w0WZx8qrcTtnlrfdul6hilKvTPAhThVm8YsqFTmk12W/WnsSy7Oq6
	s=
X-Google-Smtp-Source: AGHT+IGjaAaodAuMnxX/es03owJK/l/UBs6JxVTwTZFVer5/mcNukBpbQFEgvLPCs5Jmb9MaExk57w==
X-Received: by 2002:a17:906:9fd2:b0:ae0:cf01:a9ad with SMTP id a640c23a62f3a-af61e533cecmr1307265166b.40.1753718433142;
        Mon, 28 Jul 2025 09:00:33 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af635af9555sm430343766b.133.2025.07.28.09.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:00:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	John Crispin <john@phrozen.org>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/2] pwm: mediatek: Fix duty and period setting
Date: Mon, 28 Jul 2025 18:00:18 +0200
Message-ID:  <6d1fa87a76f8020bfe3171529b8e19baffceab10.1753717973.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753717973.git.u.kleine-koenig@baylibre.com>
References: <cover.1753717973.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2307; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=r70JoWPBMkSGg8Q7MTFwRHQvEblM9zt7/MoS5rUeNI0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoh56X9/dgc+Yosa6Tl4O9n7Tg+UrDenhDziD6r +ETX6Z6qEeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIeelwAKCRCPgPtYfRL+ ThqWB/0eM5OcaIMptlstLjjW23eDAAgVQ34z+Uk94Qqqs6ur0aQDlkd7C8D0G4xqX4GpiTGvIZA pjociRDE8NF9wIqVlQRViI6OuIqWdj9hkbXoJIEirhAJ1GshDOnBuMnJ4XOJpVKnA0EHWkefV3V TFPsa0XBR4FPukmctm7mNvqwG+uhpCjGO2qonmjbjiyh5sr1/3y5cE4gODHfNX7gECeGq45s3G/ 9uQa9A1CO+CL50BuE8wmZJ4E3KCmZKketFUGwRAkLopDfqUZnN5zzBsE3xU6ZhVN1fr/HYjXG/i sCpRmbFQ9zmYIgeMGbkpH5ZJExiKiGibWgVdsJAltccRH3+l
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The period generated by the hardware is

	(PWMDWIDTH + 1) << CLKDIV) / freq

according to my tests with a signal analyser and also the documentation.

The current algorithm doesn't consider the `+ 1` part and so configures
slightly too high periods. The same issue exists for the duty cycle
setting. So subtract 1 from both the register values for period and
duty cycle. If period is 0, bail out, if duty_cycle is 0, just disable
the PWM which results in a constant low output.

Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index b6560e52c803..e4b595fc5a5e 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -170,7 +170,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -193,9 +196,16 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
+
 	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
+	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period - 1);
+
+	if (cnt_duty) {
+		pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty - 1);
+		pwm_mediatek_enable(chip, pwm);
+	} else {
+		pwm_mediatek_disable(chip, pwm);
+	}
 
 out:
 	pwm_mediatek_clk_disable(chip, pwm);
@@ -224,11 +234,8 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (err)
 		return err;
 
-	if (!pwm->state.enabled) {
+	if (!pwm->state.enabled)
 		err = pwm_mediatek_clk_enable(chip, pwm);
-		if (!err)
-			pwm_mediatek_enable(chip, pwm);
-	}
 
 	return err;
 }
-- 
2.50.0


