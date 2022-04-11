Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA144FC046
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Apr 2022 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347806AbiDKPXg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Apr 2022 11:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347695AbiDKPXe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Apr 2022 11:23:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B675E32993
        for <linux-pwm@vger.kernel.org>; Mon, 11 Apr 2022 08:21:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso10273579wml.5
        for <linux-pwm@vger.kernel.org>; Mon, 11 Apr 2022 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/VFG6EulH67RRWPIE71JJK8AZq6cWf3+aNSyjdrV2C8=;
        b=f8FW30h1HbOZrWHAWLe1L6knIAO0lJCzBwigFR02VS5ig3PismUohmyDbYry74u0YC
         UV5H7kw4tET6yKSP4M+ROchJBxSEI4tPWRE+9dUf4NNKvRls9SfSV+pJDH9H5jo177AX
         S3p2Tb1K2+rBEP6VzhnsL5P5Oz4zNM4yZM/Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/VFG6EulH67RRWPIE71JJK8AZq6cWf3+aNSyjdrV2C8=;
        b=vOUZQNu3FZP0UAGCWx6i+MNx9nXnmM9hi/ZAkgkWqtcuV8Ho84iy5/gnmnP6FeKm60
         cEJ3xksnwqe1NOgmFD1PB/WIerMq/XWHondTrUExl99JJzt7wfSsqyhXhbM0ZVx2+F9V
         jKEN3TNXdRy5l6vQo3+NjqPH7TA3n3GJMHxyLXxa+3EWBSVRISNcFTUn3IGDIrBxVG1X
         wjXRuAXCJZwPLs5HqSuxRQzybC8cuV1AqDMoiEz5KIj/ZbBAi5RKdl0bgKhBxArb0sE0
         NQB47I4dCxQm98tTZt9hwFKJsL/etXv2k0QkNGct+/ZlvWcPGixWOYgU8GudVKucIMQJ
         vLIg==
X-Gm-Message-State: AOAM532AtdqhdSUuJ7EIIoMH6guqiEx0gXM3foM8a579wXjrJjGIjGw8
        RAgcaHIIqF3buxnzv72G5KV64A==
X-Google-Smtp-Source: ABdhPJwbqNlCfR4VhfhDPHHdmhTKyU7+ZvArbU48oZz50iRIBTjWcOKUrdfpPb01ZRfsKygY1pculg==
X-Received: by 2002:a7b:c5cd:0:b0:38c:8b1b:d220 with SMTP id n13-20020a7bc5cd000000b0038c8b1bd220mr28977405wmk.118.1649690476941;
        Mon, 11 Apr 2022 08:21:16 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm19512832wrb.63.2022.04.11.08.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:21:16 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>
Subject: [PATCH v3 0/4] Add channel type support to pwm-cros-ec
Date:   Mon, 11 Apr 2022 15:21:10 +0000
Message-Id: <20220411152114.2165933-1-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

The ChromiumOS EC PWM host command protocol supports specifying the
requested PWM by type rather than channel. [1]

This series adds support for specifying PWM by type rather than channel
number in the pwm-cros-ec driver, which abstracts the node definitions
from the actual hardware configuration from the kernel perspective,
aligns the API with the one used by the bootloader, and allows removing
some dtsi overrides.

Tested on a sc7180-trogdor board.

Changes from v2:
(https://patchwork.kernel.org/project/chrome-platform/list/?series=627837)
- reworded patch 2 commit description
- reworked the driver and dt documentation to use a new compatible rather than
  boolean property
- dropped the comment about build test only, tested on actual hardware
  (trogdor), build test on x86 (with CONFIG_OF=n).

Changes from v1:
(https://patchwork.kernel.org/project/chrome-platform/list/?series=625182)
- fixed the dt include file license
- fixed the property name (s/_/-/)
- rebased on current linus tree (few dts files changed from a soc tree
  pull, so patch 4 needs a recent base to apply correctly)

[1] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/common/pwm.c;l=24
[2] https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/depthcharge/src/drivers/ec/cros/ec.c;l=1271-1273

Fabio Baltieri (4):
  dt-bindings: add mfd/cros_ec definitions
  drivers: pwm: pwm-cros-ec: add channel type support
  dt-bindings: update google,cros-ec-pwm documentation
  arm64: dts: address cros-ec-pwm channels by type

 .../bindings/pwm/google,cros-ec-pwm.yaml      |   9 +-
 .../mt8183-kukui-jacuzzi-fennel-sku1.dts      |   4 +-
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |   4 +-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   1 +
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |   4 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |   9 +-
 .../qcom/sc7280-herobrine-herobrine-r0.dts    |   7 +-
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |   7 +-
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |   4 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |   7 +-
 .../boot/dts/rockchip/rk3399-gru-bob.dts      |   4 -
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |   5 +-
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    |   4 -
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |   1 +
 drivers/pwm/pwm-cros-ec.c                     | 109 ++++++++++++++----
 include/dt-bindings/mfd/cros_ec.h             |  18 +++
 16 files changed, 140 insertions(+), 57 deletions(-)
 create mode 100644 include/dt-bindings/mfd/cros_ec.h

-- 
2.35.1.1178.g4f1659d476-goog

