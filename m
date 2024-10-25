Return-Path: <linux-pwm+bounces-3866-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9DA9AFC42
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD02D1C20399
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C691BCA0E;
	Fri, 25 Oct 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="njn38wvm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2046.outbound.protection.outlook.com [40.92.103.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00739170A1C;
	Fri, 25 Oct 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843995; cv=fail; b=csdd8wJoOGaT6wxh5rV1OYCKcZMNA1aTtP56Jn7i8bgOJPg98fNvij+f0vqrUy3Hf+XA0dtpgNKsVLQXs4Ejtvqs7xxo4Di3l4Wg7R102j6vSlPp7sdbqKNwILWyCXpXY2djt0QNf1L3qco+4YZxL59fshVZrFb3CyOMvSUZD6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843995; c=relaxed/simple;
	bh=E2b8Gmczmf2MNV4Tt8TUoHEoHkNFTarWcKbtYqO/rXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BWS3oBt1gtc4IIsdRiB9b7AjnT8yfJlWpZWaKdSxTF5E+GuEpciJxvReBf0LeIVXJ5l4cQ0L/JWg3xI+P7hHoEQIhrwWVF0TSG4cwmVPDYt9ZHGVgVX3aK3klT12gt2BjpoKdTSvKoQCoqRYl09xdwHnJlFnFH+/bOOLnCO84Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=njn38wvm; arc=fail smtp.client-ip=40.92.103.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQ1/2AxTfW3W3adS329j4JhKQAXMDPknf8QzJXS7DcMBHEGOypI0dVE+vkEUZANTPNh/TOqJTXFUF07Z5OLMFnfpbN0j0gc8GoDInRsnLCuJy/KKgnWyt0m8ATTe+ted5oNdLxDtbvS/pe3hgNm5rBkRC15iEVQl3k5G+N11Qh7e2xwImiiaO6lYUq26NYm2KzfraL/Jr/REhaFllqzdrCLosIvIS0tSzZovdsNp8VKihu5hNC50k5C2+18TvnCZsfUQcVCt/cpPA1+acEowzr/x0JTb/cTrmr6PzDZIyTwy6WDv0fDYHq+rJkjQ61RIWTgDEhXjIbUGjPhzvIejCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ecwvGMEL3/6e4MMFJv9eE9qOpOm+Y2AZIS11nN3DEA=;
 b=RjZ+vRfDc21Zq0UK1zuL61r4FeQn8pUJlghK1mD6xBzO99pg/PGS6HTcZ6oj8RkJ/Z5GIyzJ/zllECLgS2WrHOxJov9nw2XgSozmZ8ngVmHHB26384maAswpPla+24ARmqXCXDvA1sZ0Es13UY57Vgu2xb3QbelbbwaGp71hEgtNXkP5hsuL/Q1k1z6yfNB9JBWZOMxXI7++wFAn1rGA1pGL408xWBzx6zr91Wd5+i6mKEWMjh22Iolve2nXFvgu/zHCMqb063Fqwgohdflbb+5Fl5v0VfmjMFu46H678PopW2E/pEbOwG7ynN/ZdEhJfngSCpXCMj+Thi5WkoRg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ecwvGMEL3/6e4MMFJv9eE9qOpOm+Y2AZIS11nN3DEA=;
 b=njn38wvmDCAQISiMON+57A2t3ksc+3jJ+TXLSf6BNsxUJ4QvO6OdxH7J1oN3NbwRL43h5ouLTZO4M+MfyRHxRa75hE+SDuI3qmchiKfWAVobZN++PYGUSgwJ04FfEzfKJJ6//RIkCCFUUTQSj4qWftY/1F4EgJQgz3uiafwu/QAvAYuPzBRcXMHCUoQan//F5/9cvfnw/SLrC90IH2QJZfoBNAyuvP7Mh7nsj8XBcvuSAx7xvVXhrRH25D5hAVcGFdv2Hr0z/0O72WANCTy8XgCu2IJWmIEkaHyP3tQQnxPtzL7vWU04RVGwYrmmEjpQ1LA0fipIPPkTa3PPlUuq7g==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB0337.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:13:05 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:13:05 +0000
Message-ID:
 <MA0P287MB28222636F2331748170B6F16FE4F2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 25 Oct 2024 16:13:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
