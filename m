Return-Path: <linux-pwm+bounces-477-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5778A80B6DA
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 23:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E081F21000
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 22:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99C817F2;
	Sat,  9 Dec 2023 22:35:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB111703
	for <linux-pwm@vger.kernel.org>; Sat,  9 Dec 2023 14:35:31 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rC5uw-00032B-Ox; Sat, 09 Dec 2023 23:35:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rC5uv-00EjdI-Qy; Sat, 09 Dec 2023 23:35:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rC5uv-00HPIP-HQ; Sat, 09 Dec 2023 23:35:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 0/2] bus: ts-nbus: Two improvements
Date: Sat,  9 Dec 2023 23:35:07 +0100
Message-ID: <cover.1702160838.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=543; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=A3+f2jcnsasFx6Jum7xwxcbj9TpwQIGUeOY/mLhyMmI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBldOuaJCCihduHrs6TFAMXabjptWsU/bsWcuJ+J wOy7MFJ/TaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXTrmgAKCRCPgPtYfRL+ TunLB/wM63/YVf0GzEuTjgYpzexC2w53cnGbRptRuNyTXk9NPkux2GJvzo0LVr8YmEqTV6ZkBLC sEU0A3y/O/52NBmKV55fOTb0AwX56HR967jtQ92iy87KB5903HB6TfPnIU/xb7wuBL0rHAVenDa lJTESSGwDItn100I7gxsYObZ+qvNDpvc500k4iJJD4+aV/143SSvhfJGwPLRE8j8Ygjg0rKe3t8 nCfEyTutm200MJGXlAKWboaQKrOcjWze4uuOkuEEnwnJpQTUQnSlDtcSd+SL2QtrsYj9aBUkjNk wIaaLaLnL7lZMqQQvWEyWpdKPAX5zW0TcOquw53nBQI81tTl
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Hello,

while looking at the few last users of pwm_config() I found this driver
to be easily convertible to the atomic API. The second change is another
patch opportunity I noticed while modifying this driver.

Best regards
Uwe

Uwe Kleine-König (2):
  bus: ts-nbus: Convert to atomic pwm API
  bus: ts-nbus: Improve error reporting

 drivers/bus/ts-nbus.c | 80 ++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 47 deletions(-)

base-commit: bc63de6e6ba0b16652c5fb4b9c9916b9e7ca1f23
-- 
2.42.0


