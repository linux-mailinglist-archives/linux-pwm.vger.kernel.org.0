Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83F035C796
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbhDLN3q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 09:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241820AbhDLN3o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 09:29:44 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C88C06138C;
        Mon, 12 Apr 2021 06:29:22 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id AE1F3C725CF;
        Mon, 12 Apr 2021 15:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618234161;
        bh=SxiB/wQTlRoG8/dxG1/RTDvR1hDyB+kFAQl39HISeJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHWDhbPtqiUMa6Te6Xl59XLDbFz8txMpjGNr0YkdnVWVRO/1ALoBmUmIQvltK7RQW
         y1NO+GCZ5gMEKHFOTvJ0Ubd04nOpb/pYpi413xKBnx+LFANvco3Qk95zQsrZGrn5fZ
         whWZJeWCz42nPfFlduLSWibAAZq0UlBCewbpQgms=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v8 5/8] pwm: core: Support new PWM_USAGE_POWER flag
Date:   Mon, 12 Apr 2021 15:27:42 +0200
Message-Id: <20210412132745.76609-5-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If the flag PWM_USAGE_POWER is set on a channel, the PWM driver may
optimize the signal as long as the power output is not changed.

Depending on the specific driver, the optimization could for example
improve EMI (if supported) by phase-shifting the individual channels.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/core.c  | 9 +++++++--
 include/linux/pwm.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a8eff4b3ee36..56a9c739e1b2 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -153,9 +153,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 
 	pwm->args.period = args->args[1];
 	pwm->args.polarity = PWM_POLARITY_NORMAL;
+	pwm->args.usage_power = false;
 
-	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
-		pwm->args.polarity = PWM_POLARITY_INVERSED;
+	if (args->args_count > 2) {
+		if (args->args[2] & PWM_POLARITY_INVERTED)
+			pwm->args.polarity = PWM_POLARITY_INVERSED;
+		if (args->args[2] & PWM_USAGE_POWER)
+			pwm->args.usage_power = true;
+	}
 
 	return pwm;
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e4d84d4db293..555e050e8bec 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -41,6 +41,7 @@ enum pwm_polarity {
 struct pwm_args {
 	u64 period;
 	enum pwm_polarity polarity;
+	bool usage_power;
 };
 
 enum {
-- 
2.31.1

