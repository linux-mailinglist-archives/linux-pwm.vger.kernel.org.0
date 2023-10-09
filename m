Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77157BE0B5
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Oct 2023 15:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377252AbjJINnR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Oct 2023 09:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346576AbjJINnQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Oct 2023 09:43:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34B8AB
        for <linux-pwm@vger.kernel.org>; Mon,  9 Oct 2023 06:43:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpqXR-00007s-4d; Mon, 09 Oct 2023 15:43:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpqXQ-000QjF-H2; Mon, 09 Oct 2023 15:43:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpqXQ-00CHxU-7o; Mon, 09 Oct 2023 15:43:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     stable@vger.kernel.org
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH stable 5.4.y] pwm: hibvt: Explicitly set .polarity in .get_state()
Date:   Mon,  9 Oct 2023 15:43:09 +0200
Message-Id: <20231009134309.243860-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CnSZhuwCGpDgCU1x6nYfk/lzMSEh40MGycDSG62N45I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlJANsRKIRptU3JE7o7fXIcQT/SexyB00dLuZF9 s7CzBXpS9iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSQDbAAKCRCPgPtYfRL+ TipMB/4k3u/DdfUmcM7P19YfZ1R8jvAdZ2jfV6AZ/c1ky10EuuuAi5tVtgUO70vCYHtzDMQrysz S130vEpFtXkWE+iQoIcmk5sH1kZg9Y2aHki5vGE4E60AjFxZXrWJwJA1xvKPnU8cCXuzUpyOKTG A+oN1oU/5amBiKo0YkBA60hOoL3ylSB+0QOauWgJUJZbVM9E2349GzQlokUI9s2P3bQz9nipj+U XCqEw9G7M0FSEDbNxL8wo7Xeg2DnRGabh5k6YV7amSc1wyQGeXHqHcM+GYDMdFAPtzjMsg2KALC N+WniluiQKMTFHJy3pzm3zjgg8JRx0LK4GhcgkkM1v6JCPLJ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

[ Upstream commit 6f57937980142715e927697a6ffd2050f38ed6f6 ]

The driver only both polarities. Complete the implementation of
.get_state() by setting .polarity according to the configured hardware
state.

Fixes: d09f00810850 ("pwm: Add PWM driver for HiSilicon BVT SOCs")
Link: https://lore.kernel.org/r/20230228135508.1798428-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this is a backport to 5.4.257. The original was backported to

- v5.10.179 as commit 155b2586de3f171d46c8a1955990d4676487501e
- v5.15.109 as commit 78559037632b8343b85fb1e2d0b55405c2b73b4a
- v6.1.24 as commit 98ba763cc91c8e0117ccc28e300640eee52f9b44
- v6.2.11 as commit 28ab26f6a95b4bda64cba22704484d209aad5417

A direct

	git cherry-pick 6f57937980142715e927697a6ffd2050f38ed6f6

on 5.4.257 fails with a conflict, but the same happend on 5.10.y and
5.15.y, where it was backported correctly. So

	git cherry-pick 78559037632b8343b85fb1e2d0b55405c2b73b4a

works just fine and results in this patch. Cherry-picking
78559037632b8343b85fb1e2d0b55405c2b73b4a also works fine on for 4.19.y
and 4.14.

Note there is a broken sentence in the commit log, s/only/supports/
would be appropriate. I am unsure however if I'm allowed to fix it or if
the commit log has to be exactly the same as the original.

Best regards
Uwe

 drivers/pwm/pwm-hibvt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index ad205fdad372..286e9b119ee5 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -146,6 +146,7 @@ static void hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	value = readl(base + PWM_CTRL_ADDR(pwm->hwpwm));
 	state->enabled = (PWM_ENABLE_MASK & value);
+	state->polarity = (PWM_POLARITY_MASK & value) ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
 }
 
 static int hibvt_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,

base-commit: a140610d8aff1a06d36f8e4e9e66079b561d043d
-- 
2.40.1

