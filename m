Return-Path: <linux-pwm+bounces-7390-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD915BB65F6
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Oct 2025 11:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BAB3B02BC
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Oct 2025 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C43228643E;
	Fri,  3 Oct 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pvPDNsjC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010034.outbound.protection.outlook.com [52.103.10.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D942BE7D1;
	Fri,  3 Oct 2025 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483829; cv=fail; b=jn0rSaDIxaTstmld6IPRRQ/9ZVxAFIvcdNbQMK8ck+sHK2MrMwk56opgTx+bQUuOPS3Wx1dYVjQfw5SIWTzK6PAOR+Dj5Mb1eHuWun1JG72q9MT8+38AG/6TieW0qiPdyujG7ByBaiQVMbImGZjtyNdZvTrkq21fyDgG0ilm2ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483829; c=relaxed/simple;
	bh=8MOGV1jfvT1LK5AIk2CT3Nc+ym7n5jCN2qg2CW3v+Vk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GG+EZitcIJUCKQD/Zni2pMfaeEBh8kUgkZkIc4BpzAv6wKBw9b8pAYCOqaj2V60fapCxivoSDjjN7Ezg5mDzOLwLS5xhc6FWp+I1/uavHhqmFh/SN+ZZ8DTOqpXFGrQz0+LK2mnkiCUp/uzKDOoSn4XmdsgptxCdKSNnTHTXltU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pvPDNsjC; arc=fail smtp.client-ip=52.103.10.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9jgx7aF6w0PA4H1louw5t+iaRMsjUsruskRBFTdKg1NbNLNYuR3Cs8hXPn0SYG7LtSmknfvRykG32cZGQrZ0CgCFxE0VWROLgdFoOhEz5umbjGLfR2EhTEuTPvIeMV0pD/ej2oRy61SXb78R2cNSb7T5DXdWGIqSc976Cm0xiv8vXB3pnK4M9Tye2hPz5aa3E9nXOCSZ3wJdlA5D1cPclI0rFva3MOZqyFW2HbPMs5BRIicGAhvBcysuIB8DS98FbmR+QIaxe7n7Pq/wzWT18NIkwoPCMsz7oop0LZD5ZMVUVXGLEwMrCoaArB/+gMjxXqsVm3Bo/fNTapYhQWhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=023uqoIHu3YU+8014BuA/irsMwSOYIjhrS/hKR3i1m4=;
 b=PJ+oAjH89TMYWizZsta81+S/lHHocwrBKqd8LF8v6hDGM0DkA+mJxJHVji7qvYbmS/kgBU4bFsxtegV+7vq+NxyebglpPiaaCVTcu7xsXlrvqg+/lWm3B2a0/oQT5VbxL5flHoHjAApk7rtdeiExxrwQLq+YFkunQALg+rgMD/UAPFVi7P5pkJHRjk/8EuZT3exaQy8CJLiK/9KGSuezBLZa8Wfqtel+SpCG2LElr10IWGL0bYiXYHaoL40+idXNk1iGBKHUSSAPwL01PKxPGOk643KNy5dk3bNffJZMDnzluFKhhdhk+g45Vf3fLJOPPK+GEU14iyi8NbGJiSTqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=023uqoIHu3YU+8014BuA/irsMwSOYIjhrS/hKR3i1m4=;
 b=pvPDNsjCyiNQVQDPY5PTyp9WMwHMyAUYVh6/QwA8Oj6jQMEPRORSu4X44CFXaLM6Ai+vVhkl/JC28pMroLXjOI/jYrY2xwZqBxEN/lso7OO7Fj2fSuRIoXj7UoEzCfmRaJaYz0hWXKtIhjxcKhW11bByjI448fy/0VnfW6T5WUSvUK61GZ2anJbmr7Ku3jEWIJ8oiGgkHnnz4Qno18w74D74JAbksQZLQt40f8l6KPWmGqEnzuzIho2dSQo78R5wPLB9SrKgxMyflbRZ3QmSV33dzIcx1rN1cNPGQ5Q2rDmWEDLzh3Yrusea+Hw90mClSVuyEmJvmb3GtsIqbcKv8A==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SA0PR19MB4335.namprd19.prod.outlook.com (2603:10b6:806:80::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 09:30:22 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 09:30:22 +0000
Message-ID:
 <DS7PR19MB8883BDB4C3147C86F062A4B29DE4A@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Fri, 3 Oct 2025 13:30:13 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] Add PWM support for IPQ chipsets
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Devi Priya <quic_devipriy@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Baruch Siach <baruch.siach@siklu.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <3cb50330-effc-4089-b80c-d454bccc63f3@oss.qualcomm.com>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <3cb50330-effc-4089-b80c-d454bccc63f3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0017.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5b::8) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <d6480b87-3eae-4cc5-b1f3-b567b3c080e3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SA0PR19MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a117ec-4e31-4957-a5a3-08de025f7960
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|23021999003|461199028|19110799012|6090799003|8060799015|1602099012|40105399003|440099028|4302099013|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDRiOG80ZVJtV0UyaW51SE1WUy84ZFRCclRVamdzdXNlYWxoVHR2NXNCY2Ry?=
 =?utf-8?B?QmNYRW00TEhEM1JPa29UbnRLTTBCKy9ZOWFwSXlDcDA1NVFTS3k2d3JRVkdW?=
 =?utf-8?B?bk8wdnphZ3lFTHJNYmRkR2RObU92dzRPa3hjQ3Y4aE8yaTdWTjgyVER2cXJP?=
 =?utf-8?B?bCs0RHEwN0l1cWhzUXBuc1M0T0tQNG5EVEhnbTViYzBvbmtYNmdaOHd6V21u?=
 =?utf-8?B?L3NpTThWRm1TQ1BrcmFvNFdjYW5ZbGZxbDJLMUxreUdXQUlub1ZkcDRiZkpn?=
 =?utf-8?B?VXdCb2ZUMkluaGpqQW1DK2E1Y29IRUVNSi9Uak5JZngrOTUvcS9FMFVsL2V1?=
 =?utf-8?B?WVZNMkpxaEUyR3JDaVZvbjZ1cDRheWdGMmFycUt0VndxQmNIQ2dqVmlON2Nm?=
 =?utf-8?B?Q0wyaUpaTTZ2ZHMzZnE5K2xZRWNtWjd2aFJQUklLMUtZbUxYWDg3ZnlheEgw?=
 =?utf-8?B?UWlWbjFROERaMlhCODRPR3MvK0JJNXpUQkJmZUVaU0wvb1FVdGFZN2I5S2Zn?=
 =?utf-8?B?a2laV003YXRhb1lIeUVlaWEwL0hGK2hUYWc4U1pseUVZbUdhZ2xaRml3aS9M?=
 =?utf-8?B?UUl2R3VVTDh2c1lqbEVieHEzemplRXRpTktBb1Y4R2tZdExIRU40LzVJd3BS?=
 =?utf-8?B?Mml3alNHVGVmUnR2SkVwRmxoQ05pdlFMeDN0ZGhISko3TlhBUlJIdW16QTNZ?=
 =?utf-8?B?Q09ZM00xTlNFQ3VOUnMxVzVqR015cU9KeXAyYk1COHJncEtBaklhMmVrQ3do?=
 =?utf-8?B?bDFESkdyY2JYWDVSVllSSzN6SmkyK1U2NGJ4cHVaSVdKb1gwOXRZNFd1Mmsw?=
 =?utf-8?B?cXk5SWZuOGxXWWovSFYxTFhOaDE0cHdKejdRUFVaaGVzWnVhOG9oT3prcG5E?=
 =?utf-8?B?Z0xYZkYvanBGd0Rrb0E0Y1NNQkgrbWFwc1hmZ2RwUVZDUytNV2xGYnU0SDNu?=
 =?utf-8?B?MUtqYWwwTW9YY2Z5VEVMNk1KdXhFTWJnRU5UR2dBQnR0c2lONVZnZUdUbEFl?=
 =?utf-8?B?RzdTQ3MyVDhYdE84WkhYbnJpckJ6OUpscXprS254MzRENnVLU1dwVFB1a3ln?=
 =?utf-8?B?NUw2Wkk1WXBDRjllNnRQSkFrdFdYenZXaFJoNHY2a1oxWFdxODNnOEJudjNG?=
 =?utf-8?B?NXpRM3ViRXJSb1g0cFN0VWVYZThyWnhNNGpIa1YybUJ5Z3dNak92ZDUyeEY0?=
 =?utf-8?B?K0FaSFVTYzh0SC9GSlI2RlVYQWRpc09VbUZGSG9WZGZyMWthbzdVNGNYcWha?=
 =?utf-8?B?T2lyZFpSZUNCNDV5OHRHZjNOZ0hTLzdpc3V1bS9FajhYak5vM0NmTE9ZQjIz?=
 =?utf-8?B?MXZVcm9Jb0JPTWozTmlqTWJGTXBWSzhDNjVXOHF0bGk2cWJjajJqaXYrR2pN?=
 =?utf-8?B?dVVjMU1FVjZTSE8rNGtnUk1WTTBreHY5ZC9FVTFESzB0V1JTWVNyOEJLK08w?=
 =?utf-8?B?MVcrRWFFeGxVRCt5MjA3dTdIOG9ERnZCN1dCcGtjMUNsM1h6ZVJFMUJjMlgx?=
 =?utf-8?B?dVFNdFJtcTh0amxEdUFudUE1RGFpUzh6Sk9NTnJrYnZ5d243U0lMNFBRcHc0?=
 =?utf-8?B?L0U0em1CUWc5cGZhVExDUjR4MnpwWHNJakhDckRLVFNxSlo1RTZ0ajF1WGsv?=
 =?utf-8?B?cG9BVXNmS1plRGVFMVlVTUN0bm5MV0cwQVZyT3gyYzZUazZiREwyNFFqa1hX?=
 =?utf-8?B?Z1lGMGtxMzNNMWl1RTQyQ01GaEpKWk9KYXRJTFJ4aUNZaDQvUlNxM3VJWklE?=
 =?utf-8?Q?0U8SJcaXxWFx14rE7Uoi+5sFrH0f8KQcNwjIhEM?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWhQenFod2g1cUdDU255SjR5bCsvMGVEVE1xRnROU2Ywa29Eb2dZS3VmdEU0?=
 =?utf-8?B?Q09VY09HN1gwbDYxL1ozQjlDdDNmQXYxRHk3Z2xPRTR3ZTZka2lvQ1JpaHhv?=
 =?utf-8?B?dHNXTkVjQTE5cHM2azF3VjF3V1YzSndHZXZYMVYrejZ0Sytuc1B4bFV1Vnd0?=
 =?utf-8?B?UCtJVEduRXZ2a1UyamZva1ZxZENFK1A2cXBNb2ZBZEVyQlhBMUtqU2ZnQUNP?=
 =?utf-8?B?eDNnUFc4bVdMTXFSQXZ4aWFTRVZvYTZjK0J4U21uMy81K21iWjhjczloTUZW?=
 =?utf-8?B?cnNVTURjd0dMQm9va2EzY0pUNWgwM1NvY3paY2hSZVlYZ1k5N1FvNG9CREo1?=
 =?utf-8?B?RUdRSDB0c0lBbGRYUU9qRmtvcmcvaE9qKzZzMTlPMDdRU0F1cnk4ME9Xd1FX?=
 =?utf-8?B?NTJlYnFkK3Q0eXNuRE4vVU9OdGxWSUFXMVY3WU5tMkZYV2lkZVJaK0M3cUJT?=
 =?utf-8?B?aVBjenFJNTJyWndOM2gzMkhXUTFoVjAxMVdybDArZU5XNC9BYTZDWS9QOWxJ?=
 =?utf-8?B?MmFPczV3MHg1cldxbzFvVG9PK1F6M1dYOTNXVlBBZTZMSFdSeDd1WXBVZ1FK?=
 =?utf-8?B?UWNURlVWOURnek5BdWRzYVJ6TTcxZFJ2V3BQTzN6TE5iRW1JYW1DelFRQmdK?=
 =?utf-8?B?ajFIcDBwd3Z6WGlJQ29hN3ViYkh5c2lMZVhkazZIeDZhNTEzN0piakIzbXJw?=
 =?utf-8?B?NkJhSE9UVHk5SXY1Tkh1K1l2Q052UnlWQzkxVkVQNU1KRitEK0Fvc3YycG9H?=
 =?utf-8?B?VHpqRnVHMnoxMk13TTlKZVJOck5iTEVYbmVHWXh6d3kvTC9Jdm9jNmZWeU1S?=
 =?utf-8?B?SnhqNTlkelA1MkNMb3RpTlAvLzl6akFpOHNCSXZXaWRtckh1M2xXVzV5azVI?=
 =?utf-8?B?WlVhMnRWekFpemJxanlvTkIzNk42MWRHTVRtVVhGWG01U0luZlBxNHNpckp2?=
 =?utf-8?B?MkR5bE1aTVJLZzlzMlluMFNWTEd5aXRBc2E0S1M4RC9IQVd6cHorVkprQ3FV?=
 =?utf-8?B?NlpJZWtPa2hDQU92clpycDVsZWlXWDEvMUxGL2s4WXpxT0M2aUZqQ1FwNXNm?=
 =?utf-8?B?LzZUN3ZoRXpjOVZSc3VvZDdDR2wzSTRyTjV2RW5iSVR5QW8xNmRKMlgyT2Zk?=
 =?utf-8?B?TnQzMW5USUp5UnBWTklxc1JNZVZQUmxCMWRENEF0MVNPMzVGSDllaFphK0tL?=
 =?utf-8?B?VUdEZkcrMk82OGU5dFg3Q05yNmZ0cEUzK1QwZUNhaHpuQW5SbGpIa2tXVjEx?=
 =?utf-8?B?U0xxNU1IU2lMcDF0R1FUaXlzc2orTzlka1FXOXEzY1FRVUg0NTNRandnTjFO?=
 =?utf-8?B?TnIrRG83UDhJcmNvcVRjNUQzRWFkOUg1V1NrcVNZWmg1QjhTOVBiY3pWMWdt?=
 =?utf-8?B?TFhFcy8wV0VvQm42eHV1WldDeE1YM05lRVQ2VC9KWkp6bFkvTUVYRmV2d3ha?=
 =?utf-8?B?V3p3NU1JTmdKbndmWGJkeVFNN0tvYlkzN01OZ1MrYnlUYmE4YnNOZWhaUTAw?=
 =?utf-8?B?blFwcGUzRUllQmY3cC9ONkFDQ1hPT0VTUE9WbVk0VzhzemNoMThIMjkra1RU?=
 =?utf-8?B?bCtqdTBuTHpoRklpWVpHMlpaVHhDTEloM2dPbFhvSC9GVUk0aEZ2TXpvbnlh?=
 =?utf-8?B?eXdYZTRHS1dJTVlMcTB4S2xsYnB2NGRhd3cycTQ2VkFOV3c0Z1QxOTlXdmVx?=
 =?utf-8?Q?o+vgQ3jEzv/5tkVv4OJO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a117ec-4e31-4957-a5a3-08de025f7960
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 09:30:22.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4335

