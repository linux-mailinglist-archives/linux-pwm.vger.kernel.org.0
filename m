Return-Path: <linux-pwm+bounces-312-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66309806E56
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE621C209DD
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CA4347A0;
	Wed,  6 Dec 2023 11:48:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7081A5
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-0005ym-Iu; Wed, 06 Dec 2023 12:48:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO5-00Dwrh-N4; Wed, 06 Dec 2023 12:48:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO5-00FQwp-E6; Wed, 06 Dec 2023 12:48:21 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: [PATCH v4 006/115] pwm: cros-ec: Change prototype of helpers to prepare further changes
Date: Wed,  6 Dec 2023 12:43:20 +0100
Message-ID:  <c66007e1ef898940f115d2a71f57f153756b9b70.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2941; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=fGJDQCeQRT9jKAIUsZfF4QA9US0W3363muJM3zVfIkc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5YVw9H8R9Y3bsObmFf2PQz+E0WfHg7V32IJ ni1bXvruGaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeWAAKCRCPgPtYfRL+ TrqVCACNc5c1w1P/g/DJm4bqg0IrI+gK3VGr/7noiXURduku3F7UCfxnnJYC9XIFeFvMIL8XS/4 ybsStAirwOoU2Si7vLxlSArb7YTTAvUHx45Q+x30P00DkC6vOMH9E66qyce+7WSJFud7x4g9BWj vu8j5m3VAVkpvijVHnpapzMVAtkzTaOmQUMQJ0UgkQ0S5VkCzdfJg6T4hDg0ZXLSP47u9mq+rVQ 1lj5c4LkoXbKfSeXM4Rfa35NF0RIW1r1L2XFunuy1PRrhIrybyjvmRjd3XZlcfVRaYQCIdiM5LF YLi5juSnmMW3s891FdAQUZtQjiOKh2naN0nao4xkD5xbK9BT
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

pwm_chip allocation and registration is about to change. For that the
number of PWM devices must be known earlier in cros_ec_pwm_probe(). So
make cros_ec_pwm_get_duty() and cros_ec_num_pwms() independent of
struct cros_ec_pwm_device which is only available later.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-cros-ec.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 9a8f1b6a4e13..b75478e37ecf 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -94,9 +94,8 @@ static int cros_ec_pwm_set_duty(struct cros_ec_pwm_device *ec_pwm, u8 index,
 	return cros_ec_cmd_xfer_status(ec, msg);
 }
 
-static int cros_ec_pwm_get_duty(struct cros_ec_pwm_device *ec_pwm, u8 index)
+static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, bool use_pwm_type, u8 index)
 {
-	struct cros_ec_device *ec = ec_pwm->ec;
 	struct {
 		struct cros_ec_command msg;
 		union {
@@ -116,7 +115,7 @@ static int cros_ec_pwm_get_duty(struct cros_ec_pwm_device *ec_pwm, u8 index)
 	msg->insize = sizeof(*resp);
 	msg->outsize = sizeof(*params);
 
-	if (ec_pwm->use_pwm_type) {
+	if (use_pwm_type) {
 		ret = cros_ec_dt_type_to_pwm_type(index, &params->pwm_type);
 		if (ret) {
 			dev_err(ec->dev, "Invalid PWM type index: %d\n", index);
@@ -172,7 +171,7 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct cros_ec_pwm *channel = &ec_pwm->channel[pwm->hwpwm];
 	int ret;
 
-	ret = cros_ec_pwm_get_duty(ec_pwm, pwm->hwpwm);
+	ret = cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, pwm->hwpwm);
 	if (ret < 0) {
 		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
 		return ret;
@@ -227,13 +226,17 @@ static const struct pwm_ops cros_ec_pwm_ops = {
  * of PWMs it supports directly, so we have to read the pwm duty cycle for
  * subsequent channels until we get an error.
  */
-static int cros_ec_num_pwms(struct cros_ec_pwm_device *ec_pwm)
+static int cros_ec_num_pwms(struct cros_ec_device *ec)
 {
 	int i, ret;
 
 	/* The index field is only 8 bits */
 	for (i = 0; i <= U8_MAX; i++) {
-		ret = cros_ec_pwm_get_duty(ec_pwm, i);
+		/*
+		 * Note that this function is only called when use_pwm_type is
+		 * false. With use_pwm_type == true the number of PWMs is fixed.
+		 */
+		ret = cros_ec_pwm_get_duty(ec, false, i);
 		/*
 		 * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM
 		 * responses; everything else is treated as an error.
@@ -285,7 +288,7 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	if (ec_pwm->use_pwm_type) {
 		chip->npwm = CROS_EC_PWM_DT_COUNT;
 	} else {
-		ret = cros_ec_num_pwms(ec_pwm);
+		ret = cros_ec_num_pwms(ec);
 		if (ret < 0)
 			return dev_err_probe(dev, ret, "Couldn't find PWMs\n");
 		chip->npwm = ret;
-- 
2.42.0


