Return-Path: <linux-pwm+bounces-481-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF3180B74E
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Dec 2023 00:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C784280EDA
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 23:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB21D69D;
	Sat,  9 Dec 2023 23:01:11 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4211C
	for <linux-pwm@vger.kernel.org>; Sat,  9 Dec 2023 15:01:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rC6Jl-00068t-Db; Sun, 10 Dec 2023 00:01:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rC6Jj-00EjgM-2m; Sun, 10 Dec 2023 00:01:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rC6Ji-00HQDw-Px; Sun, 10 Dec 2023 00:01:02 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 1/2] pwm: lpc18xx-sct: Don't modify the cached period of other PWM outputs
Date: Sun, 10 Dec 2023 00:00:46 +0100
Message-ID:  <8adc3d93457eed7ee8a516210ec01e918f0bd8ec.1702162780.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702162780.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702162780.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+bLbassBagzpYpF2dicCsMxLbyx0LfGpNT7MwPf7i5s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBldPGj3khYef2/5H7UOd9vHmN3OFWQiZOrJIUow jlN+tzrLbOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXTxowAKCRCPgPtYfRL+ TtE6CACgWpNFuQqJUueA8kkOv3DRGyoljR99EJsfaA/t2P/HHnFnvvceSGVoItYkw6QVqtQQ4Ex Ok3QfMyW+qcWMvTOdVm58muSwQhYhkXB/UX2PsTmqDaGe/rG0jXYCBOz4OhWJ79hPgaHr/0PPo6 L/XyPjJxNXF4hZqa3n4Ir4OzcWDSrs8qYa0yWdUe7kzq6Nlp/gZ+Hio55CqsbeG1P8ZyxxQWWuh uwNDRW4vIzDBoCr4GBl+ESE5vGHkLbNF8t0lp9lSWt/Ug8JwQDMeJykSAtXx3p4Fqx0dl2y43nj J1IXkpMpuPmidPkMrUNIExfqs/Pm4iu+bEGPeISj1CdLJvhe
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Even though the hardware only supports a single period for all PWM
outputs, modifying the other (disabled) outputs's period is strange and
wrong. Only the pwm core is supposed to update these values.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index b3d4a955aa31..fe891fa71a1d 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -194,7 +194,7 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			      int duty_ns, int period_ns)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
-	int requested_events, i;
+	int requested_events;
 
 	if (period_ns < lpc18xx_pwm->min_period_ns ||
 	    period_ns > lpc18xx_pwm->max_period_ns) {
@@ -223,8 +223,6 @@ static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if ((requested_events <= 2 && lpc18xx_pwm->period_ns != period_ns) ||
 	    !lpc18xx_pwm->period_ns) {
 		lpc18xx_pwm->period_ns = period_ns;
-		for (i = 0; i < chip->npwm; i++)
-			pwm_set_period(&chip->pwms[i], period_ns);
 		lpc18xx_pwm_config_period(chip, period_ns);
 	}
 
-- 
2.42.0


