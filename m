Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D1B30D1CB
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Feb 2021 03:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhBCCuw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Feb 2021 21:50:52 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37022 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbhBCCuv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Feb 2021 21:50:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UNizxU5_1612320606;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNizxU5_1612320606)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Feb 2021 10:50:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org, vz@mleia.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] pwm: lpc18xx-sct: remove unneeded semicolon
Date:   Wed,  3 Feb 2021 10:50:05 +0800
Message-Id: <1612320605-6430-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/pwm/pwm-lpc18xx-sct.c:292:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index dc5133b..7ef4024 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -289,7 +289,7 @@ static int lpc18xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		dev_err(lpc18xx_pwm->dev,
 			"maximum number of simultaneous channels reached\n");
 		return -EBUSY;
-	};
+	}
 
 	set_bit(event, &lpc18xx_pwm->event_map);
 	lpc18xx_data->duty_event = event;
-- 
1.8.3.1

