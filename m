Return-Path: <linux-pwm+bounces-966-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B58283C1C3
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7A21C22C13
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148B45026;
	Thu, 25 Jan 2024 12:10:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF8141742
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184648; cv=none; b=T4v0J/BY1epJQS/rMMofTyRLANFme6Tac3dJWX77yG9tvVnoXrmSz2MtS3WHb8csQg3iQXNBXTYtrE1E/z2OOcX5BXQCzAN5Bv+SdIeonunEOUa/XZ/Ag2HnmWwXPhElRc4HzPRuvwKHMqoMcQ7Ypn8HNb79VDnPJMqspbu3dhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184648; c=relaxed/simple;
	bh=u3GNrzdZ0E6VhvixW9xjo+R0sSVqJ6WMNnaZDq30XSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLGPrrDKKjAtx1nEuaSx2SnjuM3vPklhYmhDaz2s8baMR6i+E0xxNS8w/ClPwBCbvgkZksEhhhvGIaapUQIQjYAqM6sS6bK5KywFFuEDhio2B32enP5J3GgYfowJqhf70BUv0gxbsTlYCbOoMp2zly+Drb8DSOTxXojtEpMdXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-0003iz-R1; Thu, 25 Jan 2024 13:10:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-002HPp-Df; Thu, 25 Jan 2024 13:10:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-007mzJ-17;
	Thu, 25 Jan 2024 13:10:43 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v5 018/111] pwm: mediatek: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:40 +0100
Message-ID:  <a8659059ce62805d5a499edb823ace388f374d6c.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=u3GNrzdZ0E6VhvixW9xjo+R0sSVqJ6WMNnaZDq30XSE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9OmFrBGbhFht5Thk81FH0FpaFGolMcp7/J6 C6IpjBvbTaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPTgAKCRCPgPtYfRL+ TljzCACbatZ+qvtz/DkM39dSpNt8mCZBcG3gGoIJumxpmQWDQKS9u/tVmbD5QiiDapasn50JKaC JYrHAROuEMyVO1hDSoZLQPhSGzlTJW0lhwhtVTDKEiTUZ1gy2vdCjxH/NI9d+2lyuGsWhvs/w5m joYWO05vgVrbB6Z5Hw4QDsDw9Zv3NL3u1tRoDkwGk+H/EQ7ies9ArY+92pIl/z4tTn585jXXT1o twBTa5tiE3O4lbsF7PPM8gxjwGsOQiPJmuZwCXY0NCUmTWJ0CMPNgZ4GhGSAhgbXFszVfrREqnK z9HYAyt3i6OJEim6eLUrWSsxVMVdGh/gjLYaL20S+TH2lhfA
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
 drivers/pwm/pwm-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 562102a47ac0..6cf7543a3826 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -149,7 +149,7 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
 		pwm_mediatek_clk_disable(chip, pwm);
-		dev_err(chip->dev, "period of %d ns not supported\n", period_ns);
+		dev_err(pwmchip_parent(chip), "period of %d ns not supported\n", period_ns);
 		return -EINVAL;
 	}
 
-- 
2.43.0


