Return-Path: <linux-pwm+bounces-1457-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A2A854619
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A271C229F8
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA7F1798E;
	Wed, 14 Feb 2024 09:34:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645761B7EA
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903292; cv=none; b=reqFWl4jen6evPVPkUAZh9JLe9Tl6/3vEqDb1/b/sAqj6XDcTnupzIGRdakHLwVTn7083gpQXBW2rDeHn7eo1/4SpRu5lXUsi9NLaoYgEr6RVrXrfaqGQZMo40HAdb8yD6UhZ/38AIjbfTO5Ql7XmeXd6PLZ6n+GoqDuC6hXwfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903292; c=relaxed/simple;
	bh=8grekMG/pnUPKM2MOLizyNA3Ftp35oinBr44kp2qzzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWcpv8m15rtxtLiIcPeR1fIf8Ng7PRskbgV5S/sSae6dFd2kIVCM/e3Kmuq8eN/kehgVH3Myno5n+AkgdzjgblTqI0C+VvZ+99ZBUHYFhTWis81uSwTJrCpJ632ptAaaM9FTHsps+qi2b5wBiM/9Ex023LgAbzbd7SdtZADjJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-0005v0-Cx; Wed, 14 Feb 2024 10:34:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-000fGb-Dp; Wed, 14 Feb 2024 10:34:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-004Y8L-17;
	Wed, 14 Feb 2024 10:34:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v6 127/164] pwm: sun4i: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:54 +0100
Message-ID:  <9d175b4e27878618cef2e75b6ecbf01ad5d18164.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=8grekMG/pnUPKM2MOLizyNA3Ftp35oinBr44kp2qzzM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjdIZpyNN9xsJ/83vD9zGceZKDFjTgjS+vFw giGgyurR2mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI3QAKCRCPgPtYfRL+ TpS0B/91FU88mXiefrP3J4rA4CGdSag6uBm5eO2sgfhRr4Y5m3b9MI4JyFbJ/WQ4h+3EVL+uS8U ktz9YZxmHu0X+OUlFsT8GxSVAvneu1cwDWIynXlXiHzFk2wz2ZJJ2mDjKLhHRTMPT3TDP8iPmqE t0h80+KjIv7S2CUVLjo4nv1oQ9xW6Am6bp437q2YT483DwnpYDhbnCXIl1604tOR/JmkRew28h3 k9QXL+nWjyNhQDXaMD7K3WMKigRZ+Vi0UJi8sfS/Q4nySkXxyqSUBPvL6g5w56XHRcQKP68IfKj VALUdkhZLAIwm79XrJwGdX3hEKtEiudv+4htab04pHWUZks/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sun4i driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sun4i.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 2437e5961f5e..5c29590d1821 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -81,7 +81,6 @@ struct sun4i_pwm_data {
 };
 
 struct sun4i_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
@@ -92,7 +91,7 @@ struct sun4i_pwm_chip {
 
 static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sun4i_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline u32 sun4i_pwm_readl(struct sun4i_pwm_chip *sun4ichip,
@@ -385,18 +384,20 @@ MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);
 static int sun4i_pwm_probe(struct platform_device *pdev)
 {
 	struct pwm_chip *chip;
+	const struct sun4i_pwm_data *data;
 	struct sun4i_pwm_chip *sun4ichip;
 	int ret;
 
-	sun4ichip = devm_kzalloc(&pdev->dev, sizeof(*sun4ichip), GFP_KERNEL);
-	if (!sun4ichip)
-		return -ENOMEM;
-	chip = &sun4ichip->chip;
-
-	sun4ichip->data = of_device_get_match_data(&pdev->dev);
-	if (!sun4ichip->data)
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
 		return -ENODEV;
 
+	chip = devm_pwmchip_alloc(&pdev->dev, data->npwm, sizeof(*sun4ichip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	sun4ichip = to_sun4i_pwm_chip(chip);
+
+	sun4ichip->data = data;
 	sun4ichip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sun4ichip->base))
 		return PTR_ERR(sun4ichip->base);
@@ -453,9 +454,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		goto err_bus;
 	}
 
-	chip->dev = &pdev->dev;
 	chip->ops = &sun4i_pwm_ops;
-	chip->npwm = sun4ichip->data->npwm;
 
 	spin_lock_init(&sun4ichip->ctrl_lock);
 
-- 
2.43.0


