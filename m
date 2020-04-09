Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D83F1A2F8D
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2020 08:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDIGw5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Apr 2020 02:52:57 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:47343 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgDIGw4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 02:52:56 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Apr 2020 23:52:54 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 08 Apr 2020 23:52:53 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id F24854BF6; Wed,  8 Apr 2020 23:52:53 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v12 01/11] drm/i915: Use 64-bit division macro
Date:   Wed,  8 Apr 2020 23:52:30 -0700
Message-Id: <13845382bcb686ec707f7d3ab2e05a2aabde4e33.1586414867.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1586414867.git.gurus@codeaurora.org>
References: <cover.1586414867.git.gurus@codeaurora.org>
In-Reply-To: <cover.1586414867.git.gurus@codeaurora.org>
References: <cover.1586414867.git.gurus@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_state.duty_cycle's
datatype to u64, prepare for this transition by using DIV_ROUND_UP_ULL
to handle a 64-bit dividend.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 7b3ec6eb..b45eabf 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -1877,7 +1877,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 
 	panel->backlight.min = 0; /* 0% */
 	panel->backlight.max = 100; /* 100% */
-	panel->backlight.level = DIV_ROUND_UP(
+	panel->backlight.level = DIV_ROUND_UP_ULL(
 				 pwm_get_duty_cycle(panel->backlight.pwm) * 100,
 				 CRC_PMIC_PWM_PERIOD_NS);
 	panel->backlight.enabled = panel->backlight.level != 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

