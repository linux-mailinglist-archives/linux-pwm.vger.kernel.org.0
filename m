Return-Path: <linux-pwm+bounces-370-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB67806EAD
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFFEB20E5B
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E9C35F01;
	Wed,  6 Dec 2023 11:48:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08112B
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:39 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOK-0007G0-T1; Wed, 06 Dec 2023 12:48:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-00Dwwb-Jw; Wed, 06 Dec 2023 12:48:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-00FR25-An; Wed, 06 Dec 2023 12:48:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 085/115] pwm: renesas-tpu: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:39 +0100
Message-ID:  <c2b4f885e7a1192d4b40d40807ad9841ea1ea9bd.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2237; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ywpObwhU0L4/XRZ++W9DHunUs2TqjrgnTwvOxwL6w7o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF8K2gnjfzjvJoxzF9t1mprjzA3WlQA7cr5Ce fWnBQTVwt+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfCgAKCRCPgPtYfRL+ TtaLB/9iYKTeZgXpJhPiSkCrzreeAgOd5W9+DwhYhNPsdz0EtIbYXzvtjzXXpP6jtQFvXlJgu8j 7EpoNynF7YgSci0OHSs+AdWskDttmSL9iOnXYS/07Osl6/u9TBkUvB0zTODEJ87I2TK+uitenw4 X/tHz16yE/2BzGMeOCk2tmnygJtbg3RLYTfIcLMI+1SZ4jmcDEJDdrZvir5TifTLdbKbyn5Qp1/ JPB4Ggdoq1BFx1rz3IP2BjyL1GkjITXob5F8Y8NCc0mfLJD65l51dFR5Bj/1c0n8+9bUXQE3c/o 3cXUIdDxVExjjnfGbXlpS0tc/dbsRCTQ6h7MdxomGdgCnj7r
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-renesas-tpu driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index ce92db1f8511..c65d9b4e7773 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -80,7 +80,6 @@ struct tpu_pwm_device {
 
 struct tpu_device {
 	struct platform_device *pdev;
-	struct pwm_chip chip;
 	spinlock_t lock;
 
 	void __iomem *base;
@@ -88,7 +87,10 @@ struct tpu_device {
 	struct tpu_pwm_device tpd[TPU_CHANNEL_MAX];
 };
 
-#define to_tpu_device(c)	container_of(c, struct tpu_device, chip)
+static inline struct tpu_device *to_tpu_device(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 static void tpu_pwm_write(struct tpu_pwm_device *tpd, int reg_nr, u16 value)
 {
@@ -439,12 +441,14 @@ static const struct pwm_ops tpu_pwm_ops = {
 
 static int tpu_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct tpu_device *tpu;
 	int ret;
 
-	tpu = devm_kzalloc(&pdev->dev, sizeof(*tpu), GFP_KERNEL);
-	if (tpu == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, TPU_CHANNEL_MAX, sizeof(*tpu));
+	if (chip == NULL)
 		return -ENOMEM;
+	tpu = to_tpu_device(chip);
 
 	spin_lock_init(&tpu->lock);
 	tpu->pdev = pdev;
@@ -461,15 +465,13 @@ static int tpu_probe(struct platform_device *pdev)
 	/* Initialize and register the device. */
 	platform_set_drvdata(pdev, tpu);
 
-	tpu->chip.dev = &pdev->dev;
-	tpu->chip.ops = &tpu_pwm_ops;
-	tpu->chip.npwm = TPU_CHANNEL_MAX;
+	chip->ops = &tpu_pwm_ops;
 
 	ret = devm_pm_runtime_enable(&pdev->dev);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to enable runtime PM\n");
 
-	ret = devm_pwmchip_add(&pdev->dev, &tpu->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register PWM chip\n");
 
-- 
2.42.0


