Return-Path: <linux-pwm+bounces-400-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9268806EC5
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067F41C20A46
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2867D34CD1;
	Wed,  6 Dec 2023 11:49:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C318110EF
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOP-0007gl-EY; Wed, 06 Dec 2023 12:48:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqON-00Dwxw-5a; Wed, 06 Dec 2023 12:48:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOM-00FR3P-Sy; Wed, 06 Dec 2023 12:48:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 104/115] pwm: vt8500: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:58 +0100
Message-ID:  <ace1811895ea24b70d7317967104b5ce1bd185e2.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=a0tnhg9EuNoemudUk0dv7AFw5fLNRtHoi+gH4ExWte0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF9DDhQw01gOrjRP9t2G5JIEw9dZvXitUdI/d Bq1O7VzSZ2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfQwAKCRCPgPtYfRL+ Tn31B/9ya8tjBIrQE1YrxCC5crwsrqLPToOkw2fn5PorPho1jJnAIyQsR+XX+HAFYVSsHySpkKb 9j1obif5korVrd4OOhT4lbLKePhEKg++OMEWu3gxZXd9OpYjof7SMnNQjpZOVbiFLmCUQC1/WFB 20XCMjiW9RgjM+TMH5aAhK3Ws5xEXUwsOEWp5UuHunef8mN7X9zfwU6Ts6JlSFo9aSnmxAsI1VT gKZcMj7EcRdKZXMatnsgGKi1SOFl1VcG/RAPvNuYn0X0RRqzVCD/+HgZZAUC1SszsdcjFLwHvWY rsfe/aArMzUpWM9YGzQ1yyAlmSb79M9fclp1O8tEWYfF+GDZ
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
index ff5e76afbddf..b24afee37488 100644
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
2.42.0


