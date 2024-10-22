Return-Path: <linux-pwm+bounces-3740-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F009A9471
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 02:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4D01C21BCC
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 00:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B2D4A00;
	Tue, 22 Oct 2024 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B7EHuFsI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2105.outbound.protection.outlook.com [40.92.103.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763DF186A;
	Tue, 22 Oct 2024 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729555266; cv=fail; b=N/EmjDVC0CDNOvPu+thbn0uX+HLJihjtRw91M4/4A8QJGJpwPnDdJ+iAKPgN7xcxd1zzQNQwxBrkR/Fw3Vlq36AzBqBULkFeTuHsDzTbxTCad71ffpOGQCIHrcQO17wBgPd7pUgE5mtnGSEDwAkFt+J1NRNL4QrIidajo39LAA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729555266; c=relaxed/simple;
	bh=eQFIX5hKDiNkZe1WO83GOeiPvfTgSY41ezeuCwSxhuo=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PDBGmusGo+6lrBlMR9KvSyFo0EQk1lLFoICl71lNIsphmTHbWsEol+B27K7bUrX4rDQU+1lD1NoiAYyX3vJdGpNQ7CAK5wlZxOfxLhFpn94g6mr8uFm51h3hvZxRvrSq5FzLlCet4gDpm4HB3wQ7TnLCym1M7oVyNi+bEr9ANbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=B7EHuFsI; arc=fail smtp.client-ip=40.92.103.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FafXmeh3EQYrZGv8XFuhgKYbkxRxttvtYBnefdjGik3+LMqPJJgHUUIB/IpZFxA4jpE5VN6Kgq9bh0cPo4vhJfhE5rLA1wGP8Xc+22AGcixQvDvxexRKAKm0sw2V0dpo+ySfB3+dqxWb+cepcLaL1iX7PCuZOi/P+DE3lbE3hZ5WzH6KVtVylD9GsfdSERI1AmFhJlkE39URTj0ykFqg+TOnBycfgj1ogKKkPFPv5v70kL1zRrfHwVixUg+hs8xrgzl0eXptm6TRJXubteDeofljHsVx0CqZ1xmo79WOJKQV2/PtDcYkJ2zXbCkgG9bVGKUTngudUx73UmQTlglu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjsdPWen/+4LcIJ9uvtU/REM/BoF4LTHcqWcgdIGfRs=;
 b=oa8MVLR2/P+7offOya35FSmZdjNfx5u0qAlQZFmXhmqBMesqxWP+qi0vFnrQjmwhpf1EURb1uNM4BNKU7XhI9QzmCMhd0B04A6J5t5S5PudDQzvRZrUUa85xObZ2xw5mz/gt1m9wDwgMnB53a4cwR0UFb4OZ/Iu1h8q5tSb96AwYPIOOb0dZGssxgIIT3iyRPLs27iiCYPFs9T0tue/5e1K1cMRQO7PrWgLiBpHUAQsq/6KDwZWYE+UI+o9SEuXKmjt68j/4l2r72kZokZ/5ibiw0tuJmR4wxpiFZNiJQUvah78YoqVSaOd3/uDX6JOmJ5XOi5v3dRR53IZW5C95GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjsdPWen/+4LcIJ9uvtU/REM/BoF4LTHcqWcgdIGfRs=;
 b=B7EHuFsIyRm2KsSCvQxA8Ov/xA17PpNiEyKgOxIOHgTYlrv4w9/aTvKwnOjDOtNJVs108ObAXjBdsvQkw+icWcc98DMA0nbZpW84gfTT3f9WfgSFshf2bm2DDwi3s53zsL7pM2kk/OK50hSYlgWqrMQZdcT87rBVvxep8bqN61aW/R0KgbxWeICeJyuoLC8WeIpn1SMKyjBaY7C0UrcDRTeR5aLsL7KmC6fXtZbBvExUZ20m0PGUmwSFbGW/u3/gAEop/ziZ07EUlbWsSNIEVhYuU4L2jVxFs+xM7i6KMuDqRrm99PkKJDH+qo0j80djA6SqzJ85TF+cN/yU0307Fg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB0857.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 00:00:56 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 00:00:56 +0000
Message-ID:
 <MA0P287MB2822808440B26B1C445118BAFE4C2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 22 Oct 2024 08:00:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] pwm: Add pwm driver for Sophgo SG2042
