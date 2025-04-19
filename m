Return-Path: <linux-pwm+bounces-5576-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B213A940CA
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 03:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4296C446CAD
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 01:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90B44207F;
	Sat, 19 Apr 2025 01:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sjjWPg2i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079CEAF1;
	Sat, 19 Apr 2025 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745025652; cv=fail; b=nJ1KC5eA/DZ7PIsPS4RHo4+JyPqo2C50LZpvTz4f53e4T8cFAezp6wbXFgwMnnOyaygD8rn6sQ3J7UJLs3Z9tbBU9a1QQwjcRwXY2nBJ1SsYUIrENCgQ8vsY4nM/Bl1R+JBdlL8zmXaH2qNaTyach1rI/YUPIz4ga0Rr3OaPmU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745025652; c=relaxed/simple;
	bh=dBwrrk6KmyLdzKoc0kstjZc+ifLgREGnZeunp30TFAM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QvS3Kfz0mju5zyW22zgudyUSOZ/oEOwdSshH7loHiz+hHKMf2hv2a1rQ02ej+D4fNlGTRdESszNHs4eQkr8iEarkodfv65FcaY+veXSBJDIYXsWaJ2A1yD9uVOl30swFxJOnepre9yB4c4XLPV36I8wjrEbMvkUVuyRMCxIUvb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sjjWPg2i; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQgTDjVHAeW8NX7Uf1egK3p7ww+wejUANpHJB0nAPdHZjBSadVpyDXfn8A3ZOaYq0bFhmODkGv6xAQ+ccIeCeNlTU13w7XugbVesNc3gm+giTkyDbYgr/p3cFOlw293wqhnda1hE71EPhIuZjSz3a/FzIYiyTS+sCDt537a043B5b9kt8SipkI/mWB7pBlQ6jhF4AloaCI4+Uv/UhzTjlIXGsQEXaxhDaoZ6tMMyzOuvwN/Mjq7aFzGkUUzsjCxMi4x3I+5EYTMA8f2kRm/nSkxdmzSfe04AzXNwJa7sTVHw3TKEVv89ZJA48i3Ed+iZk8Dwhn7EevwVwHc5BeH1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=403l3NkQ3h7eCSA3v8u1jcljOmOtG4qkjXSfLdSEHoU=;
 b=T/UkMC4qHVXAPqt0MiP0O2jU/HLW5Ttn3utycAWI7XyahmwxdnmSp5HvhQh9d983dbhSrXD4VUwHEjp4hlTK04zypM2KhgYQVgZD/GYXnNtq3gjl9A4j3dU7wWpQzNxG5tvAn1ZDOWTgJYyOJYm2rSGzzJxbXoupMTgz3522DIiQKfaa3t3n74cvxBUcXURwC42IpQ0Gi6h5b2bIGl1yzfReIldKXFPs5Io/BOcmt+lMyrPeW5E4akRdSjuNOGh3u2VwC2bdkWjQIhd/xuLeze9r33eb/4L0gF+AOsNdGfYCOd6Dd3VS0y4IDa7kp/BOhe7eXVLTmaT3hB2Uh04QpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=403l3NkQ3h7eCSA3v8u1jcljOmOtG4qkjXSfLdSEHoU=;
 b=sjjWPg2ix5xEQLbni17GyAmgel2gL9i8rYtDLYEuaKsBqh2LBScB/8nfRF6JaP+1mTouGIsFUgD4a7BG3ht7Wvj/onICfffjiCL33iqKtTCUXtCoIXU3fe/78FDP7S7XXv35FOUEV3nkxa6mdYZ3goeHRNTGlvgE4F8LVvRg7JHUXEj88hDdcApMSzfB3meIM/jUsHf1N6J904Y0LjfvRC1kH8Y2kP46OIUXIQ3ae4LADJKHCY7bYtLDmHQWKYHZekg7k9vO2V+msJ4f79Qg7hr1j1rWi6goVJpJta7DPtMVbu4sNPDxU+AoxW7vqIYb+Hzad7TtDJiPkWtiCvzvuA==
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
 by PN1P287MB3646.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Sat, 19 Apr
 2025 01:20:43 +0000
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4]) by MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4%5]) with mapi id 15.20.8655.025; Sat, 19 Apr 2025
 01:20:43 +0000
