Return-Path: <linux-pwm+bounces-7890-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5934AD10A86
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Jan 2026 06:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 710CC30464C2
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Jan 2026 05:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6C430F934;
	Mon, 12 Jan 2026 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n+iluAQs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azhn15012012.outbound.protection.outlook.com [52.102.136.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CC81A9F91;
	Mon, 12 Jan 2026 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.136.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768197120; cv=fail; b=sQquWGp0cLDeOEpn0oh3BZftFiBS5l70c855odyu1vFjoLa4bShzvXEN/M3cb1v1XBSOcz4W26RmpkSQlqdy51n5l1Zy+12fqlTQrXADV2iGf911pNTpC0Lq5Jb7mSSSwPiWOsi+R467OjEsqPtY6ywOCvisDy4JZYwLG/Se/6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768197120; c=relaxed/simple;
	bh=yWYRDMDIdw47fih7MP7d/RK523JoWhm+PIxFPAR+mgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s2xezWkecbcEamMi4AgslVDYvDBJ8anLjyvBQIW6gjS+1hEvxx21NrPPkv+9rsjCJglexZv8humrQ3bM4hVZ7tr7ocMUbBdTdzuRxjAuHT2jtduJSlambDC4b78SNt5Y+K1Jd2zblDjbbmDlNR2gxbludPWttIXgAKAnDaK8Nb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n+iluAQs; arc=fail smtp.client-ip=52.102.136.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8keRxNT/q/ZiZwHrq8Idltqt2eh6GgKVJy7RBw3ha+C/J3JMl88G7ZVYIPWIqpe8c1eoHD79MybSCiHK8QzOQbP5kgFoOQk4AQw9IVLmI7VOsY2TuRkyIFhYo2yzHyTD8hPPtL2vhBCelXtPqte20UMoiXAlF0Z77AFdMs/h7vrZobFetwiprbMx5Vy1yaD2ugkzrLxVIkCLgTJ/uLGRnLDPPL6kBgKf0+g5qKTn2yI6VMm0nptZeFr8urCVvslHd1lYPwan4RoHIMKD0h2twPo4rUMc8odWGxPYKonhfduQ6i55NBDGczR9+qRs5Ptp3Jb2CFSGyCJVXcJbIMd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QagPH2xke9eVSLPdg1GIQ85k//vIv3vr3cxpgjHjCSQ=;
 b=daLFIJvPLvRiiC8/uDMQ6PRpQcbQ+ARUnSiZsLCMWO6vXPSwc4UYmteHAvbUrwpheRbfbFbInUnDoBkQe4x+0q6YY4sPjW6KXKfA/RuJubqkssD6H/jo1Y4O0BgdrAPP9617Lqdeb3kYMFWIHY4jDkJTTDBOnuHl9PerKBM0isU8UccWms4zqK39zEmXf8JcyjKKHa0bK4fqwTo85RlrcIoV5q92Fm5UxBZKMd12mh/evCnLLzE28COxH7RSW4wc5BSY9RNYono0F7gemRNnNVnJdh3+P1sVWMzvDOYJrHn1yk6nhk3Y9yJexpOpr/w0dV3MgbnJzX2RT1UxQLJAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QagPH2xke9eVSLPdg1GIQ85k//vIv3vr3cxpgjHjCSQ=;
 b=n+iluAQscRQTfJZxkRbQ2FV2wypSscNk6veG5uj8xpzDWgn1w7Kanb7cNawANiVaP5sMfMJK/ojFBJ3nvrFPp+4uxHpjEu3QojVsfDukeqnhLC2ttixcfQufIw3pVZUEWIw90EfR6B/n8KOEWNCMEiBIH6Q//Bg3iJdm7KFPptQ=
Received: from PH7P220CA0071.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::33)
 by DS7PR10MB4976.namprd10.prod.outlook.com (2603:10b6:5:3a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 05:51:56 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::c2) by PH7P220CA0071.outlook.office365.com
 (2603:10b6:510:32c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 05:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 05:51:55 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 23:51:54 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 23:51:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 11 Jan 2026 23:51:54 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C5ppMq4160205;
	Sun, 11 Jan 2026 23:51:52 -0600
Message-ID: <741ec8db-7804-4f31-969b-10724ec06823@ti.com>
Date: Mon, 12 Jan 2026 11:21:50 +0530
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
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DS7PR10MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: 22df40b3-9142-4934-1c41-08de519eb15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|34020700016|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHdvYS9kK3Q3amcrUGQ3MVRnQkpyalgySWVROWVzcGNYTDZXUzZGNzViWGRv?=
 =?utf-8?B?ckRxOThqeG5FNmcvY1ViTnZDc2dyaTV3N2hwREY5OEpYRkxIYzU2NnBIVCtB?=
 =?utf-8?B?VXhFSW9EUFpSQzNxeHNjTStJS1JkbkZ1UnpuNDVBWWsvcDdValB1RGxHK2V0?=
 =?utf-8?B?bzVUVlBUaFlyTGprbjRmU3I0eDVXOWJ5a3lIcEd0emtkWlc0Mzc5UnZENldM?=
 =?utf-8?B?blVUcFM2UkhKbXBzLzdvWkUyaGxkajl6YkNPYkdwdElKUzRyMmtkbGI2ZGt0?=
 =?utf-8?B?WVJoZ0t5S29tMkJIRlFHZjNSbjV1WklpbDBPWkpQWHAwVUdsaDNGclNoKzFB?=
 =?utf-8?B?ME5oa0I3VXZPMUkxdy91bG03bXlHSks0WmFtUDlyNHFlTW5jRENidEgrQnhr?=
 =?utf-8?B?QmJFdnJnaVNJMWU3Uko0WElYblZON2Evb3NkWmkycEZ2WTJmSW1nZG1LRlk0?=
 =?utf-8?B?ZjZ0bXZSZ0JaTHY0ZXJyRm56Sjl3VWxmdUJaTXY0Y2RGalZvU3VRNXNhVVRN?=
 =?utf-8?B?Ni96dXZja1c0ZCtNY053aGtmbFZNY0NXeW5RdHRJTkJBakUrVzh0WEVRMXNH?=
 =?utf-8?B?QlBoTkpDMFRjaFM5TWpqNko4eUdWRWZGUGdBU2Z5d3BzanU1cWtiMXRMclQ4?=
 =?utf-8?B?Q3I3SjM2a2FlRDhvV2FYL3JhZEJ4aVJaN2pBN283MFR0RHRQMDM0bkhkTHZ4?=
 =?utf-8?B?aUlLODhoY2dGUkVzK1BXRTd3TUZLZkxhRVBCZVhxY0tyczd2dnNrZkg4bDNp?=
 =?utf-8?B?NnpoazQ2UHpOcEdqcEY0UG1tUGg1RjREWlBSL2JxNXNFVVBWMzZ4V3FQcGRj?=
 =?utf-8?B?RTl1TGhzSVM4WG1CTzliR3F5a3BIZ0ptV0pGbkluZEpVOFl0ckZXTVR3cDBx?=
 =?utf-8?B?VTBJN085VlFGdTBHYlJKaDNvazVXRzRwZ3Mwb0JxR3B0ZGN3cWVqWFNCM2w2?=
 =?utf-8?B?SGxZY3l2Y0p0OStsM2dEL21Yb0tXeHZUUGlGd24wVllGQjhYRi9rUU5JR3NU?=
 =?utf-8?B?R3ZJM3JQelJ4KzQybk1JQjVzT2VsUFl5WmtTNmVXU2Z1dldDQkNrZnJSblZE?=
 =?utf-8?B?emVQY3RWMHJycWQyaGZud3hISEdiN2I2Wk8vYkpUL2RiQU9tMFBCUUZ0Vzg2?=
 =?utf-8?B?dVNwRTBuNHNiTW5hSTVzMzAxSnl4dEZPNDNMUUgvN2hNQUpTajBSM0dQbUtW?=
 =?utf-8?B?UFE3N3lyeDhldjYzUWp4OW0rREppV1UwZDlLZWkzd1VTclNSd0JrcG5tMTlK?=
 =?utf-8?B?UUkxWlByZlNYSlZIOWs5MTlUOXAwSnowaDJPT0ZmRTAvMW9SR3hjOUVjUlh1?=
 =?utf-8?B?N1VQUjZBUW5PZlYwUmxmNVMxK1NaOFNYeEdEY0JrbDZ1OEwvcTc5RmNkUTY3?=
 =?utf-8?B?bGZtMlV2NCtCeUVOVFd5dTlOWExSMHpHQmp5SDdlUFJHMU1TSDIxTTFVNVpT?=
 =?utf-8?B?VHRkQ09Td2JiUDNjd29OSjd3MUxNL0htQlJHdHhtaFVUcWxiOHU0Zkw0Slor?=
 =?utf-8?B?RjF4V1F3bTV1bVhqelNkb2tkVHEyMnpGcjhwTEJvbnhkN3hvckVPcHhKMVMr?=
 =?utf-8?B?THNCek1GTHBrb2ZqSkZqY3NQelBFc3VhS0t6YnFyNk00QUI4SHBaZmRhSVhZ?=
 =?utf-8?B?RWkxbTBqUm1GQ1NEWDVYUURKR1R3SkNWZ1dSVVljczJTaDdFSDhCTVVZMkFx?=
 =?utf-8?B?TEJvYzZpK3Y0QW54bXVZMWcwdnI2aGRhVjBYMC95TWtjWkQ3OHVqS2w1dnVE?=
 =?utf-8?B?ZFFWbG9nSDFYY2tnQkFVdFQ3UkZtYzN3ZzRnQ3RnTWkrem1qMFhFYllsSkFD?=
 =?utf-8?B?UGlxNmYwdkRuZEsxUXJ1S3dzelVuQlRGN2NjVFlhMkJmaERLaUhudVo1RWdh?=
 =?utf-8?B?aWd6MDk3SEQ0YzFndWhPM2h5azVKSERVRFFEd2xWTGVGNmJsOU9XdlBBS0xR?=
 =?utf-8?B?eWlSODdBT0UvbVZpQnJIRU9Mc3hqQ1BaVkh1TVRtNGJIRHhZTDhSdVZ6R3hF?=
 =?utf-8?B?cmR2TWVFQ01CZXdheVdVbFFjSDhtT05QUjlicGUvSk0zWmJDQTJNZy80aUlR?=
 =?utf-8?B?M0d5R2lJdkVMSHBoUXRnWHMzU2lOQUdDMUdHaUZOdGpXMTRDZ3MwZmV0Zmp1?=
 =?utf-8?Q?bjWQ=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(34020700016)(1800799024)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 05:51:55.4570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22df40b3-9142-4934-1c41-08de519eb15a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4976

Hi Uwe,


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

sure Uwe, I will try this from my side.

In the meantime, will you able to test the same on TI J784S4 EVM as the 
issue was reproduced on this board.

> 
> Best regards
> Uwe


