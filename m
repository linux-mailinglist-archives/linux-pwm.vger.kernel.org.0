Return-Path: <linux-pwm+bounces-317-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C364806E5E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4D728194B
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFDD347D1;
	Wed,  6 Dec 2023 11:48:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEDCD49
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00061Q-8V; Wed, 06 Dec 2023 12:48:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00Dwrt-BA; Wed, 06 Dec 2023 12:48:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00FQx5-2F; Wed, 06 Dec 2023 12:48:22 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 010/115] pwm: atmel-tcb: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:24 +0100
Message-ID:  <909399b9171a08433b16f81ca21efca47aa859d6.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Z7zJIhly+7uC4LrIb4VoqhAbkY69P/aM5XQ5q8eyrBc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5dc1EBL5X6gSoPWQtW5eZapJqrlB8gox5m2 72oYWPD5DWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeXQAKCRCPgPtYfRL+ ThdHCACicUOzGQWCtKNPxxdZxzCBzuAzYtCQpX5HOC6/mS4opQf8OkUGfKATxai8Vh+z6PQY9UZ JiJHuFVAZKXbod2G2khYUYVogniOzDD3oV8hiMPhI69aBxmc48vZyvgI1cNKe5bwwfwMzU1ddeP NVWeU61GkyT564QOOihoqtM6AhI4S5l5V5a/Zxo5wln3vAsSlEaf2m7A2hUYnKk0SKUIVjFdRHw RYkY1AX5UcsZ3TnvQ3mPbEJ7fww3CeF4Fheau0ntWoCsq5upWb/HG3hi1UUxvwi3teNCvbOTpzg qVBi/MHxqwUMcoOyFAWOWqZNp8y8LGdtqjAxsOJQXnJTAFbt
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
 drivers/pwm/pwm-atmel-tcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index d42c897cb85e..80121ab81a01 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -327,7 +327,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if ((atcbpwm && atcbpwm->duty > 0 &&
 			atcbpwm->duty != atcbpwm->period) &&
 		(atcbpwm->div != i || atcbpwm->period != period)) {
-		dev_err(chip->dev,
+		dev_err(pwmchip_parent(chip),
 			"failed to configure period_ns: PWM group already configured with a different value\n");
 		return -EINVAL;
 	}
-- 
2.42.0


