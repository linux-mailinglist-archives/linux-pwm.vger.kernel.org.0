Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2AE439E24
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Oct 2021 20:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhJYSIy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 14:08:54 -0400
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:3140
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234058AbhJYSIv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 25 Oct 2021 14:08:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiUBvUK1U++XkRmGfQrJk5ehNtmvAsGxTEDWgZtYXFdrrQV+UPVeXZ6IDKtXM4OpPWMfLPyhX0t/KU6F4KpoWQTWVkdB4C95/MegjfLyMG8l0hU+W1+JriP56EGyEDScLuATQHcSAMA8nrpfxb99FGVanvIH4x9RVsTRACHQwrl6KdKWm+0yhSwEWrmLB3rPekHqGyWAm+3vTJqsnWcxLTM8Eb5IzsWiSwBdgBfw4BwxKrvRxgiZUS4Jgk1EaE7SCFVMaU0GCi3ZzNTxJSEQsl1Hqf2+cYOQ2G4cCLf/e8Kn8L2xMoFVUq/qBcplRBrtvgkAHOlKgXG+it9EGdiJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spUM5s6nxVjKztS+n6VWlowtATDvPT1YSncx/oXqEJA=;
 b=l4dVlo4CnMQszo9Bn3ub/vlbkhfkO2+cShIBZqkXpKmO0UCnJo1HBYyj40w3l6Yc8/opNuHr0aBnAVwAKogdUt0fi7zAODjWIBIYcdINA43uDpGmxDWeiUUii5YGAkt0LTJEt9uMzXO1cjrnGdZoV7Lk06Am5aDvXgwe95ezyVdnAHoIfujSrTrD05ovJG8U+58owCpWqjtga+bJXbMT79EWQIpgYUH42v768grFh9V9KfgkBQmE2e579dsuoaJSkvvnfurxJ1FFru+5WLpUC4K7EqsF+GbRVUsjtz5zdwBvplqXiiCa6lT2GbvJEMjc61QX9ISI4fS3b38nAI65zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spUM5s6nxVjKztS+n6VWlowtATDvPT1YSncx/oXqEJA=;
 b=ILZ4recRuhVgGRjF9qaYmuZTwUwovx2KBQ6M7biOQGhEZFaMZyYuI56Q1512DNGEt3c8jx9PjxaxPHqF306YH7+t4rIm3EyH43c9Mf/tge2DiUugvyN+S+eozTA7qWW48VReGghvbZ9Qe63qrVsuODNhnN36N4eyJ2S38BfIoW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0302MB2823.eurprd03.prod.outlook.com (2603:10a6:4:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 18:06:22 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 18:06:22 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v9 3/3] pwm: Add support for Xilinx AXI Timer
