Return-Path: <linux-pwm+bounces-44-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592C67F2F7A
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CB6281A3E
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34F753808;
	Tue, 21 Nov 2023 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB7CD7D
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAQ-0005TJ-PM; Tue, 21 Nov 2023 14:51:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAQ-00AazP-76; Tue, 21 Nov 2023 14:51:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAP-004xdt-UN; Tue, 21 Nov 2023 14:51:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 047/108] pwm: brcmstb: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:49 +0100
Message-ID: <20231121134901.208535-48-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2062; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PJrMpSkAwAn3tK9mKzx+yXkF1a6/9GTkldUVIlvMjT8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWAE+24TChGdiPZzLSJOVs+n9GDApvQXCWUD oH9FGsUEDuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1gAAKCRCPgPtYfRL+ ThuYB/kBP+Zv5vo29yAiWAoV8tuyB6dictnfoNkk8b5igWb87vcBIJR1LXP0umFWPrl8gLnEhW5 wWda4iqczTe7HoaGrLuJERJNDHVU4cLV/HjeJPBXd4Jq2WRHBWTzadWasZLn+RpDVipPmWk5L1a vI2KzcMMzz/9JnMUq9G5m5q7kmUMwJO63enm3yY+oexQZPc7CSeBqsrZe1n0HKKgwIwTfJsL/M0 peSro1EUbmYst+Atzeutwm1nWy+yD7Mgpa51xy4+Rv7z3zU282xXYn4eBqnvwggWUEjIo1vCtGz BgCdKBJRdtE0Yh4gDr8NkuplGQKCYDikZ9cYPwX8/dxE/3zn
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-brcmstb driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-brcmstb.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 0fdeb0b2dbf3..1147477dc940 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -54,7 +54,6 @@
 struct brcmstb_pwm {
 	void __iomem *base;
 	struct clk *clk;
-	struct pwm_chip chip;
 };
 
 static inline u32 brcmstb_pwm_readl(struct brcmstb_pwm *p,
@@ -77,7 +76,7 @@ static inline void brcmstb_pwm_writel(struct brcmstb_pwm *p, u32 value,
 
 static inline struct brcmstb_pwm *to_brcmstb_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct brcmstb_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 /*
@@ -230,12 +229,14 @@ MODULE_DEVICE_TABLE(of, brcmstb_pwm_of_match);
 
 static int brcmstb_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct brcmstb_pwm *p;
 	int ret;
 
-	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*p));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	p = to_brcmstb_pwm(chip);
 
 	p->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(p->clk))
@@ -244,15 +245,13 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, p);
 
-	p->chip.dev = &pdev->dev;
-	p->chip.ops = &brcmstb_pwm_ops;
-	p->chip.npwm = 2;
+	chip->ops = &brcmstb_pwm_ops;
 
 	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &p->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-- 
2.42.0


