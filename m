Return-Path: <linux-pwm+bounces-957-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D7583C1BE
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4081F226A9
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3A3C097;
	Thu, 25 Jan 2024 12:10:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76573FE2B
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184647; cv=none; b=A3xRi9pKgo6cf+sXr86pKMFqMxqFz/mqLFHRKd1dIXtm+slGzosw40dHT1QIjMfiqUZGOYb1Kxsdlm6Klar3dDVMEPipcmh0yGQOK9B3AIuD97d4qbjnk09LrRSQVwyC5QrSeaRkbnnu2P4juRnhQFM+ETvGVIx9ER6nHR4p5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184647; c=relaxed/simple;
	bh=eBtQyqLCRtmLfSPQUANukLLiI/iNUzLf98CR7LqcGJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSPcUKva72ZrdqN65kd791mAjZjpj/vmkSbu/gduLrUWNXP19MMQ9eImOdI7P6Py7J9fUXFpHHq4maagGZBpXzQcLF9D9ETMb+jSAjdC+0RHJJeHF8ibxAj9nUQ5/tYRXkjhfNoUTiAJKGQ45j8aJhjPVIAPztq95NuIigJPrbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-0003Zt-BR; Thu, 25 Jan 2024 13:10:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ7-002HP4-1u; Thu, 25 Jan 2024 13:10:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ6-007myS-3A;
	Thu, 25 Jan 2024 13:10:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 006/111] pwm: atmel-tcb: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:28 +0100
Message-ID:  <1c39fb0cafbd301da6b5d17d7336f4a1336a52c9.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=eBtQyqLCRtmLfSPQUANukLLiI/iNUzLf98CR7LqcGJo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9AjB23XbPT/nTF6Ff/JCcjexXCQwLeFRLlZ 6ZUhQarPHCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPQAAKCRCPgPtYfRL+ TrT0B/93OcSt0tmFqc4iX9KzQekCQ1RFoSErwDYmvOtNrXx31oq59n/D40lTVVkGzSfgjxT9Two v96FGZd5d9PYlwl9j6c8dIih/cKn4oCiWouncJfUI9s2Mbm5f6G3oKfDXmOrbSl3ibKeZE4MxDI Ynbj+0reG1d5C+D7vsd+ZN2bvJXZAoCq0x7HLsb91UzicMPKpEPuUz46NhktTpvQfIr37kJq8bv oQtqr3KxMBPqZqOmWbvBiMV76iVGbOMHGdl9ioajz0JRwV9grOy5SpWoSYUgOFr9UcuiV5WivTa RChV0Gw8lbXECpVQmvB7CJI1YsRsET1Soam8Z28yoB5R8tow
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
2.43.0


