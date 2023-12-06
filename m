Return-Path: <linux-pwm+bounces-313-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6830806E59
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D211C209B5
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD26347BF;
	Wed,  6 Dec 2023 11:48:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C69C1BF
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00062u-81; Wed, 06 Dec 2023 12:48:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00Dws8-Qd; Wed, 06 Dec 2023 12:48:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00FQxH-HR; Wed, 06 Dec 2023 12:48:22 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v4 013/115] pwm: cros-ec: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:27 +0100
Message-ID:  <7820e8206fc07181d5cd72b0d6990ca04951b2b0.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ZNXOTu9Wd4VOmMoUJ448fHrf+nTZVWYsvHbUE7tWg3g=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSCuISKsG0J2ktXueUqcObz/o5Yt2OCk3jk/za+F/6TH KStA6s7GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZiI2Wf2vwJqt5Zsfft7gaFi qx1brPZqzvdrtZus9swr9VELZAoWryiY41Xd7LRgx9QZboG/1A/4SqyxOjxvwtUbWudrGEIzew9 9inHZGBZx5IZezZus72oXDh45phyQpbtjnWSJpbyX6+wzH4JmSWQYXrr6QzjJ6kdv9eWg682vOF e+ZS5yP390kZ1y3izuUNlAw9WVi0vOy17i0bfa1y2aqD/Rxs7oscahY20XlM2Xtao4SFz0dZ/8K bEgSUiaedXqjaEz/pW8jTvJPKfSy+HoqaQTcwL4Gsz9AlzfKAvP3dM+t3CL/gHWdK0da54cTyte tKLgSQaH+P7S48f2q/Y7eEe7/TXQbDVX3HdDK/iC2Es9AA==
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
index b75478e37ecf..6c86cd4ba538 100644
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


