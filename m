Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D77D0D64
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Oct 2023 12:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376943AbjJTKhu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Fri, 20 Oct 2023 06:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376857AbjJTKht (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Oct 2023 06:37:49 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B39D5B;
        Fri, 20 Oct 2023 03:37:46 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A854424E0F6;
        Fri, 20 Oct 2023 18:37:43 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 20 Oct
 2023 18:37:43 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 20 Oct 2023 18:37:42 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Hal Feng" <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v6 0/4] StarFive's Pulse Width Modulation driver support
Date:   Fri, 20 Oct 2023 18:37:37 +0800
Message-ID: <20231020103741.557735-1-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

This patchset adds initial rudimentary support for the StarFive
Pulse Width Modulation controller driver. And this driver will
be used in StarFive's VisionFive 2 board.The first patch add
Documentations for the device and Patch 2 adds device probe for
the module.

Changes v5->v6:
- Rebased to v6.6rc5.
- Changed driver into a generic OpenCores driver.
- Modified dt-bindings description into OpenCores.
- Uesd the StarFive compatible string to parameterize.

Changes v4->v5:
- Rebased to v6.6rc2.
- Updated macro definition indent.
- Replaced the clock initializes the interface.
- Fixed patch description.

Changes v3->v4:
- Rebased to v6.5rc7.
- Sorted the header files in alphabetic order.
- Changed iowrite32() to writel().
- Added a way to turn off.
- Modified polarity inversion implementation.
- Added 7100 support.
- Added dts patches.
- Used the various helpers in linux/math.h.
- Corrected formatting problems.
- Renamed dtbinding  to 'starfive,jh7100-pwm.yaml'.
- Dropped the redundant code.

Changes v2->v3:
- Fixed some formatting issues.

Changes v1->v2:
- Renamed the dt-binding 'pwm-starfive.yaml' to 'starfive,jh7110-pwm.yaml'.
- Dropped the compatible's Items.
- Dropped the unuse defines.
- Modified the code to follow the Linux coding style.
- Changed return value to dev_err_probe.
- Dropped the unnecessary local variable.

The patch series is based on v6.6rc5.

William Qiu (4):
  dt-bindings: pwm: Add OpenCores PWM module
  pwm: opencores: Add PWM driver support
  riscv: dts: starfive: jh7110: Add PWM node and pins configuration
  riscv: dts: starfive: jh7100: Add PWM node and pins configuration

 .../bindings/pwm/opencores,pwm-ocores.yaml    |  53 +++++
 MAINTAINERS                                   |   7 +
 .../boot/dts/starfive/jh7100-common.dtsi      |  24 ++
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |   9 +
 .../jh7110-starfive-visionfive-2.dtsi         |  22 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |   9 +
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ocores.c                      | 211 ++++++++++++++++++
 9 files changed, 347 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml
 create mode 100644 drivers/pwm/pwm-ocores.c

--
2.34.1

