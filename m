Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0C374F2A
	for <lists+linux-pwm@lfdr.de>; Thu,  6 May 2021 08:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhEFGKk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 May 2021 02:10:40 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:27431 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhEFGKj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 May 2021 02:10:39 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1465vje5003652;
        Thu, 6 May 2021 13:57:45 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 May
 2021 14:09:32 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <p.zabel@pengutronix.de>,
        <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v3 0/2] Support pwm driver for aspeed ast26xx
Date:   Thu, 6 May 2021 14:10:48 +0800
Message-ID: <20210506061050.8001-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1465vje5003652
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The legacy driver of aspeed pwm is binding with tach controller and it
doesn't follow the pwm framworks usage. In addition, the pwm register
usage of the 6th generation of ast26xx has drastic change. So these
patch serials add the new aspeed pwm driver to fix up the problem above.

Changes since v2:
- Remove the tach node, #address-cells and #size-cells from pwm-tach.yaml
- Add clocks and reset properties to pwm-tach.yaml
- Kconfig/Makfile sorted alphabetically
- pwm-aspeed-g6.c suggested by Uwe Kleine-König
  - Add more hardware descriptions at top of the driver.
  - Remove unused api request and free
  - Move the initialize settings of all pwm channel to probe.
  - Change the method of getting the approximate period.
  - Read the hardware register values to fill the state for .get_state()

Changes since v1:
- Fix the dt_binding_check fail suggested by Rob Herring
- Add depends to PWM_ASPEED_G6 configure suggested by Uwe Kleine-Konig
- pwm-aspeed-g6.c suggested by Uwe Kleine-König
  - Fix license header
  - Use bitfiled.h macro to define register fields
  - Implement .remove device function
  - Implement .get_state pwm api


Billy Tsai (2):
  dt-bindings: Add bindings for aspeed pwm-tach and pwm.
  pwm: Add Aspeed ast2600 PWM support

 .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml |  55 +++
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      |  41 ++
 drivers/pwm/Kconfig                           |   8 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-aspeed-g6.c                   | 368 ++++++++++++++++++
 5 files changed, 473 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
 create mode 100644 drivers/pwm/pwm-aspeed-g6.c

-- 
2.25.1