Message-ID:
 <MA0P287MB226200B6006A974CE752F5AFFEBE2@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Date: Sat, 19 Apr 2025 09:20:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] pwm: sophgo: reorganize the code structure
To: Longbin Li <looong.bin@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20250418022948.22853-1-looong.bin@gmail.com>
 <20250418022948.22853-3-looong.bin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250418022948.22853-3-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
X-Microsoft-Original-Message-ID:
 <adae344f-87eb-4b19-9ab2-3c254b02e7ab@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2262:EE_|PN1P287MB3646:EE_
X-MS-Office365-Filtering-Correlation-Id: 307a8712-5a94-43f4-836f-08dd7ee0674a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|7092599003|19110799003|6090799003|5072599009|8060799006|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vlp0N252RjlvWWJOR2JjK01ySE1BNzNZREJMWFloRS96WnFCT0JwMjBkNXZv?=
 =?utf-8?B?RTFHWGlpdExST2NCbUxLS1VpVmhQUTc5UVZnS3YwTk1QVUlCUytzUXBKUHlu?=
 =?utf-8?B?SUNPaFIvU2tNandMVm9laXZrM3kraEIvR0dSdEU0WkpRKzhoZDVrdWdBajh2?=
 =?utf-8?B?U1haN2N0Mjd2L09XSUVkakJtZWxDeXh3RjdsdzZPYmlHa2h3dmw3MXJsQWVR?=
 =?utf-8?B?cU9kR0JwZTM1ckJaa0V1ZGNUWlN0b3BCa1B1c1RCRmdDb2I3YkhBcTdia0VE?=
 =?utf-8?B?QXhqRnN4NmRxcW1XZzJwWnVQaE55M1hIMWpXM1k0V3ZuVWNXS0MyZCtMVUs1?=
 =?utf-8?B?TnpkR2FOZzg2Y2hsalhzWHU2em1ZUFo1TDF6VVQ2c0pQOHoyRmU5Q20wclVz?=
 =?utf-8?B?ZHBWd0F5YUhVR25oczVGcHUweWVGTzVDVWg0Y2JqWXQ1Ykg0ZlNHYzlwWUVH?=
 =?utf-8?B?Zkh5bkhhSEF1UTd4UjBCU1RiQ3VORG9oK2JySmI0amlQUjJoZ3d0TVpkR1FF?=
 =?utf-8?B?TVlkNnY1UFpjOW5qZTdBNW8zM0hTeE5KNTdVWEx0eVMvWEtaY01kQ29BN2hZ?=
 =?utf-8?B?bDdCT2ZCS2dCb3BzN2dDa1B5UG1YeUtYVGVWN0YvOEZnZW5wSis3czNRQlpp?=
 =?utf-8?B?MC83VjMydmFjVjJ1VGNjZDB3aTc5QlNJaGdJMUx6dTN2NFZIRGRkSGViWDFP?=
 =?utf-8?B?S2N1ZVkySTFyeFVwRmlUQ0p0SVNYYzYwZHcvVVh3RkdabjhDMjlvdW5zWmdu?=
 =?utf-8?B?MzVrOUx1Rkt5akV6WU80VXpndnlBMU1rSnJZM2RDNlk3Q0NFQUFwamlWOWw2?=
 =?utf-8?B?Ty96dTkxSUdwWkwxV3JPMUdWZUxYYW9qaHA5UEhLNzVBbVF4VEYzaHAvdlFQ?=
 =?utf-8?B?dWpWVGx2NkZsaldwQU9mRGwxVGV5dm9EZjAvUTdQMmJhWHcrY3Y4U0QzdW5J?=
 =?utf-8?B?OG1ycGFLcUZkS3U1U0NHbWlXYWsvcDhLcHh6VFJwQXlTcW1uNENQb3hINE56?=
 =?utf-8?B?eWgvZEZOUHZ5MWpzSHlCV2xGWUI0cUNtVW1IekJkZUxUbXhrbCtEREtIMlVW?=
 =?utf-8?B?Nkl5MitsK2ZTT3NjRUUwL2E2TTRURHduZlVvOWlCRS95S0hIOSt4ZVErUU1k?=
 =?utf-8?B?cndQaHBVak1pb1p2blY0aE5VVFNiYWJVSUl6bERqTzVTWHozeElDUFY2TTRP?=
 =?utf-8?B?T3c4dm5pU1RNTEFTRGoyc0xac2lsWDFmMk1jZHRXLzlyOHJoMW9Pd1Z4cG9X?=
 =?utf-8?B?cnVnUDh5YVZ1dGZ3eUtBci9aeVA5aFRaUHR0QmU3T1VrcXlFWUtkQ2tXTmUw?=
 =?utf-8?B?VDRENG4yanZDbk5FVHg2d3l3cEV4WXE5eGZYNmI5SzBidWllQVcvMStJUWcx?=
 =?utf-8?B?bTA4NVpHaDl0bWRpaXVrUWNJbUIxNGF0d2dGdkdiMGI2RHR2OEwxeC9kUUlC?=
 =?utf-8?B?M3NvVlI4cWpTbE5KOE54OVNDdUxXamNyOUZmOHdoaFhFQ2w3cDZzNkFXWjZk?=
 =?utf-8?B?elh0dzJ6TkUzYVE1RklsaVYvQ3RkcmQrZm5pSFEyY0h3QWF0K1RsMEpIOEdH?=
 =?utf-8?Q?q7mVui4G/2MVyMbB1q/ehUCb8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTdtY25uRXVPb0tzWDVuWWtQN25ablpxMldsZUF0c2RGQ0xmalIwM1NFeWtP?=
 =?utf-8?B?dkNhSVRpa09Gb24wNk5vU2xrRURmbjFJdGJxdGlua2RNRXJLdFc4YUg0UmRu?=
 =?utf-8?B?NVpuRnFIR3cyOXNoSWdWYnFTclZnakQ3YlBxRzdsaGIyaUVLeDJ3ZEYvcUE1?=
 =?utf-8?B?cHIzWHVMVjU1WFlTSnFrSEczUW4rM2RMK1NDMExQSzFiZjJRd3VDYVpEVW1u?=
 =?utf-8?B?RVNaclVhN2hiTFcxRlJvSFhhelVwTVQvN3J5YVBDaXhPcFR4ejBaYWxwSDJM?=
 =?utf-8?B?dHJjWHM0Rk9STm44UTNIVHI1OXhtc2puMVpZZk1rOCt4dWFCWkdyQ0VXbllp?=
 =?utf-8?B?SWZFQ2hVRHJCK3FqeUwrWTBOaUZTc2ZsV09NSi9NOVE3ZCtQZGNqRjNXVnp5?=
 =?utf-8?B?RjdNS0RGWCtGK2oydFZEM1JHVnBGVm51ZVZ0Z3d3UlZwQlArV3hPdFNBK0NX?=
 =?utf-8?B?R2RUOTFiRFY0OGd6bURYV0JEdTlVUFVJcUhVcE4yd1ZIMjFLREFybmpNVVBq?=
 =?utf-8?B?NEdMM00vT3dJaktRRE5rRVcyeTkwMWxOYzlJcWNDRUx0RkdUcW1xQkJiWnVO?=
 =?utf-8?B?djIyTDJxamhMRHYzL0x3cFFoajdaNi9SL1laZmoxNHQ0ejdMQVFzWnZsQXky?=
 =?utf-8?B?cmx0UVNlejI3Rm5FNHdyTVpJcXBPbFl0N1BoTHlmOG9jb1hJK2grbXNWMnNE?=
 =?utf-8?B?UE5qMWFPVVJqaUFqZHR1WGVtMm9xblJva1dUTDlIZW5nUHFna1B4TnZzYzA0?=
 =?utf-8?B?VjdiNU9JTjlIQnZiQVBDenAvd3FLbHF0T29XbDQwYkJNTkR0TTZiZG0yVTdB?=
 =?utf-8?B?STYra1hCMkdZenc4R0JBQnl6SHJudUwwSE9aempCOXhuTS9RYmZwRFlMSUhH?=
 =?utf-8?B?L0EyWHhTQXZQVjExN0xGZ3lsVnVQVDVSOEx3ajc5Wit2MnNYdjRkMllSS09r?=
 =?utf-8?B?Y21FUGZDOHI1ak5OQm5WbEJOSndEMmQ0RUI0b216ZVVDTjlOQVRKNVZsSFdy?=
 =?utf-8?B?R3BvMFpzRmM4Y1ZPalRPSVpZSzFHVGQzZHlmZk9yMmdkZzJVU1RydXlNRWxr?=
 =?utf-8?B?NCt3QmdaRlQ4MDFDMUhJd2t2RlJUTDhldnBCWUpWZ3c0djNlUUozRFVaVTla?=
 =?utf-8?B?aTZhYWhDT3YvcDFHVFYwN3lMMVVmeEIzYVMwb3U5S3NqK1JjTnd1RWMxZ1Nt?=
 =?utf-8?B?RHpMVDlrTXdPZmJneWQ2ak5KL2NyL2YwNkpzVmN0cUp3dXNtdlZoVUlUbk92?=
 =?utf-8?B?NjljbjRjOUEzeWpPTnN1b1U3akUzcFpMOVlwWWhuRjRFSG5VcjQwaGpVU1Uy?=
 =?utf-8?B?TmUxV1FWRXBrb0pNUVZJdGRsU1NOQU1leXVjb2hpVFM5T2M0TkUxRi9JbG02?=
 =?utf-8?B?VFdSNEE2N0pBU21SSXd6VHg2bGxUWko5TUxzTFVjaU13VFF4R0tJTm1jbTZL?=
 =?utf-8?B?K3BQZEN6elpHZEZkNFY0YmVKcngzNnN0TXNybGMwenh5WnE2amUzYk5xWnZ2?=
 =?utf-8?B?TmVNNFdCdzQrOXhkbHdZdkxtc0VSeGlycVJEYVhwZU5qVWRQMGNMZkl3R21i?=
 =?utf-8?B?bVpUVmlpRHM4UGdKRG5iOHU5T05SbTFPbk1mR0NpdzlMQS85R1NmbXpqdmRO?=
 =?utf-8?B?RHNMSVFZc1JuTWE2UE9tMWFmWkZLbkcwem5vWG0zY2pROTh2N29TWEsxdUlX?=
 =?utf-8?B?YllsaU5FS3F4VFkrSVdDeWtTSjVkYitORmxrMHdoSFpPaWZGZ0Y3bmI5UGM0?=
 =?utf-8?Q?42DyiXPkcv5ZHuT71bSIiehunGP2wrtPD06cjrU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307a8712-5a94-43f4-836f-08dd7ee0674a
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 01:20:43.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3646


