Return-Path: <linux-pwm+bounces-7-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E8E7F2F4C
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231F81C21132
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54765524CD;
	Tue, 21 Nov 2023 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CFF10C1
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAJ-0004zW-96; Tue, 21 Nov 2023 14:51:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAI-00Aax0-SI; Tue, 21 Nov 2023 14:51:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAI-004xbB-JP; Tue, 21 Nov 2023 14:51:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 010/108] pwm: ep93xx: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:12 +0100
Message-ID: <20231121134901.208535-11-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LHD5njTe7mZENdQkJW0A8QSj/HQtZmw1x8mfHwTVCwI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVYKwcf5LCeccBBo01mOVWd3R930ht9K3Knp 8o935HoHVWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1WAAKCRCPgPtYfRL+ TurdCACIgtBJrPemjHUKXZDYYG9XsYw8lWy80KW0BFoIzxOmZ9jGc6iCAogNKkBxz8mMAXIqjoN Y0QOjOkOYhVg/IPi8ZOti9tW3KuGQ7gbpyMFV1qDu0rz+7uyx7lo8wMjbk4Dpq9RuhsdK9bdFkP ZEBdyLl2ksEjtqaWRunVkIJIAae1VxDZxdAHotSUQl17guRppU81cFa6Xi8215GtV7YJ3G6ITpj FoZsPIFCifaFBiLeKBGTwHByaX/2VvIrDG32ZNQKSiotpV085Uq2ICIkgJ0sSoSwBQgt+eTf2V7 y48gf8K6Ch3UaVlOaKwU/+NJroNqTMxBd+/66yHB3i1/MfSG
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ep93xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 51e072572a87..e4c3546a61c8 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -46,14 +46,14 @@ static inline struct ep93xx_pwm *to_ep93xx_pwm(struct pwm_chip *chip)
 
 static int ep93xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct platform_device *pdev = to_platform_device(chip->dev);
+	struct platform_device *pdev = to_platform_device(pwmchip_parent(chip));
 
 	return ep93xx_pwm_acquire_gpio(pdev);
 }
 
 static void ep93xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct platform_device *pdev = to_platform_device(chip->dev);
+	struct platform_device *pdev = to_platform_device(pwmchip_parent(chip));
 
 	ep93xx_pwm_release_gpio(pdev);
 }
-- 
2.42.0