To: ukleinek@kernel.org
References: <cover.1729037302.git.unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1729037302.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <ce80a5d9-67a1-4695-849e-9dd7c1da258f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB0857:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f7e59f-6032-45f2-284f-08dcf22c9a6a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599003|15080799006|6090799003|5072599009|19110799003|8060799006|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGZnY0hPQlprT29ZS2taSmhPYzAwTkZwSkt5VlREenI2L1hnb3VhOU9yaXkx?=
 =?utf-8?B?ZnBLOFk4eGVUZkk5U3RjT1M5Y3J6TE1EdGJMeGQxRng5K09aYzJsamxKMGdP?=
 =?utf-8?B?MlFQT29uVHB5RzdCQjB4RjBvb01wV3VpcFplZVNJMUZBamxhem14K1k4ekRk?=
 =?utf-8?B?UGFUdlY0bVhhN0RzUU9VV210UUxpSVhnUlUxRXliNHJGU0lHQmVQZUtrbUpi?=
 =?utf-8?B?bVhSN2V6ajhKeTBreWVXbGhyeEI2eXFkZXFnMzUxUTM1VkhJa2RDME43eVI0?=
 =?utf-8?B?SWFHbTZOMUsvQXgybUNCNFplTTJuY2xxOXhnaEVGbWNyM2VwS0x1UytxYzVu?=
 =?utf-8?B?bTJpZnRJL0hPQVUrSCsrZGhqTnFjTmc2K0FROG0wL0lLVHpNWmhWcUZxaGQz?=
 =?utf-8?B?OFMzcFJEbThwK0o4NTVZRVBEdi9UWFNEbE4rZUtSZ21hMjlWYms5R05uMk14?=
 =?utf-8?B?YStHSnFnSnZ4Tit5RXc5WnlXcFhnaUtxaFBiTk53LzJkcHo5K2dTWEczRUdm?=
 =?utf-8?B?VnorckgwVDhkWUtZTjZZam9NTkRyenlxUXJGN0laWHcyQzVyM3hOSXlBT2tn?=
 =?utf-8?B?UFhCS014RlBLS25oSkl1YUw5cCsxZXZsaVUzdFNJUkZGYzdIQlYwRjA3OWds?=
 =?utf-8?B?RUxEbWFzcnhNMi9ReVNEK3c0alRscWNCOWNQUWRsNHkxcVNpa1ArREhGeDEw?=
 =?utf-8?B?bEFRdUsvOXVQWXVIUDB3ODJLRlVDa0pzUWRtSmxWaFVnOTFGWVludytCQnht?=
 =?utf-8?B?bW1LVDRCYmdJS2k4RXlneGlmaXA3UGZGOVJPZG9sRk90eDIzR0ZMNGNnMlZQ?=
 =?utf-8?B?WTloRHZISmJIcmsyaXBLYTY0OHFsNytnUlQ5amI2WmxhUmpZWU9hNVVIWUlK?=
 =?utf-8?B?bHpBR0RZejkxcms1YkJTdnZuV1JsYytoNm96OStNRG4vUldJeHVMcUMxcUxm?=
 =?utf-8?B?Q1ArWVgzWFV0dHF2aWpMQXQ1YnFxT2dvMFIxM2paa2IwRWJLYzdKUlU4ZDFS?=
 =?utf-8?B?Y2Qzc2RHbEp0OUJEV1B5bDlTbC9TWGhxS2VZL25rRmxxbWF3c29TbEg0OXRP?=
 =?utf-8?B?TUVWelR4d3Z0Uk9rYnBublV0dlhwL0FvaGNWWkludzNBVzhJcjEyQzdqd01r?=
 =?utf-8?B?T25SYnYzNlhVRlRGa3pHcnJjeU5nM1RJZDQySVl2Zmk5UzRKeHNPTk9reUhs?=
 =?utf-8?B?UVB2OHFQMHVad2ZleUYzSW0rN05JektHUkRpUlRSaUpGMU02czdsdTNwYld0?=
 =?utf-8?B?NVNtTDNWVnFrQysyVGlFQnBrWnRJZ3I1YlhqL1hvN2xaOWVXQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3ZBVk45UGdzTFdxL2RIbTFRTlc4aGhBNHAweU93MU9FRU9sTFhkbWxxLzVh?=
 =?utf-8?B?aTNHdlhYSmt3YmlET1d5YlJISmZVZC9ibTZFQy9RNC9BV1RwaVd6OUlmMURZ?=
 =?utf-8?B?RTNaNGpkNS9XUVJuTDd2NXhKQm5oYkE4ajA0T0NRelpuS29YV3VCUXJsbnAx?=
 =?utf-8?B?T3U1bms3RlhGUE10VXZ4SlhDMlJTbWJ5OEdlSGRRa1ZIZFRCVEJWTHhxaCt0?=
 =?utf-8?B?SER1eHdERmd6WUFxajlwaGtqNExsRGVUQUJwc3RSUStWYkF0RmpLaVNDbmVt?=
 =?utf-8?B?UEpEVUMwMWZTL2UvT1Y1eGlBWVhlWXBXcTJrMkdxblpUcUdZb3I1SS81bkh3?=
 =?utf-8?B?dWR3NXZoUy9wNjdqeVo5YzAvOUVRc3N4VVBsM29EeHJCZDVna2c2VTVPcEps?=
 =?utf-8?B?RC9wRThVZzNxTmNPRkNUUmx0TVJDd25mS1VSRVRqc0tjZDlBTmtMT0hWQmJs?=
 =?utf-8?B?Qmc2ZGNkRCtzOElBTlhJakM5eUw2Z0o1a3ZVUktwUk9VbFZrajZabUlUdjV6?=
 =?utf-8?B?czNPell0b2NlVmpZUHZhUUVwLzRYWmlQR3hxdlNFUzRYbmRZYUlwMHBURlBG?=
 =?utf-8?B?WXFEd2l2enh1R0N1cmNoQTlia0RDb1BvYnMvSytjbzdsRlhNWjVuWmJ5Q1Ew?=
 =?utf-8?B?U3EzUEIvdTQxRU5ITGkvM01Wb2JwQ25EL0RkcW5TcjhFNXZ1MDV3YlY4ODJ1?=
 =?utf-8?B?SFdySnRGMDZDZUFRSEZwYWRhOFdzQlhadXlubmVOOWZQSzlZck4wcTZZVnRN?=
 =?utf-8?B?dVBjYzlCSXdhSmxNMy9NbHJuTmw1bkVZdzVlZU9kMkZVb2MweXdFTUZIbHBC?=
 =?utf-8?B?YjNnYUt2MVhCZVRXcnZnZEJrZVFZWnlkN2hRV2RMSUNRNStHQ2VVY1gxRUZn?=
 =?utf-8?B?K1I1L2JIUkd4UVBmdHZ3bDNmbDBwVU1QMnNDOGF0SHJIYk9iZjZkY2VpMHhQ?=
 =?utf-8?B?bEJmZmljb3FFUXpTMklXamc4L1RaTTlSeEpjS3hUdGNOVGZEQnJUdVdBQTZm?=
 =?utf-8?B?SWJtaU01djlLREd4YTgwa3FXckJndGk1d1BhWkttYWJOaElZT1czUDkwb25O?=
 =?utf-8?B?alRrRHpYY0lXL1FSeEFwNFJmdGtCdFdWd3dSZitNOWhVVHJHaE1GUUlaQzBX?=
 =?utf-8?B?NFFnRkl0YzNhRGJVWmVrOS9ZN3h1ZmVHRlJlNThsaUFUWGszM2lkejI2ZkVm?=
 =?utf-8?B?RGpYaFFSTXJTdWM4dzBrT1o3YW1JOVV5c2w0Z1RnL0VQOXAyaStOeTJLK2Vk?=
 =?utf-8?B?VXFWK3FrK3E1dWFQcCtQbHJQdHY5SkhnMDB4V1NiRUFHcHZWQ3VBMzRsYkxX?=
 =?utf-8?B?TVordE4yZEZkbEE3T0JZczZhQXdhNDdXbW12OGUrNGxQZXE2VzdwWUZWNW93?=
 =?utf-8?B?Uy9jd0VGWVd1UXROTHZHU3J1ZTBBRWt1SFg5bWNad01QWUpESURnV21adEhh?=
 =?utf-8?B?M082SlNzYmVPT0o3UUxnMkQ2b2lXZUVEdTFqUDBLNWYrcENBTThnb3BlNkZK?=
 =?utf-8?B?Tmo0Z2JDbFlXN0FmcENMSXBvbk1ObG41QlZid2hpUE5sU0RDaFNJWU85Vmlk?=
 =?utf-8?B?Z3plZTMvdDdrOWNwKzBRaXNkZGk4RGptS0UvbUdqN1NybEtoaHN6WmpUR1RJ?=
 =?utf-8?B?MW5MZmJ2V1FVWmRvT3BqTlQ2d1lXL0Q5UllrblhLSG5XekVpVElmNnV4NDdR?=
 =?utf-8?Q?kYRilImHSLcFLFZMLKGK?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f7e59f-6032-45f2-284f-08dcf22c9a6a
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:00:56.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0857

