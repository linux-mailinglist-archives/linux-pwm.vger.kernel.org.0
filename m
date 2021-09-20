Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27458412C7B
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Sep 2021 04:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346276AbhIUCpW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 22:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbhIUCC0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Sep 2021 22:02:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C13C140092;
        Mon, 20 Sep 2021 11:12:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y28so69651217lfb.0;
        Mon, 20 Sep 2021 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hZA8DXDU796DBllGh2WWGpLeIOKX/wCYawIZamWEr4=;
        b=XIcF64dSuhWpXU4P/tMwGmV8lQvhQX9tGRKgC50NUIq4jcjgk6jyzreRcUc4ijlsPc
         8ntT1l+mB11fRHg2u+6lR9sjvKVnZZC+YQzpmSYi+kOkFeLf0LgZc+BVTj6MW+qoVP9P
         v9hPk+NeBy7d+vrDYg4Ok0HgHQN+1dzcA6MUJaqQLxFbKZIJU5EJAd91DOayNweFYUWo
         8PiI+jxAw0XyEkP9GE8ev6QsPig0p+bopUjkwn1nfNlAhZHU3FpT5qupriLpDVcc9Ipp
         gc1mYJHjcwhMGsC/RR+v2I8fNLc+UTyr1K9RqPcihY6wmRXqPejmRVX95Dcdud86ue3a
         MdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hZA8DXDU796DBllGh2WWGpLeIOKX/wCYawIZamWEr4=;
        b=ZVl7/icwrF6ee6bHNWW6ZoDcs6bbZl1I4nNEGUOG2m7MpI0mMF7B9U9ORVI5bsg42Q
         UFhWr3RzsEH82EG4f3J1PvHrIwB/jv3iOjrbZ3UnCzSdygN2Nmy9z3PHStHe3YgPmoDw
         a/PjwWntPkAu04u+j4oNaExUCs8utROHmJz7S4uHRDCQ6kR1EsJGXm9N5nU6uv9RjIPv
         xbd8J/Yq2F8SiNFhZf2hrnIFUIHYG65RVioz2nX59bOmESo6bOUsb+tZ9NpsFyf8LKPL
         CIBdK8DR3DSZBCijKL6G6E4dp9Cwy4133Edcxd8Ta4YvSSmp5U9FHd5PPtGXhb0Fo7f0
         scZw==
X-Gm-Message-State: AOAM532x3QTLlFjSN2zZUsCxZhEKCQG5Lkx4oQHLAOxmnHFOOj06Qpi3
        l98ttwYJx9vhX9rUCEx3RyM=
X-Google-Smtp-Source: ABdhPJzgLb+ntOtsBdjSKpDu5pG0fDgi4PQFxcnVU7wR7TnUYidBadrJPisdv9ra5MQ1i8a0c7ZG6g==
X-Received: by 2002:a05:651c:1b4:: with SMTP id c20mr1178331ljn.484.1632161517564;
        Mon, 20 Sep 2021 11:11:57 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:11:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v12 00/35] NVIDIA Tegra power management patches for 5.16
Date:   Mon, 20 Sep 2021 21:11:10 +0300
Message-Id: <20210920181145.19543-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series adds runtime PM support to Tegra drivers and enables core
voltage scaling for Tegra20/30 SoCs, resolving overheating troubles.

All patches in this series are interdependent and should go via Tegra tree.

Changelog:

v12: - Added r-b from Rob Herring to the host1x binding patch.

     - Added acks from Hans Verkuil to the video decoder patches.

     - In the v11 changelog I forgot to mention that the clk-binding
       patch was also changed with a corrected regex pattern and removed
       'clocks' sub-node. This patch needs r-b or ack too.

     - Added new "Rename 3d power domains" patch to match the DT schema
       naming requirement. Thanks to David Heidelberg for spotting this
       problem.

     - Replaced #ifdef CONFIG_PM_SLEEP with maybe_unused in the MMC patch
       to make code cleaner.

