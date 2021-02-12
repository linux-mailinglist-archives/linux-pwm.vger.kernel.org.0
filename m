Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56723319FC4
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Feb 2021 14:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhBLNWF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Feb 2021 08:22:05 -0500
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:49798 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhBLNWC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Feb 2021 08:22:02 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 11CDJTf7024694; Fri, 12 Feb 2021 22:19:29 +0900
X-Iguazu-Qid: 2wGqn5DuWpbZZCpp4t
X-Iguazu-QSIG: v=2; s=0; t=1613135968; q=2wGqn5DuWpbZZCpp4t; m=LEXnUXKL/jGx/Sb83cgREPmRUajxEqhYSQ3U0HUgE+E=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1110) id 11CDJRAi026390;
        Fri, 12 Feb 2021 22:19:27 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 11CDJRxR018972;
        Fri, 12 Feb 2021 22:19:27 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 11CDJQMt001984;
        Fri, 12 Feb 2021 22:19:26 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v2 0/2] pwm: visconti: Add Toshiba Visconti SoC PWM support
Date:   Fri, 12 Feb 2021 22:19:08 +0900
X-TSB-HOP: ON
Message-Id: <20210212131910.557581-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series is the PWM driver for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation and device driver.

[0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html

Updates:

  dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
    v1 -> v2:
      - Change SPDX-License-Identifier to GPL-2.0-only OR BSD-2-Clause.
      - Set compatible toshiba,pwm-visconti only.
      - Drop unnecessary comments.

  pwm: visconti: Add Toshiba Visconti SoC PWM support
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

 .../bindings/pwm/toshiba,pwm-visconti.yaml    |  43 +++++
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-visconti.c                    | 173 ++++++++++++++++++
 4 files changed, 226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
 create mode 100644 drivers/pwm/pwm-visconti.c

-- 
2.30.0.rc2

