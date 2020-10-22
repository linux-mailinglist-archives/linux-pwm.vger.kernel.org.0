Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C251295793
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Oct 2020 07:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502058AbgJVFFS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Oct 2020 01:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443800AbgJVFFP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Oct 2020 01:05:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5BFC0613CF
        for <linux-pwm@vger.kernel.org>; Wed, 21 Oct 2020 22:05:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w11so317293pll.8
        for <linux-pwm@vger.kernel.org>; Wed, 21 Oct 2020 22:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=br1VG/AftR5rvhAmwlJkFmu6wT77im0wqYMY63lXCPc=;
        b=f48hBtEYiQ9cumyN91pZln9WRYzYGIagC8IaqGZt02+O2MHl6eQhg0BtJ9+cg1Lz5h
         o78FtZXmTE3jBKH3YGJw6UO0d0jZFwtKCoYPkexfnY1SZ/dfXt7VslCJZM/bN6IMdzvi
         1GjVCtofogBD1D5SMd8g0By60jOJ/X9Pviva4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=br1VG/AftR5rvhAmwlJkFmu6wT77im0wqYMY63lXCPc=;
        b=KOr0HRYDYmS/Y1xJaz1tYdVwObDrpbfd53SPIbG2iOcOmaFAVHFRi/+fubEr8L/O6a
         +FfL+9MvNE3eSYuYzFePNBq+PW+6dZ5KwefQ0NO0YPxNflvaG8Hw6lrYZTAZSPXnfdTS
         jeumaoh9cpqvwuH+QkOjaElhWN1pdPX8Y28kxkREwYH/ydtNkqmFasqMwwI1UHVoH//I
         A6wMV42jTROxlbSFh3zR/GRyg/Q6NauvrwTrs4RzYkhAAZHBdyUCATdHq3UkO+RmiWoA
         JE1yYB+0fxI/YMW4sPd8wOgBpYkwdmcEov22a2KWS+C96Dh3fFIH7eHGUFK+iaCaDCtV
         J8Pw==
X-Gm-Message-State: AOAM5317y/IRoXLaa/xWFO2/CEo4q0ktsQ/gGGuVErNimtSS7srHzE0k
        nNOsscLNFvyV/Davg+6aHsFgnQ==
X-Google-Smtp-Source: ABdhPJymcPyyQm+Vwkk6bRyWkhQZdrrKBm+8kHDpsoJwQTQghvs0I0e+UpqN3Vxv1JCNbjDoQlFwsw==
X-Received: by 2002:a17:902:ab89:b029:d5:b297:2cc1 with SMTP id f9-20020a170902ab89b02900d5b2972cc1mr765458plr.7.1603343113453;
        Wed, 21 Oct 2020 22:05:13 -0700 (PDT)
Received: from alex-desktop.lan (c-73-63-253-164.hsd1.ca.comcast.net. [73.63.253.164])
        by smtp.gmail.com with ESMTPSA id q16sm394954pfu.206.2020.10.21.22.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 22:05:12 -0700 (PDT)
From:   Alexandru Stan <amstan@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru Stan <amstan@chromium.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 0/3] PWM backlight interpolation adjustments
Date:   Wed, 21 Oct 2020 22:04:42 -0700
Message-Id: <20201022050445.930403-1-amstan@chromium.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

I was trying to adjust the brightness-levels for the trogdor boards:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2291209
Like on a lot of panels, trogdor's low end needs to be cropped,
and now that we have the interpolation stuff I wanted to make use of it
and bake in even the curve that's customary to have on chromebooks.

I found the current behavior of the pwm_bl driver a little unintuitive
and non-linear. See patch 1 for a suggested fix for this.

A few veyron dts files were relying on this (perhaps weird) behavior.
Those devices also want a minimum brightness like trogdor, so changed
them to use the new way.

Finally, given that trogdor's dts is part of linux-next now, add the
brightness-levels to it, since that's the original reason I was looking at
this.

Changes in v3:
- Reordered patches, since both dts changes will work just fine
  even before the driver change.
- Rewrote a bit of the commit message to describe the new policy,
  as Daniel suggested.
- Removed redundant s64 for something that's always positive

Changes in v2:
- Fixed type promotion in the driver
- Removed "backlight: pwm_bl: Artificially add 0% during interpolation",
  userspace works just fine without it because it already knows how to use
  bl_power for turning off the display.
- Added brightness-levels to trogdor as well, now the dts is upstream.


Alexandru Stan (3):
  ARM: dts: rockchip: veyron: Remove 0 point from brightness-levels
  arm64: dts: qcom: trogdor: Add brightness-levels
  backlight: pwm_bl: Fix interpolation

 arch/arm/boot/dts/rk3288-veyron-jaq.dts      |  2 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts   |  2 +-
 arch/arm/boot/dts/rk3288-veyron-tiger.dts    |  2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi |  9 +++
 drivers/video/backlight/pwm_bl.c             | 70 +++++++++-----------
 5 files changed, 43 insertions(+), 42 deletions(-)

-- 
2.28.0

