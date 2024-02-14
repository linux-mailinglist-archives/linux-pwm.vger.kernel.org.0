Return-Path: <linux-pwm+bounces-1396-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADAE8545D2
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5041C27029
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75765182B5;
	Wed, 14 Feb 2024 09:34:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C58134AD
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903281; cv=none; b=I578s37UKclVddl7zevXhpKdELsFTJI+Q/fomjPSs1YKooj01SM5DW426nxTs4OI8uBr0QBPgwtWq7hUqwJZl2ZI+x7rvRlQgaYOrXLF8PGBkdhKWb0xWTSU7Mss5zINMH1f8EApk7LulFin94iAWOsyoVsrQ+geILjD1++Jr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903281; c=relaxed/simple;
	bh=/2pXPOuSmi0JOEICtFc+ZUbDiXGwS0BPt9xWNJheEuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biZH0qum5U03N6rsERn+ZCR58Z6B9mAJKI+I4zuE/j3iTtmXU0E5fKlLWyPldkC0Pe43Uh7u8THqoJz4hnZRDQVhguWYoMY4rZVoR4AccfOnkzo7ef0/LfO7/TuwlyFsvtYwAeaUkZoBOVPkHaRxVyy15j4iZzNlR6U729FV+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-0005Ku-2F; Wed, 14 Feb 2024 10:34:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-000fE6-Cx; Wed, 14 Feb 2024 10:34:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-004Y5b-14;
	Wed, 14 Feb 2024 10:34:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 087/164] pwm: rcar: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:32:14 +0100
Message-ID:  <8b33a106c84517430d90ee4a8dcb878d0fc3bad5.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=/2pXPOuSmi0JOEICtFc+ZUbDiXGwS0BPt9xWNJheEuY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiv44d8zPN5knwTVQWv11oQ28jtGGyVDdmhF 0KxamMR81qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIrwAKCRCPgPtYfRL+ Th0NB/40WMaVkVwNmN1gZ3JYpQtJcqXswbpHxcc0UR++nwtTT5Gv7+16PYJXgwOLux1/AB7F1rr G8R56MUlRkwDnjiz/WGdnikCz4O2cGplKvAnAx6B2OF7PT57OiDn2yEx1pMixWkNs7rcTmlYecP hq1DUajqxsgbVmP7g7QqcOqvW/B20X0evldpsNAdBFtxLECEfGXNpAIcuA5oa2xBnmBViKZi2cv 1IeBMWzhlTt0QqgT2zUAYxfuyAzzzmqYVli3WS383Pz3fB/axf1EVAu+gBQqg7MX8EXuPcb7gZV MhL5aBNaoCvW3P7RsmsI8mJljgmS3gbkwTWeWQadeofbjZVL
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
 drivers/pwm/pwm-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 13269f55fccf..4838762137d1 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -132,12 +132,12 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
 
 static int rcar_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	return pm_runtime_get_sync(chip->dev);
+	return pm_runtime_get_sync(pwmchip_parent(chip));
 }
 
 static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(pwmchip_parent(chip));
 }
 
 static int rcar_pwm_enable(struct rcar_pwm_chip *rp)
-- 
2.43.0