Date:   Mon, 25 Oct 2021 14:06:05 -0400
Message-Id: <20211025180605.252476-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025180605.252476-1-sean.anderson@seco.com>
References: <20211025180605.252476-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:208:32d::11) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from plantagenet.inhand.com (50.195.82.171) by BLAPR03CA0036.namprd03.prod.outlook.com (2603:10b6:208:32d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 18:06:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 137c71a9-7157-4243-64c3-08d997e226bf
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2823:
X-Microsoft-Antispam-PRVS: <DB6PR0302MB28238D32E9A0D0EC9BF3E45996839@DB6PR0302MB2823.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MbV4n++NYqKqI4xc2+0pj5qI2bmD5Mw7fu+pmFVJYbCQmxcUUKV0CMAlI2T5pMd6xRRJb8k6GBkQ6aYUh7/J9RA+9f1fzuSWCVNRNLlMoLZIdNqiJR7xecL7m1dJl0ywxNtyMTLnVu/SgWBpeFPKAT44OlXgA3OpMneqfhFi597MMHJsQPsuaMo7O0bK+xNAY16BJJ+02VX4oTMa4f6QRHHhSVxEjpQ6yN1HvqeioiGyuCgSQHliNTaxO3q6aRfhaNQRzIAJabUYIYKbplR9ExndB712+9BrgpkpjKOzejb8kiY8CXlNBXjAC7crH8nAunbp31KJDo/WC/J42HhdzdSo5LV3ZxIdesHfmnRjXM6sylxlMZdrfUdBmz4a7NsqScZaKyvpZW1lItHrqgyWm/uZqwcc37qCL5RkLGKWAJLOrCj/8lXYdjeSlmFreV7yL0aD9T+Zdt/pdgsjYyuGBNLOQ1DIKrjnlyHxT5LXNyrBrjVUlqpMt3MCHoZ27ZTdoRHWyjpkEOEmD2wRq8VhfdMb2QRAk09BajlSYjK4EpHBoV28XpcX/ruiX+YV8fQSeGpwFrowEUaoYjEeDdIG4bqi9nWzexbRkwpBkgSSUHiLxb/dV5H/vswv7DN/RIKO4hJSN2U5FNFqR7OewwQAdtm7pbgCqtmN72UYa0Jm6gWaeE9O+Ep9nhR6HtFtP57rSC9JtYEGmUyOM5WtCEC+Mo2vCHydZWX5CLJ58n6SIgmvzEPWqNjbts0kriPvgSpSJO/0UTOpGlZBzPeu53tmrX7zEIi9DuaqHGjROn+e7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6486002)(6666004)(54906003)(30864003)(107886003)(2616005)(44832011)(956004)(5660300002)(83380400001)(508600001)(2906002)(6916009)(6506007)(316002)(1076003)(36756003)(66476007)(8936002)(66556008)(38350700002)(186003)(38100700002)(6512007)(66946007)(86362001)(52116002)(966005)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2F4NjlVZmNrd21Fd293Rllva1NyTlhQYjVGYTBhUkxnRnhIRzgvRFRNR1BN?=
 =?utf-8?B?Zm5iSFEva09PV0VLRFZqQkhmNllhR0hCUDIyZCtwWUZuS0pwRUJ2T3dNbTZa?=
 =?utf-8?B?Umc3RlM2K1JkUC9XUytqeWdLdFZkcG1LVmUzM2F4L1IxR3dzMTRuN3JVUmNs?=
 =?utf-8?B?am5qYTl2czVPT3VKdzU2d2RCWCtWSnFuMVBxVmZwMXY0NEpnSkFaQVdFc3Mz?=
 =?utf-8?B?T1prSG5ZV3BJQzQ4N2l1QlR5NWt2WjhRelN2bXJLcXRIWVJZZDNWSGVBalNi?=
 =?utf-8?B?M1grRTFJQlJjcXZBbVVWaWVEdG9lMmxVUkU2SHprVHhGK0FjVStjSm9kQnJx?=
 =?utf-8?B?R2R6ZGF1SUtMNDIwR2xJZGVFU1NxK29wQlAzWDlGaFlTYU52cGJaMkdWbzlJ?=
 =?utf-8?B?T0pQdGZrc21NeXFPVkF2MElyUXpPVElCaEpvRWQ3czdrWG5oNUdRekl4Nmpa?=
 =?utf-8?B?alFEdjE1K0I1MlhmK3g2clFoME9tTWVTcXhCamVXMDRSU2lLYlJjcndLZk5a?=
 =?utf-8?B?U3RXdkh2RXZSTWc4NitiZllEUHF5bXRMcUIyMkZWRms3NUJvV0drSWtBM1V4?=
 =?utf-8?B?NjhuNmZOUkJ2U1dwM0prUGVRZE5qd1plelp1cGQ5aCtaUjZoOXNFOU5SN1dr?=
 =?utf-8?B?eXJzcHpJUXBlTERjdzdORGcvTzVKbDFOSVdmcndvS3kzL3pvQ2VSNGRualZV?=
 =?utf-8?B?UVVBMnRURTBQdzZDY2QyNzVhMnhvUEFLRWtnT0JtNkVJQ1drZkQ1UTJ5elo2?=
 =?utf-8?B?ZlBYRzNzcjJWd2s3eUhEbVFJMS9FclZSR08rSW8yS1M1Qll4WjFrNVF5VW03?=
 =?utf-8?B?bm5UeTg1Q3ZJKytiL0VPbUt2YUNIUlBGUVI2OSs5emtTMU1uc0lFR056R2p2?=
 =?utf-8?B?NmEySXhZTS85MVA4WVp4elRzclU2bHZYVzNXakVLUUlRRDcwZ3c2b3hKRGtC?=
 =?utf-8?B?N2czSFpZL1ZpVWN2RHA4Qk9wWmFBNzNJZVNCNHhhUmVRTVpWSjFKQld2UnAw?=
 =?utf-8?B?VEJFbUI1RHR3anBGZjh1Y0NyN0hoTkpIZFpJTWRwcDZTb0Q0bG1kaGZTVDJp?=
 =?utf-8?B?ZWFxc3BsNks2SEUvQlZBR0Q4N3NINWg5djN5MmRRS0x6V3NBUU1rLzBFdHhY?=
 =?utf-8?B?R3hXM0t0cHhZcjBaZHpPYnJJeUEvTDR6S2YrQmtOS3I0dUpOVExsUTNhQmN5?=
 =?utf-8?B?VzdWSFNHOHppMXBWdGdWRGRJTS9jQ0dSZ29RaWJsVlpxY0FURTlXaEtJU2U5?=
 =?utf-8?B?QlI3VFVBUlI5c1BDVEdreHoyM2ZaN01CQmVrQ2w5bXFUNThuQzU4RHk1SGNt?=
 =?utf-8?B?c3VydmZCaVpBSUFDVzdQMnBMbHp6MW4wbzduUkpjZnh0MWRpaXRyZ1BGWTdE?=
 =?utf-8?B?bnRNdzNFRWxDM3AyK1lvVmZJMndBVGVRU0tOenNSOFpqSTFMU1k3SFRlTnFo?=
 =?utf-8?B?b0Z5dEFvbkhQK0ViK0E3UjJzbWM1RkRsYlRISnZDK0FaUkdHL1BBeElUM0Q1?=
 =?utf-8?B?cC9Nd0FuMFF2VWtRMGJTdzdFa1VKZ0p0WkRQZnpsVkRBZFBSMGM4QTRwZTJJ?=
 =?utf-8?B?aUJFTUplZzM4RmFrbGtFcXJIcm9wN0FvaEZBNE1Uc211SHhVbW44T2FpbDlM?=
 =?utf-8?B?dWtvUGFnQTFBVGNIMkNvVWRrUU93cE1oWERsT3VOSENQcklWZFp6Vm5JTDd2?=
 =?utf-8?B?YzRVRUswZzMvRUk1ZmQ1QXJWdVRYOWtUS3lFSUp5eEI4d1JYbjY0TXhaUDZJ?=
 =?utf-8?B?UVc3K1ZpckdablhsVjk3U05UckZJRi9BNHhIOWtpeks4dURlK2hPYUJUNDZK?=
 =?utf-8?B?ZUFmdUVGTTlvdUMzcGwxWjVJY282aFNGbjFDcXN5RTQ0NEZNMzNOVW56QlZW?=
 =?utf-8?B?OFNDa1VtTGhzWllwRnptZWZxQzJhODhVUldIZHp1R3E4bWpOWXNjNkZHV05O?=
 =?utf-8?B?aDRMQ1g0WXFla2ZBNlhpYmw0aE1vTU9QQkZaV1dCbS96aVVoVjM1Q0crbHBx?=
 =?utf-8?B?RWtyb3VndFp6ZmE3cGtSc21sMHVYQjkrRXZwS0loNW5DdSt4L0g4YTJ6SXdk?=
 =?utf-8?B?aWJHK2o1SUdETDNmVkdpemRCV3ZFcXo1eXRJMC9ZbUY2eGFINDBSS2RBQmhk?=
 =?utf-8?B?Yk5Cb0ZvbjJjZTc1U0xmVVMwc1hGdDZ5QlQ4RWFidDBWT09uNTFnYndiWGxU?=
 =?utf-8?Q?6E5ij9/ZxXj/zJruhQ/CXO8=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137c71a9-7157-4243-64c3-08d997e226bf
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 18:06:21.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVaOJD1+LXt/SWrlenSzTYepwX8etFaRsVp+jn/NwgXALUmjjUJepH+5jr9BEtXlPhgYkaamRfFLftssIRfP1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2823
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
found on Xilinx FPGAs. At the moment clock control is very basic: we
just enable the clock during probe and pin the frequency. In the future,
someone could add support for disabling the clock when not in use.

