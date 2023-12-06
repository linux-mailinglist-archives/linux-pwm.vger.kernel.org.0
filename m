Return-Path: <linux-pwm+bounces-329-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BFF806E75
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA766B20EC2
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCEE35880;
	Wed,  6 Dec 2023 11:48:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716FFD5A
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOA-0006N9-Va; Wed, 06 Dec 2023 12:48:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOA-00Dwtd-IG; Wed, 06 Dec 2023 12:48:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOA-00FQyq-9b; Wed, 06 Dec 2023 12:48:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 036/115] pwm: tiecap: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:50 +0100
Message-ID:  <3b43a4cce6061c6dc64a3d28b6986ae4d7e9d1ce.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2801; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ppATWHEHhEGXwkBa8MbiFsBDgYN2JkTUM2rhAJWXqHA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6KJCWp2WDXPL+oT2N6Aa5z7kpLLnPoy+EL7 cc7m8IB9WOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeigAKCRCPgPtYfRL+ TsFQB/9A6obPv8XBEymgque1vNX6JkagLSnNJy4sonvXuduYux197xHo2mMh4ETggbYWY49kBPG l34tpQ3A7ZR18qM46O1TRZ6SteVSwlPEZvTMLr2J6P7uN+JuFGdLYmZtUyBibrsQ6GZD6v/zGuY 8S7uIQVCOiR0TboQaT/m5gnPDiF5KsdyJYDt15F0D1YvEgkUo2Y9y4nm0SqK27sWuRW/YM+LZiT U2DfKL+Lj8oAn9Y3qkcICOMrXj+dICtXMuo7Z7Qp1p9a9lg3SJV5z2syNr0FxC7V53gsTH+MkET n+VPDRy4QsjSpnAFOjW+iRRJYuzd8txxVbNf7+YcLSiJ4KWB
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiecap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index d974f4414ac9..8c4f67774f24 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -70,7 +70,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		duty_cycles = (u32)c;
 	}
 
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	value = readw(pc->mmio_base + ECCTL2);
 
@@ -100,7 +100,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		writew(value, pc->mmio_base + ECCTL2);
 	}
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -111,7 +111,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
 	u16 value;
 
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	value = readw(pc->mmio_base + ECCTL2);
 
@@ -124,7 +124,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writew(value, pc->mmio_base + ECCTL2);
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -135,7 +135,7 @@ static int ecap_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	u16 value;
 
 	/* Leave clock enabled on enabling PWM */
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	/*
 	 * Enable 'Free run Time stamp counter mode' to start counter
@@ -162,7 +162,7 @@ static void ecap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	writew(value, pc->mmio_base + ECCTL2);
 
 	/* Disable clock on PWM disable */
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 }
 
 static int ecap_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -271,11 +271,11 @@ static void ecap_pwm_remove(struct platform_device *pdev)
 
 static void ecap_pwm_save_context(struct ecap_pwm_chip *pc)
 {
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(&pc->chip));
 	pc->ctx.ecctl2 = readw(pc->mmio_base + ECCTL2);
 	pc->ctx.cap4 = readl(pc->mmio_base + CAP4);
 	pc->ctx.cap3 = readl(pc->mmio_base + CAP3);
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(&pc->chip));
 }
 
 static void ecap_pwm_restore_context(struct ecap_pwm_chip *pc)
-- 
2.42.0


