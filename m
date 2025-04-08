Return-Path: <linux-pwm+bounces-5368-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF46A7F1F5
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 03:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5125A178E35
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 01:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540753597C;
	Tue,  8 Apr 2025 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cvKPMdKE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010011.outbound.protection.outlook.com [52.103.68.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE931F19A;
	Tue,  8 Apr 2025 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744074165; cv=fail; b=qryj8cAGJl9mt7n/19kIb3VwnILIjxhRUM216FafVv0Ow9DqfmkJK6pvkXKZUGpIRldFNKpiOMLbJVknNBMX3XVSCvCO7KdEDuReFZj/+PSxY927zhppXTzsfSImU0bE9lG46166IKte4r+hFnqoePiP/VewNbkVMpnBbLpMJDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744074165; c=relaxed/simple;
	bh=wfmVkwS57RzVTL7JAfTneAtjBGVcj3/UV5y9gDZqxnE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TzwN+xks9mN3h2yIt5ItY7ZVXtJAeFmXu57eynvePXYMNGlXFAnsRJyICACxLd+Uc2+HPHORk+pA+jex1eMALO2sBXacRwa13v0Af+36mSta/aJZNwcn0oAjofzdfdcKLwHGbsOxkHB/0huIDtoZxZG8NM8Yjomph7tpTvs0Y5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cvKPMdKE; arc=fail smtp.client-ip=52.103.68.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+WSWhAHcT/zRWga6pjRTyc2rGHHy+XZ9ve6ZRi1bdDMW/VGv5U64TolLPXswEPYt/jhB22Pm2dqesSNSo73hUEyzJwdlURYEDPvQph/tIm3xGUy24yWZaPPX0TOF0GxY7m5A+2LzyGewuQbaWoLoLSX+UtPdp556NhfGfRD2KPPxSCCfsQEzFtcSUxsMffj8TrReq1BVc4paV47d5rR4BvmFja5p5i55ZsULirbPKBUalbuJJgAKa5VHCDvQOqMt906erOtPUdc9ZA6rfuPKE+lneS4cvIjETBVGFIe2wq2bM/SsTnTzXsTenwirdGsLyruUiUgn/VSsGmGYTZBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Xw7TzHFkJizfToxcVyK1e7m1J8hPgMRM18s6vFQdew=;
 b=BSJ9ECwn1BPFdSFRQWu6IXziUW5wDb7ClkS1YEwykZwVH4ZZf3QcjNpvyMLdpsP8cTOECFKxh5eQpNnaONsJG2dBJm8PwCeI+TcZf15TOI9zIeuVwwPGXG8z3GakKrgXW4Kz6Mx3Z1+1qYh1LGc9eWE9pTvPDNOMPo4rveDlkv6/sN+DGP8WnGLV1o2hKfsh9eMiI66q0PCymtMLM6vDmaKs0hoqp+LH/Npp7zUcwXoJqMzg/hiFOZHYHQe1o65OLmMLnF9B1VPApgMZUCg2RbWaiy5O/qHU0e7VEAoWKQrUmqbD0D7P15KucUEUPMCoYwuaH++x+zah4D7E2wUkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Xw7TzHFkJizfToxcVyK1e7m1J8hPgMRM18s6vFQdew=;
 b=cvKPMdKEiOucnT0mynxdaa6+Zq7U9HnH3wGrZo6YtrBH8+aJKcDEsMRNqkNcGTQUdt70TfT6HrcQIU+iHs+QBU5LUBLVTV2a2tVosaVMPrDDlqCXqY7KOFAYCMZKXIsUC1nmm1d3DuJ60pKpqHJi/sMYjhK0/uy5u7m9FOngRxhCQ/2vBA5DCIBWtmq1bnBIXUqx8Fx8tqX9d0mPrsgjW8k/Y6+FOzNIvPMb87eWSlKTl2jKiwYjz5oSmEKSxentsV/MEPaupJjD2uFdlSVuXYp9zmx0LAm2iuWX49KEDAh1cgf+AZtPM/2T+vkg8SmBwybi7gjKmqP7R0uNdUkKlg==
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
 by PN2P287MB1838.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 01:02:35 +0000
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4]) by MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 01:02:35 +0000
Message-ID:
 <MA0P287MB2262DDC10B2983C2AA5D3074FEB52@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 8 Apr 2025 09:02:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for SG2044
