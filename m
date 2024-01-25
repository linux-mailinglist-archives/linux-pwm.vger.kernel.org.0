Return-Path: <linux-pwm+bounces-951-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F314D83C1B7
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71B7290552
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFAB446A0;
	Thu, 25 Jan 2024 12:10:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AE93D98E
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184646; cv=none; b=Tm++o4GtleotDjzs0QGDevKu1xVgdjdX6vr85sUZwe81WbrpywOYjqCf+dmJ1YWsof/AwrJOlkqfqxB25p6IDlZ4mTZ4izGwx3LNSvhavoajHSf2qvASYXa2RqCTEB/UINY7ukZc+nJBrcoBZNgIpgU8t+Bh2hkTXdXRkQm7CfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184646; c=relaxed/simple;
	bh=FjGukNj1cYfdDeJbaFr89/JaJYedpj7bOyWFB1DfTbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0e2p46EF38Sf68Edm0wAmP94XW6XPjhTJVNLALkKPsdiW+gjozITD/YCF5FO5u45UA09zAdBfx7ip9mMCabsxF1Hw53LVRmpJSHaCeR7/uvPCwXiwZLrxjuCsQHMl0GAKqtAvImrSx5gfDhlWDaJKoGVxOVl0wFto2bBjY+tzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-0003gR-D6; Thu, 25 Jan 2024 13:10:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-002HPa-Jm; Thu, 25 Jan 2024 13:10:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-007mz3-1j;
	Thu, 25 Jan 2024 13:10:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-pwm@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 014/111] pwm: imx27: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:36 +0100
Message-ID:  <b4c1865612be7f5f78fc77a6cd858dec09dd46fe.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=FjGukNj1cYfdDeJbaFr89/JaJYedpj7bOyWFB1DfTbE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRN/l6V/GWyigEb/iTefuf1aK6L1azGyfUZrOuL7CxSM 5vSdD52MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjARCS72/xFfpuToNHFLdZUs +BL1VFcgS42XnT9nw5UYo/UHY7b9018atnh64P2Sx1kqDj8svO7te39S2ctK9nxypHkk8620fbs Vu2MyAvSfz96jsf3BghiPbOv2rge+JT7mCe739qzPUM81/zlhh/GsdYtvKy/N28R3kffknZh0md fubyXNWB558AeUWLN9kpG9Xvvmm9gvwT2c9zyWbL9p0CY/5T9n+Q+NnesVm20PWqQJTG1RlPhXO HHdinIjcZ2FgvcX/Hj3vn/F3sU979Mc3gpqayX8a7zKl9rqs4JdqM/WbPG3mDMu2mu3NlyK+m+0 YE2UoL/j0clNztOMXmkxnvpvdI75yOKmfQoFE4oaCsR6AA==
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
 drivers/pwm/pwm-imx27.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 7d9bc43f12b0..5d796453519a 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -145,7 +145,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 		state->polarity = PWM_POLARITY_INVERSED;
 		break;
 	default:
-		dev_warn(chip->dev, "can't set polarity, output disconnected");
+		dev_warn(pwmchip_parent(chip), "can't set polarity, output disconnected");
 	}
 
 	prescaler = MX3_PWMCR_PRESCALER_GET(val);
@@ -177,7 +177,7 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 static void pwm_imx27_sw_reset(struct pwm_chip *chip)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	int wait_count = 0;
 	u32 cr;
 
@@ -196,7 +196,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 				     struct pwm_device *pwm)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	unsigned int period_ms;
 	int fifoav;
 	u32 sr;
-- 
2.43.0


