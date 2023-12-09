Return-Path: <linux-pwm+bounces-480-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8F680B750
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Dec 2023 00:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1651B20A16
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 23:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519811D6AB;
	Sat,  9 Dec 2023 23:01:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775E8F9
	for <linux-pwm@vger.kernel.org>; Sat,  9 Dec 2023 15:01:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rC6Jl-00068q-Db; Sun, 10 Dec 2023 00:01:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rC6Ji-00EjgJ-Ts; Sun, 10 Dec 2023 00:01:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rC6Ji-00HQDt-Kf; Sun, 10 Dec 2023 00:01:02 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 0/2] pwm: Drop two strange API functions
Date: Sun, 10 Dec 2023 00:00:45 +0100
Message-ID: <cover.1702162780.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=519; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=4nC0GQtJud2kQFsCWQKNNgWIJkkV489ShRvvHO1gpTo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBldPGcGTt8f64Hql5/rFm6ZjEzLqgys4csWv5KM LrBijH2PoqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXTxnAAKCRCPgPtYfRL+ TtOZB/9eOWXk1e+Nln4ltbsTIjcCzC37PhmnEUARtrKF20II82mDDixbuDW9b7dWVJ8wVfKiwQh vuVdz2kQlyKnR80LJmRk3ArVOhcuER5wRUvoVNo2VytSIo4rMpOdJqrEUqBdRQEXiPcm7GFMj9j RbrM+Ws332UuIF7hGdqlATZJtmvx/q73ZmXZna8isZlI4Jv30LgT3w4Eko6Zka0h2Q2H7VBPfpI ndPqSF+11O5Jw368BIZVc0xl52fiimXww8HfWxl7EiDFqJEbeqi00YxDWZEUHRAfoiwnPqL9YVq yr/I7uK+n/+e8BNB4dTjjs3WqjxxmpN9xpRnyWurQpQuQdjg
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Hello,

while working on another change I noticed these two functions, found
them strange and no valid user. So this patch series drops them.

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: lpc18xx-sct: Don't modify the cached period of other PWM outputs
  pwm: Drop two unused API functions

 drivers/pwm/pwm-lpc18xx-sct.c |  4 +---
 include/linux/pwm.h           | 12 ------------
 2 files changed, 1 insertion(+), 15 deletions(-)

base-commit: bc63de6e6ba0b16652c5fb4b9c9916b9e7ca1f23
-- 
2.42.0


