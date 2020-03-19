Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71FD18C1D3
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Mar 2020 21:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgCSUvH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Mar 2020 16:51:07 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27920 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727159AbgCSUuU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2020 16:50:20 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Mar 2020 13:50:19 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 19 Mar 2020 13:50:18 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 9A8ED4B48; Thu, 19 Mar 2020 13:50:18 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
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
Subject: [PATCH v10 01/12] drm/i915: Use 64-bit division macro
Date:   Thu, 19 Mar 2020 13:50:04 -0700
Message-Id: <2403a87f9b6443401eac96a3c50d4beca63dcba2.1584650604.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584650604.git.gurus@codeaurora.org>
References: <cover.1584650604.git.gurus@codeaurora.org>
In-Reply-To: <cover.1584650604.git.gurus@codeaurora.org>
References: <cover.1584650604.git.gurus@codeaurora.org>
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

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index bc14e9c..843cac1 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -1868,7 +1868,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 
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

