Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CBD2A0DB1
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Oct 2020 19:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgJ3SpC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Oct 2020 14:45:02 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:38910 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3SpB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Oct 2020 14:45:01 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 62AFC3B11EE
        for <linux-pwm@vger.kernel.org>; Fri, 30 Oct 2020 18:37:32 +0000 (UTC)
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9CF62240013;
        Fri, 30 Oct 2020 18:37:08 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 0/4] pwm: atmel-tcb: rework device tree binding
Date:   Fri, 30 Oct 2020 19:36:54 +0100
Message-Id: <20201030183658.1007395-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

This was sent as part of a 58 patches series back in 2017. The bindings
were agreed upon back then:

https://lore.kernel.org/linux-arm-kernel/20170607211752.avts3cofvac7ks3q@rob-hp-laptop/

There is still only one user of atmel,tcb-pwm in the tree and I still
think it is worth doing that change now.

The various dependencies are now in v5.9-rc1 so it is ready to be
applied.

I have another series removing atmel_tclib once this is applied.

Changes in v2:
 - rework binding commit message
 - use enum for the pwm node reg values

Alexandre Belloni (4):
  dt-bindings: microchip: atmel,at91rm9200-tcb: add atmel,tcb-pwm
  pwm: atmel-tcb: switch to new binding
  pwm: atmel-tcb: add sama5d2 support
  ARM: dts: at91: kizbox: switch to new pwm-atmel-tcb binding

 .../devicetree/bindings/pwm/atmel-tcb-pwm.txt |  16 --
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   |  34 ++-
 arch/arm/boot/dts/at91-kizbox.dts             |  45 ++-
 drivers/pwm/Kconfig                           |   3 +-
 drivers/pwm/pwm-atmel-tcb.c                   | 264 ++++++++++--------
 5 files changed, 220 insertions(+), 142 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt

-- 
2.26.2

