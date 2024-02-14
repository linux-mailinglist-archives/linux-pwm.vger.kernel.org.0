Return-Path: <linux-pwm+bounces-1389-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09A18545CB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C1028A07A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4471759E;
	Wed, 14 Feb 2024 09:34:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A631863B
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903280; cv=none; b=eIgEPQCQGYh+BaB/fDzPgMgSlfjWoJmzZevogjdoK4iNV/uSNUqTuIT1Jxt7P0V8Wn1yMwQnlgp2gdDev503UOPmQSjhPcJKbxLSPu8eAtK2/KNzsthIKDRB+Cv0bErvoJY37JlrhSxKAawfdiHdSv3hcM3oycEaaMHvd3xa5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903280; c=relaxed/simple;
	bh=n8WkmK8zXwx0gmZde1hbERzcObCWJ/WjRRDw6pi2QYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqgm60CZ1m3rZy6nfRohYEMu2JnxFmdKIGvb3wnlK0fUxQA5MwFn3wZSIJJk9V6QD43qL7tSm0jK1LthpwXGvwFqfJWCMSBqHTMSdH9EEQm0ZWy6gBaGdcyWZhl1tRjxRR2oHm1WNKi3rtzUUGnNhP/nATdK79+PkPga0x5y+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-00052s-I7; Wed, 14 Feb 2024 10:34:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-000fCx-Er; Wed, 14 Feb 2024 10:34:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-004Y4N-1C;
	Wed, 14 Feb 2024 10:34:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v6 068/164] pwm: mediatek: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:55 +0100
Message-ID:  <819996ee175bec0ab71acc385c78e7233617e136.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=n8WkmK8zXwx0gmZde1hbERzcObCWJ/WjRRDw6pi2QYM=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHTNqnCdu5w6NzOSoYjL7v00q3Pd7/NxNi/zrWKxDV laFysV2MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRV0Hs/xPiQ72OXtl0mivD +1RIt0HttdWHC8XEjvzSPPJw0UTHk87cnSk3YmPW7642fL44ps725xw/gZZNHVk/HqpNqRWPNGG ssXW+19+7jK9m8WqtqGuHtkiv4pm0LJGlIrrN76HpQX29SW4iX9Qdoh//V6vcle7zw8/hepHq09 TnghF7f/wMNXs/50b+KpW37Q9zY3W3d0w1czSW4fS/uEctdVvoLuFItU8TL/M112yWzvTY75Zl6 fv11Tkl86U1fn/icx9VFSzcKanbLNi8Rcq9c4bv1BP8Px2k/QIvNxg/m3ur3/+IIWvpD/GSjIcu xn9XNRfkb3qpWLC3+yGXxQyFC+lui28ER/m/u/P+rN4jAA==
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


