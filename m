Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE119DE2EF
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 06:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfJUETK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 00:19:10 -0400
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:37476
        "EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfJUETK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 00:19:10 -0400
Received: from localhost.localdomain ([136.49.227.119])
        by :SMTPAUTH: with ESMTPSA
        id MP2oifB4Hr3FgMP2siDyXQ; Sun, 20 Oct 2019 21:11:51 -0700
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 0/8] Add support for Azoteq IQS620A/621/622/624/625
Date:   Sun, 20 Oct 2019 23:11:15 -0500
Message-Id: <1571631083-4962-1-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
X-CMAE-Envelope: MS4wfAu90c0pDaDRunGGnMqsYx9et4CGzqq2jfj1O0Glyz7u6Q0RvSVk+oYHIAxqJNdp4Y9teI7NzfcnwI8pFt7q+rnOBcEi+pmpwFFrUuEvf9wgjirl7FWE
 E0EVRpNXQ1fkuNe6xOPbECyqH0UpkcvQHifiqMs3cygGs7tEjP43S4AlvQdCwfQJbsHec+CJ/cjuWxHcDe3lcDZAjqkG5lLtgP8R94HVqxFnL0sUnbu9IP7w
 4MDeyXJhQ1Kw/OeoW7JumgaXVT61sQ/psa/gQ/ZQ8mI38FUaOVAGamm8DVV80v/tYhC0Hgdv2Xaxw/Y1btvQHOHY+MoQ1xgxOhiOFzc7+U7d3xshPa2m1Rbk
 h9I1+vgl2x9aVVf/hXIyIl/bwwT1kSVXOGxBKTE64il6wGrEsKF4OQnAGdtFPyI7wAGX8YeNdAsZjLy2VYekyuiFPO50a4C/Ts0yz/KG0ymnsrg8sWd/rXg9
 hD1B2/irAuPbyy/nekBSufFnB7HIaj5vPl+blZ57Hll6HmITIYPnIolXEsAa/rWvfYuY5F2XVmLsT7TW7NlWkzrh7LhEMlJX5qlVqDq6O2rwRKszIFjGxEuW
 pDqE7BurjKwLXa3SVAbPo63vGYU1sbdFtfilIz1YYEXuL31Pza1PEgNBjZQoMr+O9dC12fGr0bAjcRUgcwZ31r4z0mwMuGZ3QFG4wyGDxBlO5SfigUitaDJd
 HznpiQzcjTw7bKLeHURPRqFMXiDG7FXhwmzUsmFzpq3HAQrv4pMGeA==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series adds support for six-channel members of the Azoteq ProxFusion
family of sensor devices: IQS620A, IQS621, IQS622, IQS624 and IQS625. Each
device integrates multiple sensor technologies in a single package.

A multi-function device (MFD) driver supports core functions common to all
devices, including device identification, firmware, interrupt handling and
runtime power management. The MFD driver is also responsible for adding all
product-specific sub-devices.

Each device supports self-capacitive, Hall-effect, and (in some cases) mutual-
inductive sensing. These functions represent keys or switches and are supported
by an input driver that covers all five devices. An assortment of pwm, hwmon
and iio drivers support device-specific functions.

This series was tested using the following development hardware: IQS620AEV04,
IQS621EV04, IQS622EV04 and IQS624/5EV04.

Jeff LaBundy (8):
  dt-bindings: mfd: iqs62x: Add bindings
  mfd: Add support for Azoteq IQS620A/621/622/624/625
  input: keyboard: Add support for Azoteq IQS620A/621/622/624/625
  hwmon: Add support for Azoteq IQS620AT temperature sensor
  pwm: Add support for Azoteq IQS620A PWM generator
  iio: light: Add support for Azoteq IQS621 ambient light sensor
  iio: proximity: Add support for Azoteq IQS622 proximity sensor
  iio: position: Add support for Azoteq IQS624/625 angle sensor

 Documentation/devicetree/bindings/mfd/iqs62x.txt | 242 +++++++++
 drivers/hwmon/Kconfig                            |  12 +-
 drivers/hwmon/Makefile                           |   1 +
 drivers/hwmon/iqs620at-temp.c                    |  96 ++++
 drivers/iio/Kconfig                              |   1 +
 drivers/iio/Makefile                             |   1 +
 drivers/iio/light/Kconfig                        |  10 +
 drivers/iio/light/Makefile                       |   1 +
 drivers/iio/light/iqs621-als.c                   | 361 +++++++++++++
 drivers/iio/position/Kconfig                     |  19 +
 drivers/iio/position/Makefile                    |   7 +
 drivers/iio/position/iqs624-pos.c                | 302 +++++++++++
 drivers/iio/proximity/Kconfig                    |  10 +
 drivers/iio/proximity/Makefile                   |   1 +
 drivers/iio/proximity/iqs622-prox.c              | 334 ++++++++++++
 drivers/input/keyboard/Kconfig                   |  10 +
 drivers/input/keyboard/Makefile                  |   1 +
 drivers/input/keyboard/iqs62x-keys.c             | 340 ++++++++++++
 drivers/mfd/Kconfig                              |  13 +
 drivers/mfd/Makefile                             |   2 +
 drivers/mfd/iqs62x-core.c                        | 638 +++++++++++++++++++++++
 drivers/mfd/iqs62x-tables.c                      | 424 +++++++++++++++
 drivers/pwm/Kconfig                              |  10 +
 drivers/pwm/Makefile                             |   1 +
 drivers/pwm/pwm-iqs620a.c                        | 167 ++++++
 include/linux/mfd/iqs62x.h                       | 148 ++++++
 26 files changed, 3151 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.txt
 create mode 100644 drivers/hwmon/iqs620at-temp.c
 create mode 100644 drivers/iio/light/iqs621-als.c
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/iqs624-pos.c
 create mode 100644 drivers/iio/proximity/iqs622-prox.c
 create mode 100644 drivers/input/keyboard/iqs62x-keys.c
 create mode 100644 drivers/mfd/iqs62x-core.c
 create mode 100644 drivers/mfd/iqs62x-tables.c
 create mode 100644 drivers/pwm/pwm-iqs620a.c
 create mode 100644 include/linux/mfd/iqs62x.h

--
2.7.4

