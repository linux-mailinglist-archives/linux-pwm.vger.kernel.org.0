Return-Path: <linux-pwm+bounces-962-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2260883C1C1
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79901F216B8
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E4F3FE3F;
	Thu, 25 Jan 2024 12:10:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E33D558
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184648; cv=none; b=oisEjwEKSDS2zwYnV6lVbPsNyPJaR5Hy1AdX8rUp/6gonOpcx/TF5et5D+iAi1fU7pasbU3tWUALTuS/gh8jPITVDRhc9AbLz1bfm6yXenCM8Vrh3ixMgSq+F20sbx4DSvc0S3TLu+x6WtX2oC7pvV07W5krFCpyCXICAg7WXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184648; c=relaxed/simple;
	bh=15QkF6UfRNZdEbGD6rCarw+yiORwQG1S55uDkQ6Up0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfU2/FBszPGzTkXRACSM51kyAY6lDp80iJFtDLE2dRESKLj+5/ggI7PNk7aFsuWFv4rS09BJIrYQ2k51tOcD4ynw25UgKKaqYBg/w9auplfVHVTIWuLtk25Kz00S5/EB4f973OWr3daigYcxnHKrURlAGzXUy6HxUevymBVb6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZA-0003jy-SU; Thu, 25 Jan 2024 13:10:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZA-002HQA-Ec; Thu, 25 Jan 2024 13:10:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZA-007mzd-1B;
	Thu, 25 Jan 2024 13:10:44 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pwm@vger.kernel.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 023/111] pwm: raspberrypi-poe: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:45 +0100
Message-ID:  <5cc19dbbd107812096475804c0832fbc145ef56f.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=15QkF6UfRNZdEbGD6rCarw+yiORwQG1S55uDkQ6Up0I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9UpYSmshITP3oz3sc4JeLkLfn+6PTdHTpfD qXAu6V8IGKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPVAAKCRCPgPtYfRL+ TlzIB/9r+h2bdaHzVxAPYYa6Dr1kO112dyGGAnvijgrH7rzt93A/5Qf8BD3MmsJReLaBy8447BP iX4OAmbCnbRipmaatduFYU7FjuASiNgbD1pCo6+v2zvbWF0lkn0IuRSkgYmbym2znYXQjlXY64g PdukF3zv9Pc6mFCYD/yNZH8NaK0Y8PzKBvIM1lOCuBPiTVdsatzYtcWcHU8pFvjsk7eOR785J+I 4emxoMsxUfqZFww0Cgyffo4HU2dhgmEoW9H9ZHMAz1jBCr/Kj9xT5u7dhaSwULR3i4D7ayINfc6 R8t7w//jaZvpmoEben5n2cf4tvfU0Go/8D4+WnCcyVAA8k0W
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
 drivers/pwm/pwm-raspberrypi-poe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberrypi-poe.c
index 1ad814fdec6b..f10e8a624c51 100644
--- a/drivers/pwm/pwm-raspberrypi-poe.c
+++ b/drivers/pwm/pwm-raspberrypi-poe.c
@@ -122,7 +122,7 @@ static int raspberrypi_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	ret = raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_CUR_DUTY_REG,
 					   duty_cycle);
 	if (ret) {
-		dev_err(chip->dev, "Failed to set duty cycle: %pe\n",
+		dev_err(pwmchip_parent(chip), "Failed to set duty cycle: %pe\n",
 			ERR_PTR(ret));
 		return ret;
 	}
-- 
2.43.0


