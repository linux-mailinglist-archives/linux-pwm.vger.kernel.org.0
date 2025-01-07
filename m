Return-Path: <linux-pwm+bounces-4543-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27913A033D7
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 01:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC091884BCF
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 00:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A604F9EC;
	Tue,  7 Jan 2025 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jW8NySyk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011030.outbound.protection.outlook.com [52.103.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A3111A8;
	Tue,  7 Jan 2025 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736208937; cv=fail; b=LyzuviV9qz3df0Kxl+P/5kEVksY+jtSYe3tSojUERGoGFp3klInzMUO6wfUWDtaJvdsRvAQoI76WNrrgMEtSNl/xHTYfD8y6Z9eOg0g6ENzCXM8a67NFMC+tJQLtsxH4i+9lDxgaBs8qdpWQ2m05TmlbcihLiuXnvAb6coXOT8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736208937; c=relaxed/simple;
	bh=RedYUL6gRPj5h2IGA7dB41v06sO7nNDbqq9KiogFyHo=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WEF4q6yfvXJI1DNdDaoFMa1HsGh+yj+vAlT/F+m/DAjsFbLp29AyjawlhOcQobO58SGhufL75RoRLNITE8FvVqxJTU0F7KVNnlZnVC4pC71XjF8Fe65D1VhP/t/OWfTlMawlbWmjBDzn1Epc2hpfb2GifD8KsBLyq4YA5pTKEh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jW8NySyk; arc=fail smtp.client-ip=52.103.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsg1X5J46FVTjDpdI3f5reE/O6o+JHVAkm9INstiVn5Tez6VAIyupYNq2z+s+of5STVPidjnI1lpFQS+xAaXWSHIPjdnwrcUWd2pZEyRyCEblDJlRld1TZLlrixaCbVRkHv/35iPLZSmtNhrx5oJj04Rz5796GaaVwLY+CF9fDIK7zaKxjUvlsfb/164M21o4pB5oEivtQAkGfmcpSUR6WI30aiJxr00TR58BwGc1ltfRGreGFSyPxfZGmfZPsmop3NLCugH0asz6gZEE/wxu5a+5NG/2AVBKR2VIgWZoT9ikgu8nxSbQEsdiIIV49sv0SS1ZCU2yOBBaEKo33aLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyoiJ2Em53H5SdSwJPqvA39NqXRLTRXJcTSMGqHOQEA=;
 b=mOAakf6k+VHincDWXjmpPgGZyqFfxiYBvo1RjcNNXRKhHTscuh8PhPKjghVMXHlgtRrIhbUDByn10UO4rra+GHu3P8peN1sRwDa2rRLgkumgkP+BpnWi2PCJwEb5VBNPIFs7K++Xru3PUHM3Xrw0onOVBriplf9y3DPMsZ+ucmd9BmmGwwW9pPcEC34Iii1/REn8nWPtsBoTcUs0574sPImwWHLMBuurG2/sjN0v9GuNLTtc3ijsdMqwKoa58sVCNgR7uwHo0mauIZLNnD6id0MZPZxppCBbw5gMmjcgzwAEPLS1OcN8Ro9BC5y+kw3/7HzVZUTSuPsJOKQsRG4JOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyoiJ2Em53H5SdSwJPqvA39NqXRLTRXJcTSMGqHOQEA=;
 b=jW8NySykch6lyNdVld5vt5v+3zj9wfoURh5/S7MYf0HAqTpslpBc008ueTsh5dEc7fi0QRhhqVlRRWypMF5S2Uusram8DyyBnUGSYkeanhwpC+pDLlP8w/BkpwbIIftwW0IThfYaVqwxytYdJ970Oe8N20lCOBCq2GxnEfIIlZjnMdPnhuLCGYO9Kt3t85O7BErGVrxByHznzGL58tTMQCKnfiQmcl2V2lvufuZwQsYY/P5eGQHrXddj9hdJSyibfwwavVQBp0crooYbPN9jjpHdYZZvtdZIY1d/z9XJwioP2aPqPBtq5BrEUqx10RsKrasBhI5v5RFslPvePdJeaw==
Received: from PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fb::11)
 by MA0PR01MB6108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 00:15:26 +0000
