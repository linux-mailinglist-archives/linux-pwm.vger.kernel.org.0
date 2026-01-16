Return-Path: <linux-pwm+bounces-7916-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F236FD2E880
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jan 2026 10:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 972A4300E450
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jan 2026 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1565231AAAB;
	Fri, 16 Jan 2026 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hI4QmGcE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azhn15012013.outbound.protection.outlook.com [52.102.136.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36E31355E;
	Fri, 16 Jan 2026 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.136.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554649; cv=fail; b=V3M5l/VoawkDATBwOwIN3QT3wTEtEhulYL9urvgcZyFSoB8/vWhvVNvyGJQBqnoZaJ2AqUc6c51EGb7zAm3TWho33b5Nh1gxafl1/culDWI64GY8z4l59940bR7OHzEbKo5z/ny1Bz7thS1uygxcoheK1GDCsbVJ5soXcDRF+q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554649; c=relaxed/simple;
	bh=EL/ct15Dp5aUZAjCEUohUBugdqI9Ucb5tGNey9k5/p8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:CC:
	 References:From:In-Reply-To; b=QLG9xkXRIKWPkMBRi+PynS3hktNaasXg51VvuTyFTrOK6nsIyhS9oQkHSYUF3XnLb/mf2lWoMGQ8T8RzzYLt0PIvlNRxn8nn/JjVvl61oU1GtSQBumfySmo0a5LSylrH5E8mL7KyAKWPkamdYx8R7KAvnRA90M+LqQB4UMFtqPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hI4QmGcE; arc=fail smtp.client-ip=52.102.136.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpeT5MKwSAdd5m1/FTAEzr3CsXzxe28aV6ZYuTiRFvBrIEVKupWRwRWfkaljxGIErDv2/mZrV0JoXM4E2RopTzbVezbW3sxJ4GNKjFaGUiVrPSjZO9tA5FlGKu6bBOa9/0HbaPP3cYP8ZS6WmFSMm3+5gJmTKm7RBXiYaPN/St8fGpz9EEokg5e4LUQUMiylG30ojADjscGB9UMmC1NwL+4kp+x7OOFAD3DEtuKR+vW3XSpcdST5P7cStj0E1Sl9hVtojHkJulH24UbyD3u1wXhs1n7t2cTYelZ+eTa2KItTLkh8lJWtwsjK660svR9rcatan5aQFPdrUoCnOq5GrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=964Uysxz4X+hECtBF9D1eJY/I1iOTTciLqjfD7cVE3A=;
 b=teQ61Ibl+uiqmFjdkHnPI68nm+5GJAcJdqIRegPBbspbk87jbDDoNJx9XzVNOWyy4hwGgwke4gV2rfsAgZnYe4lR3xpHI1YVZGLh6MeiKeDB6TE6CQXDm0SkyQEGDoQJE3oROl5YAmySMrJnmO0Lc3VvZnbJqUNQqzBZX22sqbsewf+/91XRJUTIbawbkHbLG25ltkq0452Dke6SQlRumXVzoHH+Kpu/EqOSRMbfxlwI0aausys3gT7/NilBDlGT2PdJGDKG8bAhL+bdkXh913vPX8VLfOyW+qbeGFm8+yuRUtGTCLK2h70VNoBa+OeJl9HU4QiTqOrz7Va/texMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=964Uysxz4X+hECtBF9D1eJY/I1iOTTciLqjfD7cVE3A=;
 b=hI4QmGcEnxFP/c0WYVX2MJAgdlzPhpXR1/0AC280J9AIT7KdRalCgqJ8+YbPZuJktGVnZDcZakGvWgSevURUa8G6ETNVsoYlTmRnzJ4cw/mcusorjMgp4yV0fPs5dIE+Qel5cRN0mz+0Ercr4MTxAZsfDFjGjPe35CmWujMR4nE=
Received: from BN9P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::34)
 by SA2PR10MB4747.namprd10.prod.outlook.com (2603:10b6:806:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 09:10:42 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::a9) by BN9P220CA0029.outlook.office365.com
 (2603:10b6:408:13e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 09:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 09:10:42 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 03:10:41 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 03:10:41 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 03:10:41 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60G9Ab5L2905391;
	Fri, 16 Jan 2026 03:10:38 -0600
Content-Type: multipart/mixed;
	boundary="------------k2i5L1OcZpV0Smrn0fCs0pDH"
Message-ID: <8c699821-1fe8-4205-812e-b302f3d10d24@ti.com>
Date: Fri, 16 Jan 2026 14:40:37 +0530
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
 <ba63dd19-0ec8-4928-a396-7943a1131abc@ti.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <ba63dd19-0ec8-4928-a396-7943a1131abc@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SA2PR10MB4747:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e52872c-0b8c-4d71-ceff-08de54df1fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|34020700016|36860700013|4053099003|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0xHWWpjb2dRWjBQZEFIdSt0NGNYOUhSSXhYV29FKzFXTmFxaUM2R3FBSHFR?=
 =?utf-8?B?VFBiUXZzeTVqWk1LeFo5anphdUFnUXBFOXVyMzhSTWxBTVFWNmpXaFU3RTE4?=
 =?utf-8?B?WllJNjkva093TEpJblUxZVpRRjNtdVFpM0xJd1RCOThEVHczMDEvMFNzdHNp?=
 =?utf-8?B?MEgybnhQU2FLTUxWSlVEdzk5Zm1ER3dPdFI3MGI5aFdDQUxpQzdnSDRKYWFO?=
 =?utf-8?B?ditoQlEzR2RsbEI3ZkhlaWtGL1BHZSt1L0tMbFFwaCsrbE9FTGc2SnUxZ2E3?=
 =?utf-8?B?SHZtS0V3dlVvbUJERjIwZyt0RTZSRWJKUkxLODdTVmhRRk5LSEduNzhLMkQ2?=
 =?utf-8?B?TTF1Y21KWENGYTcwSWl2WUYrQ2JwNWEzRkttYmF5ZUZON0kzbnFyd0wzVnN0?=
 =?utf-8?B?Yms3c1lXUWNGK1ZjMXFRN2o3RTRTYjZTaVA1MXljVFhlaVlaMSt4WnlnZGhE?=
 =?utf-8?B?d01STE9MY2UycmZRN1d1VVdRaDVoQnpxa2dDSWM2RGE4eUdMdkVIeVBTRFVt?=
 =?utf-8?B?dmFZYS9EWFhGdmlUWmtHb0M3UHB6Z1ZCYS84S3ZibGFaSnpsUTUvdEs3NmZI?=
 =?utf-8?B?dkxvYmhsZGE2ZlphOEIxT09ya05oTHFYNFJIalFHcm1IZGZOL2xDYXdMZEg2?=
 =?utf-8?B?RG0xUGVBQ1Z3Mmg5dmMvUG93RlIxU09DZ0pseUJ4Nm1sT2FVZjlFSDdaZXBB?=
 =?utf-8?B?cERMR3orNlMwVXJ4Y1U2K01ZbHBwYUV1SS9YVFptU0phSlUxUHNJUUhlUUxw?=
 =?utf-8?B?T1FMMS9ybmJibjhYRi9PcFVORXhwaHdscEtxTGpxdlZxR1h5cisxS0VaNGpw?=
 =?utf-8?B?aUZUTHFFZ1ZhRWM2SjVMZHNRMktNV21ZNHI2L25EaWI2cUNsUWptcjVTUkkz?=
 =?utf-8?B?QnVJZ3IrYzczK3g0OXZCTW5Hc1I2bEI0cXRjZ0FDYzlDNEs5bDhQOEQwb2Jj?=
 =?utf-8?B?UXYyZm1MQmpUbUJueVRUOG9qc2lodU4rVzV1cHR3T0dBTHRqMHJYS2ptSkJS?=
 =?utf-8?B?Wis2UjN5aVRBSVRyRnpMcGR1ZG42K0VlZUt3aEYyTzdLSnUzL0NUcGEzeC9Y?=
 =?utf-8?B?WWZLTmQ0WHVmUUppN1g4cEpvM0pEcmszS1UzVERmSzdYRmVINkthWUFVT0Jp?=
 =?utf-8?B?WDNTQzk5YTVhc3k2V3BEdnU2Smp2Yi9kOGpyS3g5TncvTnJ3eUd6NDFtNHB3?=
 =?utf-8?B?UndqbEtlUU04SFBTQmxHaEpxMVRESWozQkY4YjUxMWdaMW4ySUN0QTFhSWp2?=
 =?utf-8?B?a0FvMjZmakpJVjVwR3JYVmhmTHBKbkhQL25IeEQrUGJHRzMwTmpKVTR0QVll?=
 =?utf-8?B?N0V1ZUY1R0UrYlF6bVBwNmJqZzliakdoTlFKY0JxSkY1WlB1WGFuS0xCeVlw?=
 =?utf-8?B?RVJyMXRoZ0ZobmRNZ2FiNXh6T0dmeWRrNlJaQllJS1pBUndWb01GVW5hdXlr?=
 =?utf-8?B?c2hmQy9FRW13cU1uMGVLQU43ZHBUTFlKQ005a3Y4RHovOU1LL0FXSTBtYTV2?=
 =?utf-8?B?T09iaXJmLzZSTWx5SUJBNUhaYko0b005VnI5Nms2dTZpdlBLVU0rVjNZdWND?=
 =?utf-8?B?bHJsTEk3cGR0eDJMWDFqNEtEelY3YjBkb1p5Tm9jOXE3MHpyNmIyQjdHVEo2?=
 =?utf-8?B?dUZTT1psSkNGcW93enZwMnZPS3B5czZUcklSMm4vTXBiOHhaTEU5ZUhWTnRX?=
 =?utf-8?B?V0xVeWRHbWI1dDB3R09QVHV0S2lJVnUyNFFDbDZXek5nSkpnR1pRbnh5TFFl?=
 =?utf-8?B?ZkZYWTJQSmo4WFZYMTJ0Q01BcTdlTHh3MTBDNUR1OFp1VHNaQzlWLzc2S01r?=
 =?utf-8?B?dGJ3NVJBWm9XUG5tdC9TVjVMWnRlYnhlV1VNMkVUeFlZQnE0aTJIdnAwTlpv?=
 =?utf-8?B?WmlYMHh1YytGVE9jdkplYVpXRkRGMHU1citvRnFqd295b3VKc3ZCd3pjay8w?=
 =?utf-8?B?d2ZmdTcwVDFlMTNDTitOSHNVV1dGYmE1bUhoS05WNW5pdmJiOGUwSXcwOFZ5?=
 =?utf-8?B?aUhBZjlobjZqOU5iU25nR091OVFNbyt3REREcjlIa3FOQjI5S1NBbGdPbEt4?=
 =?utf-8?B?KzZaOHpJamVQeHZNZ0V4WmwwaHlYNUpyZkdVZVI3dTdibFcxb3ozd2pSRGJP?=
 =?utf-8?B?YnV4bitXWHVXUGRHZHVLMHk3ZTdaUU9NTDZJR2tCWS91enNCdUNJOW05Yk5y?=
 =?utf-8?B?UXNPVGIzUUdWcmpxVjJUaDl2WGpOZ0ZnZDRZaElRczNYaGNUQUxxQnI2ak1o?=
 =?utf-8?B?MDRwWkk0RmRZWWFoc1hlWTEyelBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(34020700016)(36860700013)(4053099003)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:10:42.1206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e52872c-0b8c-4d71-ceff-08de54df1fde
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4747

--------------k2i5L1OcZpV0Smrn0fCs0pDH
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe,

Sory for adding another reply on top of my latest reply.
Just wanted to add a couple more things;


On 16/01/26 14:11, Gokul Praveen wrote:
> Hi Uwe,
> 
> On 15/01/26 22:47, Uwe Kleine-König wrote:
>> On Thu, Jan 15, 2026 at 04:02:16PM +0530, Gokul Praveen wrote:
>>> Hi Uwe,
>>>
>>> Apologies for the delay as it took some time for me to get the trace 
>>> output
>>> as well as to get the way I reproduced the issue.
>>>
>>>
>>> On 10/01/26 04:23, Uwe Kleine-König wrote:
>>>> Hello Gokul,
>>>>
>>>> On Fri, Jan 09, 2026 at 11:21:46AM +0530, Gokul Praveen wrote:
>>>>> On 08/01/26 23:40, Uwe Kleine-König wrote:
>>>>>> On Thu, Jan 08, 2026 at 12:10:35PM +0530, Gokul Praveen wrote:
>>>>>>> On 08/01/26 01:17, Rafael V. Volkmer wrote:
>>>>>>>> Thanks for CC'ing me on this thread.
>>>>>>>>
>>>>>>>> On 07/01/26 15:21, Uwe Kleine-König wrote:
>>>>>>>>> adding Rafael to Cc: who sent a patch series for this driver 
>>>>>>>>> that I
>>>>>>>>> didn't come around to review yet. Given that neither he nor me 
>>>>>>>>> noticed
>>>>>>>>> the problem addressed in this patch I wonder if it applies to all
>>>>>>>>> hardware variants.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I also didn't observe the issue described here in my testing: 
>>>>>>>> duty cycle and
>>>>>>>> period changes always appeared to take effect as expected.
>>>>>>>>
>>>>>>>> My tests were done on an AM623 EVM.
>>>>>>>>
>>>>>>>> One possible explanation is that my test flow mostly exercised 
>>>>>>>> configuration
>>>>>>>> while the PWM was already enabled/active, which could mask the 
>>>>>>>> effect of a
>>>>>>>> put_sync/reset happening after configuration.
>>>>>>>>
>>>>>>>
>>>>>>> Yes, this is the reason why the configuration was taking effect 
>>>>>>> for you ,
>>>>>>> Rafael, as the PWM was already enabled when setting the 
>>>>>>> configuration hence
>>>>>>> masking the effect of a put_sync/reset happening after 
>>>>>>> configuration.
>>>>>>
>>>>>> Can you provide a list of commands that show the failure? That would
>>>>>> result in less guessing for me. My plan is to reproduce the failure
>>>>>> tomorrow to better understand it on my boneblack.
>>>>>
>>>>> Sure Uwe. These are the commands I have tried for PWM signal 
>>>>> generation:
>>>>>
>>>>> cd /sys/class/pwm/pwmchip0
>>>>> /sys/class/pwm/pwmchip0# echo 0 > export
>>>>> /sys/class/pwm/pwmchip0# cd pwm0/
>>>>> /sys/class/pwm/pwmchip0/pwm0# echo 10000000 > period
>>>>> /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
>>>>> /sys/class/pwm/pwmchip0/pwm0# echo "normal" > polarity
>>>>> /sys/class/pwm/pwmchip0/pwm0# echo 1 > enable
>>>>>
>>>>> Once these commands were executed, I measured the PWM signal using 
>>>>> logic
>>>>> analyzer and the duty cycle was 100% even though we had set 30% 
>>>>> duty cycle
>>>>> through the sysfs nodes.
>>>>
>>>> After that sequence I "see" a 30% relative duty cycle on my boneblack.
>>>> (With the follwing patch applied on top of pwm/for-next:
>>>>
>>>> diff --git a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts b/arch/ 
>>>> arm/boot/dts/ti/omap/am335x-boneblack.dts
>>>> index b4fdcf9c02b5..a3f4a4bb64e4 100644
>>>> --- a/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
>>>> +++ b/arch/arm/boot/dts/ti/omap/am335x-boneblack.dts
>>>> @@ -173,3 +173,25 @@ &gpio3 {
>>>>    &baseboard_eeprom {
>>>>        vcc-supply = <&ldo4_reg>;
>>>>    };
>>>> +
>>>> +&am33xx_pinmux {
>>>> +    ehrpwm0_pins: ehrpwm0-pins {
>>>> +        pinctrl-single,pins = <
>>>> +            /* P9.21 UART2_TXD -> ehrpwm0B */
>>>> +            AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT_PULLDOWN, 
>>>> MUX_MODE3)
>>>> +            /* P9.22 UART2_RXD -> ehrpwm0A */
>>>> +            AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, 
>>>> PIN_OUTPUT_PULLDOWN, MUX_MODE3)
>>>> +        >;
>>>> +    };
>>>> +};
>>>> +
>>>> +&ehrpwm0 {
>>>> +    pinctrl-names = "default";
>>>> +    pinctrl-0 = <&ehrpwm0_pins>;
>>>> +
>>>> +    status = "okay";
>>>> +};
>>>> +
>>>> +&epwmss0 {
>>>> +    status = "okay";
>>>> +};
>>>>
>>>> )
>>>>
>>>> That makes me think the problem isn't understood well yet and needs 
>>>> more
>>>> research. @Rafael, does the problem reproduce for you with Gokul's
>>>> recipe? (Or did you try that already? I understood your reply as "I
>>>> didn't encounter the issue but also didn't test specifically for 
>>>> that.")
>>>>
>>>> As I cannot reproduce the issue, can you please check if adding
>>>>
>>>>     pm_runtime_get_sync(pwmchip_parent(chip));
>>>>
>>>> to the probe function makes the problem disappear? Also please boot 
>>>> with
>>>>
>>>>     trace_event=pwm
>>>>
>>>> on the command line and provide the content of
>>>> /sys/kernel/debug/tracing/trace after reproducing the problem.
>>>>
>>>
>>> PWM EVENT TRACING OUTPUT:
>>> =========================
>>> # tracer: nop
>>> #
>>> # entries-in-buffer/entries-written: 3/3   #P:8
>>> #
>>> #                                _-----=> irqs-off/BH-disabled
>>> #                               / _----=> need-resched
>>> #                              | / _---=> hardirq/softirq
>>> #                              || / _--=> preempt-depth
>>> #                              ||| / _-=> migrate-disable
>>> #                              |||| /     delay
>>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>>> #              | |         |   |||||     |         |
>>>        gen_pwm.sh-1039    [000] .....    88.564669: pwm_apply: 
>>> pwmchip0.1:
>>> period=100000000 duty_cycle=0 polarity=0 enabled=0 err=0
>>>        gen_pwm.sh-1039    [000] .....    88.564728: pwm_apply: 
>>> pwmchip0.1:
>>> period=100000000 duty_cycle=30000000 polarity=0 enabled=0 err=0
>>>        gen_pwm.sh-1039    [000] .....    88.565065: pwm_apply: 
>>> pwmchip0.1:
>>> period=100000000 duty_cycle=30000000 polarity=0 enabled=1 err=0
>>>
>>> The trace output might mislead us thinking that the duty cycle is set
>>> properly as the event tracer reads the duty_cycle variable which gets 
>>> set
>>> irrespective of whether the value gets reflected in the pwm registers or
>>> not.
>>
>> Can you please also enable CONFIG_PWM_DEBUG? That should show the values
>> actually used as it enables a few calls to .get_state().
>>
> 
> It is the same event trace output as given above, Uwe.
> 
> Additionally, adding this config did not show any additional logs as 
> there is no ,get_state callback implementation in the TI EHRPWM 
> driver(pwm-tiehrpwm.c)
> 
> I also confirmed the same using the below dmesg output:
> 
> [    0.484725] ehrpwm 3010000.pwm: Please implement the .get_state() 
> callback
> 
> I believe dumping the registers and capturing the signals using logic 
> analyzer is the best way to reproduce this issue, Uwe.
> 

I have found another easier way to show this issue by enabling debug 
prints, Uwe. I have attached the patch for the 
same(0001-Debug-prints-to-check-if-period-and-duty-cycle-is-re.patch). 
This patch basically reads the registers and prints its value.

So, after applying the attached patch and running the following 
commands, I got the following output.

Commands:

 >>>>> cd /sys/class/pwm/pwmchip0
 >>>>> /sys/class/pwm/pwmchip0# echo 1 > export
 >>>>> /sys/class/pwm/pwmchip0# cd pwm1/
 >>>>> /sys/class/pwm/pwmchip0/pwm1# echo 10000000 > period
 >>>>> /sys/class/pwm/pwmchip0/pwm1# echo 3000000 > duty_cycle
 >>>>> /sys/class/pwm/pwmchip0/pwm1# echo "normal" > polarity
 >>>>> /sys/class/pwm/pwmchip0/pwm1# echo 1 > enable

Output:

Before put sync: Period:65103, Duty cycle:19531
EHRPWM enable function: Period:0, Duty cycle:0

This indicates that the duty cycle and period is not reflected.

Sorry for posting one reply on top of another, Uwe.

Best Regards
Gokul Praveen
> Best Regards
> Gokul Praveen.
> 
>> Best regards
>> Uwe
> 

--------------k2i5L1OcZpV0Smrn0fCs0pDH
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

--------------k2i5L1OcZpV0Smrn0fCs0pDH--

