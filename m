Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BE544ECED
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Nov 2021 19:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhKLS60 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Nov 2021 13:58:26 -0500
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:5344
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230137AbhKLS6Z (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 12 Nov 2021 13:58:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmGCQzquyW2JqOJZJqtOmwNidhrYXeDhfUXsrlaxQ6RxMrA61ppgNasfgZ9JXsh8JuaO7j5pv64uw0nskKaep8wgpJkyzaX+fjnWol8rsBbb9yDmMkWFx/NkY47A8Ku7aJCXX4Mgp9BVw3jI+4zclGInHxjhk7LBnIwbz5X9nsnXg+NLxUNX0e0loa0tFSnOdn4hEPciRziVxWssiAdDIDk1wOOmHGUrChG4Hm2IjtTePKEuWj7WPa7rwiV+FahsiUR/r7VZBQ9fqESb2JsNOpVGqIuyGY9CM3c9aK3EIMLMmr1DlL8yPBP+jR06h5jEp8J1xMMjEt4GisbjFHGGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnhYE1u8daTSVKDbiNQZoRQMxrkKQXNrXVjE/vTziVY=;
 b=bq8lkDSIxcdsnD7vYSObohrGcp/5HwfZ6w5ZHcjdTEaBJQys+OCM3iyCdrEyy5d18gVfLOBCn8Sqe2p5romYpE38IYoLmQEtghTfyccPUkANMnOtRG0YIg5E9YlJ7bi0nHnM2FW9kH19QnfITMoomMNdTePrX/SQLtN3gOCVWZ4pe+QrweFjHpe0VfIRUjD3ci0Vux8r4YOFQxSVljnchJtR2e4m+VNiY0EdPGn2/nmr/FAr6cK+SpiAYZJD2RSH5xIK4Yrjint3/M3Cr+OhYqrdmH0ugYFKvaakq5EqhG5x3PDI1+wbLRL+kqJ4pm0uNYvIrH7/frtUJO30hkUanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnhYE1u8daTSVKDbiNQZoRQMxrkKQXNrXVjE/vTziVY=;
 b=W6duOzp1oFgQMtnABX4ME5Gmp1xmkdk9/Z7Y+eFkwaQBF7VjLbTYJGQgA+aU6H8pWJNUCB3oM+jgmzFF8BLELIwewSAwAjJt5nsQeTt/IHnxZIriXy5CxyMOmsIOIpPOvAz/mdAA4Q6Yv0AaUIIu3IprGSUf3J7lLyGCM/6hhoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6201.eurprd03.prod.outlook.com (2603:10a6:10:13f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 12 Nov
 2021 18:55:32 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4669.015; Fri, 12 Nov 2021
 18:55:32 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v10 3/3] pwm: Add support for Xilinx AXI Timer
Date:   Fri, 12 Nov 2021 13:55:04 -0500
Message-Id: <20211112185504.1921780-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112185504.1921780-1-sean.anderson@seco.com>
References: <20211112185504.1921780-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:208:2be::35) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from plantagenet.inhand.com (50.195.82.171) by BL1PR13CA0210.namprd13.prod.outlook.com (2603:10b6:208:2be::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.14 via Frontend Transport; Fri, 12 Nov 2021 18:55:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a587d397-1035-4ad4-4099-08d9a60e008c
X-MS-TrafficTypeDiagnostic: DB8PR03MB6201:
X-Microsoft-Antispam-PRVS: <DB8PR03MB620120B4602B07335D8AF4D896959@DB8PR03MB6201.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3e8vVkNbAiDO8E3FG1HKc+fxAMdIUmM9xm26pmcFhMsfo85ZnIPnFnkByP4XSrSQXKwbsXUHF7CwTurIp2ay0E5Qi96sOeCgrFq+rCs+Zjp63EJ99pi/WTnGpA3JwFI2b1fYGzf0dAjbg7kHaEbdyrEzUalWLe1waSRHpTI6VH3e0QLqygYqF2gi2ohyK9DgUGbHgVEqF+y97Oc/m5wU00/bAoHoY8goQ9r8OEuXs3gZi69/acy3PVQ2QQ8KK6TFLZisCza5Q4AhhljScbldAiFimYbdHZmVQi7ZDIOMG4LKnLyNK0RaqBuvD2Bl1ugcrSXiD+VYSWs0ODUdItsw9jxEnWITb4QGjz2bP+wncxm4W7wBOLMybxwE0yUtU6OEIzCMwgw0IpNcXeSCadi5wzzzkOj1aFC1MjpgToDJ8rK7piOd/D2pI/87QwTw5WaC2F0W2T50gr6c/pMc53XIvJsZUUFNhXNVxUAzRwEBcz8Q1XKeeoK3AoI/JYT5UquWbml/VP5FA05kDxkTtOHtVaNe5BmEKQtru3ep9f5VY0DC8moJy3+/xEp9ezUAyzCGfRg6ThltXEt4jNPpVZcwm2sDRaUiGoUwk3AbmU6tO8CdKuckg/rNBBpPus4BRxZMlHDdmdx4J3cY+crq+RLHZnCkGiEUoOpc9SxKBsDzaSCEMqPxoexWfD9at+67Owf0EXaBNDKpHFD0yiTpqqu+5dYskmHEssTYsKBmgSHyQAUF8oVC1lKlpnm9Fs70y69PX54pvaBiTpiYu+2Mp9FfV7eECVVqnO1Sru7D5dA2q8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(66476007)(66556008)(86362001)(186003)(1076003)(83380400001)(26005)(5660300002)(316002)(508600001)(966005)(66946007)(54906003)(52116002)(38100700002)(8676002)(4326008)(38350700002)(6506007)(956004)(2616005)(107886003)(6916009)(6486002)(30864003)(6666004)(36756003)(44832011)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhUb0xtcWd4ek9tL0FoSXNNTUlROVMvSlVTd0VLTnhWSWg0RSsvZi9EM3Za?=
 =?utf-8?B?dVFidnJ4dXI4ZGl5YmtYaEhMRnFwYW4rWitjVXVHYjFIVVdOdmdweUlySlpp?=
 =?utf-8?B?Y2VJSWxmazI0ZXYxcmxwcmM3WElFdDVteWdYdXVVa1RYc3c5SXV4UFJtd2J0?=
 =?utf-8?B?M0xnYk1zV3dXeG9QUzNrRDIrZExiUVdCc3pFbWZabmFPZXkrcEhhd2F3bm0w?=
 =?utf-8?B?QlNVZVNZY1FJZnY1cGtvVHJZS09DMlh1d3EwMis4QkQ1eERmaEwzUEg4L2hF?=
 =?utf-8?B?SmZKTmt4QjFZZkxLbmZzU2xYTmhvWFZ4UmxtRTZDYlRIL0F6L2lEb1djUEUr?=
 =?utf-8?B?ZmhNWEhlVEhNTkJyNUZlSVY3UzJvb1p3VUUvNlpWNWtpaG1td3BmUG5uWVpU?=
 =?utf-8?B?RHVkeGlqUXFtOWp1NEFtTkQ2RXAvaXE4RkhESnQ4blVJdDRKWVVQdDd2em03?=
 =?utf-8?B?OW1EQ3czWklsNHF0b1lpMFZRdUhTdno5cGgybGx2MkpCa1BsMm5ON1YvTEky?=
 =?utf-8?B?ZXJ3dTdNL3F4K1dKUU12czdDZmZpYkxyZVlId0U4ZkRicEczMTM5cGlQaWlk?=
 =?utf-8?B?S0ZLc2VhRVJmRUpxSmlTUWZDMGNoMks5M04yUjE3bmlpMHNBK254N2lUT1RE?=
 =?utf-8?B?OE5uN0NtT1FJNHVnY1NzZEE0SWJxK04vVWt3blNKc2xuKytpbU1jZE91NFd4?=
 =?utf-8?B?dnl4alRGa0V2Z3c1d0tXSldYTHNXVHZqQzVlOUNTWjl2ZXhzNk43b1VRS2x5?=
 =?utf-8?B?TkNMcGc2Qit5Q21rczZmQXp2eHpuMFVyTXdoU3pBRTM4dXh1YWF3M0pNc2pk?=
 =?utf-8?B?VGxkc3JJS0lpUzRCV2VDV2tYcllqVW1FaVdJdWhpZndpS2NwWDRtRTFKck5T?=
 =?utf-8?B?SlhNVVhCV1ZJb2JrVERaY3V0L3ZZallEaEpGbkMvMCtmVTRHcnZmeHJwOUFt?=
 =?utf-8?B?YkFwRldvYVFoVlpkbEk5WkhuRFV6S0tyRi8vZytydXAveHJrMmhDd0N6L04v?=
 =?utf-8?B?ZVF0bytLRVNTaUlIVnRGY0VsTk1VL0lWZmhmdDdxVUtZMy9IcEtxVWdmdjU4?=
 =?utf-8?B?QkdxWXgrMWVJUkNrNm5vbnliTTYrMkVNY1N4Y0FKa3g4T2t1OXdoK1dhU0pO?=
 =?utf-8?B?ZUsvQTlMTlR4NFcrVzdWM0ROVUkzN3hONnQ0S0cwM202bmNMU2hxdFVub1Z3?=
 =?utf-8?B?TG9DQnlpNkZhMnZjMkRZcFVDQ1U4dWVvWG1obElXOTlzWW1PUXVLYVBhSnRJ?=
 =?utf-8?B?MGc3RWNWSkp4OU1PV1ZhMHlkc3F5Smhwd2pjUkdIZ3VyZGFsNzBHeFZYb3ho?=
 =?utf-8?B?UGs1cTJkaWRpaDVIQU1EVXZxU1NFZW1Ed2RNbk5BSjViU0NzdGRYNndJMkQ0?=
 =?utf-8?B?Z0hZMngzOHM5dnhOOU5hU1VSVThsRHRYclowc09oWXFWU0JsajE3VklBWUdk?=
 =?utf-8?B?ZERkS0ZVaEJnL2dENHErUnlHNVhzZ0xHL1o2VTh0UFNYWDk2aC9KSUM4NWdQ?=
 =?utf-8?B?RG9BZnJHUXIyVUMvMGwvN2sreTJTNnZKZVJrRG8yYVB2eXAxV2pBb3lVMjdU?=
 =?utf-8?B?NUswK0UxczNDREw1aGVONHhBQ05RRy9WWDFKdUdkT2hxTXQyUTVIYWVDalJl?=
 =?utf-8?B?L25EY0s2TS9oUDNETExTcEdqaUc0dHdkRGNvbjBxd3pkYjNSM1c3L1czK254?=
 =?utf-8?B?Wnc3NXcvOEQrbitVVXJuWnl1QktlcmNLR1dKbE56RTBBdm9HQ1NocnNVK2ox?=
 =?utf-8?B?ZVZ2QVpkT25lVElxYkVnL1lmZzdCbW91OHZWcWczaXVLRHFzNFY2NmdHU25v?=
 =?utf-8?B?cW5zSGpSUC9iaU1aWWVud2I2dmsxSVFoa3JoaWtpOEN1THZtVzVXYjZzRlBK?=
 =?utf-8?B?VzFmaFVyNnRWZXFxbG5sbCt4UmtTdHFiVlI3SXhMc3ZDMlFDZTV6UzZpd0Fr?=
 =?utf-8?B?eXE4aXVQbjJqTnZxK1VIZlFya2ZEWFBkUzNyRjNoaGpDdUFINExKQjM2THFa?=
 =?utf-8?B?ZmZNM09zb2dwclJNcjVPcENKS1JPNG9qYWxGUlAvV0dWeXN0U1BwMWdwUU5E?=
 =?utf-8?B?S3p1cysrcW03Q2NiSk9Dam9WSnF3QW1VQTMvbEZPYk1SUnlkUCtURnI3RFdh?=
 =?utf-8?B?eTI3SFd0NXl0a3NyQ2ZVU3M3RitockRmYXlYWUIvSGFFeVYxeGlkRTgwazBC?=
 =?utf-8?Q?+nIKMUiFjjxc7Y9YhABV3c8=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a587d397-1035-4ad4-4099-08d9a60e008c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 18:55:32.0766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJ93fYzaSdi1366cbHvaayS6Q1DGpixjdq6B496O3xw1K2SVjMb/DA2K6AF7xl8Hyrl7xaP6Bioh5HH1pWdacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6201
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

Changes in v10:
- Fix compilation error in timer driver

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
index 3b79fd441dde..6f0f57c041c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20614,6 +20614,12 @@ F:	drivers/misc/Makefile
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
index f8832cf49384..dea34a3d4aa4 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -251,6 +251,9 @@ static int __init xilinx_timer_init(struct device_node *timer)
 	u32 timer_num = 1;
 	int ret;
 
+	if (of_property_read_bool(timer, "#pwm-cells"))
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