Hello, Uwe,

If it looks good to you, can you please apply the binding & driver part 
of this patchset for next v6.13？For dts part, I will handle it.

Thanks,

Chen

On 2024/10/16 8:19, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> Add driver for pwm controller of Sophgo SG2042 SoC.
>
> Thanks,
> Chen
>
> ---
>
> Changes in v4:
>    The patch series is based on v6.12-rc1.
>
>    Updated driver to set property atomic of pwm_chip to true as per suggestion
>    from Sean.
>
> Changes in v3:
>    The patch series is catched up with v6.12-rc1. You can simply review or test
>    the patches at the link [3].
>
>    Add patch #3 for dts part change.
>
> Changes in v2:
>    The patch series is based on v6.11-rc6. You can simply review or test the
>    patches at the link [2].
>
>    Fixed following issues as per comments from Yixun Lan, Krzysztof Kozlowski
>    and Uwe Kleine-König, thanks.
>
>    - Some minor issues in dt-bindings.
>    - driver issues, use macros with name prefix for registers access; add
>      limitations comments; fixed potential calculation overflow problem;
>      add .get_state() callback and other miscellaneous code improvements.
>
> Changes in v1:
>    The patch series is based on v6.11-rc6. You can simply review or test the
>    patches at the link [1].
>
> Link: https://lore.kernel.org/linux-riscv/cover.1725536870.git.unicorn_wang@outlook.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/cover.1725931796.git.unicorn_wang@outlook.com/ [2]
> Link: https://lore.kernel.org/linux-riscv/cover.1728355974.git.unicorn_wang@outlook.com/ [3]
> ---
>
> Chen Wang (3):
>    dt-bindings: pwm: sophgo: add PWM controller for SG2042
>    pwm: sophgo: add driver for Sophgo SG2042 PWM
>    riscv: sophgo: dts: add pwm controller for SG2042 SoC
>
>   .../bindings/pwm/sophgo,sg2042-pwm.yaml       |  51 +++++
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   8 +
>   drivers/pwm/Kconfig                           |  10 +
>   drivers/pwm/Makefile                          |   1 +
>   drivers/pwm/pwm-sophgo-sg2042.c               | 181 ++++++++++++++++++
>   5 files changed, 251 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
>   create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c
>
>
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc

