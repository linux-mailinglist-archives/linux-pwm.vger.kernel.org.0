Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362D45F278B
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Oct 2022 03:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiJCB4K (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Oct 2022 21:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJCB4I (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Oct 2022 21:56:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E052F3B0
        for <linux-pwm@vger.kernel.org>; Sun,  2 Oct 2022 18:56:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u24so1483954plq.12
        for <linux-pwm@vger.kernel.org>; Sun, 02 Oct 2022 18:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=H2yW7sQlNTQsS+bDO3N4aI2ZS8x5GxxjQBsHy/zLo+E=;
        b=f2XfdUgnhVyStk0l3FWEjxVjLD7M34YLcjcb4GfH/DpaPtFqyH8l6cL0qslWWRTNDs
         lQu8eYIRoBJJd39HYi7hqiBcdIf53DIoEBXTsJNAH6EV795e3S/5towDAYsuNzF55oFW
         mg/pdHtGZpKo9sPcPbrPj0F/QHM1fpUHbLiYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=H2yW7sQlNTQsS+bDO3N4aI2ZS8x5GxxjQBsHy/zLo+E=;
        b=6iugqOb4/nBp+DbxhPTas+/Qqi06JrmOgDQ9AoPEBRM58WBSLTSjEn9HTxgMdMHB8L
         J95h5r8QVet0c9QsJe+apk55ZqmVAtO+z5wooIE+CB1o5DvtoG3dZX4t+sViv51ZLBkM
         fSlTqOBvhrHB2wwntRyhGIL8pNocYroJ92nCe7cSd3zX2nIjRexP9rzwM05iiIc/PQSY
         CCq4sx7ukRwZlNG90RJIOy5zuco3n/cF/mKHLRsYOKkD2xCCofL7VAxfvHN0XDeIQ6jP
         IAFNyzb9AQiT12Q9TmHmgaGRAYrSvAex9+xFCfbLHyR1qhsU+4ydKVgUW13+brR4MmRF
         eTMQ==
X-Gm-Message-State: ACrzQf1FJ/TMMYyoCJoAdfGMc/8sO1FUnc87KuIHUnRHcAWyIvvQdVbe
        vJdEswvmp/Ygmp2K1Gx3VZIV4MtAvG1Ya195S9w=
X-Google-Smtp-Source: AMsMyM5+JcoMhHIGKRbOdTtKXdW1kDyvLFRGQWsmj6tUjS5O9PY4SI/uX07w1jthnXQVx7LJfLy7Hw==
X-Received: by 2002:a17:902:b101:b0:17b:5e1f:484a with SMTP id q1-20020a170902b10100b0017b5e1f484amr18557840plr.71.1664762166741;
        Sun, 02 Oct 2022 18:56:06 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.45.132.124])
        by smtp.gmail.com with ESMTPSA id s9-20020a17090302c900b0017b69f99321sm5893786plk.219.2022.10.02.18.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 18:56:06 -0700 (PDT)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 0/5] pwm: pxa: Fixes for enable/disable transitions
Date:   Sun,  2 Oct 2022 18:55:41 -0700
Message-Id: <20221003015546.202308-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

I ran into a couple of problems while getting this driver working on the
PXA168. It wouldn't always activate properly when I turned it on, and it
wouldn't always deactivate properly when I turned it off. These patches
fix issues with the clock enable/disable transitions.

With these patches applied, the driver works flawlessly with my use
cases on the PXA168. I don't have any other PXAxxx devices to test with.

Changes since v1:

- Remove pxa_pwm_enable and pxa_pwm_disable.
- Reorganize pxa_pwm_apply based on Uwe's suggestions.
- Enable this driver with ARCH_MMP for the PXA168.
- Add delay after clock is disabled (and inhibit brief on/off blips).

After applying the first round of suggested fixes, I discovered (while
using it as a PWM backlight) that I was once again being affected by the
"too quick" on->off->on transitions, which resulted in silent failure.
Hopefully this isn't too crazy, but I fixed it by adding a delay to
allow the last period to finish after the clock is requested to be
disabled. When you turn the clock off, it stays latched on until the
period finishes (because PWMCR_SD is not set). If you try to turn it
back on during this time, the request is ignored and it shuts off
anyway. Waiting a full period before attempting to start the clock again
avoids the problem.

I also inhibited register setup if PWM is already disabled and staying
disabled in an attempt to avoid unnecessary brief on/off "blips".

Doug Brown (5):
  pwm: pxa: Remove pxa_pwm_enable/disable
  pwm: pxa: Set duty cycle to 0 when disabling PWM
  pwm: pxa: Remove clk enable/disable from pxa_pwm_config
  pwm: pxa: Wait for final PWM period to finish
  pwm: pxa: Enable for MMP platform

 drivers/pwm/Kconfig   |  2 +-
 drivers/pwm/pwm-pxa.c | 64 ++++++++++++++++++++++---------------------
 2 files changed, 34 insertions(+), 32 deletions(-)

-- 
2.34.1

