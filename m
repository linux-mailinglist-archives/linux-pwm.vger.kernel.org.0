Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F6D761AD3
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jul 2023 15:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjGYN72 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jul 2023 09:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjGYN71 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jul 2023 09:59:27 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D9CC1FC0;
        Tue, 25 Jul 2023 06:59:26 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,230,1684767600"; 
   d="scan'208";a="174439662"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Jul 2023 22:59:25 +0900
Received: from localhost.localdomain (unknown [10.226.92.3])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 455CF40062CC;
        Tue, 25 Jul 2023 22:59:23 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] pwm: rz-mtu3: Fix build warning 'num_channel_ios' not described
Date:   Tue, 25 Jul 2023 14:59:21 +0100
Message-Id: <20230725135921.125765-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Fix the below build warning:
warning: Function parameter or member 'num_channel_ios' not described
in 'rz_mtu3_channel_io_map'

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/pwm-rz-mtu3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index bed8bd671e37..a56cecb0e46e 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -40,7 +40,7 @@
  * struct rz_mtu3_channel_io_map - MTU3 pwm channel map
  *
  * @base_pwm_number: First PWM of a channel
- * @num: number of IOs on the HW channel.
+ * @num_channel_ios: number of IOs on the HW channel.
  */
 struct rz_mtu3_channel_io_map {
 	u8 base_pwm_number;
-- 
2.25.1

