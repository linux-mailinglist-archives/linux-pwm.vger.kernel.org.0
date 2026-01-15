Return-Path: <linux-pwm+bounces-7902-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4BFD226B4
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 06:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 113893009D6D
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 05:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B62989B5;
	Thu, 15 Jan 2026 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SR8+FvaM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazhn15010016.outbound.protection.outlook.com [52.102.139.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908C29D26D;
	Thu, 15 Jan 2026 05:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.139.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768454415; cv=fail; b=b4GU+zG3IqwFm97qPN8XrVZ8MflroD/ztx4LZ59dUsimGmVZ2GsYE6mNnPmQR94Zs1wgB7pHq1n4GdTeZGXANIvcVZJkxI3ppeEfrygfE4+3hclWwK4V2w4aj9ZSdWxb1MC7ajo5YRU6i0xt2snmHSad0TJpsfNmpAN0hvN0+Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768454415; c=relaxed/simple;
	bh=26fXAtTN/MgAcwdNHaGfcCioJeTpJJzGdhqCiim4BPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tTkhhoJG4WQBuOHb90ZzwSVN0F1Jlz/JJgLQqOSewUZnacCiYg2k9xfQAm6U2J5BRUa2fWrD1R77kuJkfCcZLMliI8rjFgMZlsuiv3n/m5Acdk0L4aTWMKb4bL2VgfE15NMF70QrSIRboLLBs9aca/035mfVDbdANYucVEHVubA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SR8+FvaM; arc=fail smtp.client-ip=52.102.139.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs451GPcBNF1JtsFuebZ8KKsYGb/GZlSHHDl+lg0lBasKKz3L7sfDw3bgFAFTJxTPWABw6+IBDlzgLU3CGwUyvJmH6JZMinZqvSnfHv1DCvksXL5tNuy0A5m7gOqDC5mbNDaBzf7xAK7/r6nD2mFQiJD4xmvJwfTIfNjncW+NSmuiG9edBUVobRuZMRtx+cwvDA+PIr4ySXzUI+uRXddjjDgx+GMv7mERdu6SB3q+P8x8u/fRLZwn+8j+vtKCyhDENNlAD7FJ5x64FEO41+4+wC7Y1lHYVxSdmN/VkQs574c1yZArlel3xGn7wCD82k1aiATpiOrOM5z4d1fge4QdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjd90OSoICst8fyon2aAf282nmS8C4t1ueZyoxB6aYw=;
 b=XvdMG2YcFbZk6DzpIKGusMOMg+04GVZyrCp04Gb/ZyFv3VtuoiLl0wGIw8EAajUOKlM6WFIKPw+bz3TeXl7DK9DQVpXDj3TcNr8tjZAJZV4NluBz1uWu7GMcaoFdwQwun4BD0W1Wgu/Bp/TcOR4Qclu9eAuwSERQ32xFR94n8/FG2gy0vZtFLJ+nEE3hAJXTpAbMxx4AXXygnA1jf3z1NKHTT1TyfhjosdPnA3WN6irabDtLmndTGUaQp8unuLl7Ak3WngD5ToQK+4MgqJkZyQ+um4i70Hr87tXbc6gg1J8qcQ7Cz/oKa290vGvfvoc+mRWzKUqh0YP7PpZeYu87vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjd90OSoICst8fyon2aAf282nmS8C4t1ueZyoxB6aYw=;
 b=SR8+FvaMvk/pC56pjwEuoRsTPoqg4KbQiEkBr/v4j6sMQx1tvrrI6HBOpdtzK9FvjfsASADuMTPK25S6c5gh456SdZBzMGS/FRUd7ES94yGGKCM0ww4zYOo970jNk1MLFXuLABfVQsUzXdw9dAUCE/JEceV4k00NEbMktemBHm4=
Received: from CH0PR03CA0442.namprd03.prod.outlook.com (2603:10b6:610:10e::32)
 by LV3PR10MB7940.namprd10.prod.outlook.com (2603:10b6:408:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 05:20:11 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::1c) by CH0PR03CA0442.outlook.office365.com
 (2603:10b6:610:10e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 05:20:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 05:20:11 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 23:20:10 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 23:20:10 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 14 Jan 2026 23:20:10 -0600
Received: from [172.24.31.151] (lt5cd2489kgj.dhcp.ti.com [172.24.31.151])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60F5K74Y867709;
	Wed, 14 Jan 2026 23:20:08 -0600
Message-ID: <85d941a6-9c57-45f3-ab6a-33ca91cf05a5@ti.com>
Date: Thu, 15 Jan 2026 10:50:06 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before setting
 configuration
To: Gokul Praveen <g-praveen@ti.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, <j-keerthy@ti.com>,
	<linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<n-francis@ti.com>, <u-kumar1@ti.com>
References: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
 <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
 <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
 <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
 <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|LV3PR10MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 6edb2891-2337-4daf-5595-08de53f5c182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|34020700016|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGdIQi9yQzRLNDhPSjlzbng3dG9aT0ZzZTFsMVRhbEtMYm5XVGJseEdOTVFz?=
 =?utf-8?B?SVYreWp4QXBtdUl4WUdrWURCY0hoMzRTZ0RnSjcyVVU0UGlJQlhlMDJNWDR6?=
 =?utf-8?B?NkZCRlZqcXZ6UnUxd2hXSmkvY0ZMdXJzcEszbEZTdE0zdk9RTUpLMkRrMXZI?=
 =?utf-8?B?ZHMxQStaaTYyL0tFZ1JNZGpwM2hTZ0owR1JuajZ3MjZ2ZjBBdjR2US9qcDk5?=
 =?utf-8?B?TjdyL0I0WGRaV1Jvc09XdXU1cklPWGc4Qy9XckhNcVM2UE5ZWEZ5NVJVTW1n?=
 =?utf-8?B?M0pVRktySGhVZDFqUGU5MC9jTitqYXRabWliK092aDRNTklGR29nbGd2MTFq?=
 =?utf-8?B?bHZJMnFYMHB4cjd4WmxZem5FVnVuZDRpQ1cwNWFDQU5jdmRuYjJvbjE5dFBN?=
 =?utf-8?B?MlVRZjhualRiM0ZFOVp4aTQyR1hlUnFxT1JLTlJwK3NHaWtmUXZIUTRSVk4r?=
 =?utf-8?B?OUliS0cwdFhxVWlMRHVsZDB0ZW5jUTExTkhGN3Vya2c5c2RucXcxT21XS2JY?=
 =?utf-8?B?ZXc5ZFhUczJpUWh2RUJ4Q2poK0RqYmFCaDdQVllZMHRvVVIzK1JoazY4MHBv?=
 =?utf-8?B?bGhFdDZYNGs0Z3NYaHZ5V0FSbncxbnZVR0UrUlBJSXlKSHZqaVZ2OHRhai9w?=
 =?utf-8?B?bFhCK1VXZ0Y4VmVRYnpaN3Vzd0hYMTdxQVc1ck1LQktmMTVPWFI4bCs0NWU4?=
 =?utf-8?B?R0c0bDFNMkZsMUU4aTBjQUFqTVp2V2M3a0NxYTFWT2JxN2ZZK0lsS1U5U2dF?=
 =?utf-8?B?WlBja3RNUGxzZjdsNGNVYWpLb0ZPM2JEMmNIT1VTaEs2TlIyTURxYyt6QTA5?=
 =?utf-8?B?N053VUNXVUVnZURVTlhxQi9XWE81NkVjd1plV3JpSlFDSno4NDI1Zy9OL29y?=
 =?utf-8?B?Ymd1MkxFTHZPSk5GQzZiVTlHdnM2Q0FtV0lIcGNsNWxjWjBxRzVWT1psTkJI?=
 =?utf-8?B?UHhBb2kyVmptTjZQTVN1eW5USlM5NzlMUjVQa3lQNGF3R3N6Vm5xUERjaWxl?=
 =?utf-8?B?VThRbG14ZzNqbGJPanNNU2h6MVBZZFZlWmVwTitFOHJPNktiQ2xEbG9WeXhB?=
 =?utf-8?B?TUlSNUZMVWJmb2NQWGNSMHNha1ZaZDFlOHQwd2wxZmdGUEZiZ2pFeDF4amw2?=
 =?utf-8?B?UnYrNXhwT0F4V2lHa3pobHRKcWhqSUQ2TEJNcVQ1aWF1SUlDaDdhK1ZhMVZO?=
 =?utf-8?B?WDlXYmZVbitQQ0srNnJ1bGRaVUlqNlhjZjhOaEZVQjF4bUtCMXU3amhJU0tZ?=
 =?utf-8?B?SEVZWWFqbm82dlhwZUNYRUwySzJaMTNjUkQ0QWJKZkFiWDhQWlFLR0loQkl3?=
 =?utf-8?B?K0J4QldjQTg2dC85KzBLQ3hlL0h5cWhubFpHRytTbGZFT29BUjB3WVduOUtT?=
 =?utf-8?B?dG1mL05GTE9VSnhDOFZSWE1nSzVkWkh1bm1QdFowem91eklrTkFGV3JhYndN?=
 =?utf-8?B?Tzd3SkFzdWJBb0FyY2Rkb1l1RkFpUkk0V3BPaGIxelhoL3JaMDRPOFNxZ3Fu?=
 =?utf-8?B?SStpeDFDTm1hNlBzRlpMWVdUb2gvNGtuelp4c3NITGZscXJrWDhOMTAyRGVi?=
 =?utf-8?B?aFp1WFZ4QXRQVVVwTHg1VmlBR2lhOTVCSGQ5T1ZteGVGeWFaVzQrR3gwaW81?=
 =?utf-8?B?aVpWOXdsb0NGS2FXMC9nZHh0V2hoL2FENjBIMG9pdHJlWVdSd0poc1QweHRS?=
 =?utf-8?B?dEZNRXVhWUNTdExPYmg3RDVFZk12eEN6UkJyUjlOUjlpcld0MncvWHJEcWtk?=
 =?utf-8?B?U055YWVIMCtOcU1LUmNiZDlmZjVrd1dLd04rdEZEVTBLckFDSERpczZPWW1N?=
 =?utf-8?B?bDZqZXZucHRwczl0Mk1XNTlORXRXYklOOFQ4VW12ZGFjN0xZaVE1eVg3NkFa?=
 =?utf-8?B?TDM1Si9wQUsrSk9oRktFOXdaLzMvUDFMenFKRDZCZXBuV1drQ09Jc1BJTVN3?=
 =?utf-8?B?cTVjeE5WWTIyeUttMVNTL3JBcGw5ZFUwQUpWR0Z0K1I3dHVETCtpN3dZR3VB?=
 =?utf-8?B?YnJMQ0o2cnlnN1lkMUxmdlpMb2FkVVdzaVFrNnM3em9xT1hUT3FhbTNWRFE3?=
 =?utf-8?B?S2NlOWw0VGpYMVVONTkzZmU3UHl1VXRIaGh0U2hpd2NVdGpkK2ZDK1BMT1l2?=
 =?utf-8?B?aTRYNHQvZnZFQTlMZmovUEFwMlp1bmpGdXc1djBGYUZUdnhqRUpTQU54MU9B?=
 =?utf-8?B?ekVzbUowYUtaUlhqT3BDSEtwTWwya2FFYlRRNFhRZDVGeVhLc2lwdFJYMFk2?=
 =?utf-8?B?azlTUStsTUc3NlFjWXlHSW0vZ2ZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(34020700016)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 05:20:11.0824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edb2891-2337-4daf-5595-08de53f5c182
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7940

Hello Gokul,

On 1/9/2026 11:21 AM, Gokul Praveen wrote:
> Hi Uwe,
>
>
> On 08/01/26 23:40, Uwe Kleine-König wrote:
>> Hello Gokul,
>>
>> On Thu, Jan 08, 2026 at 12:10:35PM +0530, Gokul Praveen wrote:
>>> On 08/01/26 01:17, Rafael V. Volkmer wrote:
>>>> Thanks for CC'ing me on this thread.
>>>>
>>>> On 07/01/26 15:21, Uwe Kleine-König wrote:
>>>>> adding Rafael to Cc: who sent a patch series for this driver that I
>>>>> didn't come around to review yet. Given that neither he nor me 
>>>>> noticed
>>>>> the problem addressed in this patch I wonder if it applies to all
>>>>> hardware variants.
>>>>>
>>>>
>>>> I also didn't observe the issue described here in my testing: duty 
>>>> cycle and
>>>> period changes always appeared to take effect as expected.
>>>>
>>>> My tests were done on an AM623 EVM.
>>>>
>>>> One possible explanation is that my test flow mostly exercised 
>>>> configuration
>>>> while the PWM was already enabled/active, which could mask the 
>>>> effect of a
>>>> put_sync/reset happening after configuration.
>>>>
>>>
>>> Yes, this is the reason why the configuration was taking effect for 
>>> you ,
>>> Rafael, as the PWM was already enabled when setting the 
>>> configuration hence
>>> masking the effect of a put_sync/reset happening after configuration.
>>
>> Can you provide a list of commands that show the failure? That would
>> result in less guessing for me. My plan is to reproduce the failure
>> tomorrow to better understand it on my boneblack.
>>
>> Best regards
>> Uwe
>
> Sure Uwe. These are the commands I have tried for PWM signal generation:
>
> cd /sys/class/pwm/pwmchip0
> /sys/class/pwm/pwmchip0# echo 0 > export
> /sys/class/pwm/pwmchip0# cd pwm0/
> /sys/class/pwm/pwmchip0/pwm0# echo 10000000 > period
> /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
> /sys/class/pwm/pwmchip0/pwm0# echo "normal" > polarity
> /sys/class/pwm/pwmchip0/pwm0# echo 1 > enable
>
> Once these commands were executed, I measured the PWM signal using 
> logic analyzer and the duty cycle was 100% even though we had set 30% 
> duty cycle through the sysfs nodes.
>
> However, with the below command sequence, the duty cycle was getting 
> set properly
>
> cd /sys/class/pwm/pwmchip0
> /sys/class/pwm/pwmchip0# echo 0 > export
> /sys/class/pwm/pwmchip0# cd pwm0/
> /sys/class/pwm/pwmchip0/pwm0# echo 10000000 > period
> /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
> /sys/class/pwm/pwmchip0/pwm0# echo "normal" > polarity
> /sys/class/pwm/pwmchip0/pwm0# echo 1 > enable
> /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle


I don't think , this last call of setting duty_cycle , even will land in 
driver code .



>
>
> PWM is working only if we re-update the duty cycle after enabling the 
> module.
>
> If we do not re-update the duty cycle after enabling the module then 
> PWM signal line is being high(100 % duty) always.
>
> Test Environment: TI J784S4 EVM board.
>
> Best Regards
> Gokul Praveen
>
>
>

