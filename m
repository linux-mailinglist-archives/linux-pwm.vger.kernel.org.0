Return-Path: <linux-pwm+bounces-339-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B60CE806E81
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4603FB20EFE
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD343455C;
	Wed,  6 Dec 2023 11:48:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D9ED5B
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO8-0006BJ-8s; Wed, 06 Dec 2023 12:48:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00DwsW-QJ; Wed, 06 Dec 2023 12:48:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00FQxf-Hh; Wed, 06 Dec 2023 12:48:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Paul Cercueil <paul@crapouillou.net>,
	linux-mips@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 019/115] pwm: jz4740: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:33 +0100
Message-ID:  <e52d09b461b13e9aaeb989ceeaf2360ec66720ac.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2494; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Q/T4RqrA7nugEcKTaYZvDEjZxWPzehWomsMNLs5V/yA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5sQAXPvNjOV//InU2yTesi3vpIj0WoRjNHE KpC58IR56aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBebAAKCRCPgPtYfRL+ TtTsB/9fcjwbaPTFrgtvXNxgwMmx1nlywpIf9ksjURP3x7oxf6n6ZviGxrdOimueK8DOKQscwvu vkFyrwF+0QygOxtP88UVPnnFXDXwcJHozXMQZnQTgLmNzYXzqDg27NPYkk7eN5NZtFEGh4nZsKg V2/Z6GnTASIlHVLHU2tQLi17oz6227zoJLdi9Mqn+G5h/nrrT1kLyeQ6wCtVTVOwj6JalNHwp/I i7WitrdN2fHXOoeLCkU5kBjdalm2/TeTvSqqrEFa9vh99fybHPjtpx1ASbYM1wWEjmFEiLj/X1s z9Wj0BbTVPL+NtY4SGbIQzsJvBISTapiS6+o4FWGG95z+/cA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 80dcff237a15..36763134cd87 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -35,13 +35,12 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 	return container_of(chip, struct jz4740_pwm_chip, chip);
 }
 
-static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz,
-				   unsigned int channel)
+static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip, unsigned int channel)
 {
 	/* Enable all TCU channels for PWM use by default except channels 0/1 */
-	u32 pwm_channels_mask = GENMASK(jz->chip.npwm - 1, 2);
+	u32 pwm_channels_mask = GENMASK(chip->npwm - 1, 2);
 
-	device_property_read_u32(jz->chip.dev->parent,
+	device_property_read_u32(pwmchip_parent(chip)->parent,
 				 "ingenic,pwm-channels-mask",
 				 &pwm_channels_mask);
 
@@ -55,14 +54,14 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	char name[16];
 	int err;
 
-	if (!jz4740_pwm_can_use_chn(jz, pwm->hwpwm))
+	if (!jz4740_pwm_can_use_chn(chip, pwm->hwpwm))
 		return -EBUSY;
 
 	snprintf(name, sizeof(name), "timer%u", pwm->hwpwm);
 
-	clk = clk_get(chip->dev, name);
+	clk = clk_get(pwmchip_parent(chip), name);
 	if (IS_ERR(clk))
-		return dev_err_probe(chip->dev, PTR_ERR(clk),
+		return dev_err_probe(pwmchip_parent(chip), PTR_ERR(clk),
 				     "Failed to get clock\n");
 
 	err = clk_prepare_enable(clk);
@@ -149,7 +148,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	rate = clk_round_rate(clk, tmp);
 	if (rate < 0) {
-		dev_err(chip->dev, "Unable to round rate: %ld\n", rate);
+		dev_err(pwmchip_parent(chip), "Unable to round rate: %ld\n", rate);
 		return rate;
 	}
 
@@ -170,7 +169,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	err = clk_set_rate(clk, rate);
 	if (err) {
-		dev_err(chip->dev, "Unable to set rate: %d\n", err);
+		dev_err(pwmchip_parent(chip), "Unable to set rate: %d\n", err);
 		return err;
 	}
 
-- 
2.42.0


