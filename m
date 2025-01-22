Return-Path: <linux-pwm+bounces-4698-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174B4A18D85
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 09:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA7D1652DF
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBBA1C3C1A;
	Wed, 22 Jan 2025 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="possaiYR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011030.outbound.protection.outlook.com [52.103.68.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEAB17BB6;
	Wed, 22 Jan 2025 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737534124; cv=fail; b=CWzUbbOMePne0+aj0weRlch3LTwzXQywd0Yye6QwDN16gIsZrLbGNdBLguS/BPf0cbR+NuLohbQic+/l6wkHb7J2ib6YbAT+tP4ByU7bNgVLsiXSv4QwBKzgzKyBje3wB200k7LqlTvF1HUIEU8TqNjBgVSI5piqUr2u+yHknQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737534124; c=relaxed/simple;
	bh=N5DrrywbnlRZcAaNwa0MMqPuZE2lZPsKsUnkGAcCbdk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VwaztLxPSjSPs+x+v4WACu84EaS6xWDvO3w1GUBvBEsk1lBSpBLKBZZW/aHlsk6tX6Bk5eeoHNPvQPjxG8gw34htTRSB4juCKKf2ZBtJbHqYHXAwEEwyQ9Em0aF1B/qMuBg//jzHNxH6FFXQWva6qUCi7iUW1N78vYzED/VKAVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=possaiYR; arc=fail smtp.client-ip=52.103.68.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcQZOTeNM6Gr6SbptRne1C45kjt/4YDqOOBx1ggAPt45d8a0OmWG4aS4brdEw0oVZ3Q6Wx4sdV7Hcg3XnmDMsbgGgiWAWg8Goe5Y1jnZun1iLM073OWQDwpKvG/VJnEMGW8rgYGSLTjjf/2n9C+F/vn1HsEQBC+HTOuRvhA3AmNkWEfceIX3SVzhydxoZdFb0xRTWDXvXeW2kPNMPlui1xL1CxBX14TCI7CPcVJ+1LlZ3s/8zwLm+oiZb+UK+xWCMudsnQeB18HxMMI54FhuDwS+Xndwxq5+HTElL04nRMDfopUvwqwzqpvmt2sUCwDm61AE03sArXx2TraB5rR0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nDaV+qoBzLsl94CfXfWt3KAXS1PbJ4fC9kMSV17+d4=;
 b=mue0sWrVnZhdyuqPh0njEUI/QaUS/ODVZooe/ZbT/mTId0dK79vHoZTXVYzSDJEDmu5OuKJzFLrTywB02Qs/t7spHHBShprYBZhckERwDWrw0nVd5jDk3MGH9j6/X6DCHa+/UlToqSYhAVp37yHAmAgBX9DlyT715HRlsfAn9jSODL7gbqRtTKnVp96aHNHZJEycr1kMz2ILzyz7//pIF4CAXoz2cyi86pkzjgbemDdTVYZbBKahT9RhKE/d1TTD/sTtlyVuz2wr3mLg5OjtNrWb55v3b+V2WkHydFZBHr6URvka7VWWE+Y9uTB9QrEKX7Maj3CyuN7fDTDwXbiq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nDaV+qoBzLsl94CfXfWt3KAXS1PbJ4fC9kMSV17+d4=;
 b=possaiYRJ7/YvNK+mbopGtxLLtzvXq05EoK/E497bh1NGSON88pRyPnJ2l1Vp8CbD0LHydRvrK2MQ6Pj/8zgk1wfNkYSvMOtlgQLvkPwzXm5+9Pv/9QCaIVf42QegMW0R5Gaw4A+C1HZLTZcXZJOwI9hk8qve3ukc/ydPxvffjzCpIytyJYNOqP+zCKf7XlAIQa4D1dPhqC+mUncRcyOF7Mr+UI/jVctRI9LhDz9WnI7ocMlKVS/WtKby8yv4I109icDtmcKtPZ3tXHT8Nb1PWdAKLAIdQh96DmQLTXYaHZhQmcgLw5opDnF3ek7vlSqB1dUvVeJmesLTCK4eDZGyQ==
Received: from BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:44::15)
 by MAZPR01MB7054.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 08:21:54 +0000