Received: from PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc57:de35:cc59:cc4f]) by PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc57:de35:cc59:cc4f%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 00:15:26 +0000
Message-ID:
 <PN2PR01MB95232C384994345CBAA68913FE112@PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 7 Jan 2025 08:15:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] pwm: Add pwm driver for Sophgo SG2042
To: ukleinek@kernel.org
References: <cover.1733281657.git.unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <cover.1733281657.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fb::11)
X-Microsoft-Original-Message-ID:
 <b3615bb3-2f42-471c-aa37-c888fb959d1a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PR01MB9523:EE_|MA0PR01MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: a8058952-a6c2-4dfd-ebb2-08dd2eb0627b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|7092599003|15080799006|8060799006|5072599009|6090799003|10035399004|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXYwTUNpK2JlTnAvYUViVEdXSlkvU0RlY2FQbjgydGRYN0NicmlRNlBsdHZI?=
 =?utf-8?B?OGR1T0o1TWJzRzViNlpoSFViYVJaS0dtMHpmcENwakNkL2p2TnAxV090cUxE?=
 =?utf-8?B?b09Nb1kzVHZKbTVtaGNXeHg0MnpyOGN1WkhFOHBFekxXWU1tRDEvbkt2WU9r?=
 =?utf-8?B?V1BNS3cyRXlFT2VUd0pnOFBiQ283d0I1UlJIYTdzWkdWVTJjZGdNbzU5MzZ0?=
 =?utf-8?B?aG5Ec21QL2dqNlJaWXUzcHBndU1YQVNYUHZQWWdFbzRqd0ZqZ0J1YlNWUmJs?=
 =?utf-8?B?aXZNWjB5ZmY3Sk1nZmpYbnJSNXZuVUxsd2w2ekRaVHVuTVZxOStGWFMxVk00?=
 =?utf-8?B?TlF3Q293NUx3cU9qYkxyUmxqRnlvUG42Q0xZZU8rbnVISEJOejB1aE5GVUta?=
 =?utf-8?B?ajRMNnJtQTV6a2JBYjVtdmdqMFcwcFllT2FMeTBMTWx2Y3NIMEFHdCtWZUVj?=
 =?utf-8?B?K1ltSjMxWXVFZ01udEVCUlZGZ2tKZEswOC9KUGRNM1Bac0FrejYvMmJPYmk5?=
 =?utf-8?B?ZlcwU2JDMU5TbTc4cDNTb1ZCd3V5d2E2N011ZFU2MCtpK3FXSnBKMVRnQ0Ez?=
 =?utf-8?B?WFBPclFXWFFDQ3dyM0NvU3dnRXpIcVdtYkpMYkwwdHdNK3JNeG00NTYvS01F?=
 =?utf-8?B?SVpOVGcrNHlUYlhZeTdPNnd1dkpjTjV0cVdCNmRqeGFFTEEwazVSS0FtQU53?=
 =?utf-8?B?UUVYUDhLeVpOOURPMzhaMEF5N2RnQWZvSGZmMGdubFpnYXVIbEVva3VHam55?=
 =?utf-8?B?THBmWjZCU1V5UVlxdS9jK3VOOWZyYjdMa3ZBQms1OHVoVjQyNXc2bGljZk1V?=
 =?utf-8?B?Zk42dEY1ZzJmUWQxRzhLOCtaZWNESnlxNmdwTUdaMlpFdjNWaTI4UEpURS9y?=
 =?utf-8?B?VkdyZlBrMU03UzJBcWlxN0dwSlNQelIrL3hGaEN4VDlTZklIWHVWb0hmU2Rr?=
 =?utf-8?B?eDY2RXBOd29nRjhldUVjejVtcVkyMWM0WFpySFZ5OHZaWUMzRHFtZSsrWTRv?=
 =?utf-8?B?ODhjR0o3aGkwM2UyQk9sR1FCa090STlLYTFyYlh5UXYvR1FVdW15a043Z2Nm?=
 =?utf-8?B?WjJCOW00ZkQrcExweU1ibHlRSjNWUHNTYXduM2VQSEtsazJHYlBCZTkzMC8v?=
 =?utf-8?B?c1U0NzFndVl4T3pxc2plbDVSc3RPa3BhSGV2amxyMGlIUkduU1A1SitxLzVO?=
 =?utf-8?B?UXV4T29PQ0RPNDB6Um4wdVNkTHpwakN2UnVBRTNyZS9zTVBOMFU1dnpSaVN0?=
 =?utf-8?B?bUVUaFdtOHZUQ2pTM01Ubzh1clVSaVdqUzZIWlBDK2U0dEl2eEo0a2M5S0pY?=
 =?utf-8?B?N3BkTytSaEhQMVVqbXZ4UTVML0Fqd3AvalZBQTUvYXhQU3BTSWs3Q1crbkZF?=
 =?utf-8?B?OUdLaXpBejRaWUU3QVMycER5bnZ2QVh5bHRqRjZJUnk1OWJvS3NvNTNJdDUx?=
 =?utf-8?B?cGR3eVJTZWtSTzNaakpBWThHa3VTNzlEREVvSHFwMXVkeGdleVNhVFRSL2Yv?=
 =?utf-8?B?eFdEZTV6Q1UvWmIrVlB6dzAvVVlpM2VzNUl4Yi9TRlczd0U1R25QUkNabmg3?=
 =?utf-8?B?bkhVQXFld0gyVHhmWTc5ckZ2WXFGTi9jMGVHRGVvYzFiRzFKdFRBb014MXVM?=
 =?utf-8?B?NzYyZkRyczNCbi9kTVhxYmVLbUVGU0ZiRkhMMzhqdnlmVWptS0FHaFBvVkhi?=
 =?utf-8?B?KzJIWjVySGxEajlHMTcrRUhQWGMzZ2VlYmVCOXB5WC9kYmF2V3daVnBBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T29ESkNoanl6MTJpbThhcDRFTjZpVXI2NExweWtBcGZNMXFIL1FyOHVoQVcr?=
 =?utf-8?B?bVdlV0E1NWt5QzROcWpSRzZGa2ZZNjFoZDEzdmZEbUhWaEdOQXg2ME5hc3FH?=
 =?utf-8?B?QStJalpTMnFTZmo0dUpBNkJFclJIbFFDeUwxZVBUNkRIWDVjbVM2S2RiMFND?=
 =?utf-8?B?ajE1SmxwcjRaVTFqejNPZXI4NktKVlJPSUEvWjJaQTZ4UWhmcFpER1hTK05M?=
 =?utf-8?B?eHVZSG5Fby94RUwwcENWSWhNOVdzNmt6RHpVWGNtOXFORU9vaUI1K0ZkZ0RW?=
 =?utf-8?B?UG5QZWhnT3B4N1k1M2RBMld5YXU0NmlzTHcrWGY5MHluVk82V28xL2xoK0pW?=
 =?utf-8?B?RDhPRXVWczk1N0NrTFQyQnowTEU0YXdZR2svY1FTYmNkREpNdkFmeVhpOU5w?=
 =?utf-8?B?Ym9nYS9XSmNxU0hHRDJqNWdhOVNDT0lrREVSK3dDZG5XZ01XRE9wUGJKYXYx?=
 =?utf-8?B?QjRqZks5TEEycUxLSWdmTExpUzMyWDcxSnpKL1hDOW5WU0FoMVpobGxDSmJT?=
 =?utf-8?B?eDZmZWpoVm5VaVhoc3duQlB1SWtubkc2c05KaWpqYUZLbVBVMmRndTZGQ3Rq?=
 =?utf-8?B?WmErR2xKUDU0MXhwazlocHhmZkhCc3UyVFlsS3gwTVFrczNiWEhyd21pWWxJ?=
 =?utf-8?B?ajZiR1pnQ1FyTnFmcHYxTjF5Q3h3VVdrMmFyOUx2RmMvN3ZQTkQ4N1V5S2V4?=
 =?utf-8?B?QlJobXB6RHhXUUxOWGp2V1pUbnZrVWdXY2FCK3hGTWZ2WFlIT1hqcUdYbHU1?=
 =?utf-8?B?aWEzckxUT0lBejFGVTExYThQaFZac3NYd1Uxc3g1RDFXY2dMaHZmQ1VHc2ZJ?=
 =?utf-8?B?Qzc3OW9kTEs5dnJ6Z2w4SDAySUNhTGFqeEhWODVqYzVuQkR5NitVNXNScVBM?=
 =?utf-8?B?S2VsTjJYeVltNndqSTRmemhyNDlVV3NZa3Bwc2orM0JPVTFkMXVnZ0U0ZWl6?=
 =?utf-8?B?aHdKc0RmWVcwbXNKZTgwS2VOcThYUFp6bTF1UkxqR1Q4WDlQNWdPUDRmN0pI?=
 =?utf-8?B?K01pMU1PbmVWZ0tUaFBsSTZTSkJ5UlczMVBEdk9BQU5nQjdnYzFVWnorSDlN?=
 =?utf-8?B?QmRsVFNMbmJoUXpFVTNvcWlwZzh1UDFFc2xDbUhkSnVnOFRvcWM5cjBYaFVZ?=
 =?utf-8?B?c2NoSjd5dWVsdC9scmRwVnVqWnlvSDhVbThpMHFYb3dWSFNWTnBQdk9iR1Zx?=
 =?utf-8?B?QWhLeXh5Yk9DcjkyZzlwaU40MFovQ3JOR1Z2YU1lQWxIclVjU3F0dHpIdEJm?=
 =?utf-8?B?TWhuWGpkcFljWlVqdENSNituQkFaSVIvaG5mb3BwWFcwbmdiQTU1OFBRaG1m?=
 =?utf-8?B?OGg2NDFaVG1KSFRjYjNwTW13VS9SQ0Zmcm9UZDBsQnZJNTI3VU8yMW1UTkxF?=
 =?utf-8?B?QWJWOU5vNkFIV0NnTFNIVUR4YWFhTjJXa0FxN0VTcCt0eVVqWG5tYlJxd2FR?=
 =?utf-8?B?NllTbUo2dC9BUGVObVBPTG1BVlVRaTNsMFZyeGw0MHFuaDMrTGp0MmpoaXZS?=
 =?utf-8?B?dVlMMUo2WVIyUTgyNlBZNnN6dWNuMituNFdrTzlNTVY4VFcyMmZUMGtsUkZB?=
 =?utf-8?B?ZHErMVdvLzk5ZVNOK3lDZ0NsU0x1QkoycStJT0Z2QjZFYlBNRC8zTUFMUG96?=
 =?utf-8?B?ZHRxenBsak9Cd3BWb3Zrb0YvM25LN1NSZTIyZHBrcGhlVUp5L2JZbXlKQWtx?=
 =?utf-8?B?NklQOTFoYThVTmpqMHFkcEVvdmZscnBKMkxFZkRsa09rY0ZkNEZPc2FFU09J?=
 =?utf-8?Q?msO9n0m2FjFRUhi0dumMwzhWpnxHVL7AvwI8zMq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8058952-a6c2-4dfd-ebb2-08dd2eb0627b
