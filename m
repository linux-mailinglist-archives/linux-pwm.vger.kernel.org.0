Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CCD24C810
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgHTWz6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Aug 2020 18:55:58 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48591 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgHTWz5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Aug 2020 18:55:57 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 24C6B1BF203;
        Thu, 20 Aug 2020 22:55:54 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/4] pwm: atmel-tcb: rework device tree binding
Date:   Fri, 21 Aug 2020 00:55:42 +0200
Message-Id: <20200820225546.2246517-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
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

Alexandre Belloni (4):
  dt-bindings: microchip: atmel,at91rm9200-tcb: add atmel,tcb-pwm
  pwm: atmel-tcb: switch to new binding
  pwm: atmel-tcb: add sama5d2 support
  ARM: dts: at91: kizbox: switch to new pwm-atmel-tcb binding

 .../devicetree/bindings/pwm/atmel-tcb-pwm.txt |  16 --
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   |  31 +-
 arch/arm/boot/dts/at91-kizbox.dts             |  45 ++-
 drivers/pwm/Kconfig                           |   3 +-
 drivers/pwm/pwm-atmel-tcb.c                   | 264 ++++++++++--------
 5 files changed, 217 insertions(+), 142 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt

-- 
2.26.2