Some common code has been specially demarcated. While currently only
used by the PWM driver, it is anticipated that it may be split off in
the future to be used by the timer driver as well.

This driver was written with reference to Xilinx DS764 for v1.03.a [1].

[1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v9:
- Refactor "if { return } else if { }" to "if { return } if { }"
- Remove drivers/clocksource/timer-xilinx-common.c from MAINTAINERS
- Remove xilinx_timer_common_init and integrate it into xilinx_timer_probe

Changes in v8:
- Drop new timer driver; it has been deferred for future series

Changes in v7:
- Add dependency on OF_ADDRESS
- Fix period_cycles calculation
- Fix typo in limitations

Changes in v6:
- Capitalize error messages
- Don't disable regmap locking to allow inspection of registers via
  debugfs
- Prevent overflow when calculating period_cycles
- Remove enabled variable from xilinx_pwm_apply
- Swap order of period_cycle range comparisons

Changes in v5:
- Allow non-zero #pwm-cells
- Correctly set duty_cycle in get_state when TLR0=TLR1
- Elaborate on limitation section
- Perform some additional checks/rounding in apply_state
- Remove xlnx,axi-timer-2.0 compatible string
- Rework duty-cycle and period calculations with feedback from Uwe
- Switch to regmap to abstract endianness issues
- Use more verbose error messages

Changes in v4:
- Don't use volatile in read/write replacements. Some arches have it and
  some don't.
- Put common timer properties into their own struct to better reuse
  code.
- Remove references to properties which are not good enough for Linux.

Changes in v3:
- Add clockevent and clocksource support
- Remove old microblaze driver
- Rewrite probe to only use a device_node, since timers may need to be
  initialized before we have proper devices. This does bloat the code a bit
  since we can no longer rely on helpers such as dev_err_probe. We also
  cannot rely on device resources being free'd on failure, so we must free
  them manually.
- We now access registers through xilinx_timer_(read|write). This allows us
  to deal with endianness issues, as originally seen in the microblaze
  driver. CAVEAT EMPTOR: I have not tested this on big-endian!

Changes in v2:
- Add comment describing device
- Add comment explaining why we depend on !MICROBLAZE
- Add dependencies on COMMON_CLK and HAS_IOMEM
- Cast dividends to u64 to avoid overflow
- Check for over- and underflow when calculating TLR
- Check range of xlnx,count-width
- Don't compile this module by default for arm64
- Don't set pwmchip.base to -1
- Ensure the clock is always running when the pwm is registered
- Remove debugfs file :l
- Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
- Report errors with dev_error_probe
- Set xilinx_pwm_ops.owner
- Use NSEC_TO_SEC instead of defining our own
- Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe

 MAINTAINERS                        |   6 +
 arch/microblaze/kernel/timer.c     |   3 +
 drivers/pwm/Kconfig                |  14 ++
 drivers/pwm/Makefile               |   1 +
 drivers/pwm/pwm-xilinx.c           | 311 +++++++++++++++++++++++++++++
 include/clocksource/timer-xilinx.h |  91 +++++++++
 6 files changed, 426 insertions(+)
 create mode 100644 drivers/pwm/pwm-xilinx.c
 create mode 100644 include/clocksource/timer-xilinx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f26920f0fa65..6cc3be5d5e99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20603,6 +20603,12 @@ F:	drivers/misc/Makefile
 F:	drivers/misc/xilinx_sdfec.c
 F:	include/uapi/misc/xilinx_sdfec.h
 
+XILINX PWM DRIVER
+M:	Sean Anderson <sean.anderson@seco.com>
+S:	Maintained
+F:	drivers/pwm/pwm-xilinx.c
+F:	include/clocksource/timer-xilinx.h
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial@vger.kernel.org
diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
index f8832cf49384..20e2669b533d 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -251,6 +251,9 @@ static int __init xilinx_timer_init(struct device_node *timer)
 	u32 timer_num = 1;
 	int ret;
 
+	if (of_property_read_bool(np, "#pwm-cells"))
+		return 0;
+
 	if (initialized)
 		return -EINVAL;
 
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index aa29841bbb79..47f25237754f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -638,4 +638,18 @@ config PWM_VT8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-vt8500.
 
+config PWM_XILINX
+	tristate "Xilinx AXI Timer PWM support"
+	depends on OF_ADDRESS
+	depends on COMMON_CLK
+	select REGMAP_MMIO
+	help
+	  PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
+	  typically a soft core which may be present in Xilinx FPGAs.
+	  This device may also be present in Microblaze soft processors.
+	  If you don't have this IP in your design, choose N.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-xilinx.
+
 endif
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 708840b7fba8..ea785480359b 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
+obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
new file mode 100644
index 000000000000..d79ef202d62f
--- /dev/null
+++ b/drivers/pwm/pwm-xilinx.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ *
+ * Limitations:
+ * - When changing both duty cycle and period, we may end up with one cycle
+ *   with the old duty cycle and the new period. This is because the counters
+ *   may only be reloaded by first stopping them, or by letting them be
+ *   automatically reloaded at the end of a cycle. If this automatic reload
+ *   happens after we set TLR0 but before we set TLR1 then we will have a
+ *   bad cycle. This could probably be fixed by reading TCR0 just before
+ *   reprogramming, but I think it would add complexity for little gain.
+ * - Cannot produce 100% duty cycle by configuring the TLRs. This might be
+ *   possible by stopping the counters at an appropriate point in the cycle,
+ *   but this is not (yet) implemented.
+ * - Only produces "normal" output.
+ * - Always produces low output if disabled.
+ */
+
+#include <clocksource/timer-xilinx.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+/*
+ * The following functions are "common" to drivers for this device, and may be
+ * exported at a future date.
+ */
+u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
+			    u64 cycles)
+{
+	WARN_ON(cycles < 2 || cycles - 2 > priv->max);
+
+	if (tcsr & TCSR_UDT)
+		return cycles - 2;
+	return priv->max - cycles + 2;
+}
+
+unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
+				     u32 tlr, u32 tcsr)
+{
+	u64 cycles;
+
+	if (tcsr & TCSR_UDT)
+		cycles = tlr + 2;
+	else
+		cycles = (u64)priv->max - tlr + 2;
+
+	/* cycles has a max of 2^32 + 2 */
+	return DIV64_U64_ROUND_CLOSEST(cycles * NSEC_PER_SEC,
+				       clk_get_rate(priv->clk));
+}
+
+/*
+ * The idea here is to capture whether the PWM is actually running (e.g.
+ * because we or the bootloader set it up) and we need to be careful to ensure
+ * we don't cause a glitch. According to the data sheet, to enable the PWM we
+ * need to
+ *
+ * - Set both timers to generate mode (MDT=1)
+ * - Set both timers to PWM mode (PWMA=1)
+ * - Enable the generate out signals (GENT=1)
+ *
+ * In addition,
+ *
+ * - The timer must be running (ENT=1)
+ * - The timer must auto-reload TLR into TCR (ARHT=1)
+ * - We must not be in the process of loading TLR into TCR (LOAD=0)
+ * - Cascade mode must be disabled (CASC=0)
+ *
+ * If any of these differ from usual, then the PWM is either disabled, or is
+ * running in a mode that this driver does not support.
+ */
+#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
+#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
+#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
+
+struct xilinx_pwm_device {
+	struct pwm_chip chip;
+	struct xilinx_timer_priv priv;
+};
+
+static inline struct xilinx_timer_priv
+*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
+{
+	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
+}
+
+static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
+{
+	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) == TCSR_PWM_SET &&
+		(TCSR_PWM_MASK & tcsr1) == TCSR_PWM_SET;
+}
+
+static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
+			    const struct pwm_state *state)
+{
+	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
+	u32 tlr0, tlr1, tcsr0, tcsr1;
+	u64 period_cycles, duty_cycles;
+	unsigned long rate;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	/*
+	 * To be representable by TLR, cycles must be between 2 and
+	 * priv->max + 2. To enforce this we can reduce the duty
+	 * cycle, but we may not increase it.
+	 */
+	rate = clk_get_rate(priv->clk);
+	/* Prevent overflow by clamping to the worst case of rate */
+	period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
+	period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
+	if (period_cycles < 2 || period_cycles - 2 > priv->max)
+		return -ERANGE;
+	duty_cycles = mul_u64_u32_div(state->duty_cycle, rate, NSEC_PER_SEC);
+
+	/*
+	 * If we specify 100% duty cycle, we will get 0% instead, so decrease
+	 * the duty cycle count by one.
+	 */
+	if (period_cycles == duty_cycles)
+		duty_cycles--;
+
+	/* Round down to 0% duty cycle for unrepresentable duty cycles */
+	if (duty_cycles < 2)
+		duty_cycles = period_cycles;
+
+	regmap_read(priv->map, TCSR0, &tcsr0);
+	regmap_read(priv->map, TCSR1, &tcsr1);
+	tlr0 = xilinx_timer_tlr_cycles(priv, tcsr0, period_cycles);
+	tlr1 = xilinx_timer_tlr_cycles(priv, tcsr1, duty_cycles);
+	regmap_write(priv->map, TLR0, tlr0);
+	regmap_write(priv->map, TLR1, tlr1);
+
+	if (state->enabled) {
+		/*
+		 * If the PWM is already running, then the counters will be
+		 * reloaded at the end of the current cycle.
+		 */
+		if (!xilinx_timer_pwm_enabled(tcsr0, tcsr1)) {
+			/* Load TLR into TCR */
+			regmap_write(priv->map, TCSR0, tcsr0 | TCSR_LOAD);
+			regmap_write(priv->map, TCSR1, tcsr1 | TCSR_LOAD);
+			/* Enable timers all at once with ENALL */
+			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
+			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
+			regmap_write(priv->map, TCSR0, tcsr0);
+			regmap_write(priv->map, TCSR1, tcsr1);
+		}
+	} else {
+		regmap_write(priv->map, TCSR0, 0);
+		regmap_write(priv->map, TCSR1, 0);
+	}
+
+	return 0;
+}
+
+static void xilinx_pwm_get_state(struct pwm_chip *chip,
+				 struct pwm_device *unused,
+				 struct pwm_state *state)
+{
+	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
+	u32 tlr0, tlr1, tcsr0, tcsr1;
+
+	regmap_read(priv->map, TLR0, &tlr0);
+	regmap_read(priv->map, TLR1, &tlr1);
+	regmap_read(priv->map, TCSR0, &tcsr0);
+	regmap_read(priv->map, TCSR1, &tcsr1);
+	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
+	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
+	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	/* 100% duty cycle results in constant low output */
+	if (state->period == state->duty_cycle)
+		state->duty_cycle = 0;
+}
+
+static const struct pwm_ops xilinx_pwm_ops = {
+	.apply = xilinx_pwm_apply,
+	.get_state = xilinx_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static const struct regmap_config xilinx_pwm_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.max_register = TCR1,
+};
+
+static int xilinx_timer_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct xilinx_timer_priv *priv;
+	struct xilinx_pwm_device *pwm;
+	u32 pwm_cells, one_timer, width;
+	void __iomem *regs;
+
+	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
+	if (ret == -EINVAL)
+		return -ENODEV;
+	if (ret)
+		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
+
+	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, pwm);
+	priv = &pwm->priv;
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	priv->map = devm_regmap_init_mmio(dev, regs,
+					  &xilinx_pwm_regmap_config);
+	if (IS_ERR(priv->map))
+		return dev_err_probe(dev, PTR_ERR(priv->map),
+				     "Could not create regmap\n");
+
+	ret = of_property_read_u32(np, "xlnx,one-timer-only", &one_timer);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Could not read xlnx,one-timer-only\n");
+
+	if (one_timer)
+		return dev_err_probe(dev, -EINVAL,
+				     "Two timers required for PWM mode\n");
+
+
+	ret = of_property_read_u32(np, "xlnx,count-width", &width);
+	if (ret == -EINVAL)
+		width = 32;
+	else if (ret)
+		return dev_err_probe(dev, ret,
+				     "Could not read xlnx,count-width\n");
+
+	if (width != 8 && width != 16 && width != 32)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid counter width %d\n", width);
+	priv->max = BIT_ULL(width) - 1;
+
+	/*
+	 * The polarity of the generate outputs must be active high for PWM
+	 * mode to work. We could determine this from the device tree, but
+	 * alas, such properties are not allowed to be used.
+	 */
+
+	priv->clk = devm_clk_get(dev, "s_axi_aclk");
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "Could not get clock\n");
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Clock enable failed\n");
+	clk_rate_exclusive_get(priv->clk);
+
+	pwm->chip.dev = dev;
+	pwm->chip.ops = &xilinx_pwm_ops;
+	pwm->chip.npwm = 1;
+	ret = pwmchip_add(&pwm->chip);
+	if (ret) {
+		clk_rate_exclusive_put(priv->clk);
+		clk_disable_unprepare(priv->clk);
+		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
+	}
+
+	return 0;
+}
+
+static int xilinx_timer_remove(struct platform_device *pdev)
+{
+	struct xilinx_pwm_device *pwm = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&pwm->chip);
+	clk_rate_exclusive_put(pwm->priv.clk);
+	clk_disable_unprepare(pwm->priv.clk);
+	return 0;
+}
+
+static const struct of_device_id xilinx_timer_of_match[] = {
+	{ .compatible = "xlnx,xps-timer-1.00.a", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xilinx_timer_of_match);
+
+static struct platform_driver xilinx_timer_driver = {
+	.probe = xilinx_timer_probe,
+	.remove = xilinx_timer_remove,
+	.driver = {
+		.name = "xilinx-timer",
+		.of_match_table = of_match_ptr(xilinx_timer_of_match),
+	},
+};
+module_platform_driver(xilinx_timer_driver);
+
+MODULE_ALIAS("platform:xilinx-timer");
+MODULE_DESCRIPTION("Xilinx LogiCORE IP AXI Timer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
new file mode 100644
index 000000000000..1f7757b84a5e
--- /dev/null
+++ b/include/clocksource/timer-xilinx.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
+ */
+
+#ifndef XILINX_TIMER_H
+#define XILINX_TIMER_H
+
+#include <linux/compiler.h>
+
+#define TCSR0	0x00
+#define TLR0	0x04
+#define TCR0	0x08
+#define TCSR1	0x10
+#define TLR1	0x14
+#define TCR1	0x18
+
+#define TCSR_MDT	BIT(0)
+#define TCSR_UDT	BIT(1)
+#define TCSR_GENT	BIT(2)
+#define TCSR_CAPT	BIT(3)
+#define TCSR_ARHT	BIT(4)
+#define TCSR_LOAD	BIT(5)
+#define TCSR_ENIT	BIT(6)
+#define TCSR_ENT	BIT(7)
+#define TCSR_TINT	BIT(8)
+#define TCSR_PWMA	BIT(9)
+#define TCSR_ENALL	BIT(10)
+#define TCSR_CASC	BIT(11)
+
+struct clk;
+struct device_node;
+struct regmap;
+
+/**
+ * struct xilinx_timer_priv - Private data for Xilinx AXI timer drivers
+ * @map: Regmap of the device, possibly with an offset
+ * @clk: Parent clock
+ * @max: Maximum value of the counters
+ */
+struct xilinx_timer_priv {
+	struct regmap *map;
+	struct clk *clk;
+	u32 max;
+};
+
+/**
+ * xilinx_timer_tlr_cycles() - Calculate the TLR for a period specified
+ *                             in clock cycles
+ * @priv: The timer's private data
+ * @tcsr: The value of the TCSR register for this counter
+ * @cycles: The number of cycles in this period
+ *
+ * Callers of this function MUST ensure that @cycles is representable as
+ * a TLR.
+ *
+ * Return: The calculated value for TLR
+ */
+u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
+			    u64 cycles);
+
+/**
+ * xilinx_timer_get_period() - Get the current period of a counter
+ * @priv: The timer's private data
+ * @tlr: The value of TLR for this counter
+ * @tcsr: The value of TCSR for this counter
+ *
+ * Return: The period, in ns
+ */
+unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
+				     u32 tlr, u32 tcsr);
+
+/**
+ * xilinx_timer_common_init() - Perform common initialization for Xilinx
+ *                              AXI timer drivers.
+ * @priv: The timer's private data
+ * @np: The devicetree node for the timer
+ * @one_timer: Set to %1 if there is only one timer
+ *
+ * This performs common initialization, such as detecting endianness,
+ * and parsing devicetree properties. @priv->regs must be initialized
+ * before calling this function. This function initializes @priv->read,
+ * @priv->write, and @priv->width.
+ *
+ * Return: 0, or negative errno
+ */
+int xilinx_timer_common_init(struct device_node *np,
+			     struct xilinx_timer_priv *priv,
+			     u32 *one_timer);
+
+#endif /* XILINX_TIMER_H */
-- 
2.25.1

