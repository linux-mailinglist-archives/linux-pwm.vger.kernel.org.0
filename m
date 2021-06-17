Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F7F3AB04C
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Jun 2021 11:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFQJyH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Jun 2021 05:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhFQJyG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Jun 2021 05:54:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73412C061574
        for <linux-pwm@vger.kernel.org>; Thu, 17 Jun 2021 02:51:59 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogn-0007P8-79; Thu, 17 Jun 2021 11:51:57 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogm-0005Ng-SG; Thu, 17 Jun 2021 11:51:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v1 4/6] pwm: tegra: Assert reset only after the PWM was unregistered
Date:   Thu, 17 Jun 2021 11:51:43 +0200
Message-Id: <20210617095145.163694-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
References: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=/m4R0J8UVth94GKqUInFjs8A16/GNpJIbvipkp9jTr4=; m=l4Xm8J0VSHEoSUlreU7nDsFyAjmLqT8bMTbf9l/XVzA=; p=I3FylcGdLGcK/y6aRf5kncBAouk5M45XS6LZzZCcqK0=; g=d23df0fa8dbb9104130dd7a2076c9284681826b2
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDLGvkACgkQwfwUeK3K7AlHyAf+P/H TEN6jouEvdjniCqFv4iJUB8KlL1PR1P6PBs04bXj5yWaqHhbgM92slzhWLu+JcqUIBJ4KCcpaszpd FnA1ZaeKKyQqO0RqqmpW7FLn1h6VB0I0UcEedYSaSSX44wBtxlU/5sDYpkjRQuzRIxOr/kO3cLCD7 VIU8l/sd5JhDm8rEXMrkUB4U/xljhqZt3/ctVxQskheaLngURfOIQsAoS0OcP1iTUTgxtMrpVFsMx Nt4uVzTb1iVta58aJsrZ4iqjL3Vxv9Jy/9LeD5/zzLAGdZjaN3btxYkkyJXRZVpB4ArnIniK4nZeU CnFcwQLvSVPMwT6ZrnndI0veJzPiefw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The driver is supposed to stay functional until pwmchip_remove()
returns. So the reset must be asserted only after that.

pwmchip_remove() always returns 0, so the return code can be ignored
which keeps the tegra_pwm_remove() a bit simpler.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tegra.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index e865743e5989..11a10b575ace 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -301,9 +301,11 @@ static int tegra_pwm_remove(struct platform_device *pdev)
 {
 	struct tegra_pwm_chip *pc = platform_get_drvdata(pdev);
 
+	pwmchip_remove(&pc->chip);
+
 	reset_control_assert(pc->rst);
 
-	return pwmchip_remove(&pc->chip);
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.30.2

