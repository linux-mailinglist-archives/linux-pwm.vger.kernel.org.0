Return-Path: <linux-pwm+bounces-612-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCBF81C4CE
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Dec 2023 06:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60011C24425
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Dec 2023 05:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B0C6124;
	Fri, 22 Dec 2023 05:57:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4F611B
	for <linux-pwm@vger.kernel.org>; Fri, 22 Dec 2023 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGYWi-0006Gk-Qk; Fri, 22 Dec 2023 06:56:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGYWg-000gX2-DM; Fri, 22 Dec 2023 06:56:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGYWh-001ZEo-6z; Fri, 22 Dec 2023 06:56:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2] MAINTAINERS: pwm: Thierry steps down, Uwe takes over
Date: Fri, 22 Dec 2023 06:56:39 +0100
Message-ID: <20231222055638.334619-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=X0rr02MMweZu31HiZW50Ct+YGisBh9oku7G0onegMQc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlhSUWS7iB1+IIQPZVF5mxx/3dZBfq24qMSH/+3 DpVbYK6eIuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYUlFgAKCRCPgPtYfRL+ TqwPB/44ztcUeIBfpy9I2rH0PNp0KqoDckmsZ/r+ng9ioYXbgGeoqkJSRAH8DpCuMmns/Zf4raO itUo46RKb6isNIHh9TmpCg/tP6UC8pPFkkUQ+jC40BMWDBJITQ+eAbOMvjQ1LXFZhk6hy/ImG0J 3YPikS5tfCVg3LpRMmwGlmdCvdFI2eWWmcvlwPDfmO72tcgLrygcAFmQG9gKkVOIJTrhM4RXgba Lx9a1joDOeuYeMi07QKgXhQlS4LN/+vIMW0JpDfLBqR7snuAT8E/5qKQrb1FQhgUNtV7Zb7vrFe qoOk/wB577jIjvDnU3IKpA4Obrr2/7sxcSKPD1s4yRJzq+4y
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

It's not easy to let go responsibility for a subsystem that one cared
for for a long time, but Thierry realized that his heart isn't in the
pwm framework any more.

Thierry cared for the pwm subsystem (commit 200efedd8766 ("pwm: Take
over maintainership of the PWM subsystem")) as a maintainer during
nearly 12 years. A big thanks for the time, effort and dedication spend
during that time.

Uwe takes over maintenance.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello Thierry,

changes since (implict) v1:

 - Add Neil's Reviewed-by tag
 - Fix the git tree URL to the one I actually intend to use (i.e. drop
   -pwm from the repo name).

Please pick this one instead of the one from yesterday.

Thanks
Uwe

 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5342cf32d73f..c6c7b50e6ef6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17561,12 +17561,11 @@ F:	Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
 F:	drivers/media/rc/pwm-ir-tx.c
 
 PWM SUBSYSTEM
-M:	Thierry Reding <thierry.reding@gmail.com>
-R:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+M:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git
 F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
 F:	Documentation/devicetree/bindings/pwm/
 F:	Documentation/driver-api/pwm.rst

base-commit: 9a216587a03dfbc6199f29f1054d9974041a8cc8
-- 
2.42.0


