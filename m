Return-Path: <linux-pwm+bounces-1333-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0C854590
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1541F2E0DD
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F2318628;
	Wed, 14 Feb 2024 09:34:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65E7179AE
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903268; cv=none; b=I7Wj3Am0JY0MK33yhy+0wjuqXZ9H0s41wr3PteUyYA6s7UAotAIelrt6jkVsS253HUYJ08YhMwrLNMMwDlsBmSBlum4ev4dsztGYemu48hV/c8fThcwHI8xIiQvVEeNtyl4vk+UVcKniog3vP02HNzSOa/hQt+ginqagEu452I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903268; c=relaxed/simple;
	bh=X11YFRRXpy/6TObmD0IkFCXyfClShBnw+M24ucXNpp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNqXOqAx+vC9fxgfR656auGKSywbtQu/I/VaOSkFPug7sHNDlJanIkEQ4eHnLrsNWUzN3J2I3PNMIxUQf4VtscF9KYvW5c9/yq4m3BQV/aDypLZ7fuYnrbnVTP8wwnZoNFcQk7WO9dwVi4Cbom4nyqS8bLecuZfEvUwUxEPbr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-0004R6-Kz; Wed, 14 Feb 2024 10:34:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-000f81-Sb; Wed, 14 Feb 2024 10:34:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-004Y0V-2a;
	Wed, 14 Feb 2024 10:34:19 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 013/164] pwm: atmel-tcb: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:00 +0100
Message-ID:  <463d43cab01f97f3c4247c63cc08e76aa15684c4.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=X11YFRRXpy/6TObmD0IkFCXyfClShBnw+M24ucXNpp4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhZh44bDOEZyf1+SgXF17gAdw0HhqZUbQ8NF CwCqOhz1MaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIWQAKCRCPgPtYfRL+ TlymCACQyuRBK6ii3fw96UC7bfhuFf6soDt3+TVZ5WsXQ0eVQfzVvEeLsdbrWLvXXB95hfp4qce lNbStzL+sl5gTVRigGjyNzJtbOaRt0cdZPqEkI8SJd9/SC/n7ghkknsVATCD3aoL78mRy/gxCCp ZvIdCU6UPLDAfN1wYBbDXZ6n8KdPGuqMhbWQMADGRijJhESCbfxz1fOxLJt8Ex+3oI4FyzV8zRe VUebQC24bjbj6XqpA3N4zYlABSRH9ufy4bze09JR2kFfzZI9/tpaQ05F3oS6QvALCBeJ0Cb9TjK ZI2N4HQUVtE+q7lwUXwJx42t4PLQZLN8ew3YWw2t8g5akV4N
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


