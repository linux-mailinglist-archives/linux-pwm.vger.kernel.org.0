Return-Path: <linux-pwm+bounces-319-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA70806E5F
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBD71C20B2F
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E10B34CD1;
	Wed,  6 Dec 2023 11:48:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A994BD40
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00065P-Rf; Wed, 06 Dec 2023 12:48:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00DwsG-67; Wed, 06 Dec 2023 12:48:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00FQxQ-Ti; Wed, 06 Dec 2023 12:48:22 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 015/115] pwm: ep93xx: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:29 +0100
Message-ID:  <f2b4a59fda8117133c003f4be8ba6a0d4cd52a48.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=LHD5njTe7mZENdQkJW0A8QSj/HQtZmw1x8mfHwTVCwI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5jjxydQe+rbVg3NNz9abfKnYJKHtFi9nfXe uohkdFoi5+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeYwAKCRCPgPtYfRL+ TkMoB/9UcJfAkN8ClIs9p4/g31RnzEpZ+KLKjgseDQgftEhcFEoj/SMdOPHCzEhldQCPHTWVc2+ pIR09I0NsvOzZsNkzGuTOlEf1l+cwAapsHgb06dNGDUqp3OThTWXCVU3Ov+ijiBjZzquTADBm+G 0irGN1cvlIMtHfDrpr+9vHINYkVeaAaXcJyuD62TAgFXXt4+vw5q+ipno2+NXOawekTJJQl3/pj W3ZSMMBL2hsXay6G5dNAXJDHUHueL+wOq6IGaNEYgXUaTXJVXUHs0DtgOccum+mJTG1krIO6Yul KSLM3tdGbKztEhghChG8KaWHzt+G0W+M86HepsqfR8SarNPM
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


