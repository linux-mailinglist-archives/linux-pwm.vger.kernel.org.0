Return-Path: <linux-pwm+bounces-7909-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 125F4D23F3C
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 11:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A169C30038CF
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE56357A23;
	Thu, 15 Jan 2026 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NbtqnsJ9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazhn15012018.outbound.protection.outlook.com [52.102.137.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129DC35A94F;
	Thu, 15 Jan 2026 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.137.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473148; cv=fail; b=Mg0iJb1G/DdFJkwcliQOrM4E62FHaCVeuy8aYe4Rkc43mtRmBYMTiBffiNJImxUsl6e6z5yAkA074rWpu/mll4+DtGVqow+434yXW0B29HlwNUWvELnfkVh72jB2mZnJvGy2O3DrufpoIAFOZ4h/ECs3698bebRPDVhmTaA1oY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473148; c=relaxed/simple;
	bh=IbtE+rC67nnn8rzTpS25ZNPFQO3cmTxTDIe4tYXk7DQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=kwY8tr5d+pIRC5jlSUkRpiD6gOuG74ObCW3KtpB+cdFsUjYBlUjsckHQn9OW+RUT43CqlIc7m6A69r8sHbvQeFDAeWgtnBzjmLEUMVqQQgax1M5xBpDDn4mckwg2gmm/i15WT5Cd5AS0BIJCousMBHQotxP/pfHFaGUXDsLebag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NbtqnsJ9; arc=fail smtp.client-ip=52.102.137.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5p2HHqD/05fK4Jnb7pBINwsenF+zks3EiAQVoPxxNd1UqYhTHGbU9wKBgmFvTzI4x9EanRFjFUAaEZlLZigzB0xddPvPzyJ9RSGhXXJsn9KX9gLj5sggrogx37TZm65m9d4XngEQOjAN+5Kz96TWVLK6s75VwyucJ/n95G3alMQ7yOgOzrCXsfYwB5Q98e3v0I6efJkzXEA5hj7ucJBBXSSTCAK2MBCM4DQRXfpMIaaVVOVcrL5eQVBWcurXk1sSWJghsAHL6pFnfq1KYf4p5pxAcc7fly/tkiN6C3GP/wGW4yPGwsG8vDHVhYhhkLlOWJ9ejA96gOiFiRI8r5zTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/PdVtptb5JM2x6aU68qK8OI2Zn1sDdc2KdEJVmjuWM=;
 b=HOlSa9XVhRcVHHVJnfg2AXTgxPb264QkxgYas31AzFl2Fi9kJ0FlXRPw5Ub1a5gBvi4LPTKyXgRMvMRWYckQhWDBbD9OVWPws4Y+kCYQkUn1xxp8eVhN9OOgv/z5Y2168xm+ZGqwp3EsKSMmWy6XtZgJ99JdwWP8wrVY5/RFXykgmqzuuGEAmK1SIhYHKZ2IuPAz/sYj2ZO2Zgo+QYXCgHmXxHIezF6umccwmTEE11xZSx66bp8vZpl8voL7mtznM6WFj2CzKqi48JXA/ZJv4ZVyep86P8UH3MfWAeTmGSLOuyUukUaZ7AWyLBqFjrHaX+OKa7QeY0DEFFiOeRvZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/PdVtptb5JM2x6aU68qK8OI2Zn1sDdc2KdEJVmjuWM=;
 b=NbtqnsJ9aFOGrXemVvordjqRYcpcHRbpJYpvS9uLDXfiypnfWV8EH/bXYl6BhWZyh9MsTGnXSq6HB7CbZt2LVUTm9ojmsvVW6JY8cHt1cBdOKnz7EV49oBS4vmHQ6aJGcac5n7uGVewm+PvriZldjkii5+RsayRnYrcyKLZsGs8=
Received: from BN9PR03CA0680.namprd03.prod.outlook.com (2603:10b6:408:10e::25)
 by CH3PR10MB7743.namprd10.prod.outlook.com (2603:10b6:610:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 10:32:21 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::1f) by BN9PR03CA0680.outlook.office365.com
 (2603:10b6:408:10e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Thu,
 15 Jan 2026 10:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 10:32:21 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 04:32:21 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 04:32:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 04:32:20 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60FAWHlW1419100;
	Thu, 15 Jan 2026 04:32:18 -0600
Content-Type: multipart/mixed;
	boundary="------------j1r0xgOJm8I9pV7DD1h6kRvq"
Message-ID: <63a0c480-c953-4717-9efe-766038d7fa8b@ti.com>
Date: Thu, 15 Jan 2026 16:02:16 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before setting
 configuration
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
CC: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, <j-keerthy@ti.com>,
	<linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<n-francis@ti.com>, <u-kumar1@ti.com>, Gokul Praveen <g-praveen@ti.com>
References: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
 <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
 <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
 <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
 <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
 <xdj2ceubkss3ingkxdvc64zqrcd3wzz2uxa6wqwgvilu2ykukc@hbn6tt2gnxj5>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <xdj2ceubkss3ingkxdvc64zqrcd3wzz2uxa6wqwgvilu2ykukc@hbn6tt2gnxj5>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CH3PR10MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 292d64ce-5b23-469a-2e8f-08de54215dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|34020700016|36860700013|82310400026|4053099003|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFAzclo0MTIyNUx1eUp6MjBIVWlpSGlDT1poZXRNWDdza2ZtOUlDWDRuOEdx?=
 =?utf-8?B?ZEJkbDVWRVNDVkxZdmszZWJXVVRBV0J4Mi82RkhpTXl0Vk5yaXY5RnVrMnkx?=
 =?utf-8?B?eG1IUkFGbElGRDV3ZmhUbmxJMmFyazFRVDhDYkhmWGU4N3VoNW11eDJ6UUVw?=
 =?utf-8?B?VE92S1BGdjB4T3FDdHNaVEVhakswMHF3RlVXUHVrVjlJZExhZzRaWjJWS0w5?=
 =?utf-8?B?Nmt1bWNqMElJV1FCbEwybnRCaDBVVTdCT1A4amk3R1dSNUtJMjhVc3hwMmpw?=
 =?utf-8?B?TG9IeEV0OW5OV2Uyb0hwUnlka29XUXNmVTU5TCtXUGlVQ0J4c3JzODZjcGhw?=
 =?utf-8?B?ai9xTGYvNGpJa0ZxWUhqQ0J5R1VHK0h6WUpwS200eTlkeGxsb0R3UmlTVVdK?=
 =?utf-8?B?VjI5UHFZblN3Q1NXUFFST29LVlN0b3g5UEdIb0cwOGUxR251MzBWNkFxZEc4?=
 =?utf-8?B?ODVtOVBRVWZMWU55OUJNWU9OQWdGMldYNGU4U3RwbVZOK1V0aU1rZUVrWEpS?=
 =?utf-8?B?VG16Vnd0R1RvRHVrVlNTTWVpN1JUdXBqTnVRSDM3T3kvYkc3YytwRnRpUmE0?=
 =?utf-8?B?ZWhxUkNHN1J6SytoVEJmTElaTVZvb2FsNzNLaklVWmhaUzdpVE5OV05zRDdE?=
 =?utf-8?B?SStoQ3BRMGQ1QkQxa0NzcjI2R3paeGJoVHQwclBQVWJaYUZ4MnpWOHMrRFVt?=
 =?utf-8?B?TmZlZkxLNTkxT0hxYTFKdWIzRklxRHRyVzZSSlk3SkczTHV0M1h3dUd6eEY2?=
 =?utf-8?B?dVdxTjZWY2w0K1AxQXl6dFJheXpKK1hMR1M2K0NHem9Jei93ZEZFZnBwdzc4?=
 =?utf-8?B?b0FjcnJDd1V5WEpPWlA4elRhN0JPL1ArTWtDMEkxVmdPcGkrWmpCRFF2dG1X?=
 =?utf-8?B?azFYQi9ReE5TRTRRSEpjZmRJREFCT0o1ekRJRkIrSWNjazVBU29JNDhHbEF3?=
 =?utf-8?B?NEFYbU9qbTlMaEVSQkhBQkdXTWVIQ09pTmhNQmlKTUIvMnAweSt5ckRGQXJT?=
 =?utf-8?B?MStnUzV3R1pQaDI2Qm5acTFVOUtWZU9McDN4UmRLU3IxbXZZWkVFcDdZZzVs?=
 =?utf-8?B?Z0V0eVBEcFpoYXRZRlV1bE9VQXBTSE5nWklFYWptSWVJY2tqM0pqQ2pFVnlR?=
 =?utf-8?B?OGF4ZE9rQkoySEc5VHFUKzVSZHZSNkRrdS9yWkhidTBRdUlzVXNDNVh2dlNT?=
 =?utf-8?B?YTVES0NxZEVUVWFxdHJweEt0cXF1Y3cyS2dxRHVUZ2lVOXVJQWhzMWFkak1X?=
 =?utf-8?B?bU5ZNmJhVkgrcVBSN0h6NzlITTl2QmRjd3ZicHlOcTNBVzF2dXlIbVhLUDd2?=
 =?utf-8?B?WGJjZ3dyU2o4RGpCS2ZMK3ZGK2dpQldtUEpZY2JpQ0tqbDlUVC82cWVVNktx?=
 =?utf-8?B?eTVZajA4UVpiT0FVMzF0Y0t3VTFVRDBGVHZCWjA0eWdhVnNmOUp3Q2tVbm5Z?=
 =?utf-8?B?VmcvcCtnM3RuTWhNbmltcXFIQmlQejhLTnFERlp5ajRyVWFCc2IwUEhmRmdV?=
 =?utf-8?B?VktSQ1o2QjB4WmZzNVY2dGpSRkZCYXB5MHhZMC9XNTZwV0ZXSW9wanlMbEY0?=
 =?utf-8?B?bmxBb0xiTkhGbVFZbjg1ZVZCL2FhcE02bm1UMFV0ZGd1MEphZ0FGNkRXMGRT?=
 =?utf-8?B?bWxVQlJqeVFIWjFvOVJOVUZhVFVySndVaHdiQ0JtdkxVSUJuU2dPcE5KQlRu?=
 =?utf-8?B?amtQc0g4enVYc3lxRGxyaU52TnlKS3hnU2twb3ZJU1M4cDNzd2d5dFB1M1FV?=
 =?utf-8?B?b0VBNGJHLy81NU45VEIxc0p0OFQ0NjQwTkR0VlVRVkVLVll1OC8raHJHMkZz?=
 =?utf-8?B?cXFpbE9UTk1UK1cwZVR2T2RRQjkzcGtzcUpHaFNha1A0c01VaXlJTFNOUi9u?=
 =?utf-8?B?SDhyLzk3NkpaS1Yyc1pwajVGRlZralFGZ2IwRFlseVBMa3JSdFJFd05jVmJ4?=
 =?utf-8?B?ckZ4S25GdXdrN0xZeDhwWm96cmlZNGd0ZGZPZHFSLzBrK21YbEZzZkNpd0Ry?=
 =?utf-8?B?cWxpZWVuT2lkcE9BZ1VYRDZ4T2ZPcmZjWE81cFVldUN5RG15dXEwYno3RTFt?=
 =?utf-8?B?UHJnVkVWOG44SitQbEVGSUh5eGhrREE1YTBFSWJzamlnemtnU3RwN1lGOUkv?=
 =?utf-8?B?bEYwWUd5RUFqODQ2bjdJWURzVHhrdHA2N2dxK1BoZ2F6NnVBNzIwWjQ2WkRI?=
 =?utf-8?B?QWd3bXRVUzJjVnBObUpVVjhpak5VRDR4cE10UEZSNjBZazFDK3JoLzczdUc1?=
 =?utf-8?B?RXJPWUpiYzErblBvZmxiM2lPTlVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(34020700016)(36860700013)(82310400026)(4053099003)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 10:32:21.5730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 292d64ce-5b23-469a-2e8f-08de54215dc4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7743

--------------j1r0xgOJm8I9pV7DD1h6kRvq
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe,

Apologies for the delay as it took some time for me to get the trace 
output as well as to get the way I reproduced the issue.


On 10/01/26 04:23, Uwe Kleine-König wrote:
> Hello Gokul,
> 
> On Fri, Jan 09, 2026 at 11:21:46AM +0530, Gokul Praveen wrote:
>> On 08/01/26 23:40, Uwe Kleine-König wrote:
>>> On Thu, Jan 08, 2026 at 12:10:35PM +0530, Gokul Praveen wrote:
>>>> On 08/01/26 01:17, Rafael V. Volkmer wrote:
>>>>> Thanks for CC'ing me on this thread.
>>>>>
>>>>> On 07/01/26 15:21, Uwe Kleine-König wrote:
>>>>>> adding Rafael to Cc: who sent a patch series for this driver that I
>>>>>> didn't come around to review yet. Given that neither he nor me noticed
>>>>>> the problem addressed in this patch I wonder if it applies to all
>>>>>> hardware variants.
>>>>>>
>>>>>
>>>>> I also didn't observe the issue described here in my testing: duty cycle and
>>>>> period changes always appeared to take effect as expected.
>>>>>
>>>>> My tests were done on an AM623 EVM.
>>>>>
>>>>> One possible explanation is that my test flow mostly exercised configuration
>>>>> while the PWM was already enabled/active, which could mask the effect of a
>>>>> put_sync/reset happening after configuration.
>>>>>
>>>>
>>>> Yes, this is the reason why the configuration was taking effect for you ,
>>>> Rafael, as the PWM was already enabled when setting the configuration hence
>>>> masking the effect of a put_sync/reset happening after configuration.
>>>
>>> Can you provide a list of commands that show the failure? That would
>>> result in less guessing for me. My plan is to reproduce the failure
>>> tomorrow to better understand it on my boneblack.
>>
>> Sure Uwe. These are the commands I have tried for PWM signal generation:
>>
>> cd /sys/class/pwm/pwmchip0
>> /sys/class/pwm/pwmchip0# echo 0 > export
>> /sys/class/pwm/pwmchip0# cd pwm0/
>> /sys/class/pwm/pwmchip0/pwm0# echo 10000000 > period
>> /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
>> /sys/class/pwm/pwmchip0/pwm0# echo "normal" > polarity
>> /sys/class/pwm/pwmchip0/pwm0# echo 1 > enable
>>
>> Once these commands were executed, I measured the PWM signal using logic
>> analyzer and the duty cycle was 100% even though we had set 30% duty cycle
>> through the sysfs nodes.
> 
> After that sequence I "see" a 30% relative duty cycle on my boneblack.
> (With the follwing patch applied on top of pwm/for-next:
> 
> diff --git a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts b/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
> index b4fdcf9c02b5..a3f4a4bb64e4 100644
> --- a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
> @@ -173,3 +173,25 @@ &gpio3 {
>   &baseboard_eeprom {
>   	vcc-supply = <&ldo4_reg>;
>   };
> +
> +&am33xx_pinmux {
> +	ehrpwm0_pins: ehrpwm0-pins {
> +		pinctrl-single,pins = <
> +			/* P9.21 UART2_TXD -> ehrpwm0B */
> +			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)
> +			/* P9.22 UART2_RXD -> ehrpwm0A */
> +			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_OUTPUT_PULLDOWN, MUX_MODE3)
> +		>;
> +	};
> +};
> +
> +&ehrpwm0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ehrpwm0_pins>;
> +
> +	status = "okay";
> +};
> +
> +&epwmss0 {
> +	status = "okay";
> +};
> 
> )
> 
> That makes me think the problem isn't understood well yet and needs more
> research. @Rafael, does the problem reproduce for you with Gokul's
> recipe? (Or did you try that already? I understood your reply as "I
> didn't encounter the issue but also didn't test specifically for that.")
> 
> As I cannot reproduce the issue, can you please check if adding
> 
> 	pm_runtime_get_sync(pwmchip_parent(chip));
> 
> to the probe function makes the problem disappear? Also please boot with
> 
> 	trace_event=pwm
> 
> on the command line and provide the content of
> /sys/kernel/debug/tracing/trace after reproducing the problem.
> 

PWM EVENT TRACING OUTPUT:
=========================
# tracer: nop
#
# entries-in-buffer/entries-written: 3/3   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
       gen_pwm.sh-1039    [000] .....    88.564669: pwm_apply: 
pwmchip0.1: period=100000000 duty_cycle=0 polarity=0 enabled=0 err=0
       gen_pwm.sh-1039    [000] .....    88.564728: pwm_apply: 
pwmchip0.1: period=100000000 duty_cycle=30000000 polarity=0 enabled=0 err=0
       gen_pwm.sh-1039    [000] .....    88.565065: pwm_apply: 
pwmchip0.1: period=100000000 duty_cycle=30000000 polarity=0 enabled=1 err=0

The trace output might mislead us thinking that the duty cycle is set 
properly as the event tracer reads the duty_cycle variable which gets 
set irrespective of whether the value gets reflected in the pwm 
registers or not.

The best way to check if the value is reflected is by dumping the 
registers.

On J784S4 EVM , I executed the script attached(gen_pwm.sh)and dumped the 
EPWM_CMPB Register(reflects the duty cycle) using the below command:

 >devmem2 0x03010014

Output:
0x00000000

The above output indicates that the duty cycle was not set as the 
register values are 0.

However, after executing the command(echo 40000000 > 
/sys/class/pwm/pwmchip0/pwm1/duty_cycle) after the above steps were 
done(ie: executing script and dumping registers), the duty cycle is 
reflected properly.

 >devmem2 0x03010014

Output :
0x000065B9

The LSB 2 bytes(65B9)(reflecting EPWM_CMPB register) , indicates 40% 
duty cycle set properly.

This is how I confirmed that there is a need to set the 
duty-cycle(different from the previous one) again, even after enabling 
the pwm.

I am also sharing the device tree 
changes(0001-Enable-EHRPWM-1_B-using-AC33-pin.patch file) made to enable 
ehrpwm1_B on J784S4 EVM.

Also, just ensure that SW2.2 is set high(1), so that the AC33 pin(used 
for EHRPWM1_B output) is routed to TP 126.

Additionally, I also measured the PWM signal using logic analyzer and 
was able to reproduce this issue.

Best Regards
Gokul Praveen

> Best regards
> Uwe

--------------j1r0xgOJm8I9pV7DD1h6kRvq
Content-Type: application/x-shellscript; name="gen_pwm.sh"
Content-Disposition: attachment; filename="gen_pwm.sh"
Content-Transfer-Encoding: base64
Content-Description: gen_pwm.sh

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiMhL2Jpbi9iYXNoCgpjZCAvc3lz
L2NsYXNzL3B3bS9wd21jaGlwMAplY2hvIDEgPiBleHBvcnQgI1dpbGwgZXhwb3J0IHB3bTEg
ZGV2aWNlCmNkIHB3bTEvCmVjaG8gMTAwMDAwMDAwID4gcGVyaW9kICNJbiBuYW5vc2Vjb25k
cwplY2hvIDMwMDAwMDAwID4gZHV0eV9jeWNsZSAjSW4gbmFub3NlY29uZHMKZWNobyAibm9y
bWFsIiA+IHBvbGFyaXR5CmVjaG8gMSA+IGVuYWJsZQoKCg==
--------------j1r0xgOJm8I9pV7DD1h6kRvq
Content-Type: text/x-patch; charset="UTF-8";
	name="0001-Enable-EHRPWM-1_B-using-AC33-pin.patch"
Content-Disposition: attachment;
	filename="0001-Enable-EHRPWM-1_B-using-AC33-pin.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Enable-EHRPWM-1_B-using-AC33-pin.patch

RnJvbSBkNGRhNjEwZjcxMDRmMjU0ZTdkYzVmOWQ3ZjZhYTFiMTEyZmRhMjg3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBHb2t1bCBQcmF2ZWVuIDxnLXByYXZlZW5AdGkuY29t
PgpEYXRlOiBUaHUsIDE1IEphbiAyMDI2IDE0OjUyOjU5ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gRW5hYmxlIEVIUlBXTSAxX0IgdXNpbmcgQUMzMyBwaW4gRW5hYmxlIFBXTSBFVkVOVCBU
UkFDSU5HCgotLS0KIC4uLi9ib290L2R0cy90aS9rMy1qNzg0czQtajc0MnMyLWNvbW1vbi5k
dHNpICAgfCAgMSArCiAuLi4vZHRzL3RpL2szLWo3ODRzNC1qNzQyczItZXZtLWNvbW1vbi5k
dHNpICAgIHwgMTggKysrKysrKysrKysrKysrKy0tCiBhcmNoL2FybTY0L2NvbmZpZ3MvZGVm
Y29uZmlnICAgICAgICAgICAgICAgICAgIHwgIDcgKysrKysrLQogMyBmaWxlcyBjaGFuZ2Vk
LCAyMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvdGkvazMtajc4NHM0LWo3NDJzMi1jb21tb24uZHRzaSBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvdGkvazMtajc4NHM0LWo3NDJzMi1jb21tb24uZHRzaQppbmRleCAx
ZGNlZmYxMTlhNDcuLmFmNDEwM2YxNTllMyAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy90aS9rMy1qNzg0czQtajc0MnMyLWNvbW1vbi5kdHNpCisrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvdGkvazMtajc4NHM0LWo3NDJzMi1jb21tb24uZHRzaQpAQCAtMTAzLDYgKzEw
Myw3IEBAIGNiYXNzX21haW46IGJ1c0AxMDAwMDAgewogCQkJIDwweDQ0IDB4MDAwMDAwMDAg
MHg0NCAweDAwMDAwMDAwIDB4MDAgMHgwODAwMDAwMD4sIC8qIFBDSWUyIERBVDAgKi8KIAkJ
CSA8MHg0NCAweDEwMDAwMDAwIDB4NDQgMHgxMDAwMDAwMCAweDAwIDB4MDgwMDAwMDA+LCAv
KiBQQ0llMyBEQVQwICovCiAJCQkgPDB4NGUgMHgyMDAwMDAwMCAweDRlIDB4MjAwMDAwMDAg
MHgwMCAweDAwMDgwMDAwPiwgLyogR1BVICovCisJCQkgPDB4MDAgMHgwMzAxMDAwMCAweDAw
IDB4MDMwMTAwMDAgMHgwMCAweDAwMDAwMTAwPiwgLypFSFJQV00xKi8KIAogCQkJIC8qIE1D
VVNTX1dLVVAgUmFuZ2UgKi8KIAkJCSA8MHgwMCAweDI4MzgwMDAwIDB4MDAgMHgyODM4MDAw
MCAweDAwIDB4MDM4ODAwMDA+LApkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy90
aS9rMy1qNzg0czQtajc0MnMyLWV2bS1jb21tb24uZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvdGkvazMtajc4NHM0LWo3NDJzMi1ldm0tY29tbW9uLmR0c2kKaW5kZXggZTUwNzM1NTc3
NzM3Li40YTYzZGRlYWEzNzIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkv
azMtajc4NHM0LWo3NDJzMi1ldm0tY29tbW9uLmR0c2kKKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy90aS9rMy1qNzg0czQtajc0MnMyLWV2bS1jb21tb24uZHRzaQpAQCAtMjk2LDYgKzI5
NiwxMyBAQCBKNzg0UzRfSU9QQUQoMHgwZTgsIFBJTl9JTlBVVCwgOCkgLyogKEFSMzgpIFRJ
TUVSX0lPMC5NTUMxX1NEQ0QgKi8KIAkJPjsKIAl9OwogCisJbWFpbl9laHJwd20xX3BpbnNf
ZGVmYXVsdDogbWFpbi1laHJwd20xLXBpbnMtZGVmYXVsdCB7CisJCWJvb3RwaC1hbGw7CisJ
CXBpbmN0cmwtc2luZ2xlLHBpbnMgPSA8CQkJCisJCQlKNzg0UzRfSU9QQUQoMHgwNzQsIFBJ
Tl9PVVRQVVQsIDkpIC8qIChBQzMzKSBFSFJQV00xX0IuR1BJTzBfMjkgKi8KKwkJPjsKKwl9
OworCiAJdmRkX3NkX2R2X3BpbnNfZGVmYXVsdDogdmRkLXNkLWR2LWRlZmF1bHQtcGlucyB7
CiAJCXBpbmN0cmwtc2luZ2xlLHBpbnMgPSA8CiAJCQlKNzg0UzRfSU9QQUQoMHgwMjAsIFBJ
Tl9JTlBVVCwgNykgLyogKEFKMzUpIE1DQU4xNV9SWC5HUElPMF84ICovCkBAIC02NjEsNiAr
NjY4LDEzIEBAICZtY3VfdWFydDAgewogCXBpbmN0cmwtMCA9IDwmbWN1X3VhcnQwX3BpbnNf
ZGVmYXVsdD47CiB9OwogCismbWFpbl9laHJwd20xIHsKKyAgICAgICAvKiBFSFJQV00xKi8K
KyAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOworICAgICAgIHBpbmN0cmwtMCA9
IDwmbWFpbl9laHJwd20xX3BpbnNfZGVmYXVsdD47CisgICAgICAgc3RhdHVzID0gIm9rYXki
OworfTsKKwogJm1haW5fdWFydDggewogCWJvb3RwaC1hbGw7CiAJc3RhdHVzID0gIm9rYXki
OwpAQCAtODUyLDcgKzg2Niw3IEBAIHAxNS1ob2cgewogCQkJLyogUDE1IC0gQ0FOVUFSVF9N
VVgxX1NFTDEgKi8KIAkJCWdwaW8taG9nOwogCQkJZ3Bpb3MgPSA8MTUgR1BJT19BQ1RJVkVf
SElHSD47Ci0JCQlvdXRwdXQtaGlnaDsKKwkJCW91dHB1dC1sb3c7CiAJCQlsaW5lLW5hbWUg
PSAiQ0FOVUFSVF9NVVgxX1NFTDEiOwogCQl9OwogCX07CkBAIC04ODgsNyArOTAyLDcgQEAg
Jm1haW5fc2RoY2kwIHsKICZtYWluX3NkaGNpMSB7CiAJYm9vdHBoLWFsbDsKIAkvKiBTRCBj
YXJkICovCi0Jc3RhdHVzID0gIm9rYXkiOworCXN0YXR1cyA9ICJkaXNhYmxlZCI7CiAJcGlu
Y3RybC0wID0gPCZtYWluX21tYzFfcGluc19kZWZhdWx0PjsKIAlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOwogCWRpc2FibGUtd3A7CmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2NvbmZp
Z3MvZGVmY29uZmlnIGIvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZwppbmRleCA0NTI4
OGVjOWVhZjcuLmQwOGQ5MzQ2ZTg0OCAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9jb25maWdz
L2RlZmNvbmZpZworKysgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnCkBAIC0xNjQz
LDcgKzE2NDMsNyBAQCBDT05GSUdfUFdNX1NUTTMyPW0KIENPTkZJR19QV01fU1VONEk9bQog
Q09ORklHX1BXTV9URUdSQT1tCiBDT05GSUdfUFdNX1RJRUNBUD1tCi1DT05GSUdfUFdNX1RJ
RUhSUFdNPW0KK0NPTkZJR19QV01fVElFSFJQV009eQogQ09ORklHX1BXTV9WSVNDT05UST1t
CiBDT05GSUdfU0wyOENQTERfSU5UQz15CiBDT05GSUdfUUNPTV9QREM9eQpAQCAtMTg1OSw2
ICsxODU5LDEwIEBAIENPTkZJR19ERUJVR19GUz15CiAjIENPTkZJR19TQ0hFRF9ERUJVRyBp
cyBub3Qgc2V0CiAjIENPTkZJR19ERUJVR19QUkVFTVBUIGlzIG5vdCBzZXQKICMgQ09ORklH
X0ZUUkFDRSBpcyBub3Qgc2V0CitDT05GSUdfRlRSQUNFPXkKK0NPTkZJR19UUkFDSU5HPXkK
K0NPTkZJR19FVkVOVF9UUkFDSU5HPXkKK0NPTkZJR19UUkFDSU5HX1NVUFBPUlQ9eQogQ09O
RklHX0NPUkVTSUdIVD1tCiBDT05GSUdfQ09SRVNJR0hUX0xJTktfQU5EX1NJTktfVE1DPW0K
IENPTkZJR19DT1JFU0lHSFRfQ0FUVT1tCkBAIC0xODY4LDMgKzE4NzIsNCBAQCBDT05GSUdf
Q09SRVNJR0hUX1NUTT1tCiBDT05GSUdfQ09SRVNJR0hUX0NQVV9ERUJVRz1tCiBDT05GSUdf
Q09SRVNJR0hUX0NUST1tCiBDT05GSUdfTUVNVEVTVD15CisKLS0gCjIuMzQuMQoK

--------------j1r0xgOJm8I9pV7DD1h6kRvq--

