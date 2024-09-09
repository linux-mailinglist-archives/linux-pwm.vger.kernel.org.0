Return-Path: <linux-pwm+bounces-3159-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5761C9711D6
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7242877AB
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1E91B1431;
	Mon,  9 Sep 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uQqVWGDa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2076.outbound.protection.outlook.com [40.92.103.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC31AF4EB;
	Mon,  9 Sep 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870304; cv=fail; b=Cue4Uo50URB+ntFyXERF8bMY+Kdj7G4d66PwRZbpIXu5RJYdSam7YiDpZ6Mt9CaN1S15I4ybup3GkLhjNXV6ocUVG2hSTJBSXPYOUNPGuOJL9LhIIkc5Xc7U5HYiZf6WKsVdAwludZRlqzPrKtzgeGbmYdUBNXuhn5ufCCttyEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870304; c=relaxed/simple;
	bh=lXcMRbY1GX325faGpR4Ay29GtBkVFIgd8yRcKjJHpGo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lEiTFOTbbtyi1ImUo0e+1CiOtWBSBCA0kngpunzUBKT3NM1r5K4g3cyUKBWM3EY8ugHHh7Le9dtuO+QS3BLvwQ4VXCDEEsgIxMVblzz+2KxZ3GiUn+KMDqYy0I8sAzUs38St4RKuCSbiQb6CTya015PIljBS2WKgjl5Kik01FGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uQqVWGDa; arc=fail smtp.client-ip=40.92.103.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SenjdaEk7+ec6VyPm7sItsheGwJjC6+HCP6OoPQlGcyM6TxY9hWXGkuQj//oZ4fbbmEAAcZ+IGOyIzs01V3oeTmt3omVniBmBIP7qIzNWloQDNurr/EtvVX04MdKsJh+RMphJAfChIoEvlMZrbPD3s60ndyy/tPGcYnqmDSPydm827lCSMlBrIlbmxv+xLq//rKMXxbUJOqpmO6bx/uEVbl36dwu2Ns9rmbmqQCkgjP79xMTb15cgdTBaLCdDtnmU0806dVHgaXNRzhZTkr32X4Dpq4F0J1QTLegszWvx6K/Bwh3zAQXQTd5aCHSh3srhF/wpzbh3g0whBbn8L7a3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7F+idI0fLiJXc1a8thWbHsAnjIxRwlnHKF36BTzfyI=;
 b=fgLi5I49KJFgOsXrKphzZFkLuXQZIr4js9L4IHKaH2SenQLeCOz9hzUbG41UCHlMJi4ik7Z/cJXXzTEVovMnP6MmM/FrUk27QSwI6Nt1BD1jRSBDPKR/LuHAwPvMMncZWSB/UFkwU5T6FPOUNQc5jJRcBgD+tZw/YbP1KGUvjwgXuoLh9P29UKL7xkbxnBPKQZf30KwKi6w+C7k4lOCHAn9QPFdYNUpdu0+QtMGvJVqrXfR1PiZXglgqTHZAlhdS7m1Qjsl5LmgTEXYCJ9NxjZOzPzNUt7bGY0SoVDFjGzNSP0d7LDI6zGi1IOho+RpTjiWeRsbp7Wgyku43eoRWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7F+idI0fLiJXc1a8thWbHsAnjIxRwlnHKF36BTzfyI=;
 b=uQqVWGDaHh0qJCZ91A3jREzwLjSGu2ZVvk+xhn+CbOE3+iP9ivoVkQSwLm2soqyFNtzxEncdNn2fmr856rpp1IvgWZf/6Of/WLkSvImp37IN2Iqfm9jXQ8Ca/tcGbwIoMA3MCN/c1XC4I0YE7QeKPUs/k0aWDC1mNUlC7vY9afVZeZ1BLa2x0rYCPeJVPWuZwF3GLtRcBdwnevbA3e0+BSmA9HOpkKTdzgWHTSUgalW4SuKsm6l5W64oDxN7GR4LiGjobDmAgm2mKPLDt2lslhhAxFM97lZdMBnHewiPqBC6EQC+eEngkFeXwZwT3HJlcusv/70bPU9Qn8EswxOKlA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB0314.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 08:24:54 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 08:24:54 +0000
Message-ID:
 <MA0P287MB28225ECCF1D263A20917AD5DFE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 9 Sep 2024 16:24:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Chen Wang <unicornxw@gmail.com>,
 ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
References: <3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang@outlook.com>
 <202409080100.h6lX5Asm-lkp@intel.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <202409080100.h6lX5Asm-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [F1S1sqjnhUwCAGR9Vq1av/D2K/GB4g9e]
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <6657655b-591f-4c52-99ca-0fb1f9ac5c40@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB0314:EE_
X-MS-Office365-Filtering-Correlation-Id: e81a3ff1-48e0-4752-b952-08dcd0a8e183
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|5072599009|6090799003|8060799006|19110799003|3412199025|440099028|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	Y725LEHWHC5nkMirIFAjRX0e0ige1pYoZC++5dRu/VGxx8uoUAN225a2UBlofAQm8Yod+tOPP+TDTFfl0P0jwQeuPoC5kVkEarz2yJr+F4vF0fpXnq92EkVaWIJF6to8bLCtUs9WuUQVCxLFtHp6rYhpBY1F+XF6F06U/kTNICVFkHkDAU6guHOz6bnUx0B8eMvPGmQuRv+RUQN7V2EH6FX2AHEYinp2w8q/OXes506FPggvn+4FhlbXBAmx+gS9jTtqSU/IkjNN2U/bNMgIpc4+UbvVfyGqQtC691+6GTwRM9h1z1/Qk8VBHvIK8sd/eC6EkF+OA6ZVKYjZbRYQNGm6iotbAvajiLUjJUqrWUeANLQBM+FxbHNB3ePbEkEFurAYX6Eh0Jel5AcTRVx8HkzNe2AyMTfM/ZBge4LNwnrtR79dsGUYPNNAZX5IMUMoc9nyzbHIxQheEfY7OxSlTU9nsvt5OV0i9C9/fhDYCNKYY9ghMjreftgcujf896VGGtnBXj5XsSfwJB6aHu2forJZiFYtnpi5w0CpJz3uACaY2LaqeusDpJ2AQGwMmEtAHyPVC9H+yDPt1m0xLTPKmF456bsnMJqIVfJ+zbqc7c7kNdEDVyAczriD2NdwG/MZoyef6fwP6ue014AtywuIKaOQFP+6rf62/mT6mwHZdHBRq6oE1CgeiACy7R2GFEYwOjj/DfGUHBynjbbAoga9d0dLX5V92/49s3rwlUzG3Zv5nbIa5NJIBX0/J6N3egOz2zHokOCW3VfvM77AUPV511c2EQLRuv/XptSqLaNq9t79m9Iw8gio8h5K2VW9WjMGZJTOJuP7j7Lj/lTrlV9CBAelF7yM8bP2GlVEGUEVRGo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW8zWnpuRFlnYWpOSmJEaTZLN0EwK094ZHN1TDJnR01Ndk02ZmhjL1A2UVVV?=
 =?utf-8?B?MDE4bzZEUHN6NW1kWkExZEl6aEFEdGRoR3p0aHFQQ2xiVWNtTEJTY3RyMC9S?=
 =?utf-8?B?a3Z2eFlLWUU0Q3BtbmR3WFdwMXNMODdCZFNMb1oxOTFCR1FRZTVvQlVWN0dC?=
 =?utf-8?B?TzE2ekNXNTFzVUI2NGFsQ0NodUhLNUZ1T2dLV2lzck9yZzlXZkNiS3oxTWJa?=
 =?utf-8?B?TmN0U3FldHZKM0VnaGFnMGNzQjZkR0xienU5UEp5SU8xZGZGM2tScm5RRHU5?=
 =?utf-8?B?eFF4bGVvclVIdlgyVUdwaEJEVjFoaHRCMEU0dWxNVDJOWnZYMjhtUytMMnli?=
 =?utf-8?B?bVQ4M015NnBNdG5tdG1qTUtlbXBwUXNWeUFGMWFjNGVzR0luekJzVGNDZ3RP?=
 =?utf-8?B?UjBFdXVNZlRVWFRubHVGT3RaMEkrMU5QLzduZFdZbW5VbUFyTjdVRnFrSWJQ?=
 =?utf-8?B?ekFLYUJxOE5Oa2NMMytYUGtVeVkwd281SStFU2M0ZG40a3RHNGJnWU1vRG8r?=
 =?utf-8?B?U0V0azJPS09qdXdTUy82SWoyeFFkamZXQ29WOWdVS2dxcFl0MTlpNkRJRE9D?=
 =?utf-8?B?N2xoU3dDSko1MUY1QzVFWlJ4dmIvSVV6bURTM1B2bUVFWlgzdVc4TWpxaEVI?=
 =?utf-8?B?TG5VRmhKSzUxKzJ2S1pRTk1Ta2Zib2RYV1JJTnhIMko0eE16dnB4cWFFY3k3?=
 =?utf-8?B?c3l1RFVKUnp3eGtyaHd0WWg4VmhLM1J0REkyOTMwTDJFbnlpb0s0ajNZTVZT?=
 =?utf-8?B?a1lyendBTnd1Wnc1bW5oenNkRWZuY004UnZEellBTDBEbU9NbWF2WTVud1lC?=
 =?utf-8?B?OXFhb2J6Z2wwMCtkeUdHRmpESEtGVDUzbTBPUWVBZFNyOW5ucTBMU1RLS1B3?=
 =?utf-8?B?Y1IwS2VhbmFGcFE2UVY2UXZtelgwVmcvWXdiZ3hqVjVUWW1HVmV3SzY1NkRY?=
 =?utf-8?B?WWNRM3BjSmdmdWNPVmZqNTNITmJRMDFHWjFicmVkb00xZGhJNWY2bmNPZS83?=
 =?utf-8?B?RjM0bFZzY2htUEw5bkhxMnUxN2NKeUhaZ2NBcTRxMXBENmdRWkxLM0VsbWZN?=
 =?utf-8?B?ZFlqVGZ1UWVoYWJVZjJIOXA2ZW1NU3ZtQ0Q5bjl3bE02QU1CVXQrOGluVDlq?=
 =?utf-8?B?amoxdXlVSWtxRi9vWU5mT3JqbVEvUjUvWWNlWUkvNlhVRDZNYWhBaEI3aXdB?=
 =?utf-8?B?anVmbjZlZmxMWVE4WktOaWFQcUZkelJidFNqSHJLN2MwYlhhNUFYZFAvOEhj?=
 =?utf-8?B?eDR1YWRjK1UzVHJGVVU5WnVwNGx5QmNxKytYK1lnSmxIQWZFdXVldTNja1Ry?=
 =?utf-8?B?ak9JT1UvUUJIYlBsU0xzaXJxWVB5ZEZWVWxRb2dMUVhHZU1CSXJuOUN0SXRK?=
 =?utf-8?B?aDNXTnVqeGxiYUZxcWdoV2w2MWJ2Vm9CUDdoeUNyMDdwb1ZGNUJjRXhsdTU0?=
 =?utf-8?B?NGdyZERtNHFuZitmbTRReldybERVMHY5ckJPV1JQRmJ1WExqUUtaMzhWMXVW?=
 =?utf-8?B?R3RhU3VxODQ4V1A1aW9rUFlTeGNhTmNGZ0Z0YlRVYmdoR05ER3B0aGUyY0Er?=
 =?utf-8?B?Q0J5OXJQZU9ZUDA1RXdHRHJOVXRJNnF2ZTNqQ3NpbkFFOURMeWtZWTNPTk5a?=
 =?utf-8?B?MkJ3M3RCT21teDhVY0dXb29UVkxxQWRUbVo5aVIyUm5yODlkMFVRZTlCRkRE?=
 =?utf-8?Q?uCZrC7ugcPLfoqb0gOd5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81a3ff1-48e0-4752-b952-08dcd0a8e183
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 08:24:54.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0314

hi,

I wonder why CONFIG_PWM_SOPHGO_SG2042 is enabeld for m68k? Please remove 
this.

Regards,

Chen

On 2024/9/8 1:58, kernel test robot wrote:
> Hi Chen,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on 431c1646e1f86b949fa3685efc50b660a364c2b6]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Wang/dt-bindings-pwm-sophgo-add-bindings-for-sg2042/20240905-201303
> base:   431c1646e1f86b949fa3685efc50b660a364c2b6
> patch link:    https://lore.kernel.org/r/3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang%40outlook.com
> patch subject: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
> config: m68k-randconfig-r133-20240907 (https://download.01.org/0day-ci/archive/20240908/202409080100.h6lX5Asm-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 14.1.0
> reproduce: (https://download.01.org/0day-ci/archive/20240908/202409080100.h6lX5Asm-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409080100.h6lX5Asm-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/pwm/pwm-sophgo-sg2042.c:99:34: warning: 'sg2042_pwm_match' defined but not used [-Wunused-const-variable=]
>        99 | static const struct of_device_id sg2042_pwm_match[] = {
>           |                                  ^~~~~~~~~~~~~~~~
>
>
> vim +/sg2042_pwm_match +99 drivers/pwm/pwm-sophgo-sg2042.c
>
>      98	
>    > 99	static const struct of_device_id sg2042_pwm_match[] = {
>     100		{ .compatible = "sophgo,sg2042-pwm" },
>     101		{ },
>     102	};
>     103	MODULE_DEVICE_TABLE(of, sg2042_pwm_match);
>     104	
>

