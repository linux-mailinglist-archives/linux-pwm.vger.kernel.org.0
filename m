Return-Path: <linux-pwm+bounces-1091-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6768183D9D8
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 12:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F42280FB6
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 11:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FA11429E;
	Fri, 26 Jan 2024 11:59:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABB21802A
	for <linux-pwm@vger.kernel.org>; Fri, 26 Jan 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270390; cv=none; b=qEfEH2UH+u78Mt722w/QPp7VVzLL+i87eDLqgGqRp42nlPvB06tWNpzVPJsNwxWNnxtqlNhPuSIJVJ6pX/+FF/CjLo/TBzLvrWFGyW3/8GJmyfHKrfOpZRcW6Ui9L4diBHsqwBp1PdPz9MmowtF9Jfx365JRZ4jDQxXxWj/TLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270390; c=relaxed/simple;
	bh=+3CuzUV4xDPI/LVjPycdcu7szZLV2rJ7YrQLdoRZLXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FCcQq3KQgdN7FxUNcCNz1SllEQOH2LCaN0xNWqIP48VYHxJ0fXnbVXM4bx1Hx131psRAwLv13s+cSbHrSueyhA9R0na+bbLVnekhmG3BWWKiAr7YeNcX55tX8utLqTooGMXeAGhIf9xhjmrcC/ZUY6eXOC9RGq4N4KNnqjKnLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTKrz-0001hQ-MK; Fri, 26 Jan 2024 12:59:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTKry-002Uyj-DZ; Fri, 26 Jan 2024 12:59:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTKry-008bFS-13;
	Fri, 26 Jan 2024 12:59:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Boris Brezillon <bbrezillon@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 0/2] pwm: atmel-hlcdc: Two improvements
Date: Fri, 26 Jan 2024 12:59:34 +0100
Message-ID: <cover.1706269232.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+3CuzUV4xDPI/LVjPycdcu7szZLV2rJ7YrQLdoRZLXc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBls56n8WDarRbVU39lwew5GpWRHUuQuPOYHqyQr wbaFPpkCHKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbOepwAKCRCPgPtYfRL+ Tl4tB/oCDygtifB9pWQkqGgsMu55LjehVTF5XFdZK8eex1+qYkyKIAaKNjfCbkTW2Zm/WYbaXBv YkZ+qFjnNQog/tivamUs8aXosW2sq3CrZVUapVcCwPKIb9ww4RK5+yF00kp1czB8E+neP5wCg6m O6BA6hXJ8NVehUGQaOLpN5B0HHc2MbOTH0Xy15srQ2ZAYpvLwzInbONsYdJnJYk67Y0lT44Ynmo JMXEK1Vmu6T3FvLNjSP/mCTL2L9TTAEdwIKPK/Pb8+mbTRhNUVaaAKknc4tO1hGaT3h1P/xol20 /tu+eNuR3HmYiteXlWloGm13Jcc4pU1XNTDpmy6GxB42DOb/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Hello,

while looking through various pwm drivers I found these two
improvements.

The conditional clk_disable_unprepare() in .suspend() makes me wonder if
the PWM continues to operate during suspend. Can someone with the
hardware confirm that? If so, is it really necessary to restore the
registers (by calling atmel_hlcdc_pwm_apply())?

Other drivers have a logic in .suspend() that makes them return -EBUSY
if the pwm is still enabled. So I further wonder if there is an
application for the atmel-hlcdc driver to handle the pwm being enabled
there. Any hints are welcome. I already wondered if it's safe to let the
pwm core return -EBUSY for a suspend request if the hardware is enabled.
So the answer to my question is relevant to this plan, too.

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: atmel-hlcdc: Fix clock imbalance related to suspend support
  pwm: atmel-hlcdc: Don't use pwm consumer API

 drivers/pwm/pwm-atmel-hlcdc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

base-commit: 7be3ba1e5644170feb2cb587860015de97fc7d8a
-- 
2.43.0


