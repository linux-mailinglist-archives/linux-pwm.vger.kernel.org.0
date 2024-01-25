Return-Path: <linux-pwm+bounces-1001-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C945783C1E4
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D231C22BFC
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3763A27E;
	Thu, 25 Jan 2024 12:10:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1646559
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184658; cv=none; b=CNYymOoG7NSd9ybcxBQzqJSOEdezurAs8ZUXcWL16Ux7X31j7OA3FmgSeEJVVj2KrI094JVEvyNDG9EwV5TorGXfxAOaIJYzVglgerW3r557FEuW2y54eyot4Tg6IJFtbSvM5yoHcmK+d2yLCgWVPyPSh2TyJkMhwdhLQ+N/qoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184658; c=relaxed/simple;
	bh=0c8sbrGBYHHUqmBguqG5s01btYLJBEd8GiQ88NLECrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8oeTlLbqBDhfic2IoVusHZYOZQns6JZdDF6qgx/A9BqpbVkmFeTKfUS+8r+UmY+LV6/TtlX0qUz4l1i/zDMVu9A3eKSkHO/1FNk8tzkZFZrjhVvj0MX+q2cChyySccMTq2AC2wIPx8WC/eXtm41X2a+3Tplq5KMSfqqanR7Dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-0004Oe-39; Thu, 25 Jan 2024 13:10:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZJ-002HSz-0v; Thu, 25 Jan 2024 13:10:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZI-007n2a-34;
	Thu, 25 Jan 2024 13:10:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 066/111] pwm: keembay: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:28 +0100
Message-ID:  <1abdec8140b957d13bbf8eee22f4944afa81652b.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2016; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=0c8sbrGBYHHUqmBguqG5s01btYLJBEd8GiQ88NLECrI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+Hf4SXQ1vcu1UqS/neuouVmWACsi/7vYUaf Bm/nCbnILeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPhwAKCRCPgPtYfRL+ Tq2lB/kBRQ8zhSY9f+PYVtYX7BBYNNhv2XGvmqsxG+KSVBsLIf9aEpHEGG4ip7ikRYsLsSunE5h 8DcShp8xMjwwo2AuQzu97YBEvwC9EkH09F+0Icwy5aD6YUKrCjai/9R2wH87DeZzmeBDrKk6guV nLxUHvXo2JGwNS6CFL52udBiYcXR5562ASP2Pu8hgFnLRodnEwo7W0r4gF/Tsff62BZKLkcz1Ti NvtzrkhQnUeSn7nN6L8upzP1keVxyuhW6XAHD5JqtV/sU7r376NAQZmYQBHW7Js93SnzHhwnkvW DJDFy+IIAfL6kkU3/gaqq6TEEWUK6GqL83XnfFDtpic4KVy6
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-keembay driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-keembay.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
index ac824ecc3f64..35b641f3f6ed 100644
--- a/drivers/pwm/pwm-keembay.c
+++ b/drivers/pwm/pwm-keembay.c
@@ -36,7 +36,6 @@
 #define KMB_PWM_HIGHLOW_OFFSET(ch)	(0x20 + 4 * (ch))
 
 struct keembay_pwm {
-	struct pwm_chip chip;
 	struct device *dev;
 	struct clk *clk;
 	void __iomem *base;
@@ -44,7 +43,7 @@ struct keembay_pwm {
 
 static inline struct keembay_pwm *to_keembay_pwm_dev(struct pwm_chip *chip)
 {
-	return container_of(chip, struct keembay_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void keembay_clk_unprepare(void *data)
@@ -185,12 +184,14 @@ static const struct pwm_ops keembay_pwm_ops = {
 static int keembay_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct keembay_pwm *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, KMB_TOTAL_PWM_CHANNELS, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_keembay_pwm_dev(chip);
 
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk))
@@ -204,11 +205,9 @@ static int keembay_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &keembay_pwm_ops;
-	priv->chip.npwm = KMB_TOTAL_PWM_CHANNELS;
+	chip->ops = &keembay_pwm_ops;
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
 
-- 
2.43.0


