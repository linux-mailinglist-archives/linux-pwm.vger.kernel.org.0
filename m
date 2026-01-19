Return-Path: <linux-pwm+bounces-7920-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70142D39EFA
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 07:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 885513010BD2
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 06:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25A2286416;
	Mon, 19 Jan 2026 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FQS9uwlk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118328152A;
	Mon, 19 Jan 2026 06:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768805374; cv=fail; b=ShQDox2Y9kNqXjN/2PcsKuOSEO8D4pOAAUpRmXWR4z7SAhMfKbAQI7hRONNTRYA0UlrQ8hLPkDiSX+ovcCWJC+mzchONwmB4k5EiAws8PvFTnmrQrtQsl6lEGAc457YWn26bvurjF5JSIDVS/LUkTtr0L+73ndWJBCRZl1N5tmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768805374; c=relaxed/simple;
	bh=PsMrV4gnZaBfi0YE1rofUpMOfJ9S+sVibBtbjo5qC2c=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=R4I0doJdSe8bwzJH/PRxi4vdM2DPnhw2zBMmeBg4aLOWzkZBajDzccUHC6JgKXgb5JhUapQnhi5rPG5EY/Wh2bC0MdKMozceRrYIPcQ9vsKK4gE1IeD7EH4mqJgPz0VOV/4hx1v2wAWYc6qzhwrczF0eYg4bY65Eblv5t99xTLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FQS9uwlk; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaQBknxcveFHZY/aj7BP0dAe9hU9F8SJqYfC0AH7vqi2Yi0ZtYfmMKIdkJmI/LZDW/iCrT8n83LKTTgEZSMnd6OvHLWwUMtCg1VMy6arBPwc6ijHNTOxN1OgOn7DW0XcCbcsOgNsBc1qhJSM1EWircUWJbcB8HSrq6SB/tqnMy8QVMgMoCO9dmgyPM5xd4u9I8gAyxQcJkFTTIBe/w0H58BHUsvY7recXwQPzlEaE3d2DZ0M22VlTJDUX4TSCXNja9ItPppjnr4z68I5l+KdMhUKuXKipkOuXye/sGP4AXt8FvM9C4vYK+7s1cEbPmNDuhH6T4LYzCLksG1m+mjV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcC+GCAsCEG1zj1RoGJHZE8bx0J3f3s4A7YWfGQXYO0=;
 b=cHvfxDGjk2lYCfSJ8/F1my6+PV17c8SCTIfewhm7brHQn4YqKpUtOs2efDHeFtXXP7oJ/BHRr55RW+gw5fy0BYp1yDEV8rXHu8a5GmH1nuBkcwsJwn/ubNkS1KeTtdk7bZ5+7tK/jYpgeuPSIToBGOJSTXqJ/sdOY9wvSwRVeHLAGVj3cV8bUopatzAzihUEssNpjLBrS59UQIf1vYaog/kRrZ538pJwezBvg8lJ/kmj21LBVPSmhJRuJVB3S2tj6beFeTl1tmcFQOsZVQDDfXxAFd855BVceOm79GvxaCFJz/KouDiZN1C0CaMYGxcvjZkuInzSrQAlOQ+3NCE6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcC+GCAsCEG1zj1RoGJHZE8bx0J3f3s4A7YWfGQXYO0=;
 b=FQS9uwlkpUTqbnTcwgF/lMAGNECCtW6SU/9hWDqlxpfZp1tB3lfHjXVjcieOKWbj7yvPCXiwhxffxq30Jb7WGOaFcSM/CWa5IObSZGBKwcuPn5E5FJUs3kLkSLxa4BwfaG1fxz+DVHaabDoOVNtfi/fLo7xyz1jihu29ugIluFk=
