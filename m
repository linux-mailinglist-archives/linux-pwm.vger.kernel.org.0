Return-Path: <linux-pwm+bounces-571-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5249381818F
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Dec 2023 07:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F52B23FAE
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Dec 2023 06:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB4F8820;
	Tue, 19 Dec 2023 06:33:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F090881E
	for <linux-pwm@vger.kernel.org>; Tue, 19 Dec 2023 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFTfP-0005fl-Uq; Tue, 19 Dec 2023 07:33:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFTfO-00Gs1V-GE; Tue, 19 Dec 2023 07:33:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFTfO-005o4e-6w; Tue, 19 Dec 2023 07:33:22 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	kernel@pengutronix.de,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] pwm: cros-ec: Drop documentation for dropped struct member
Date: Tue, 19 Dec 2023 07:33:17 +0100
Message-ID: <20231219063316.167905-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hTGoLKojplScw4b1HQdC6uBR8tfhmqpbzg3xFffOUHo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgTktN/Zg8G9Dp4CK9clG6aPtNbxFD1Ac1fySp K/0zUVbcXmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYE5LQAKCRCPgPtYfRL+ TtczB/9vlhmYs7AoIaxRa8iU+JYZQ7TzEwfX6SAXmhi2Do04+p+3+8myg6ivYPSBR7RHeYm/+uE Obc9IW82xGBL8gO+LPz7RKU6hnsSejtdxFSN6HKCm5qkDPlTtqmc8ToUQBYU5y97+OXIPzFOQUP egiGRD8kRe6KSpBwJsQ7SMte4x1YjDsjDwmhxDQ5WSYA69wO0pmh1kXw4FkEOuz9R0vGNis9OGU 3kPXPzSumEcSe4MkyLdqR1owB9b0zg5ZaoIEmuR9FD9Siy2xxrqQnc6KqC497hslThS22wIiefJ C/PeofFpykxwBNMjWwD+O0a2H9jPqwnbCNdSaTX1P2xrydAa
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Recently an unused member was removed from struct cros_ec_pwm_device,
but the kernel doc wasn't adapted accordingly. Catch up and drop the
documentation, too.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312190757.O4M9dsln-lkp@intel.com/
Fixes: ffb150737fee ("pwm: cros-ec: Drop unused member from driver private data")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-cros-ec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 9a8f1b6a4e13..5fe303b8656d 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -18,7 +18,6 @@
 /**
  * struct cros_ec_pwm_device - Driver data for EC PWM
  *
- * @dev: Device node
  * @ec: Pointer to EC device
  * @chip: PWM controller chip
  * @use_pwm_type: Use PWM types instead of generic channels

base-commit: aa4db8324c4d0e67aa4670356df4e9fae14b4d37
-- 
2.42.0


