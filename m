Return-Path: <linux-pwm+bounces-943-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C6B83BC66
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 09:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB76283888
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47771B818;
	Thu, 25 Jan 2024 08:57:08 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D471B966
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173028; cv=none; b=r7xBXbkNTF2U5oqhD2A5Y/dgsiuWLX36vSzj0Vahfg+Etw6yWHybWOC9vjKOLbGfBfx0JzbCSnjlBSVXuitBqOu3IdMJe793yNHn97wsFAEkGCCT81v8Zu4yNHf0QOz41IOp/1O1m1JKmeFtyapLu+3cuciauu7LqIoqc8OljkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173028; c=relaxed/simple;
	bh=LgAKJbOYZ3rv7aqdPZe/a5Rf0IWWlx0GgvDlWM9aPR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FsUL49Bxxk7OUem9Dia6TnjVbHgzqXhRwvy1LImj31QLNBehcwhkgePSCsN79ZYoeIBQyPcfR07F1oxJ//w5HYt1YG2UCxpCMmFcm1af6M7Bu5cu6bDb28E4hOqmR1jafFbxx1Rw4qmS/Yv/5efNR0hTrEo4jHC4GvLhcRd/cKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSvXg-0006xo-HG; Thu, 25 Jan 2024 09:57:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSvXe-002FDN-Nt; Thu, 25 Jan 2024 09:56:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSvXe-007hEY-25;
	Thu, 25 Jan 2024 09:56:58 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH] pwm: mediatek: Update kernel doc for struct pwm_mediatek_of_data
Date: Thu, 25 Jan 2024 09:56:49 +0100
Message-ID: <20240125085649.1571268-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LgAKJbOYZ3rv7aqdPZe/a5Rf0IWWlx0GgvDlWM9aPR0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsiJSPNz4mUO5rzm4585pLiubJTxJQ2Ceudupx I5A4wQr1GCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbIiUgAKCRCPgPtYfRL+ Tuf3B/9ofxPplTuOVfAlQiGOiwTd6JsF+EpstZ9JS1ccDxb6d80IwkTzJYuMxwKdhtjnnuPH9IE tfOLXpC85kKKyZcVkyiPatghz5uBappQ3eOMs6nsU4nfb0720SwbY7jhnlJOGSTjz4TTlwuVD1T pwm8OQ9YP2+Gw4jLvJdYSdbcwaN2SdipOQKBKNWz7RFO/+iGY4jV4bz7FJomawqtZL2ITdW4keY 6y6RJP78NTg7VVxB99UlOFrA3xETZUUFzL/eazyjDuRQGDHMXnBMNa8iD7RX3qgQ40tu/ahkPet lz9b8PpM/GWK6c6lAUF4D6x9aXavMxKXxYRtigiSzFq5j0yT
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The struct never had a member called clk_freq. This fixes the W=1
warning:

	drivers/pwm/pwm-mediatek.c:60: warning: Excess struct member 'clk_freq' description in 'pwm_mediatek_chip'

Fixes: efecdeb82f21 ("pwm: mediatek: Allocate the clks array dynamically")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mediatek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 17d290f847af..562102a47ac0 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -47,7 +47,6 @@ struct pwm_mediatek_of_data {
  * @clk_top: the top clock generator
  * @clk_main: the clock used by PWM core
  * @clk_pwms: the clock used by each PWM channel
- * @clk_freq: the fix clock frequency of legacy MIPS SoC
  * @soc: pointer to chip's platform data
  */
 struct pwm_mediatek_chip {

base-commit: b578dc69e6b1be72909b6f961f20c41019b233ee
-- 
2.39.2


