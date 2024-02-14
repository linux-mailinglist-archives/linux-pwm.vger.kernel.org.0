Return-Path: <linux-pwm+bounces-1348-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF898545A4
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC6C1F2E047
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F2318E27;
	Wed, 14 Feb 2024 09:34:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298F17C6D
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903270; cv=none; b=Asmc6WMXwHCSKo4W+uY3cy7TBZl5GfCaXI/NV1v2PjOKheLU/7l/NsT05wZZgL8JVE8S/dAz3MfaNvnPkB5hFCCM0BEaatCBKgUXt+XsEd3xamJ/lRiAjK+JcOC3QiIDJJEg05tTZat2iXyrXajx0AszXDRVtdCOunUTyqdbO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903270; c=relaxed/simple;
	bh=d0p4zq+ZNI+oblJ74VZxgRdDBukuAsuIxyr6xwcPm2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0qqPfcvsmS4qgy36CxIfxdMCy7cbnaQEoxQmmxPCn78xybjzsAD1+tCvULBiaxxa2phzgCVJDorWdWFQgkmPR8maqzAuJ8QQzMSeDVbK0Pc25xnw5XWvKjr6PjEAmH5ozvEpU6Dh2NBen0X7AVzYRgqyLQh+uwFEXW4gFFghcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-0004TY-RL; Wed, 14 Feb 2024 10:34:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-000f8R-62; Wed, 14 Feb 2024 10:34:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-004Y0d-0M;
	Wed, 14 Feb 2024 10:34:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 015/164] pwm: atmel-tcb: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:02 +0100
Message-ID:  <c845e6c9d27c8a4037755b2ae702b0039947a3c1.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=d0p4zq+ZNI+oblJ74VZxgRdDBukuAsuIxyr6xwcPm2Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhb9lxgP6Jqa6m0yw04Es1EWyLphu+Zv2jw3 BPrRFWVuY2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIWwAKCRCPgPtYfRL+ Tpn+B/wLgkmQyUGhyyBwTsLQv1CUuwwBaSGA67E06qS3GSZB7pw6j/OBHRaPVtew4OnIzqJZ2Qt c9dgomASD+DBkwqDpLjhfXhd1PX3k3afxLZGusBBj3Zt2SZpFQM1tIQ8NcGhOl3q+8STOBknp5+ PmuCW6h1ka0oGeD5D+Ih+Wx4foFilUt/FGhxap9/D2CuPLQGsXC6d8+29R4a8GeES7wwomOViRj RgBRbR6iiMnVG1GIiNWICN6FEe+llli3QetGrkwH8xFTiqmk0UFazpxIWtt6j3ooIIEKMCFiOXS o8pRKirnkoFtrkxgz9KcIF5z3Yn//gRlc1bqMZGzYIsPIB4Y
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-atmel-tcb driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 9d928e26b403..528e54c5999d 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -47,7 +47,6 @@ struct atmel_tcb_channel {
 };
 
 struct atmel_tcb_pwm_chip {
-	struct pwm_chip chip;
 	spinlock_t lock;
 	u8 channel;
 	u8 width;
@@ -63,7 +62,7 @@ static const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128, 0, };
 
 static inline struct atmel_tcb_pwm_chip *to_tcb_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct atmel_tcb_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int atmel_tcb_pwm_request(struct pwm_chip *chip,
@@ -397,9 +396,10 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	int err;
 	int channel;
 
-	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
-	if (tcbpwm == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, NPWM, sizeof(*tcbpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	tcbpwm = to_tcb_chip(chip);
 
 	err = of_property_read_u32(np, "reg", &channel);
 	if (err < 0) {
@@ -437,10 +437,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
-	chip = &tcbpwm->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &atmel_tcb_pwm_ops;
-	chip->npwm = NPWM;
 	tcbpwm->channel = channel;
 	tcbpwm->width = config->counter_width;
 
-- 
2.43.0