v11: - Added acks and r-b from Rob Herring, Mark Brown and Miquel Raynal
       that were given to v8.

     - Corrected order of the new memory controller reset entry in
       device-trees and host1x DT binding patch, which was requested by
       Rob Herring.

     - Switched consumer drivers to use power domain state syncing done
       by new Tegra's common OPP-initialization helper.

     - Made use of new devm_pm_runtime_enable() helper that was added to
       v5.15 kernel, where appropriate.

     - Added "fuse: Use resource-managed helpers" patch.

     - Converted Tegra20/30 clk drivers to a proper platform drivers,
       which was requested by Thierry Reding.

     - Removed clk-bulk API usage from the MMC patch, which was requested
       by Thierry Reding.

     - Changed CORE power domain name to "core" in a new patch
       "Change name of core power domain".

     - Misc small fixes for problems that I found since v8, like couple
       typos in error code paths and restored working RPM for Tegra DRM
       UAPI v1 that was removed in v8 by accident.

v9-v10: Figured out remaining GENPD API changes with Ulf Hansson and
        Viresh Kumar. The OPP-sync helper that was used in v8 isn't needed
        anymore because GENPD API now allows consumer drivers to
        init rpm_pstate of power domains.

v8: - Added new generic dev_pm_opp_sync() helper that syncs OPP state with
      hardware. All drivers changed to use it. This replaces GENPD attach_dev
      callback hacks that were used in v7.

    - Added new patch patch "soc/tegra: regulators: Prepare for suspend"
      that fixes dying Tegra20 SoC after enabling VENC power domain during
      resume from suspend. It matches to what downstream kernel does on
      suspend/resume.

    - After a second thought, I dropped patches which added RPM to memory
      drivers since hardware is always-on and RPM not needed.

    - Replaced the "dummy host1x driver" patch with new "Disable unused
      host1x hardware" patch, since it's a cleaner solution.

