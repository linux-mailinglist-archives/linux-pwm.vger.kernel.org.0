Return-Path: <linux-pwm+bounces-1410-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F408545E8
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC22D1F2DB6E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5B318EB9;
	Wed, 14 Feb 2024 09:34:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D018C3B
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903283; cv=none; b=LxobqHeOVnR0bDHzhJi9Wo32WJM4YkPxAuisxSEy92cQj7+Gi1ArregBSWlMi5SqPeUL/HYnBCtbimvJz3ih2R02WJNBUS/CksKFiRKDerBmM9pyE7d/bXMTSgMLOGT/aWz9XQ4/WvW3pP9hEYQmB2T3g4sSeQ3Ar9bswkRuRuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903283; c=relaxed/simple;
	bh=yvSEaJYnF7CooEKDOl/Y3z2R+Ytvs9m7kGSX9/DCHgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6eW5APZtLPQ7KwqxyS8ak+ulhhJWgfKw7+7pxZAAU1OMW5Ts+5qxQASD7aapTHG9uobfHaQ9txBBfR0SdoBpdqiXknXegbJGrBLYDfTinXY5rq2hSGXG82gKYyc7ETi7LDJqiIkAMiR30B2/PvYHcjmoxfvh7zRkGSEKoEAaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-0005aW-AF; Wed, 14 Feb 2024 10:34:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-000fFA-SI; Wed, 14 Feb 2024 10:34:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-004Y6r-2a;
	Wed, 14 Feb 2024 10:34:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-pwm@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 104/164] pwm: sifive: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:32:31 +0100
Message-ID:  <170c3c61707992cbc57dce31f70c168fcd3dbe51.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=823; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=yvSEaJYnF7CooEKDOl/Y3z2R+Ytvs9m7kGSX9/DCHgc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjCx1+v/kJVRtfzLCiVQGYhc60gZOm86GULV dms9EZrE5iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIwgAKCRCPgPtYfRL+ ThQcCAChumSvRSxpwTj3umlxZHziiK3tNtRFcerDwhF08tCqzl94WwnIzoys1G27O8aRtDpTplT zQarcYL1zR6psvcRQCsOuvLEIDlic0AGYa+p5gHQ/UV1IkW1e9WTZ0xxYtTTAPKs1ZYpLUn+oj/ Ld1KHPQ2Eart8g/6OppO1irj6yHGEKXKId/F5x3pLUvuDSFPrLW9rDt5XmRnLF+fYsjSllRb8oX eNdeyP1GF2adtN8H+mFqgT8tnKg0GfWS5cELUxXGJa1ry5zOYXsi3rjLYmjun+70BSdqTWe2wPH xcd8oj3ysv+WpSBMYe2INRd+9uyAWRxyVgUJzGATzbLpMPhJ
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
 drivers/pwm/pwm-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index ed40a687f909..6abe91d2f21c 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -186,7 +186,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!enabled) {
 		ret = clk_enable(ddata->clk);
 		if (ret) {
-			dev_err(chip->dev, "Enable clk failed\n");
+			dev_err(pwmchip_parent(chip), "Enable clk failed\n");
 			return ret;
 		}
 	}
-- 
2.43.0


