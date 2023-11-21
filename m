Return-Path: <linux-pwm+bounces-87-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC787F2FB1
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DDCCB20FA9
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4615381E;
	Tue, 21 Nov 2023 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9A51708
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAc-0006YX-OW; Tue, 21 Nov 2023 14:52:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAb-00Ab2Y-H8; Tue, 21 Nov 2023 14:52:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAb-004xhR-84; Tue, 21 Nov 2023 14:52:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 097/108] pwm: visconti: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:39 +0100
Message-ID: <20231121134901.208535-98-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YbptV1JFV8xUG4G16TBZlHSfQeEQVB34tNfnk2eyW6c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLW3xEKrTYNV12HogHpc6RU6tb5vWV9M5hR/t vScqIZR516JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1twAKCRCPgPtYfRL+ TjXYB/9cOl36h9P5+DkujuVETIdV90TMN1sJpibJS6shk/sJOxNfY4XylUURjXbQn4bo20J/9FV hISFrSccYQiJV5RBeoV0vH2lJntbev53Tl50AkdhJTax12vGaECsNsulXw4waKTcv5I5sRUdTUN 6KrjAy3boifl/BVKxSatvYsy8gv3Yt6onB070ecgWsg1D9ZWA8+7I+ne3FVAfsiQu09itIuB8OJ kqvHh8qt6v7AdBaLnpeFIHWGPXHxPxZj98FWS5YMqOvFMu5EYfrkOK1u9mIcJVkulitE0UeME8X Vtf64gf8j/WSkW7CDS/jo6O2WdpgjwCuSUlaXoCsUCAE+Ihj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-visconti driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-visconti.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
index 8d736d558122..64ca4059a5a0 100644
--- a/drivers/pwm/pwm-visconti.c
+++ b/drivers/pwm/pwm-visconti.c
@@ -34,13 +34,12 @@
 #define PIPGM_PWMC_POLARITY_MASK	GENMASK(5, 5)
 
 struct visconti_pwm_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 };
 
 static inline struct visconti_pwm_chip *visconti_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct visconti_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -134,22 +133,22 @@ static const struct pwm_ops visconti_pwm_ops = {
 static int visconti_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct visconti_pwm_chip *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 4, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = visconti_pwm_from_chip(chip);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &visconti_pwm_ops;
-	priv->chip.npwm = 4;
+	chip->ops = &visconti_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Cannot register visconti PWM\n");
 
-- 
2.42.0


