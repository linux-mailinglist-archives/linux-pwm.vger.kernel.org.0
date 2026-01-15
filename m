Return-Path: <linux-pwm+bounces-7903-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4448D22847
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 07:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA0313000776
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 06:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95D2BE7DC;
	Thu, 15 Jan 2026 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bgmbHm20"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazhn15013044.outbound.protection.outlook.com [52.102.146.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188C2C327D;
	Thu, 15 Jan 2026 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.146.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457696; cv=fail; b=e4/vxIcJ9+NsUO/VWssz0sfwbDjf9foBM9Lk0AfBspfHKqXWDXXj197xSn0qqki5+pT4XVcSP+Qn4rwkigeVEBGiT25a9HIuxT+4YwlATGVhEweJLarxzqs1bfVE44s/I2xY7Sutz2NU6oki4mHymsHsKeDFWwvbDJbGu0q7+yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457696; c=relaxed/simple;
	bh=SIAK1hmiRBVY8bQ8BbwmmmPpt2jFN9Phig1QTN7MtrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lBFXpn27Fvs+vckAA9GOEZyCE4irKpePjpyaVRjk2Dp2zy26zQuitQVfN+dbEInlVaPz+2qiCS21sdh/kAogj3ZmcsKQl3twc198dwCimYeem5RQ8vwHn0j2v05BBfdWaIUbQZtuEb8LzuMbghW8+8zhIZ5TB33C5m+WC2faLQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bgmbHm20; arc=fail smtp.client-ip=52.102.146.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II3Be3MnbFR3wKRUahNDQDbBAyFFCeY+kwaROavBdQpuZeBXcYd8UaSO9N8D6IWDYRNqaUt+rIrISmKAbuWWz4cIbnSdF8CayVM7gskdFqslnmYgf03zU2GnyZYUUpf+lLeYNyn/QQzmN7z43NIaV9aMHQvwIeuvpq2oUAYivUhFgTpMYaZL8XBRBURxRnChWhPp2pFtwY+M8pe39XQ1HP3/aJY523KIoBYwNvXj+wRoC9eWKxwPuVV3QFFX57XjQUX0GneaQTi1CB1aADnpRAiyKkq8wFs0pYn1GZdTFJZIASDD09/I3Ph2faSqNV4skSIpSBF1kXkgZ7fi1DlrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1DpVdmLL9nktYZaquylmH2QmDOmpFqJfEzM2FudvA8=;
 b=w3bOtfZ5Sgs3a16hKLTlFHYv3gs7Tcx/2fhmdoXxb1+GaaLzsXgAy0CJuw/mrzjzFb8qfzR4BM14fn0SDBDMsOaQa6WBcPsOb6/5DJfybL6Cd/dHh1vWpuDqm0f9JCUowW8/k7yjePE3hb1qQjJZ47FCqTqklTbQMyHehNxxA9p+gDdWxJ7z6lw1vlpd4sz5DLZBMAR9a/wQxCVrpgDlQi7qYVrj9Mmq+FP2lQ6lH216FelD16WsZYaEdbr29B5QJ18zvvTs1XBc5txMcVh6LqkV3n4yPU+xDOYF+vFMXm/ANd0GBqGj0A5gFF93aaZglCSqYm46kbrVn3hYtD2Y2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1DpVdmLL9nktYZaquylmH2QmDOmpFqJfEzM2FudvA8=;
 b=bgmbHm204ueDfnlx+L37YHoYBpIJLYZQlYEirRNiPBv7020Jul3QOLmapDeP/zhbDJCkE48NgMJac98lQIq4rcZIEDUrOREQz0YF/CAmCEIbwgvRmQTLQH/C24Rw7yGbjYAEcreetdaDPkofSZrxo5QeSTagSDBc1NTBr5QgTrs=