Dmitry Osipenko (35):
  opp: Change type of dev_pm_opp_attach_genpd(names) argument
  soc/tegra: Add devm_tegra_core_dev_init_opp_table_common()
  soc/tegra: pmc: Disable PMC state syncing
  soc/tegra: Don't print error message when OPPs not available
  dt-bindings: clock: tegra-car: Document new clock sub-nodes
  clk: tegra: Support runtime PM and power domain
  dt-bindings: host1x: Document OPP and power domain properties
  dt-bindings: host1x: Document Memory Client resets of Host1x, GR2D and
    GR3D
  gpu: host1x: Add runtime PM and OPP support
  gpu: host1x: Add host1x_channel_stop()
  drm/tegra: dc: Support OPP and SoC core voltage scaling
  drm/tegra: hdmi: Add OPP support
  drm/tegra: gr2d: Support generic power domain and runtime PM
  drm/tegra: gr3d: Support generic power domain and runtime PM
  drm/tegra: vic: Support system suspend
  usb: chipidea: tegra: Add runtime PM and OPP support
  bus: tegra-gmi: Add runtime PM and OPP support
  pwm: tegra: Add runtime PM and OPP support
  mmc: sdhci-tegra: Add runtime PM and OPP support
  mtd: rawnand: tegra: Add runtime PM and OPP support
  spi: tegra20-slink: Add OPP support
  media: dt: bindings: tegra-vde: Convert to schema
  media: dt: bindings: tegra-vde: Document OPP and power domain
  media: staging: tegra-vde: Support generic power domain
  soc/tegra: fuse: Reset hardware
  soc/tegra: fuse: Use resource-managed helpers
  soc/tegra: regulators: Prepare for suspend
  soc/tegra: pmc: Rename 3d power domains
  soc/tegra: pmc: Rename core power domain
  soc/tegra: pmc: Enable core domain support for Tegra20 and Tegra30
  ARM: tegra: Add OPP tables and power domains to Tegra20 device-trees
  ARM: tegra: Add OPP tables and power domains to Tegra30 device-trees
  ARM: tegra: Add Memory Client resets to Tegra20 GR2D, GR3D and Host1x
  ARM: tegra: Add Memory Client resets to Tegra30 GR2D, GR3D and Host1x
  ARM: tegra20/30: Disable unused host1x hardware

 .../bindings/clock/nvidia,tegra20-car.yaml    |   37 +
 .../display/tegra/nvidia,tegra20-host1x.txt   |   53 +
 .../bindings/media/nvidia,tegra-vde.txt       |   64 -
 .../bindings/media/nvidia,tegra-vde.yaml      |  119 ++
 .../boot/dts/tegra20-acer-a500-picasso.dts    |    1 +
 arch/arm/boot/dts/tegra20-colibri.dtsi        |    3 +-
 arch/arm/boot/dts/tegra20-harmony.dts         |    3 +-
 arch/arm/boot/dts/tegra20-paz00.dts           |    1 +
 .../arm/boot/dts/tegra20-peripherals-opp.dtsi |  941 +++++++++++
 arch/arm/boot/dts/tegra20-seaboard.dts        |    3 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi       |    3 +-
 arch/arm/boot/dts/tegra20-trimslice.dts       |    9 +
 arch/arm/boot/dts/tegra20-ventana.dts         |    1 +
 arch/arm/boot/dts/tegra20.dtsi                |  116 +-
 .../tegra30-asus-nexus7-grouper-common.dtsi   |    1 +
 arch/arm/boot/dts/tegra30-beaver.dts          |    1 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi         |    1 +
 arch/arm/boot/dts/tegra30-colibri.dtsi        |   17 +-
 arch/arm/boot/dts/tegra30-ouya.dts            |    1 +
 .../arm/boot/dts/tegra30-peripherals-opp.dtsi | 1412 +++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi                |  175 +-
 drivers/bus/tegra-gmi.c                       |   52 +-
 drivers/clk/tegra/Makefile                    |    1 +
 drivers/clk/tegra/clk-device.c                |  222 +++
 drivers/clk/tegra/clk-pll.c                   |    2 +-
 drivers/clk/tegra/clk-super.c                 |    2 +-
 drivers/clk/tegra/clk-tegra20.c               |   77 +-
 drivers/clk/tegra/clk-tegra30.c               |  116 +-
 drivers/clk/tegra/clk.c                       |   75 +-
 drivers/clk/tegra/clk.h                       |    2 +
 drivers/gpu/drm/tegra/dc.c                    |   74 +
 drivers/gpu/drm/tegra/dc.h                    |    2 +
 drivers/gpu/drm/tegra/gr2d.c                  |  155 +-
 drivers/gpu/drm/tegra/gr3d.c                  |  388 ++++-
 drivers/gpu/drm/tegra/hdmi.c                  |   16 +-
 drivers/gpu/drm/tegra/vic.c                   |    4 +
 drivers/gpu/host1x/channel.c                  |    8 +
 drivers/gpu/host1x/debug.c                    |   15 +
 drivers/gpu/host1x/dev.c                      |  151 +-
 drivers/gpu/host1x/dev.h                      |    3 +-
 drivers/gpu/host1x/hw/channel_hw.c            |   44 +-
 drivers/gpu/host1x/intr.c                     |    3 -
 drivers/gpu/host1x/syncpt.c                   |    5 +-
 drivers/mmc/host/sdhci-tegra.c                |   80 +-
 drivers/mtd/nand/raw/tegra_nand.c             |   55 +-
 drivers/opp/core.c                            |    6 +-
 drivers/pwm/pwm-tegra.c                       |   88 +-
 drivers/soc/tegra/common.c                    |    4 +-
 drivers/soc/tegra/fuse/fuse-tegra.c           |   51 +-
 drivers/soc/tegra/fuse/fuse-tegra20.c         |   33 +-
 drivers/soc/tegra/fuse/fuse.h                 |    1 +
 drivers/soc/tegra/pmc.c                       |   27 +-
 drivers/soc/tegra/regulators-tegra20.c        |   99 ++
 drivers/soc/tegra/regulators-tegra30.c        |  122 ++
 drivers/spi/spi-tegra20-slink.c               |   10 +-
 drivers/staging/media/tegra-vde/vde.c         |   57 +-
 drivers/usb/chipidea/ci_hdrc_tegra.c          |   53 +-
 include/linux/host1x.h                        |    1 +
 include/linux/pm_opp.h                        |    8 +-
 include/soc/tegra/common.h                    |   24 +
 60 files changed, 4741 insertions(+), 357 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
 create mode 100644 Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
 create mode 100644 drivers/clk/tegra/clk-device.c

-- 
2.32.0

