Return-Path: <linux-pwm+bounces-399-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBBE806EC3
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7251C209BA
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B633D347D2;
	Wed,  6 Dec 2023 11:49:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD68810EC
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOP-0007fr-Hj; Wed, 06 Dec 2023 12:48:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOM-00Dwxr-Vb; Wed, 06 Dec 2023 12:48:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOM-00FR3K-Md; Wed, 06 Dec 2023 12:48:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 103/115] pwm: visconti: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:57 +0100
Message-ID:  <e8c7c3837df04f7c612b80079c64352c83cd3ab6.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=bSwi90FUBuq3aWqOwrCIzQTVB9WJIexDe7IonLnDdn0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF9C4fl05ABCJf4K6qoWujz/mpKk8RqJzuief t0RGWrpqbSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfQgAKCRCPgPtYfRL+ The7B/9gzjtkAEGiRzXtF94uRhM1mnnsw4fb8RHGhfuPAqJ6P2QTDl5e9xV6ApSXQv7zLkt4CcG 2uUM+NiR7r72ELa3GB99ijnHKDjffFs9upRMjfPluAYlnX8EXVTbeTuIFfXBEFnukOfIPCQt5ux Sz6OSNoPcyfGQrkjmkp64lABnqqiH72h5/PsgW/bQ0n+8H2hn/6HjHSTT9p5PHodML9hhQZ4sab rfeIRDLEVYwCODK3k9XdsDlvBEawS63z5sv5A5tmYu4RqiHuyVdVBnClqgzoLwyI1rq8y64fL4Z lYlTghSNcBbWBDbxobSPqUiBtsNRyuYSEujcVC1++s0AP8wk
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
index 8d736d558122..9e55380957be 100644
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
+	return pwmchip_get_drvdata(chip);
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


