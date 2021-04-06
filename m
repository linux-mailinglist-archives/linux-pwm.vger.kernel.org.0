Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A985B355972
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346562AbhDFQoE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 12:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346567AbhDFQoE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 12:44:04 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00804C06175F;
        Tue,  6 Apr 2021 09:43:55 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 74B80C6AE56;
        Tue,  6 Apr 2021 18:43:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617727434;
        bh=Qq0WLolcIcqX1eFNZQ/kqZq/+F/21afsWvutegaWuOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VdZdBZCQG2W2Zttf76FQdQPBL/CjSghKmBV0WfgK68n/d2ApJPuahYRsyi4cgrXTh
         YHaoR78f/zYuNSDhoDGk8VwtWpA5N3d3A6JUOfFtNEmoP7VC7x8iUIVCF0dZVTj0MT
         C6Iu9/KBzc1S8GDG6mYdDIy97ivpeTnscaSmOrH0=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v7 5/8] pwm: core: Support new PWM_STAGGERING_ALLOWED flag
Date:   Tue,  6 Apr 2021 18:41:37 +0200
Message-Id: <20210406164140.81423-5-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If the flag PWM_STAGGERING_ALLOWED is set on a channel, the PWM driver
may (if supported by the HW) delay the ON time of the channel relative
to the channel number.
This does not alter the duty cycle ratio and is only relevant for PWM
chips with less prescalers than channels, which would otherwise assert
multiple or even all enabled channels at the same time.

If this feature is supported by the driver and the flag is set on
multiple channels, their ON times are spread out to improve EMI and
reduce current spikes.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/core.c  | 9 +++++++--
 include/linux/pwm.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a8eff4b3ee36..f58aad754741 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -153,9 +153,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 
 	pwm->args.period = args->args[1];
 	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	pwm->args.staggering_allowed = false;
 
-	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity = PWM_POLARITY_INVERSED;
+	if (args->args_count > 2) {
+		if (args->args[2] & PWM_POLARITY_INVERTED)
+			pwm->args.polarity = PWM_POLARITY_INVERSED;
+		if (args->args[2] & PWM_STAGGERING_ALLOWED)
+			pwm->args.staggering_allowed = true;
+	}
 
 	return pwm;
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e4d84d4db293..3d5dee8c564f 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -41,6 +41,7 @@ enum pwm_polarity {
 struct pwm_args {
 	u64 period;
 	enum pwm_polarity polarity;
+	bool staggering_allowed;
 };
 
 enum {
-- 
2.31.1

