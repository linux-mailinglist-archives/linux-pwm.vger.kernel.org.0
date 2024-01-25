Return-Path: <linux-pwm+bounces-1028-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF73083C206
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F356B1C2074E
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD9236B10;
	Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E7374F5
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184663; cv=none; b=r1hg8r+FbIQzxLTugvMnjctemP+vh8W60/gK5AyJFPIaO8Wgnl4hHdD3xTN2m4ohr4dd7XEQOSaWfTJWdAHnw7oaTL+0ZcyscxrbyqZ588h22zbvBseRkmUHTvQNEYpYCK9MxftZ/a5YD4MvNw4g0h2Oxqzy8pc01J7lFJYGAOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184663; c=relaxed/simple;
	bh=5crgfzM9h8QstH1wGkHc8bfPWS3UUWzoWy5opErr66o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3F3VC55yMtWXDZ9eQuJ/yPzNW5spNVPS8nF4230hRyAGJDC0Co7/jg1jH2tpxWNplt0Obn19ekpVRm5DyPJYDCKEpVgrFc4JJ3OzuBAd88uZJUvpJNaAY1GDuc03YE+3I7GwjOqf6TB7CSprZvj7m7m9B862+1WA8d3rbs6os0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZP-0004ZG-FC; Thu, 25 Jan 2024 13:10:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-002HUn-7x; Thu, 25 Jan 2024 13:10:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-007n4X-0X;
	Thu, 25 Jan 2024 13:10:58 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Hammer Hsieh <hammerh0314@gmail.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 095/111] pwm: sunplus: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:57 +0100
Message-ID:  <ceef343a6a4b1432ceaff2d8a227f6a7a2f2075c.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=5crgfzM9h8QstH1wGkHc8bfPWS3UUWzoWy5opErr66o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+p/G3dutsAAtyeLEPwKXmHsfdsZl6ZzZwSs 6N/gD3//maJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPqQAKCRCPgPtYfRL+ Tm51B/9i32ESD0/FKx4T8YzZtxu05MKOSlPVlFcEyOHQjTvrKIJPs0WcC9v9oNHr/GV/7cv24af enHhlQr3Y7m/Z0fxKPz7O0nInKaTMH9QxDgBqSDxdl6kv+sX01Ni1c8K3j4+NY+9ifan8uzRWIC dssvlzV0jCvPz8/x2vrZow4ipA/EZVmkYY3g6uehZ3EUPCapO/zl4Uo1e4OYaMCijMHp6V76/z7 PziYZhJNMLClQl9NCBhklT7fuE93PIIsMMYFugdpVgQCJijAy2LbWrdUfQka2epe+wHB/zOv61M HbhTmFl6YsU0uGUPKyjdxIX7QUCbb+zdwt/Cie09DVXTJzGp
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sunplus driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sunplus.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
index 773e2f80526e..b342b843247b 100644
--- a/drivers/pwm/pwm-sunplus.c
+++ b/drivers/pwm/pwm-sunplus.c
@@ -43,14 +43,13 @@
 #define SP7021_PWM_NUM			4
 
 struct sunplus_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sunplus_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -175,12 +174,14 @@ static void sunplus_pwm_clk_release(void *data)
 static int sunplus_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct sunplus_pwm *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, SP7021_PWM_NUM, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_sunplus_pwm(chip);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -203,11 +204,9 @@ static int sunplus_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &sunplus_pwm_ops;
-	priv->chip.npwm = SP7021_PWM_NUM;
+	chip->ops = &sunplus_pwm_ops;
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Cannot register sunplus PWM\n");
 
-- 
2.43.0


