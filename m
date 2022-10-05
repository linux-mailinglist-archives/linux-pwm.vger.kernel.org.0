Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8565F5C74
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Oct 2022 00:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJEWMx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Oct 2022 18:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJEWMs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Oct 2022 18:12:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C81982D32
        for <linux-pwm@vger.kernel.org>; Wed,  5 Oct 2022 15:12:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f11so25187051wrm.6
        for <linux-pwm@vger.kernel.org>; Wed, 05 Oct 2022 15:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ihn1c1dcXl4OV9zInkSHKqtzyH5iqpIvuzLLVJlBQKg=;
        b=TVykR+11Ol944ioog+ZWYqIfcv4YGosJc2jnB3ricb7zGkZyXvliJAipSOL9kB8kkx
         TByqj7Ie0MNmls48enloFT8M2/Nw5PMpqSuoi5pXUFWp4QAXsyHK8/7UZvIk7iwTTsaj
         NHGE4kWAjY6uTgF5t7nkpZwUhGbeFThIm04T18wr1ohymDeuFDAqQYASAR4OCyIPGyn2
         ag7QLouzCq5kcCwwV05EzXemoV7H+7DPxt1d7If724S5+ntxYw9p4DoWVGXJoBBmwT75
         wQwwqBaoCBMzUfXs+HrmyUAKoLDUmNfqqBq8yHB6089+p0tFovmMJ7oIpTFV9z8zJl5p
         OgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ihn1c1dcXl4OV9zInkSHKqtzyH5iqpIvuzLLVJlBQKg=;
        b=Gf2MYPE0teBmmBFNgZ0MgyVClAtukmpQotorXhgbq0QBjurJPTJML3kAWqLsMh5S5e
         oMJ3QrzuhLIv57px3L0HTgXZpoXSYdgOxhtrqwZXjCcuP80HKoHUrDgSrC4UaN4RUm6I
         u7JizwH0Q6Tepwt2Ina9xD1sffVlCNPbbZq/+HyVFinjBpe1gll3MlHIaTHNQ9p9bxZ+
         yOAfpsiRqFE3ztTVSqE280v6MrKKcJiesPgj69Ltr7cVKghUSfn864elRXGZtD8ZG3Ga
         959pVmOCoL5aanKzCGm95o2hnfjaen+a/22/LX09j9IbdnJlnWZeGjLJ8g2j1fSUk7O3
         Ik4A==
X-Gm-Message-State: ACrzQf3lOtN+EG75E309qxBYJcC90AHpVz8xj4C4lfKNs9vRuPZiwCWu
        nDIO5ApZhwNPG+vLy29+Ij5SyXjFvTQSGYvOaRsHJwcF5CWRPBJeD7BsCR9wr1DskIZGb6zNioC
        Qw5gfusQMZs+qymGwYl1nKMqPI3gQ4egH0RVVlXsAUYv1NJhvQ6x7lytMYv2ac1jFZsP2a0REwM
        k=
X-Google-Smtp-Source: AMsMyM5Bk0Tz5kvrBToNKnI9m19qc2ynG08QFn559+JEQbsLWPS+FkzMgHWdyGxp2aMYtAdbCPh5uA==
X-Received: by 2002:a05:6000:1f8f:b0:22e:627d:855c with SMTP id bw15-20020a0560001f8f00b0022e627d855cmr1036099wrb.468.1665007965538;
        Wed, 05 Oct 2022 15:12:45 -0700 (PDT)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id d2-20020adffd82000000b0022e327f849fsm12184437wrr.5.2022.10.05.15.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:12:44 -0700 (PDT)
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
Subject: [PATCH v5 00/10] Designware PWM driver updates
Date:   Wed,  5 Oct 2022 23:12:32 +0100
Message-Id: <20221005221242.470734-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is an updated version of the Designware PWM driver updates
for OF support, which now splits the driver into PCI and OF parts
as well as tries to sort out the review comments.

I think I have sorted all the review comments out, but this has been
rather difficult to find time to finish due to other work and being
ill.

Series history;

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

