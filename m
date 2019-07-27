Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D0C7776C
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jul 2019 09:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfG0HTT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Jul 2019 03:19:19 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:59360 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfG0HTT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 27 Jul 2019 03:19:19 -0400
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Jul 2019 03:19:18 EDT
Received: from proxy01.sjtu.edu.cn (unknown [202.112.26.54])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id E26C51008CBC3;
        Sat, 27 Jul 2019 15:10:50 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by proxy01.sjtu.edu.cn (Postfix) with ESMTP id CCA8920424204;
        Sat, 27 Jul 2019 15:10:50 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dRKgTVampxTk; Sat, 27 Jul 2019 15:10:50 +0800 (CST)
Received: from xywang-pc.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: xywang.sjtu@sjtu.edu.cn)
        by proxy01.sjtu.edu.cn (Postfix) with ESMTPA id 9F49720424202;
        Sat, 27 Jul 2019 15:10:50 +0800 (CST)
From:   Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Cc:     thierry.reding@gmail.com, palmer@sifive.com,
        paul.walmsley@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Subject: [PATCH] pwm: avoid disabling clk twice
Date:   Sat, 27 Jul 2019 15:09:16 +0800
Message-Id: <20190727070916.2960-1-xywang.sjtu@sjtu.edu.cn>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Similar to commit 63fd4b94b948 ("serial: imx: fix error handling
in console_setup"), as ddata->clk has been explicitly disabled two
lines above, it should avoid being disabled for the second time.
clk_unprepare() suits here better.

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
---
 drivers/pwm/pwm-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index a7c107f19e66..00f6fab5bd3b 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -312,7 +312,7 @@ static int pwm_sifive_remove(struct platform_device *dev)
 	if (is_enabled)
 		clk_disable(ddata->clk);
 
-	clk_disable_unprepare(ddata->clk);
+	clk_unprepare(ddata->clk);
 	ret = pwmchip_remove(&ddata->chip);
 	clk_notifier_unregister(ddata->clk, &ddata->notifier);
 
-- 
2.11.0

