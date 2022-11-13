Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C702D627381
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Nov 2022 00:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiKMXgr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 13 Nov 2022 18:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiKMXgq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 13 Nov 2022 18:36:46 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C6FCE2A
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:36:45 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f3so2466502pgc.2
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2oa04UU65G5c9Rs+m30vB7MFgSlNEvRRp6q3MFpYSE=;
        b=edVcpy3q5ahb5Htb8Nx5J430lCrOloKch+m3ahU4zX6gSSo/5gd8cGYC/m0SllqOTK
         /GenjOGjW0VnPBABzpiSuRX0buHnQtwjp+BZ+XhBTOIuFNqqEVIk23E47qgeRfVZ4aiq
         rCkgC86aeuRpH6qRNzyuQkewZr3rPA2YUvA6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2oa04UU65G5c9Rs+m30vB7MFgSlNEvRRp6q3MFpYSE=;
        b=R8OmpZgxwizp0+MA1iP3riEq6PXb+YmoC0hqy+7SOv3fyxfnVpcU26mrGMpKEesXZm
         h2E82kq9kjmG3XDEbmMHxo4A0sYsrguDRubYWJWaYtVrt0lQp9ssLPf6nKpFlGrwcoKv
         kIvxR7FdCs8hc2HRQhaewt4twytyjlTtL+S5H+dn35dd5zHY7d6+ukC57sfhsu2VDiX/
         518jL4N55n6ulhkwjdId5Q4q5F+IqqFvho3u4qQeur9mAm0mO+e7RThgDJJzcYxEh+R9
         gXnPTFwm2CqFZct7LZK0RHl4Us6wtyxk+76jV89E4nFd/uLVNLwGEfHaV0Sn7HEPqb+r
         nANA==
X-Gm-Message-State: ANoB5pnJT5AIdTKWd/MdSlhQ4EP5jT6x+IdOgT+Mu62W11d0OOrVYV+G
        QDxpTbldRjL76HAHe234qyrvbi8ARzp4x41NIRg=
X-Google-Smtp-Source: AA0mqf5aTYPUINkwOlYo6hFkx8yOjdvHtVlXLA58VAub9QPJhoQTaf3MnHOhQX8WcWAs3jVPnVe74A==
X-Received: by 2002:a05:6a00:4187:b0:56e:3a98:1089 with SMTP id ca7-20020a056a00418700b0056e3a981089mr11510311pfb.38.1668382605157;
        Sun, 13 Nov 2022 15:36:45 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id q14-20020a635c0e000000b004597e92f99dsm4641990pgb.66.2022.11.13.15.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 15:36:44 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 0/6] pwm: pxa: Fixes for enable/disable transitions
Date:   Sun, 13 Nov 2022 15:36:33 -0800
Message-Id: <20221113233639.24244-1-doug@schmorgal.com>
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

Changes in v3:

- Switch to abrupt shutdown mode instead of the delay hack from v2.
- Fix commit message explaining why duty cycle is set to 0.
- Add documentation link and limitations section at top of file.

Changes in v2:

- Remove pxa_pwm_enable and pxa_pwm_disable.
- Reorganize pxa_pwm_apply based on Uwe's suggestions.
- Enable this driver with ARCH_MMP for the PXA168.
- Add delay after clock is disabled (and inhibit brief on/off blips).

Doug Brown (6):
  pwm: pxa: Remove pxa_pwm_enable/disable
  pwm: pxa: Set duty cycle to 0 when disabling PWM
  pwm: pxa: Remove clk enable/disable from pxa_pwm_config
  pwm: pxa: Use abrupt shutdown mode
  pwm: pxa: Add reference manual link and limitations
  pwm: pxa: Enable for MMP platform

 drivers/pwm/Kconfig   |  2 +-
 drivers/pwm/pwm-pxa.c | 58 +++++++++++++++++++------------------------
 2 files changed, 26 insertions(+), 34 deletions(-)

-- 
2.34.1

