Return-Path: <linux-pwm+bounces-679-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C970825FCC
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jan 2024 15:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09C8283BDA
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jan 2024 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D3E79C1;
	Sat,  6 Jan 2024 14:13:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CA79C7
	for <linux-pwm@vger.kernel.org>; Sat,  6 Jan 2024 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM7QJ-0004AZ-0Q; Sat, 06 Jan 2024 15:13:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM7QI-000ovl-6d; Sat, 06 Jan 2024 15:13:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM7QI-0040z0-0O;
	Sat, 06 Jan 2024 15:13:14 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Paul Cercueil <paul@crapouillou.net>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: linux-mips@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] pwm: jz4740: Don't use dev_err_probe() in .request()
Date: Sat,  6 Jan 2024 15:13:03 +0100
Message-ID: <20240106141302.1253365-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=i+FKGzfBwfmMxhSMObPAUwmu/trLDofAD/x+QHgSRC4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlmV/uJ5pV1q3SVWuDfz7HlRR4H47YCXa6lFyJe tCSH0fJRW2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZZlf7gAKCRCPgPtYfRL+ TnC1B/4+tojo9TvriQjnvI9vMtR7IQeywhaaQ4b4ae/+rpagdaBBFlpn+xEsE8tden6YUHwxE+I mQdnntnBM4NFMDQtAgXcViUUsmBrja2Rqwk7L+qSsGuf/7z/DKgTu1TQwOIBLz47PdVzu8LrnVy rtzmWZ8sGUI5TQ1Yg12WIrla6p4X3Fg7Yy0mNs15bXQUNtd6jNzucYzmZ2QOOKO4TRlP4sT7Xt8 Xarv+UQsjLK8+Q+5wOKAdq3CndbqKe2ZDAsfXUOtvruhni9LQRKiRMQQ8ij6QhW26DYk4fD7XmI QUeeSmDfESMsCBOkPtd9cDTY6E3ZbSnAKoJi1HnUkcbANfxP
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

dev_err_probe() is only supposed to be used in probe functions. While it
probably doesn't hurt, both the EPROBE_DEFER handling and calling
device_set_deferred_probe_reason() are conceptually wrong in the request
callback. So replace the call by dev_err() and a separate return
statement.

This effectively reverts commit c0bfe9606e03 ("pwm: jz4740: Simplify
with dev_err_probe()").

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 80dcff237a15..3933418e551b 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -61,9 +61,10 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	snprintf(name, sizeof(name), "timer%u", pwm->hwpwm);
 
 	clk = clk_get(chip->dev, name);
-	if (IS_ERR(clk))
-		return dev_err_probe(chip->dev, PTR_ERR(clk),
-				     "Failed to get clock\n");
+	if (IS_ERR(clk)) {
+		dev_err(chip->dev, "error %pe: Failed to get clock\n", clk);
+		return PTR_ERR(clk);
+	}
 
 	err = clk_prepare_enable(clk);
 	if (err < 0) {

base-commit: d73f444d06fb8a42a5c0623453f3ea1fe9880229
-- 
2.43.0


