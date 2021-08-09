Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA023E47E9
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Aug 2021 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhHIOtJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Aug 2021 10:49:09 -0400
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:20101
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230490AbhHIOtJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 9 Aug 2021 10:49:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1/D0bOP8d2G//IqjCAWLlEZj7CsOy2NVqMtAkkSrEIGRbgYXfM1cAbLCH3w7nPFnXywqfwpv4GQ2lonnxzbulj+Yetj5sFUfiVOHkp6eLprWdNWc3a98wBaoUzkO9SrfZp6Xkf9MN+2I2YJV2MkmkmCPJp5hWBYRGJU3qDi0K2NvJs8z+Bf9TS3BNjCa+CUYn3YImSd/GWXqAcOkWGLQnx60g9FuDI6GQsQNDbGhRshqw/XXuFl+LlUBqlU01Tu+M8NYxWLT9h0UQupdy44dJx5H0yYiJq0p1hlf4r6ip1zLVhRd28B24hH2prM+uAFQ2m/kyCPxLZqeMr8sGbjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh0XwOIO8LcthH/ndP5W7bZxtI/89TvUF1t88Kd7z0w=;
 b=RbVt6BVfzbfh9sd+fJGE0dNSpX/WTNlZEYSNwwi4J3b2FsmIcLXPeWgOXV6BnId+kKCWtekRcAeCTwOf+NZJbbuLk0Wwu8e5j9vZjWSmILA6GWPnJA5Gnfy2S3UIR9+5tY2LDGik/Fol3+BtJD498bqqCuEj21C33VX3yrV/7Dw9MGlQIq7XJOSHbRpJKi4J+iB1Cxw1d1GVXMpNhnc0qvpSY8+uQ/SSztsM0FscLK+Nwd7kJ7iltvXSAbPLknzI1ZDgOA8h47nistPIyTtNJ5F4cfrZJGoobbGobRqM5Jt6qyUk+0UGDKfvlvlWdFVpvtdLMMikdJojp/KCGFSRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jh0XwOIO8LcthH/ndP5W7bZxtI/89TvUF1t88Kd7z0w=;
 b=mts80IH7PC0bMS4gOB8m2ficxSOl3EJvDpWLDS9whzDjz8I52opezaagovmbfhDEEfSCtxOrUkzY49d8PdvkUY/mA+PBRVL1xWPH9xTkbA6T7nITjO8GcTLhoHExkwgJjAPHY6X7cU76OaVCSIvI7OjcQIBxpPa/iiuUamcs5X8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5368.eurprd03.prod.outlook.com (2603:10a6:10:d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 14:48:45 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 14:48:44 +0000
Subject: Re: [PATCH v5 3/3] pwm: Add support for Xilinx AXI Timer
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210719221322.3723009-1-sean.anderson@seco.com>
 <20210719221322.3723009-3-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <cf3cfa4c-a519-1413-1e7b-649b07de844a@seco.com>
Date:   Mon, 9 Aug 2021 10:48:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210719221322.3723009-3-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:208:257::29) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0054.namprd13.prod.outlook.com (2603:10b6:208:257::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.9 via Frontend Transport; Mon, 9 Aug 2021 14:48:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff50546e-f586-44d0-55d3-08d95b44c979
X-MS-TrafficTypeDiagnostic: DBBPR03MB5368:
X-Microsoft-Antispam-PRVS: <DBBPR03MB536882E8CC22179F5A84C24396F69@DBBPR03MB5368.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKoLe38j6/GVjshVKOAJWTNAiqQopuyDL53nNU2gi7H05ONe+YbhKhY22lekQtTP3eOoK+lq39lQORxP1T1pQJppPy1xHprYCS13ndD6vds4VKyhtKEj20APa3xv+bfK0Hv2RRfUfiIJcL2+UWH4cJzrI8fDD1W5homPNjTtRmReG5BrJeUBALL8v2HaCljrZiLFPaRjBH7t965Shaw50yukA8i/zYPc2ZkI8AR7rswtTbn9bUoG3gx6qc63/H2fSSQeO7fmGVC3VLCpRn4BRS9GQ6oYN/Kt1GgcqMo5DgBFTLvBmOq2anmycL+lhR7jUTyjIutoDLB7Og13f1w6GpCFLHp0zg0kh81OSL9M/d9IuO+YmOsD3e0WlbArWTmQZl8ZH9h5Pxhc5StsHgcvAAukKViMPQt56JcwGw8V0KS+kUIgbSxLILCwpz7DSraYVC/ep8bexGMx6P7vUlbSK3yCXeXEKe27UYu+3fmgFYIOVBCd7QkzScmYvLEsafwdKTFFTO9i4gybOMWkK+QcCn4xe5CGTwbR/9YUQdr7mMBZ+gctzXBVGWqWRLDRTTVctBwwkd6dPdLYK34hAO0wY9NDqBcuO27cYRQzCKrJGEZ71ou3yEZ7fpDSeQqwe0vGiXcnVBu/ATfTELJQEsAZ5uOELLnSaOkwHTVTNznErDyadu6hMRFvUQr8YdITTYr/XwFqWZjX8hE4UMVvnRRUmKJO4zjkfTGECmhtFVVgboSbIHNSS4z7RaZhBwW4+JPjnsNZr1aHeDOJUJt1DP4+/IWvVz+ufmGXUuhnwYaaJu4t/+aYsvxZX0F2AtLJGBjrpVMvlzcbstC4VvVOKTH902FmWZoYT1gI3UpbmFYsKMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(956004)(52116002)(8676002)(53546011)(8936002)(30864003)(44832011)(6486002)(2616005)(54906003)(38350700002)(316002)(38100700002)(16576012)(66946007)(5660300002)(66476007)(4326008)(66556008)(966005)(83380400001)(36756003)(26005)(86362001)(186003)(31696002)(2906002)(6916009)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1FGSE4rQm1nazZUZTJ2cXhYdzYrNHIwWnFROVRjQmxjWVVkYUZ1ZlJBNHZR?=
 =?utf-8?B?bGRBcTdORHNRR3NiR1pkc2MyME5sU1RVK1NyQXNGY3NveDFySzJyQm5KU0tm?=
 =?utf-8?B?M3NjRFl4ZHJLS01mS0RmbmxLM2thZVRwamFJak02MDFmd0FuN28xT0F6RWhC?=
 =?utf-8?B?aG00Q2tkNzZGbkhXZnIzdVVpUmpZWWJkSWR5WEtYQ1VLNW1qYUhHRnpTYmJ1?=
 =?utf-8?B?Q3lDa0dwOU8xcnMzV1FGRlJ6OFgycVZ5Q2tSWnJaU1Q0c0JoQy9HcXR2VTR2?=
 =?utf-8?B?ZWUzNE9GbHczbCtNMzJkSmgvZ2xtOW9sRGRweGtValdhYVYxUXFndWlNZXBJ?=
 =?utf-8?B?RlZ3QnQ4SGNaTng3UTJqcHlmb3BVaFE1N29wSGpDTVhheTdvdnM5em9FTlBL?=
 =?utf-8?B?eU9hQ29Vb0x1L3lPL2dXQ2NzMjVYSG81TkR2M01CRHNmV1lvUjJsYjJ4UGlR?=
 =?utf-8?B?UkNpRlBSZHJYd0FsQUZxRVBJTWpYcHpUQ3NwTWFZU3RzbDA0cm4vVXNqdkM1?=
 =?utf-8?B?b1Uybm1hZDBPenBiaHcvTkNScDh4TWthTjVtVjFBcVVqTXQrSEhEblh3dlVS?=
 =?utf-8?B?QnBOUDlVOVBUcnRhWDZCVjAyVFcwdDFZVm1TR3BVV0VuTXBjUU9MZHJJZGlX?=
 =?utf-8?B?NEMzbUk4M2JJR2pTSEVIRVp2TW5vQmk1UFR6SkFZeDNOYWdOdzdRdko4Tktw?=
 =?utf-8?B?Mm9kV29nNEp3TCtydURpanZmN1dDYVk1L0pSazVkTU1hbmx1YUd4OWpOaU5v?=
 =?utf-8?B?eUo1clJtSmxjMmNzM0dEbjBZbUFHb1kvNFVIRnBGYVRwaE0wQm1wOUE5bHJt?=
 =?utf-8?B?REN4TEM1L05YV0ErelljU0xrUUlkR09rYjg1MmQxOWJUQUxuSzBrRFpsNXZh?=
 =?utf-8?B?anFEZjJ2RWNoRUhvdWZzSWVMUkk0OFY3Z1lyaVBKYnozaENrN3B4RHVHbklP?=
 =?utf-8?B?RlZCWXhTUXhUMWozWlhvdjZEc1BmenlEcmh5ZzArZ1pnaUxxYk90cWFGN1Vn?=
 =?utf-8?B?cldZYVlsd0FTOEF1VUE3bkwxNldMYTYvWHovV0NGcHQwZTF1UW9ZUjQ5blhT?=
 =?utf-8?B?SGM2bFdseTFGSFFmRUZqS1FZN2kweC94enMyZkpPbEFPemRYdS9FWFNaTkRy?=
 =?utf-8?B?UE5MYWJGOXRjSUhZbUFzK0haQU9lTDhsNmNQR3BOaE1sQWw1dGVtYWJBY3Ft?=
 =?utf-8?B?WUVyVFVjN081Vmc4YUU3M2hkZGhxNzNlQ3NFU29ndXBVRnRGdW9tWjZtaW1u?=
 =?utf-8?B?RXBoU2dWR1pjRFA2UnAzOEFlU05xVUFVVnFjR0lPZGZycVJsZkt4akdsMjBD?=
 =?utf-8?B?OWdmVGNFMklBeHBiT0l5L2VZRGJucVlzZndYWHN6UGJGdm8vR3psTGs3S1Ex?=
 =?utf-8?B?Q2RFVXZhZzVESDVmRkZCNzZkMlVhQ3dPdS9Dam5oSGRNQzFtS2hrbkNQU1ZC?=
 =?utf-8?B?VlBoMkE5ZXY1aUFtM2J0bFlnRmVWSWFRSUJaclA5eDZMNFk3UmoxNVo0RmVK?=
 =?utf-8?B?aURFU3FEd3RLYWFVbEhKbkpGRXpHSi9YOFhHWUx3Tk9JcmwzZnA1UUhKMTh0?=
 =?utf-8?B?NlY4Mmg2MzYxYnRpWFVwUklTRllyTW9rWExGUXIwbTlVVlpWdmN3d3dNdTBK?=
 =?utf-8?B?bTNlT1NxeGkyUkRRYUVhMVpBd0s4V3JZTytBWEUrazhweitpTnE5U3dya0g2?=
 =?utf-8?B?bUsvL1QxOWVna205aldJeFZZV3VyOHlNUGUrMER2VnZHWDlUaWNSTGVoN3I1?=
 =?utf-8?Q?/Peoy8I7CYAos2Y7RL6reQhflzsrlDTbPunHSO2?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff50546e-f586-44d0-55d3-08d95b44c979
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 14:48:44.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Byc11De3frJkX+5H88QFpbBMOAjLCg85TeGIrmkZTzEPrbNEJzApVNVsgt4nwSjMYOyOuqN2q2Ebl7ckrlpavQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5368
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

ping?

On 7/19/21 6:13 PM, Sean Anderson wrote:
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
> Uwe, I know we haven't finished our discussion on the previous series
> wrt what checks/rounding apply_state should do, but I want to get some
> feedback on the other changes I've made to this series in the meantime.
> 
> Changes in v5:
> - Elaborate on limitation section
> - Rework duty-cycle and period calculations with feedback from Uwe
> - Use more verbose error messages
> - Allow non-zero #pwm-cells
> - Remove xlnx,axi-timer-2.0 compatible string
> - Correctly set duty_cycle in get_state when TLR0=TLR1
> - Perform some additional checks/rounding in apply_state
> - Switch to regmap to abstract endianness issues
> 
> Changes in v4:
> - Remove references to properties which are not good enough for Linux.
> - Don't use volatile in read/write replacements. Some arches have it and
>    some don't.
> - Put common timer properties into their own struct to better reuse
>    code.
> 
> Changes in v3:
> - Add clockevent and clocksource support
> - Rewrite probe to only use a device_node, since timers may need to be
>    initialized before we have proper devices. This does bloat the code a bit
>    since we can no longer rely on helpers such as dev_err_probe. We also
>    cannot rely on device resources being free'd on failure, so we must free
>    them manually.
> - We now access registers through xilinx_timer_(read|write). This allows us
>    to deal with endianness issues, as originally seen in the microblaze
>    driver. CAVEAT EMPTOR: I have not tested this on big-endian!
> - Remove old microblaze driver
> 
> Changes in v2:
> - Don't compile this module by default for arm64
> - Add dependencies on COMMON_CLK and HAS_IOMEM
> - Add comment explaining why we depend on !MICROBLAZE
> - Add comment describing device
> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
> - Use NSEC_TO_SEC instead of defining our own
> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
> - Cast dividends to u64 to avoid overflow
> - Check for over- and underflow when calculating TLR
> - Set xilinx_pwm_ops.owner
> - Don't set pwmchip.base to -1
> - Check range of xlnx,count-width
> - Ensure the clock is always running when the pwm is registered
> - Remove debugfs file :l
> - Report errors with dev_error_probe
> 
>   MAINTAINERS                  |   1 +
>   drivers/clocksource/Makefile |   5 +-
>   drivers/pwm/Kconfig          |  13 ++
>   drivers/pwm/Makefile         |   1 +
>   drivers/pwm/pwm-xilinx.c     | 268 +++++++++++++++++++++++++++++++++++
>   5 files changed, 287 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/pwm/pwm-xilinx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 252d71addd18..6adafd3e7a09 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20050,6 +20050,7 @@ XILINX TIMER/PWM DRIVER
>   M:	Sean Anderson <sean.anderson@seco.com>
>   S:	Maintained
>   F:	drivers/clocksource/timer-xilinx*
> +F:	drivers/pwm/pwm-xilinx.c
>   F:	include/clocksource/timer-xilinx.h
>   
>   XILINX UARTLITE SERIAL DRIVER
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index a7cba6ef5782..dcf434fdb726 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -88,4 +88,7 @@ obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
>   obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
>   obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
>   obj-$(CONFIG_MICROCHIP_PIT64B)		+= timer-microchip-pit64b.o
> -obj-$(CONFIG_XILINX_TIMER)		+= timer-xilinx.o timer-xilinx-common.o
> +obj-$(CONFIG_XILINX_TIMER)		+= timer-xilinx.o
> +ifneq ($(CONFIG_XILINX_TIMER$)(CONFIG_PWM_XILINX),)
> +obj-y					+= timer-xilinx-common.o
> +endif
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c76adedd58c9..974774b7c987 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -637,4 +637,17 @@ config PWM_VT8500
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called pwm-vt8500.
>   
> +config PWM_XILINX
> +	tristate "Xilinx AXI Timer PWM support"
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
> index 000000000000..291577be992f
> --- /dev/null
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + *
> + * Limitations:
> + * - When changing both duty cycle and period, we may end up with one cycle
> + *   with the old duty cycle and the new period. This is because the counters
> + *   may only be reloaded by first stopping them, or by letting them be
> + *   automatically reloaded at the end of a cycle. If this automatic reload
> + *   happens after we set TLR0 but before we set TLR1 then we will will have a
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
> +	bool enabled;
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
> +	period_cycles = mul_u64_u32_div(state->period, rate, NSEC_PER_SEC);
> +	if (period_cycles - 2 > priv->max || period_cycles < 2)
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
> +	enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> +	if (state->enabled) {
> +		/*
> +		 * If the PWM is already running, then the counters will be
> +		 * reloaded at the end of the current cycle.
> +		 */
> +		if (!enabled) {
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
> +	.disable_locking = true, /* The PWM subsystem handles locking */
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
> +				     "could not create regmap\n");
> +
> +	ret = xilinx_timer_common_init(np, priv, &one_timer);
> +	if (ret)
> +		return ret;
> +
> +	if (one_timer)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "two timers required for PWM mode\n");
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
> +				     "could not get clock\n");
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "clock enable failed\n");
> +	clk_rate_exclusive_get(priv->clk);
> +
> +	pwm->chip.dev = dev;
> +	pwm->chip.ops = &xilinx_pwm_ops;
> +	pwm->chip.npwm = 1;
> +	ret = pwmchip_add(&pwm->chip);
> +	if (ret) {
> +		clk_rate_exclusive_put(priv->clk);
> +		clk_disable_unprepare(priv->clk);
> +		return dev_err_probe(dev, ret, "could not register pwm chip\n");
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
