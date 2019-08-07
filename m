Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC49853B9
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2019 21:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbfHGTlD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Aug 2019 15:41:03 -0400
Received: from vern.gendns.com ([98.142.107.122]:43638 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389462AbfHGTlC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Aug 2019 15:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JokjWWho/2zfAnvvaFBEyWXOCT3O2zg4J7WISh2hl5A=; b=Eos7XohVKEfGrdxSBI9kjkfm/2
        WmdwutJ4Yt9HAuWwSgA3QbXfiLcnfXu4i2QvMLKqYbdbY8MMtR/aBfEjRl5gQqbtMhaQFmoKOrssJ
        W51GaEZf890b3xuk4CFAzLdDiFbHBhmqbdSiA/rVQgetWbfYxNsWDePdYRhuNPEWzLUHCJSObQGwJ
        3llycmnl3LZ/g6oPU4ThzdGv6cYiRpR3WgEcXTC98AIejQ+y5a7HWNpGoqBkzXdGtrrluh6zasKuq
        iIVtWiTsMwc/baJ8x33Kup63axtfkezowE+xunOo0JyhO0ViMwjbouR35vmDGakQEJpNmDHIu6Yed
        bmLb7P9w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60292 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hvRnv-00006r-Mm; Wed, 07 Aug 2019 15:40:59 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2 0/5] counter: new TI eQEP driver
Date:   Wed,  7 Aug 2019 14:40:18 -0500
Message-Id: <20190807194023.15318-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series adds device tree bindings and a new counter driver for the Texas
Instruments Enhanced Quadrature Encoder Pulse (eQEP).

As mentioned in one of the commit messages, to start with, the driver only
supports reading the current counter value and setting the min/max values.
Other features can be added as the counter subsystem gains support for them.

v2 changes:
- New patch to move TI PWMSS driver from drivers/pwm/ to drivers/bus/
- Device tree bindings converted to .yaml format
- Device tree clock renamed from "fck" to "sysclkout"
- Dropped unused index and strobe signals from counter driver
- Added synapses and actions to counter driver
- Fixed base in of kstrtouint()
- Clarifications in commit messages

This series has been tested on a BeagleBone Blue with the following script:

#!/usr/bin/env python3

from os import path
from time import sleep

COUNTER_PATH = '/sys/bus/counter/devices'
COUNTERS = ['counter0', 'counter1', 'counter2']
COUNT0 = 'count0'
COUNT = 'count'
FUNCTION = 'function'
CEILING = 'ceiling'
FLOOR = 'floor'
ENABLE = 'enable'

cnts = []

for c in COUNTERS:
    function_path = path.join(COUNTER_PATH, c, COUNT0, FUNCTION)
    with open(function_path, 'w') as f:
        f.write('quadrature x4')
    floor_path = path.join(COUNTER_PATH, c, COUNT0, FLOOR)
    with open(floor_path, 'w') as f:
        f.write(str(0))
    ceiling_path = path.join(COUNTER_PATH, c, COUNT0, CEILING)
    with open(ceiling_path, 'w') as f:
        f.write(str(0xffffffff))
    enable_path = path.join(COUNTER_PATH, c, COUNT0, ENABLE)
    with open(enable_path, 'w') as f:
        f.write('1')

    cnt_path = path.join(COUNTER_PATH, c, COUNT0, COUNT)
    cnts.append(open(cnt_path, 'r'))

while True:
    for c in cnts:
        c.seek(0)
        val = int(c.read())
        if val >= 0x80000000:
            val -= 0x100000000
        print(val, end=' ')
    print()
    sleep(1)

David Lechner (5):
  bus/ti-pwmss: move TI PWMSS driver from PWM to bus subsystem
  dt-bindings: counter: new bindings for TI eQEP
  counter: new TI eQEP driver
  ARM: dts: am33xx: Add nodes for eQEP
  ARM: dts: am335x-boneblue: Enable eQEP

 .../devicetree/bindings/counter/ti-eqep.yaml  |  50 ++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/am335x-boneblue.dts         |  54 ++
 arch/arm/boot/dts/am33xx-l4.dtsi              |  27 +
 drivers/bus/Kconfig                           |   9 +
 drivers/bus/Makefile                          |   1 +
 drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} |   0
 drivers/counter/Kconfig                       |  12 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/ti-eqep.c                     | 460 ++++++++++++++++++
 drivers/pwm/Kconfig                           |   9 -
 drivers/pwm/Makefile                          |   1 -
 12 files changed, 620 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.yaml
 rename drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} (100%)
 create mode 100644 drivers/counter/ti-eqep.c

-- 
2.17.1

