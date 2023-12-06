Return-Path: <linux-pwm+bounces-367-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0BF806EA8
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F434B20D4B
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EBF358BB;
	Wed,  6 Dec 2023 11:48:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB0110CB
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-0006w5-HX; Wed, 06 Dec 2023 12:48:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOF-00Dwvb-QM; Wed, 06 Dec 2023 12:48:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOF-00FR0z-HJ; Wed, 06 Dec 2023 12:48:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Paul Cercueil <paul@crapouillou.net>,
	linux-mips@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 068/115] pwm: jz4740: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:22 +0100
Message-ID:  <a4a0ca1f8c36b61313a2c00e034624bcc1c05600.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2167; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=nriEtKfizy+dLJE8Bx+JHMdROcX/lWIpUsRsawKMsws=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF7YWf59rFTEzI9YxtCtWy0ohjXLQWTbXdH47 sgqhnVYEp+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBe2AAKCRCPgPtYfRL+ TgYIB/9XzZqB2kjuaOS/qR17/j7e83nwHvSN3TOHPaHG9tSKO3VHGoVC2eR7bGIBRHlGt3YIBlh 02V7uvygq/98/nuCPl029Y4nB7YFuNkHeyn6poKmN5o/C1tp5vou60UUznmAPc9oTAuc3kYZNWS VN4kpAyNo8kgk+Bnoq1/ox7fb+3jgJYXu/ZA1l+pEA7PEjyMsp7TE9WNrDq0LuIwI0dICEJOezZ F84mJrCbdo+P9YiMjUtGkECcFUmmf8FtGNGM7EIdFsGW26DF+nYBeyU2dHCd1ghCmbvDTA3i5PP +bYbr2Gtgyv3yzHSjUKOxADPzwXEP+AW/eja7EaMPQlzmEGA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-jz4740 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 36763134cd87..5a7cc41df77e 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -25,14 +25,13 @@ struct soc_info {
 };
 
 struct jz4740_pwm_chip {
-	struct pwm_chip chip;
 	struct regmap *map;
 	struct clk *clk[];
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 {
-	return container_of(chip, struct jz4740_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip, unsigned int channel)
@@ -222,6 +221,7 @@ static const struct pwm_ops jz4740_pwm_ops = {
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct jz4740_pwm_chip *jz;
 	const struct soc_info *info;
 
@@ -229,10 +229,10 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!info)
 		return -EINVAL;
 
-	jz = devm_kzalloc(dev, struct_size(jz, clk, info->num_pwms),
-			      GFP_KERNEL);
-	if (!jz)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, info->num_pwms, struct_size(jz, clk, info->num_pwms));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	jz = to_jz4740(chip);
 
 	jz->map = device_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(jz->map)) {
@@ -240,11 +240,9 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(jz->map);
 	}
 
-	jz->chip.dev = dev;
-	jz->chip.ops = &jz4740_pwm_ops;
-	jz->chip.npwm = info->num_pwms;
+	chip->ops = &jz4740_pwm_ops;
 
-	return devm_pwmchip_add(dev, &jz->chip);
+	return devm_pwmchip_add(dev, chip);
 }
 
 static const struct soc_info jz4740_soc_info = {
-- 
2.42.0


