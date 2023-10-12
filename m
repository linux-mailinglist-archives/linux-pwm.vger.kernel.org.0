Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177037C7852
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 23:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344202AbjJLVC6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 17:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442372AbjJLVC6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 17:02:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC389D
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 14:02:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qr2pU-000772-Cv; Thu, 12 Oct 2023 23:02:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qr2pQ-001EgW-QN; Thu, 12 Oct 2023 23:02:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qr2pQ-00FDqj-HD; Thu, 12 Oct 2023 23:02:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: [PATCH] pwm: samsung: Document new member .channel in struct samsung_pwm_chip
Date:   Thu, 12 Oct 2023 23:02:29 +0200
Message-ID: <20231012210228.1009473-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TinZcVixfWff9r+KWwFdJry6obdM5LE5EMAISvNNtLI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKF7l6LUqJ6xBMLocRVt/FQXn9YKx6IyvCLH6Z YDeIzqfewCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZShe5QAKCRCPgPtYfRL+ Ti2zB/98m5mKAl8kqq5TU8HWCMKZhHOPU0j/K+ZSOWYWXB+zmnmmLfB7VAcRfpjolGAd1QZJxj3 QBuaMHQwZ9swkzvNSRpLHZdAoc001DPKMD+j0EhYT1std5J6CxUc1s/A4v8+8ts2oUO20WmfOYM +9Q4Xdaz0Hy3iuKC5MYRt8HvQobwGSCtkk/wunKLCTUl89VNxlxAvsQxNkG5a3lNuIyY1zrS5V5 fG66pAm0mtEhQiGP/yoQsPrxLCjU/lWgcMH7ied5+LM4vViLAZQLY0ZrgMvEkighjjA0eedu5c1 +R2+1O/NsM9G50leXkB41r45cnrEGDqk9Rv5svBbgX8YJPy3
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

My earlier commit reworking how driver data is tracked added a new
member to struct samsung_pwm_chip but failed to add matching
documentation. Make up leeway.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310130404.uQ33q5Dk-lkp@intel.com/
Fixes: 4c9548d24c0d ("pwm: samsung: Put per-channel data into driver data")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index c437fab7ded8..42f8587087fb 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -77,6 +77,7 @@ struct samsung_pwm_channel {
  * @base_clk:		base clock used to drive the timers
  * @tclk0:		external clock 0 (can be ERR_PTR if not present)
  * @tclk1:		external clock 1 (can be ERR_PTR if not present)
+ * @channel:		per channel driver data
  */
 struct samsung_pwm_chip {
 	struct pwm_chip chip;

base-commit: 4c9548d24c0d4034f056e2c9f0e72599a382a846
-- 
2.42.0

