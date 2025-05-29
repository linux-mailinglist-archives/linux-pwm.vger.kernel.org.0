Return-Path: <linux-pwm+bounces-6169-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E8BAC766E
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 05:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E3E1888805
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 03:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC30A20E6F7;
	Thu, 29 May 2025 03:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Iid3cXLi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36332EAE3;
	Thu, 29 May 2025 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748489280; cv=fail; b=c2ZxCz0K+4u3rFaUMQBYfmrgHfrGMey569Jb1v9UJrBEQawtwiXnwwqtUeYjl3BaweItCIRxRHDupvshbBf/df9vlMmRhIyFckKKvp671u5UoskvehikWM6le2t9oofZiAl6SFfxE4GR7e88uubLPY0NZ7vjAacJL1IrObTsqHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748489280; c=relaxed/simple;
	bh=zFbTv0ri166bW6ucMi+TkTfWK0Cpv26tQY46ndcgP6E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kf8Ea9/jcjy2ffKyF+VW8Llsrim4SCxIeSWuktc+RE0WLSr/qWTzcUun4JC6JhKOSr81Vwcl62NaOJMwHqpWXJKyM/nWJbs65brA48uptUvViubLCjpAjJXszvCq9DcbjNWUr1J1XYcEpkOLnjntRwVSgaLWBxj15t/Fhoe8ouE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Iid3cXLi; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K87zwCj+Ne4GIPuNDqdLC88SlkDpAk7WBTL36qNlH9qgPO80K7m0WBva6IEKcYlPZvPOMYJCMYiBEZpb/f2evnxj6EerAfRooKxb3LWgo8u5aNBaei5MJg2S29JpfdVaQ++JwgnlODSFwdzaAgAaAWpDet0eNIV9SmFfV5F2h8IZb1gD6BxFDAHyBu240CWwZHYE36LFTN/V5Vev8btOhODvubmPX+u3P8i5Bwn2AFyxD4EHyOnFM0hmSUdPYArF69IADXGL9U1boVldaA9FgvczYI+M8eGEMSbOnfqvR9qWsnhClPepca33fmA7KZau4B44dr3PHTmt0/zM42UI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wvo+w60nQlstCPOpF6pTVO34Hbb9ZCA0VHvCfan99Ps=;
 b=FUeCUMbQ7XgfCIDZo2dMPTVBYeL8R5q08Nn62rH8kfY+wF6uGmsYP5rVzsSlbNTzsXUfVbi6AXemlRRnaEIYYnx016bwSxEDrhXZvBsmb/NIrYkhNqJl2o4YrjfOTxvrqgQDMrf09+uZT4gIxO2Nuhjhd783d3dn/bGdk72ZA0PEFWUtlK2EgPzh0b8eDA2iWb7KmQsRDRtB+cQihOZQBaQbJQTtmtmuUHQm0DVNMA2BlkTfB5cNOszXQOQR11NERRpFnxqixWi6MXk9/kuiRFcJ/SoxQ1sONF7oJpCJ1FJvMQKYwJXJLvUMNEwU00GzUTwaUPKn83JxGYcjuEMqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wvo+w60nQlstCPOpF6pTVO34Hbb9ZCA0VHvCfan99Ps=;
 b=Iid3cXLiOeV2FXEklgeRhrnQDsG5RJujtoAlVKdi4oEq5Q3Pu70H4OL38svxQyOGcA/VzSIcFgpIHhVfnY5QFaY7OmJOZGWjDX4sUqt0H88ITG0PFpf7Y6DvfSru7VEJtNk6d+BlgMHSOg3TU9x+RwLAi5cuyuKhxOOwgqHUFbeSemOmqBXeJY5wpMbkPsfZ0J6n6T8TPA/UjOcDPJpfFouKCZTK42V0LEORPoDg4GDQcnLexzOuuPXFlBRNnG4gCCelq5EDNyazrcvOttW7GQIp7DDijoTuhr+mhLWQIpXtMxNxVT8BEq6emSzkr6f1JoCbhvyIEgkqQFgUPHqnAg==
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
 by MA0P287MB0555.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Thu, 29 May
 2025 03:27:50 +0000
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4]) by MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4%5]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 03:27:50 +0000
Message-ID:
 <MA0P287MB22623CDDCC0156327B446B32FE66A@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 29 May 2025 11:27:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] riscv: pwm: sophgo: add pwm support for SG2044
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
References: <20250528101139.28702-1-looong.bin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250528101139.28702-1-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:100::6)
X-Microsoft-Original-Message-ID:
 <83e4a554-c4a4-4c99-8f9f-d4a4912ccccc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2262:EE_|MA0P287MB0555:EE_