Received: from CH0PR03CA0185.namprd03.prod.outlook.com (2603:10b6:610:e4::10)
 by SN7PR10MB6332.namprd10.prod.outlook.com (2603:10b6:806:270::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 06:48:57 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::26) by CH0PR03CA0185.outlook.office365.com
 (2603:10b6:610:e4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 06:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 06:48:55 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 00:48:32 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 00:48:32 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 00:48:32 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60J6mRxM3093269;
	Mon, 19 Jan 2026 00:48:29 -0600
Content-Type: multipart/mixed;
	boundary="------------aWRpLptIbYbqMErw5zKcjQnj"
Message-ID: <4a52e857-e6b2-4526-952c-0de6679a48e3@ti.com>
Date: Mon, 19 Jan 2026 12:18:26 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before setting
 configuration
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, <ukleinek@kernel.org>
CC: <j-keerthy@ti.com>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <n-francis@ti.com>, <u-kumar1@ti.com>, "Gokul
 Praveen" <g-praveen@ti.com>
References: <xdj2ceubkss3ingkxdvc64zqrcd3wzz2uxa6wqwgvilu2ykukc@hbn6tt2gnxj5>
 <20260119025521.26212-1-rafael.v.volkmer@gmail.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20260119025521.26212-1-rafael.v.volkmer@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SN7PR10MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c283b55-c991-480e-f3a1-08de5726d0fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE9lbGxocjFTWERaYTZrc1R0M2FsK2RuRkJvRzZQeUNJUzRuSGxDNDlwYU43?=
 =?utf-8?B?M2EyQUNsSUtYemcraW9vWWVxT0RFeis3d2V2VGFPSXU0cmpnb1ZQR29SZHFB?=
 =?utf-8?B?NDBKV2VqaU5ZRGFyTExWd1c3RFRyZElCWjd4QXhlN1FSWGVlUVNOWUtka05E?=
 =?utf-8?B?TTdFMERUY255b1pycVNkd1BUZFNuRkRuVnByWHlpNmg5SVNZWllZVzBWa0s0?=
 =?utf-8?B?bXFjWDI4ZmxiT3YwTE5CbTgyYUF6R3FvVUxaQnJNTjdFZVVLcms0SGR1dTdK?=
 =?utf-8?B?bGdtRFJYSFd4VEJRZEw2K0FtVmwrR1RmMDBvYzIzNVVtbjBjSEF2SVErdjU1?=
 =?utf-8?B?bEJmTE9qWTBxdkc3WTZqVlNYWFBBcTFpYm1ydjQwc0x1SXEyK3JzcTN5b0tR?=
 =?utf-8?B?ejZiWUtCOGFURnZ0WlE2QUtZYVZhRlZ2RzF6L0YvKzhTMlVFbGJia2dmd3pL?=
 =?utf-8?B?T3UzeFhESHNIZ1RKaTlSalNWenNiWW1XbjJlWGM4WW9TZ2xPV2l3Vi92U3E3?=
 =?utf-8?B?WG9IYVVmdEhpYTZMbWhNRzNUTC9CaWVPVTczK0s0QmxtdGtSaFFoTVNjenhl?=
 =?utf-8?B?QzhaS3ZzZjZldnZrWExMM2FqNDNwdlhQelV0c3k2Z0VYQjg2RTlmcCtFQWNC?=
 =?utf-8?B?MUxMNERtZDBaWlNYM01Vd2lLVm4zQXNKbFU2YzVZMFZqWm9yd2poMzdFTjc0?=
 =?utf-8?B?MUtLS3NkTk5GbDFQS0VvN01JWmhUSTBUaDFaYlZxZ0Qzbjh4V2k1UmF2WG5B?=
 =?utf-8?B?TW00NVFpaDkyMzdZVXpVR0hXYlAvWGpSblhkQkUwRTVVdGpENEhkU203MGRY?=
 =?utf-8?B?UnNCbVhUckFKdzd1SjBvcGZQMDEwWVZYaWxtUStQWHFFYWtKMUZkYzVMc2dt?=
 =?utf-8?B?VU9zc2xrTERQeE52bmw2bUJERnV5NEJocDR6ZjhpaGxJQkxRbENYbTIwSEJa?=
 =?utf-8?B?blR2enNVaXZIUDlnNWl4QnIxVFJIK3R3YXluOWJIVTloUWFYNytzVURYSzZV?=
 =?utf-8?B?b3lGQW5FdFZLM0pLcEJQa1I5SUsyTDlOd2ZGSkxVTnFFZkpYVUgyTU55VnB3?=
 =?utf-8?B?bGRaUGwrZlRaOVM4MHlXb29yT0Z6V2lLWG52Wm4yQWxTeHhwYVF0MnYzbVB0?=
 =?utf-8?B?alJlRVRWTWJ6UmV1NEZnMTRGSG5mSjNYSDdNLzNhN0ZheU9wQVg0eEZoc2lu?=
 =?utf-8?B?Um5tUTRGQWdFQm51STMrUFJ3RDdXNnU0OSt3NGJQR2FLWWRCWm5hM2VVRnZv?=
 =?utf-8?B?QTRrcnFZOUtMWERKQlZpNzU1TW90T0NpNkJaV1J1MEVyRUdmYk5UeXNuSWpT?=
 =?utf-8?B?dm9IcVJ6TGZWMkFTb1haazJNL3dxOEMxY1I2UXlvbFI4bkl5YmpiQzZISDJV?=
 =?utf-8?B?RzlRYU54MU03RkprTnBrakpGVWJLSTI3OUk5SHgzSHpxL0h6bC94ZGNMWHVo?=
 =?utf-8?B?cUpoNmJHR2RGcEcxdSt4c09Bb25mVWVoVE1saW4yUEdJaFlaQ3BGblpUdExN?=
 =?utf-8?B?Mk9hK0oxVVVOVGxCazJVODBOSldnUEtkVUtHRlNZK290bHVMbnZRcUh5MnRL?=
 =?utf-8?B?YWpIaUF5bnVRVWxiZVRDcnJHdG43anBwdTdLSmdKbTZWYVpiYy8vMCtHVE1a?=
 =?utf-8?B?S04rdldlamEvZklLeTdYYXNtMnZiMTkxKzZwd3hlR1didGVYWjVpYTMyUUsv?=
 =?utf-8?B?a29vWU5NNHllNzRSTDhUSlRNTGVtcndNa1BVQjhKWDk0NXlkMElFaktLNk45?=
 =?utf-8?B?SUh0NDlRWEZCREpYRG53UlNPODYxQkhpVTBoYXo4Z0xmbitqNGlEeVlQUW1a?=
 =?utf-8?B?bW1pUHUyNUdVeWN5bGEyK3p2enM2d2pJK3NrY1ZZc05NOFVFRVB1TWxRTDVj?=
 =?utf-8?B?Q3lYMjJuM0xmaWMvSnBnMncxaGdZUlZLT0RCNFgrNlRRRkJaNGVlWkhEcERw?=
 =?utf-8?B?ckpPaXU3Q2poMlZXYTM2K0EvMkkzOGR3ekVMU1hCa0hLaFZxMWZ5UTBaSkhv?=
 =?utf-8?B?YzIrMGlCTy9SdkxlUkdrb0lEV3FkaXZ1SWNnODhkRkVCRm1KMHJoQUUxS0JX?=
 =?utf-8?B?NjQ0UkVnMmxpaFVEOVJLcGJFTnVMdDdSS1VOekxOb2s1NUZ1dDYrMFhOeUVl?=
 =?utf-8?B?bTViT3ZzNjEweW1CRnRVUUZ2bVhTNjVvTXljNGZMeDlPbmpwZnlQUi9wNUR0?=
 =?utf-8?B?MDIxWnpaNXVFMEoxWTU5dkJCOVIvbERML1lmTXh5OEt4am1FR2owYTNaaGZ0?=
 =?utf-8?B?d2dyVDVYK24wQ1JHcDc0aFRER0hRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(4053099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 06:48:55.8842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c283b55-c991-480e-f3a1-08de5726d0fd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6332

--------------aWRpLptIbYbqMErw5zKcjQnj
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael.

On 19/01/26 08:25, Rafael V. Volkmer wrote:
> Hello Uwe, Gokul,
> 
> Sorry for the late response, I was on vacation and away from my setup.
> 
> On Fri, 9 Jan 2026 23:53:22 +0100, Uwe Kleine-König wrote:
>> That makes me think the problem isn't understood well yet and needs more
>> research. @Rafael, does the problem reproduce for you with Gokul's
>> recipe? (Or did you try that already? I understood your reply as "I
>> didn't encounter the issue but also didn't test specifically for that.")
> 
> Right, my previous reply meant I hadn't explicitly targeted this issue yet.
> I have now re-tested using Gokul's sysfs configuration sequence, but I still
> cannot reproduce it on my setup.
> 
>> As I cannot reproduce the issue, can you please check if adding
>>
>>        pm_runtime_get_sync(pwmchip_parent(chip));
>>
>> to the probe function makes the problem disappear? Also please boot with
>>
>>        trace_event=pwm
>>
>> on the command line and provide the content of
>> /sys/kernel/debug/tracing/trace after reproducing the problem.
> 
> Since I cannot reproduce the issue here, I can't validate whether adding
> pm_runtime_get_sync() changes the behavior, and I don't have a failing
> trace to share.
> 
> For reference, I ran the tests on an AM62P EVM using TI's default SDK
> userspace, with a custom kernel on top, and U-Boot from the SDK. The
> board was booted from SD card.
> 
> I used pwm1 instead of pwm0, since the PWM pin routed to the EVM 40-pin
> header is ball B21 (SPI0_CLK / EHRPWM1_A). The signal was verified with a
> logic analyzer at 24 MHz sampling rate.
> 
> This makes me suspect the behavior Gokul observed might depend on another
> configuration interacting in parallel.
> 
> If possible, could Gokul try the same recipe on an AM62 EVM using TI's
> default images and confirm whether the issue reproduces there? That is the
> platform I am currently working with. This should either match the AM62P
> results or help identify a relevant configuration difference.
> 

Can you test the same on TI J784S4 EVM as I reproduced the issue on this 
board.

I believe dumping the registers and capturing the signals using logic 
analyzer is the best way to reproduce this issue.

The easiest way I tried to reproduce this issue is by enabling debug 
prints. I have attached the patch for the 
same(0001-Debug-prints-to-check-if-period-and-duty-cycle-is-re.patch). 
This patch basically reads the registers and prints its value.

So, after applying the attached patch and running the following 
commands, I got the following output.

Commands:
============
 >>>>> cd /sys/class/pwm/pwmchip0
 >>>>> /sys/class/pwm/pwmchip0# echo 1 > export
 >>>>> /sys/class/pwm/pwmchip0# cd pwm1/
 >>>>> /sys/class/pwm/pwmchip0/pwm1# echo 10000000 > period
 >>>>> /sys/class/pwm/pwmchip0/pwm1# echo 3000000 > duty_cycle
 >>>>> /sys/class/pwm/pwmchip0/pwm1# echo "normal" > polarity
 >>>>> /sys/class/pwm/pwmchip0/pwm1# echo 1 > enable
========================================================
Output:
===========
Before put sync: Period:65103, Duty cycle:19531
EHRPWM enable function: Period:0, Duty cycle:0
===================================================

This indicates that the duty cycle and period is not reflected.

It would be really helpful, if you can try the same procedure on J784S4 
EVM, Rafael. I have also attached a patch(0001-Enable-EHRPWM-1_B-using 
AC33-pin.patch) which includes the device tree changes for enabling 
EHRPWM1_B. The testpoint used for signal capture is TP126.

Additionally, it would be great if you can also share the output after 
applying the attached 
patch((0001-Debug-prints-to-check-if-period-and-duty-cycle-is-re.patch) 
on both AM62 EVM and J784S4 EVM.

The issue is that I do not have an AM62 EVM with me, actually. Apologies 
for that, Rafael.

Thanks in advance for your help, Rafael.

Best Regards
Gokul Praveen
> Best regards,
> Rafael V. Volkmer

--------------aWRpLptIbYbqMErw5zKcjQnj
Content-Type: text/x-patch; charset="UTF-8";
	name="0001-Debug-prints-to-check-if-period-and-duty-cycle-is-re.patch"
Content-Disposition: attachment;
	filename="0001-Debug-prints-to-check-if-period-and-duty-cycle-is-re.patch"
Content-Transfer-Encoding: base64
Content-Description:
 0001-Debug-prints-to-check-if-period-and-duty-cycle-is-re.patch

RnJvbSA3OTMxNzFiODU3YTdjMzdjODM4ZDg4MmIyNjEwYjg5ZDZlZjkwZTFhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBHb2t1bCBQcmF2ZWVuIDxnLXByYXZlZW5AdGkuY29t
PgpEYXRlOiBGcmksIDE2IEphbiAyMDI2IDE0OjMxOjAyICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gRGVidWcgcHJpbnRzIHRvIGNoZWNrIGlmIHBlcmlvZCBhbmQgZHV0eSBjeWNsZSBpcyBy
ZWZsZWN0ZWQKIG9yIG5vdAoKU2lnbmVkLW9mZi1ieTogR29rdWwgUHJhdmVlbiA8Zy1wcmF2
ZWVuQHRpLmNvbT4KLS0tCiBkcml2ZXJzL3B3bS9wd20tdGllaHJwd20uYyB8IDE0ICsrKysr
KysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcHdtL3B3bS10aWVocnB3bS5jIGIvZHJpdmVycy9wd20vcHdtLXRpZWhy
cHdtLmMKaW5kZXggN2E4NmNiMDkwZjc2Li4zNjI2Mzc1YzVlNGEgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvcHdtL3B3bS10aWVocnB3bS5jCisrKyBiL2RyaXZlcnMvcHdtL3B3bS10aWVocnB3
bS5jCkBAIC0yODMsNiArMjgzLDcgQEAgc3RhdGljIGludCBlaHJwd21fcHdtX2NvbmZpZyhz
dHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20sCiAKIAllaHJw
d21fd3JpdGUocGMtPm1taW9fYmFzZSwgVEJQUkQsIHBlcmlvZF9jeWNsZXMgLSAxKTsKIAor
CiAJLyogQ29uZmlndXJlIGVocnB3bSBjb3VudGVyIGZvciB1cC1jb3VudCBtb2RlICovCiAJ
ZWhycHdtX21vZGlmeShwYy0+bW1pb19iYXNlLCBUQkNUTCwgVEJDVExfQ1RSTU9ERV9NQVNL
LAogCQkgICAgICBUQkNUTF9DVFJNT0RFX1VQKTsKQEAgLTI5MCw3ICsyOTEsMTUgQEAgc3Rh
dGljIGludCBlaHJwd21fcHdtX2NvbmZpZyhzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVj
dCBwd21fZGV2aWNlICpwd20sCiAJaWYgKCEoZHV0eV9jeWNsZXMgPiBwZXJpb2RfY3ljbGVz
KSkKIAkJZWhycHdtX3dyaXRlKHBjLT5tbWlvX2Jhc2UsIGNtcF9yZWcsIGR1dHlfY3ljbGVz
KTsKIAorCXUxNiBkdXR5X2N5Y2xlID0gZWhycHdtX3JlYWQocGMtPm1taW9fYmFzZSwgQ01Q
Qik7CisJdTE2IHBlcmlvZCA9IGVocnB3bV9yZWFkKHBjLT5tbWlvX2Jhc2UsIFRCUFJEKTsK
KworCXByaW50aygiQmVmb3JlIHB1dCBzeW5jOiBQZXJpb2Q6JXUsIER1dHkgY3ljbGU6JXVc
biIsKHVuc2lnbmVkIGludClwZXJpb2QsKHVuc2lnbmVkIGludClkdXR5X2N5Y2xlKTsKIAlw
bV9ydW50aW1lX3B1dF9zeW5jKHB3bWNoaXBfcGFyZW50KGNoaXApKTsKKwkKKwkvL2R1dHlf
Y3ljbGUgPSBlaHJwd21fcmVhZChwYy0+bW1pb19iYXNlLCBDTVBCKTsKKwkvL3BlcmlvZCA9
IGVocnB3bV9yZWFkKHBjLT5tbWlvX2Jhc2UsIFRCUFJEKTsKKwkvL3ByaW50aygiQWZ0ZXIg
cHV0IHN5bmM6IFBlcmlvZDolZCwgRHV0eSBjeWNsZTolZFxuIixwZXJpb2QsZHV0eV9jeWNs
ZSk7CiAKIAlyZXR1cm4gMDsKIH0KQEAgLTMwNCw2ICszMTMsMTAgQEAgc3RhdGljIGludCBl
aHJwd21fcHdtX2VuYWJsZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2
aWNlICpwd20pCiAJLyogTGVhdmUgY2xvY2sgZW5hYmxlZCBvbiBlbmFibGluZyBQV00gKi8K
IAlwbV9ydW50aW1lX2dldF9zeW5jKHB3bWNoaXBfcGFyZW50KGNoaXApKTsKIAorCXUxNiBk
dXR5X2N5Y2xlID0gZWhycHdtX3JlYWQocGMtPm1taW9fYmFzZSwgQ01QQik7CisJdTE2IHBl
cmlvZCA9IGVocnB3bV9yZWFkKHBjLT5tbWlvX2Jhc2UsIFRCUFJEKTsKKwlwcmludGsoIkVI
UlBXTSBlbmFibGUgZnVuY3Rpb246IFBlcmlvZDoldSwgRHV0eSBjeWNsZToldVxuIiwodW5z
aWduZWQgaW50KXBlcmlvZCwodW5zaWduZWQgaW50KWR1dHlfY3ljbGUpOworCiAJLyogRGlz
YWJsaW5nIEFjdGlvbiBRdWFsaWZpZXIgb24gUFdNIG91dHB1dCAqLwogCWlmIChwd20tPmh3
cHdtKSB7CiAJCWFxY3NmcmNfdmFsID0gQVFDU0ZSQ19DU0ZCX0ZSQ0RJUzsKQEAgLTMyNyw2
ICszNDAsNyBAQCBzdGF0aWMgaW50IGVocnB3bV9wd21fZW5hYmxlKHN0cnVjdCBwd21fY2hp
cCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSkKIAkJcmV0dXJuIHJldDsKIAl9CiAK
KwogCXJldHVybiAwOwogfQogCi0tIAoyLjM0LjEKCg==
--------------aWRpLptIbYbqMErw5zKcjQnj
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

--------------aWRpLptIbYbqMErw5zKcjQnj--

