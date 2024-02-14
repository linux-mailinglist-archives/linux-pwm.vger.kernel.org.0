Return-Path: <linux-pwm+bounces-1344-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC768854598
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7652228887F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9598C18B14;
	Wed, 14 Feb 2024 09:34:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A978175B9
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903269; cv=none; b=Q9P0VACe/AIn9+f4PiyQuOLBPDTxif2IbQs5MkDN3xXdxLpwFDWhzAodv3sfEmYw/oQ59YNy5JfZaUjNOzHTHOf2L0o2Tx91v7cGmC4nw5WW6FLSG1sGbRx0h72PiV58ntu6ZRe+qynRmjIgaJtYCcBrL7q60gczsauMRZWyFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903269; c=relaxed/simple;
	bh=Ep0s6J6ypHxZo5gEnEQY44o+aQvWJ0Zh0WSAqFDZ4+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eojIMcpIAk5Tk8QqOLAxzXKivasP/3LNuOycCRSrBPhJmIDnm5S3wG2GQcATWt9b36ReK9TF3Bn6INtGVX9rtq6WKE8qkcU86jm1QMSVj5oBa2WdAzK6QUO9Fl+4wQ79/ePL6k3R1rOdxy8r9xsyB5Gyetj1yukiHsff6eZuELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-0004Z2-Tc; Wed, 14 Feb 2024 10:34:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-000f9u-2m; Wed, 14 Feb 2024 10:34:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-004Y1P-01;
	Wed, 14 Feb 2024 10:34:22 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 027/164] pwm: crc: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:14 +0100
Message-ID:  <a41b62365295be9debd4a9aaa80ca87fca35b320.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Ep0s6J6ypHxZo5gEnEQY44o+aQvWJ0Zh0WSAqFDZ4+g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhpuPJMhlpsn8/r5a/C3wLUUaqSQ1Lb9Sl64 AyybT8PmeSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIaQAKCRCPgPtYfRL+ TjAgCACUzyXLguAmAb9YrG4ibG9c+ZGm7GvQQElI6upaJXiy6CL6RZew4gNpG0GLeY5C6AOclXB kZd1cXZxMAajkm45lxoLWcWhqpU4hvTZOwCqEgsNhqXY/36uusXlkkBgvkKu2GObQWwvF9FrYlm ZFV252DhzPC5Pgv/r21NjdNnVrCPv0n8qCGLXzU0A6uWpm8D8J5Z1kjiWDPAxtWGktKPTghqtfy sQ52515LBhkhSek4L6ubboeuqoSwUeklM4dbGCh7BJhYytknARD2TbSkOHD7ehRsSbG4MZS/S12 hP+96oHARWRfzUgMZFwOc37i02G+429VRmqHmxYVtttrzINn
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
 drivers/pwm/pwm-crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index d985a9d3336d..c8a852345a97 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -55,7 +55,7 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	int err;
 
 	if (state->period > PWM_MAX_PERIOD_NS) {
@@ -125,7 +125,7 @@ static int crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			     struct pwm_state *state)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	unsigned int clk_div, clk_div_reg, duty_cycle_reg;
 	int error;
 
-- 
2.43.0