To: Longbin Li <looong.bin@gmail.com>
Cc: ghost <2990955050@qq.com>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, sophgo@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20250407072056.8629-1-looong.bin@gmail.com>
 <20250407072056.8629-3-looong.bin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250407072056.8629-3-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:100::6)
X-Microsoft-Original-Message-ID:
 <6f81b548-d884-4e8d-94f8-e5dac757a048@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2262:EE_|PN2P287MB1838:EE_
X-MS-Office365-Filtering-Correlation-Id: 798d23c9-1682-4e03-2c08-08dd76390b65
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8060799006|461199028|19110799003|5072599009|15080799006|7092599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a01WRml1UUw1M241Mjk4RzlIalEzL2RwdW0zK1czdzZ5dnlxSzRCczRkM29M?=
 =?utf-8?B?ZERjeGtQY2ZKckJzNHcvY0pJbGQyd3JQUkNFcUtLOVRQME11b0FPUkg0b1JC?=
 =?utf-8?B?SmMwMUd3N3ZCSnMvODZMM2hhYWVnRmh5RS9IaXUzd2pjRGpDd0plbnVTUUVJ?=
 =?utf-8?B?T1JrVlRRUDdaMmcxdkJWT0R4VzVYUHBwazJ3RTlqazlMSlFDY3ZTUGhDcUhu?=
 =?utf-8?B?aDh0Nm9MWHA5dWNKc2x5SndZQlhja0UzUFdZaVgvZEQ3WnlMK0tVeno1dVRH?=
 =?utf-8?B?VUtSZzVXenZjRWg1c0tCelljbjgxdEpFV0toMnhNZDN4VStSSGIwb0E0KzdT?=
 =?utf-8?B?S05BY3hzWitIZEM2YXFlVlRLQ2Y3RWRYNXNXOWsrOXVSS0NzUGdEREQ3emVj?=
 =?utf-8?B?SXRXZWM0Mi9wT0JVR01oL3c5QnFXb3B0T0RGdXozR1J2Q25TZ0JGVkdzVXdj?=
 =?utf-8?B?dDVrWDBFSnE4bjJ5Ujhodmh4bXd2aVdkaExDMGFVZVRoK0tXcm12MmRQNUFU?=
 =?utf-8?B?THEyUzlPbzhHbVRQUVBIMkV6T3Zxa1hCUWxYbkxrcVRHOGtmUlBYVUpCMndt?=
 =?utf-8?B?Y3JFYlB6WmtzWEZwS2xQYnFGTVhXSlNqOUdrUDlTZkZBbkRxMVJmK2MvUGFV?=
 =?utf-8?B?K1dBbGJPT2F0aHpUUzUwa29Xa2NnYU5lOGl3Z2VPK0lpZ0lNNXhQWFViTm9L?=
 =?utf-8?B?Ykx6OEdiVWx6UENhRzM3YWFLVFQ5eXZmc1ZtbnFFMUZ5TkE3TG1lNTZ6M3ZM?=
 =?utf-8?B?Um1YVFAvRC9Fc0RzTElwcXM5NkQ2aUxzQ1FRVUNzMXUydHptbUlYQUNrQ0pC?=
 =?utf-8?B?T01pelZXZjJ6d0RoRFowZzVGMTNrMUZuYjEraUJ6WFNQMzE1TnlJM0p5c3d1?=
 =?utf-8?B?LzZCZ0ovT2tXN0xzc3EzMjBRaXBZMFNvQkc0cmdTL25vb0p2dFZzVHdCRXQw?=
 =?utf-8?B?d0RkS245eGdkOE1aTjdIM1FTa3F0UUFwSXo4UFlTRnUzTjE0RE4zbXpEZ0R0?=
 =?utf-8?B?Q1BTZHhUYkh1MUo1anFYamEvUlB3Z3NiOVNRYW02eUIveUR6TGd3VTY0aVVK?=
 =?utf-8?B?MXQyaUZMMWxaNFBYMXNIREIzVzNodHpCQkt6YXpIZ1NrdGRpM0NJZnpkTnJ1?=
 =?utf-8?B?WlhTNXhHbFBiUkowVytrMlpmaU5xRkNUS3RvUkViRVdiYkNqYlRTYys4UEJo?=
 =?utf-8?B?VW5mVThlMVBXbDhUK3lwbHVWV0tRWGUvekE2SmtkR05HSGxDMXJQTzZrYzZl?=
 =?utf-8?B?UU9teUNVM2VrWHhpZUxQVkJ6UHQyUmVtWldyKzE3NWtlTkFIbVkrQ2VjQTR1?=
 =?utf-8?B?bnhCY1dVdTZoODRTbUU3bjQ4bEdpRTdxT05YbHFleFZuQ2VHcXllZjQwWk5u?=
 =?utf-8?B?aktTNkdJTlN3NXd1c3M5ZWc4Q1FaMVBQT21DY3oxcTFZNDdueU9FaE1UVnF4?=
 =?utf-8?B?NlFvNG5nQUdseC95cTJIOEJBclpTVWR5dTFzUE1xTDJScXBGVS9NWHVDTHY1?=
 =?utf-8?B?RitnRVdYZjdpSHBqampkS2M1WGhSdTdjRVc0OVYwaEhOMDZOaU14TlRoNG5h?=
 =?utf-8?B?U0VXUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGJnRzhHSTdORGwrZGhxQTk2WU9WeE5hV2R5QTlIYXY1Q3E1NWlHOVBxM3V2?=
 =?utf-8?B?TzI1MG15MXNDYTZHOCtJeG5GR05kRldlWlYwUVJSUksyU1Rwc0FQLzNYSXlC?=
 =?utf-8?B?THZPMkFxWkcxcmdFdEhEa1l5RTVybEVQVnQwZnBNN2hZWnk0WWVpZlFtWFF6?=
 =?utf-8?B?MmFyQmFPOVJnckd5UENyU09vb0tEN1ZPUjJUcWNwOHhOamFCWndIVXh6UFJT?=
 =?utf-8?B?ZTdjdDYrbzdsL0xqVXB6TUNrdHdYZXNJTGFJUUFUYkhnSktMZDhUSm5pNjJn?=
 =?utf-8?B?SE05czE2SWVpV3JkZkJjdWNmU1JjM3dXbFBMWWRYK0lXUkFVMTFSeWVkV2ls?=
 =?utf-8?B?NU51MmZ3THBwb3VobGtyZVdaaEJ1Ym5KRFNTeklVaHRuQlVyVTlMUSt3SEpT?=
 =?utf-8?B?WTRLbEVxZ3dkM3B1MmRNa1lHTHRpcjlYa3FPREZsS3Y1djlPcjkxSmlBbmhn?=
 =?utf-8?B?OEYvMkUvL3RlY0M0WlBPNnFkRmd5dEhiMnNZMWJmcFB0b0hYUGNwVzduQlRz?=
 =?utf-8?B?RnRCOEI3UG0yWFZ3MnRiTzNUV1NSWXhYd2pCZEx4NmN1UWVZR1AwQnFQemhq?=
 =?utf-8?B?UVlVRmNEZWR4RnlaSXRVU2lGWFErcHNjMEhDb092U3ZOUjRKYWJmeUdEeSsv?=
 =?utf-8?B?bFJGOFlwRlFqNFhSeEpYSjJZeFluV09hZjBPRFZxamM3Nzh2ZmR1MDN2Wndk?=
 =?utf-8?B?SGxqWWZzZDBTTk1FT0hPeXNPeXk1RmRPbDZSM045ZTNrZXdONmY3dmdJKzNj?=
 =?utf-8?B?UXBQYWNqWUNid0ZZaFBFTlFndTkyQUJXYTRhL29HM292MnM1WDRKaEtjV240?=
 =?utf-8?B?d3lzTXNhNnR2c3MvemlMYXR6R1VEWUVXdVU5MG5CTWtLKzBiWVVMMjNRNWdL?=
 =?utf-8?B?eEk1M2YrdDl4Zkd6Z2gxMFNTeFlvOWZjMkRyeVkxOFpDRjFTUzBjOVU5L2xw?=
 =?utf-8?B?L2ZMeVdUZ3ZHb01pSThBbERUODRmaE1yZzFMUTNlTGc3aS9WK0VJdTJSd0ly?=
 =?utf-8?B?RjREeDNvMWsySHBwcDg2K3RWSTBHTEZwQW15NllKcExOQ0NSOFZ4L1B0RVYy?=
 =?utf-8?B?YlRwSUMyRkpXVncyKzRaZzNzS3hwdm9JdnluNkxDRkRSYnFPZDdPVTdtUjFI?=
 =?utf-8?B?c1U4YlFjOXFHdUNkaDVBQkZlNDRDeGR2K3QzRklaZHhFMlNQS2ZFSDlJeW1m?=
 =?utf-8?B?VmRnTE8yS2dPUjNOVXpnL084cHozSXNkRUtWTUdScjhkWUpvemg2OWdDVHU2?=
 =?utf-8?B?eXZzZkkwQ3lBRFlSUlhlNzVvUWVNUkczZ0FCQTd0eUJONysyOHZrYnBTdWNK?=
 =?utf-8?B?RFhYNmprY2djSkJJTFpwVmNCYmZYWittWmJFVGVLMHdIbSsxWU0ydUNpMHl0?=
 =?utf-8?B?ZXZwQndsLys4TzQ5V0VDQnNEdU02SktJQmhucVkyalhDZFNLNitHdWpvUldM?=
 =?utf-8?B?d2Zqa3ZWRXlwUi9qYkN5djduTW1WdmxlYVFSL0NXN0ZHd0xwOFUxQ3VFL3h6?=
 =?utf-8?B?M1BYV0VBUlFhN1VWTWdKRWl2T2V5bGNhUUw1NFdNR2hxNnVPY2ZkaDlRYUZj?=
 =?utf-8?B?dFFPbHh3RzVyOHM2TjdWbCthSE9iM1lvZ08xc3h0cTE3c2F1R0xYRWtEc2xi?=
 =?utf-8?B?NzAySzEwc0Nuc0J1dlJCaS9HTmRTd1JjOUdtU1ZRVkI1YUFjYWNqVFVCUjVq?=
 =?utf-8?B?TThzcERXazFPRFZEclJ4dDJZSVVGMDhweERSNklCeXA1bjg4MVNJcHMvdXAy?=
 =?utf-8?Q?GgRJ32U/PhHZ5lfG+ITELL1XNS+mBvJh0F7E+w+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798d23c9-1682-4e03-2c08-08dd76390b65
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 01:02:33.6180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1838


On 2025/4/7 15:20, Longbin Li wrote:
> From: ghost <2990955050@qq.com>
>
> Add PWM controller for SG2044.
>
> Signed-off-by: Longbin Li <looong.bin@gmail.com>

Consider updating "MODULE_AUTHOR" (add your name) and 
"MODULE_DESCRIPTION"(add SG2044).

Thanks,

Chen

[......]