Received: from BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::954a:952d:8108:b869]) by BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::954a:952d:8108:b869%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 08:21:54 +0000
Message-ID:
 <BM1PR01MB2545DDDC4BC3042D403971C6FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 22 Jan 2025 16:21:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] dt-bindings: pwm: sophgo: add PWM controller for
 SG2042
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Chen Wang <unicornxw@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <cover.1733281657.git.unicorn_wang@outlook.com>
 <673f314d78ab467399afc02b96ac730149f19587.1733281657.git.unicorn_wang@outlook.com>
 <dvjnhptep4fa3iqxzsau5fdp7qrno4nhnpdecvvyb55h6sxjpl@ohnvvbldwtpj>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <dvjnhptep4fa3iqxzsau5fdp7qrno4nhnpdecvvyb55h6sxjpl@ohnvvbldwtpj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:44::15)
X-Microsoft-Original-Message-ID:
 <a300a5f9-9f28-4b7b-9704-c060677aeedf@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB2545:EE_|MAZPR01MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: b507c4fb-0dbc-492e-7ab8-08dd3abdd3eb
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT+Low/KBlUSJz3r0Ahd/UBoFlO6HVy9nwkYVXKBJa7Lpg73DhQpkm0kBKUp9uklNJh3STnwh3zbqgQ7buQfacsrA4dgvFpIdxgRhzfUIIBnyXCj0Hv0+YiUyLM7dtH7xbvdRO10vkDUTDliqN2OCtSOfHBfZoGpYg66d9ZYak1Y2hnqa8aONF9shSEwg/yqmqEm+YW+HWw2a2UY5fV+4s99CmvYu5n/iz3X7gtyENd8eTZxBaWnntT1/bmY95G4HyFnswlV3XKH1kstaJlHtJ7fqjU5ArAAXVxbhpBpq2q3Ef5ZdtfHdqSuBYdO2WRRo+ab5FIGUsuW8G96Rgc/qEEi1ETqGvm899MWLTZDoNKAwXpk5AcoxOkeSor6mBrzZ/9gGz5GCSgsyzAEsJKv9/Z6pIEfkSDdoNHPElctUYOrsaENwIg55Imzmil9fTC6kq8rl3ZvBcodP0pAcn78tjuR9BvbmJcfeWEXpy7FS36BQYAcBFmcV4bw5eIhy2Wcu94y/opIFfgxu6vkuW0AU5gChq77AhTWR1KLQ188OyqtITxE1htaKIe9tVDTJc7qft6B1qOOhbSN0RHkevAeFN4/DHFwb3K3mdf5I9q/kxGMTxn5j1wdOU8ee7mHxZiv45DlC4qQ8TmCgufV0zLbWo6w06iYPk0JnciHbUzhbBQpIiUdFkSIx/GbGLseoxX6sSE/tsrMCpcA0n8c3LUFrRjpJxQjQWPJrTlmsY7nh4vLfuoZgrjrkPf6DVHlpN7/dY2jATE2iR067wcLHQdWyOACbFlsguZm2ZFJp5Bg0nfnBCktk8PtNZ0o
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|5072599009|7092599003|8060799006|461199028|6090799003|10035399004|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmRSL0dsK0lzUFU2ZUJFd1MzZEhycGcvbHFxOEZaWmRrekRFWERDd1B2S1Jv?=
 =?utf-8?B?WlVEcDJKVFZ6ZGlIMHlING4zVko1bE4raEkrZ0xFc0tNWENhN25lMlpjRm13?=
 =?utf-8?B?a0VpZVdEclY4K0NIcVkvM01ZRlhmNE1QUzd6MHUwL2ZzVWJGWHZuaitxbTVJ?=
 =?utf-8?B?UlhWemRTa2YxUmM5aklvbGxpOXc1RGRwejh6MWs5RTBNamlJTEI0bEh0UXgr?=
 =?utf-8?B?M2ozb0FzT0EvWW1CaHhVQUpFdlVMNGhJeGZBQkUyRXRmOFN6K3kvRGhvUnZY?=
 =?utf-8?B?Q1Bvc05KWllyaHFoZUZGcS9QYlM1RkhIaGtCL3IrRHVleUI3VDlMU0RYVWJE?=
 =?utf-8?B?MnFZSzNiSGtCYi83a0dpU3RDQUNDNUkxNkNmdXp6azVnM3Zua1dYT05NRThU?=
 =?utf-8?B?WEVacXkwcmlKRXZxSlBlc1MxM0dBMlRVcURvRzZ6dFZQUHFXWXVnOWVwKy9v?=
 =?utf-8?B?UXRrR0NJZStyUmFsK01DWFJKOG5lSTIxU1lobXhRZGpmd3NyRU5xUkt4d2l0?=
 =?utf-8?B?SGEvUDRKSm5meEw5U3Y0ZGIvZFBSNjRSd0swQllnc2pudi9ydU1hSUFqaTNo?=
 =?utf-8?B?Mld4eHRoUnJnZlVnUlZ6RUkvbDlQUzdBenRGTEk2a0h1ZTRKUDh3SnZpOUNR?=
 =?utf-8?B?UTVQYkc0U2ZCRU1qbGs0QThGRlVRNWVSajZ5ZlFqQ1FwL3B2TExVSkg4dkxJ?=
 =?utf-8?B?R2dzSzUzcXZsa2JyL1BadkNMQ0wxcjRWa2M3UGtHZm53ZnJrZ3grWmhsZkJW?=
 =?utf-8?B?WlJkdWswbEozRnF5YlM2c2VpZkd3WWFoYXE2VWdjUUlubHc4cXhyblBCVlky?=
 =?utf-8?B?K3NjWG1jRFk5UVdyVitnQWNxUjV3ajV5bFNieEFNRDNhTE95RnpLYng3SEJj?=
 =?utf-8?B?NU85QzBVSTEvRUtkUTh0R24yaWtPV1JGQTY0ZTdPUG9iL1hnV3RlNHJMbUpK?=
 =?utf-8?B?b3FKYVFPdjA3NmZ2SjZvZlhIUFRNL3ZxVVdQSWN2emtlUEdSblBKZ1FidDFo?=
 =?utf-8?B?NXUzRWNjTDlla2E4L1RiNTdxb0tMcC9NVkd1NzV5MFVSb05sRUFKQVdXQWJo?=
 =?utf-8?B?RU9rck9tOXhsc1ZTVnRRcGJLclFPV3lwUndUQkUrcDBJMnJIaE9lbWMxVFlH?=
 =?utf-8?B?Z1pGbXo1SkZOUm0xclhROW80RlJqSGd1aHB3cU02VjJnaFlsdm9PdGJ3ZlYr?=
 =?utf-8?B?N3p4M2gwZmdqd054M2YrdFprLzBqMy9hNkl4YVZVSk1WNjRRTzZuUHRWd2ww?=
 =?utf-8?B?NWJ0L3JaZU5iU1NoZVZxRjVJYXJubCtrbjF1WUpvUzlTWkl1N1dOUWVTRTVs?=
 =?utf-8?B?ZEVYcklTYmJuZkZ0Zml3U0VEWlh5NmtWU3BnOHhJNDFqakZvVEhNOG5SWVJB?=
 =?utf-8?B?VzB1Wnd6TGRiaGZpbnYzbkFsTWlaOWhKaFRUMnFZaGtnUXU3RVZPdmNCdndQ?=
 =?utf-8?B?VW9VZndsS2VDbTJIQzIzTkNjQmh3ck5zZzREbDE0ZGtseEJJRnI0WVRsQUtT?=
 =?utf-8?B?SkJyOXdHZWVhR1BwYTZsY3ViNWNGTXNQelYwQ1ZZMWlaeWcyUjdBNXlwV0Q4?=
 =?utf-8?B?aXZ1UT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGFneEJFOE5lL3REdlNtSDk1a0xENGVQemxjSElvSkoyalJTa2RhZ0Q4eHIz?=
 =?utf-8?B?YisxMEZVeHM1ZmQzUG1wOUpNcUQvSzVndEJQRFNCeW5jNFJXekNBVCtWRFFz?=
 =?utf-8?B?ZTRENTI1a1A0Y3FveEdBYW5TOGZXS1ZDVkhiKytaclY1aS9PQmNiM0R6MStj?=
 =?utf-8?B?QU0ybTkvTlUrWWtxRUVTWG1aL3ltSWZqVUR1Z0JnTkZHMy9NdzNPRGVxdXNP?=
 =?utf-8?B?OFZnUXM2Uyswd2ZuOXczZGpsc0xzUWxobFdzTEtOeHduZko3dW9vNCtaSmhj?=
 =?utf-8?B?T3hQUkl2KzFQUmNmTStnT2J1WDMvUFduS2RlR0lSRkZ0a2txcGNsTDcxbEdK?=
 =?utf-8?B?a25lY1V5bmRKdWloRVd1MjQ5NVhRT1QwYlp6WjdtMEgzOVJseEFqV3BWdzhO?=
 =?utf-8?B?RUYxVlJkRytpNmJPMmtqTGsxcmNianUvYkkrbG5VTWlOek9sT1J1dHpQcDFa?=
 =?utf-8?B?MmlLTU9ub0NQY2IzZjIzWnRvV05xSXN1TUlyeDFRdnB2Y0dYeExnY0RsUVRC?=
 =?utf-8?B?Q1c0OUp5clpwSjhEeEUrOGpkVkppTjgycSt2OE1DazJBSThsTmhnSm41WHA1?=
 =?utf-8?B?Vm9jUmpZQ3JTNnBQZk95ejRSbE5BbnppaWVsem9JMmRMcnh3TFUxd0tpS0Vq?=
 =?utf-8?B?bWZuWHZkdnFiVVhMY2FPSzhFNzRRMTBHVUhWTUIrUVhSUFJaclprcFZjaytQ?=
 =?utf-8?B?blZnMkNNVjRvZkJLTFFreVE0QmNkVnFMK3U4Q1BFTldIV3MrdWE2ZHRkUjJP?=
 =?utf-8?B?TnY0L003UURiSUw4dWdMcnVLVTBLV0M4bmR0YURjMU9EcEZtSjlUSStOUDJE?=
 =?utf-8?B?QmNORThVRTI2eEtyTnFKdWVSVnRWV0M2QmZ6N1Jod3oyWm9MbUs3VkVQUXpR?=
 =?utf-8?B?Ynpad1VHWnN4VWtjeUFBeFNyRkpBczM3Qi82T1UvL29jRTNJcTN4VGZKamZo?=
 =?utf-8?B?ODNDQXBZTGxrdGVrRFYvQ3N0WDVKQmxaY0dvSEhjU3ZUUUFOVUZiQzNGQXAy?=
 =?utf-8?B?QytyZ3lFckFwYU9wcmJlMWtaSHoyTWhMcTdqV1d5dTdQMHNIT2pGNG9ma25V?=
 =?utf-8?B?ZUVFOU9ZcGdEdFpucThqMlNQdWhZWWNMNXFMWmcxVVR3cU52RGpOeFVoNkIw?=
 =?utf-8?B?Sk5UMGl5NDlUZ29UWDNsOGh4c3BUK1pEQkQ0VCtHbUczODIyOEpOZm1WckZH?=
 =?utf-8?B?d3NsdXc3YXlPYmlpdGlNWE9idk45ZXVXN2FZRXd6NHFaaElsVWI0MlRoVnY3?=
 =?utf-8?B?M2pOb1VMUkwwU28yUWQxNnpEVEozVmJQVkVJVnA4WnZBWHkwcGltdzNiOHB0?=
 =?utf-8?B?U0E0NE43ZmYxV0ZMc1oxSmU1ckdpSGNSN25kVTlhUXpvVTlpUHRsMG05UTcr?=
 =?utf-8?B?aG5qeWYvelR3QWtmbUdTZWwvUzdoSTBKKzFXT2hjWFNndnQyMnF5ZzFvWStm?=
 =?utf-8?B?dG91anIrQ2xsWjZQeFl5VjdDWmpJQXhNUkpXZWFISnJPZDAzbkcrSjBGZFlP?=
 =?utf-8?B?dVlLYkMyWnFuL0NMdytTeFVVdTRnM3NxWjBRMGJzQk9xNWdXSWdOOHNqUE53?=
 =?utf-8?B?R2dOVk0xZU5qaExtMklieG4rWVdtSXh2RHpjNm9aV3VTb2xHUWJTWldOS0Rl?=
 =?utf-8?B?NUU1NGNsNzBxbUFRSjc1RGJpMXlJWHMrN1pEbVJvNVBjclNCWjhpcC80d1JS?=
 =?utf-8?B?N093czhsSVZhaEtSdytFc1ZKU21VYThlby9nRUxHQmJUN0o3MFNTdHRpNXJP?=
 =?utf-8?Q?4kFdI9EyX1qkF0i/Ep7MLQ1qK5LcGl6xY49Nhvh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b507c4fb-0dbc-492e-7ab8-08dd3abdd3eb
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 08:21:53.8916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7054


On 2025/1/21 19:16, Uwe Kleine-König wrote:
> Hello,
>
> On Wed, Dec 04, 2024 at 11:16:22AM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Sophgo SG2042 contains a PWM controller, which has 4 channels and
>> can generate PWM waveforms output.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Nitpick: Put your S-o-b last.
ok.
>> ---
>>   .../bindings/pwm/sophgo,sg2042-pwm.yaml       | 58 +++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
>> new file mode 100644
>> index 000000000000..5dea41fa4c44
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
>> @@ -0,0 +1,58 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/sophgo,sg2042-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo SG2042 PWM controller
>> +
>> +maintainers:
>> +  - Chen Wang <unicorn_wang@outlook.com>
>> +
>> +description:
>> +  This controller contains 4 channels which can generate PWM waveforms.
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: sophgo,sg2042-pwm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: apb
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  "#pwm-cells":
>> +    const: 2
> Please use 3 here.

Accepted.

Thanks.

Chen

[......]


