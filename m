Return-Path: <linux-pwm+bounces-7904-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7FCD22EA3
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 08:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA1A93051E80
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F852DECA8;
	Thu, 15 Jan 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JRnuxmlH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazhn15010017.outbound.protection.outlook.com [52.102.133.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7B119D093;
	Thu, 15 Jan 2026 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.133.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768463214; cv=fail; b=WM3qFasnp5/pUo8VOCbBuAP+0glgAUGGiS3JBXhvUBXQ85Vp2CO2+q0AsiU+MUNJdGr5C22xyR6DEQyMFc2K14BsolJ1vc1lq5yFW32v/E4RireleK3EiUmMYeauuPgZh/F/3d9jt+klCdQstlthCJOR5zkzXSXW27SeZO+WAd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768463214; c=relaxed/simple;
	bh=QQokLzWely0tarYyenHjQUuAkWOjK217KQQPmaBx/AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JYqr1/TbEx98Chf8Wv+B85GazmLV8PB6DidJ9G698zJwtSp/v2u3RBoBYCfUpAM5t8NUkgEKbOu0x8AbzF4TzT83IQHIq/XEy+lGY9Q9YvIlEIV0bdO6/vxpTLBAIXhZIgcCx+DSJW+ldbs7eXyRdPdRgkskLqtZecGm5qoxLO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JRnuxmlH; arc=fail smtp.client-ip=52.102.133.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhRosseFASOWoCb8Hn9KRH8WWnDq5NDVUGegwQIoA47vD4t44YeV7FfBMA0XaezjVaLqpjv+KfkyBAv5/5A90ukXovc/TELWeQxtWMDq/+jcYgAU7/bscapK+TdEeqFqgZBxl+FRBngw56IQ8XCtfZLMI5afTBVX7ADzoEP2FmOIvvUC0hUE2Eubsru4OlIOoAh8MfJLB1M9VLuUERDAxM1DNidkzdl1tXLr+ZOjWAM4jxIOOudMGzlZ46MDefb+bNsEEND3LGR/JqqUJj7i/hQdEVdGJp+HwgrJEcnzgoraXNKWG03h2vYLIbIihLSUASnCdfIzmVH05a0jhzkxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5J5IqAyUAKVpj8K4wLogbTcqizm4ROKcCG0LyNcZ1Y=;
 b=ci3gNCc8RN5pjTJpLZZ37a5QgArZ8Eata7GlX3qt4894Q7FvcdkEF5ZeAqSBihXmhoyoIXSCbNjC4tuZBfgvgSUVAbDoBTqwi6B83POD868SwEVgji/mxWWtwkjwMJKMXCjAzQhlbLmeFObsGo9CSS2iJ/tt3bF0Cqz/jVfXw6MzHuHFDTYN2c5u8m5dlWFuj2vOyV01LkWTHneQn7z8pH3gTl54Y9pP1oXJUZEp0F5nyFiqL16T9UeD1IxQ1xRLjz/71oetoH18csTX95/uoJTV7fLqfA9fgzbCF0dhYCcl/pYXhn0knQCa9VE91acjgmKfyQK73tjackzqYzwGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5J5IqAyUAKVpj8K4wLogbTcqizm4ROKcCG0LyNcZ1Y=;
 b=JRnuxmlHGVaPwDpKmjSIZeb6t+D7im+h8Z7TO3P1zGRKGFegVv5Wlfj9zUWDauap+omzVJTTCnyYlglArOOXy4JMyulR0a5ii7ZQubdZXY36Txy2gTHTPVm01EfMmD+kLY508L1aNSxnQcsq2gOZ/uPwQsPmmWecWeBYOukQz8Y=
Received: from DM6PR18CA0028.namprd18.prod.outlook.com (2603:10b6:5:15b::41)
 by CO6PR10MB5649.namprd10.prod.outlook.com (2603:10b6:303:14c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 07:46:50 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:15b:cafe::be) by DM6PR18CA0028.outlook.office365.com
 (2603:10b6:5:15b::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Thu,
 15 Jan 2026 07:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 07:46:49 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 01:46:49 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 01:46:49 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 01:46:49 -0600
Received: from [172.24.31.151] (lt5cd2489kgj.dhcp.ti.com [172.24.31.151])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60F7kkDe1204456;
	Thu, 15 Jan 2026 01:46:47 -0600
Message-ID: <2ebce2e1-48d1-4d14-9772-b01d7f388641@ti.com>
Date: Thu, 15 Jan 2026 13:16:46 +0530
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
	<n-francis@ti.com>
References: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
 <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
 <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
 <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
 <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
 <85d941a6-9c57-45f3-ab6a-33ca91cf05a5@ti.com>
 <3527b094-5b39-473a-afc1-cfca7baeb3d1@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <3527b094-5b39-473a-afc1-cfca7baeb3d1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CO6PR10MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d576cad-f357-4b09-a221-08de540a3dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|34020700016|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUY2dFQxVzJQNm5oUC84QmpBdEo3N2FwY29lOGdtdkxZVi9VNjNBcHRKQzBl?=
 =?utf-8?B?ODZta1BIb1pBSzE1VnpYVmdxV3dvZlcwZzNyclF4ZXE1WmdqMGswREl6RVVE?=
 =?utf-8?B?WW9nMllZS01rbWl1VGszR0ZvZVk4UmpNbGNjc2NLNEIrSHFBTUIvUGxIVmVI?=
 =?utf-8?B?ZjdoNGlWVjVzTzg4T2Y5UVdkcElrb1l2NDRyYlBWcFdROGR1RkpjU3FjSnAv?=
 =?utf-8?B?UkZzaThOMThaMFY5ZVZpWlZFTjlycXQxSUhjbSt0UTByV1ozT3dNNFhJVFhW?=
 =?utf-8?B?WmhZRm96RU56MkEvaEdmdUY1Nkc1d2NmelcwaGFkQTFlaERaQnV5L1dhWkhn?=
 =?utf-8?B?VXpzdUkyMHEvMU5qbFc1RFVwcHhkdVd0TE1OQVh0cDJIa08vSzJJeWowQlhP?=
 =?utf-8?B?dDNxbklJQkhzNDZVbEZFUm5jOHdDVkw1T0o5eTVwbTlkSHhQbWY3bjdmODJr?=
 =?utf-8?B?b2EzK2grcFlxWGwvajh2M2RpaThnWTlqaGNnSmJMZnM1RlFZZTArNTRDZjcv?=
 =?utf-8?B?MzVUZXVVWTVwNVdkNmpmZ1BrT0swVm9BbDFzRm9OeStBRCtOcHQySEg4Qm8x?=
 =?utf-8?B?M1RQaUYrcTNQbUhoblBHd3U5ZjQ2S2NYSnZDd1dGQUdKcWhicFU0QnBSejZZ?=
 =?utf-8?B?VEdmN3lYZi9OWlJBVGZ4OHhraW1vbDlFZ0FxdGRUVkRHNmZmVWVGVVBqZG91?=
 =?utf-8?B?S0dXL3BLMitKTFg3QUJ2VG1GZys1VzhYY0Z5OCt3MXNmZ3FEQ3FRR2ZNMmRG?=
 =?utf-8?B?bTFuQ25NQ282djRCTGZqNTRndHpVd2VPUlAxK1BId3R1OFh5TmcyRHR3TGp1?=
 =?utf-8?B?UmMzeEZvTHM2NTlrTkp4RkpUS3lCck1yd3JPTm1pM2NxSkgvd2hBdlpPU2xN?=
 =?utf-8?B?TmR3ZVQyZ0pYc1RqQ2FTd3k0KzJtOTBXTWVKK3FNaWZoU3o5c1VsSm1VVnow?=
 =?utf-8?B?YVJqa0ErRUdKTG53cm5rNUpXSVExSHhnaEY2bjUycVFYc1c5blRwQmdVR1RL?=
 =?utf-8?B?TCtlWXlrOEpocU44TW8xTkZsZ3plYlJhZ3VHaFg4NXNuVkYrZFZ3MElqRCtK?=
 =?utf-8?B?dk5tZVRmWWxlY0haQWFDZ2lYT2hMRk1nVjQ2Y2dkYnBabEE1blVYRkR6LzBK?=
 =?utf-8?B?VlBGUmZlcmxjQ0tOTk5waG1YeENNcTJ2dDJoazRJRHZGWHk4NEgrUUZjdFNl?=
 =?utf-8?B?T0MrRGMybHlFbW5DMHRUelFHYlFlS3NGVnN2ZnBBRld0aHA0ZUpzVHA0Sm5k?=
 =?utf-8?B?dVJwamV4RDFvVkliYzFoR2dBL29MN3o3SzdQR3dOcXl2WGFBR3lsTW40V1cy?=
 =?utf-8?B?NEtlaUtJSUNuRzhIUGRQajlQMVcyL3lVNFdxQ2cwSmJFaW5yMEErV2svaGFm?=
 =?utf-8?B?dVA5OFYrVHJ5QjJ0TFczcDRrTUtneHlrQUM4WG00OXArbnlnMUNvZ0k3VUFL?=
 =?utf-8?B?LzJUTXN6b1Jhcmx2RzFVQW9CWCt5ZTdxeGtkTWJaM2ZudEd6Z1hEdGc3RTJG?=
 =?utf-8?B?ZHNqeit2NEdKK3B3ajY4M09adkZxbEdHVk4wTEcrazg5a1RSOXcrMHNlRkhT?=
 =?utf-8?B?NFRnTk1HS0JSQzZ6VkdPa0dVcXljV0RtRm8rWUxxMXhRRzZCMnVQVk1ORm1S?=
 =?utf-8?B?MVZoVDdDZk4wUVRiV3ZxL1ppdllhczhzVnE5SGR4OSsyQy9oeWxxWC90MXhZ?=
 =?utf-8?B?cWlXZkc2cy9GSlY1aFpPejdRVmNLZ2V3QzRKcUZBeTJqNUhjY3RjZzN0clo3?=
 =?utf-8?B?K2ZBeXM0aEpkZ2FsV0M5ODQ5NDBmMzdxbUQvSko2emt2ZkVNZjNsVUIyNmhW?=
 =?utf-8?B?ck5CSTZiNnpFOFNudys2dmRFWG1xbElhK3JNSGJxUXltY2l6alVWNmt5U2pH?=
 =?utf-8?B?NzJGUy9aZU8vb3Zrd1VJSVBkL3lJMkRXdWJVdGNzellMUnhEMXpkbFY0emFU?=
 =?utf-8?B?Z05vRnFVOWo4WFhVdkpFdnVRS0VMalp2b09UZzU1SVJxejdja1VVamlSSUJx?=
 =?utf-8?B?R2FIb1hoOEk5Vnlmd1lUM0JwdUhSM3J0b2xPZ0pXNU45S0tZc05PRUVEcU9o?=
 =?utf-8?B?YkloTE1OSTRJZklydGlrcUtseXRQUmgwSS9CQ2JwQnNETk1GQndkS2h0aE8y?=
 =?utf-8?B?N1FvUXVYUWVJaUFQbkVkVmoyUGo5Y0ZZMzFpNkkxWjlHeDhhS0dLb2g0ekdQ?=
 =?utf-8?B?ZHJIQUNoN2FqYUtPNW1QM3UyU0wxTVFxV2xCKzZWQ1p3cUJkM1JmQnVZcFlI?=
 =?utf-8?B?Z211NFJoTDZscnUrT0xDdStOYnF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(34020700016)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 07:46:49.8626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d576cad-f357-4b09-a221-08de540a3dfc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5649


On 1/15/2026 11:44 AM, Gokul Praveen wrote:
> Hi Udit,
>
> On 15/01/26 10:50, Kumar, Udit wrote:
>> Hello Gokul,
>>
>> On 1/9/2026 11:21 AM, Gokul Praveen wrote:
>>> Hi Uwe,
>>>
>>>
>>> On 08/01/26 23:40, Uwe Kleine-König wrote:
>>>> Hello Gokul,
>>>>
>>>> On Thu, Jan 08, 2026 at 12:10:35PM +0530, Gokul Praveen wrote:
>>>>> On 08/01/26 01:17, Rafael V. Volkmer wrote:
>>>>>> Thanks for CC'ing me on this thread.
>>>>>>
>>>>>> On 07/01/26 15:21, Uwe Kleine-König wrote:
>>>>>>> adding Rafael to Cc: who sent a patch series for this driver that I
>>>>>>> didn't come around to review yet. Given that neither he nor me 
>>>>>>> noticed
>>>>>>> the problem addressed in this patch I wonder if it applies to all
>>>>>>> hardware variants.
>>>>>>>
>>>>>>
>>>>>> I also didn't observe the issue described here in my testing: 
>>>>>> duty cycle and
>>>>>> period changes always appeared to take effect as expected.
>>>>>>
>>>>>> My tests were done on an AM623 EVM.
>>>>>>
>>>>>> One possible explanation is that my test flow mostly exercised 
>>>>>> configuration
>>>>>> while the PWM was already enabled/active, which could mask the 
>>>>>> effect of a
>>>>>> put_sync/reset happening after configuration.
>>>>>>
>>>>>
>>>>> Yes, this is the reason why the configuration was taking effect 
>>>>> for you ,
>>>>> Rafael, as the PWM was already enabled when setting the 
>>>>> configuration hence
>>>>> masking the effect of a put_sync/reset happening after configuration.
>>>>
>>>> Can you provide a list of commands that show the failure? That would
>>>> result in less guessing for me. My plan is to reproduce the failure
>>>> tomorrow to better understand it on my boneblack.
>>>>
>>>> Best regards
>>>> Uwe
>>>
>>> Sure Uwe. These are the commands I have tried for PWM signal 
>>> generation:
>>>
>>> cd /sys/class/pwm/pwmchip0
>>> /sys/class/pwm/pwmchip0# echo 0 > export
>>> /sys/class/pwm/pwmchip0# cd pwm0/
>>> /sys/class/pwm/pwmchip0/pwm0# echo 10000000 > period
>>> /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
>>> /sys/class/pwm/pwmchip0/pwm0# echo "normal" > polarity
>>> /sys/class/pwm/pwmchip0/pwm0# echo 1 > enable
>>>
>>> Once these commands were executed, I measured the PWM signal using 
>>> logic analyzer and the duty cycle was 100% even though we had set 
>>> 30% duty cycle through the sysfs nodes.
>>>
>>> However, with the below command sequence, the duty cycle was getting 
>>> set properly
>>>
>>> cd /sys/class/pwm/pwmchip0
>>> /sys/class/pwm/pwmchip0# echo 0 > export
>>> /sys/class/pwm/pwmchip0# cd pwm0/
>>> /sys/class/pwm/pwmchip0/pwm0# echo 10000000 > period
>>> /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
>>> /sys/class/pwm/pwmchip0/pwm0# echo "normal" > polarity
>>> /sys/class/pwm/pwmchip0/pwm0# echo 1 > enable
>>> /sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle
>>
>>
>> I don't think , this last call of setting duty_cycle , even will land 
>> in driver code .
>>
>>
>>
>
> Can you change the last command to the following. Ideally , it should 
> be a different duty cycle set to enter into the driver code.
>
> >> /sys/class/pwm/pwmchip0/pwm0# echo 6000000 > duty_cycle


Yes it will leads to entry into driver code.

But between below calls, (enable and set duty cycle again)

/sys/class/pwm/pwmchip0/pwm0# echo 1 > enable
/sys/class/pwm/pwmchip0/pwm0# echo 3000000 > duty_cycle

I don't see ehrpwm_pwm_disable will be called.


>
> Best Regards
> Gokul Praveen
>>>
>>>
>>> PWM is working only if we re-update the duty cycle after enabling 
>>> the module.
>>>
>>> If we do not re-update the duty cycle after enabling the module then 
>>> PWM signal line is being high(100 % duty) always.
>>>
>>> Test Environment: TI J784S4 EVM board.
>>>
>>> Best Regards
>>> Gokul Praveen
>>>
>>>
>>>
>