Received: from BY5PR20CA0035.namprd20.prod.outlook.com (2603:10b6:a03:1f4::48)
 by CY8PR10MB7290.namprd10.prod.outlook.com (2603:10b6:930:7b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 06:14:52 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::76) by BY5PR20CA0035.outlook.office365.com
 (2603:10b6:a03:1f4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 06:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 06:14:52 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 00:14:51 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 00:14:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 00:14:51 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60F6EmP1959177;
	Thu, 15 Jan 2026 00:14:48 -0600
Message-ID: <3527b094-5b39-473a-afc1-cfca7baeb3d1@ti.com>
Date: Thu, 15 Jan 2026 11:44:47 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before setting
 configuration
To: "Kumar, Udit" <u-kumar1@ti.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, <j-keerthy@ti.com>,
	<linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<n-francis@ti.com>, Gokul Praveen <g-praveen@ti.com>
References: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
 <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
 <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
 <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
 <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
 <85d941a6-9c57-45f3-ab6a-33ca91cf05a5@ti.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <85d941a6-9c57-45f3-ab6a-33ca91cf05a5@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CY8PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 54faffda-e991-4d53-0ad9-08de53fd6547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|34020700016|82310400026|376014|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWF1Y09nZmJaZFhZV3hrdkxTaktjZytjSW9pMkowWXRBMnp3T1NKdkYxVFRh?=
 =?utf-8?B?VFdMOExOTEQzMUcxdWNOZTg5Vm5WUUp1Vk1iSTcxSkNjR3phQW15SGNPODBH?=
 =?utf-8?B?QjZRdXIyY0pXK2VGcFZ6aFZOZERQcUpZVkQ2TER6QnE2SVZjcVJtQ3JmMTRr?=
 =?utf-8?B?SzRmVHJFYVp1cy9PKzM1ZGw0QU8rTDhrK3k4dXhuMzdvaEd1eFdCZG9YSUxC?=
 =?utf-8?B?OWhXRUk1dXg5QzBQNW0wZFMrUS8vZEpaRVVGVmtxUEVQL250MldBM3pDVUth?=
 =?utf-8?B?QitMYW8yS0hzZkVFWkQ4OHNic2lGR0VQQU0xOGRHQzJLVjB4OW5Mb3V1bjhr?=
 =?utf-8?B?ekJKWlJYSTJLTmx4UzVSWHFqTktsOTlnRFcvbEJFTW1HMmJWelBidWltRjBw?=
 =?utf-8?B?R2xuYVlCaW9GSndiWWVscHN2ZUxURHhqLzZSV1VEV3VTZzQvZmtsSTlYSzhH?=
 =?utf-8?B?cWgxenlFTktTVzVBWlVqdXd3eGVpa2laQUJ3MlA0Tk1LdVdEaGVPRFErbGRD?=
 =?utf-8?B?T3B6akFEaUxNb093QmFsUW9acytIekozanVUR2twZitBb3dQR01KTnk4dlZo?=
 =?utf-8?B?eGVBT3pZbXZMVExmYWZjc0oyZkVncEw1MnplaUgrZE1vZmJhaDdmUzBJaDVv?=
 =?utf-8?B?QmtSN083bEdMYnJsSlBwTm9wcFQ1em1BUXZYelM5RHo4dnVQeUZ5cGlXTktz?=
 =?utf-8?B?SnhDRHh1L3g4UHhaaEoxaHlZVDlSeThPUU5KL2gxMSsxUmtHOTUwNklYSUJs?=
 =?utf-8?B?WGtmalZOaDNRVmZjNFdWcWpmazRJL2dpczFZQitkajgraGl5MWIzVG1RUUN6?=
 =?utf-8?B?c0Z0VWpYc1htWTFMUWhLakxZR21oTlVpd0VSOUw3SlF1Q2hDVWxqc0pEeGxK?=
 =?utf-8?B?YWxOODdZLzZsZXpFWnRlZlBWU0ZFL2dwVkNpY1p5aW40NlJCbW80Q3dKQklX?=
 =?utf-8?B?RDBKbFFmanU5R2dzWjQzbWZxSk56V2VLZ2pMemlIQlFzaDRaZjlFVVhLcFRn?=
 =?utf-8?B?NEZkTXpONEVJUWoxdzBkTU5haDJ1SlBKNVV3NmtTbk9sVll4akV1YzYyRnYx?=
 =?utf-8?B?T0haeTh6TGs3T05EQ3dvUVEzaCtxQ0M2eXJIMjM2RFV6NTZ1a3ZyWTdtTTBF?=
 =?utf-8?B?UnA5ZzVGMUxkdkV4c285UmNTYUhGUjB4NG5RcVNFNVRWbVA4ZkRuZ0l6YWJJ?=
 =?utf-8?B?a3I3MzdWRjN5d1NvREhnUmdLYThZaHZieGVjSmVrdDRxSlRYU2dESzVXMHZh?=
 =?utf-8?B?WnRHOWVka2ZWKy9YaGVqeityVWV2bkhrbEQ2Sy9WckZxTTlONzRYbUlERkR5?=
 =?utf-8?B?QnRDakNpLzV0U25pUGZWM2YwcEh0QmlLVFcyaHkxTHRqeDJvazNUS1pSRUF3?=
 =?utf-8?B?TXhWNlpLUU9Pd29Sa292dzlhbkFFQkdROFFPam1jSHlhN3FNN2hYYUdiVTVL?=
 =?utf-8?B?UmNFUlRSczhpeVIwQ20vckRXMjJpcFNPL0dRZUc4b2J4aERHbCtsUVVlNkhE?=
 =?utf-8?B?SWZESDI1dHlXZHdyVG9BT1JFNXprVGdoS0p5WE9MNDRyOGw5cXYrMUpFa1RB?=
 =?utf-8?B?USt0NEM2Sld6bnZleWZqUVFDa1k3UForOER0bG1UVXJudm5CT2I0dHo2YWJy?=
 =?utf-8?B?NGhXbXhoVkZ2VGs3aVJPYkxqYXVISlF3ZEovem9CK1ZpWGVJbVlSRFAxUWxq?=
 =?utf-8?B?V2c5WTRPYk9tOTZrQkE0RFRvcEhQNVI2UjlpN3hRU1FCUjJRcG1zNVpEQ0Yr?=
 =?utf-8?B?dXZBY2RneEI0Z3BtTEhFU0QvMXpIOVNYYzZ6ellBT1NRVm9Oc09adGZWNElk?=
 =?utf-8?B?SURHVEVPd3FlcVFjZStpRzdaRHFrVGMxOVlUWmsxRitoZC9NcVpqYnc3aTZi?=
 =?utf-8?B?SEsvdjdZSjBabVdtN2k1dnZYK1hkUnZ2RlNEUTBCaDRNVXNTeGh2eVFsY3Fk?=
 =?utf-8?B?bTlVMUEydC8xM00wQzFnbHVaQ1Z6L1pCVlhGc05PdlQzc0pyQmNiRlRicGEz?=
 =?utf-8?B?OFUxNnNBWHZSaEJrSWgwa3YvbHRUMG5zZ3JMWTgrK0lhQ0lZemJlbXdvY1Bn?=
 =?utf-8?B?OGM0UDc0ZmhOS01ObXNxQ3hQN1lLWWhuT2gvcTdlL1RqRXVkaDYwUER0T1k1?=
 =?utf-8?B?Zkh4UTlBeDdCLzV6UEM4QmwzUXBWU3Vwd1QzSk1uWnJrQVNtek5lSmJIaHRj?=
 =?utf-8?B?Y1hkd21IYVBvS1EzaklXRUQyM3RNTlAwdFNzeUlPY2d5dHB2STExSTdQZzdU?=
 =?utf-8?B?MzVRbUptRTBCYUZGVWhlL29TcFVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(34020700016)(82310400026)(376014)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:14:52.2816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54faffda-e991-4d53-0ad9-08de53fd6547
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7290

Hi Udit,

On 15/01/26 10:50, Kumar, Udit wrote:
> Hello Gokul,
> 
> On 1/9/2026 11:21 AM, Gokul Praveen wrote:
>> Hi Uwe,
>>
>>
>> On 08/01/26 23:40, Uwe Kleine-König wrote:
>>> Hello Gokul,
>>>
>>> On Thu, Jan 08, 2026 at 12:10:35PM +0530, Gokul Praveen wrote:
>>>> On 08/01/26 01:17, Rafael V. Volkmer wrote:
>>>>> Thanks for CC'ing me on this thread.
>>>>>
>>>>> On 07/01/26 15:21, Uwe Kleine-König wrote:
>>>>>> adding Rafael to Cc: who sent a patch series for this driver that I
>>>>>> didn't come around to review yet. Given that neither he nor me 
>>>>>> noticed
>>>>>> the problem addressed in this patch I wonder if it applies to all
>>>>>> hardware variants.
>>>>>>
>>>>>
>>>>> I also didn't observe the issue described here in my testing: duty 
>>>>> cycle and
>>>>> period changes always appeared to take effect as expected.
>>>>>
>>>>> My tests were done on an AM623 EVM.
>>>>>
>>>>> One possible explanation is that my test flow mostly exercised 
>>>>> configuration
>>>>> while the PWM was already enabled/active, which could mask the 
>>>>> effect of a
>>>>> put_sync/reset happening after configuration.
>>>>>
>>>>
>>>> Yes, this is the reason why the configuration was taking effect for 
>>>> you ,
>>>> Rafael, as the PWM was already enabled when setting the 
>>>> configuration hence
>>>> masking the effect of a put_sync/reset happening after configuration.
>>>
>>> Can you provide a list of commands that show the failure? That would
>>> result in less guessing for me. My plan is to reproduce the failure
>>> tomorrow to better understand it on my boneblack.
>>>
>>> Best regards
>>> Uwe
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
>> Once these commands were executed, I measured the PWM signal using 
>> logic analyzer and the duty cycle was 100% even though we had set 30% 
>> duty cycle through the sysfs nodes.
>>
>> However, with the below command sequence, the duty cycle was getting 
>> set properly
>>
>> cd /sys/class/pwm/pwmchip0
>> /sys/class/pwm/pwmchip0# echo 0 > export
>> /sys/class/pwm/pwmchip0# cd pwm0/
>> /sys/class/pwm/pwmchip0/pwm0# echo 10000000 > period
>> /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
>> /sys/class/pwm/pwmchip0/pwm0# echo "normal" > polarity
>> /sys/class/pwm/pwmchip0/pwm0# echo 1 > enable
>> /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
> 
> 
> I don't think , this last call of setting duty_cycle , even will land in 
> driver code .
> 
> 
> 

Can you change the last command to the following. Ideally , it should be 
a different duty cycle set to enter into the driver code.

 >> /sys/class/pwm/pwmchip0/pwm0# echo 6000000 > duty_cycle

Best Regards
Gokul Praveen
>>
>>
>> PWM is working only if we re-update the duty cycle after enabling the 
>> module.
>>
>> If we do not re-update the duty cycle after enabling the module then 
>> PWM signal line is being high(100 % duty) always.
>>
>> Test Environment: TI J784S4 EVM board.
>>
>> Best Regards
>> Gokul Praveen
>>
>>
>>


