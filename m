Return-Path: <linux-pwm+bounces-5575-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28E7A940BF
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 03:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B0B3B8878
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 01:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F370831;
	Sat, 19 Apr 2025 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DDN7kzsq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD10D3398A;
	Sat, 19 Apr 2025 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745025205; cv=fail; b=dG5oByf9i9QB8/iXbr3rXHuSSDakVvTD1tGQ+nMHviHTQl8uNO+2HzP4FvB48Y+CLQX1lFz7uoDUwvWXYSB4Ht7tIiqR1mZ7LM09bYdm5vJEI7fCbd+qwNggCiFSCKmVL46e+MiwQ1YK2NyJ+pql/ztEv+MmGa4Wl0hFGeKElME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745025205; c=relaxed/simple;
	bh=J7W0cAhYOL7URNz1rjCZmxah6MggovUYf+cdNgvsCfk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+9EUcSTyemlOuV/ucgNY4Q1UzdpLf+e0rzkDmbK+wxxUcNaCsAqAw8UDGEmAzyFPs3Y6M9NhrIe7cINbMKyOEwL1EJLVCF/te7lD03OYBV+kL7PPjvRMSePum1DFQgf3rIImSrQOYK+xlIxybqRp0eLjDrlY5qV81ZpkXyjikU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DDN7kzsq; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9oGrScYJKUX88VE+67nfv11dqlfgy4UxPycoV9Z0ei/dzSXCEiDcuDhBQPT6m4NlKB+vSGcHCOHhz3cBiTiyj7FMMtpmbEGCb9vRM5SpVYZl0BgkxYFdVQF/wSgVQ76eTl8LTVMqmwBA9Gf3qdSUjfTNJPsBHwdYlK4IM0R8QrdI10uUGX1qa/zS2w8ycNAAfFplc53tahLrwqKdyFl1e21G50ug4RqlmERLULxv2cWCzM7ewcBK5K/RS7/g4aqSRCkHKKeiKzo7qwypdsSDr6ph/gtych+HwYzZI+eesAe1zPZL6VkVa5OMA06BNvcMX3CzRxIOXFEflCKiQKeug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RjYxmDXk+a1tCjaHKNET6TWW4L3IM5aayNkGl1IF1A=;
 b=p9+UpNSt+wSOhTFZdEsFMzKyf2teFltjG0LVIAZEt3jeaxkXS2sjq/TYkcLGBt++Ua+znRzs+KLJv0gT4XcM9CG6ZiVVfKfMA+ApLFbqDVracJjX6dSWAm6+1tfEIRCvOcAslFz5FAiRRW994wkoxG5qPC4Z6c1Hdkhli5wDp/RayYM1MSoLfPEQZQFDWwDTzlN6Jdp/pxFRwMbCO0ji3Y4pTdjYuSAT04Uc2mOLbmJiTGh1l6WPtIsMsUfqn2g+yRAQ7msa/RQKZY2Hj9Oa2sMbUVHun93QxM2B2PS6mfWaicaX+Y26DP3R9Ogv+WRDEXwLZFz5j1L6sc2X/DEqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RjYxmDXk+a1tCjaHKNET6TWW4L3IM5aayNkGl1IF1A=;
 b=DDN7kzsquM676sXkEjWAEEucNIXekny2BmoJd3zBMfTCANlYi4je0qbbOdZyWBRacYIxRQjv9S57p1zf3BW5Gjg/fAS0kGELP4K9u9pdQ7iq0yYwJt0q+xUy3+oh3BhAbHXOV2SyfpNUeXHxpZzoSOb7tnTjcX0Pfy2TJe9yb/9Cm1mNjctnCRbXNQ8pecqAo/Q9YRYrOz/nupyuuAQjn+B5QIu5Cu/JhJAntn0AutUSeqhGEU64wQLQXlyQ30odBF3s0a0Wv0zXPxna1O398m9ItSKJh8b3qc4p+py7T9IgivDJdyJKM+StUdFnRryHDUXUK+55P3Vdw9jOE/vTfg==
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
 by PN1P287MB3593.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Sat, 19 Apr
 2025 01:13:15 +0000
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4]) by MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4%5]) with mapi id 15.20.8655.025; Sat, 19 Apr 2025
 01:13:15 +0000
