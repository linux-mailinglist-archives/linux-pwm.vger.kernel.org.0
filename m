Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AED8A4C9F
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 00:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfIAW6r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 1 Sep 2019 18:58:47 -0400
Received: from vern.gendns.com ([98.142.107.122]:37370 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfIAW6r (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 1 Sep 2019 18:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q5I8hNXYUTOVr6qJJGD6VgyFndq2TJGOuDuT4GVouDk=; b=mAzKb4qBMqscx40J8SieYVnJ4w
        CDyosjONCebl6PiNzSRwIofpGAlYPNofqndaEpMvvk8lvwe1w7fsvH83Tujs96moLqifpQyJnux87
        wkDWpRnJlKNZKRAlU8KfmigT6KsWTrRXB191TcLia30td2qHcwWP7Kx7ukmkiz0M15VlJFNVc0ULE
        0i33kJnUTMUabzPKXh/lStK2yp9qJZzXMgkqG5NbNR7IRdZ7K76ic7jvivuq8pxkNa2OBX6iHRWrE
        8ExsjK/beLyVM8HARyLDpaSa9bEjk8e82W+tGip6D4fkuhu5c2yyjRBihjeei/PfeAmTvYXu6CACe
        o0IHTW0w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:58390 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1i4Ynz-000351-RK; Sun, 01 Sep 2019 18:58:43 -0400
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
Subject: [PATCH v3 0/6] counter: new TI eQEP driver
Date:   Sun,  1 Sep 2019 17:58:21 -0500
Message-Id: <20190901225827.12301-1-david@lechnology.com>
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

v3 changes:
- Minor changes to device tree bindings (style and generic node name)
- Drop action in initializer
- Fix ordering of pm runtime disable
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

David Lechner (6):
  bus/ti-pwmss: move TI PWMSS driver from PWM to bus subsystem
  dt-bindings: counter: new bindings for TI eQEP
  counter: new TI eQEP driver
  ARM: dts: am33xx: Add nodes for eQEP
  ARM: dts: am335x-boneblue: Enable eQEP
  ARM: dts: am335x-boneblue: Use of am335x-osd335x-common.dtsi

 .../devicetree/bindings/counter/ti-eqep.yaml  |  50 ++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/am335x-boneblue.dts         | 146 +++---
 arch/arm/boot/dts/am33xx-l4.dtsi              |  27 +
 drivers/bus/Kconfig                           |   9 +
 drivers/bus/Makefile                          |   1 +
 drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} |   0
 drivers/counter/Kconfig                       |  11 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/ti-eqep.c                     | 473 ++++++++++++++++++
 drivers/pwm/Kconfig                           |   9 -
 drivers/pwm/Makefile                          |   1 -
 12 files changed, 634 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.yaml
 rename drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} (100%)
 create mode 100644 drivers/counter/ti-eqep.c

-- 
2.17.1

