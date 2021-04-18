Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609323634BE
	for <lists+linux-pwm@lfdr.de>; Sun, 18 Apr 2021 13:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhDRLKE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 18 Apr 2021 07:10:04 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:59596 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhDRLKE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Apr 2021 07:10:04 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 13IB9CRB009817; Sun, 18 Apr 2021 20:09:12 +0900
X-Iguazu-Qid: 2wHHmufQVDPW4c3ZsO
X-Iguazu-QSIG: v=2; s=0; t=1618744151; q=2wHHmufQVDPW4c3ZsO; m=bFx2UGZ7wxb+8hlnJCcU1PCnVR+fX5Hc18qtcCc6NEo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1112) id 13IB9AE2004930
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 18 Apr 2021 20:09:11 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id AC2121000B4;
        Sun, 18 Apr 2021 20:09:10 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 13IB9AQd008046;
        Sun, 18 Apr 2021 20:09:10 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v5 0/2] pwm: visconti: Add Toshiba Visconti SoC PWM support
Date:   Sun, 18 Apr 2021 20:09:02 +0900
X-TSB-HOP: ON
Message-Id: <20210418110904.1942806-1-nobuhiro1.iwamatsu@toshiba.co.jp>
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
    v4 -> v5:
      - No update.
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
    v4 -> v5:
      - Droped checking PIPGM_PCSR from visconti_pwm_get_state.
      - Changed from to_visconti_chip to visconti_pwm_from_chip.
      - Removed pwmchip_remove return value management.
      - Add limitations of this device.
      - Add 'state->enabled = true' to visconti_pwm_get_state().
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
