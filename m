Return-Path: <linux-pwm+bounces-12-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA8C7F2F5A
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD852B210F9
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167BD53809;
	Tue, 21 Nov 2023 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12408D6F
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAI-0004xX-Ss; Tue, 21 Nov 2023 14:51:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAI-00Aawt-ES; Tue, 21 Nov 2023 14:51:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAI-004xb3-5V; Tue, 21 Nov 2023 14:51:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v3 008/108] pwm: cros-ec: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:10 +0100
Message-ID: <20231121134901.208535-9-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Y6SybQdrptjmGL25w1qQN8taLORx4QehGQ0MqQwXx4o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVW7G8g3B4WoIGznwQ3kx7w0eEuOHuAoS+Y9 q571iChN32JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1VgAKCRCPgPtYfRL+ TntsB/9Nj6A9eZjKBsj6nQfE/dfFW/JB2+Gc3gcXs3rnAozNlIFoDRihsY2UBSnBQYuFlNcQDGl NzVn7viCDI3j7dSvzyV5vFfBW05aOjqkyw8n/oovKxB3QbOp9hf98ROBHP2+dU1JFVt6a29kwNc QLaJSAS803j7KVaoNDiVwd23n5VMTNFOxz2GKTOUV4XRN+wS3zIS5kklDJsRgq4aoL3E2TKzsw2 uO3pKC15M2dl05ducMWbB8OhIi28HJ3WxtMvpuTfaTB6YnqbVlY5FmB1hm8zKa9PLFnOQ7Kfd48 2UCMMsiOsG5FDWS6I8Tc84amaoL0eV/kC1w8E0M0gWrgzGtF
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
 drivers/pwm/pwm-cros-ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 7345ca1c60f0..0ce8220646ea 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -173,7 +173,7 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, pwm->hwpwm);
 	if (ret < 0) {
-		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
+		dev_err(pwmchip_parent(chip), "error getting initial duty: %d\n", ret);
 		return ret;
 	}
 
-- 
2.42.0