Hi Kathiravan,

On 10/3/25 13:04, Kathiravan Thirumoorthy wrote:
> 
> On 10/1/2025 7:34 PM, George Moussalem via B4 Relay wrote:
>> Add PWM driver and binding support for IPQ chipsets.
>> Also, add nodes to add support for pwm in ipq6018, ipq5018, ipq5332, and
>> ipq9574.
>>
>> I've picked up work based on Devi's last submission (v15) which dates
>> back to 05 October 2023 as below SoCs are still active.
>>
>> V16:
>>
>>    Removed reg description in bindings as the offset is not relative to
>>    the TCSR region anymore since simple-mfd support was dropped and PWM
>>    nodes defined as their own nodes, not child nodes. Updated the example
>>    too.
>>
>>    Dropped patch to add simple-mfd support to the qcom,tcsr bindings
> 
> George, thanks for taking up this series.
> 
> Can you elaborate on why the qcom,tcsr binding change is dropped and 
> made the PWM as an independent node? IIUC, it should be child of TCSR 
> node. In V15, I see the qcom,tcsr binding is applied and *dropped only* 
> due to dependencies / lack of information on the "pwm-cells" property.

Please see below patch where it was decided to drop simple-mfd as TCSR
is configuration only and any child devices should be defined outside of it:
https://lore.kernel.org/all/20220909091056.128949-1-krzysztof.kozlowski@linaro.org/


> 
> Thanks,
> 
> Kathiravan T.
> 

Best regards,
George

