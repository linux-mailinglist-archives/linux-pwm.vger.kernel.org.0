Return-Path: <linux-pwm+bounces-952-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFBB83C1B9
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25092909A3
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB43D98E;
	Thu, 25 Jan 2024 12:10:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DCC376E1
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184646; cv=none; b=muy9mbHP/vTxrfv7tPbZn2Z+gPd5CIIrD8KU9nimnZ9vBxWVD9VQt1hfbirji1QRdKFQZv+RKab1R/U1M2qCN6GBYadk64yAYLxPDgrNmjxQCmuSfYk+n7ATduEl73neR+dRFC79jvzrRGbWeRvkwoUb1rWVAHgyPQ3pGYGnhjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184646; c=relaxed/simple;
	bh=74KiAob4DCgNHoLYu3wxcnMyhxw+QLO1gn9EmhyVpZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtLsTfWN6aZDqXxXRGRfZtKhA9d1w4TanAwaqLGSzh/HDNUei1MBh8/I5CWDuzQ+xqCHBH77ypHQxcraxRqQgnQBUtoUeVu0SJK+p7Yb1GSTanKuIDhZPBatmxb6lbxZ306e6G7JBtwPDZieIEFI4SgZ2YK6SslZngHcGZcSotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-0003cB-4R; Thu, 25 Jan 2024 13:10:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ7-002HPE-JY; Thu, 25 Jan 2024 13:10:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ7-007mye-1h;
	Thu, 25 Jan 2024 13:10:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Benson Leung <bleung@chromium.org>,
	linux-pwm@vger.kernel.org
Cc: Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	kernel@pengutronix.de,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v5 009/111] pwm: cros-ec: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:31 +0100
Message-ID:  <ff7c2a67903d4cb6cd89ca066dcb0b5598a3c659.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=74KiAob4DCgNHoLYu3wxcnMyhxw+QLO1gn9EmhyVpZ0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9ET8qdPEDfgq3Vl9JuIMjJxck9S6N/Lz7sC 4mnt4liVy6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPRAAKCRCPgPtYfRL+ Ti9GB/93N/aieXClsVPd9TdOVVjj6oXgWeGBioAracO7/u9oO6Qa7zWqxJOklkpMkyU4GuLIDVT 9bXpt2mbGO+T3ei/zipBJMMfqWjSNedCX5Svwbi6Tp/DYb2KspulCL2/Ac/GAaca7y/FiEqUj3Q AcZEe1DTrYoSgCykroQbQE/HkqvdyLrMK9G32VEZapM1jHh81eQFWqp3w634PdkT0CG7p33I/NT eXwxdMvp+e17knJmmOMS1FMTt9NimyyWq8VkbF0UXgIUcBCYjg+lslr3il/AcdEQbdKcdH3SRpG BC+grd3k2iwKEiOPRvFgJq8WMXePiR2mqntgER0ReU71D1xu
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-cros-ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index e556f6218dd7..968e300e9f06 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -172,7 +172,7 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, pwm->hwpwm);
 	if (ret < 0) {
-		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
+		dev_err(pwmchip_parent(chip), "error getting initial duty: %d\n", ret);
 		return ret;
 	}
 
-- 
2.43.0


