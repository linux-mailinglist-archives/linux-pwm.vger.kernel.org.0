Return-Path: <linux-pwm+bounces-311-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C96806E53
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712D3281BA5
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E6534579;
	Wed,  6 Dec 2023 11:48:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3A9112
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00066v-RR; Wed, 06 Dec 2023 12:48:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00DwsK-BG; Wed, 06 Dec 2023 12:48:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00FQxU-2P; Wed, 06 Dec 2023 12:48:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 016/115] pwm: fsl-ftm: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:30 +0100
Message-ID:  <5b9f86d21a562232f3a298a515967b93fe44f998.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=nWr7Fn1CP8UGCXi7544g8G4oBBwlUD+iTlh8wcPSjDU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5p5mDRvoAa1jUxj7IpKJ7UWHGtkRhqxuROc QDf7zi5L2iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeaQAKCRCPgPtYfRL+ Tly5B/48SpQfG2LAZfvoxgwsw929GjBLLfYs9cshse7BLNpDb/RPDLMEpezD62rMp3Tf2Y25DRz Tx3mx0989dq30ve31m0APhhTgyB3YJfCnmkxL6gIm2NgMUSSNsOaWahyAmsIb2nRTYgN14tZDkb Ydv1eeJK1fBL4tVGAaSwliXLlQY/gi2wYxnbfgtXq6r3RKfdhtjnjaCOun94qkd+cgVimETqzSX CdCoGjFhym4cW/+w9VlZVEVANi4H+nENqLM3g/GbZM3On1ALv+K3z6x3VPuEvavpqsD652nduW4 17xqE8cKlVQGIKxM+rvLzFJXpAYaBDUCWB6YtCjQ23wUe70U
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
 drivers/pwm/pwm-fsl-ftm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index d1b6d1aa4773..47f1f5ac39cf 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -221,10 +221,11 @@ static bool fsl_pwm_is_other_pwm_enabled(struct fsl_pwm_chip *fpc,
 		return false;
 }
 
-static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
+static int fsl_pwm_apply_config(struct pwm_chip *chip,
 				struct pwm_device *pwm,
 				const struct pwm_state *newstate)
 {
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	unsigned int duty;
 	u32 reg_polarity;
 
@@ -232,7 +233,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	bool do_write_period = false;
 
 	if (!fsl_pwm_calculate_period(fpc, newstate->period, &periodcfg)) {
-		dev_err(fpc->chip.dev, "failed to calculate new period\n");
+		dev_err(pwmchip_parent(chip), "failed to calculate new period\n");
 		return -EINVAL;
 	}
 
@@ -246,7 +247,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	 */
 	else if (!fsl_pwm_periodcfg_are_equal(&fpc->period, &periodcfg)) {
 		if (fsl_pwm_is_other_pwm_enabled(fpc, pwm)) {
-			dev_err(fpc->chip.dev,
+			dev_err(pwmchip_parent(chip),
 				"Cannot change period for PWM %u, disable other PWMs first\n",
 				pwm->hwpwm);
 			return -EBUSY;
@@ -322,7 +323,7 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		goto end_mutex;
 	}
 
-	ret = fsl_pwm_apply_config(fpc, pwm, newstate);
+	ret = fsl_pwm_apply_config(chip, pwm, newstate);
 	if (ret)
 		goto end_mutex;
 
-- 
2.42.0


