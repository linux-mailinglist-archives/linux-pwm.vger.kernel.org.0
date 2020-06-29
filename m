Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EE920D11E
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2020 20:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgF2Sir (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 14:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgF2SiB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 14:38:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5433C00F834
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:47:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so16408507wrv.9
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NEV6hYDCbFsvfJQmVY8SdLZWAEKAYJLZhNHaqOLyTQ0=;
        b=g/qvooMn7EGa6fcqc2kWnU2ojwrJqK2KiizeQeRVmrzZNiW+BuWl/MFpjCt7ykkfQi
         /WtES5WG4855eTikHYrDxPwhnzNevMFtUE0Uw1T+XtYmxeAV8nlDXMIZbpC8slMDFM9b
         l9bvKnHs6tD4Q+fAd/GrCSLSCZP6CxvRyfcX6949iBxHUkpeHaZwBbPTNuRkN2DUXVrk
         mP9eGbJLxI2Rw5zbVk4RDUM6LbadMulN+A0LYyqtETOkhIAfq01WPOQj+rNpoGAZlBtH
         lMLvIy6r1baqcRuN0MQg0hhdEQriJtNufm8KwQDDs6uM4b1C2n1dXb2jm04IZyUV4x5S
         7m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEV6hYDCbFsvfJQmVY8SdLZWAEKAYJLZhNHaqOLyTQ0=;
        b=r/9hkkXj9gy+gWDsLDNAcUtoR8vHv9JgYgxbrSuqji8XnlcSFPqR8/zwXi3hCq8KZt
         HgoIfKVOzSA6K6OUlwSqCanyWGU8HiEeSBInRBa6HlDtGPGEN+L4XW6WfgDzBxGqdMt8
         dlhE4TgMLw2YsbgqmXZhlrCxLSkbjdDBONgWhRR0/mfJiHu/Le0u2GjlYA5DSuIxoiz2
         v3yEvX0ZuJX+lvu0OxORxKKf8c+vS91wAXgGeIAhuUcxSYq9Wswb/gxUti6Zca/fS4/j
         v3L4k3LXqJTRzJ2mB4eqHP98MjnFTVJxQfSwyD2Mqvf9xys8+NnM0idQpEN+U1VXKOgM
         0Pfg==
X-Gm-Message-State: AOAM533/y4HJ5RmTwUHfP8ufAxw87lhNY7HIDWgUQRz4YXg5wXNlbpt0
        IL81LMA19vi2DEBnnCYOawGRLw==
X-Google-Smtp-Source: ABdhPJydHemsKTs48wiPVgEp/Hc461CvZjxrU2X87Xf1dlr2h8v+7RF5f+XgVLw3AkYxwWDmRNEYFw==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr16990851wro.413.1593434878504;
        Mon, 29 Jun 2020 05:47:58 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id e17sm12995924wrr.88.2020.06.29.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:47:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <blogic@openwrt.org>,
        Zhi Mao <zhi.mao@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/4] pwm: mediatek: Provide missing kerneldoc description for 'soc' arg
Date:   Mon, 29 Jun 2020 13:47:51 +0100
Message-Id: <20200629124752.1018358-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629124752.1018358-1-lee.jones@linaro.org>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Kerneldoc syntax is used, but not complete.

Descriptions are required for all arguments.

Fixes the following W=1 build warning:

 drivers/pwm/pwm-mediatek.c:57: warning: Function parameter or member 'soc' not described in 'pwm_mediatek_chip'

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: John Crispin <blogic@openwrt.org>
Cc: Zhi Mao <zhi.mao@mediatek.com>
Cc: linux-pwm@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-mediatek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index b94e0d09c300f..ab001ce55178e 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -46,6 +46,7 @@ struct pwm_mediatek_of_data {
  * @clk_main: the clock used by PWM core
  * @clk_pwms: the clock used by each PWM channel
  * @clk_freq: the fix clock frequency of legacy MIPS SoC
+ * @soc: pointer to chip's platform data
  */
 struct pwm_mediatek_chip {
 	struct pwm_chip chip;
-- 
2.25.1

