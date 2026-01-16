Return-Path: <linux-pwm+bounces-7915-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EA5D2E2A5
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jan 2026 09:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFFF9301BCCF
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jan 2026 08:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3621E3074AE;
	Fri, 16 Jan 2026 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EmToczMo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazhn15010016.outbound.protection.outlook.com [52.102.133.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F62305045;
	Fri, 16 Jan 2026 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.133.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768552871; cv=fail; b=uOaouJGbNi/Gq90OVILrP8+hmcnrPrhafkixK8SxzNRqlA3h0dsbp+BC4Am/1L+r+AXLaSLBAcCgJxiY4qGjFOHiU3S34IJm0hRSfDdyfDFgoy4f6fOaxyuknBcJxsqiHbBrmBHtihzcztmT1LBhYBUGOCVexGARNSCUdfxdxvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768552871; c=relaxed/simple;
	bh=nFdydYqcQjGw6+mwYaDSb3tf1ebwg1aLosy5AP9XJCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rFMrAWi0XfgPOK0Pe4LFLrOMuwg6zW0OXvsDaGQVMfFoKPje6cDYJsyKQAv1Hf56o8yr1MPJdX+zzFjP5UdPIwlfSuorXqa8+nD2zq4SnTbQf7OfVsG9/+bBvhFOjA7ysESzJXqe17eKE4hc33rp+pJoaKEHuU/qxzXKhaFORd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EmToczMo; arc=fail smtp.client-ip=52.102.133.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yThqLKe4gLKPqBg6e6Wxvw3VIEo0Xah6EsUYg6JYJgse8nVJE6IwuvJUvwLC1g2+xnlRZB7cwr7h88NsH+MtKc+td54Y7GgX7sah6T+DvGHv6MbksrtAu6WMG7fu/96Cq+jmh8U0iZGuqcsUVsBALkz5A7jpkMrk7iWF1aSTcEqySIpM30FNcHLYJUpoA9tuwxtDm00rQl5UIBYhScldFfKvlS18g1EmZYhaOW2fHdXFFlT+VhOjOU/289ytJyjW576nWjFkcpAu2wSzuNj9oyZiEIzVGK1mhcuW3uC52B0HXHXuu1Wu2+e5v+1kUiS/H10ixunUQPQTr6VlQ0UYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG2P+uTTgafGkOFyud/+rbSbsGn0GdHR5Wh3NfXdFcQ=;
 b=JuVxvjKCt3mNE7RvGEPqIfnQ9rZGYmrcK7BwKrQEhR0qT9/orA7U3vJEv1qOXZibkqZ0AX/9DBonSvUlN1zWUjYxXjdKRPohU766fB8LHrCV2ZiEt9E+vEGWsADuC2y3wnrE68UQfAKqAhldhwsoD5duqdTqCD66i+0CV4JptFKrLjLod1nC8Ov1cn2fmpCMX7Fe1oGBi5bAYt9hx2YlFHrI+GkrAh3OQwbuOpdV1eMf/LLW+nkXWMscedsJvxt2aI2p6CvUJp23uISjQwDc4Vn3EOq+bNpC+Teo1XWYcph92IEMD2pNTjWvdLI8U+NCoMzMTVAr73mb2il3lmvMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG2P+uTTgafGkOFyud/+rbSbsGn0GdHR5Wh3NfXdFcQ=;
 b=EmToczMoAN7R9JdH4tOYhxCzTTTpVo4zKFPjXTKdOizSI3u49W4i51HZAXoSI7gqu2a4XszVgT+CFrQwTnJG+yB5IIkuN6gCMvYoPgpo9TRqPbPpVDCWtCdl2NMGpCjSrei+XPmXJSdFsJy4bCOW2UXuTMk86LnvH7dkFxExoGA=
Received: from BN0PR08CA0014.namprd08.prod.outlook.com (2603:10b6:408:142::23)
 by PH7PR10MB6651.namprd10.prod.outlook.com (2603:10b6:510:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 08:41:06 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::19) by BN0PR08CA0014.outlook.office365.com
 (2603:10b6:408:142::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.9 via Frontend Transport; Fri,
 16 Jan 2026 08:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 08:41:06 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 02:41:06 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 02:41:05 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 02:41:05 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60G8f2g32864475;
	Fri, 16 Jan 2026 02:41:03 -0600
Message-ID: <ba63dd19-0ec8-4928-a396-7943a1131abc@ti.com>
Date: Fri, 16 Jan 2026 14:11:02 +0530
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
 <63a0c480-c953-4717-9efe-766038d7fa8b@ti.com>
 <nj2xtbprctszessuedsxkdvpbjywcruwoo3ioyfrfdbt5lemg3@eri5iorsajo3>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <nj2xtbprctszessuedsxkdvpbjywcruwoo3ioyfrfdbt5lemg3@eri5iorsajo3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|PH7PR10MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 556515d3-84ff-4f25-1076-08de54dafd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|34020700016|82310400026|36860700013|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmJWMFd1bFZLMlRKVk02YW1lWEpLdmZmcnkxNENtYzVEWGc2SGxEYlFwYUlZ?=
 =?utf-8?B?ZFBCRUZDWVU2YVoyVWo2VEJXMkpiMS9iV09sa2dwTEVhQU9UK0RiZ1B3aXBL?=
 =?utf-8?B?NW9xNG5zZGtObndZNWNrNjg4SFB5Y0s1ZldwbkRvWmEwNjRuWlNwOUFiS2Vr?=
 =?utf-8?B?WlZkdWxxMkd1OFRpT1RiNEU5emlwemdpODh2NmF1YXlmMmNRekZrc3dCQlNQ?=
 =?utf-8?B?MlZpNlJXNjNEbHFONlhQOTRsWVdHeGxhUmxrTFpyTjhSdmJ0eDA4RGFISGNl?=
 =?utf-8?B?by9jRHp4SmhLQ1BWV1B3d1NZVlMvMlNpV2U3bWxxRXBWeFJFbytaYXppUkov?=
 =?utf-8?B?QXhSV0lUU3B3Rnh3dFk2eDQ1S2tlSnJPSVNaNENGUitxd1NTeW1mZWhXMlMr?=
 =?utf-8?B?cEpmQTllR3U4VUgwMVdaUWQ4V21YVlBjUEZ1SEo4R3REUGRPVTZqRDBsTGhR?=
 =?utf-8?B?S1RrdHRaUGYxYklJNEZTbVJSVWRYZ0JHR3lFVFY4eG50NE4rS2VFR2MrZ29j?=
 =?utf-8?B?aWtNbWVzTzBnL20zVHlzSHNKWlV3a2VaSHhJQkVhc3RLZHZoZkl6enlpUXl3?=
 =?utf-8?B?NVA3UUk0M3JlSVZlMzQwVmJvVDlkcjVaK21wZWEvWmVVSnp6eDJSOU5GbjVk?=
 =?utf-8?B?aTlBY3N5TDA2OHIvZ3VWcEtvQThzR3Nyc3BxNzl0b1JWVjhFRXYwZm84T0ha?=
 =?utf-8?B?dlR5SWNzbGxOZS92a2xxMWhoNm9zaVVVRjhMK3NoT3lVS3VUZTBDbmhhb3Zz?=
 =?utf-8?B?UHBGYUtyU2lOWjk3a05SL1B1ZjMrNEwzcEl3OGh3eFhkQ2FOQlhnZGFFOEFN?=
 =?utf-8?B?WER5bWFid1VLKzhOK0VXNXhWNHNONjZnMFI5VkVyaWdwLzR6blUzRTBLbTli?=
 =?utf-8?B?M3c5RnZIUXJoMmx2REhHdUVXMGtCQitteUdwaEFWWERqNG5xS25TM1lkRTJw?=
 =?utf-8?B?RnFDMFk1WS94L21IY2psc2p5OC9uR1lUWHFVdnN6NGR0R243OEkzSExoeVkz?=
 =?utf-8?B?ZGxqRGt0Nk5WUVJvcDdsV0NSd0FKWEdMNTdPdTZSckk5RzdJV2pQOG5xdHpq?=
 =?utf-8?B?VUwwZFc5WGpmMkViUFZBaWViTEIxVTZWa2lyN1llRld1RG1PWWdWbmJPWGdn?=
 =?utf-8?B?Qkoxb2hCT1p1NGxEM0xrYzFpQmlCSk1KblZKWitaVHdRU040aDJ1YnlQQTIw?=
 =?utf-8?B?Y3puNVlBZlV0ZVZoY256UFpWRkNYZGd5VEtpTGxkT2p0bDlIU2p2ejBicW9V?=
 =?utf-8?B?bVI0RmNmMjFJV1lYY095Y2lJaTlOdFFPQjkzZVNnYjZ4b0loei84T1hiTTB2?=
 =?utf-8?B?R1JEeS9iaVRGVFhCL3BnVVB2SzN4VnlaM0JnMjZIUWt0czNTUnUzQWdaMWJG?=
 =?utf-8?B?NjlMekxiYVhhVVZPNWdPZGMzNEVHZlBVNjZTcUZMT3dPSGxvVzNER0cwN3pY?=
 =?utf-8?B?aU5vMExOa3dFcHptUlkvNUs3Tm9ac3BBcXNEUStaczZKL2N3MHdBalNXVXJi?=
 =?utf-8?B?NUdaYnBEQmkyM2hyR0Y5VjE5RDl2c0FOZGdXcCswOCsxOTJMYzAzWGdjUnZP?=
 =?utf-8?B?ajRUUUVMKzZsUXc4dUNJc0J2cFdSS2FJazRQWHVyV3IrYW9CU21tL2N5cXdQ?=
 =?utf-8?B?VXM4M2ZkcjZrZFh6SmF2dmh0cmhreUFWblA2SjRhNDFRSm9zeUVhWENSaWJJ?=
 =?utf-8?B?TkU4R0kyUTJ3d29nWFFpMUxQQy85NFcrSjNUZThEZUdDVHdXQTBUL1IrMEJJ?=
 =?utf-8?B?NnpuL3VNZG1IeVlpa3psUVRia01naU1xUmxiM3UzOTVDWlozQm00T29ZcU1R?=
 =?utf-8?B?cEZDUGJUZlJpNUdYeHBVSmZxRWFHN245R1ZCRmllaHFLQm1MOFBZV0dZTFMz?=
 =?utf-8?B?NGxVVTBmWi9MMXU2Y3p5Nkl5TVdXa3Z3NTlKRSsvUFF2U05ubXR0eXA2dndN?=
 =?utf-8?B?NjFsS2tyQk9LMHhVVEtlK2xpRzFjT2xabmcxS0wwWHdIOEVCUU9wVXVKbXBZ?=
 =?utf-8?B?TUNwdkMrVzEraHBhTjc1QXpiQTJrK01xdk9ZNU1KbCswU1Vqd0NCWHFNanQ4?=
 =?utf-8?B?TEl2cTJNdy8rMGdmWEV3ZHNETHNqbnNvQmRuc3pyRkRpdzhkb2tJNUdEVndU?=
 =?utf-8?B?MVRZcWxwbExBNWhFMGFnUXNHV0VORUJkYTlZV1ZWcjBvRjFjNmEvcHc0VjBH?=
 =?utf-8?B?WllQSHpIZkZpY2NXbkpNVHVIS3VSV00wVUxSVVhtVzBucFpVVG1OdUQwcG1k?=
 =?utf-8?B?UmhmYklEemM4ZEs3aWxRNWFHY3BRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(34020700016)(82310400026)(36860700013)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:41:06.6297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 556515d3-84ff-4f25-1076-08de54dafd99
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6651

Hi Uwe,

On 15/01/26 22:47, Uwe Kleine-König wrote:
> On Thu, Jan 15, 2026 at 04:02:16PM +0530, Gokul Praveen wrote:
>> Hi Uwe,
>>
>> Apologies for the delay as it took some time for me to get the trace output
>> as well as to get the way I reproduced the issue.
>>
>>
>> On 10/01/26 04:23, Uwe Kleine-König wrote:
>>> Hello Gokul,
>>>
>>> On Fri, Jan 09, 2026 at 11:21:46AM +0530, Gokul Praveen wrote:
>>>> On 08/01/26 23:40, Uwe Kleine-König wrote:
>>>>> On Thu, Jan 08, 2026 at 12:10:35PM +0530, Gokul Praveen wrote:
>>>>>> On 08/01/26 01:17, Rafael V. Volkmer wrote:
>>>>>>> Thanks for CC'ing me on this thread.
>>>>>>>
>>>>>>> On 07/01/26 15:21, Uwe Kleine-König wrote:
>>>>>>>> adding Rafael to Cc: who sent a patch series for this driver that I
>>>>>>>> didn't come around to review yet. Given that neither he nor me noticed
>>>>>>>> the problem addressed in this patch I wonder if it applies to all
>>>>>>>> hardware variants.
>>>>>>>>
>>>>>>>
>>>>>>> I also didn't observe the issue described here in my testing: duty cycle and
>>>>>>> period changes always appeared to take effect as expected.
>>>>>>>
>>>>>>> My tests were done on an AM623 EVM.
>>>>>>>
>>>>>>> One possible explanation is that my test flow mostly exercised configuration
>>>>>>> while the PWM was already enabled/active, which could mask the effect of a
>>>>>>> put_sync/reset happening after configuration.
>>>>>>>
>>>>>>
>>>>>> Yes, this is the reason why the configuration was taking effect for you ,
>>>>>> Rafael, as the PWM was already enabled when setting the configuration hence
>>>>>> masking the effect of a put_sync/reset happening after configuration.
>>>>>
>>>>> Can you provide a list of commands that show the failure? That would
>>>>> result in less guessing for me. My plan is to reproduce the failure
>>>>> tomorrow to better understand it on my boneblack.
>>>>
>>>> Sure Uwe. These are the commands I have tried for PWM signal generation:
>>>>
>>>> cd /sys/class/pwm/pwmchip0
>>>> /sys/class/pwm/pwmchip0# echo 0 > export
>>>> /sys/class/pwm/pwmchip0# cd pwm0/
>>>> /sys/class/pwm/pwmchip0/pwm0# echo 10000000 > period
>>>> /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
>>>> /sys/class/pwm/pwmchip0/pwm0# echo "normal" > polarity
>>>> /sys/class/pwm/pwmchip0/pwm0# echo 1 > enable
>>>>
>>>> Once these commands were executed, I measured the PWM signal using logic
>>>> analyzer and the duty cycle was 100% even though we had set 30% duty cycle
>>>> through the sysfs nodes.
>>>
>>> After that sequence I "see" a 30% relative duty cycle on my boneblack.
>>> (With the follwing patch applied on top of pwm/for-next:
>>>
>>> diff --git a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts b/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
>>> index b4fdcf9c02b5..a3f4a4bb64e4 100644
>>> --- a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
>>> +++ b/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
>>> @@ -173,3 +173,25 @@ &gpio3 {
>>>    &baseboard_eeprom {
>>>    	vcc-supply = <&ldo4_reg>;
>>>    };
>>> +
>>> +&am33xx_pinmux {
>>> +	ehrpwm0_pins: ehrpwm0-pins {
>>> +		pinctrl-single,pins = <
>>> +			/* P9.21 UART2_TXD -> ehrpwm0B */
>>> +			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)
>>> +			/* P9.22 UART2_RXD -> ehrpwm0A */
>>> +			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_OUTPUT_PULLDOWN, MUX_MODE3)
>>> +		>;
>>> +	};
>>> +};
>>> +
>>> +&ehrpwm0 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&ehrpwm0_pins>;
>>> +
>>> +	status = "okay";
>>> +};
>>> +
>>> +&epwmss0 {
>>> +	status = "okay";
>>> +};
>>>
>>> )
>>>
>>> That makes me think the problem isn't understood well yet and needs more
>>> research. @Rafael, does the problem reproduce for you with Gokul's
>>> recipe? (Or did you try that already? I understood your reply as "I
>>> didn't encounter the issue but also didn't test specifically for that.")
>>>
>>> As I cannot reproduce the issue, can you please check if adding
>>>
>>> 	pm_runtime_get_sync(pwmchip_parent(chip));
>>>
>>> to the probe function makes the problem disappear? Also please boot with
>>>
>>> 	trace_event=pwm
>>>
>>> on the command line and provide the content of
>>> /sys/kernel/debug/tracing/trace after reproducing the problem.
>>>
>>
>> PWM EVENT TRACING OUTPUT:
>> =========================
>> # tracer: nop
>> #
>> # entries-in-buffer/entries-written: 3/3   #P:8
>> #
>> #                                _-----=> irqs-off/BH-disabled
>> #                               / _----=> need-resched
>> #                              | / _---=> hardirq/softirq
>> #                              || / _--=> preempt-depth
>> #                              ||| / _-=> migrate-disable
>> #                              |||| /     delay
>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>> #              | |         |   |||||     |         |
>>        gen_pwm.sh-1039    [000] .....    88.564669: pwm_apply: pwmchip0.1:
>> period=100000000 duty_cycle=0 polarity=0 enabled=0 err=0
>>        gen_pwm.sh-1039    [000] .....    88.564728: pwm_apply: pwmchip0.1:
>> period=100000000 duty_cycle=30000000 polarity=0 enabled=0 err=0
>>        gen_pwm.sh-1039    [000] .....    88.565065: pwm_apply: pwmchip0.1:
>> period=100000000 duty_cycle=30000000 polarity=0 enabled=1 err=0
>>
>> The trace output might mislead us thinking that the duty cycle is set
>> properly as the event tracer reads the duty_cycle variable which gets set
>> irrespective of whether the value gets reflected in the pwm registers or
>> not.
> 
> Can you please also enable CONFIG_PWM_DEBUG? That should show the values
> actually used as it enables a few calls to .get_state().
> 

It is the same event trace output as given above, Uwe.

Additionally, adding this config did not show any additional logs as 
there is no ,get_state callback implementation in the TI EHRPWM 
driver(pwm-tiehrpwm.c)

I also confirmed the same using the below dmesg output:

[    0.484725] ehrpwm 3010000.pwm: Please implement the .get_state() 
callback

I believe dumping the registers and capturing the signals using logic 
analyzer is the best way to reproduce this issue, Uwe.

Best Regards
Gokul Praveen.

> Best regards
> Uwe


