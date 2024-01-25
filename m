Return-Path: <linux-pwm+bounces-1026-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915D483C205
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47123290AF6
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FEE4502D;
	Thu, 25 Jan 2024 12:11:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D83C097
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184663; cv=none; b=u6DKiZ78a8vGtU2WkLChq4liBWXb+IUaVuzxEW+8fQ91T2OOq7SAQ45MlZ6VKuMpyuH6LDkY5KLSl8UCVFwZhUvIMS3gmG05HnmQ6SYBN3ngwTc0aLvr19lNxLffPs9VoAQqvzDBeC9k7lqhbV1/0neMNpZxVnOUMjIkH+Nonvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184663; c=relaxed/simple;
	bh=a+0nMEmpriresN5Y+tyAxBKTFn98H96kR3UB4qLH6n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tq5EsEQdjwohX0V8k8NA5tEquHfEuid4MtqVI9pX+ySYQV2xXRcPyLq/chEz6XBgbx1mg0JfeUnEiWxlNiLlRPuFWY21bytIfnLg8g2bQTn7DuJ5FuFU1BspnMQeS1NbRveNnnsFVxqTMBDXuH4Rfjaloe+2KqU/PFZ4TI0bfvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-0004Xz-QS; Thu, 25 Jan 2024 13:10:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-002HUT-Ev; Thu, 25 Jan 2024 13:10:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-007n4D-1F;
	Thu, 25 Jan 2024 13:10:57 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 090/111] pwm: sti: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:52 +0100
Message-ID:  <a50f7df78cf636ac88d0753e7df3141c0fe71346.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3489; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=a+0nMEmpriresN5Y+tyAxBKTFn98H96kR3UB4qLH6n0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRN/otPqDC77vt49WcKe+EETZ2GFvU7MXeqzV+07fnZ1 3fOJzalk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJVOxi/6fQ5mqqzlYkynK7 N1a46+b8HUIRqrxaLHfPGXjVnTPduGmXMs/3itd+nRGmvPdjN3QU9SRzfy90n6LkXvtts2G7g+p y6UNi8So/HzR5r3r9PGxb7owJJqEbrwXMuT3jfeDrv8WR36SSwpe3u+9zWHdTtsSiZm/JUy6B4v opTFaTElO1bubz1r2RWSQ4STEwVf2/2He9Pfv6blxh+y3+z1Un+ZVfbGqhA3PBW8PZgUriltdTE ss/i+QIsHDvv+5yQG/zH8X/atwneezU5Eyiuus7o78c/XiuK8bR5TSrRIv/54cP+44sunnFRip7 6u+Feauflk43VZr2a5nrXp//WW+Pm2teVlvVzRAtOFMNAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sti driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sti.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 6cf55cf34d39..3a31e342e536 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -94,7 +94,6 @@ struct sti_pwm_chip {
 	struct regmap_field *pwm_cpt_en;
 	struct regmap_field *pwm_cpt_int_en;
 	struct regmap_field *pwm_cpt_int_stat;
-	struct pwm_chip chip;
 	struct pwm_device *cur;
 	unsigned long configured;
 	unsigned int en_count;
@@ -114,7 +113,7 @@ static const struct reg_field sti_pwm_regfields[MAX_REGFIELDS] = {
 
 static inline struct sti_pwm_chip *to_sti_pwmchip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sti_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /*
@@ -503,10 +502,6 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 	u32 num_devs;
 	int ret;
 
-	ret = of_property_read_u32(np, "st,pwm-num-chan", &num_devs);
-	if (!ret)
-		cdata->pwm_num_devs = num_devs;
-
 	ret = of_property_read_u32(np, "st,capture-num-chan", &num_devs);
 	if (!ret)
 		cdata->cpt_num_devs = num_devs;
@@ -561,13 +556,18 @@ static int sti_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sti_pwm_compat_data *cdata;
+	struct pwm_chip *chip;
 	struct sti_pwm_chip *pc;
 	unsigned int i;
 	int irq, ret;
+	u32 num_devs = 0;
 
-	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	of_property_read_u32(dev->of_node, "st,pwm-num-chan", &num_devs);
+
+	chip = devm_pwmchip_alloc(dev, num_devs, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_sti_pwmchip(chip);
 
 	cdata = devm_kzalloc(dev, sizeof(*cdata), GFP_KERNEL);
 	if (!cdata)
@@ -600,7 +600,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	cdata->reg_fields = sti_pwm_regfields;
 	cdata->max_prescale = 0xff;
 	cdata->max_pwm_cnt = 255;
-	cdata->pwm_num_devs = 0;
+	cdata->pwm_num_devs = num_devs;
 	cdata->cpt_num_devs = 0;
 
 	pc->cdata = cdata;
@@ -644,9 +644,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
-	pc->chip.dev = dev;
-	pc->chip.ops = &sti_pwm_ops;
-	pc->chip.npwm = pc->cdata->pwm_num_devs;
+	chip->ops = &sti_pwm_ops;
+	chip->npwm = pc->cdata->pwm_num_devs;
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
@@ -655,23 +654,24 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		mutex_init(&ddata->lock);
 	}
 
-	ret = pwmchip_add(&pc->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		clk_unprepare(pc->pwm_clk);
 		clk_unprepare(pc->cpt_clk);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static void sti_pwm_remove(struct platform_device *pdev)
 {
-	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	clk_unprepare(pc->pwm_clk);
 	clk_unprepare(pc->cpt_clk);
-- 
2.43.0


