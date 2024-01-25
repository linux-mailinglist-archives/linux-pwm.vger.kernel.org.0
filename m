Return-Path: <linux-pwm+bounces-984-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B364F83C1D6
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665161F22A8F
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7CC45033;
	Thu, 25 Jan 2024 12:10:54 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB84439A
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184654; cv=none; b=fXvINcV7l1AlP/bJCI3uxO9H8TsV6JAzZoQUaLSjCoucIuAdeFeX11Pq1KF5Wn3+D+20QgVrVxzeXHcBmRKZNeLQZzhmgGdqrXb29vl8m9hQbODZKb72kZerm2JePqbpPEtG1Gv1UXIOksaltwWuURiAlySTrgG6jGLmXLwFw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184654; c=relaxed/simple;
	bh=TZC2i850mmZA7TRa+F19cdXeyXFOZTXIsdwaUd0XKe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ob79VapWziB1kINLyigPJmi5Xyj5tnIEZYFV7DNwoHONrA8o+3K2w76ex3ZmnZO/Su1MWyLbFO4+QRmunr7DODdbXQxwX84v82gkajAVhg7U6VZtmkk89Km27w8DQTj+yoPtSHuynSEKMJm+bjkn2oDh4oa7nV/kIFUCLH5/u4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-0004Hd-Le; Thu, 25 Jan 2024 13:10:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-002HRw-0e; Thu, 25 Jan 2024 13:10:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZF-007n1T-32;
	Thu, 25 Jan 2024 13:10:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pwm@vger.kernel.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 050/111] pwm: brcmstb: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:12 +0100
Message-ID:  <4da39b2333ae7639d724e925eaffb51d9e577492.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=TZC2i850mmZA7TRa+F19cdXeyXFOZTXIsdwaUd0XKe0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk90yXfDgUf/cID0mjpPVYObWmZe7DptZfvar G34xi4Bu2uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPdAAKCRCPgPtYfRL+ TvxXB/99FlBF4ZIb3AlkJeqniog7qM3n62rsSuFgiDwQ7M+LXfyWsZSDlWvbYVjz8k/WRgaHgBH pthnHVuHV4GsT8cZeFEN0XEQ3zQaAY1R4ZGqHyMwYqyD/0Hh62+JPz/tlzVc2f97s85keOrAiQC aS9tPeiSOabtnuekfF4Vb8FON+5M0JOC0eCKUY06PwkUZZFC6IhH+/H2ldwsYMP6xFz3KwBZomQ ZFU+zJFh0y+O/7lSGBnKOV1RnxtlGcgrn2mL8tPZOJeZwabIXfH4z5B8NUwCDnbjYKH2IqYnUhR ZsR5rqgLQ63y9beDlTtBPRBNAEpistIE+jlbay6eLrDUb5Sn
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
index 0fdeb0b2dbf3..82d27d07ba91 100644
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
+	return pwmchip_get_drvdata(chip);
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
2.43.0


