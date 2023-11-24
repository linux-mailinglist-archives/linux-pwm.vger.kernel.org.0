Return-Path: <linux-pwm+bounces-201-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FECA7F85A6
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 22:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596C528394F
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 21:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB523C088;
	Fri, 24 Nov 2023 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0C919A2
	for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 13:52:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6e5y-0002d1-Tn; Fri, 24 Nov 2023 22:52:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6e5y-00BLvq-7V; Fri, 24 Nov 2023 22:52:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6e5x-007hOY-RO; Fri, 24 Nov 2023 22:52:17 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 0/3] pwm: Alternative way to convert leds-qcom-lpg to devm_pwmchip_alloc()
Date: Fri, 24 Nov 2023 22:52:09 +0100
Message-ID: <20231124215208.616551-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Zof9pl1mjeVT+LqEcVRl15fx4BuRDAfJ1KtMv91Dhck=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlYRsIEKkNcvF4Kz3WdRQEzWtid/2khDCfhJmpz gEeh3aAhiOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWEbCAAKCRCPgPtYfRL+ ThyHB/9bSj7OVwJzjllWnGoztK/WhudMIEMf3yTh0M+fVGF0/5RowcjW4wxc3YdLQX8mTKe/Zzq /6MyxhbhfIFU2uEpPIr+jrA2Ws/TESPBjcAlXLOR7RIxM90l2SQrKP3hHMQpAcTcXrctHKDbrIA JDS1t1GhbPnu5iYdsmEEIDCKDxbctjPITllMY/pSpIn11KdeIxEvEXE9Tz0F7Mx061rLVh5x2NF 7VKz5NAfnVf8PXLTvJLL4niLfOAuzOgtnUH3/bzobyRTO7pUhtWRuUi6UdoUEMy6ZnJZjcIT0Uo I/A7uYBan+ZLxQDZxIz0dyBY8BYr7qJDCeTiJU/P/qPE4PhB
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Hello,

on my way home thinking about my pwm-lifetime series[1] it occurred to
me how the leds-qcom-lpg driver could be converted to use
pwmchip_alloc() much prettier. Instead of patch #102 it can just not use
the feature to allocate private data and use (a new)
pwmchip_{get,set}_drvdata() function pair.

The 2nd patch is just split out of the conversion. In my original series
the equivalent was contained in the converting patch.

I'd expect that this sorts out the concerns about the ugliness I added
in two of the "non-pure" PWM drivers. A similar approach can be used (with the
same changes in core.c and pwm.h) for adapting the ti-sn65dsi86 driver.

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/20231121134901.208535-1-u.kleine-koenig@pengutronix.de

Uwe Kleine-König (3):
  pwm: Provide wrappers for storing and getting private data
  leds: qcom-lpg: Introduce a wrapper for getting driver data from a pwm
    chip
  leds: qcom-lpg: Make use of devm_pwmchip_alloc() function

 drivers/leds/rgb/leds-qcom-lpg.c | 27 ++++++++++++++++++---------
 drivers/pwm/core.c               |  2 ++
 include/linux/pwm.h              | 19 +++++++++++++++++++
 3 files changed, 39 insertions(+), 9 deletions(-)

(This base commit isn't published to not annoy the list with reports about
failed builds because of missing changes.)

base-commit: e40bd269dc0aa05aaf5390d66428601dc7433433
-- 
2.42.0


