Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C5F3AB04A
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Jun 2021 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFQJyH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Jun 2021 05:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhFQJyG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Jun 2021 05:54:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10789C061760
        for <linux-pwm@vger.kernel.org>; Thu, 17 Jun 2021 02:51:59 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogm-0007P4-Uf; Thu, 17 Jun 2021 11:51:56 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogm-0005NF-Jn; Thu, 17 Jun 2021 11:51:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v1 3/6] pwm: tegra: Don't needlessly enable and disable the clock in .remove()
Date:   Thu, 17 Jun 2021 11:51:42 +0200
Message-Id: <20210617095145.163694-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
References: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=wQKPGwjHvonrkdypb2NbXVcbtCOEXSH2iC9m6ZTTwPM=; m=oIbjB3nmfF2ZzyS2/BzlUq2cEnmLvfPlJ4O0U2iP8c0=; p=FKRj2btoyIbjzBr0ea2a26YRopKdFk3dFb5aj+OD2vw=; g=6bddbb9d6b58a1cdc89502149e5d7df265ba3a95
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDLGvUACgkQwfwUeK3K7AkqVwf7B+7 QLx3cu6095hh6yhEEpZqfHzV77dwWpwQQXg2oUeD+KLrL+dLAtF9id9Cfd4kBG9UjcR9OVIeHuk4s OiHDq7SlleuWJoi0vj869GYckUsFjI8aPAR3FQveg8CtJiko1t72alu/D86dRmr+LVHu6ukVtcPa2 qL30429GSZCAdkIyzBfVR6gbkNpRIvWNl+AwoVKDiUfcQh4n/yZXi+sSJ1Mes2zeGmJTkjuzOmppJ M5w/9z6SFj6daBMAZbuqlSrPbJtbUa77/iclSHlrCjHascirhB77maRiY9/C9ihcZxfv7o8B4moH6 SCL0F21l4jgxrcboXM9fTh3XtUJczpQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There is no reason to enable the PWM clock just to assert the reset
control. (If the reset control depends on the clock this is a bug and
probably it doesn't because in .probe() the reset is deasserted without
the clock being enabled.)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tegra.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index a051cf43e7d7..e865743e5989 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -300,14 +300,8 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 static int tegra_pwm_remove(struct platform_device *pdev)
 {
 	struct tegra_pwm_chip *pc = platform_get_drvdata(pdev);
-	int err;
-
-	err = clk_prepare_enable(pc->clk);
-	if (err < 0)
-		return err;
 
 	reset_control_assert(pc->rst);
-	clk_disable_unprepare(pc->clk);
 
 	return pwmchip_remove(&pc->chip);
 }
-- 
2.30.2

