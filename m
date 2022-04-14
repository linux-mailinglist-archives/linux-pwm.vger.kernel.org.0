Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4DE5009C6
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Apr 2022 11:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbiDNJbC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Apr 2022 05:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbiDNJbA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Apr 2022 05:31:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E786E4CB
        for <linux-pwm@vger.kernel.org>; Thu, 14 Apr 2022 02:28:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g18so6053800wrb.10
        for <linux-pwm@vger.kernel.org>; Thu, 14 Apr 2022 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQ1Ns6exvywbj5YVrqChmYabRv4bnzV6d00OZRotDxk=;
        b=hTP08ZMDNByzNE+rOxyiJkLh1x9yUlo716JKFvue1wfejnxuRwmCzb7ZFTk/YjVQ12
         o0vKMBgoU7iyS3t3bwVhu8mymoFVKPqcLc+2zW4wk+RKx8fYE1YrW8DF/2m6HL9s4cqc
         GuuuZMODv27K+4dioFQboC6aH4spw0V4bj74Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQ1Ns6exvywbj5YVrqChmYabRv4bnzV6d00OZRotDxk=;
        b=xNuekE9ThURe5unaXVYqYcMr2IHqS/BgNPr+i6AH/jx271xvIFAGQytsogH6kegkVV
         AUBcwSD2jGtzpMVsmhaJS9yqElenVBVrmUArRDKS0GcLC1gCaZZW0Ia2l3AGu3TfDdIv
         V/XI0vUqodaF50cP0TmFndDEiFyVt2bW9pIcUk4M3scHdwT5OLyWCgwMcDBD6lBq7+y8
         T3bCl29fbdrl++HWo0EgRIdxZ0IUpVmmKchCv220LiquKbvnp1upwo5eKm6muifY3lj0
         ga6pW+9WEVDIBpVGpjgy75qB8X0odJGiv2ejFHEspPP0BU9sKfDV8lJ2BtMRmGD22Nr1
         Gr6g==
X-Gm-Message-State: AOAM532/pe/ODKMvxANZ3LXlOY49K2tNpGM4fe2jzGLRpbfE9IjZsy2S
        rEr0U5Lj5fH2s1LCm6NwIUKTLA==
X-Google-Smtp-Source: ABdhPJxNm30rXQDMpWZpc08ebVbqvKPBKcHSxDG4T9G3LivzhKHgSKTkBAvQOg/b3BVjtkQeWuwuEA==
X-Received: by 2002:a05:6000:1202:b0:207:a5f6:fc0 with SMTP id e2-20020a056000120200b00207a5f60fc0mr1410782wrx.438.1649928513656;
        Thu, 14 Apr 2022 02:28:33 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b0038e4c5967besm1698099wmb.3.2022.04.14.02.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 02:28:33 -0700 (PDT)
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
Subject: [PATCH v4 0/4] Add channel type support to pwm-cros-ec
Date:   Thu, 14 Apr 2022 09:28:27 +0000
Message-Id: <20220414092831.3717684-1-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
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

Tested on a sc7180-trogdor board, build tested on x86.

Changes from v3:
(https://patchwork.kernel.org/project/chrome-platform/list/?series=631131)
- actually reworded patch 2 commit description
- reworked patch 2 to use of_device_is_compatible() instead of compatible .data

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
  pwm: pwm-cros-ec: add channel type support
  dt-bindings: update google,cros-ec-pwm documentation
  arm64: dts: address cros-ec-pwm channels by type

 .../bindings/pwm/google,cros-ec-pwm.yaml      |  9 +-
 .../mt8183-kukui-jacuzzi-fennel-sku1.dts      |  4 +-
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |  4 +-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  1 +
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  4 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  9 +-
 .../qcom/sc7280-herobrine-herobrine-r0.dts    |  7 +-
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  7 +-
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |  4 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |  7 +-
 .../boot/dts/rockchip/rk3399-gru-bob.dts      |  4 -
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  5 +-
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  4 -
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  1 +
 drivers/pwm/pwm-cros-ec.c                     | 82 +++++++++++++++----
 include/dt-bindings/mfd/cros_ec.h             | 18 ++++
 16 files changed, 121 insertions(+), 49 deletions(-)
 create mode 100644 include/dt-bindings/mfd/cros_ec.h

-- 
2.35.1.1178.g4f1659d476-goog

