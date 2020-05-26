Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBD01E28EF
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 19:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgEZRfO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 13:35:14 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:5422 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728064AbgEZRfO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 13:35:14 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 May 2020 10:35:13 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg03-sd.qualcomm.com with ESMTP; 26 May 2020 10:35:13 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 28E394C97; Tue, 26 May 2020 10:35:13 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v15 01/11] drm/i915: Use 64-bit division macro
Date:   Tue, 26 May 2020 10:35:01 -0700
Message-Id: <4b56ba06f4f1e63cf50858d3e45c88057dc443e4.1590514331.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1590514331.git.gurus@codeaurora.org>
References: <cover.1590514331.git.gurus@codeaurora.org>
In-Reply-To: <cover.1590514331.git.gurus@codeaurora.org>
References: <cover.1590514331.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_state.duty_cycle's
datatype to u64, prepare for this transition by using DIV_ROUND_UP_ULL
to handle a 64-bit dividend.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 276f438..81547a0 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -1920,7 +1920,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 		return retval;
 	}
 
-	level = DIV_ROUND_UP(pwm_get_duty_cycle(panel->backlight.pwm) * 100,
+	level = DIV_ROUND_UP_ULL(pwm_get_duty_cycle(panel->backlight.pwm) * 100,
 			     CRC_PMIC_PWM_PERIOD_NS);
 	panel->backlight.level =
 		intel_panel_compute_brightness(connector, level);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

