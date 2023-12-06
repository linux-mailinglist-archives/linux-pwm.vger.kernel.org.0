Return-Path: <linux-pwm+bounces-387-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEC5806EB9
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFDC281BFE
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63A234564;
	Wed,  6 Dec 2023 11:48:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC3610D4
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOL-0007NC-7q; Wed, 06 Dec 2023 12:48:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOJ-00Dwwx-Hz; Wed, 06 Dec 2023 12:48:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOJ-00FR2P-8u; Wed, 06 Dec 2023 12:48:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Michael Walle <michael@walle.cc>,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 090/115] pwm: sl28cpld: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:44 +0100
Message-ID:  <9d30dfa31b849d57a1769a39af597e102e3da3c8.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=sswbAV+zBzYeVO1IFM+012HWgn2W/2K9ehtnV0csJaM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF8PspHlg7zn9C03QCV2SnDhFugG1esAFzVxi FNxV8ivP1CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfDwAKCRCPgPtYfRL+ Ti72B/4pNkdPlVOFrMXYTA1fq8wHMZBCcrf3pBZLmSZTjruuWP7iZiTXvdLLGCPehmytC3cqykf dnkrAyub7M5PyAUZXlP2/oGhdqQWPWB8wBOcUV2mNk/tdoVzJE2B8XwTeybv2e2QiKWTSN2v1LO XzlVU74Q1S/HboMEagiBGcxl6f9NNStpI/+UkK7yumbrZ34YNVt+FROtn41bCjB+l9cSGZMQieC w8+vwA37slTiwXjUqAm+vyQe/EINxCghBXoXPGUYmi+LODhiBZeCp55HQ4cIRCJceSIGPGRqNws l3c1ncU2lWxJm5OaiZ/yyYeEFZsnHZbdjd85Rh+HE8qpMVfz
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sl28cpld driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sl28cpld.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index 88b01ff9e460..934378d6a002 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -81,14 +81,13 @@
 	regmap_write((priv)->regmap, (priv)->offset + (reg), (val))
 
 struct sl28cpld_pwm {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 	u32 offset;
 };
 
 static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sl28cpld_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int sl28cpld_pwm_get_state(struct pwm_chip *chip,
@@ -213,9 +212,10 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = sl28cpld_pwm_from_chip(chip);
 
 	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!priv->regmap) {
@@ -231,10 +231,7 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize the pwm_chip structure */
-	chip = &priv->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &sl28cpld_pwm_ops;
-	chip->npwm = 1;
 
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret) {
-- 
2.42.0


