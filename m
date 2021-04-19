Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C819C3638B1
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Apr 2021 02:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhDSABv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 18 Apr 2021 20:01:51 -0400
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:38768 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbhDSABl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Apr 2021 20:01:41 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 13J00pQR021687; Mon, 19 Apr 2021 09:00:51 +0900
X-Iguazu-Qid: 2wHHQAoCK5XYSo4bGK
X-Iguazu-QSIG: v=2; s=0; t=1618790451; q=2wHHQAoCK5XYSo4bGK; m=og7IFJUKyb7215psUxeUTVV/b9UvbMqd3VDJn/siVEY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1113) id 13J00ox4029022
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Apr 2021 09:00:50 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 4A92E100096;
        Mon, 19 Apr 2021 09:00:50 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 13J00n4R025236;
        Mon, 19 Apr 2021 09:00:49 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v6 0/2] pwm: visconti: Add Toshiba Visconti SoC PWM support
Date:   Mon, 19 Apr 2021 09:00:05 +0900
X-TSB-HOP: ON
Message-Id: <20210419000007.1944301-1-nobuhiro1.iwamatsu@toshiba.co.jp>
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
    v5 -> v6:
      - No update.
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
    v5 -> v6:
     - Update year in copyright.
     - Update limitations.
     - Fix coding style, used braces for both branches.
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
 drivers/pwm/pwm-visconti.c                    | 189 ++++++++++++++++++
 4 files changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
 create mode 100644 drivers/pwm/pwm-visconti.c

-- 
2.30.0.rc2

