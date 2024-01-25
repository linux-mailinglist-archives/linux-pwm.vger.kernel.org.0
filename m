Return-Path: <linux-pwm+bounces-1041-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BECC083C226
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29808B24C74
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295FB3FE3F;
	Thu, 25 Jan 2024 12:11:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E43EA62
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184666; cv=none; b=q29Mou97xGBOoyM6BFSEUfuOScaKlaVGwUMljArvcBUGCEhOxsCa7gglKbHJgK4UJ9Os5fxNkEEuXEySEeIPZvL7C2aaUTqEktLSYqmH5mrVfyONj1Eu0M9KyNPstARhP9Y4pJUuztRGCP7K0vzrI+Ip3hgh8JuQ1mKCSbyrwek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184666; c=relaxed/simple;
	bh=dkfJtIjUtbDhr/LiFNhq2M4wEO28QtDlc90Nq+Tu3yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuHTGkpe9qE4TkpIxygQ6csktXSgU3c8nU2KBZ4BkwbNwPOQHLjydnz80S7k+7NH+qRZwwdihQOFs/X8UmIDmbLG7NQQt1PiDRAVuaj4RyhPlv06giDGjy7LRafDPJg11ZNxtlfR6tuAfa9y4RFFmuj6qwZJtHmBNzjBcS4HZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZQ-0004cI-NS; Thu, 25 Jan 2024 13:11:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZP-002HVC-Aj; Thu, 25 Jan 2024 13:10:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZP-007n4v-0o;
	Thu, 25 Jan 2024 13:10:59 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 101/111] pwm: vt8500: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:10:03 +0100
Message-ID:  <01b4c6f966cd9506c7a0771a442d13199c4b92fd.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=dkfJtIjUtbDhr/LiFNhq2M4wEO28QtDlc90Nq+Tu3yQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+wQpnU070buZRIXoJz4AXaXF25nY4Up4epJ Ecc2tP/8ziJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPsAAKCRCPgPtYfRL+ TjfIB/4mu+z9//YiNWdz74fKfzConYKFZMTK4Cl5mKn4KsqQNAru7rYDjLlne3ucrOFBG0RX4m8 JJVsg9ElZ5Lg1b7MPOOxWF3W9b/riBHCGuo/AImRA99Ca9mojDQoqIXP3GX2lhK0fRhBHBr9nW3 /sgq7LBynQIYO3BrvApdGOMV4ftabAuwi/GTqDB+VR+5GMEe4XeaL2fxZmcH915UdGZ15cyx+pw 6yACeE+jS9LBwwAAHwXjOkSA6bgByXh+gzHcApssDVsd6b/cV8wbhwdWCayRBn4mBnL8IqXHlfR pMMC0kv80mdiK8iq20/sRNsNK/f25mymmuhYLcxTh/8Uy7pm
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-vt8500 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index def48dbef808..ea465376fe09 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -45,12 +45,14 @@
 #define STATUS_ALL_UPDATE	0x0F
 
 struct vt8500_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
-#define to_vt8500_chip(chip)	container_of(chip, struct vt8500_chip, chip)
+static inline struct vt8500_chip *to_vt8500_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 static inline void vt8500_pwm_busy_wait(struct pwm_chip *chip, int nr, u8 bitmask)
@@ -232,6 +234,7 @@ MODULE_DEVICE_TABLE(of, vt8500_pwm_dt_ids);
 
 static int vt8500_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct vt8500_chip *vt8500;
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
@@ -239,13 +242,12 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	if (!np)
 		return dev_err_probe(&pdev->dev, -EINVAL, "invalid devicetree node\n");
 
-	vt8500 = devm_kzalloc(&pdev->dev, sizeof(*vt8500), GFP_KERNEL);
-	if (vt8500 == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, VT8500_NR_PWMS, sizeof(*vt8500));
+	if (chip == NULL)
 		return -ENOMEM;
+	vt8500 = to_vt8500_chip(chip);
 
-	vt8500->chip.dev = &pdev->dev;
-	vt8500->chip.ops = &vt8500_pwm_ops;
-	vt8500->chip.npwm = VT8500_NR_PWMS;
+	chip->ops = &vt8500_pwm_ops;
 
 	vt8500->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(vt8500->clk))
@@ -255,7 +257,7 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(vt8500->base))
 		return PTR_ERR(vt8500->base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &vt8500->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-- 
2.43.0