To: Sean Young <sean@mess.org>
Cc: Chen Wang <unicornxw@gmail.com>, ukleinek@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, inochiama@outlook.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 chunzhi.lin@sophgo.com
References: <cover.1729843087.git.unicorn_wang@outlook.com>
 <4abe3cd4a870fc15b5e54a48eb4554a7419a4ef8.1729843087.git.unicorn_wang@outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <4abe3cd4a870fc15b5e54a48eb4554a7419a4ef8.1729843087.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <b2930b21-319d-4e92-996f-23e8222cfdb1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB0337:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fad2497-e590-4296-261b-08dcf4ccda6a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|461199028|19110799003|8060799006|7092599003|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	iqwXcWlM9zwOz9XxiV/qADmk8cPmVQrmiHlnWofoVDmQRRF6KZkR1FXLFfm2wRRVGd+PrvUbENd5yjzpjiA/kkVH+roLk1lhWqtkdxGYLLPmkkgcsV83D7TqUuKPO7G1CnVk4siK2KpL/hYTvWsrUEaJ5q0KhM1EvFsFSUPzAjaigHIq67P05EJqGK1n6dgnFM7wC42lgKSLGYmJSJH5WycTI91+lSKxeiKRMyJqhSuedM4CZvN8FYbSucAz30HVZuSBVtEAsLB8VrKM1waFqv2XjCLiVlqoX/92knVx3SOYnA+3wYFveJoRVy+p19LJEzkvK4Qj5quDHLfYofo1SQP039HbPcq9zczuHRfrpI0Jx87K08oh5GG/LvHjfT+UCzq8qH/4qZfPoiq82Zw3X0uukjaD0HKlwu9PF8Kn7M+X2K8PPb02UMSlm5QQjX3QPsQQgoBKG+E3D2X9OfyJpMjVnnViLKG8NqwuRZBlrpsf0fM00pZ3JSk0ERTS69fi9seCOeiHUp7o9YKiuvSpoI6ZuifxawwlnUtafqyvdOgP6YFMMAwyUHyJ6a+abyN9opI2Uy6UOp5mzhq6ai1wGcXkG+upUBJIAh8bQMVVhCaXRJkU/EV18brOq4CJVSjP2r04atOgBTTvWdtZHLShAFJhMRuHb+6Rz+Ggd3HDqRL41LMWFdvqivZ1tjw1aLM9DHZ+n1/sNHxMzFwlWbeNjYlbMGEdM66yruI/ewS323SGxob76TGde5rc/WcAzpcp0xQDHdBnlMpLNrVYMIxf0g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnhUenZLQmdxVzNpaHN4enlFdXdYRmVPNlJ5aWZLd3pOck9qQlVoVU9vbXVk?=
 =?utf-8?B?Zll5bEZ3QUlwRk1iR21BOUF4QWVCNkpUWTRaQVZ0WXlNZnN2RWRNdVZld29V?=
 =?utf-8?B?OC9xVWRyR21TS2FHYWNXOGE2NGdzemxIeHN3QnRTL3VQRDZJQStmYUl3VDZs?=
 =?utf-8?B?Ync3U281aVFPaHVIUG8zVnk3WExTcWNlN3FvV0pNTnM3ZmlHNFpQMzhzU3g2?=
 =?utf-8?B?VWxhMDYyRmtDN3F0bVZyOUZoU0IxMXYwSGp2SzQzbEd4Z1lXUm9QdHJBZDgw?=
 =?utf-8?B?bi84VUxzSWJxNitUcFdib0U2ZFluVkRYWnA3RW15Q3Qvazd6bU8xVnhwNmxn?=
 =?utf-8?B?MmNMVnhreXAyZzdWL0tLRUM2bkdKZ2ZUVk5oU2hsN1YwWnFpc3hiY21OUHdL?=
 =?utf-8?B?eVp4dzVjWjJxbnRwUmxuRSsrcFdlOUhpRXAwMjFkaWFmbk4zaWhQRXQ0Rzgz?=
 =?utf-8?B?TmFMMGllMHJEK1kwN1dHMi9ITWJTSjhmT0FaVVRvRzlkaUthMVRZNzhMV2RP?=
 =?utf-8?B?S2xvVWV6S3hPbnlxOUV2cVNtL21IZm5ZSlJHSDF1bTJHZXVxQndJSEhpbTU2?=
 =?utf-8?B?N2JFY1RpQndXYzkrcjlOY09zLytSVkRsWk9UZkNzODY2aE9XNUFvcU9LaHNG?=
 =?utf-8?B?a0hzcVg0d1BDbWlsRHBMZUF3YkRER2Z2cXFQSmYxWHRXL09tZzlVZ0tGUFFh?=
 =?utf-8?B?czF0elBlUk1iRUR6TEh3VWhkUmRnbFlaV1hiYWNWdTNqYVMyWkdhaG96U1hi?=
 =?utf-8?B?Q0FjbGtnN2c3N1JtUkU0RDFMcm5NVUZiTFFiYTVvOUpVVGlWNER3Nnp2S2dK?=
 =?utf-8?B?NzNhTjkrTzlNMVBWQ3B0R1JEQXFkdmhRUExEcG4vV3FtOFlKTjBVWVJpTGJu?=
 =?utf-8?B?QUcra01IVzRrZUQrT1B4dmoxVEI1dFRwR2NPUDJ0UENDUWtISlZDTE9YZEla?=
 =?utf-8?B?bnl2VVVCWnQyUDRmbXBuSktGRnNWL202QWtVVXZQbGVuRjlQb0NJNmhTRy9y?=
 =?utf-8?B?ZzNZVnVwSXNZaVkwVk1JcTk0RzFPakdLazV3NG54Tjhoc2Myb3MrVW1qZHVW?=
 =?utf-8?B?RGtHcmJvbkk0SnNXUDF2U1ZKRFZCeUNuYU9vNGhqcjFYKzNWcytWcURNNFNQ?=
 =?utf-8?B?aitkUDZOR2hqazNjTnN5SjFMV3Uxc3lDeVA0SmRtWUQ3amNmZXZwVkhRQ1Zk?=
 =?utf-8?B?TjVSa2theUR2Ry9CYlh1TktIZWh4ZmpwQS9SdWVXdGVFZ1Nod05qQytYT0Vx?=
 =?utf-8?B?UFM5Q2psRFZKTmUrMmhsMzJmeklZWUZPblEyNDR0NXFtQnFtS2ZJUkRRRzY5?=
 =?utf-8?B?SGRwV2J5a0lFYzQzR0JjbGdVVTBIMjRMZkFaYmZ0eXZrMHFsZ3A3eGVpRlZp?=
 =?utf-8?B?cklSd0NZVlBlaExQdzRWa1RLOEhoYlJDdnNra2NiZWlsaGszbWFQeHcxVUls?=
 =?utf-8?B?ZGxEQnNnS3l0WkVIbk9GV01wTzI1WGVySTJuVUlHOXFydDB0N1FGeTNSendU?=
 =?utf-8?B?cnNNb1ExNWt4R0p3aVIvUFlFa1RTdFdUZGp6T0I3U1h5N2c5Y1Q4bjFUUjlh?=
 =?utf-8?B?V29DN3ZRdkVxOUk2WUcxd2NPMzdvaVhoQjhwZnpqeklNZVg0dW9ONFdTaEY1?=
 =?utf-8?B?YmhNQ1lLRTdodDBJT1NsWWxjQ2NQai8yUFdDc0ZXV3NpN0E1WjFCVHFHQkpq?=
 =?utf-8?Q?L0S0UgDgITWpOU9tsDoe?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fad2497-e590-4296-261b-08dcf4ccda6a
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 08:13:05.6227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0337

