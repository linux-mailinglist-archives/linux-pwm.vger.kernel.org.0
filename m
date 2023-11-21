Return-Path: <linux-pwm+bounces-69-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7847F2F95
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA881C2166B
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBA553801;
	Tue, 21 Nov 2023 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEE910DE
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAZ-00068J-05; Tue, 21 Nov 2023 14:52:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAW-00Ab18-Fw; Tue, 21 Nov 2023 14:52:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAW-004xfv-73; Tue, 21 Nov 2023 14:52:00 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 076/108] pwm: pxa: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:18 +0100
Message-ID: <20231121134901.208535-77-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=oOktcXH+j+v7RYS5XSYBfs6aLaJnbVsWEVZrC2cNhdo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWgF2x6+Rpwv+wrmody7eXQgxhcIq9cS1gDN o61POG0hL2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1oAAKCRCPgPtYfRL+ TkO4B/wLp5hpYEkWlbxRxCKFeGp/vZBU6EjF5uqY1hmES0C3HaGg7ulcMBNvJxBWsW8iC6CmrVx m1DhKu5C4z52l2C/pp3JrZYeVlvkC6ijwg4bjKlWdCayGbzNHnpQYruOpGd0r9AV6EMMzXLc7l5 e31ZVW+XxzVvBJtPU0bf05V8NLSfH1hFntq8hKU34EBJBbR1q6LvvrsI0CoSZKPc9mqCA0B+p/o XrwhuvzuBleTGnyKav0wKFWcovjASzfj1LNAgANaKl8GyHFsQNkNDkZ77+0g2ZMMVrsS8fPH+KF lwrXaT2MsBqiO94/Ig7qBmO6+gTw6HFbepsvtoEFb0XzRn2K
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-pxa driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pxa.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 76685f926c75..764b52dfb6a0 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -49,7 +49,6 @@ MODULE_DEVICE_TABLE(platform, pwm_id_table);
 #define PWMDCR_FD	(1 << 10)
 
 struct pxa_pwm_chip {
-	struct pwm_chip	chip;
 	struct device	*dev;
 
 	struct clk	*clk;
@@ -58,7 +57,7 @@ struct pxa_pwm_chip {
 
 static inline struct pxa_pwm_chip *to_pxa_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pxa_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 /*
@@ -159,6 +158,7 @@ MODULE_DEVICE_TABLE(of, pwm_of_match);
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct pwm_chip *chip;
 	struct pxa_pwm_chip *pc;
 	int ret = 0;
 
@@ -168,28 +168,29 @@ static int pwm_probe(struct platform_device *pdev)
 	if (id == NULL)
 		return -EINVAL;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (pc == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev,
+				  (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1,
+				  sizeof(*pc));
+	if (chip == NULL)
 		return -ENOMEM;
+	pc = to_pxa_pwm_chip(chip);
 
 	pc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pc->clk))
 		return PTR_ERR(pc->clk);
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &pxa_pwm_ops;
-	pc->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
+	chip->ops = &pxa_pwm_ops;
 
 	if (IS_ENABLED(CONFIG_OF)) {
-		pc->chip.of_xlate = of_pwm_single_xlate;
-		pc->chip.of_pwm_n_cells = 1;
+		chip->of_xlate = of_pwm_single_xlate;
+		chip->of_pwm_n_cells = 1;
 	}
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
 		return PTR_ERR(pc->mmio_base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		return ret;
-- 
2.42.0