X-MS-Exchange-CrossTenant-AuthSource: PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 00:15:25.9844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6108

Hello & Happy new year, Uwe,

Just ping and want to know if this will be picked by pwm/for-next for 
targeting 6.14?

Thanks,

Chen

On 2024/12/4 11:15, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> Add driver for pwm controller of Sophgo SG2042 SoC.
>
> Thanks,
> Chen
>
> ---
>
> Changes in v6:
>    Nothing major changes just rebased onto v6.13-rc1 and retested.
>
> Changes in v5:
>    The patch series is based on v6.12-rc1. You can simply review or test
>    the patches at the link [5].
>
>    Updated driver to add resets property for pwm controller node as per
>    suggestion from Inochi.
>
> Changes in v4:
>    The patch series is based on v6.12-rc1. You can simply review or test
>    the patches at the link [4].
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
> Link: https://lore.kernel.org/linux-riscv/cover.1729037302.git.unicorn_wang@outlook.com/ [4]
> Link: https://lore.kernel.org/linux-riscv/cover.1729843087.git.unicorn_wang@outlook.com/ [5]
> ---
>
> Chen Wang (3):
>    dt-bindings: pwm: sophgo: add PWM controller for SG2042
>    pwm: sophgo: add driver for Sophgo SG2042 PWM
>    riscv: sophgo: dts: add pwm controller for SG2042 SoC
>
>   .../bindings/pwm/sophgo,sg2042-pwm.yaml       |  58 ++++++
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   9 +
>   drivers/pwm/Kconfig                           |  10 +
>   drivers/pwm/Makefile                          |   1 +
>   drivers/pwm/pwm-sophgo-sg2042.c               | 194 ++++++++++++++++++
>   5 files changed, 272 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
>   create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c
>
>
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37

