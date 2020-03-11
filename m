Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A0C180DA7
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2020 02:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgCKBlk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Mar 2020 21:41:40 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:26769 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727960AbgCKBl0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Mar 2020 21:41:26 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Mar 2020 18:41:24 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 10 Mar 2020 18:41:24 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 6DFB44AEB; Tue, 10 Mar 2020 18:41:24 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v8 11/12] backlight: pwm_bl: Use 64-bit division function
Date:   Tue, 10 Mar 2020 18:41:20 -0700
Message-Id: <a9f914f92ee637c68e1d336e5b4894a565eb3cdc.1583889178.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583889178.git.gurus@codeaurora.org>
References: <cover.1583889178.git.gurus@codeaurora.org>
In-Reply-To: <cover.1583889178.git.gurus@codeaurora.org>
References: <cover.1583889178.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_state.period's datatype
to u64, prepare for this transition by using div_u64 to handle a 64-bit
dividend instead of a straight division operation.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-pwm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/video/backlight/pwm_bl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index efb4efc..3e5dbcf 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -625,7 +625,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
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

