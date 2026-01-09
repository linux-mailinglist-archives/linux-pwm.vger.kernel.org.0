Return-Path: <linux-pwm+bounces-7885-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C8CD0744F
	for <lists+linux-pwm@lfdr.de>; Fri, 09 Jan 2026 06:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9A72300D923
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Jan 2026 05:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EEF2773FF;
	Fri,  9 Jan 2026 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d6eJWgPu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazhn15012040.outbound.protection.outlook.com [52.102.146.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63C1DDC1D;
	Fri,  9 Jan 2026 05:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.146.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767937920; cv=fail; b=tk8pBRlfCfo2X8JmNqtLaOcTVo83P51fb/8sEujJzxBXQ54VOPbDAKLv00vVJj/lva1IcKjLI1jS+kKzSxPaAKJuAtPlloUgUXLKEYfWHS/wlBQ2u7tykTvQ3/Ulu30Nej1HJCTIzAn5cSp9QJf+JRICi7mYR7BttRI7SrzA7po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767937920; c=relaxed/simple;
	bh=xalRGkDMxTynx23CFsW08PPs7XylmPzG3UxXawGVOa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ve9D1vZ5qBJbbKVfjrJN8ooKMnDup/B3ijXNJ4zNwpYLAPzhoSu7mlf2nQ9JyS2ztnfNRxldoPUgegMT7/pABIrKpCck4GKsEt6pMwcBQ/cD8TZELHrZ8T6FEEqPvsmoMERcaToPwdxE8JqzxmHekzKqgNMh8aEStAMlXasowbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d6eJWgPu; arc=fail smtp.client-ip=52.102.146.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe886M8w0xCfpq2h62POhWXAEBuONgrEqqsBgvOclSKurM/KFfDBhA8YqG03ioNIxbfIabGnTPijazY2mLXz5w0sJydqvb0ubNX5BMUs9KuzOBIeoBDj3II3GSDIUdkuUVJ07kEjOqVRcZUohYa8PB4U8dxOPrgwgANpmwtoJTPsZ0oSbZA/vW1taC7QaRfvU6P7x9T+otUQ3+BsaEGfmZUW2nIFImhhWFLqMhmOc6LilBWA2JOLu7d3ItNJsFzRfnruBkNAc3Qv/PhqHQA6OJab8slT7OaTJkavCmSxKP9UPKf92wg4HkI28fT7ExHctwcGTFAef2hIp+EoUHtc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RS1clRSUH1/xGkwXrd24tRCoG+NxCbWGsHDMj41XwA=;
 b=ilLMIWsd56M8a+agBnJcvidw1jAIoDzpPTxJ2U/bbNswn94KDOMSe1wRKMtRmkwFOSPaPJENahdteAe1Q9tC0g+oCy/vtu+V8ggLJqsn5be33vxuGDOJpwaFZ9lGW2f+we/5x8zkhZtAsNv5IQ5PNmnAc4x/JyE49MauFdoqdIN4H5sj4IjhCEv+RCCK1sj6tocEi15Hd5iVe9NM38M+tgsoW3pGm+WTWgJjG2XxJVcu8uexnpnQ+LRVEUz7GOYiFs6euSoK7Dwdf8cZLRPFBw97twcO5fDAJVRZgjXOxnTsqf2W6TMEB+PN4/RFZJJ7gsK+fKztKmxATJk9rI4TtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RS1clRSUH1/xGkwXrd24tRCoG+NxCbWGsHDMj41XwA=;
 b=d6eJWgPuhtRSGstPTliGK5q+l2LPyPaNZajzlm7dGR047mnIhfpiRUXhSC1ecfshAbQJZNf1luH4RwKxWHwXklQNT2vUwECcBFAVUiux8VBmVrn4Zh8WSoykG0digRQ8kg4Wjrs76KLVopDwgDORey5WHSNlK6sk/KIy65TdOPQ=
Received: from BY5PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:1e0::29)
 by IA3PR10MB8515.namprd10.prod.outlook.com (2603:10b6:208:572::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Fri, 9 Jan
 2026 05:51:56 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::a2) by BY5PR03CA0019.outlook.office365.com
 (2603:10b6:a03:1e0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 05:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 05:51:53 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 23:51:50 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 23:51:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 23:51:50 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6095plFa3598050;
	Thu, 8 Jan 2026 23:51:47 -0600
Message-ID: <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
Date: Fri, 9 Jan 2026 11:21:46 +0530
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
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|IA3PR10MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: fc07694d-425f-4ebb-924d-08de4f433102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|376014|1800799024|82310400026|36860700013|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWRtN1R5ZkJoSWRxZU1tUlpjaHpqeUNvVVdVM3ErL3VGdXgwamgxeGY3Z05E?=
 =?utf-8?B?SHFTTlIzTldqR0hteUlhbUZHRHFzRk1KVEZadHBkZWQzcmE1MDRLN2tRSXQv?=
 =?utf-8?B?V1hQcDBiUDZ4eEYwNDM2VzhocDdJdHJab2FIUGRVRnVuN3o5QXFsRk1Od1R0?=
 =?utf-8?B?Um1SUnRLMWZKTE9TS2hRUlA2VEFVZ3ZqK0RiQlp1V2U3NTdyNVBETFc5YnNn?=
 =?utf-8?B?YndSZ29wNmRGMnNYTFJESVdvdjhGaHZDWVYwNUNWdE10cHU3SnlxY1pIQzR6?=
 =?utf-8?B?b2pDbUdRTEF3WHpBZlAyV1c0anRCMzF5bWNMWEFtWks5NWtvT3ExdjI4UDJs?=
 =?utf-8?B?UGxDUmRXMmh1U1hlMHdMdnZpTFpoS08ra3YvYXJMQ01qZWtDMWV5cWcrWTc2?=
 =?utf-8?B?L3ZkQVI4MlhUa3F5NXpkcVdhSjFMak5OUjBuc3Q5OFJXN3MxQVBXaXloT1di?=
 =?utf-8?B?clNpQjlkT2Q4alRLYU1tbXROVE5uSGFrOEx3ZjdoK3RacGFsTlpkZVBXK09v?=
 =?utf-8?B?NEdGMjdxbW9LSmZ2QXJGclF1VnJJREVVOUtlNVR1WCtwSlFFdFN6THluWjdH?=
 =?utf-8?B?UXAxL0pKbFluOEY2aExjQXZLOGJic2NRYUVqKzhUUktSOEZESDR4UFRQdHE4?=
 =?utf-8?B?bjF0WW1nMmROaVIwK3FJdit5Tlh3Z3pta25PR2RkL25zWTE3QVVnOGtpbHBB?=
 =?utf-8?B?ZkxtV3IwNjJkellKZmVzRm5LSllwNjFnUVhINXd2Q0d3TmJlVmZUWVBCQ0Q5?=
 =?utf-8?B?R1F6bDhjaFVuR0FLdWE3QTRjc2wySnBiQlExaDMvY3pxbVRXL0h4d1RYTE9R?=
 =?utf-8?B?MHVpUFFLdjgwZWZqSHhtSDl4eGJnVTNFNkdyamVpYWxOckptTnRtU1Jobmxp?=
 =?utf-8?B?SHFqNVh5TWQ2UXdmVzY5QTBJWnJVdzlzSlplRVllb04ra3pBZXJHckpodFVp?=
 =?utf-8?B?OTRuYmZWVFJxdGVTcXdBVTQzNkV2R1RtOUxtemJVTE1IcmpRZVYwZGljdjlz?=
 =?utf-8?B?NUZuQkVucUR4STYwTStPZVlWRW10REFrMDFhM3o4MmFidDd0WXNqTWV5cVBC?=
 =?utf-8?B?Rm9zKzdrSVdRVjFPUFZ4VXlXNVNTMnoyODNaKys5b0RFVmkvWGswTlZHMWhR?=
 =?utf-8?B?TzdjV1VhTGpuQ2Y4TU9xblNEUFZiZW51NUh4TVdUNXBpSjV1ZCtNaEhobjdQ?=
 =?utf-8?B?cDhJQzIvQStCb21xak12S1lUa1pCVHZsWGpvWEhPNkxjYkY0M1EwYjlsMitV?=
 =?utf-8?B?RUJhYW9DUnJkL1JMd2FuajUwSzQ5YlkxUXA2b2owYnZrWVU1VHdHSlhlaXpU?=
 =?utf-8?B?Sk4xTVVKWTBoMlcwd2NSQ2RoVHkweE5sbUdCV1d2U0lrWnVzNnB3STFJL1Jn?=
 =?utf-8?B?ZklrMWoxL0YzQzFObDU4MVhlc2ZIdW8vQkZrNHZpaXB5TWV2ZFlXRVlrNiti?=
 =?utf-8?B?R00yeU1iY1BRSTEwVS9pSVRLeDFGMlc5RjdQR1RxS0FWcE5ISnpkMS9ucVNh?=
 =?utf-8?B?Y0N3WXJSTy85a3FrdzdPUHBINVNuR3VNZldFTU1rV3UvR0FUc2V5OWpZOEVr?=
 =?utf-8?B?Z2NYdVIzSFRHZ3JOQkJRSjlDTkFGbVVna2xOdWhmdldqTWQ0aVFnZ1NRM1FV?=
 =?utf-8?B?MVkxQnhUaXdwVk5CNFpjNlpwNlRoOGZyRU5xVURSRzlIV1U3NTFkY1pCc0Yx?=
 =?utf-8?B?d3BkK2xYK2RpRzNMZGora0ZWaWJibGRWNkZScHlndjJXOGxuQ2FkdWQvL0U0?=
 =?utf-8?B?dnA4UG9Kd1VHWnZ5bjJYVGJkTlNvVXl1Z0F1NzNDQm1DcVkrY3lqWDZSTXI4?=
 =?utf-8?B?bjBFWHI2cHludUV4NU5BRVArdnhuRlpieS9aeUs0bkgxa09DVUZGYXVJS3lj?=
 =?utf-8?B?QUF1cW9oUGw1MUwvS3dZQnFsTm0ycDRHT2ZmbGRUNk9qTlVvYWZRckNtQ25L?=
 =?utf-8?B?eHlJeXQrSHdqZUVsdzEzWURTeU0zM0kveDRmQ1JPQnFRZFp4Q0Q4bkFBcTJy?=
 =?utf-8?B?V3NJYXg3V0ZmejNaNzk2MVRWSHc3UkhDZy9DTDYvVlRRanYvaW1USStyVll1?=
 =?utf-8?B?VW9ubkk4dUNFcC8rSHowTExEbmpqbkc0OEN1NzI3MmN5cmhEbFFwbml4djhz?=
 =?utf-8?Q?tVOE=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(34020700016)(376014)(1800799024)(82310400026)(36860700013)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 05:51:53.5454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc07694d-425f-4ebb-924d-08de4f433102
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8515

Hi Uwe,


On 08/01/26 23:40, Uwe Kleine-König wrote:
> Hello Gokul,
> 
> On Thu, Jan 08, 2026 at 12:10:35PM +0530, Gokul Praveen wrote:
>> On 08/01/26 01:17, Rafael V. Volkmer wrote:
>>> Thanks for CC'ing me on this thread.
>>>
>>> On 07/01/26 15:21, Uwe Kleine-König wrote:
>>>> adding Rafael to Cc: who sent a patch series for this driver that I
>>>> didn't come around to review yet. Given that neither he nor me noticed
>>>> the problem addressed in this patch I wonder if it applies to all
>>>> hardware variants.
>>>>
>>>
>>> I also didn't observe the issue described here in my testing: duty cycle and
>>> period changes always appeared to take effect as expected.
>>>
>>> My tests were done on an AM623 EVM.
>>>
>>> One possible explanation is that my test flow mostly exercised configuration
>>> while the PWM was already enabled/active, which could mask the effect of a
>>> put_sync/reset happening after configuration.
>>>
>>
>> Yes, this is the reason why the configuration was taking effect for you ,
>> Rafael, as the PWM was already enabled when setting the configuration hence
>> masking the effect of a put_sync/reset happening after configuration.
> 
> Can you provide a list of commands that show the failure? That would
> result in less guessing for me. My plan is to reproduce the failure
> tomorrow to better understand it on my boneblack.
> 
> Best regards
> Uwe

Sure Uwe. These are the commands I have tried for PWM signal generation:

cd /sys/class/pwm/pwmchip0
/sys/class/pwm/pwmchip0# echo 0 > export
/sys/class/pwm/pwmchip0# cd pwm0/
/sys/class/pwm/pwmchip0/pwm0# echo 10000000 > period
/sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
/sys/class/pwm/pwmchip0/pwm0# echo "normal" > polarity
/sys/class/pwm/pwmchip0/pwm0# echo 1 > enable

Once these commands were executed, I measured the PWM signal using logic 
analyzer and the duty cycle was 100% even though we had set 30% duty 
cycle through the sysfs nodes.

However, with the below command sequence, the duty cycle was getting set 
properly

cd /sys/class/pwm/pwmchip0
/sys/class/pwm/pwmchip0# echo 0 > export
/sys/class/pwm/pwmchip0# cd pwm0/
/sys/class/pwm/pwmchip0/pwm0# echo 10000000 > period
/sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
/sys/class/pwm/pwmchip0/pwm0# echo "normal" > polarity
/sys/class/pwm/pwmchip0/pwm0# echo 1 > enable
/sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle


PWM is working only if we re-update the duty cycle after enabling the 
module.

If we do not re-update the duty cycle after enabling the module then PWM 
signal line is being high(100 % duty) always.

Test Environment: TI J784S4 EVM board.

Best Regards
Gokul Praveen