Message-ID:
 <MA0P287MB2262745872348EACA7E3DDEFFEBE2@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Date: Sat, 19 Apr 2025 09:13:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: sophgo: add pwm controller for
 SG2044
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
 <20250418022948.22853-2-looong.bin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250418022948.22853-2-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:100::6)
X-Microsoft-Original-Message-ID:
 <b6b460f8-03a8-440a-9b99-609a6a42e786@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2262:EE_|PN1P287MB3593:EE_
X-MS-Office365-Filtering-Correlation-Id: 74365edb-c9cb-4390-1460-08dd7edf5c6c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799003|8060799006|15080799006|7092599003|6090799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFduTG8vSFpVUHYyR3owRnZGbHNiaG5PUkpJL1RqUVpXZWlybjVEZjQ3b21q?=
 =?utf-8?B?dTV0aVZwYjRLbEE3VHZyYXUvdXJaRDJNdU44TEFsZHFTQ0Uva3JHRG4wdmhi?=
 =?utf-8?B?d1VFcVpiNG95aW01b0JpZDkyK3RjTFNqZGNtK3ErdUVBeGxWUmNXcTBoQ2w1?=
 =?utf-8?B?N0pvaHMwT0dZNXNDbDNJbUJWWWJzVmpvNU9ZSHJIZ0NJakEvTnhiNDJZeWts?=
 =?utf-8?B?KzZkVE5ubExUdzFIbnYyUzJyZmMyTVB6WVJuK0k4RzhSNXRvMnhCRUl6eFlK?=
 =?utf-8?B?WU83d0ZzTmVNc2RYUC9xV1RnRWEwdWxtVEpKdldlRmxSSXJ4TkREYURzWlAr?=
 =?utf-8?B?UWFyeG5iYWcvaWYxYXRLb0JnUUd2WGU2QnVIVm8rbUJUNjkvd2JIQ1loNUVm?=
 =?utf-8?B?VWMzTnRzWHQ0UU16UG53cnNNaGZvN0FBQjliaEJadmlGVGpzQnZnZDE2a0dy?=
 =?utf-8?B?ZVkxUWZiemhEbERqYzJ1allITi9RV3BUcG1xZnFabE42YkZRdnlVbjdaUmpJ?=
 =?utf-8?B?R3BkcEVkRUZ6WHBmdFhpU0hQaXBORnNPT2F5WmhhNGIzOUZyVEMwcHhzQ1pV?=
 =?utf-8?B?ZGhlL1pyT09wV0J3ZzF3c2ZCb3R4d0dHTGttSHhLK3lqQWpoeFR0L3g0QVZl?=
 =?utf-8?B?ZTZEM1JwWWxSNXMzV2F5SEdPRlVCN3BYRlhuRFMrRnBsaHl3U3haNXlRQ3JQ?=
 =?utf-8?B?eWxpWVE5bExsMkFjcEErUUQzd3orZ1FtYVZ4RURjQzZnV0JqUGlsRXZkYXpw?=
 =?utf-8?B?TFlSMCt4Q3VRaEh2WEt1WVZva1hNcmNQcEFvVG9JcUtwb20xZkl5aFZjTkg3?=
 =?utf-8?B?K05NVlNpb3lKSzdTM04zOTZkM2FqSXFrNzlYSTlaWjdSRGF6SEVYZHN5QUFC?=
 =?utf-8?B?aS9NeldOem4rb1dxMFNVUUNUQlVzWjFlZVN1RUZITWRmOUFJN1ViT3k0WmVR?=
 =?utf-8?B?b0EvbFU4YzN2NWhlamtMeVRXb1hhNGdPUC9DUWhVanRsVVYxZWFHdjVCSGY1?=
 =?utf-8?B?TGFSODFINFNUbjJZdDBsYXNlRXgyWXN4cVhISHg1SFJlaHhpeWFsQ1VrTFRs?=
 =?utf-8?B?K2FHazlIZm5oL21GbHpjOXFtUUVUNnF2VEhYQkxPd3pPT0JwTXdlS0pkSzlE?=
 =?utf-8?B?dzFkUUdxWVhMYWdlaXgrUG9pSVYrSHZJU05KeHVEMGdJbTBEV1c4TllyZUYw?=
 =?utf-8?B?ZnFmbFdrWHpHZGV2TkRJTlg4WXdoVEJLMHB3ZG1ZSW9ManU4YjdibWdoWDhO?=
 =?utf-8?B?YmhHT1dCRFJ3eUg0c1dpUnFqLythdnRJY1lDSTV4bFd0OTZidjczMkw3RFhy?=
 =?utf-8?B?MTV2aXVtTDUxWkRVRjNBejhHSFNjbXhzSWkvUHViOVZvckdaUHE2VEkzTGM4?=
 =?utf-8?B?QzU3c0I2SzBUd2NicXZnc3RGYk9hY2xqRjlsT0ZFeXNKaHpPc29CL0RNSHZX?=
 =?utf-8?B?V3BvZUszbFl1dmhzQnN2SmcyMDVpU1BOUEZSSVkwQ3NwUXozeEQ4ZEhndkhI?=
 =?utf-8?B?MEJHWFg3cUJDRERleFVIQWZPVTA4R1oranhmMld2RkJZYnBTVm8yOXA5cDBh?=
 =?utf-8?B?akZUQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjA3dHNabDFhNVJDeVJHSGd4VENhYWY2dThuTHR1OUtzWENiWGVTRnc4TERW?=
 =?utf-8?B?V3FNL3d2M050UjhoTjNjcHhaTVM4L3NkRHdNVG8ydTdIalhYbzhWaU45VlE0?=
 =?utf-8?B?MXNSVGF3Q3hQQ015QTJrRWVtK1dpc3ZyYXhRamlaUTNMTDhwYkk3di80SGw1?=
 =?utf-8?B?YjBMaTFTWlNOM0oySXlrUmNNUHBkR01CbkVHNWt3MnBoUTlTaGZDRUc0RjUx?=
 =?utf-8?B?RjBZb2o4ZDFYZW0zdnpXZDRDUENHV1YvYWZidW5OMkxwSVY1Z1RoNjlVMHk1?=
 =?utf-8?B?NWpiY0duck56Y0tYWkFWbm9qbFUvcm9XYVJRNnJDdVY2aUcwd1NGL2Q5a2dL?=
 =?utf-8?B?NDdac05nd3hmekRmVUlEVkg4OGt2bEJsT2RONEMzRmZ5cUwzdTBYUXN3VmtF?=
 =?utf-8?B?eHE0eDlYMWJhTTB3K3c1dmxGcmhiWDg1U1k2RmgvWVJBSFVJeWg2dGl2ZHJ4?=
 =?utf-8?B?NUNOM2RZUDB4Z09XOW5BbU9LYUZuWTRNTVVSdXplUG94b2dXTy9Ia0VBbFRy?=
 =?utf-8?B?Y3FKU3lub1d5QytoeERtSStQSG51TW9qaWVZU2NVUUJMVVc4ZFd0WXkzM0hX?=
 =?utf-8?B?eE9mRldlWjFuQWZxUXd5NDlVTm1GYzhEWEdYMEVrZWxOSTVzWm9PQnFDRlZs?=
 =?utf-8?B?TjlBUWcybEFNUXV0ZnVDQVdsWm84eFFJQUp5MWFHOWJlSEdHaHFNdzU1eVls?=
 =?utf-8?B?dHdFbXVHQU1mM3d5YWRMZ3BpNy9HOUtjNzVRajRRMTlqNDN1d21FU1JqUGdo?=
 =?utf-8?B?UzRPdGV3ejJkRGQyOG84eTl2TTJ0YVZOYjlmVlZLcHpLTElnWC9PaVNCZWFW?=
 =?utf-8?B?cGxDbEdyVG50c0tSRmY3VTRyOExPb3krMmJjK2lFOWdSemJWeTIwY3lqYzE3?=
 =?utf-8?B?YzNPa3ZGeE1WcW1jZURWRVE1UTBXdjc5My9YL3cyVmxTdVE5dEc0Snh0RFgw?=
 =?utf-8?B?WHI3Mk95NzZDVUxUM2ZvQUcyRThNS3NkNk1ScHAzSFgxaXZETmo4MEt1NGtQ?=
 =?utf-8?B?WVVibFFWRFp0cU1tNnp4Uy8rb1RjcGx2SEZIcENKZjJUbFBwS1FYeUk5OFMx?=
 =?utf-8?B?R29VTGxFaWxmdTF1bHpTRjg3NHhRQWk2RmJLRUlueTF4S3dDTGdac3NMUnNX?=
 =?utf-8?B?VDZtclhBWDhNNVU1dWg5R0ZtR1M2akN2VVdWWmlONlZ5c1RYMFRkODdWQmNO?=
 =?utf-8?B?bFk0Ykp4UTQ5S0l0MlFGS3RHTDBzM216NHE3RGZsaTFtbW5rS1pod2srdUFI?=
 =?utf-8?B?YVByUVJoSWhrSnRTSGVZbnFUYktZUWtzWko4WmpnVS8yTG9tQVBldytmYjc0?=
 =?utf-8?B?aDVLWmJ6RUkvMG1RdmZ6NmxIMjQyeUtCbjJvT2JDRjBtTjVXUTEyYkR1aDcz?=
 =?utf-8?B?VXRwdUdhWWFqdW0zaG9LeXpJK29NbnEvamhkenhyS2puNkFycSt6a2J4L01F?=
 =?utf-8?B?bkxtZzhrcDZVZGlPalo0Nll0MkluakRHNjlVZTZYZ0NjVDNFYVJMU1RMNUsx?=
 =?utf-8?B?TTVTT1ZReExsZmpFLy8yY0lJQm0zUndMQW81V201b3lXSHVGdjlDS2pYb1Ez?=
 =?utf-8?B?bFh1emE4cWQ5aTFkVVVRaDB3Zm5UWnQ3MW4yc0lKRVNZYThSak05a3ZTalVo?=
 =?utf-8?B?ZjhEc3JnNzB5S0xtV01LZ2R5ZGNyMFBKSjAzOExyZTVtcGhaZ3dQdUx0aWVj?=
 =?utf-8?B?QVhBR1lzMXVqQmZ3T0FpQ1Y3b1EraWpNLzhERnFFenhRL2N3bjUzWDN2djNF?=
 =?utf-8?Q?w3TmFGZq9x2KNyTncz90p4r3SZLg6dKb8KmiQqO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74365edb-c9cb-4390-1460-08dd7edf5c6c
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 01:13:15.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3593


On 2025/4/18 10:29, Longbin Li wrote:
> Add compatible string for PWM controller on SG2044.
>
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> ---
>   Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> index bbb6326d47d7..e0e91aa237ec 100644
> --- a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> @@ -17,7 +17,9 @@ allOf:
>
>   properties:
>     compatible:
> -    const: sophgo,sg2042-pwm
> +    enum:
> +      - sophgo,sg2042-pwm
> +      - sophgo,sg2044-pwm
>
>     reg:
>       maxItems: 1
> --
> 2.49.0

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thanks,

Chen