On 2025/4/18 10:29, Longbin Li wrote:
> As the driver logic can be used in both SG2042 and SG2044, it
> will be better to reorganize the code structure.
>
> Signed-off-by: Longbin Li <looong.bin@gmail.com>

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thanks,

Chen

> ---
>   drivers/pwm/pwm-sophgo-sg2042.c | 62 +++++++++++++++++++--------------
>   1 file changed, 35 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
> index ff4639d849ce..23a83843ba53 100644
> --- a/drivers/pwm/pwm-sophgo-sg2042.c
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> @@ -26,18 +26,6 @@
>   #include <linux/pwm.h>
>   #include <linux/reset.h>
>
> -/*
> - * Offset RegisterName
> - * 0x0000 HLPERIOD0
> - * 0x0004 PERIOD0
> - * 0x0008 HLPERIOD1
> - * 0x000C PERIOD1
> - * 0x0010 HLPERIOD2
> - * 0x0014 PERIOD2
> - * 0x0018 HLPERIOD3
> - * 0x001C PERIOD3
> - * Four groups and every group is composed of HLPERIOD & PERIOD
> - */
>   #define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
>   #define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)
>
> @@ -53,6 +41,10 @@ struct sg2042_pwm_ddata {
>   	unsigned long clk_rate_hz;
>   };
>
> +struct sg2042_chip_data {
> +	const struct pwm_ops ops;
> +};
> +
>   /*
>    * period_ticks: PERIOD
>    * hlperiod_ticks: HLPERIOD
> @@ -66,21 +58,13 @@ static void pwm_sg2042_config(struct sg2042_pwm_ddata *ddata, unsigned int chan,
>   	writel(hlperiod_ticks, base + SG2042_PWM_HLPERIOD(chan));
>   }
>
> -static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> -			    const struct pwm_state *state)
> +static void pwm_set_dutycycle(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      const struct pwm_state *state)
>   {
>   	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
>   	u32 hlperiod_ticks;
>   	u32 period_ticks;
>
> -	if (state->polarity == PWM_POLARITY_INVERSED)
> -		return -EINVAL;
> -
> -	if (!state->enabled) {
> -		pwm_sg2042_config(ddata, pwm->hwpwm, 0, 0);
> -		return 0;
> -	}
> -
>   	/*
>   	 * Duration of High level (duty_cycle) = HLPERIOD x Period_of_input_clk
>   	 * Duration of One Cycle (period) = PERIOD x Period_of_input_clk
> @@ -92,6 +76,22 @@ static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   		pwm->hwpwm, period_ticks, hlperiod_ticks);
>
>   	pwm_sg2042_config(ddata, pwm->hwpwm, period_ticks, hlperiod_ticks);
> +}
> +
> +static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
> +
> +	if (state->polarity == PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		pwm_sg2042_config(ddata, pwm->hwpwm, 0, 0);
> +		return 0;
> +	}
> +
> +	pwm_set_dutycycle(chip, pwm, state);
>
>   	return 0;
>   }
> @@ -123,13 +123,16 @@ static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   	return 0;
>   }
>
> -static const struct pwm_ops pwm_sg2042_ops = {
> -	.apply = pwm_sg2042_apply,
> -	.get_state = pwm_sg2042_get_state,
> +static const struct sg2042_chip_data sg2042_chip_data = {
> +	.ops = {
> +		.apply = pwm_sg2042_apply,
> +		.get_state = pwm_sg2042_get_state,
> +	}
>   };
>
>   static const struct of_device_id sg2042_pwm_ids[] = {
> -	{ .compatible = "sophgo,sg2042-pwm" },
> +	{ .compatible = "sophgo,sg2042-pwm",
> +	  .data = &sg2042_chip_data },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
> @@ -137,12 +140,17 @@ MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
>   static int pwm_sg2042_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> +	const struct sg2042_chip_data *chip_data;
>   	struct sg2042_pwm_ddata *ddata;
>   	struct reset_control *rst;
>   	struct pwm_chip *chip;
>   	struct clk *clk;
>   	int ret;
>
> +	chip_data = device_get_match_data(dev);
> +	if (!chip_data)
> +		return -ENODEV;
> +
>   	chip = devm_pwmchip_alloc(dev, SG2042_PWM_CHANNELNUM, sizeof(*ddata));
>   	if (IS_ERR(chip))
>   		return PTR_ERR(chip);
> @@ -170,7 +178,7 @@ static int pwm_sg2042_probe(struct platform_device *pdev)
>   	if (IS_ERR(rst))
>   		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
>
> -	chip->ops = &pwm_sg2042_ops;
> +	chip->ops = &chip_data->ops;
>   	chip->atomic = true;
>
>   	ret = devm_pwmchip_add(dev, chip);
> --
> 2.49.0

