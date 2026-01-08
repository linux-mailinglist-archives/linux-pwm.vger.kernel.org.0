Return-Path: <linux-pwm+bounces-7873-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36015D01437
	for <lists+linux-pwm@lfdr.de>; Thu, 08 Jan 2026 07:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E251302D5C2
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jan 2026 06:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05BB33CE86;
	Thu,  8 Jan 2026 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A/F7swDf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azhn15010055.outbound.protection.outlook.com [52.102.136.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B160F2620DE;
	Thu,  8 Jan 2026 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.136.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854461; cv=fail; b=YhbzX9eBIRKkdRo1VNpnt3cuLr5Q3nmSP7aTGhenfD47ESmZHx8Df7J4uzWwqlkLB5V70rYWUg3vceL8yic/Aggv74rQUH8vJpAwHEv7xlUSUY/QeUSer6ethOzK047UMxZuc6ruEsWGhXmqVJYBG+tUJBShugdoyq2n0eeLEXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854461; c=relaxed/simple;
	bh=+PHcCdHD4CUWnAQL5R134g9H9JpKByIaQmNv8K2usNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mW4pwmqBAPHz7b6JcK/DAhPU34LWeBMicoF4rIY8GM15a7KvEQVD16fZrAU1NkEXRxaO+bxzutdP4h8RYgL8oMFP+dNHbBvAmu6qVTLfOkSURlwNj4nYWEWwDf/E+3YN6o1/l4bUtQSbIU41hNnrtnxOYI/mmYrNb53HCY0mFdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A/F7swDf; arc=fail smtp.client-ip=52.102.136.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRjY5yLJlpgVdtwzpDNDRcMVIFexKGq930D+uxG0s8YelhtIphwmmvaPxTQskBoL+Fy+1QIsMcBxdf5mMmgJ93qNBFSycpjLgehmH/lEeXk9hxm2xo9dxJZUGdIk4rFiTBuwBm3Jj0Wrv8nVuirJRHjpGf2PQLVmfZ3jwrkpBtq+Lac57+k3wEEMcraEhW9E3e0Qv7Jmby533KcuaV2U9T13UCBcIWtWjhOeIm4LwUm/NO7xrVl6vpU2u0kh3zaE6cbdyKqWdvLQyoccRSaHrcXIiDKXwT/uWeYvp/DVbJgEp9vy7U1jUCNb9Oy45+/8j5zXdrLQqpPE+dptRG6h9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYDYT0vUFsASXvqs6ccbOcppzq4m1xMcZdQPCaZF96k=;
 b=BYJ+jcV2G+EC6fUsEcEnbKS2IKwTlFINx1zVpapwwJE5ox6XUl0udQe6B3ZdpWeZHSAV8lb/P5Jea1a2OKufylopgz4e/wm7D2IrdVQ12mL74bpiCCl5hF01pJfeKLoWYuJCcTmp5RW2SJWQLXpZnkQwwULHkarJebytqJvDUgBLjlp33kxB+0DN4jL973TtsgElXDtHRcHNFZ5B8RFImZbEbCZHl4eGDGhQuzLY8/N/NHzwjXgh3dSAV4bsS4yAFcLKgq46ljRKuE1yamz/6zBpy4ltyJajVJ2cix6JMzDHUiAYzVZbNH0JzZJWeaiPV78R/61fMi8sgYnVq7xFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYDYT0vUFsASXvqs6ccbOcppzq4m1xMcZdQPCaZF96k=;
 b=A/F7swDfPSiFDoqGPQxoG6BCRzcdKZle4JyBlWnD5LRlmcXC8FnxgaCykOz/1mFA/xlR+ows6b4upt3jSXreNeP6XL8b1Sga4HHvSCNq7Du1rBR2yZbY7UwdzvSyD6ttPazQ9+CNjjJFTbUZ97H5qGseG9i/UGFl2EapYeohMIc=
Received: from PH7P220CA0127.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::7)
 by MW5PR10MB5873.namprd10.prod.outlook.com (2603:10b6:303:19b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 06:40:48 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:327:cafe::18) by PH7P220CA0127.outlook.office365.com
 (2603:10b6:510:327::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 06:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Thu, 8 Jan 2026 06:40:45 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 00:40:38 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 00:40:38 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 00:40:38 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6086eZ5I1923924;
	Thu, 8 Jan 2026 00:40:36 -0600
Message-ID: <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
Date: Thu, 8 Jan 2026 12:10:35 +0530
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
References: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
 <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MW5PR10MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 0871842b-03ff-431b-f9d3-08de4e80d9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|34070700014|376014|34020700016|36860700013|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amNMYjBQY2JnSHJ2Wisvb0FNblNiaHA1aE5wc3Z6a2Jhb1ZxcEtjM295Sm14?=
 =?utf-8?B?cEJKblg3VDlmbXM0VGk5TVhMWEdwbmlnbFBhQncvMkRLSEYrdzlUVlVvQldE?=
 =?utf-8?B?dFpLVmdRUjByMWNuRUFrTnljZzRVcmU0MVRIQ2tRTGRRT2Y5U043QWxuTnBz?=
 =?utf-8?B?NGY5MjZlZHBiRW1uWDhrb1I5VWlDZE5HNkozYW1pQUJ1dDdBV3pQOGd5ZFNv?=
 =?utf-8?B?N3RBTkx4a25rdnI4NU10aHJDd0o3T3ZFT00velZabzhaS1FoSUIxRUIxd05q?=
 =?utf-8?B?dk0yaFNtNFZTck1CNXgyeE01ekpOTXM1cm5kQm01RVI1TFJIaHZzNEowblBs?=
 =?utf-8?B?b0NsYlhYSXBDeDJVOEdLaGdsNzVjNEtrblg4ZzZOeGw0T05zRXpSN3h4N0Nv?=
 =?utf-8?B?SlhjM0VKVFlqOFpIYlhQbWxXOWVFdDBaZ21hUWVrRFMybDFJNGFEMWZHcEdk?=
 =?utf-8?B?cWIrbVRsQnJpMUU5eElOY0hxeW5NY05UalJ3MlpHM2ZQeTgycWl1YjBadDQ4?=
 =?utf-8?B?REx5cU0wcmQyUVd1QnZ6ZWRLVExqTjR3K1J0a3hFaGR5MVlEVmRXY3JjT1Yv?=
 =?utf-8?B?Y2ZCS1JpM3UxSUpvWHRwY1NHQXFYRUJYbnBsUzA1UjZlSHBiN2dHdHp1R3o0?=
 =?utf-8?B?VExvSFdwYVdpRDJLMFVCZktOQlE3VVZFZDhnMDRZOG9UQjFoQjFNNkh2RUZ6?=
 =?utf-8?B?cUlrNzZtbTRsOWRvdW5sRElpODZianFNQkhnSnFvVStra0prYlk0QmxZMm04?=
 =?utf-8?B?cVdXekUvVHRwOTBqRUJBd2cyUDhuZFlqanFsVDNwcEswUit6ZW5TT0ZEUTVI?=
 =?utf-8?B?Z2h3azBIanJtSG03T1FFSXMvMTh3SjM5b2lXeDA4SGJJeW9jdk9aam42WmdW?=
 =?utf-8?B?MmRReDVobHlXa05HMjlVMkRLbVI5Q2xsUjFQN0VRS291ekpUZ2NnSXExaGdH?=
 =?utf-8?B?cW9aWGlCL0xnbFBENmF6N0hQOUNiYVJ3WU51MkE3ajdTb29nT3BkVVhRWkpn?=
 =?utf-8?B?TnBBdE93TVhpemlSNVI0WmtJU0pud0tUYk00OFp6d3BvaFZFQnlpeFM5T0hZ?=
 =?utf-8?B?WGx3YXd6YkJ2ejNJQzRrNGZsT2Y1TVhyejk3bW55SmlhdVEwN1lMVUUyT2F4?=
 =?utf-8?B?aWs0V0ZtOWMwSzRZY1dyaXRXVWFrY21vS0ZkZkMzeHhkNnVuNk1GS25ZaHVk?=
 =?utf-8?B?d0NmK24xUklGeXZsZkRocnJ4b3RRRkVrOWxXVWVmbWFOZU1tOVFQdjFOdGR2?=
 =?utf-8?B?UlQ3VWpqeUI3aFFkWHQ2cnliY3VrdG1vRUw2V09hc2cvV3ZacWtIQVQxWWdJ?=
 =?utf-8?B?WGhpbzBHS3hoKzhnUGtsUlFGemxpVW5zYlJtNDhKOTRNRkowcDNPNk50Z0pt?=
 =?utf-8?B?c0ZxbjBOU2pKcGJrMEgwSXA5MUdOakpzRXNaVmw4aGVQVnpqYnRobTVJazF4?=
 =?utf-8?B?S2pjVHVaUlRDalRLZmlLTDRPaWVyUEFOcmhwNUkvY25JRzZFc3IzOGNrRU5l?=
 =?utf-8?B?ajdBODJkUkxDekYyVUYvd0tMUytVUWdUbzNHY004NXRrQ0c0RkNJRUd5c29T?=
 =?utf-8?B?R0FLdU5tUjB3WXN2Y1Zkc1hodEJ1OFlnbzROeTRXa2ZCYXMyWkVqMWtYcU00?=
 =?utf-8?B?RXRlNk5jUmlqY3FTenJ2MzdGVVRjaVBBVTBUdGlCcnRlTWMzYy9LMzIxSksr?=
 =?utf-8?B?UzBGdHZiRlA3SG11RGlEbVBlQm1IcEZRbzBmLzUvaGZhOFRKV1NEQ2QrVzZC?=
 =?utf-8?B?L3k0VnRnSHIzQnh3L3ZVekt4ZXlxaDl6aTJ3YlE4RnpmN3lZQzVqVGhBQytJ?=
 =?utf-8?B?R0FieGFrRFhiQmVaTWQ5Z1E3OEVNZTU4WjFwY2tNUFBBVmV1d1R5ZGpCYlky?=
 =?utf-8?B?d1lGTXZjUXJNTHlHcW1jZUZzMlJiejRqOVV0TXBZZUtOQkhhanA5WGlHcGdm?=
 =?utf-8?B?QWZVdkRrMjI1eUF1YnF2d1g3bmFBQjlmY1pCT1VZUWJsTi8zN1owZ1N5dE9s?=
 =?utf-8?B?aWJoeVRpdVRRWGdBWHhYamVva2hxV0NzNTZmcDJZZ3BHNmllNy9qSThnRTNt?=
 =?utf-8?B?V3lzdjBKallnL1hSYkZsNUJDYXdXNnJHMTNOL2w0MGx5elhheTlFQXZJUThI?=
 =?utf-8?Q?uUI4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(34070700014)(376014)(34020700016)(36860700013)(1800799024)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 06:40:45.0971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0871842b-03ff-431b-f9d3-08de4e80d9e7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5873

Hi Rafael,

On 08/01/26 01:17, Rafael V. Volkmer wrote:
> Hi Uwe, Gokul,
> 
> Thanks for CC'ing me on this thread.
> 
> On 07/01/26 15:21, Uwe Kleine-König wrote:
>> Hello,
>>
>> adding Rafael to Cc: who sent a patch series for this driver that I
>> didn't come around to review yet. Given that neither he nor me noticed
>> the problem addressed in this patch I wonder if it applies to all
>> hardware variants.
>>
> 
> I also didn't observe the issue described here in my testing: duty cycle and
> period changes always appeared to take effect as expected.
> 
> My tests were done on an AM623 EVM.
> 
> One possible explanation is that my test flow mostly exercised configuration
> while the PWM was already enabled/active, which could mask the effect of a
> put_sync/reset happening after configuration.
> 

Yes, this is the reason why the configuration was taking effect for you 
, Rafael, as the PWM was already enabled when setting the configuration 
hence masking the effect of a put_sync/reset happening after configuration.

Best Regards
Gokul Praveen

> Regarding my pending patch series for this driver: it should not
> conflict this change, as it's largely preparatory refactoring for a
> follow-up series.
> 
> Best regards,
> Rafael V. Volkmer


