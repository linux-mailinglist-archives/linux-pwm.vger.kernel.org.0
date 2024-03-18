Return-Path: <linux-pwm+bounces-1796-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B86287ED86
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 17:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305731F229B9
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB83535CA;
	Mon, 18 Mar 2024 16:28:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF15339C
	for <linux-pwm@vger.kernel.org>; Mon, 18 Mar 2024 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779305; cv=none; b=NEg7Gg894ke5jXCgkuWNz1cGyL7Wy6p+5HAGwqzDV+QQTtGraCiwhzEVAg3nGJKgHoQ4xp/QT+Ad2BlGS4VkcEWR+pQD19HzPnngGXllifVfd4jqYrtN27skKjIjl+CcItFup8N78IJlPAdywLDHzr3CsDgAQUT9aD4HRgrf3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779305; c=relaxed/simple;
	bh=s9JicVFj4pJmGVVQ4r+P90evKiT5bMKtXEpV6/oPFI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fTAQq9SEvZRaGtWOnoYTwQ0G1jIXVYMLboMqZwk8ga3fn9y0tumwgKJVzoZs0NVYS5phrfn4SU+sye5sVhIT+DmdrM6HffDHIR4BZ2e+VgAxwaXVMHKgljTtX6MtBK9IdC+r50/w/QTZ/xZu+VDNj/vQQGkfeFH+BAKNy5OQ1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmFqA-0007vL-3z; Mon, 18 Mar 2024 17:27:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmFq6-00771H-UX; Mon, 18 Mar 2024 17:27:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmFq6-0084a7-2h;
	Mon, 18 Mar 2024 17:27:54 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 0/2] hwmon: (aspeed-g6-pwm-tacho): Prepare for further pwm core changes
Date: Mon, 18 Mar 2024 17:09:48 +0100
Message-ID: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=s9JicVFj4pJmGVVQ4r+P90evKiT5bMKtXEpV6/oPFI8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl+GdNy9W4Yul+TxF6AO3lEUVPIz9Vovisop+ib w/mSgiPXhOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfhnTQAKCRCPgPtYfRL+ To38B/9RPIoE7KfD1gvs8Lx052TFmKt/pZgu8+BvKF+vNlAkstLnm5l4Lag4Mv16X0ryqsCfYrQ bioPj+vf4b/GKri5eDBDT1jGALIpcWPYMPHmo7fVWSe8NS9YjhuvnUaTf02eTX6u6cZ2mJKM2rB LeP/6I5/qjMX+gA6Av8s5jiW7Gu9rjuD6YwqoDmdfZ2c7tQZVYPVywnHVM7miZJkxOSJ+MzmNDu q3dE0nzCoGsUrFf019MrXUulcprnnCQQXmzkolUXG5qU4WqHSF+n9A9SVXc8RHfkYcSsWkqf3Ed qODGN2RWmNoK6gpz1Y/c7M4EV4m54agLGpZLz32r0GyD+tJk
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Hello,

there is a pending rework for the pwm framework[1] that requires a
preparatory change for all pwm drivers. When creating them I wasn't
aware of the aspeed-g6-pwm-tacho driver, just found this now while doing
build tests with my series.

To not delay application of my series, I'd like to take the two patches
from this series via my pwm tree.

To state the (maybe) obvious: This series depends on the following commits:

	7e1449cd15d1 "hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach"
	024913dbf99f pwm: Provide pwmchip_alloc() function and a devm variant of it
	4e59267c7a20 pwm: Provide an inline function to get the parent device of a given chip

The earliest commit containing all those is:

	15223fdbdf4f "Merge tag 'hwmon-for-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging"

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/cover.1710670958.git.u.kleine-koenig@pengutronix.de

Uwe Kleine-König (2):
  hwmon: (aspeed-g6-pwm-tacho): Make use of pwmchip_parent() accessor
  hwmon: (aspeed-g6-pwm-tacho): Make use of devm_pwmchip_alloc()
    function

 drivers/hwmon/aspeed-g6-pwm-tach.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

base-commit: f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
-- 
2.43.0