X-MS-Office365-Filtering-Correlation-Id: eca71ce3-5709-49b4-e570-08dd9e60ca25
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|7092599006|8060799009|19110799006|15080799009|5072599009|1602099012|440099028|3412199025|4302099013|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEx4NVVHbGpRZ0dIZm9RM0lXOE0vSkNmcjhGQnZpZXZvdW5lOGl1QmhuOVpa?=
 =?utf-8?B?OU5yNXV2dDFPOXZVNlNhNVJyUDZld0lGL3FGditIaU1Kb0NIelBFbDhiQ2Vx?=
 =?utf-8?B?Z1FXclVNemJOU29OdWtBU2FIdUZqcVo0NU5ONDU1UXZUdlpHN21LbEZvQlUy?=
 =?utf-8?B?dXJRQndXK3FJZ3JkMGJLNGNRcXNGV3Z5cVJYWmdUd1Y4SDhxTnlOZ3orYWQ4?=
 =?utf-8?B?NWZ0TVl1T0xwVHZ1TVIwekVMOThKUEh6T3JKR21VS3RIMEtDSHIyRXNxbUlu?=
 =?utf-8?B?b1BRVzNTZldVSVo0ektKTlBGcWt2Qmk4Z3NIZ2FmL1BuWWtiQ3pldldHZHdV?=
 =?utf-8?B?eGRUN0VCc1hTVU1WdWRiZFBlaTY3RG1COEF3Rk14SEYzeXYyVkJML1NLVEFt?=
 =?utf-8?B?dEdRNkcwdUcyOVBnVUtVVmRMNXE2Tm9Oc2JYeWtJSGcvV21hQ2pQN1FJeHZ4?=
 =?utf-8?B?bHVmT3lsd1EvRm96cCt6NU1HOC9wa0svZ2k0MEdHYkdVRStIeGFDeXRUY2tP?=
 =?utf-8?B?Z1JTQW1HUEMyaXZvdGpuUlNQMXViLzFYZTRzZzFiR05CZHQrQkFEYlRwY3pz?=
 =?utf-8?B?b1NCLzB1VU9tbTRKV2hKTnk0RnBMTURQRkZZZU9JektnMHV3VFZnTlVVNDIv?=
 =?utf-8?B?ZXN3SEx1SEdvNVRZNmxMNDkxUTR0NWJvTVNPOG81M1E1SHkxNGN6MW15S3cy?=
 =?utf-8?B?clNkMU9aalp4YXB3SXJoWEdjOUNtbmNpb0loa20ybm1tdFk0THVyQzhmSlhI?=
 =?utf-8?B?M2JaMzNmZFlQL2xrc0ZCNzg2bHZrcHdIcUQ4SXBxWnNEQzI4OGl1OVcxNGdt?=
 =?utf-8?B?dnZ5ZUY0RkZpL1h6MDhzdzB0NDdkbTc1QU5taGZKZ0ozYmtuTk5JcWhEWlM3?=
 =?utf-8?B?Vmp5QUtPTUFrT0NnRTEvd2JhUmJrb2gzaU85eW4wMlNNWERGLzd0Tmdrdyth?=
 =?utf-8?B?dWRneEkrQ3NVSGk1S2RwRjVEQVJzcDUvdGRUWUs4ZEV0clpxMVlocXRTMm9p?=
 =?utf-8?B?ZDhNdC9YUnBZM2kva0JiWVJRKzhvZUdya0p4enYzVWluWFVuMUQ4NFFxRmtl?=
 =?utf-8?B?eEQ1TVB5bS9xeUFPMzdPU2pKVGZITjZOSjhaYWEvYThTOUdDVjRtbU0wbzhi?=
 =?utf-8?B?Rk43L2VPOVplVFdQR2tsQ1c4cFRlakdEMzc0ZDYyMFEwU0pIUnRTNm9wYjNp?=
 =?utf-8?B?VHlsQnRwMVBMZ3YwVUZhRjVLaGxLK1hrekczUW4yenZDRStIaUNrLzErbmt4?=
 =?utf-8?B?cnhsMHVUTUZtcXRUazVYdlV2d3dIWDFPUEhhem1oNEoyYnR0UVlMZzBmR1lV?=
 =?utf-8?B?dGtzbGtwemVvNGxSRmx0bGlOSklFT2VPNWgzQjBkUk9oZEdqNFRNQ09RR24x?=
 =?utf-8?B?UGFwaUJ5NmtNTmZXZVFlRVN6MGxpdEJuRWhNWDVud1cxSzY3bGZpQ1V3YTJJ?=
 =?utf-8?B?L1JEak5vUVhkZHNyY0RiclBGYU42ai9NYmJ5WDBFQ1Rqc1JTbDhlemxDdThM?=
 =?utf-8?B?YnZGb2dZR3M3MktDc1VCdTZ5b0Q5aEZiTDhMOUlMWWQ5Y1ZIQ0hUK3lNd3pq?=
 =?utf-8?B?Vkw1ZzJRZ2tiYytheXFxc0ZLRUtxRi9RSmFRZ29ncktLV2R5d3VvUjBydFB0?=
 =?utf-8?B?dkljNkIwQ1dFK0pkS0NjWkpvQjEwU3UxTmV2ZkNtcDlJMFg1LzJPQmw4eWtE?=
 =?utf-8?B?U0JaZG9zdk9EdklRcDVZWS9zbHJQRHVyZ1JGWTRVNE5QRlFDSXVNLzQ3cDBW?=
 =?utf-8?Q?Xk3VZl71pb+6a//weKzXWK2PBbWKxgT2xKgyJFG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFExN2pwL2s4Zm9jME9hQVJUWjFQZUtudVJ5bFBEUHpjeEh6OVJjVEhGc1FJ?=
 =?utf-8?B?TUdLVmRoT29vcjk0RG0yTnpsZ2p2U05Jd2ZBd1U5SS84N2FucWVqdnlvczEz?=
 =?utf-8?B?MEtqMDBLUHNtMUdIZWJ3T3NISWlWRkxrWk9vdUNGeGhVUnd5aUJVMnRPMWEx?=
 =?utf-8?B?cUdqZnZmaVhKTzBTSk10Q3pJYjNIdGFvTUkvOHpreWZiT1VoRHhWUElZR2Vh?=
 =?utf-8?B?S0VXSFFQTUNUdk1tc3Roc1Z1K09TcEd2VXI4eVNEUXUzNTdhV1huVnBab2ZZ?=
 =?utf-8?B?dUI1aHU3Sy9aTFYyK3VHYkk2eEo0bmRnNlV5VWhLRkY1cSs3WDI5Mjd2WjJL?=
 =?utf-8?B?cnVUS3JsZUs2QTU1R0QxZVUrVXQxdy9RbWZTZ2JsL1NsM2I1a0t1aWU4a2w3?=
 =?utf-8?B?ODhEaDBwV3Faa1JWUEthWTVLVDlmdms5WHlNeHp1RVczUUVrUGh3RTF2OWhX?=
 =?utf-8?B?MHBjREZITC9TOEE3RU1EaG9makNXODRwdkgxTGZ5YnJlNWlKRElvSUtvUUQ2?=
 =?utf-8?B?WSs2bnB5NzIxakNyNG1BVlRvSXBhNlljejZJQ1V2dVZORXgvM1lncTI0N1NR?=
 =?utf-8?B?WG12RUFpTE9rRHpiVnZENGYvSHBzT0xSVE9tQWVPZzkwZ0F4elE0Z0tRdGJJ?=
 =?utf-8?B?R29ud1dDUExmTUV5MFZtMGJCTzB0SlQwSE13bkptL1FtL1BFUFljUVI3enRz?=
 =?utf-8?B?dW5WbGpvNDM1RGlpMUhHUFlDb2Mwa01VYTJlcHFqckZDSEJLdGFZa1J0bWtT?=
 =?utf-8?B?aHNvcEUrWUJBeFVvOGdtcWc0RTh2bUJiVW4rQm84VllwVGIxSTdiSmt1am5k?=
 =?utf-8?B?d3E5OGhPZlhMMnNCajJBYmJxMlkrMCtWOGVaUXlMWTdzWDRZWDhkb2s4UnZT?=
 =?utf-8?B?UnZaM01vYzE5cVNwWlpySmFXazh3d3ZzQmg1Zkd3SERZYmxSREd0NVA1cjJY?=
 =?utf-8?B?YXRlY1pVSjYyd3IxVE1OenlidElmVTJmWHh4S0NSR0Y2WE9VcVVBbmQvSC9p?=
 =?utf-8?B?T1pqc3ZXU1VKWHlMY0lBRExXZkR5OVEvV0VtSjZzVHpLNTNXdkowdjlKSHRF?=
 =?utf-8?B?LzdjajZEd2hua1ZDZUs3d0xyYU1EU1lrMHkydEdlbnJ6QzMwYXRFUHdVOU5W?=
 =?utf-8?B?QjlEQ0I3SmFOc1NoV0JPRnJlbkdSRG9hQlhjaE15K0FpZFJIS1JmQ3BaQmRO?=
 =?utf-8?B?b0VQaWNDWCtDdWhPOUxnQS9Za2hxM0x0K2F6ZTZmM21LUWRPTlk5VUdaUUZJ?=
 =?utf-8?B?aVJVS2VkMndielNLMEdlemdMYmNjbFc4S3VmSzg4UlNOQVpqaDErdVptaHlR?=
 =?utf-8?B?QWk2ZmcwZ2U2WmdHR0hjUDJrUllhSUx4YjhvazNmaGZObm4wU0FUVUd3TlJw?=
 =?utf-8?B?SVpmQjhkRTZEU00vNjlRSitJM2dkMnhra2FYVlZ0REt3WTNQaHNJNXJyQjNJ?=
 =?utf-8?B?ek5hWG5WcktaMmRIWW5sUWFBV1Z1NjNZcXp3VGtRdnZYMUJNYmkzUUNHWC9q?=
 =?utf-8?B?K2VBN1NyMkVIN0czajJKalh6NVVQUFBTOElDVlE4eS9idUhWMWFPK1BaVnNX?=
 =?utf-8?B?NDcrQ0hLYTBGZkMyZTNMWGYrTGo2YUpKazlrcyszb2Yxa1Uvckt1SEhIMXBs?=
 =?utf-8?B?dlNqNEpXZ01MVnFxY3hVdEFYRkpPSzY1blZWUC9SY09zVkJVYU5OZTg4RjNn?=
 =?utf-8?B?a3d3WFN6b0dVb0dEQko0Y0R6Y1l4bnd0MHkzMFZYSzBZM1lIa3N2TU1ZNHdm?=
 =?utf-8?Q?GQAmYP/Di40DLYUo6lf5e1Fv0uqONPxSm3UX8mR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca71ce3-5709-49b4-e570-08dd9e60ca25
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 03:27:50.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0555


