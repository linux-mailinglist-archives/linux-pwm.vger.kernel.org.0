Return-Path: <linux-pwm+bounces-945-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F4883C1AE
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D209328FC55
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2EA3F8CA;
	Thu, 25 Jan 2024 12:10:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A816C1CA83
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184645; cv=none; b=IeKg4BI2NWGSQ1Dep4+0EZ2pua1race0e13cg2ytMIN9EcOjrhWogzmpWmtCqrGmKbAGFQUsVOlQVhIU2LnHnCG0W3PgZF/lY3qmffdeVvuk6zi2zNVtK5XuObxKMVQvqukPF+x9ViWIZTAyBAIRRFELwHdbkdOuqxzTzDGCF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184645; c=relaxed/simple;
	bh=hJgSdC2n9RSk5u06nSDoTge/3JwjiJ/09/04zNqldz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tshR0XKP64h3t6EDTASC29oLyKy6qnv0c5YhYHb9mvfjazIR6mtJarfVNg1Fv5qYhAENmumxvNFus7zPjHivlPw9QRRri9UnPGixFqWez8eO5IqVIBFwuCNr8xVmya3FvWoN0Bu+WAe7SM322Ne3zsRUfMTA2VvdL+V9pBd7JBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ6-0003ZO-LH; Thu, 25 Jan 2024 13:10:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ6-002HOp-7X; Thu, 25 Jan 2024 13:10:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ6-007myC-0V;
	Thu, 25 Jan 2024 13:10:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Benson Leung <bleung@chromium.org>,
	linux-pwm@vger.kernel.org
Cc: Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	kernel@pengutronix.de,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v5 002/111] pwm: cros-ec: Change prototype of helpers to prepare further changes
Date: Thu, 25 Jan 2024 13:08:24 +0100
Message-ID:  <578f3c0f4394ed97da2d7ff1a4d2f4b95f3b24f6.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2990; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=hJgSdC2n9RSk5u06nSDoTge/3JwjiJ/09/04zNqldz0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk879DTV5RgyMuiu5l76SHkNXAULB1F4/+1P8 +yKEemB7DWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPOwAKCRCPgPtYfRL+ ToUdCACGKvwElqSgGqz6RsHoD/sCB/nxRoi97yR5kSsBsvSUyTFnaYKUo1WZnNKYeGHQhU+O6uj pzNcjNn1WsUMBfMWvoIXrmfEAQUE5WAILJ+81eyAy/v8Vrf0y+dCNDcbe91Us4QtUBFsBSmQhVD JQ9MwpsWnYnVNRg7TzGp0Y6KKLNJSE+P5sYjbonQ6zeSdRT7/yi33lsRGZ8yN7WOxnVH+z//+/T Wauigka+AIPfPF6schhs3Hloqoha1EOT9AqXCBMCg29ug7XeYVuLWnNO4unDkGXx5fKn7HXBVfl sMtzmqKvK+Ut0WsbzEOIqAOa8Gaq3oIKEjBpQI8NEIvcM7jF
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

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-cros-ec.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 339cedf3a7b1..e556f6218dd7 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -93,9 +93,8 @@ static int cros_ec_pwm_set_duty(struct cros_ec_pwm_device *ec_pwm, u8 index,
 	return cros_ec_cmd_xfer_status(ec, msg);
 }
 
-static int cros_ec_pwm_get_duty(struct cros_ec_pwm_device *ec_pwm, u8 index)
+static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, bool use_pwm_type, u8 index)
 {
-	struct cros_ec_device *ec = ec_pwm->ec;
 	struct {
 		struct cros_ec_command msg;
 		union {
@@ -115,7 +114,7 @@ static int cros_ec_pwm_get_duty(struct cros_ec_pwm_device *ec_pwm, u8 index)
 	msg->insize = sizeof(*resp);
 	msg->outsize = sizeof(*params);
 
-	if (ec_pwm->use_pwm_type) {
+	if (use_pwm_type) {
 		ret = cros_ec_dt_type_to_pwm_type(index, &params->pwm_type);
 		if (ret) {
 			dev_err(ec->dev, "Invalid PWM type index: %d\n", index);
@@ -171,7 +170,7 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct cros_ec_pwm *channel = &ec_pwm->channel[pwm->hwpwm];
 	int ret;
 
-	ret = cros_ec_pwm_get_duty(ec_pwm, pwm->hwpwm);
+	ret = cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, pwm->hwpwm);
 	if (ret < 0) {
 		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
 		return ret;
@@ -226,13 +225,17 @@ static const struct pwm_ops cros_ec_pwm_ops = {
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
@@ -283,7 +286,7 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	if (ec_pwm->use_pwm_type) {
 		chip->npwm = CROS_EC_PWM_DT_COUNT;
 	} else {
-		ret = cros_ec_num_pwms(ec_pwm);
+		ret = cros_ec_num_pwms(ec);
 		if (ret < 0)
 			return dev_err_probe(dev, ret, "Couldn't find PWMs\n");
 		chip->npwm = ret;
-- 
2.43.0


