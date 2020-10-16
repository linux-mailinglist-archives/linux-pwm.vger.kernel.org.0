Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A12290826
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 17:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409941AbgJPPQN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 11:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409936AbgJPPQN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Oct 2020 11:16:13 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C31FD20897;
        Fri, 16 Oct 2020 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602861371;
        bh=c+YsK2J8DdpiJEfsMYPt+lGBjI0F4b9EJK07DSg8ZNE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=2QLAX0eSdbAfraisiiiArZqpQyYJJwKwXBW/cPW7iWXcbTkOF9OVxKG7uEGOJYHL9
         /hMy9HCcQwFLkrXrlRMFAqv2RVs1r1aB7fMMbu/kvN5cv0L9RK5diDP4Km4Lk/7Knp
         cfxONxw92DbR/6CfwvXpdkkio2HZOVPtrzJcqeaU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 4/4] CREDITS: remove trailing white spaces
Date:   Fri, 16 Oct 2020 17:15:28 +0200
Message-Id: <20201016151528.7553-4-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016151528.7553-1-krzk@kernel.org>
References: <20201016151528.7553-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Remove trailing white spaces.  No functional/substantive change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 CREDITS | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/CREDITS b/CREDITS
index f5c924a09b74..748301954ab7 100644
--- a/CREDITS
+++ b/CREDITS
@@ -98,7 +98,7 @@ N: Erik Andersen
 E: andersen@codepoet.org
 W: https://www.codepoet.org/
 P: 1024D/30D39057 1BC4 2742 E885 E4DE 9301  0C82 5F9B 643E 30D3 9057
-D: Maintainer of ide-cd and Uniform CD-ROM driver, 
+D: Maintainer of ide-cd and Uniform CD-ROM driver,
 D: ATAPI CD-Changer support, Major 2.1.x CD-ROM update.
 S: 352 North 525 East
 S: Springville, Utah 84663
@@ -263,7 +263,7 @@ N: Paul Barton-Davis
 E: pbd@op.net
 D: Driver for WaveFront soundcards (Turtle Beach Maui, Tropez, Tropez+)
 D: Various bugfixes and changes to sound drivers
-S: USA 
+S: USA
 
 N: Carlos Henrique Bauer
 E: chbauer@acm.org
@@ -1205,7 +1205,7 @@ N: Daniel J. Frasnelli
 E: dfrasnel@alphalinux.org
 W: http://www.alphalinux.org/
 P: 1024/3EF87611 B9 F1 44 50 D3 E8 C2 80  DA E5 55 AA 56 7C 42 DA
-D: DEC Alpha hacker 
+D: DEC Alpha hacker
 D: Miscellaneous bug squisher
 
 N: Jim Freeman
@@ -1305,7 +1305,7 @@ S: P.O. Box 76, Epping
 S: New South Wales, 2121
 S: Australia
 
-N: Carlos E. Gorges 
+N: Carlos E. Gorges
 E: carlos@techlinux.com.br
 D: fix smp support on cmpci driver
 P: 2048G/EA3C4B19 FF31 33A6 0362 4915 B7EB  E541 17D0 0379 EA3C 4B19
@@ -1346,7 +1346,7 @@ E: wgreathouse@smva.com
 E: wgreathouse@myfavoritei.com
 D: Current Belkin USB Serial Adapter F5U103 hacker
 D: Kernel hacker, embedded systems
-S: 7802 Fitzwater Road   
+S: 7802 Fitzwater Road
 S: Brecksville, OH  44141-1334
 S: USA
 
@@ -1387,7 +1387,7 @@ N: Grant Guenther
 E: grant@torque.net
 W: http://www.torque.net/linux-pp.html
 D: original author of ppa driver for parallel port ZIP drive
-D: original architect of the parallel-port sharing scheme 
+D: original architect of the parallel-port sharing scheme
 D: PARIDE subsystem: drivers for parallel port IDE & ATAPI devices
 S: 44 St. Joseph Street, Suite 506
 S: Toronto, Ontario, M4Y 2W4
@@ -1529,7 +1529,7 @@ N: Benjamin Herrenschmidt
 E: benh@kernel.crashing.org
 D: Various parts of PPC/PPC64 & PowerMac
 S: 312/107 Canberra Avenue
-S: Griffith, ACT 2603 
+S: Griffith, ACT 2603
 S: Australia
 
 N: Andreas Herrmann
@@ -1831,7 +1831,7 @@ S: Hungary
 N: Bernhard Kaindl
 E: bkaindl@netway.at
 E: edv@bartelt.via.at
-D: Author of a menu based configuration tool, kmenu, which 
+D: Author of a menu based configuration tool, kmenu, which
 D: is the predecessor of 'make menuconfig' and 'make xconfig'.
 D: digiboard driver update(modularisation work and 2.1.x upd)
 S: Tallak 95
@@ -2022,7 +2022,7 @@ W: http://www.xos.nl/
 D: IP transparent proxy support
 S: X/OS Experts in Open Systems BV
 S: Kruislaan 419
-S: 1098 VA Amsterdam 
+S: 1098 VA Amsterdam
 S: The Netherlands
 
 N: Goran Koruga
