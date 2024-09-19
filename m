Return-Path: <linux-pwm+bounces-3290-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F4097C25A
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2024 02:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728331F21ED3
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2024 00:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07628849C;
	Thu, 19 Sep 2024 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KXZh56+c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2089.outbound.protection.outlook.com [40.92.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8EAAD2D;
	Thu, 19 Sep 2024 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726707414; cv=fail; b=p49s6I0si0l+F8/SZ/0JdZTDQhPG9aWxs8mO/6h1C53XuoinP1dEJ7x6Ed5ix8LxURE8QSMpAvPkuuoFs4WPhWUMkEjRfWvCOfnC3epCVO9Y/cdpKKe6dmEFPsDbtFKYhVOz7h2tAMW/TbHVK+UD6FByhMRIR7UNLQRMt9TWU+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726707414; c=relaxed/simple;
	bh=QyOF1+AfPDilW4T1HrCpyJGqWsQJ1IyQRLXgX7XP74M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ewbmS+AEJfFq0wtvNtIsplxQSOG/uZUe4m7FDvMEYSqlTZMtzr7DfOAHoVFDNwhi1MqC9QI5CqSfu21S4tN0IMfVDCZTxZVZE/ErB76mxhfgSLOI+AK9lqNJjPAI9R7htok0MD99kldLnaFnpOIcVB3rHaJZ00BGNGwwE1gwJ1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KXZh56+c; arc=fail smtp.client-ip=40.92.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKJt2mFsENt6GUxQRegnaw7usdt8tHeIjHXOAA+6Eo+zA0NlS488f1Rhy6kO2o3F4dyGGa1UmhFWKeKwmZksFLpyjU7XSF8h0wK4LGeBa/NeVCgAchZYSc+EW6QqF7LLeR67R1Q4jTcCzqrw2uO6EeU5fq1pXgtw2sRAdFfQzubj6EeVDV5j6wcyOL5aEGVdVcUY7u6C5CgcswUL3aT7mZpKWv1Z0bPpBJjFoeGLfWKlw6QgqprCmhOihAoLuZaZIT5xX4V8MCcRpuCXsp8cI6eohmG/KcgI2Vk48fDtCsI7beHez6vkJrhpWbfNRAjmc+kOLaoxuPB+1iWy/E3b2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nldyJwSfEE11io8vtch1j0lP2qDJ4yKW7mqy0MKZFx4=;
 b=FeGE35pCNYltixUtY/VGeGOQAgSYn9IjRFe/EhDO3zqJi5ZCHKsvviZM9wlejHHqTEMHQOAp88E09GY1UuL2j8ypBaLy3zJeX4e8oNFBaFxg/IESsF3Vg4NkHtEpqXht4CtjfiCObpua6BoWVHatznIKtlUVzO9BRp6KgfHvEkDUN4FSi/YbGPHhM0NI1DiZ+KwEtIXcVvxspnQMho5mF8FtA9q6tGHNqm/Pd+T5objeKfCg/ovq0AzmuqfUtoA/xjpb/0zEm1LGgdmhWGNHBR3jf7JtquuV6uuSVDDcvR1W3nOcek1Tfd8+dnih696aiRivFk5/9TQ0E6Qaev0VPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nldyJwSfEE11io8vtch1j0lP2qDJ4yKW7mqy0MKZFx4=;
 b=KXZh56+cmEL5aLZov5izF+ireK8XRPpcr6aP6iWNdV6ESRrIDlxkywJl5qZDlmDAGQE1PQNVEWGAtc9V0prtFV1LBOn8EQ2pFl6wdbRV6VOgihBzRAFIyUl7IDMXyEE/Y1fILk55R3QXtWguqxMgftLEL9pXFffpNEuUcsAWlzT4bvjY8hq6Qam07OIRHuQX8aLeGKxiDkUTXARzMxAbsJMT9iyw4dDWnbLWb+RG4ttTVFGEYrE/KhDaGMHUQLj9M1tphFeO/wSeJJWpam32mvdflX8DuURlQr5ep+aKCR1yzn3/eKV5llriBKzFO0afq6haXvl+hJvkH/Hii3ubhg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB0394.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:56:45 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 00:56:45 +0000
Message-ID:
 <MA0P287MB28229E6C1F4AD0C75B6201BAFE632@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 19 Sep 2024 08:56:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
To: Chen Wang <unicornxw@gmail.com>, ukleinek@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, inochiama@outlook.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 chunzhi.lin@sophgo.com
References: <cover.1725931796.git.unicorn_wang@outlook.com>
 <0f7568620c2ad3d21885e83182c51f4fe9202367.1725931796.git.unicorn_wang@outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <0f7568620c2ad3d21885e83182c51f4fe9202367.1725931796.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <57b0d0aa-8a87-44ff-b38e-28b069de1564@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB0394:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5f069f-d16a-4148-48c6-08dcd845eee5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|5072599009|19110799003|6090799003|461199028|7092599003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	6QE/sKj0Oo9/Ob5ZTQt/p/zUApYvINFQlXUCJttGnkKkArgrrC7+04085H8GSh76qfkfhikgfSp4UAXq+y5JHprCr1N0WQl2ZYoMyThMRlSwI3BqwRg+ZQvCNRnjy4VJzS27CcBn0NuDwXRTtaBB720aE4+9aE7KGHaCZzO6pp9Hws72YRwxZ/jPNiw27clPNz4tVyWZ0Lg1xXyWz8g07Gk9Z5uFwZWsOBBiSSiNJi/ekTSMLoM3giS0x2XGaGdSCD2Bvnx6tEsJIK18ebD/Zqf1FRMTZ00mm7lFOJxMnf6/WZoXILZswzGILNlxAWBlMzg6cizv2K1zS6QZhEY7Cbd2Hx+AshEmr7dHKs6Cxj14fBGAPEeX/RMWbpNdO8AmVTOV2bwi9lrsdmNd/IiApujANRt983xHwfhitJJduSKZXlHfsjDw11LKRqZtvXTVas/f++8Nbst8Tm2ObGE0fwiNZaQefOZmqSO7VG1kL0KGuPP6oZbtb5DySobyrQpWQmCeyjzRGj+gxv/uKaHvWBc3UvmrphLYMjC0RWzBINVW+vb5hDeQQFOnRsE3JAu8Ras7gkYXncEcRIWooTYWrlvP2MI2CNU6CFJFJxJIxSdiqabueZ/P4Wcd80afrkciSZbzJ3iSqc3UTGkio+jwDtu/rlMYTrQWKyrfGh9sAvoQ9MBWGnlWiQ8pMG41w06pebVmoeFJOUbqNFdHGy9X89VG0OaltTqt74TM2b4Dy7Qp5bj7HarJaEr8CAU3Xk/fKHFxrtuW7kTv/FPwRM5ZPQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGFXUFJpcEpZV01TNk9JbHBXSVlXTWVsQlpnbitLaUgvMW1vc0x0a3F0U2pn?=
 =?utf-8?B?bWdNRlBDaWs1b3g2c1VGK2liSnZWZ0k2dldLbzdJSjVWV003elJQTitsempT?=
 =?utf-8?B?SkZSQVZrOW5tZWNFYTZmdzRWb21qa05RNC9pSW9MY3pHWmpHak5Sc3ZiN2Fo?=
 =?utf-8?B?SUl5NTJyZU01Y283UVQ2YmZIWDBwYVBxbk5rVkYzQnZJUjYyRVlMYnRpV2t0?=
 =?utf-8?B?NEpOZmxGeHpKWS9ZRUVlSVJrWWNRV3JXQ2x4TVJnYksvdTZROXdLYWN6K2p6?=
 =?utf-8?B?YU50Zi9PVnNEeTZma3E5OG4zMEU5V1NoblVhMTFsUEs3VjdNQ09GdUFBdWNI?=
 =?utf-8?B?KzBwNUhJTWRGRWNLSWtIWTlJNUVEWDV5ZTB0RGRNRFhnY1BzYXI3S0doczVE?=
 =?utf-8?B?NGFYTFJ1TDJ1T3dvZ21CRUNGYW1xWXcyb1ZjQ01qTmhBMlZkTkJscDVjZ1dG?=
 =?utf-8?B?L0JIaVhvTDVJQUpSR2JtbUJrZm1KWXJqaXY1VUhtYnBCcXhFajlPc0JLdTBs?=
 =?utf-8?B?ZnZWenBJbzJYdUdaMVdKcVRRNzhPL0lsajhSa085a2FKZ3E5ZHprVTA1dFVy?=
 =?utf-8?B?QWFxRUFHVXlEdmNua1VjVjkrekxZUDlsU0pTS2ZEaWpCVGgwMG01U2Y3OXZh?=
 =?utf-8?B?Yng5aXllSHFUNisxMkJhdVVKNExKb3RpaG9DbGVnTVk4a3pNN0Y4WGlnK2V5?=
 =?utf-8?B?MGd5cWFtaU8zWWRoU0tUY3F6YXROZ2JKZUF4bldtYkI0d2VMNjJ2QThnb2hD?=
 =?utf-8?B?ZUdsaXVtWVMzUlNtZjgySGtUeE9XQ2lGVnQrY2k5b3kya2R6TWQ2UHhoeDR0?=
 =?utf-8?B?ckFRNDBBaDROTnBGMDRWU2ZZOHhOc3ZFd1lGVlJ4T2lPbUlJYkYvZ3ExNmhR?=
 =?utf-8?B?VGt5VlkrN2JiY0xZcVpBb3JQZkZlNDgvTDVVN3NqNENudXdSYnNkYUgyY2RR?=
 =?utf-8?B?SFRYV3hJY2hsa2pndEFpZHZ1elNaN2FiODQrQlZaNTk0UndPTVFicW8xajdl?=
 =?utf-8?B?MDV5VkxObllybk10b3YvNUtZL2dvWFg5ai9RRFZIdjZvUE1ZbG1PSHVnQnlt?=
 =?utf-8?B?OEtLdVdWQ0FLeE5vSkZybnMxVXptV21kTy9OMmxwRWpCM2gwSCs4WVYzMlk3?=
 =?utf-8?B?U3E2YlZSaURkVmxQUDNTOTI5Q3NROVRjUGlKZDJWZUZTWjFkNHJUaDRWcFRq?=
 =?utf-8?B?M0lNd0lGWFZXYjVsVjl5QzJ4R3RabXdCdHBmRU8xd1krNFYrTWIxYlRPMll5?=
 =?utf-8?B?Unc5eXg3MUtRY2EvdDhJTytXUDZXYTFpZStLdHRlcHRxMFF1c3g4T0ZheVNv?=
 =?utf-8?B?ZWJ2NmNWTmtYVFBrU0w2QktWTEIzK1lqbGRodktmaThVOHRPTkpxWWJmd0xr?=
 =?utf-8?B?c3NqZitCU1l2dkRvMUNMS2dOQ0JtSFgzaVpDeEdZdzM4NEIyeHlSS2x4ejB5?=
 =?utf-8?B?UTdnZDhQbHdQRGFET0dGR0d4MlgxcURkL2dwOXdKVWFXbEt0T1k2WkR4blZl?=
 =?utf-8?B?TW1xWmxsVjFIVWlURGtXRnFONWtvQi9BMWVPUFhueVBpczhNa0R0QW5JcSs1?=
 =?utf-8?B?UW4vRDJBbjVNYTVSakczZXo3cDBidGNnNXlTbVdkRnN1WlEzMlllLzU0WTBJ?=
 =?utf-8?B?OS8zL2ZZQXgwUit3R216SWExMzZCbUtwdnpKOGxtRk84dW9iRE1sMmY0TSs3?=
 =?utf-8?Q?aR3jt7pQAnnK4yZ8g4YD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5f069f-d16a-4148-48c6-08dcd845eee5
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:56:45.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0394

Ping ~

hi, Uwe,

Can you please review and comment?

Thanks,

Chen

On 2024/9/10 10:08, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> Add a PWM driver for PWM controller in Sophgo SG2042 SoC.
>
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   drivers/pwm/Kconfig             |  10 ++
>   drivers/pwm/Makefile            |   1 +
>   drivers/pwm/pwm-sophgo-sg2042.c | 180 ++++++++++++++++++++++++++++++++
>   3 files changed, 191 insertions(+)
>   create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 3e53838990f5..de8a36ecabbb 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -577,6 +577,16 @@ config PWM_SL28CPLD
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called pwm-sl28cpld.
>   
> +config PWM_SOPHGO_SG2042
> +	tristate "Sophgo SG2042 PWM support"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  PWM driver for the PWM controller on Sophgo SG2042 SoC. The PWM
> +	  controller supports outputing 4 channels of PWM waveforms.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm_sophgo_sg2042.
> +
>   config PWM_SPEAR
>   	tristate "STMicroelectronics SPEAr PWM support"
>   	depends on PLAT_SPEAR || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0be4f3e6dd43..ef2555e83183 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
>   obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>   obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>   obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
> +obj-$(CONFIG_PWM_SOPHGO_SG2042)	+= pwm-sophgo-sg2042.o
>   obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>   obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
>   obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
> new file mode 100644
> index 000000000000..198019b751ad
> --- /dev/null
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sophgo SG2042 PWM Controller Driver
> + *
> + * Copyright (C) 2024 Sophgo Technology Inc.
> + * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
> + *
> + * Limitations:
> + * - After reset, the output of the PWM channel is always high.
> + *   The value of HLPERIOD/PERIOD is 0.
> + * - When HLPERIOD or PERIOD is reconfigured, PWM will start to
> + *   output waveforms with the new configuration after completing
> + *   the running period.
> + * - When PERIOD and HLPERIOD is set to 0, the PWM wave output will
> + *   be stopped and the output is pulled to high.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#include <asm/div64.h>
> +
> +/*
> + * Offset RegisterName
> + * 0x0000 HLPERIOD0
> + * 0x0004 PERIOD0
> + * 0x0008 HLPERIOD1
> + * 0x000C PERIOD1
> + * 0x0010 HLPERIOD2
> + * 0x0014 PERIOD2
> + * 0x0018 HLPERIOD3
> + * 0x001C PERIOD3
> + * Four groups and every group is composed of HLPERIOD & PERIOD
> + */
> +#define SG2042_HLPERIOD(chan) ((chan) * 8 + 0)
> +#define SG2042_PERIOD(chan) ((chan) * 8 + 4)
> +
> +#define SG2042_PWM_CHANNELNUM	4
> +
> +/**
> + * struct sg2042_pwm_ddata - private driver data
> + * @base:		base address of mapped PWM registers
> + * @clk_rate_hz:	rate of base clock in HZ
> + */
> +struct sg2042_pwm_ddata {
> +	void __iomem *base;
> +	unsigned long clk_rate_hz;
> +};
> +
> +static void pwm_sg2042_config(void __iomem *base, unsigned int chan, u32 period, u32 hlperiod)
> +{
> +	writel(period, base + SG2042_PERIOD(chan));
> +	writel(hlperiod, base + SG2042_HLPERIOD(chan));
> +}
> +
> +static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
> +	u32 hlperiod;
> +	u32 period;
> +
> +	if (state->polarity == PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		pwm_sg2042_config(ddata->base, pwm->hwpwm, 0, 0);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Period of High level (duty_cycle) = HLPERIOD x Period_clk
> +	 * Period of One Cycle (period) = PERIOD x Period_clk
> +	 */
> +	period = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->period, NSEC_PER_SEC), U32_MAX);
> +	hlperiod = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->duty_cycle, NSEC_PER_SEC), U32_MAX);
> +
> +	if (hlperiod > period) {
> +		dev_err(pwmchip_parent(chip), "period < hlperiod, failed to apply current setting\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(pwmchip_parent(chip), "chan[%u]: period=%u, hlperiod=%u\n",
> +		pwm->hwpwm, period, hlperiod);
> +
> +	pwm_sg2042_config(ddata->base, pwm->hwpwm, period, hlperiod);
> +
> +	return 0;
> +}
> +
> +static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
> +	unsigned int chan = pwm->hwpwm;
> +	u32 hlperiod;
> +	u32 period;
> +
> +	period = readl(ddata->base + SG2042_PERIOD(chan));
> +	hlperiod = readl(ddata->base + SG2042_HLPERIOD(chan));
> +
> +	if (!period && !hlperiod)
> +		state->enabled = false;
> +	else
> +		state->enabled = true;
> +
> +	state->period = DIV_ROUND_UP_ULL((u64)period * NSEC_PER_SEC, ddata->clk_rate_hz);
> +	state->duty_cycle = DIV_ROUND_UP_ULL((u64)hlperiod * NSEC_PER_SEC, ddata->clk_rate_hz);
> +
> +	state->polarity = PWM_POLARITY_NORMAL;
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops pwm_sg2042_ops = {
> +	.apply = pwm_sg2042_apply,
> +	.get_state = pwm_sg2042_get_state,
> +};
> +
> +static const struct of_device_id sg2042_pwm_ids[] = {
> +	{ .compatible = "sophgo,sg2042-pwm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
> +
> +static int pwm_sg2042_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sg2042_pwm_ddata *ddata;
> +	struct pwm_chip *chip;
> +	struct clk *clk;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(dev, SG2042_PWM_CHANNELNUM, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	ddata = pwmchip_get_drvdata(chip);
> +
> +	ddata->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->base))
> +		return PTR_ERR(ddata->base);
> +
> +	clk = devm_clk_get_enabled(dev, "apb");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get base clk\n");
> +
> +	ret = devm_clk_rate_exclusive_get(dev, clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
> +
> +	ddata->clk_rate_hz = clk_get_rate(clk);
> +	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
> +
> +	chip->ops = &pwm_sg2042_ops;
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver pwm_sg2042_driver = {
> +	.driver	= {
> +		.name = "sg2042-pwm",
> +		.of_match_table = sg2042_pwm_ids,
> +	},
> +	.probe = pwm_sg2042_probe,
> +};
> +module_platform_driver(pwm_sg2042_driver);
> +
> +MODULE_AUTHOR("Chen Wang");
> +MODULE_DESCRIPTION("Sophgo SG2042 PWM driver");
> +MODULE_LICENSE("GPL");

