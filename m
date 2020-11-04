Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C3B2A7324
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbgKDXup (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733029AbgKDXo6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:44:58 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F16BC0613CF;
        Wed,  4 Nov 2020 15:44:57 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id y184so132955lfa.12;
        Wed, 04 Nov 2020 15:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mSwbQjJ1cVy439QSgrXK9AcLY7148KkOFvsAqpIxmwg=;
        b=QtXKfweBRlsbGOAlYxZXOz/lYCy8unSAvDGjjvWSh/sezRhvIb291EkMy/Az42Eo7e
         TAfz8YALCyTQ46RYjcz1KHr1bxx3QIW42M38LghlqXeAJIOhgwnXDJ2w5PFdGxUrDaJa
         CgbvRUnmn+hP+Q9Jgoz/cIcjn3sh+vTzr920aJr959sxIfklRYfD0wQYr1mK7xUjvoYi
         X2ev0EAqFLOjT7G0Gaih9PQ6buZ2mt73AMYcrCt1Dn2Wa1sOYP2Wywby9BlcF6QCpkRM
         Ts50hSUFzQvXaYS6FgwlN+Yz+9QeF79aJ602AxxMXZAJiSKQWJJzQ4tzPEnhrIo8A+OP
         CRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mSwbQjJ1cVy439QSgrXK9AcLY7148KkOFvsAqpIxmwg=;
        b=CHfmP0EBUT82N4MB+0o69Qlqbx8NL1aILsx3GkrJy7iQbCsEosJv9mx7ydBOPYIQpB
         EQsJrXzANjE6AnkbLT+V1esVVC9CzARvTGylZWjup6fwYiySwfX/cyH/nVRJZduWiPd3
         cubZfxp8//zXhcuOsZYcwhW46nyS+OXy3o+VsCUyS4r3x85ChORNkU+7OcsbYS0Vo3QP
         +DdOAX4BMm3ZOBy6g4iXZ4M7no2deXiJMKXeZqwLk+KncOYmhXtwrXXqjsMywBlNXGjr
         SCqB9qMKXq27qJ7ePul5o2TN1NhB+lTrjU2UZ4wt8us8NCKCxMeS/7PG5JFYn7ec+CYC
         GhVA==
X-Gm-Message-State: AOAM5338YjWVZgPbgkJnag5JvK6trQIK3AOuqSvQGGxXar+mSRXaBdvc
        jI4ifJJ0BUHOWL5xESbGbfw=
X-Google-Smtp-Source: ABdhPJyAnR4d+zZoZfcUMnF37/CdTyI5a7cshqFtJeUxmjjzKi7K0NU+QmIwz6qwfyOY2SPBqOSB8Q==
X-Received: by 2002:a19:c8c1:: with SMTP id y184mr46637lff.598.1604533495960;
        Wed, 04 Nov 2020 15:44:55 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:44:55 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA Tegra20/30 SoCs
Date:   Thu,  5 Nov 2020 02:43:57 +0300
Message-Id: <20201104234427.26477-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Introduce core voltage scaling for NVIDIA Tegra20/30 SoCs, which reduces
power consumption and heating of the Tegra chips. Tegra SoC has multiple
hardware units which belong to a core power domain of the SoC and share
the core voltage. The voltage must be selected in accordance to a minimum
requirement of every core hardware unit.

The minimum core voltage requirement depends on:

  1. Clock enable state of a hardware unit.
  2. Clock frequency.
  3. Unit's internal idling/active state.

This series is tested on Acer A500 (T20), AC100 (T20), Nexus 7 (T30) and
Ouya (T30) devices. I also added voltage scaling to the Ventana (T20) and
Cardhu (T30) boards which are tested by NVIDIA's CI farm. Tegra30 is now up
to 5C cooler on Nexus 7 and stays cool on Ouya (instead of becoming burning
hot) while system is idling. It should be possible to improve this further
by implementing a more advanced power management features for the kernel
drivers.

The DVFS support is opt-in for all boards, meaning that older DTBs will
continue to work like they did it before this series. It should be possible
to easily add the core voltage scaling support for Tegra114+ SoCs based on
this grounding work later on, if anyone will want to implement it.

WARNING(!) This series is made on top of the memory interconnect patches
           which are currently under review [1]. The Tegra EMC driver
           and devicetree-related patches need to be applied on top of
           the ICC series.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=212196

Dmitry Osipenko (30):
  dt-bindings: host1x: Document OPP and voltage regulator properties
  dt-bindings: mmc: tegra: Document OPP and voltage regulator properties
  dt-bindings: pwm: tegra: Document OPP and voltage regulator properties
  media: dt: bindings: tegra-vde: Document OPP and voltage regulator
    properties
  dt-binding: usb: ci-hdrc-usb2:  Document OPP and voltage regulator
    properties
  dt-bindings: usb: tegra-ehci: Document OPP and voltage regulator
    properties
  soc/tegra: Add sync state API
  soc/tegra: regulators: Support Tegra SoC device sync state API
  soc/tegra: regulators: Fix lockup when voltage-spread is out of range
  regulator: Allow skipping disabled regulators in
    regulator_check_consumers()
  drm/tegra: dc: Support OPP and SoC core voltage scaling
  drm/tegra: gr2d: Correct swapped device-tree compatibles
  drm/tegra: gr2d: Support OPP and SoC core voltage scaling
  drm/tegra: gr3d: Support OPP and SoC core voltage scaling
  drm/tegra: hdmi: Support OPP and SoC core voltage scaling
  gpu: host1x: Support OPP and SoC core voltage scaling
  mmc: sdhci-tegra: Support OPP and core voltage scaling
  pwm: tegra: Support OPP and core voltage scaling
  media: staging: tegra-vde: Support OPP and SoC core voltage scaling
  usb: chipidea: tegra: Support OPP and SoC core voltage scaling
  usb: host: ehci-tegra: Support OPP and SoC core voltage scaling
  memory: tegra20-emc: Support Tegra SoC device state syncing
  memory: tegra30-emc: Support Tegra SoC device state syncing
  ARM: tegra: Add OPP tables for Tegra20 peripheral devices
  ARM: tegra: Add OPP tables for Tegra30 peripheral devices
  ARM: tegra: ventana: Add voltage supplies to DVFS-capable devices
  ARM: tegra: paz00: Add voltage supplies to DVFS-capable devices
  ARM: tegra: acer-a500: Add voltage supplies to DVFS-capable devices
  ARM: tegra: cardhu-a04: Add voltage supplies to DVFS-capable devices
  ARM: tegra: nexus7: Add voltage supplies to DVFS-capable devices

 .../display/tegra/nvidia,tegra20-host1x.txt   |  56 +++
 .../bindings/media/nvidia,tegra-vde.txt       |  12 +
 .../bindings/mmc/nvidia,tegra20-sdhci.txt     |  12 +
 .../bindings/pwm/nvidia,tegra20-pwm.txt       |  13 +
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  |   4 +
 .../bindings/usb/nvidia,tegra20-ehci.txt      |   2 +
 .../boot/dts/tegra20-acer-a500-picasso.dts    |  30 +-
 arch/arm/boot/dts/tegra20-paz00.dts           |  40 +-
 .../arm/boot/dts/tegra20-peripherals-opp.dtsi | 386 ++++++++++++++++
 arch/arm/boot/dts/tegra20-ventana.dts         |  65 ++-
 arch/arm/boot/dts/tegra20.dtsi                |  14 +
 .../tegra30-asus-nexus7-grouper-common.dtsi   |  23 +
 arch/arm/boot/dts/tegra30-cardhu-a04.dts      |  44 ++
 .../arm/boot/dts/tegra30-peripherals-opp.dtsi | 415 ++++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi                |  13 +
 drivers/gpu/drm/tegra/Kconfig                 |   1 +
 drivers/gpu/drm/tegra/dc.c                    | 138 +++++-
 drivers/gpu/drm/tegra/dc.h                    |   5 +
 drivers/gpu/drm/tegra/gr2d.c                  | 140 +++++-
 drivers/gpu/drm/tegra/gr3d.c                  | 136 ++++++
 drivers/gpu/drm/tegra/hdmi.c                  |  63 ++-
 drivers/gpu/host1x/Kconfig                    |   1 +
 drivers/gpu/host1x/dev.c                      |  87 ++++
 drivers/memory/tegra/tegra20-emc.c            |   8 +-
 drivers/memory/tegra/tegra30-emc.c            |   8 +-
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/sdhci-tegra.c                |  70 ++-
 drivers/pwm/Kconfig                           |   1 +
 drivers/pwm/pwm-tegra.c                       |  84 +++-
 drivers/regulator/core.c                      |  12 +-
 .../soc/samsung/exynos-regulator-coupler.c    |   2 +-
 drivers/soc/tegra/common.c                    | 152 ++++++-
 drivers/soc/tegra/regulators-tegra20.c        |  25 +-
 drivers/soc/tegra/regulators-tegra30.c        |  30 +-
 drivers/staging/media/tegra-vde/Kconfig       |   1 +
 drivers/staging/media/tegra-vde/vde.c         | 127 ++++++
 drivers/staging/media/tegra-vde/vde.h         |   1 +
 drivers/usb/chipidea/Kconfig                  |   1 +
 drivers/usb/chipidea/ci_hdrc_tegra.c          |  79 ++++
 drivers/usb/host/Kconfig                      |   1 +
 drivers/usb/host/ehci-tegra.c                 |  79 ++++
 include/linux/regulator/coupler.h             |   6 +-
 include/soc/tegra/common.h                    |  22 +
 43 files changed, 2360 insertions(+), 50 deletions(-)

-- 
2.27.0

