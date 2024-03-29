Return-Path: <linux-pwm+bounces-1830-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10364891697
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 11:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBE31F20EDA
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40911EB4B;
	Fri, 29 Mar 2024 10:17:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE975024E
	for <linux-pwm@vger.kernel.org>; Fri, 29 Mar 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707424; cv=none; b=S/aKo+VEG2lDYaDFfRYIVTm28yeEBGO2fKp4cpjUh8QYW1C26pkNS6TSl09BLytrXb7aL/9TA/iiHhDVKAVXaL9Obr+UbXo49i4615Qh9M3KtPskMKAaNJROU14jy7sSMmdAeHam54Ba2wWBRVhGnqP1PugjkPDBq5nmapQxfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707424; c=relaxed/simple;
	bh=XL3poH2y8oEo0pLJCjDVIsvxBQ8qW/YAq8acjcctwRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n+bXfeVqE5oCxJeN2X6F6RKq472M5FmTSVilcneXqAeZ4nEyO6AgEGhoReQKfWVjvHNZNkwErfS2+lHfl74xA51KRTXwPS2T3tutgNLI8T1PDDoDNB+M3R7cH1eGlmO4kml1RyEOoHUcmna3qNbftYUXZwSGWCWRPRosYqH462A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rq9IB-0004BN-TB; Fri, 29 Mar 2024 11:16:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rq9IB-009Ao4-E8; Fri, 29 Mar 2024 11:16:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rq9IB-00DOxV-18;
	Fri, 29 Mar 2024 11:16:59 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Cc: kernel@pengutronix.de
Subject: [PATCH] pwm: Don't check pointer for being non-NULL after use
Date: Fri, 29 Mar 2024 11:16:48 +0100
Message-ID: <20240329101648.544155-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XL3poH2y8oEo0pLJCjDVIsvxBQ8qW/YAq8acjcctwRY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmBpUQt/bAlbtOCdK99qXyjaQysFP4U5wnlFF1Z PMtdUOfQeSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZgaVEAAKCRCPgPtYfRL+ ThIvB/9k1FJsv72fn7e0/c5elbO0xHAZhZw6YEtka/bRrpkg4v4te3SrIHyU8A/Z1U0eEs47oFs 9XLIgzi9yeJzMnswgmzenGJ0uVPjVnEHH2B+DC3IHOBFug+iGzJZCW5hS2+t+6i4/XftUOYyZkN 7zNyjJ2B6blZsbq2ZvUmaixe0VNcbRFyHaKhEN/8Lh5dOLZq8KzZRB/WeTDVW+poyLcjuYP4BsU aXf2SKknRSz5PXPjabVBHakoOr7Y9SBiB8wwPd9f/q8jQKfqaDd4owezMcgAp84qLvpOZbwhW3O kBW24oiwrzs6JdozJnYsLTgarad2g1ePqDV6LBIfpOp7cCvS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

After assigning chip = pwm->chip; the compiler is free to assume that
pwm is non-NULL and so can optimize out the check for pwm against NULL.

While it's probably a programming error to pass a NULL pointer to
pwm_put() this shouldn't be dropped without careful consideration and
wasn't intended.

So assign chip only after the NULL check.

Reported-by: David Lechner <dlechner@baylibre.com>
Fixes: d60bc2995732 ("pwm: Add a struct device to struct pwm_chip")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 7f41ab087b98..54a62879fffa 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1866,11 +1866,13 @@ EXPORT_SYMBOL_GPL(pwm_get);
  */
 void pwm_put(struct pwm_device *pwm)
 {
-	struct pwm_chip *chip = pwm->chip;
+	struct pwm_chip *chip;
 
 	if (!pwm)
 		return;
 
+	chip = pwm->chip;
+
 	mutex_lock(&pwm_lock);
 
 	/*

base-commit: d60bc2995732489766cbe650fc367e036ff6a0e0
-- 
2.43.0


