Return-Path: <linux-pwm+bounces-702-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00729828EEC
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jan 2024 22:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137F41C23C2E
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jan 2024 21:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5993DB98;
	Tue,  9 Jan 2024 21:34:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9DA3DB84
	for <linux-pwm@vger.kernel.org>; Tue,  9 Jan 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkC-0006cz-6X; Tue, 09 Jan 2024 22:34:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkB-001Z2F-QH; Tue, 09 Jan 2024 22:34:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkB-006680-2N;
	Tue, 09 Jan 2024 22:34:43 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 3/5] pwm: Let the of_xlate callbacks accept references without period
Date: Tue,  9 Jan 2024 22:34:33 +0100
Message-ID:  <127622315d07d9d419ae8e6373c7e5be7fab7a62.1704835845.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704835845.git.u.kleine-koenig@pengutronix.de>
References: <cover.1704835845.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=BMmHJt880nhlmFlEZrw8htfLYZmurkhqfoLEipuv8/E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlnbvst8njtk15FdAQGIVEJDc3usU1Rc5O7XQqb ev6fzoAH5eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZZ277AAKCRCPgPtYfRL+ TlynCACQM9ZeFIjXPRRCYIervWLD+QXc/r8Cs/PWWSSgr2rYrEOdwl1uR/LqiJQO8WhgfpkQhGT M+WgJ/ZyCzMaVYstflu6sgEgj9iDn2JpBjXgBe/S6X0SSVTUXpZcoLuSqDpptb/nI4gEW8TEqDj ZDN9y5ltDIcEmMZnzQZuQSVYtAWPl6I49uTQ4eWe51GGatlXMqiddVkRYiCW+3VtvkPGkh1J5aq MVgXG3yRFoHK2zhEOVQTRGIDS41bKhSPdgcVPEiDA38te+4PT6JzHVE8hTXTXxRinGD6X1q4NWW y4Dpf6FXfAeIuHItFdaeXDKXsRX6JqDaegDJ/03W32ckPoFI
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

With this extension of_pwm_xlate_with_flags() is suitable to replace the
custom xlate function of the pwm-clps711x driver.

While touching these very similar functions align their implementations.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 31f210872a07..606d9ef0c709 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -107,8 +107,8 @@ of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *arg
 {
 	struct pwm_device *pwm;
 
-	/* flags in the third cell are optional */
-	if (args->args_count < 2)
+	/* period in the second cell and flags in the third cell are optional */
+	if (args->args_count < 1)
 		return ERR_PTR(-EINVAL);
 
 	if (args->args[0] >= chip->npwm)
@@ -118,9 +118,10 @@ of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *arg
 	if (IS_ERR(pwm))
 		return pwm;
 
-	pwm->args.period = args->args[1];
-	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	if (args->args_count > 1)
+		pwm->args.period = args->args[1];
 
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
 	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
 		pwm->args.polarity = PWM_POLARITY_INVERSED;
 
@@ -133,18 +134,15 @@ of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
-	/* validate that one cell is specified, optionally with flags */
-	if (args->args_count != 1 && args->args_count != 2)
-		return ERR_PTR(-EINVAL);
-
 	pwm = pwm_request_from_chip(chip, 0, NULL);
 	if (IS_ERR(pwm))
 		return pwm;
 
-	pwm->args.period = args->args[0];
-	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	if (args->args_count > 1)
+		pwm->args.period = args->args[0];
 
-	if (args->args_count == 2 && args->args[1] & PWM_POLARITY_INVERTED)
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	if (args->args_count > 1 && args->args[1] & PWM_POLARITY_INVERTED)
 		pwm->args.polarity = PWM_POLARITY_INVERSED;
 
 	return pwm;
-- 
2.43.0


