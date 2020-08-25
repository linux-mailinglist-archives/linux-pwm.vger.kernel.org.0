Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A369252019
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 21:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHYTgA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 15:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYTf7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Aug 2020 15:35:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9EB72075E;
        Tue, 25 Aug 2020 19:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384158;
        bh=M1J8uZpqgbBk0Tp3JOS/OOQb4fA/JLnQDLU2aYyUXZk=;
        h=From:To:Cc:Subject:Date:From;
        b=HIS7rlbZC99+PFJ+c8TL3+mAFsePhLupI704uWAszxjjQtUK0rRn26QHhWk51eWPf
         osIIVZV6O8lT/j7Ew+BLD285VUcGHCFOkYLMR0yuSzUtYuTjxNzMDHDy+Ab3kRUQYC
         hmdIrv3bnxN73fG1c+3EPyro5Z47zPoDJd5DzXyQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 00/19] dt-bindings / arm64: Cleanup of i.MX 8 bindings
Date:   Tue, 25 Aug 2020 21:35:17 +0200
Message-Id: <20200825193536.7332-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

This is a v3 of cleanup of i.XM 8 bindings and DTSes.

It is separate patchset from i.MX 8 pin configuration cleanup, which
also touch the bindings [1]. No dependencies (although in my tree this
comes first).

Merging
=======
There are no dependencies, so dt-bindings could go through Rob's tree,
DTS through SoC. I think there is no point to push dt-bindings changes
through subsystem maintainers (gpio, pwm, watchdog, mtd etc). Usually
Rob has been picking them up.

Changes since v2:
=================
1. Add Rob's review,
2. Correct things pointed during review (see individual patches and
their change logs).

[1] dt-bindings: mtd: gpmi-nand: Fix matching of clocks on different SoC

Best regards,
Krzysztof


Krzysztof Kozlowski (19):
  dt-bindings: gpio: fsl-imx-gpio: Add i.MX 8 compatibles
  dt-bindings: gpio: fsl-imx-gpio: Add gpio-ranges property
  dt-bindings: gpio: fsl-imx-gpio: Add parsing of hogs
  dt-bindings: gpio: fsl-imx-gpio: Add power-domains
  dt-bindings: perf: fsl-imx-ddr: Add i.MX 8M compatibles
  dt-bindings: pwm: imx-pwm: Add i.MX 8M compatibles
  dt-bindings: serial: fsl-imx-uart: Add i.MX 8M compatibles
  dt-bindings: watchdog: fsl-imx-wdt: Add i.MX 8M compatibles
  dt-bindings: mtd: gpmi-nand: Add i.MX 8M compatibles
  dt-bindings: reset: fsl,imx7-src: Add i.MX 8M compatibles
  dt-bindings: thermal: imx8mm-thermal: Add i.MX 8M Nano compatible
  dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching
  dt-bindings: nvmem: imx-ocotp: Update i.MX 8M compatibles
  dt-bindings: arm: fsl: Fix Toradex Colibri i.MX 8 binding
  dt-bindings: arm: fsl: Add ZII Ultra boards binding
  dt-bindings: interrupt-controller: fsl,irqsteer: Fix compatible
    matching
  dt-bindings: serial: fsl-lpuart: Fix compatible matching
  arm64: dts: imx8mq-evk: Add hog suffix to wl-reg-on
  arm64: dts: imx8mq-zii-ultra: Add hog suffixes to GPIO hogs

 .../devicetree/bindings/arm/fsl.yaml          | 14 ++++++
 .../bindings/gpio/fsl-imx-gpio.yaml           | 43 ++++++++++++++++---
 .../interrupt-controller/fsl,irqsteer.yaml    |  8 ++--
 .../bindings/mmc/fsl-imx-esdhc.yaml           | 37 ++++++++--------
 .../devicetree/bindings/mtd/gpmi-nand.yaml    | 18 +++++---
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  | 38 +++++++++-------
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml | 16 +++++--
 .../devicetree/bindings/pwm/imx-pwm.yaml      | 14 ++++--
 .../bindings/reset/fsl,imx7-src.yaml          | 19 +++++---
 .../bindings/serial/fsl-imx-uart.yaml         |  4 ++
 .../bindings/serial/fsl-lpuart.yaml           | 17 +++++---
 .../bindings/thermal/imx8mm-thermal.yaml      | 10 +++--
 .../bindings/watchdog/fsl-imx-wdt.yaml        | 11 ++++-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  2 +-
 .../boot/dts/freescale/imx8mq-zii-ultra.dtsi  |  8 ++--
 15 files changed, 182 insertions(+), 77 deletions(-)

-- 
2.17.1

