Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67E070521
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2019 18:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfGVQNg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Jul 2019 12:13:36 -0400
Received: from vern.gendns.com ([98.142.107.122]:51336 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbfGVQNf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 22 Jul 2019 12:13:35 -0400
X-Greylist: delayed 1635 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jul 2019 12:13:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1innLmemI1YK9z1CEeqUt59/OsFQDgFrRWTZveqQDFo=; b=et8rX0i0bdlwCoihML2rE8CE+n
        WJlLtDVFMTum0shQ6D8BN1OfsfGGA/hRMaI+G0RP5LhKxJppFjFfSHj9OA57O+cbWy71lYBShYBO0
        p0lEpgEGkLFZETJw6lwqJ3Oe5UF9Z9RJHiilz4oN0ZWwBnhHUHLaOgBj+c2M0ASps2h2ymfgNsu8d
        /gyna72Cyg9n5ldNIAg3DIOJZ838RwxBiZQiC3sqBFTHQ+98Gfod4Axeum0HDsUGZV7Q3uWgTba/j
        f38J10it5JtaduHPEn2eqWoX061t+RFBZbCHkgXp2nxLj1yDC4QvFT+aEMYnVwADJtNg0B9P4CBHJ
        HLlDiGzA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44690 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hpaW1-006p1O-CJ; Mon, 22 Jul 2019 11:46:17 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 0/4] new driver for TI eQEP
Date:   Mon, 22 Jul 2019 10:45:34 -0500
Message-Id: <20190722154538.5314-1-david@lechnology.com>
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
Other features can be added on an as-needed basis.

The only other feature I am interested in is adding is getting time data in
order to calculate the rotational speed of a motor. However, there probably
needs to be a higher level discussion of how this can fit into the counter
subsystem in general first.

This series has been tested on a BeagleBone Blue with the following script:

#!/usr/bin/env python3

from os import path
from time import sleep

COUNTER_PATH = '/sys/bus/counter/devices'
COUNTERS = ['counter0', 'counter1', 'counter2']
COUNT0 = 'count0'
COUNT = 'count'
CEILING = 'ceiling'
FLOOR = 'floor'
ENABLE = 'enable'

cnts = []

for c in COUNTERS:
    enable_path = path.join(COUNTER_PATH, c, COUNT0, ENABLE)
    with open(enable_path, 'w') as f:
        f.write('1')
    ceiling_path = path.join(COUNTER_PATH, c, COUNT0, CEILING)
    with open(ceiling_path, 'w') as f:
        f.write(str(0xffffffff))

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

David Lechner (4):
  dt-bindings: counter: new bindings for TI eQEP
  counter: new TI eQEP driver
  ARM: dts: am33xx: Add nodes for eQEP
  ARM: dts: am335x-boneblue: Enable eQEP

 .../devicetree/bindings/counter/ti-eqep.txt   |  18 +
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/am335x-boneblue.dts         |  54 +++
 arch/arm/boot/dts/am33xx-l4.dtsi              |  27 ++
 drivers/counter/Kconfig                       |  12 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/ti-eqep.c                     | 381 ++++++++++++++++++
 drivers/pwm/Kconfig                           |   2 +-
 8 files changed, 500 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.txt
 create mode 100644 drivers/counter/ti-eqep.c

-- 
2.17.1