Hi, Sean,

Since the changes are minor compared to v4, I have kept your signature. 
If you find any problem, please let me know.

Thanks,

Chen

On 2024/10/25 16:07, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> Add a PWM driver for PWM controller in Sophgo SG2042 SoC.
>
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>   drivers/pwm/Kconfig             |  10 ++
>   drivers/pwm/Makefile            |   1 +
>   drivers/pwm/pwm-sophgo-sg2042.c | 194 ++++++++++++++++++++++++++++++++
>   3 files changed, 205 insertions(+)
>   create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..ec85f3895936 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -584,6 +584,16 @@ config PWM_SL28CPLD
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
> index 9081e0c0e9e0..539e0def3f82 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
>   obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>   obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>   obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
> +obj-$(CONFIG_PWM_SOPHGO_SG2042)	+= pwm-sophgo-sg2042.o
>   obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>   obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
>   obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
> new file mode 100644
> index 000000000000..a3d12505e4aa
> --- /dev/null
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> @@ -0,0 +1,194 @@
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
> +#include <linux/reset.h>
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
> +	struct reset_control *rst;
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
> +	rst = devm_reset_control_get_optional_shared(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "failed to get reset\n");
> +
> +	/* Deassert reset */
> +	ret = reset_control_deassert(rst);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to deassert\n");
> +
> +	chip->ops = &pwm_sg2042_ops;
> +	chip->atomic = true;
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0) {
> +		reset_control_assert(rst);
> +		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
> +	}
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

