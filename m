Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A161335A910
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Apr 2021 01:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhDIXJ0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 19:09:26 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:43166 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhDIXJY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 19:09:24 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 139N8mWI008616; Sat, 10 Apr 2021 08:08:48 +0900
X-Iguazu-Qid: 2wHHUTCVsZgY3Qsr0S
X-Iguazu-QSIG: v=2; s=0; t=1618009728; q=2wHHUTCVsZgY3Qsr0S; m=iSRXoOVmIJhZkFGAE2HAlPNpneGlFMc/4l9UvBXOFRA=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1111) id 139N8lOq006567
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 10 Apr 2021 08:08:47 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 1C8B11000D7;
        Sat, 10 Apr 2021 08:08:47 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 139N8kHq019966;
        Sat, 10 Apr 2021 08:08:46 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v4 0/2] pwm: visconti: Add Toshiba Visconti SoC PWM support
Date:   Sat, 10 Apr 2021 08:08:35 +0900
X-TSB-HOP: ON
Message-Id: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

This series is the PWM driver for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation and device driver.

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

Updates:

  dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
    v3 -> v4:
      - No update.
    v2 -> v3:
      - Change compatible to toshiba,visconti-pwm
      - Change filename to toshiba,visconti-pwm.yaml.
      - Add Reviewed-by tag from Rob.
    v1 -> v2:
      - Change SPDX-License-Identifier to GPL-2.0-only OR BSD-2-Clause.
      - Set compatible toshiba,pwm-visconti only.
      - Drop unnecessary comments.

  pwm: visconti: Add Toshiba Visconti SoC PWM support
    v3 -> v4:
      - Sorted alphabetically include files.
      - Changed container_of to using static inline functions.
      - Dropped unnecessary dev_dbg().
      - Drop Initialization of chip.base.
      - Drop commnet "period too small".
      - Rebased for-next. 
    v2 -> v3:
      - Change compatible to toshiba,visconti-pwm.
      - Fix MODULE_ALIAS to platform:pwm-visconti, again.
      - Align continuation line to the opening parenthesis.
      - Rewrite the contents of visconti_pwm_apply() based on the contents suggested by Uwe.
    v1 -> v2:
      - Change SPDX-License-Identifier to GPL-2.0-only.
      - Add prefix for the register defines.
      - Drop struct device from struct visconti_pwm_chip.
      - Use '>>' instead of '/'.
      - Drop error message by devm_platform_ioremap_resource().
      - Use dev_err_probe instead of dev_err.
      - Change dev_info to dev_dbg.
      - Remove some empty lines.
      - Fix MODULE_ALIAS to platform:pwm-visconti.
      - Add .get_state() function.
      - Use the author name and email address to MODULE_AUTHOR.
      - Add more comment to function of the hardware.
      - Support .get_status() function.
      - Use NSEC_PER_USEC instead of 1000.
      - Alphabetically sorted for Makefile and Kconfig.
      - Added check for set value in visconti_pwm_apply().

Nobuhiro Iwamatsu (2):
  dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
  pwm: visconti: Add Toshiba Visconti SoC PWM support

 .../bindings/pwm/toshiba,pwm-visconti.yaml    |  43 ++++
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-visconti.c                    | 188 ++++++++++++++++++
 4 files changed, 241 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
 create mode 100644 drivers/pwm/pwm-visconti.c

-- 
2.30.0.rc2

