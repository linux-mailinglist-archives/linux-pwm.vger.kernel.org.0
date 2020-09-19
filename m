Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC96271056
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Sep 2020 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgISTm5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 19 Sep 2020 15:42:57 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:56392 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgISTm5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 19 Sep 2020 15:42:57 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Sep 2020 15:42:56 EDT
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id C7C54A05B3;
        Sat, 19 Sep 2020 19:33:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo05-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo05-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G6RbiLyf29ms; Sat, 19 Sep 2020 19:33:37 +0000 (UTC)
Received: from jupiter.simonsouth.net (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 77C83A025D;
        Sat, 19 Sep 2020 19:33:27 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, heiko@sntech.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Simon South <simon@simonsouth.net>
Subject: [PATCH v2] pwm: rockchip: Keep enabled PWMs running while probing
Date:   Sat, 19 Sep 2020 15:33:06 -0400
Message-Id: <20200919193306.1023-1-simon@simonsouth.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Following commit cfc4c189bc70 ("pwm: Read initial hardware state at
request time") the Rockchip PWM driver can no longer assume a device's
pwm_state structure has been populated after a call to pwmchip_add().
Consequently, the test in rockchip_pwm_probe() intended to prevent the
driver from stopping PWM devices already enabled by the bootloader no
longer functions reliably and this can lead to the kernel hanging
during startup, particularly on devices like the Pinebook Pro that use
a PWM-controlled backlight for their display.

Avoid this by querying the device directly at probe time to determine
whether or not it is enabled.

Fixes: cfc4c189bc70 ("pwm: Read initial hardware state at request time")
Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index eb8c9cb645a6..098e94335cb5 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -288,6 +288,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	const struct of_device_id *id;
 	struct rockchip_pwm_chip *pc;
 	struct resource *r;
+	u32 enable_conf, ctrl;
 	int ret, count;
 
 	id = of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
@@ -362,7 +363,9 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	}
 
 	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
-	if (!pwm_is_enabled(pc->chip.pwms))
+	enable_conf = pc->data->enable_conf;
+	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
+	if ((ctrl & enable_conf) != enable_conf)
 		clk_disable(pc->clk);
 
 	return 0;
-- 
2.28.0

