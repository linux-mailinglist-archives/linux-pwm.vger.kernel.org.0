Return-Path: <linux-pwm+bounces-1021-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299EA83C221
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D57B24A30
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CA73D98E;
	Thu, 25 Jan 2024 12:11:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486474439F
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184661; cv=none; b=sef5AXycC0iRvml264qFR7gR32iJ4sf+Dle473gDosxki8GL8LgHv4xTTgT5r6Qke0w6OIOpZWWSNcZVTtL0SgteGK2ihRBffx0PuokCusPdZzOKms+SpAGjKXlhzq27nXyYRZr3f1XRR1nQ1NfxfxcN/wjvC7BrvBeZDUtykbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184661; c=relaxed/simple;
	bh=rtkcltZMOo6Md1RGPzlmRgv8CpR5PZFpQu75wMewXGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ar97D79zkmv+juLp4G75Uxmyiz8GW8vilm2mnfwaxbshUifgrCJ8Txq6bKlprw2oN1A5WAYkVW3DGcJTuZFsR1WaVzKsHMZxkciRu0ba3EGIrKF0kPB8so+PqRYbkwTOxpp65LpEf/MU5JRuNUkJfUN9q+qnhAVm/JrzKFwmlTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-0004Vs-IK; Thu, 25 Jan 2024 13:10:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-002HU4-9G; Thu, 25 Jan 2024 13:10:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-007n3g-0e;
	Thu, 25 Jan 2024 13:10:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 083/111] pwm: rockchip: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:45 +0100
Message-ID:  <3fa1cd248c423c95ab1290634cbfeb3276ba28fd.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2829; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=rtkcltZMOo6Md1RGPzlmRgv8CpR5PZFpQu75wMewXGw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+b7O3Tj9e5mLiJRD+ipanh5rqcqMw8SSFr/ hT7jkyLY7CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPmwAKCRCPgPtYfRL+ TuX4CAC4FUxEkLR++lna/0x4V3p4ucf0bvhZZV0k6mJtnGEetrbF3GlcUj72tO9zyWvSwqlKlpa Sb2q6kLIzDQ5ibxn4iivv2/bu9OP5KAElzL1SNw+Zz8g+60tyRtXVuF5Fkz7Jm8ZQYAe0IzbCK7 /8hEjfWL1mq67VfXAdd8yUSDLgt5iO2lUVc2OW0kyLSXDqsLyci3EuaKXD+Dn5xur7WNvikj+iv JPBuh0SVgJmHo/euTq7tj1bvqvCBhjqbK8L76bhzidQlLJmAb+KufRtPjEMG/wdJPovR+3wjbv7 pro6sGXR9szKEmMyP9kEdsFle+mOmG+n34s717EcTv0kDpjR
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-rockchip driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rockchip.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index a7c647e37837..0fa7575dbb54 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -30,7 +30,6 @@
 #define PWM_LP_DISABLE		(0 << 8)
 
 struct rockchip_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	struct clk *pclk;
 	const struct rockchip_pwm_data *data;
@@ -54,7 +53,7 @@ struct rockchip_pwm_data {
 
 static inline struct rockchip_pwm_chip *to_rockchip_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct rockchip_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int rockchip_pwm_get_state(struct pwm_chip *chip,
@@ -296,14 +295,16 @@ MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
 
 static int rockchip_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct rockchip_pwm_chip *pc;
 	u32 enable_conf, ctrl;
 	bool enabled;
 	int ret, count;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_rockchip_pwm_chip(chip);
 
 	pc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->base))
@@ -337,18 +338,16 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 
 	pc->data = device_get_match_data(&pdev->dev);
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &rockchip_pwm_ops;
-	pc->chip.npwm = 1;
+	chip->ops = &rockchip_pwm_ops;
 
 	enable_conf = pc->data->enable_conf;
 	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
 	enabled = (ctrl & enable_conf) == enable_conf;
 
-	ret = pwmchip_add(&pc->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 		goto err_pclk;
@@ -372,9 +371,10 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 static void rockchip_pwm_remove(struct platform_device *pdev)
 {
-	struct rockchip_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	clk_unprepare(pc->pclk);
 	clk_unprepare(pc->clk);
-- 
2.43.0