@@ -2094,7 +2094,7 @@ S: Germany
 
 N: Andrzej M. Krzysztofowicz
 E: ankry@mif.pg.gda.pl
-D: Some 8-bit XT disk driver and devfs hacking 
+D: Some 8-bit XT disk driver and devfs hacking
 D: Aladdin 1533/1543(C) chipset IDE
 D: PIIX chipset IDE
 S: ul. Matemblewska 1B/10
@@ -2469,7 +2469,7 @@ E: mge@EZ-Darmstadt.Telekom.de
 D: Logical Volume Manager
 S: Bartningstr. 12
 S: 64289 Darmstadt
-S: Germany 
+S: Germany
 
 N: Mark W. McClelland
 E: mmcclell@bigfoot.com
@@ -2553,7 +2553,7 @@ E: meskes@debian.org
 P: 1024/04B6E8F5 6C 77 33 CA CC D6 22 03  AB AB 15 A3 AE AD 39 7D
 D: Kernel hacker. PostgreSQL hacker. Software watchdog daemon.
 D: Maintainer of several Debian packages
-S: Th.-Heuss-Str. 61 
+S: Th.-Heuss-Str. 61
 S: D-41812 Erkelenz
 S: Germany
 
@@ -2791,7 +2791,7 @@ E: neuffer@goofy.zdv.uni-mainz.de
 W: http://www.i-Connect.Net/~mike/
 D: Developer and maintainer of the EATA-DMA SCSI driver
 D: Co-developer EATA-PIO SCSI driver
-D: /proc/scsi and assorted other snippets 
+D: /proc/scsi and assorted other snippets
 S: Zum Schiersteiner Grund 2
 S: 55127 Mainz
 S: Germany
@@ -3029,7 +3029,7 @@ D: Embedded PowerPC 4xx/6xx/7xx/74xx support
 S: Chandler, Arizona 85249
 S: USA
 
-N: Frederic Potter 
+N: Frederic Potter
 E: fpotter@cirpack.com
 D: Some PCI kernel support
 
@@ -3462,21 +3462,21 @@ S: Klosterweg 28 / i309
 S: 76131 Karlsruhe
 S: Germany
 
-N: James Simmons 
+N: James Simmons
 E: jsimmons@infradead.org
-E: jsimmons@users.sf.net 
+E: jsimmons@users.sf.net
 D: Frame buffer device maintainer
 D: input layer development
 D: tty/console layer
-D: various mipsel devices 
-S: 115 Carmel Avenue 
+D: various mipsel devices
+S: 115 Carmel Avenue
 S: El Cerrito CA 94530
-S: USA 
+S: USA
 
 N: Jaspreet Singh
 E: jaspreet@sangoma.com
 W: www.sangoma.com
-D: WANPIPE drivers & API Support for Sangoma S508/FT1 cards 
+D: WANPIPE drivers & API Support for Sangoma S508/FT1 cards
 S: Sangoma Technologies Inc.,
 S: 1001 Denison Street
 S: Suite 101
@@ -3500,7 +3500,7 @@ N: Craig Small
 E: csmall@triode.apana.org.au
 E: vk2xlz@gonzo.vk2xlz.ampr.org (packet radio)
 D: Gracilis PackeTwin device driver
-D: RSPF daemon 
+D: RSPF daemon
 S: 10 Stockalls Place
 S: Minto, NSW, 2566
 S: Australia
@@ -3710,7 +3710,7 @@ N: Tsu-Sheng Tsao
 E: tsusheng@scf.usc.edu
 D: IGMP(Internet Group Management Protocol) version 2
 S: 2F 14 ALY 31 LN 166 SEC 1 SHIH-PEI RD
-S: Taipei 
+S: Taipei
 S: Taiwan 112
 S: Republic of China
 S: 24335 Delta Drive
@@ -3871,7 +3871,7 @@ D: Produced the Slackware distribution, updated the SVGAlib
 D: patches for ghostscript, worked on color 'ls', etc.
 S: 301 15th Street S.
 S: Moorhead, Minnesota 56560
-S: USA 
+S: USA
 
 N: Jos Vos
 E: jos@xos.nl
@@ -3879,7 +3879,7 @@ W: http://www.xos.nl/
 D: Various IP firewall updates, ipfwadm
 S: X/OS Experts in Open Systems BV
 S: Kruislaan 419
-S: 1098 VA Amsterdam 
+S: 1098 VA Amsterdam
 S: The Netherlands
 
 N: Jeroen Vreeken
@@ -4117,7 +4117,7 @@ S: People's Repulic of China
 N: Victor Yodaiken
 E: yodaiken@fsmlabs.com
 D: RTLinux (RealTime Linux)
-S: POB 1822 
+S: POB 1822
 S: Socorro NM, 87801
 S: USA
 
@@ -4215,7 +4215,7 @@ D: EISA/sysfs subsystem
 S: France
 
 # Don't add your name here, unless you really _are_ after Marc
-# alphabetically. Leonard used to be very proud of being the 
+# alphabetically. Leonard used to be very proud of being the
 # last entry, and he'll get positively pissed if he can't even
 # be second-to-last.  (and this file really _is_ supposed to be
 # in alphabetic order)
-- 
2.25.1

