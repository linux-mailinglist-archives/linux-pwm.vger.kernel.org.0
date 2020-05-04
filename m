Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72191C465F
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2020 20:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgEDSuy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 May 2020 14:50:54 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:7667 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727906AbgEDSuX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 May 2020 14:50:23 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 May 2020 11:50:20 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg05-sd.qualcomm.com with ESMTP; 04 May 2020 11:50:20 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 71DB74D38; Mon,  4 May 2020 11:50:20 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [RESEND PATCH v14 09/11] backlight: pwm_bl: Use 64-bit division function
Date:   Mon,  4 May 2020 11:50:15 -0700
Message-Id: <3e2a15330b8dd9c828586bfbbbb4aa2b482212de.1588616856.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1588616856.git.gurus@codeaurora.org>
References: <cover.1588616856.git.gurus@codeaurora.org>
In-Reply-To: <cover.1588616856.git.gurus@codeaurora.org>
References: <cover.1588616856.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_state.period's datatype
to u64, prepare for this transition by using div_u64 to handle a 64-bit
dividend instead of a straight division operation.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 82b8d75..464baad 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -606,7 +606,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		pb->scale = data->max_brightness;
 	}
 
-	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
+	pb->lth_brightness = data->lth_brightness * (div_u64(state.period,
+				pb->scale));
 
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = data->max_brightness;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

