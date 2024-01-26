Return-Path: <linux-pwm+bounces-1092-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7304283D9E6
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 13:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6CC281231
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 12:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E40134C4;
	Fri, 26 Jan 2024 12:04:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9CED272
	for <linux-pwm@vger.kernel.org>; Fri, 26 Jan 2024 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270687; cv=none; b=gYH56pDytc36iD+JIMEMWUOiTr11u7f2ujZ4JbYArutsit9hEr/0i2xQWpJmbC9/um6lJ0sQGSJ1Thc6GFs0y8hrhkcb8/MbK/HLNZrOF2uKvsOrJpFHHkIhlykZhEciqsi66HYa91PjrP5X/g5jLbklD6XmueFuAk4NoMl8ow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270687; c=relaxed/simple;
	bh=9q1iHqiWwpiY1qDkwKANkwGoxjp+zeNg369vsPRSYGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtununOjzVU1Vlkri3v11wR69m3XFv05lPP+zBNFnPzz0jG1LA1aDYOZ3Nxgy/O0zGj9zutcrt+BnWsy+BNZMAagRFfdWnq7Dp/8pp2kTo/BpcmYRRbBZTXsDjdjfX31sBi9d3qDrCjOYAY2XfF2Fcq8BxB+qFl2E7hGqmZkjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTKwr-00022R-IE; Fri, 26 Jan 2024 13:04:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTKwq-002VPO-RI; Fri, 26 Jan 2024 13:04:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTKwq-008bQW-2Q;
	Fri, 26 Jan 2024 13:04:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Boris Brezillon <bbrezillon@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 1/2] pwm: atmel-hlcdc: Fix clock imbalance related to suspend support
Date: Fri, 26 Jan 2024 13:04:33 +0100
Message-ID:  <b51ea92b0a45eff3dc83b08adefd43d930df996c.1706269232.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706269232.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706269232.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9q1iHqiWwpiY1qDkwKANkwGoxjp+zeNg369vsPRSYGk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBls5/SsgkYYdZ3lKyJ7ep15A9GacxpbVDw95BgR TpcpbBbd4qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbOf0gAKCRCPgPtYfRL+ Tr7uB/91ZPiyCQ9eQUAefCVMurDDeI9MUXMBkT8GYDIjJclAqHf/vs+2HxT+cMQ1nNmQ+YGmjoa HxzAk+Qml7+5pB55K51yJjT4a6vWTB5DPk1/eC+ivclNqaYPyZL0e6/exRExMqfTn6AEilpwuIg rudPHLyPi6W92Z2Y6kFChFr2XPviX9lGiUyDzCDaFW7BqLOYDxfMjob+a59sAPE3N+W9dOWF5gH 4/aCyTz4ZQI55w+/RPzm3MtdxWsJ5XClvqU8E3hk2YRTIRcUsSXjA9FgqvAdGuzUdt6MQrb0wTR BtDV1vpQho1Hr5VR4X6YY2gRgE2XHezF2ic7juEluK/BJv1v
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The suspend callback disables the periph clock when the PWM is enabled
and resume reenables this clock if the PWM was disabled before. Judging
from the code comment it's suspend that is wrong here. Fix accordingly.

Fixes: f9bb9da7c09d ("pwm: atmel-hlcdc: Implement the suspend/resume hooks")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 3f2c5031a3ba..1f6fc9a9fcf3 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -185,7 +185,7 @@ static int atmel_hlcdc_pwm_suspend(struct device *dev)
 	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
 
 	/* Keep the periph clock enabled if the PWM is still running. */
-	if (pwm_is_enabled(&atmel->chip.pwms[0]))
+	if (!pwm_is_enabled(&atmel->chip.pwms[0]))
 		clk_disable_unprepare(atmel->hlcdc->periph_clk);
 
 	return 0;
-- 
2.43.0


