Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD9F416886
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Sep 2021 01:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbhIWXiS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Sep 2021 19:38:18 -0400
Received: from mail-db8eur05on2064.outbound.protection.outlook.com ([40.107.20.64]:58016
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240661AbhIWXiS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 23 Sep 2021 19:38:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgaMYwWORo94RQkOTlXM6Cu5CqbZIhIoTHyOHhh0iqigSCdJZrvk0tmwMUdCAxkHQRBS6Cn9P331jbsb6V18EVZbIPFOpGitB+FZ0Xk+5DTWzcfAF5exoI+XyewWBtTdN/Hbd70XgwBXBxkXOfI349Wzm4+zS3PfefqQizvPhg7DmxJ4iSYW5HzpCItP2qUTD8YfF8JdZV9qFEGA1gHL7BAo3fqOUX/FaKb+oe2YrNF+pW4vbuOiGWW6OM1c1x5KxAbJkjg+Ew6TDQG2TvDInmajdrTt79uKxkDz75fLnuGBGyu908z5T7Q7uRdqbXM9Dt+fByJYtntGpZIS4dE8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iwKdHmfMptXH/tdBev3Yl3A81vLvvtdLmX8r7bJrV6E=;
 b=kV/bzZnY3XS/tLDuo5F5nHojiVHDLee+T69IdjKZC8OLB6DDxOuwc49hggfMINXNK0QDHiZJe0biq4EuNVSCQbzj7xKavlT9iQvct3vvc84qArSKw2km/Ga3whEsiWQYarTgvYt1VbrrLYroi19BDQ5bk8IQrH/W3tRaAHnTJlDLR+8tAydKPjSxKK1yGTiCn99tZKPuAefzKd7fHl72ald36FfHjMtBQ5aUSQQW2SRZSJN1Vo38NrCTOV2jV4tbnUmhe4POjznNMsJYwqYv0rsNuYns5Fxi9miGEGuTKaTrtN6r3/pfhYAxxkH9M9Qk1vI8p039UKmrOXhwoX8eHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwKdHmfMptXH/tdBev3Yl3A81vLvvtdLmX8r7bJrV6E=;
 b=jcIXlkueSfpNNJXmaMKREdP+fUM0kcYMgUhODRnWNN7tcLszExoqyAnJiVYkcBbrs0Ipion4JHjQn9n6isiHa4lPDMjkPDdsKlSgAxtFaf9j+0ZzYMnUNv4l4wr9MgS9rTEv2G1noTp2eReLgK4Q8HrZ5gN2XncQLXu9TBOGSD0=
Authentication-Results: hazent.com; dkim=none (message not signed)
 header.d=none;hazent.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (20.176.234.91) by
 DB8PR03MB5674.eurprd03.prod.outlook.com (20.179.251.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Thu, 23 Sep 2021 23:36:42 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 23:36:42 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v7 3/3] pwm: Add support for Xilinx AXI Timer
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>
References: <20210916180544.2873770-1-sean.anderson@seco.com>
 <20210916180544.2873770-3-sean.anderson@seco.com>
Message-ID: <8580895f-0503-17ca-c6e4-54d91dd8f26a@seco.com>
Date:   Thu, 23 Sep 2021 19:36:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210916180544.2873770-3-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0088.namprd02.prod.outlook.com
 (2603:10b6:208:51::29) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from [172.27.1.65] (50.195.82.171) by BL0PR02CA0088.namprd02.prod.outlook.com (2603:10b6:208:51::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 23:36:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 261693d8-7da9-4cfb-5252-08d97eeaff81
X-MS-TrafficTypeDiagnostic: DB8PR03MB5674:
X-Microsoft-Antispam-PRVS: <DB8PR03MB56742D2F5E904DE3867AEAF596A39@DB8PR03MB5674.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKxqyRS6snI6ytrlgdkr1F6CxtG/iQpLcwYFdACMV/esCzvgNfCtaFBVrgbovcMk6R4RIspkWegA5n7k4g88aYS6pQ+MIc375Ulgb9pOz9F6ipP0L5xXM0a7OP76jjrrwBljgz5Wqdea6vHJhoApG/Val7NjBduYGI7Zxj9NFQBmdKNLAlyz2a1M5mQJHjznuxpvouEMMQ16EUyvrLtB6XixWrqG9kmMsAgijhyE+qkiw9RDnf3Nx463gfkk1IdAXQczeN+xb5wBRFLlZPxJBYfGNrMAZOqnK7xpB6oC2miIdyqa5DER/BqcWxugidVe4J94NaS3vAn93eT2AVh1ZudsOW76BMklW7SVGZv/DGdspgFeSfuuMD3X5C2JZwfSjazJeuMHTd66snjKgIJu0F6ckBhRli1BIY+yUbDlpgaJWjpbzy78Qqpcii268MsC3YTqYG2vWZmcc+iw1sMiUESnc+YaMPIe/aSdekvaFrncN+KUKYjlvCEzWZI/yQOGPWhyBZPz+3huG9+qf9Xl2zxdob2yMlHT1cgc1+CyCx2RTm+iqPDJ7RMLNE2II3j5CfIfs5QDG5xvnXT1u2YQz73uQJ6oD+XMP7RrPecqe/Ko102Y2ZubImrtBXVQM8SZ1mtThe0iDG4nzHNhvu5HK4BjkOrcbyaZbL+GdJpyXuboS3cLYrOGIVPeSo69eT1k9ngZqUmEeMKaUlcd6s9wNetF6fzV+BiOEcCIsLiYMDntTSrzFql2XePHWG4ew9m1Osf0Gq7pbHMmJ23QFijmQnQYAYDXasZP2sByqlUnHmybPpoIaeE21X6ba9hBC5V2P1g9Oyck5zd30mUGZ1yq7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(53546011)(6666004)(30864003)(36756003)(6486002)(86362001)(44832011)(8676002)(5660300002)(966005)(31696002)(2616005)(8936002)(66476007)(6916009)(66556008)(66946007)(38100700002)(186003)(38350700002)(4326008)(54906003)(31686004)(316002)(83380400001)(26005)(956004)(16576012)(52116002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldCWDBMSEZ4bEU4Zmt6eFBKMkpSUGtuWWJUZkcyMFNiMlJRaG85dHRzMEMv?=
 =?utf-8?B?RXVtRlpNNmRTMDErNGpGZ0MyNnpOWkFyMlV6ODY0a2FoQnFWNDY2RFBsT0dJ?=
 =?utf-8?B?WE94NDJaOUdMMEZLcjMyZU9TWjY0NzBYMFRpeGRIQXVhL1lqQWRCWUYrcmxO?=
 =?utf-8?B?NThqNGdUZFVDY3hsYWdpQytGQVRQY3NESHVOS1FZS2gxTXU5WHdzTGZUYWRZ?=
 =?utf-8?B?STRiQ202R3BSSlhVSm1qd21YL3cxQkxCRWtlY2JXdW5KVGw4UFNwNHE4RGU5?=
 =?utf-8?B?ekZXVTRpK09zcHdJM2h6Y3VTSjZVVzhPYTVHUGVxSnpkMmM0aENUUkEyZWZ5?=
 =?utf-8?B?R09lYlRKaUliWTJmSUR5UGZaTUkyR0NHdlBwcG9wcndEb2Q3b210ZkdWVDlp?=
 =?utf-8?B?bVJzZW5QUi8wSC9kN05JNG04ZW42VjhQZWV0WEtWRlhRNXhqN1VhWE5qNzgy?=
 =?utf-8?B?KzJEMlVJSnhMWTJYajFWdWYwWERQMEtYTWJWREZnS2tmSzdPSE5qWU9ZVmRr?=
 =?utf-8?B?c1lXMXRHS2RRZTkwcG9RY2FObHpnMWQ4MnJCbmt0b1NHTjQyREVXM3R6MWpI?=
 =?utf-8?B?OE1JUmxWcXk3c1ZuUWRvRFFsT253R3lYaDBZTmlKVmRHNlE3dmdXMm9lVHVz?=
 =?utf-8?B?UkZBditWSFBUbjFKUVJ2Z3VxSi8zV21oWTBtNkFnUWZjQ3RHSS9oWTFaeDBJ?=
 =?utf-8?B?OUFuNENZOXI3UEU4Mk1NK1J4NkorcGo0bmRBTlh5OFZEUlYwR0l5ZFltSjhv?=
 =?utf-8?B?VEhKY2pQU0V1SktHR0NkUFdsQ2E4MHlyWktBNFAvQTlpRW1Pa25MVDZ3VUpS?=
 =?utf-8?B?TG90L2VVT2w4Tld2VW1sbnpNYll5NmlwYTNKNkVxL1dkSWh3eTQzUnNYb3dn?=
 =?utf-8?B?cGtiR3FKdWVTdU44OWZDV0MvcDFkYVVURWRqZ1oxN0NPUklHMlR5b2ZPRDN5?=
 =?utf-8?B?aVZES3EyaVd2ZUYrMWpDZ2NDWmgzYlRUbTdHeUM4RnU1a2kyU2FXNmhRdGlR?=
 =?utf-8?B?RmdDMk9CcTZHa1FibEZMY1d6c1NjK0prSjRTR0NJMUtxeFJmZEFxRmVYSU0y?=
 =?utf-8?B?SmNmR3NjakJiRm5qMlp3VElqYnV1QlRPQmpsNUQwRm1SSTJ6WWRWeFNJM05n?=
 =?utf-8?B?dElrMFJEbU9yMDVmU2FtRzNqa1BtLytvd1g0aHo2RnFsc2FLN0tyR2hLUTdK?=
 =?utf-8?B?N0Zmc05KMTVkRi90MEZrc3NPUCtvZFZPekZQKzRBaFhtRkRzbDJkdTRCUFZS?=
 =?utf-8?B?NXZ1TFZlV3dLKys2aWgrU1FrVFpKMXBOVEgram1RTUxRN2hBazNpV1I0aWVB?=
 =?utf-8?B?eXVWVjNqS1FVamtSU2cxTkNSS2wrcmo3NzVXUHJzRi9LRkpzc0txQ280a1dz?=
 =?utf-8?B?ZmJZQ0lqUHhPVzRTdTdmaTBmSEdpazV6Wm9scFJSOGlzSEFnc1ErY1lQTnUz?=
 =?utf-8?B?RVpjbHdOZW1peURSbU9MMlplbGFYTldsSTdPT1hhVEJFSW5DODJCUDk4d0Q4?=
 =?utf-8?B?TEh5UHdDdFRqbVoyQjh2N2FrT1l3YzdIKzBZV2hpbHV3VXpoNjYvK01EL2Ri?=
 =?utf-8?B?MTZqenArOUg3TCtzazF6bVZvemVBVloxNUt6UVJwc2kySFNYM0tDM2lkNXZx?=
 =?utf-8?B?V2FTTzRPRkxWaDQzeE9JMlMwSS9CTCtxdWMzeDBCM0lkK3NabGwwNmpGNWQv?=
 =?utf-8?B?RzJ1THZwNzJHZzZuVm9pUlQ4b0ZFYnFwNGhMVUVMS2JuQkZjNGluMHBOR3R0?=
 =?utf-8?Q?j8wBadMuGKOKcHGlsitpvQVeL3a3UfCqEK6O7f2?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261693d8-7da9-4cfb-5252-08d97eeaff81
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 23:36:42.5375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlI93ZWHo3np8fdrAHEYT8Z559NmMhowRFviDDDmgNlKEj7RK9a/Oe0u2tDe2/TDXLahoCeBXFfB3MiggO4uRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5674
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

I see that in patchwork this patch is marked as "Changes Requested" [1].
However, I have not received any feedback regarding the changes I need
to make. Please let me know if I have missed anything.

--Sean

[1] http://patchwork.ozlabs.org/project/linux-pwm/patch/20210916180544.2873770-3-sean.anderson@seco.com/

On 9/16/21 2:05 PM, Sean Anderson wrote:
> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> found on Xilinx FPGAs. At the moment clock control is very basic: we
> just enable the clock during probe and pin the frequency. In the future,
> someone could add support for disabling the clock when not in use.
>
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
>
> Changes in v7:
> - Add dependency on OF_ADDRESS
> - Fix period_cycles calculation
> - Fix typo in limitations
>
> Changes in v6:
> - Capitalize error messages
> - Don't disable regmap locking to allow inspection of registers via
>    debugfs
> - Prevent overflow when calculating period_cycles
> - Remove enabled variable from xilinx_pwm_apply
> - Swap order of period_cycle range comparisons
>
> Changes in v5:
> - Allow non-zero #pwm-cells
> - Correctly set duty_cycle in get_state when TLR0=TLR1
> - Elaborate on limitation section
> - Perform some additional checks/rounding in apply_state
> - Remove xlnx,axi-timer-2.0 compatible string
> - Rework duty-cycle and period calculations with feedback from Uwe
> - Switch to regmap to abstract endianness issues
> - Use more verbose error messages
>
> Changes in v4:
> - Don't use volatile in read/write replacements. Some arches have it and
>    some don't.
> - Put common timer properties into their own struct to better reuse
>    code.
> - Remove references to properties which are not good enough for Linux.
>
> Changes in v3:
> - Add clockevent and clocksource support
> - Remove old microblaze driver
> - Rewrite probe to only use a device_node, since timers may need to be
>    initialized before we have proper devices. This does bloat the code a bit
>    since we can no longer rely on helpers such as dev_err_probe. We also
>    cannot rely on device resources being free'd on failure, so we must free
>    them manually.
> - We now access registers through xilinx_timer_(read|write). This allows us
>    to deal with endianness issues, as originally seen in the microblaze
>    driver. CAVEAT EMPTOR: I have not tested this on big-endian!
>
> Changes in v2:
> - Add comment describing device
> - Add comment explaining why we depend on !MICROBLAZE
> - Add dependencies on COMMON_CLK and HAS_IOMEM
> - Cast dividends to u64 to avoid overflow
> - Check for over- and underflow when calculating TLR
> - Check range of xlnx,count-width
> - Don't compile this module by default for arm64
> - Don't set pwmchip.base to -1
> - Ensure the clock is always running when the pwm is registered
> - Remove debugfs file :l
> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
> - Report errors with dev_error_probe
> - Set xilinx_pwm_ops.owner
> - Use NSEC_TO_SEC instead of defining our own
> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
>
>   MAINTAINERS                  |   1 +
>   drivers/clocksource/Makefile |   5 +-
>   drivers/pwm/Kconfig          |  14 ++
>   drivers/pwm/Makefile         |   1 +
>   drivers/pwm/pwm-xilinx.c     | 267 +++++++++++++++++++++++++++++++++++
>   5 files changed, 287 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/pwm/pwm-xilinx.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 683cfc03b71d..328664194e62 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20606,6 +20606,7 @@ XILINX TIMER/PWM DRIVER
>   M:	Sean Anderson <sean.anderson@seco.com>
>   S:	Maintained
>   F:	drivers/clocksource/timer-xilinx*
> +F:	drivers/pwm/pwm-xilinx.c
>   F:	include/clocksource/timer-xilinx.h
>
>   XILINX UARTLITE SERIAL DRIVER
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index a7cba6ef5782..36aa2e5ac1d5 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -88,4 +88,7 @@ obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
>   obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>   obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
>   obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
> -obj-$(CONFIG_XILINX_TIMER)		+= timer-xilinx.o timer-xilinx-common.o
> +obj-$(CONFIG_XILINX_TIMER)		+= timer-xilinx.o
> +ifneq ($(CONFIG_XILINX_TIMER)$(CONFIG_PWM_XILINX),)
> +obj-y					+= timer-xilinx-common.o
> +endif
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index aa29841bbb79..47f25237754f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -638,4 +638,18 @@ config PWM_VT8500
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called pwm-vt8500.
>
> +config PWM_XILINX
> +	tristate "Xilinx AXI Timer PWM support"
> +	depends on OF_ADDRESS
> +	depends on COMMON_CLK
> +	select REGMAP_MMIO
> +	help
> +	  PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
> +	  typically a soft core which may be present in Xilinx FPGAs.
> +	  This device may also be present in Microblaze soft processors.
> +	  If you don't have this IP in your design, choose N.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-xilinx.
> +
>   endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 708840b7fba8..ea785480359b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>   obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>   obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
>   obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
> +obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
> new file mode 100644
> index 000000000000..972cb65c9fe9
> --- /dev/null
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + *
> + * Limitations:
> + * - When changing both duty cycle and period, we may end up with one cycle
> + *   with the old duty cycle and the new period. This is because the counters
> + *   may only be reloaded by first stopping them, or by letting them be
> + *   automatically reloaded at the end of a cycle. If this automatic reload
> + *   happens after we set TLR0 but before we set TLR1 then we will have a
> + *   bad cycle. This could probably be fixed by reading TCR0 just before
> + *   reprogramming, but I think it would add complexity for little gain.
> + * - Cannot produce 100% duty cycle by configuring the TLRs. This might be
> + *   possible by stopping the counters at an appropriate point in the cycle,
> + *   but this is not (yet) implemented.
> + * - Only produces "normal" output.
> + * - Always produces low output if disabled.
> + */
> +
> +#include <clocksource/timer-xilinx.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +/*
> + * The idea here is to capture whether the PWM is actually running (e.g.
> + * because we or the bootloader set it up) and we need to be careful to ensure
> + * we don't cause a glitch. According to the data sheet, to enable the PWM we
> + * need to
> + *
> + * - Set both timers to generate mode (MDT=1)
> + * - Set both timers to PWM mode (PWMA=1)
> + * - Enable the generate out signals (GENT=1)
> + *
> + * In addition,
> + *
> + * - The timer must be running (ENT=1)
> + * - The timer must auto-reload TLR into TCR (ARHT=1)
> + * - We must not be in the process of loading TLR into TCR (LOAD=0)
> + * - Cascade mode must be disabled (CASC=0)
> + *
> + * If any of these differ from usual, then the PWM is either disabled, or is
> + * running in a mode that this driver does not support.
> + */
> +#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
> +#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
> +#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
> +
> +struct xilinx_pwm_device {
> +	struct pwm_chip chip;
> +	struct xilinx_timer_priv priv;
> +};
> +
> +static inline struct xilinx_timer_priv
> +*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
> +{
> +	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
> +}
> +
> +static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
> +{
> +	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) == TCSR_PWM_SET &&
> +		(TCSR_PWM_MASK & tcsr1) == TCSR_PWM_SET;
> +}
> +
> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
> +			    const struct pwm_state *state)
> +{
> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +	u64 period_cycles, duty_cycles;
> +	unsigned long rate;
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	/*
> +	 * To be representable by TLR, cycles must be between 2 and
> +	 * priv->max + 2. To enforce this we can reduce the duty
> +	 * cycle, but we may not increase it.
> +	 */
> +	rate = clk_get_rate(priv->clk);
> +	/* Prevent overflow by clamping to the worst case of rate */
> +	period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
> +	period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
> +	if (period_cycles < 2 || period_cycles - 2 > priv->max)
> +		return -ERANGE;
> +	duty_cycles = mul_u64_u32_div(state->duty_cycle, rate, NSEC_PER_SEC);
> +
> +	/*
> +	 * If we specify 100% duty cycle, we will get 0% instead, so decrease
> +	 * the duty cycle count by one.
> +	 */
> +	if (period_cycles == duty_cycles)
> +		duty_cycles--;
> +
> +	/* Round down to 0% duty cycle for unrepresentable duty cycles */
> +	if (duty_cycles < 2)
> +		duty_cycles = period_cycles;
> +
> +	regmap_read(priv->map, TCSR0, &tcsr0);
> +	regmap_read(priv->map, TCSR1, &tcsr1);
> +	tlr0 = xilinx_timer_tlr_cycles(priv, tcsr0, period_cycles);
> +	tlr1 = xilinx_timer_tlr_cycles(priv, tcsr1, duty_cycles);
> +	regmap_write(priv->map, TLR0, tlr0);
> +	regmap_write(priv->map, TLR1, tlr1);
> +
> +	if (state->enabled) {
> +		/*
> +		 * If the PWM is already running, then the counters will be
> +		 * reloaded at the end of the current cycle.
> +		 */
> +		if (!xilinx_timer_pwm_enabled(tcsr0, tcsr1)) {
> +			/* Load TLR into TCR */
> +			regmap_write(priv->map, TCSR0, tcsr0 | TCSR_LOAD);
> +			regmap_write(priv->map, TCSR1, tcsr1 | TCSR_LOAD);
> +			/* Enable timers all at once with ENALL */
> +			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
> +			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
> +			regmap_write(priv->map, TCSR0, tcsr0);
> +			regmap_write(priv->map, TCSR1, tcsr1);
> +		}
> +	} else {
> +		regmap_write(priv->map, TCSR0, 0);
> +		regmap_write(priv->map, TCSR1, 0);
> +	}
> +
> +	return 0;
> +}
> +
> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
> +				 struct pwm_device *unused,
> +				 struct pwm_state *state)
> +{
> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
> +	u32 tlr0, tlr1, tcsr0, tcsr1;
> +
> +	regmap_read(priv->map, TLR0, &tlr0);
> +	regmap_read(priv->map, TLR1, &tlr1);
> +	regmap_read(priv->map, TCSR0, &tcsr0);
> +	regmap_read(priv->map, TCSR1, &tcsr1);
> +	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
> +	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
> +	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +	state->polarity = PWM_POLARITY_NORMAL;
> +
> +	/* 100% duty cycle results in constant low output */
> +	if (state->period == state->duty_cycle)
> +		state->duty_cycle = 0;
> +}
> +
> +static const struct pwm_ops xilinx_pwm_ops = {
> +	.apply = xilinx_pwm_apply,
> +	.get_state = xilinx_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static const struct regmap_config xilinx_pwm_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.max_register = TCR1,
> +};
> +
> +static int xilinx_timer_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct xilinx_timer_priv *priv;
> +	struct xilinx_pwm_device *pwm;
> +	u32 pwm_cells, one_timer;
> +	void __iomem *regs;
> +
> +	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
> +	if (ret == -EINVAL)
> +		return -ENODEV;
> +	else if (ret)
> +		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
> +
> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, pwm);
> +	priv = &pwm->priv;
> +
> +	regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	priv->map = devm_regmap_init_mmio(dev, regs,
> +					  &xilinx_pwm_regmap_config);
> +	if (IS_ERR(priv->map))
> +		return dev_err_probe(dev, PTR_ERR(priv->map),
> +				     "Could not create regmap\n");
> +
> +	ret = xilinx_timer_common_init(np, priv, &one_timer);
> +	if (ret)
> +		return ret;
> +
> +	if (one_timer)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Two timers required for PWM mode\n");
> +
> +	/*
> +	 * The polarity of the generate outputs must be active high for PWM
> +	 * mode to work. We could determine this from the device tree, but
> +	 * alas, such properties are not allowed to be used.
> +	 */
> +
> +	priv->clk = devm_clk_get(dev, "s_axi_aclk");
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Could not get clock\n");
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Clock enable failed\n");
> +	clk_rate_exclusive_get(priv->clk);
> +
> +	pwm->chip.dev = dev;
> +	pwm->chip.ops = &xilinx_pwm_ops;
> +	pwm->chip.npwm = 1;
> +	ret = pwmchip_add(&pwm->chip);
> +	if (ret) {
> +		clk_rate_exclusive_put(priv->clk);
> +		clk_disable_unprepare(priv->clk);
> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int xilinx_timer_remove(struct platform_device *pdev)
> +{
> +	struct xilinx_pwm_device *pwm = platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&pwm->chip);
> +	clk_rate_exclusive_put(pwm->priv.clk);
> +	clk_disable_unprepare(pwm->priv.clk);
> +	return 0;
> +}
> +
> +static const struct of_device_id xilinx_timer_of_match[] = {
> +	{ .compatible = "xlnx,xps-timer-1.00.a", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, xilinx_timer_of_match);
> +
> +static struct platform_driver xilinx_timer_driver = {
> +	.probe = xilinx_timer_probe,
> +	.remove = xilinx_timer_remove,
> +	.driver = {
> +		.name = "xilinx-timer",
> +		.of_match_table = of_match_ptr(xilinx_timer_of_match),
> +	},
> +};
> +module_platform_driver(xilinx_timer_driver);
> +
> +MODULE_ALIAS("platform:xilinx-timer");
> +MODULE_DESCRIPTION("Xilinx LogiCORE IP AXI Timer driver");
> +MODULE_LICENSE("GPL v2");
>
