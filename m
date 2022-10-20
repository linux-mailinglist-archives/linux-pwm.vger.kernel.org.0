Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB802606402
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Oct 2022 17:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJTPQR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Oct 2022 11:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJTPQQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Oct 2022 11:16:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2151382EA
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2022 08:16:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w18so35063135wro.7
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2022 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPfdUDxQ8JWzLN/qiL20jBM0KQ2BlXI48NY7ZfUHHSc=;
        b=R47J7bhm6nc6f+hbSTG6ubo+fIvok0uIfxmJnOX9lBwOGpzg7l8tU9mO0q3PzZw/Eo
         A86ckdcXYz85ZzJzZXRpPKJmIf7tQaDbFWFbs4lDHGgwFct04cRrHJwyhylP4vIGPOOq
         nG6wpaXqnvZeYRWSCZz7cZ+y1dRHeft7WEMYxC8E1TROTVrGlW5WSHHT7KwxjaHSnTpR
         V3m/dAmfkKDA7V7nCoSKw1E7gN35CtbVow0YdcfLWHbosD+XAxA39qS9hbsvMg/Y696n
         l9i3J0YhLHioHHVSxOSqKZlDFmE9aU7D0lIJlmgq0bgi6q3kzsSlQymtZPkux8m2pvQY
         pNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPfdUDxQ8JWzLN/qiL20jBM0KQ2BlXI48NY7ZfUHHSc=;
        b=IkFzLGyPJt9KVTTTvx+hnr/8QvfkY57YI5uvqAJjac6dxW1lV9bcbo6AmkomwBBt3m
         3t96MegUbHr4irNTCvp9oiUsroMFZb4ABX4TzjFPdC7miQrwZA10+mpleBC6SMCW/5Su
         MWcbsYTZ9AZ/Ixz0wL2h9BVpA8Orx1wzyI+C7mSolUyNJyLE7u1cZ5i8IR/3cI09LmOX
         PhnnIfXw6woaOcwG9lYHSj23EsJFpT+CU+aRDoN59S8mRzfYifXP7PmXXbixkxScVAn3
         P83pXTfdJ3l+hQdVYxh4yGXpD62pkc+nDdMMpc0PtaMn6a7TX8pJQnRklwfNVEn5DOfd
         O+ag==
X-Gm-Message-State: ACrzQf2CHI1B46Ob15kZ+V9O/+yX8k7L85kTX/GOS/01D/d57syFdXZb
        4zQ+bTZTtdDc9NoPmb9one/2/Q6cfWZ+8CDZlZJaHp72cpaS7H+Y+dAQdduAPq8Y47X14upkht7
        q+cMnj1OfogdV8dMr8qF4kMd+J51rd58E0j4kQ2Lvh0GMKyNoFy2yq6qu6Z5iFYjT/R481i+Nrd
        E=
X-Google-Smtp-Source: AMsMyM4jI2hcOzEdc5K0f/c82GJsXiCvu7j6Wo8CQbxy1l2wkijCAqWKzRAC/Jkkkni6l5QGv/C9tw==
X-Received: by 2002:a05:6000:154e:b0:230:45ad:fb87 with SMTP id 14-20020a056000154e00b0023045adfb87mr9474567wry.270.1666278973340;
        Thu, 20 Oct 2022 08:16:13 -0700 (PDT)
Received: from rainbowdash.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b003c6f3e5ba42sm41362wmb.46.2022.10.20.08.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:16:12 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v6 00/10] Designware PWM driver updates for OF
Date:   Thu, 20 Oct 2022 16:16:00 +0100
Message-Id: <20221020151610.59443-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is an updated version of the Designware PWM driver updates
for OF support, which now splits the driver into PCI and OF parts
as well as tries to sort out the review comments.

Hopefully this can now be queued for the next kernel version.

v6:
 - fix removal ordering of DWC_PERIOD_NS
v5:
 - fixed kconfig string error
 - merged pwm-nr into main of code
 - split of code from pci code
 - updated pwm-nr capping
 - fix duplicate error reporting in of-code
 - fix return in of-probe
 - remove unecessary remove function as devm_ functions sort this
 - fixed ordering of properties
 - added missing reg item
 - fixed missing split of the two clock sources.
 - get bus clock in of code
v4:
 - split pci and of into new modules
 - fixup review comments
 - fix typos in dt-bindings
v3:
- change the compatible name
- squash down pwm count patch
- fixup patch naming
v2:
- fix #pwm-cells count to be 3
- fix indetation 
- merge the two clock patches
- add HAS_IOMEM as a config dependency


Ben Dooks (10):
  dt-bindings: pwm: Document Synopsys DesignWare
    snps,pwm-dw-apb-timers-pwm2
  pwm: dwc: allow driver to be built with COMPILE_TEST
  pwm: dwc: change &pci->dev to dev in probe
  pwm: dwc: move memory alloc to own function
  pwm: dwc: use devm_pwmchip_add
  pwm: dwc: split pci out of core driver
  pwm: dwc: make timer clock configurable
  pwm: dwc: add of/platform support
  pwm: dwc: add PWM bit unset in get_state call
  pwm: dwc: use clock rate in hz to avoid rounding issues

 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml |  68 ++++++
 drivers/pwm/Kconfig                           |  24 +-
 drivers/pwm/Makefile                          |   2 +
 drivers/pwm/pwm-dwc-of.c                      |  76 +++++++
 drivers/pwm/pwm-dwc-pci.c                     | 134 +++++++++++
 drivers/pwm/pwm-dwc.c                         | 210 ++++--------------
 drivers/pwm/pwm-dwc.h                         |  59 +++++
 7 files changed, 402 insertions(+), 171 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
 create mode 100644 drivers/pwm/pwm-dwc-of.c
 create mode 100644 drivers/pwm/pwm-dwc-pci.c
 create mode 100644 drivers/pwm/pwm-dwc.h

-- 
2.35.1

