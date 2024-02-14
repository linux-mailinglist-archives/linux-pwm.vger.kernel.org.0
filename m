Return-Path: <linux-pwm+bounces-1343-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B1F854596
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F6F1C2628B
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9510918B09;
	Wed, 14 Feb 2024 09:34:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B816B15AE0
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903269; cv=none; b=W2PV0q4TcRsI7qR//W1nz7qX1C8epC/v1sUXI2Glg/NKQeb6DBx2i2y8YZzSOuv9GwbK5zk3h71XZq3JHfS0+XOl8PlitEYfTZX4RVB1M2cbW69mPQ2ukCnGRKpP/W39ifZ6PyqWXi3HuqWPOrGlPKR+ggQOeF+29I5EczSSipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903269; c=relaxed/simple;
	bh=XxgEjvTX8Gycaku241V/JGRbGACWFS6LpdpoWaNJMe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYdj8WgCLMeMU1BrlU/uC3fTZDlhXPziei0tnekB46z+fSHsbw06HchVo4P0oKh7G1u2+bFk5WwqFLhFL6rNb2bGC6z2wUPQlDl4rq9ip80/+LV+SXyv/b/SLb7piWc5WssnvxCglRv2drzwPfB7isOurvroTeFylbLSmljjERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-0004el-AU; Wed, 14 Feb 2024 10:34:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-000fB8-Q5; Wed, 14 Feb 2024 10:34:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-004Y2H-2L;
	Wed, 14 Feb 2024 10:34:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 038/164] pwm: fsl-ftm: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:25 +0100
Message-ID:  <131f976a8f876a88e2a940f5acf6aa1d81833b89.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=XxgEjvTX8Gycaku241V/JGRbGACWFS6LpdpoWaNJMe0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIh2E+YhFdS9Xcq/Kmj/qxmpQ1rqDCf2G2vpI lnR9pw0xmqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIdgAKCRCPgPtYfRL+ TiMLB/0U48lGNIqFmppPv/q2Dhx/StvlaMUCyGFdbye/Q0kbwFdX2AvHbJZnr0xNMyDSq0Arnsq Z80GF8YdKItWpnm4uywilYHABsbJHNsi3a9dIrRHgDPVYs11qHKW+OyAbopAfMWtt8W/vywbN2t c8vhu1lJwSMw3RMpZRrJgjUtoktW2XOL7muhvIhRGqMXcNwECkNL9w4YyOGSQRzPd3etiJw0+o+ viBedPKyLGV5EOa7PQzwQZ3fHJFQEy2RJhYkLHdEPII3q1BcZkra0oriKER6SRgxBMgxlz52+/v dH2PN+TVlEmeAfI6VuXb9njDELwILP/bsmKAZ/mdtAjlf6CR
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the accessor
function provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-fsl-ftm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 5792c6ca449f..47f1f5ac39cf 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -233,7 +233,7 @@ static int fsl_pwm_apply_config(struct pwm_chip *chip,
 	bool do_write_period = false;
 
 	if (!fsl_pwm_calculate_period(fpc, newstate->period, &periodcfg)) {
-		dev_err(chip->dev, "failed to calculate new period\n");
+		dev_err(pwmchip_parent(chip), "failed to calculate new period\n");
 		return -EINVAL;
 	}
 
@@ -247,7 +247,7 @@ static int fsl_pwm_apply_config(struct pwm_chip *chip,
 	 */
 	else if (!fsl_pwm_periodcfg_are_equal(&fpc->period, &periodcfg)) {
 		if (fsl_pwm_is_other_pwm_enabled(fpc, pwm)) {
-			dev_err(chip->dev,
+			dev_err(pwmchip_parent(chip),
 				"Cannot change period for PWM %u, disable other PWMs first\n",
 				pwm->hwpwm);
 			return -EBUSY;
-- 
2.43.0


