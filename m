Return-Path: <linux-pwm+bounces-3985-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8589B8475
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Oct 2024 21:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB37B1F23069
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Oct 2024 20:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9CC1AD3E0;
	Thu, 31 Oct 2024 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="VGPCXslt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2097.outbound.protection.outlook.com [40.107.21.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD11531C0;
	Thu, 31 Oct 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407071; cv=fail; b=fnYIwMcjpoqvueZZX7NNSsfcG4/S8BTKzw/FSEDnhuZmu/hTQkZno+tKCk5wZhliELnvXEJ0wltQZuDVG8At5D12g9TCUj6N5Vqu8oKBNgTm401dVCuW/jPouAMxlUd3qa9bSscfxpzTRDnmZTaoLxtucmEai/jB0bUBT9b4erE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407071; c=relaxed/simple;
	bh=srGkLE1wHn1okPFYBPx9/yed2V/7nyicztS5TWyESFE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PKVNl7kbavNx8525y9k2CdTEMRJu0b5X6UWxzida+9cz0qh1gYp13QhFYpszWhYsJ2WHNWJUVfIaCy2nAVmdVMEbhcdV5Etp1b/8Bs1We65BWweqtkoiSUcnWtXXK48fogwmcmI8s0H7BFD02BD498T8q/SaS6jZFRMJmkbtua4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=VGPCXslt; arc=fail smtp.client-ip=40.107.21.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9sjLMgm2YSlg3kWaAbRMH6GjBAyOUAnPjxkOlzRxer/hhze0w25BdbJM7+Y9Wkt0oQrW4J+BBFAlTE08awx5h90pG2EhBtIYpzJch7ejELl6/G7ccvSKAup468l4/oZLu0fuTIv7Rv/n7tf3Lf9EowLu9jA9MhzPek0Jav7nrHAGVV0/1PhwxNi61WnArzBMwI0aYBCoMTxrPBqOnQFyd7yW7lWuLYGCBWnXzXrxYgFPdPMxCymWDho41ri+GCM4ou7wa7Rx0gF0kK5yHvLkxVi1bE3Tkm7EKH/HO06tj9p7oJgfO3qaGmF25nAlb0FrJFNmfkBR+1IqfMA1BJlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZDQn7AFePZJtH3DTQJAOVefeUvsFO4c+D327S305po=;
 b=MJmxyjF8A3gKXNOawG2jiJwqWDitwwB2Fes3LxqZFKyhGxMefEA9mywLEAHHV8OIhIDwukB4KUb+oLzlcDq8FXDBA42B6OERmQHjC5t8gPKt8V30oeMAEUNjRsEPb1CnfSxgGhVr+D492oLW84Yp5UMBse2TfYJ1/Nub1a4UWvpt8pKz//WKlLzyYn+NDtvReDZyGugCY+EgDq5A1H442TotiATVOWTRH+8pGO787tD6/iXPuI6uz+sPEPcY2OJ8PCng3nvC983euEfDMj8yIukVYkuvFuF/flWupbnh545y1ZeFxycHuBq2ANUaX0aFqY9i6EIC4fhE1oshE7gqUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZDQn7AFePZJtH3DTQJAOVefeUvsFO4c+D327S305po=;
 b=VGPCXsltvOkVO5iGhPobnUm860hc8L0DGhb7QWhQidWpETQmmDjG+2wb6D5qKIZcnJSAsdmoD2FV04dZdvqO0bG3Ezfury98MgSRuFj8O4J3wwvt2Jeqn4JcxdkFAifzXIMdl6N7t2ufGOQNS+cEz2vBJGW7FYJ3wXEvaYqRr1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18)
 by PAXPR08MB7350.eurprd08.prod.outlook.com (2603:10a6:102:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 20:37:43 +0000
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35]) by AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35%6]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 20:37:42 +0000
Message-ID: <bc8af1b2-7537-4abf-962a-32e95e9dc3fc@genexis.eu>
Date: Thu, 31 Oct 2024 21:37:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] pwm: airoha: Add support for EN7581 SoC
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
 ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <20241023-en7581-pinctrl-v9-6-afb0cbcab0ec@kernel.org>
 <bf5lpb3dwfywzgnbcel6de57ick7hfzxfaovyqrt7juif6tgp7@sdmugrua6t3c>
 <184f8707-0b4b-474a-b2d4-b54a3438f4a3@genexis.eu>
 <ljpgey6oqeisnhnf3zojnmczxvpduabj6cgf3utef3oic2k27e@r5sbpdxwzghs>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <ljpgey6oqeisnhnf3zojnmczxvpduabj6cgf3utef3oic2k27e@r5sbpdxwzghs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00014AF1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::305) To AM9PR08MB6034.eurprd08.prod.outlook.com
 (2603:10a6:20b:2db::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB6034:EE_|PAXPR08MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a0164b-bfe4-4fd8-c6e6-08dcf9ebde8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUI3NEhCVmFveEc2bC85clQ5L0NRUzFLTzlWTHJvWndNYm03Q0xNMkZkVGor?=
 =?utf-8?B?L2lNUXJ4ZVRtZVlyMVVmRllSdzVpMU0yTEtUbEFvZ1hiSTU0QVdWTVZSM3RW?=
 =?utf-8?B?YW1NMU1pcENoSC9NRVRHQmVFSzVlNTlWWGlwZFh2UnVsQWVLVmRERENwcWs2?=
 =?utf-8?B?RWZKRjl1dkZ1NnlwMVdENU5QeGZZWHFqN1ozOE1UY0ZyZGZqUmNRdXVpNnJU?=
 =?utf-8?B?VnRkZXlHS0o1UzJlbHE3V1lqSFZWSFI3cUdOVW1jTmlnS09JamJkYTJsYyta?=
 =?utf-8?B?ekcwQkpYdkpVaTBKT1VPNit1eVB0c3FQcHlQK3NKZnQySkpSSW1zTlVwNWNr?=
 =?utf-8?B?OFN6bEZaZFBBK3ErdEQzZGRrSTZ4REVNSngyckxCaXM1S2NnS2FBVVArWDFC?=
 =?utf-8?B?MFlkd1F5c05paFZBWXFEUFlzZC9mVms1cC83WVN3ODZpWGgxcnE5Y2tKMUNj?=
 =?utf-8?B?YW5yQ2tQV3JFbVZOUkdyUk1sQVhDamdKeDZDcWh0djZzR25Id05Pb3pLalpN?=
 =?utf-8?B?N3lTeVJ5eFNIdkhJNks0d2F4bEE5R25vaU9IOGk1WitjSzNRWmRMVzRnY2hX?=
 =?utf-8?B?SXR0eTdHUkVHS0ZsZXk2eUxMc1FYMmF2dTVOU09lNVFtMERYZnF0amcrR2pG?=
 =?utf-8?B?TnF2bXlRVElzNGFWYmJIajMwY3dNM21rSFZYV3hYQW0vVmFFV2tUa1lRVG0r?=
 =?utf-8?B?TUtuNjM0UllrZjRnSzArdUJOTXVndmdTbk95Rjk4K2NITW91eTE4ZGExV1la?=
 =?utf-8?B?Q0RwbFdnaStzb3VrQ1JIVUxwL2lSNjlSZU1HeVEwSEVyUHNjck9yQmNXUmdY?=
 =?utf-8?B?WnB3d2VvalVEZUE1ekxiVkhoZityU3dqMFJmSkZSZm5BbXEvQ2E4K2NOVUdp?=
 =?utf-8?B?aXBEenJDQ1ducVducjd3N2JZc0U5a1JXZ2Y1T05NOG1CdnNzMzdLTVhqRVRz?=
 =?utf-8?B?UUlZeWU3NHlxa1Zya0NNb3d2ZmVTYmFndk5FMkFES0hEaTlsZEZVQk5MQzhK?=
 =?utf-8?B?MVdIT0pWZnFmZC9WanJLSnNKdCtjTzJwQXRMOXVaRFQ1Ym9pWDE4SlJtc2Ew?=
 =?utf-8?B?L25WaVUwWmpRMjUybytZSktKL2JwTzJLVWc2RmQ2SGgyZ2l3UHhwWUpFajRS?=
 =?utf-8?B?R0NBZktIWDFvMEo3RDAzdGp4NUNYbHREcnlESHRFdXZRZXhnUHcvUzFGSnky?=
 =?utf-8?B?UGdTSzdCSXpGWTdSdTRMRm5BSXhXekp6SEpRdFZlUGxHNlJSR0J2V0hPZ1Rz?=
 =?utf-8?B?NWZpSkl0akhGUElHY2FFbGgwc1ZwcHNXNFJNOTlIaDBuSlRkWHV1OEhnM2FK?=
 =?utf-8?B?SmRFQy9xVmhvZFhUMjVEekpoM3N2V2pTSm9TWHhqZVArYUhBb2VxUE9PYllE?=
 =?utf-8?B?Q1VaSldHaUp2Sk5QV2FuQ1YvdzJ1M0Fmckp3b1N6MTkwOHVCNCtENWJvODlk?=
 =?utf-8?B?cFNjTGpEZHlWNXc4VEJUUndZYkZRNG8wanN1dFlhbFZKNGF2b0tHZjhhZ29Y?=
 =?utf-8?B?Y1REVDNGMytKd3BPMFkvdkhhOU5YSXZGVU9YdjNBMlBkcjN0Y3h3ZTFTVE1H?=
 =?utf-8?B?cjhVYnJTbkxEVE9oT1JVcGlBM0I5M2JLSE5xdDhnM0tZZlBmb0h5SnpZdzBZ?=
 =?utf-8?B?TTZwYkFteEJoWi8zZktUemRrZkc2RDJQUmtIc0QvK2k3NjZoMVgzWXFzczVt?=
 =?utf-8?B?SEJtM3JTcDhVclBTcFE3Z1FHT0cvZUEydUkxSjlpUmdFM3RZV2dIRjVHU241?=
 =?utf-8?Q?+Vk7JfBLAnE6vdQFwTUzQXGg7mFyPAmOWe4XZWf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6034.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KytMQzVpam9QM0RLZE4rZW50dTBiTVVFZHRIa3ZQS3ZYR2JNbFY4UFoxbXBB?=
 =?utf-8?B?dWNBemswdkFlRVViZmlvSk8xWWlHU2x4Vy9nOEF1WHROc2dybG9oaVNWVkNo?=
 =?utf-8?B?blpiZ29aUHNLejFxblZkbG9TbmNaQzAxKzAxYW8wNzd1bHhtMSt2d2pnQVYz?=
 =?utf-8?B?d0lqRnBqNG1WdVZRSUNSa0VxQlBVN0tPOEI2UXc5N3JLdCtGUzN0Y2o1UEFa?=
 =?utf-8?B?SjZYMGJIeFBnQm41UHRsMGo0eXVxS1F6eGcyTUZQbWt4SnJ2cnp5eGMxT3F2?=
 =?utf-8?B?VVNmQ3BxSTY2LzFxbkltL0h0ekZIU0dCL0lRbXowWVVNaC9DS0IzUnNFS3VF?=
 =?utf-8?B?TUJvemdpWmpUTjBpNEVSRnRMZllEMUhoUDBPbUlBOFBjWllBeGc1MXJRWEo4?=
 =?utf-8?B?RW5JU1BBZ2llem9XeXpzY3V3R2NKWTc5L001SFprNzJuM1BPc2ZMbGlzQ0hj?=
 =?utf-8?B?ZzI1NzAxdEhBQk1EcHBxSit2cGdjQXZSeHRHSVJPQmN4Sk82WWdqeU92bHgy?=
 =?utf-8?B?amxIK1pIV1l3Sng0cWF0YkFGRHAwNnlDa0RNaFdzRXBHQS9JbzR4a3ZSbmVO?=
 =?utf-8?B?TzRVbGdQVC9Xc3djMkZuOEpmaFRSZ0l2TlEyd1JMYW5nRWRVQ1pnanpoTU5P?=
 =?utf-8?B?bWhRbWk2a3ZqM3hGOFVlbTczSFdSdUNXZ2NTaEMxMkRlRlZUMEU2R3ZLTkVV?=
 =?utf-8?B?V3Jja3ZmbElzbFg2T2piUFljaEY2d1RWd3k5bFpmR2YwTmxJNFl0WEd3elo2?=
 =?utf-8?B?N1orY1o0OFJOaEtkUGdjd0w0RmdRWDlyLzlZNXA3SXhscGoyRzhOMFdvSUR3?=
 =?utf-8?B?RkR3TG5KMWlGcmxOQjJhRjgwT3NsNzBCOHhJUStleEhHMHBxYVpMOExMeDI1?=
 =?utf-8?B?NVNEcHhiSE8wMnRrN25CU1lwclZna3FmQTdjZzNhSUNiOHVWMzk5VGxTNEdn?=
 =?utf-8?B?NHNZeC83Q0g5TjhGSE1VdWwvVmFyWGRONFpBQTdaVjRSaERuZUdkTHlJaXMz?=
 =?utf-8?B?UjljdmtSMDViRFFjSTg3SStSY3RFWitadHlkM1o4R1BiQ0JJNFpoMDB2KzdN?=
 =?utf-8?B?MVd5QlJOSGxrZllMbUIwbnByalI0VFhxNyt4Z3JWMld4U25GSEpSZlJhNTNC?=
 =?utf-8?B?T1B4a2twdXVMMkkxTU1mL2wwTDRibVhWcHRiVzdmeExtU2cvaWFGYWdVS3Nz?=
 =?utf-8?B?dndNQ0drQ0xCWkNaWVlFY0lIZEs4TlhRTktGQm9WckpVa0hWakcvV1NvTWFI?=
 =?utf-8?B?eHZNM0UwMERKM3ZOVldkZkpPWGJtMUhEU2lROUZROHRyWXNmbFV3Z1hzYlR6?=
 =?utf-8?B?cnl6UGJEVWhkeUFHai9ab3R4S01melhoT01jVFBrTUpjKzhLNkxtVGNtcGk2?=
 =?utf-8?B?N1c3aVUxZzl5UmJKNXFkTjQ1amczU3hrempRZTQxWS94cWhOOW1KK2l3U3Q4?=
 =?utf-8?B?WmN5WWRCMmRRT0VIaWZqVmthVEdYZ054Rk5ySVBCR0Uxcm15UEhML3AyNEo1?=
 =?utf-8?B?dUtmeVBNM2hhMWU5N2M0M1NYek4rS29QakRGRzV2UUs5TXI5WFhacmVqcUpa?=
 =?utf-8?B?K0k5S0xiUDFRcXpQd21ab0hmVUpSbmFGQ0Y2djM4RTc5L1kreVdCUnJKVjRE?=
 =?utf-8?B?TjRpd1REMzMyRWpkV1Zmd3lndGJzSHpzSUpJbFdpd0xLT2IrS1d4aDFMK0kz?=
 =?utf-8?B?L2ZrN3dscm90T0lwcHlmbjFQTnlvc3NTZXI4UTFnb3VlcUVKaGEyUlBJeXFV?=
 =?utf-8?B?M1FZY2hUMldyM1lNd0svYVFLM2gxTHVZN1k3TEVQa2NDdS81RHlHRURQOEpn?=
 =?utf-8?B?RVR3QVJDZk5meHB5Q1Q2ZzVHY1N4NGVwdHd2Z21ma2hkQUZBbnRpTGk3Uity?=
 =?utf-8?B?WENFK21NdEJDeGp6Mno2VTdvUEk1MW95VXh5UTU0dWc3ZUdIUFkzNjU5NXI4?=
 =?utf-8?B?ZEU2R3FSZE1IdmdyTHVQcStkUm5md29SdnZXRE5MWVFYbnN6SFNtZG5MMDlk?=
 =?utf-8?B?czZsb2dFdVRvVkhUUnNqZUFsY0hyb2haWitHUXZObjUzbXQ3UTJHQVdObXhY?=
 =?utf-8?B?Vmw2c2FmbS9xdDUxQlhOdVhTZzc2WkpoNXZvdW9jL2V2YjdheWJTNVkyS0Vn?=
 =?utf-8?B?QlVIMkVHM212dm56SllKb0VLZndLd1dCUHBZRGxZM0JGTzV4R0t3L1JYTlQw?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a0164b-bfe4-4fd8-c6e6-08dcf9ebde8a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6034.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 20:37:42.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uUMc/vcmaSIHpLFtxIfBq2c78CtsYDiQ6ixZE/6XFDY03Yp+UmPwoLpbC6MXTdTYz0eAUWiI3qbrKBEbIdBlns3hG49wAx+Wj11WHf/FZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7350

On 31/10/2024 11:53, Uwe Kleine-König wrote:
> Hello Benjamin,
>
> On Wed, Oct 30, 2024 at 11:14:41AM +0100, Benjamin Larsson wrote:
>> On 2024-10-30 08:32, Uwe Kleine-König wrote:
>>>> +	/* Configure frequency divisor */
>>>> +	mask = WAVE_GEN_CYCLE_MASK(index % 4);
>>>> +	val = (period << __ffs(mask)) & mask;
>>> FIELD_PREP please.
>> Per my understanding FIELD_PREP only work on compile time constants.
> Then please create an alternative macro with the same semantic that also
> works when the mask isn't known at compile time instead of open coding
> the same concept several times.
>
> Best regards
> Uwe

Hi, someone did but the code never got merged.

https://lkml.org/lkml/2021/11/22/532

So the current way of doing it seems to be to open coding.

Are you proposing macros like these are added?

#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))

MvH

Benjamin Larsson


