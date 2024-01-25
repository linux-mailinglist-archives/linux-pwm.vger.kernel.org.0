Return-Path: <linux-pwm+bounces-947-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B509683C1B0
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B17B1F217BC
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C874123F;
	Thu, 25 Jan 2024 12:10:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D005036B0E
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184645; cv=none; b=XiL9ySTdOaJz889O3tFJMh/AWzKOgYym8BygQUpsobEM1zyPZZ5T4n9b+PIlyQRyDnMtSmuWek8zkWXwCu25YRo0OfK762QAa8J45ZC5EFpX6SIixDitBrnsBskI2p7wTnTs0zwiIEYygOcBqu1Zpeu2HHbrQBlQTr1+nbN6Cd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184645; c=relaxed/simple;
	bh=QAwdGsDD3nCsJGs4OgRRdVziw7oMhwIuCi4wAgw2bGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S50WnN8vAQHMBwZRacoR7Qj7kjFU3dWxjfl6fXgNr8PW1a34PxWtOYwCFQv9IBtDK0zT4T9Dv9e3kBKWm/GZ7a0fZHRYU5p0Ss79+k2MaCh1DrQ77kaLaof6SRY7iR1o9gLE0Z+nOYdsC0hwUAuLjAZOFa8T9Sq9n0cg5nARIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ7-0003aL-RM; Thu, 25 Jan 2024 13:10:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ7-002HPB-DE; Thu, 25 Jan 2024 13:10:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ7-007mya-14;
	Thu, 25 Jan 2024 13:10:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 008/111] pwm: crc: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:30 +0100
Message-ID:  <033e9bcf766a9fc3a62952c694a4c2010c4857c0.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=QAwdGsDD3nCsJGs4OgRRdVziw7oMhwIuCi4wAgw2bGY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9Dxjy4365oK7pOGQ5AdmDv2X1NF3q3IO5Zz WrfA26cUdKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPQwAKCRCPgPtYfRL+ TmX+CAC5OaRFf0TiPuNogfcoju5VL8ifLWCY+QbdsCI5tD2HRZSSfMv+bW1pGbkYti//1qTrfKq o21RIwu91YstLx1m59YlhlZM7Dbwy5l56UDW9luIrMc4fwgyLnuteZlRdupgl3qSQQlDNdWCT4v /8h528mbx/8iKqRTASr1L0StrsbelbxRAkAZpAWz/nuzYzqIAS4uwmUBP1xmw/i6Yu30wawNapt /ePxOpjL+1ZipMQRYwu3+TiTj9/3z4IwTUDw0ZU9dfcpwgmqyl7oWe3x5lAcGx/nT3cYmYUf5z2 E5V0TeTvdC7LKkHAANInzpE45YEBADp2bWulWbQqxNv851xM
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
 drivers/pwm/pwm-crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index e09358901ab5..c8a852345a97 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -55,7 +55,7 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
-	struct device *dev = crc_pwm->chip.dev;
+	struct device *dev = pwmchip_parent(chip);
 	int err;
 
 	if (state->period > PWM_MAX_PERIOD_NS) {
@@ -125,7 +125,7 @@ static int crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			     struct pwm_state *state)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
-	struct device *dev = crc_pwm->chip.dev;
+	struct device *dev = pwmchip_parent(chip);
 	unsigned int clk_div, clk_div_reg, duty_cycle_reg;
 	int error;
 
-- 
2.43.0


