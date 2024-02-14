Return-Path: <linux-pwm+bounces-1387-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216348545D9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F9FB22FEE
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845781758C;
	Wed, 14 Feb 2024 09:34:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6254F12E72
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903280; cv=none; b=hZXLfCQ/sprOjcYcGAnzhWkH83ZeaOKv4jbdCorrAMi/EvwKbO18tb05j8I333tJJmN+GYax6XEc31VbzoUpNvQZvUEs2jqEx/o1ex4xuTdGLAeQO8BDmobFcpmsB7VXV6v1DVCNvJmMZ+I0LIefmaMZv2FjRRaJNymPD17U/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903280; c=relaxed/simple;
	bh=tckScFPWS6URzhmSZ5hzAZ/IN0qAPlMBZCNdmE0zraw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7peHGeXiuj/UFx1sQZfLiFISZQoLveba7Y4PTLLOwS+e8x2vkbKRwD5SMa8gwiT/vRdW0GSyub1Jn7zyjz2e0I5FlMDenuFs9i0gzwqCeyNzOslZCGhSrgxO/m3APTtko7VjMBRHSs4ejHz/FHuhLYmhv7Emo18+RfX5PZN6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-0005JQ-EV; Wed, 14 Feb 2024 10:34:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-000fE0-3i; Wed, 14 Feb 2024 10:34:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-004Y5T-07;
	Wed, 14 Feb 2024 10:34:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pwm@vger.kernel.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 085/164] pwm: raspberrypi-poe: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:32:12 +0100
Message-ID:  <6758bcddb150f2c4353469937f1a68ecb87465ed.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=tckScFPWS6URzhmSZ5hzAZ/IN0qAPlMBZCNdmE0zraw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIisB8V/68e/2Dm6u/ZpfffFdjoQSCAshbIDN jsAFuWqwCiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIrAAKCRCPgPtYfRL+ TioHB/9nX5RKM/BXRhHRjK/0H0GOuMXLQRmMc2/LsBU1Yg7sbmfBinQrMpLB4l3EzqHvpbVjF4L 5XpzhBxaig5Cjod26SZhBJgjMENWc0pZjpsT0Z3kpox0RlvmATkHwA31aX4pi5HUhRZYN2SDs4l QFy+ESyt9T7D5Hn7mGIfagoeTABKRfowH8HCWEitmgex1YvER/aHqGuaf9EwX0NISy9SBPvuLwn vt7XDmeghl/szuhEbK8YoxcwGiIq5t+M8aU4Zu0UMDBP/+KGoWqSueg9GcYx5C65KePCpd9M7om SVri1DtEQg5C0So3dAQX8DpUrQU4Utu7kXLI/kzrBdB9RtgM
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