On 2025/5/28 18:11, Longbin Li wrote:
> This patch adds PWM controller support for four independent
> PWM channel outputs.
>
> ---
>
> Changes in v5:
>
>    - Rename function and variables for clarity.
>    - Modify code style.
>
> Changes in v4:
>    You can simply review or test the patches at the link [4].
>
>    - add tags for mail.
>
> Changes in v3:
>    You can simply review or test the patches at the link [3].
>
>    - Rename macro definitions to unify naming.
>    - Modify code style.
>
> Changes in v2:
>    You can simply review or test the patches at the link [2].
>
>    - Modify variable naming and code logic.
>    - update "MODULE_AUTHOR".
>
> Changes in v1:
>    You can simply review or test the patches at the link [1].
>
> Link: https://lore.kernel.org/linux-riscv/20250407072056.8629-1-looong.bin@gmail.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/20250418022948.22853-1-looong.bin@gmail.com/ [2]
> Link: https://lore.kernel.org/linux-riscv/20250424012335.6246-1-looong.bin@gmail.com/ [3]
> Link: https://lore.kernel.org/linux-riscv/20250428013501.6354-1-looong.bin@gmail.com/ [4]
> ---
>
> Longbin Li (3):
>    pwm: sophgo: reorganize the code structure
>    pwm: sophgo: add driver for SG2044
>    dt-bindings: pwm: sophgo: add pwm controller for SG2044
>
>   .../bindings/pwm/sophgo,sg2042-pwm.yaml       |   4 +-
>   drivers/pwm/pwm-sophgo-sg2042.c               | 141 +++++++++++++++---
>   2 files changed, 127 insertions(+), 18 deletions(-)
>
> --
> 2.49.0

No major changes, LGTM.

Chen


