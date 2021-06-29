Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279333B771F
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jun 2021 19:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhF2RZ0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Jun 2021 13:25:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45314 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbhF2RZY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Jun 2021 13:25:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lyHRm-0003BW-2k; Tue, 29 Jun 2021 17:22:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] pwm: ep93xx: Fix read of uninitialized variable ret
Date:   Tue, 29 Jun 2021 18:22:53 +0100
Message-Id: <20210629172253.43131-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a potential path in function ep93xx_pwm_apply where ret is
never assigned a value and it is checked for an error code. Fix this
by ensuring ret is zero'd in the success path to avoid this issue.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: f6ef94edf0f6 ("pwm: ep93xx: Unfold legacy callbacks into ep93xx_pwm_apply()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pwm/pwm-ep93xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 70fa2957f9d3..8a3d781e6514 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -137,6 +137,7 @@ static int ep93xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				writew(duty_cycles, base + EP93XX_PWMx_DUTY_CYCLE);
 				writew(period_cycles, base + EP93XX_PWMx_TERM_COUNT);
 			}
+			ret = 0;
 		} else {
 			ret = -EINVAL;
 		}
-- 
2.31.1

