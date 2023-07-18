Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52411757DEF
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 15:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGRNl1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 09:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGRNl1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 09:41:27 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB319D1;
        Tue, 18 Jul 2023 06:41:25 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="169764035"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Jul 2023 22:41:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.137])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id CB680400F32B;
        Tue, 18 Jul 2023 22:41:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Randy Dunlap <rd.dunlab@gmail.com>
Subject: [PATCH] mfd: rz-mtu3: Fix COMPILE_TEST build issue
Date:   Tue, 18 Jul 2023 14:41:19 +0100
Message-Id: <20230718134119.118018-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When (MFD) RZ_MTU3=m and PWM_RZ_MTU3=y, there are numerous build errors:

ld: vmlinux.o: in function `rz_mtu3_pwm_config':
drivers/pwm/pwm-rz-mtu3.c:374: undefined reference to `rz_mtu3_disable'
ld: drivers/pwm/pwm-rz-mtu3.c:377: undefined reference to `rz_mtu3_8bit_ch_write'
ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_ch_write'
ld: vmlinux.o: in function `rz_mtu3_pwm_config':
drivers/pwm/pwm-rz-mtu3.c:382: undefined reference to `rz_mtu3_8bit_ch_write'
ld: vmlinux.o: in function `rz_mtu3_pwm_write_tgr_registers':
drivers/pwm/pwm-rz-mtu3.c:110: undefined reference to `rz_mtu3_16bit_ch_write'
ld: drivers/pwm/pwm-rz-mtu3.c:111: undefined reference to `rz_mtu3_16bit_ch_write'
ld: vmlinux.o: in function `rz_mtu3_pwm_config':
drivers/pwm/pwm-rz-mtu3.c:397: undefined reference to `rz_mtu3_enable'
ld: vmlinux.o: in function `rz_mtu3_pwm_disable':
drivers/pwm/pwm-rz-mtu3.c:259: undefined reference to `rz_mtu3_8bit_ch_write'
ld: drivers/pwm/pwm-rz-mtu3.c:264: undefined reference to `rz_mtu3_disable'
ld: vmlinux.o: in function `rz_mtu3_pwm_enable':
drivers/pwm/pwm-rz-mtu3.c:230: undefined reference to `rz_mtu3_8bit_ch_write'
ld: drivers/pwm/pwm-rz-mtu3.c:234: undefined reference to `rz_mtu3_8bit_ch_write'
ld: drivers/pwm/pwm-rz-mtu3.c:238: undefined reference to `rz_mtu3_enable'
ld: vmlinux.o: in function `rz_mtu3_pwm_is_ch_enabled':
drivers/pwm/pwm-rz-mtu3.c:155: undefined reference to `rz_mtu3_is_enabled'
ld: drivers/pwm/pwm-rz-mtu3.c:162: undefined reference to `rz_mtu3_8bit_ch_read'
ld: vmlinux.o: in function `rz_mtu3_pwm_read_tgr_registers':
drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bit_ch_read'
ld: drivers/pwm/pwm-rz-mtu3.c:102: undefined reference to `rz_mtu3_16bit_ch_read'
ld: drivers/pwm/pwm-rz-mtu3.c:103: undefined reference to `rz_mtu3_16bit_ch_read'
ld: vmlinux.o: in function `rz_mtu3_pwm_get_state':
drivers/pwm/pwm-rz-mtu3.c:296: undefined reference to `rz_mtu3_8bit_ch_read'

Replace the macro IS_ENABLED->IS_REACHABLE, allowing COMPILE_TEST to be built
for PWM_RZ_MTU3.

Reported-by: Randy Dunlap <rd.dunlab@gmail.com>
Closes: https://lore.kernel.org/linux-pwm/TYWPR01MB877550F95CF000B63E9AD022C238A@TYWPR01MB8775.jpnprd01.prod.outlook.com/T/#t
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/linux/mfd/rz-mtu3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/rz-mtu3.h b/include/linux/mfd/rz-mtu3.h
index c5173bc06270..4f15c0dead60 100644
--- a/include/linux/mfd/rz-mtu3.h
+++ b/include/linux/mfd/rz-mtu3.h
@@ -151,7 +151,7 @@ struct rz_mtu3 {
 	void *priv_data;
 };
 
-#if IS_ENABLED(CONFIG_RZ_MTU3)
+#if IS_REACHABLE(CONFIG_RZ_MTU3)
 static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
 {
 	mutex_lock(&ch->lock);
-- 
2.25.1

