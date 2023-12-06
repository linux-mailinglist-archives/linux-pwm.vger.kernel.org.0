Return-Path: <linux-pwm+bounces-422-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FD180769D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 18:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100FD280F22
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE62697BE;
	Wed,  6 Dec 2023 17:30:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C47122
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 09:30:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAvjX-0000Ul-92; Wed, 06 Dec 2023 18:30:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAvjW-00E0iy-B0; Wed, 06 Dec 2023 18:30:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAvjW-00FdcZ-1R; Wed, 06 Dec 2023 18:30:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH] pwm: stmpe: Silence duplicate error messages
Date: Wed,  6 Dec 2023 18:30:43 +0100
Message-ID: <20231206173042.1762233-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2911; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vC1n9UqzjYgVwvtpQ0rpTKRf0oBlyHd84psPO2kGVTk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcK/D0emr33wY8gr0c3fyro3jDAZFmdv96BWgl TNDQr8HafSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXCvwwAKCRCPgPtYfRL+ Tq15B/9QFXtj60VmNUyFVM7whafg5aew9JZVK9JerSltr/zMHPfIKyTojZHE3Fu6QCbbsKKtYVR aebHIOj6j6rgI+sE6VgGnor8G5JaNd5+xkyvGWXgdWhJ9WuyTat4MKzz35/Nmx1S7BDbYeLVQwY VG7sF7FUJ1zS6Sn52qcHty51Vs6zpk5fSgIpJ7mORpb2PdXxrx1SEBLlzXQs+QJzZutMKJ64Jqi n41e+XE9dsNxNg+LJemSA1GSlKux9P2JqG0c4hoB6KA/tTMqKCWX0LpVc6iiS5qqwXlayQ6OUJI OzSndfXqCpB4gIYfcn7cdyQ+b+7bzbExaIDsMKtqEPci0T61
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

stmpe_reg_read() and stmpe_reg_write() already emit error messages when
they fail. So the extra error messages in the pwm driver are only little
useful. They are useful in some situation, as they give a bit of context
to the failing register write. So don't remove them but degrade them to
dev_dbg().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

some time ago I suggested to remove the error messages. Thierry
suggested instead to turn them into dev_dbg instead.

See
https://lore.kernel.org/linux-pwm/20230728081803.aswbz4slvrqqi5hc@pengutronix.de
for the thread where that happend.

Best regards
Uwe

 drivers/pwm/pwm-stmpe.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index d730631c6583..19c0c0f39675 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -44,7 +44,7 @@ static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
 	if (ret < 0) {
-		dev_err(chip->dev, "error reading PWM#%u control\n",
+		dev_dbg(chip->dev, "error reading PWM#%u control\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -53,7 +53,7 @@ static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
 	if (ret) {
-		dev_err(chip->dev, "error writing PWM#%u control\n",
+		dev_dbg(chip->dev, "error writing PWM#%u control\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -70,7 +70,7 @@ static int stmpe_24xx_pwm_disable(struct pwm_chip *chip,
 
 	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
 	if (ret < 0) {
-		dev_err(chip->dev, "error reading PWM#%u control\n",
+		dev_dbg(chip->dev, "error reading PWM#%u control\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -79,7 +79,7 @@ static int stmpe_24xx_pwm_disable(struct pwm_chip *chip,
 
 	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
 	if (ret)
-		dev_err(chip->dev, "error writing PWM#%u control\n",
+		dev_dbg(chip->dev, "error writing PWM#%u control\n",
 			pwm->hwpwm);
 	return ret;
 }
@@ -233,7 +233,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		ret = stmpe_reg_write(stmpe_pwm->stmpe, offset, value);
 		if (ret) {
-			dev_err(chip->dev, "error writing register %02x: %d\n",
+			dev_dbg(chip->dev, "error writing register %02x: %d\n",
 				offset, ret);
 			return ret;
 		}
@@ -242,7 +242,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		ret = stmpe_reg_write(stmpe_pwm->stmpe, offset, value);
 		if (ret) {
-			dev_err(chip->dev, "error writing register %02x: %d\n",
+			dev_dbg(chip->dev, "error writing register %02x: %d\n",
 				offset, ret);
 			return ret;
 		}
-- 
2.42.0


