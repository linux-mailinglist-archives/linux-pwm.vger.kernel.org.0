Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE36C46C8CB
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Dec 2021 01:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbhLHAlI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Dec 2021 19:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLHAlH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Dec 2021 19:41:07 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49366C061574;
        Tue,  7 Dec 2021 16:37:36 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i12so961528pfd.6;
        Tue, 07 Dec 2021 16:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1JqiKmk6tDXTGaEtxrWkscvDqDyptyUAa8P68lBP78=;
        b=e7ZCQCYLVUlkbwiET3x8XGUJvHkHUvd43LC/57XOAliKbhQL+wLXvWG+N3kWQKuqzh
         io5BIc4OI7m7AOHCA15+BPI8eh+8W2tT7QPyhjUFsZ7Ghrc4Rto4ehR9u/EoEEhbSAAf
         hgLiM731m2wk0EEBrUbYwS364yQgrOIdT0uIZrCFERwZ7XuKY/hv+zj97b3kDuFFyu7k
         C/YIYSuxRDEmRai8VxjxqiuNYr1PWdmztH7snc+i7SsSAM/925YL5i4XUCnyDGX+4QA9
         +tcaT8hQuiX5BkVQHo/twnO9dViGcIUrfsJil82BcauXmiUEosTJ/1/XSiNkT0uoXEqs
         Dx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1JqiKmk6tDXTGaEtxrWkscvDqDyptyUAa8P68lBP78=;
        b=QGdFUWSpkjiJDH8kjoacgLVcj9oEbYb19YLahwEEzmYxoTABiKL4B94I6HqSSRwOem
         uSAgHxTBuCS9daAeeXcekF9R3tSC7fp/3g22P0p2oW8zYp8VQW9G5Ugg1Q7wye0T0IqR
         bTHoAVnSwpvcEV92eyDJ9PDU1CEdqzAuvQRPMV9YvhdD/+KrrnPE51SZOiIRNDX8fMts
         TyS2slSurZlxcKLNBddG68pkQXy1qxjCGy98X1cyttRGWt3qpeHuqVdO5vJig+fmkVx5
         mXOzdiwCmtujgrlOYIRg/wipELiQnG7D71DpggcjE3gTB1MFtyqwtbSM9ncRPqqI26Xp
         +DnA==
X-Gm-Message-State: AOAM533Eq+WK4lhK4VzhgOE7MZiW0b9VMgp0kKlaA32pIKdYQYE8zFOq
        gYSbGayMmZUPRhF/Wypx3vryuf4S/nc=
X-Google-Smtp-Source: ABdhPJwqrp9gusPoC3YlTeudrf4lwuZxAAEaJ0rKEiK6MFezKDknwVre8S4PowzGx2Y6fqMMMTcD4A==
X-Received: by 2002:a63:496:: with SMTP id 144mr27574514pge.552.1638923855357;
        Tue, 07 Dec 2021 16:37:35 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:37:34 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Gregory Fong <gregory.0xf0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...),
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-crypto@vger.kernel.org (open list:HARDWARE RANDOM NUMBER
        GENERATOR CORE),
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH v3 00/15] Broadcom DT bindings updates to YAML
Date:   Tue,  7 Dec 2021 16:37:11 -0800
Message-Id: <20211208003727.3596577-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

This patch series contains a number of device tree bindings being
converted to YAML to help with validation.

There will be second, and possibly third rounds later on after those
land in.

Thanks!

Changes in v3;

- added Gregorys' Acked-by to the GPIO binding patch
- added Uwe's Acked-by to the PWM binding patch
- fixed STB L2 binding to include the missing 2711 compatible string
  and interrupt-names property for 7445
- fixed the NSP SATA3 controller node unit name and added a missing
  check for the 63138 variant to check for the reset/reset-names
  property

Changes in v2:

- rebased against dt/next
- addressed Gregory's feedback on the GPIO binding change
- added Damien's Acked-by to the ATA binding patch

Florian Fainelli (15):
  dt-bindings: mmc: Convert Broadcom STB SDHCI binding to YAML
  dt-bindings: reset: Convert Broadcom STB reset to YAML
  dt-bindings: pwm: Convert BCM7038 PWM binding to YAML
  dt-bindings: rtc: Convert Broadcom STB waketimer to YAML
  dt-bindings: gpio: Convert Broadcom STB GPIO to YAML
  dt-binding: interrupt-controller: Convert BCM7038 L1 intc to YAML
  dt-bindings: interrupt-controller: Convert BCM7120 L2 to YAML
  dt-bindings: interrupt-controller: Merge BCM3380 with BCM7120
  dt-bindings: interrupt-controller: Convert Broadcom STB L2 to YAML
  dt-bindings: rng: Convert iProc RNG200 to YAML
  dt-bindings: thermal: Convert Broadcom TMON to YAML
  ARM: dts: NSP: Rename SATA unit name
  dt-bindings: ata: Convert Broadcom SATA to YAML
  dt-bindings: bus: Convert GISB arbiter to YAML
  dt-bindings: usb: Convert BDC to YAML

 .../bindings/ata/brcm,sata-brcm.txt           |  45 ------
 .../bindings/ata/brcm,sata-brcm.yaml          |  98 ++++++++++++
 .../devicetree/bindings/bus/brcm,gisb-arb.txt |  34 ----
 .../bindings/bus/brcm,gisb-arb.yaml           |  66 ++++++++
 .../bindings/gpio/brcm,brcmstb-gpio.txt       |  83 ----------
 .../bindings/gpio/brcm,brcmstb-gpio.yaml      | 105 ++++++++++++
 .../brcm,bcm3380-l2-intc.txt                  |  39 -----
 .../brcm,bcm7038-l1-intc.txt                  |  61 -------
 .../brcm,bcm7038-l1-intc.yaml                 |  91 +++++++++++
 .../brcm,bcm7120-l2-intc.txt                  |  88 -----------
 .../brcm,bcm7120-l2-intc.yaml                 | 149 ++++++++++++++++++
 .../interrupt-controller/brcm,l2-intc.txt     |  31 ----
 .../interrupt-controller/brcm,l2-intc.yaml    |  71 +++++++++
 .../bindings/mmc/brcm,sdhci-brcmstb.txt       |  53 -------
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 100 ++++++++++++
 .../bindings/pwm/brcm,bcm7038-pwm.txt         |  20 ---
 .../bindings/pwm/brcm,bcm7038-pwm.yaml        |  43 +++++
 .../bindings/reset/brcm,brcmstb-reset.txt     |  27 ----
 .../bindings/reset/brcm,brcmstb-reset.yaml    |  48 ++++++
 .../bindings/rng/brcm,iproc-rng200.txt        |  16 --
 .../bindings/rng/brcm,iproc-rng200.yaml       |  29 ++++
 .../bindings/rtc/brcm,brcmstb-waketimer.txt   |  20 ---
 .../bindings/rtc/brcm,brcmstb-waketimer.yaml  |  44 ++++++
 .../bindings/thermal/brcm,avs-tmon.txt        |  23 ---
 .../bindings/thermal/brcm,avs-tmon.yaml       |  57 +++++++
 .../devicetree/bindings/usb/brcm,bdc.txt      |  29 ----
 .../devicetree/bindings/usb/brcm,bdc.yaml     |  46 ++++++
 MAINTAINERS                                   |   6 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                |   2 +-
 29 files changed, 951 insertions(+), 573 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
 create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
 delete mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
 create mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt
 create mode 100644 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-tmon.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.yaml

-- 
2.25.1

