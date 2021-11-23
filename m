Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA67459F39
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Nov 2021 10:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhKWJdF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Nov 2021 04:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhKWJdE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Nov 2021 04:33:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178A4C061574
        for <linux-pwm@vger.kernel.org>; Tue, 23 Nov 2021 01:29:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7e-0004zO-Sw; Tue, 23 Nov 2021 10:29:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7c-000acO-Ln; Tue, 23 Nov 2021 10:29:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7b-0004Yb-LU; Tue, 23 Nov 2021 10:29:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Sean Anderson <sean.anderson@seco.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 4/5] pwm: stmpe: Drop unused setting of driver data
Date:   Tue, 23 Nov 2021 10:29:38 +0100
Message-Id: <20211123092939.82705-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123092939.82705-1-u.kleine-koenig@pengutronix.de>
References: <20211123092939.82705-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=8jATezIbTlGSrdLdO5ys8yywShN3MuQ8u9zcvX9o3X4=; m=cvdV+JPCpFyGWqfi+3WupSS1omG0Q3Ie0aF8MW1uChg=; p=HJY9CrYP39XlcJYI39MINTuizNs0pUZ35b1qfFAIet4=; g=adb0b952bf122359cdcd76e56d37916d9ba326ee
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGctHwACgkQwfwUeK3K7AmyRwf+Ilq JW2RKt0X3FcdVjgT4WPQ9W6oZKassdpL/ekoiocKk0f4wxYVCsESNaS7xvG32DoikhE29/AKbKxN5 ZUxXFJT5kvSRNuf9Y9LkNRrMOnZenSJf1vH9jp2XF+FBn69Zs10DKcwQ64g5kh90LZ0cA/08zTo35 sstVme0+wbqkaLsmQww/QpLFQovf5fvdFn9c1FcT4xIWCJxIZa5/lhh3SPjXezUdYNwCqsJXNiosS FBF/tA6ljSGEMeJsV+NUU+zOwzgsY1q3BQ2LQIEVFA6d1O9/jinfbE7WXNMOuCaEHiPSk7R4wVG6T hMQC8udVYSWVyqnQLyHkprVROdmGJsA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The driver never uses dev_get_drvdata() to retrieve the pwm driver data.
So drop setting it.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stmpe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index 9dc983a3cbf1..7c0e567ff71c 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -301,8 +301,6 @@ static int __init stmpe_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, pwm);
-
 	return 0;
 }
 
-- 
2.30.2

