Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5D091CFC
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2019 08:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfHSGVr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 02:21:47 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:50319 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726584AbfHSGVr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 02:21:47 -0400
X-IronPort-AV: E=Sophos;i="5.64,403,1559487600"; 
   d="scan'208";a="24116684"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Aug 2019 15:21:45 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D7F254001DDF;
        Mon, 19 Aug 2019 15:21:44 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3] pwm: rcar: remove a redundant condition in rcar_pwm_apply()
Date:   Mon, 19 Aug 2019 15:20:12 +0900
Message-Id: <1566195612-11614-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the rcar_pwm_apply() has already checked whether state->enabled
is set or not, this patch removes a redundant condition.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes from v2:
 - Revise some typos in the commit log.
https://patchwork.kernel.org/patch/11083353/

Changes from v1:
 - Spin-off this independent patch (5/7).
 - Add Geert and Uwe's Reviewed-by.
https://patchwork.kernel.org/patch/11034743/

 drivers/pwm/pwm-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 5b2b8ec..c8cd43f 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -187,7 +187,7 @@ static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* The SYNC should be set to 0 even if rcar_pwm_set_counter failed */
 	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
 
-	if (!ret && state->enabled)
+	if (!ret)
 		ret = rcar_pwm_enable(rp);
 
 	return ret;
-- 
2.7.4

