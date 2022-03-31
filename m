Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C481C4EDA0D
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Mar 2022 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiCaNAO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 31 Mar 2022 09:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiCaNAL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 31 Mar 2022 09:00:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72DA3EBAB
        for <linux-pwm@vger.kernel.org>; Thu, 31 Mar 2022 05:58:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p189so14228355wmp.3
        for <linux-pwm@vger.kernel.org>; Thu, 31 Mar 2022 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s6IAiCErtoOnzY3QsYXRtTepvpiVgbrk3mBJAs+Q6vU=;
        b=bvNNA21ueIlJ6UIxIQIw6Q2a62ptN6bDTK06HUE1vsXd46k2UdcAw+hO3A0upoEgWw
         TQhZkRxWepuAwYNUMp13le4x9Znra1Dh//Xeljgx4ZKSwSfi8aMfHt4CBTppdp1WeEm0
         nm8oT4URhjVyqGxfKuB2W4h9yzjB0sTabLFxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s6IAiCErtoOnzY3QsYXRtTepvpiVgbrk3mBJAs+Q6vU=;
        b=mwBYBxJxiP/CnsTk0DpnLOXl0CtAXR4v2+1Mf4Gji6bQ+6fPUE67ijm5fv9M97wEHb
         dHo7DWApokjgI30xjR4/BwelqadkhZyZptIXibPWOu6oiDDN69+JBghI0N6NH2akaPwB
         9WdOhGGEV4yErmoLDICd1zT6SNRQv5tBO5XOXORwkJrXaYv1dl7L2ZkUJG4bu67kvk1L
         Sc/iQhjTc5RrbDJ2L1jdhNVF456MnATPJAn0Cfj5ZOAKIlG1Qnac/CmaE5tE2Rv9J0Le
         1ZEbp8H1QVcJudXOAfoApuzJKtKrt+lHYdZUplLVr3NnlbQ7c/8ewwiarJZfNmh4kMO8
         E1rg==
X-Gm-Message-State: AOAM530hfSYddK5e20YmID0njMH9bObn8tQniNYjSSY9HXrS3diV2dpO
        ZLY0LqirFdwJga1P4YoVhiZpbQ==
X-Google-Smtp-Source: ABdhPJzonrrVqK+Oc9T5eRd5302wWGc9jNLdlpnmStxZJpcaRUQhHL7NZubtbnHg8xWPm/0Nvq3LuA==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr4780128wmh.21.1648731501845;
        Thu, 31 Mar 2022 05:58:21 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038c9249ffdesm8230695wmq.9.2022.03.31.05.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:58:21 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Add channel type support to pwm-cros-ec
Date:   Thu, 31 Mar 2022 12:58:14 +0000
Message-Id: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
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

Tested on a sc7180-trogdor board, but on a version based on an older
kernel, so this exact series is build only tested.

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

 .../bindings/pwm/google,cros-ec-pwm.yaml      |  6 ++
 .../mt8183-kukui-jacuzzi-fennel-sku1.dts      |  4 +-
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |  3 +-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  1 +
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  4 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  8 +-
 .../qcom/sc7280-herobrine-herobrine-r0.dts    |  6 +-
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  6 +-
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |  3 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |  6 +-
 .../boot/dts/rockchip/rk3399-gru-bob.dts      |  4 -
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  4 +-
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  4 -
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |  1 +
 drivers/pwm/pwm-cros-ec.c                     | 80 +++++++++++++++----
 include/dt-bindings/mfd/cros_ec.h             | 18 +++++
 16 files changed, 117 insertions(+), 41 deletions(-)
 create mode 100644 include/dt-bindings/mfd/cros_ec.h

-- 
2.35.1.1021.g381101b075-goog

