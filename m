Return-Path: <linux-pwm+bounces-7957-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF87D3C278
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 09:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3A794C3403
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 08:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264DF3431FD;
	Tue, 20 Jan 2026 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nwz9OPuI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E0283C89;
	Tue, 20 Jan 2026 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768898092; cv=fail; b=ULb4SBmHT9ULcuW/m705GuDzJ9mNraWagRFF5coRxeFMco9Rs9+NyuIMB0CtBPX+UU5dM+MRGx91UOuVhrYTtt4U1R5uM4G339QwSGiDZkNOI/e+ZxsOqicUzyGQl4INxepytZfxsvQmrvxN93uPIf1sMfgqfRln9rcD/jWrA0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768898092; c=relaxed/simple;
	bh=2o6TKxFO6Tg6QcATUp7CVUh3CM8bM2VIIOgoeYtNtyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oid2fxK9RBtqSrOBSmQzyb2Awre7Z3R6tmfnfj6HBKnrQqX8fJ58kmmEIyOUXjY9UsfOH1eKufwGLmpRGtyO9EEnuiZu/jJY+D6yMlujqS3x597EWRyohpSWN59oMmQ7NBwz3mkxn4nnfEuuSTQ4ijJ+7NQ9CxXYgsX6NydMkH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Nwz9OPuI; arc=fail smtp.client-ip=52.101.61.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkvxzPuI6N0s+ODo5DPa5340X0NN9/NW6ugsIj4WSibrBieIutrcaNQWT/K0dEvobT6bamXkAx9mnXZmZVgVBy5XrSMTFZbIIxJq8KuVl4qYdCj3gXBjioJehAfJ3/1dQRirtljPGl0d5u+TJdaNhCIyb+z6syDKdOXiQ96AXQdWIqg1dT1HzAzN43bvpQFUd4hAc6DkvbsOolUy1q0jUcOGegfuJVSkGC6JB3t1uOd6Z+hmU1lfXepc9LoWyNBCeDT7Fnz7AyHbAa7FJh3v/59/oOYFL4ZRqd3KvZ8L2Ne6eDmckQQ/el4fjjeTo1ybRBLFB719RqGJJ1dmUO25cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJHKSWVZBz7XyvsZZFs6sZTy0Ve2IMkps85jLgFNm40=;
 b=Au5sAu4K8G6t8ZkHfaOuUEEhggZzHmVd5FDIIuw/GPaLJH/iKF91BMnTfnaytgCmTYHve9WoMOwrN4jZIghV+brOyMEtVFg5N3057OIUDwXYf4is53I5fDeqUm8G3Djsr8MzvF2RocUt4Szz6dYj6xvkpugzA2o+ExnzfXZHONjA1evw4k9uzypsgfuU/HByFXM7OBdblOQPulQCKtD9zMCV51yoJrtJAWqrYB1jtS7MPKD2SMb+aQFfv+ivgxGOVCpGd+Laa+93gud8AzKKWpBMu8taw0tDYawDnAJIPDoUQjnIP+60T8Y/aUofzQEaaEQDZ7VdaK1LxZQgx0Aflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJHKSWVZBz7XyvsZZFs6sZTy0Ve2IMkps85jLgFNm40=;
 b=Nwz9OPuIOrrgsOhwD3tngwq/yA0A95GDYvoTTEDAPgEzTXn9/cqYYTMnGyNThhsj1LwdXcvM3gJoCwebVZ94whusmJp56Yr9ot8b0tRn0nP4VNDKVpJNZUoubzkI7hZHPB01JDDvq0YyeG68ghQJsLSvrrUVGDnzhy+RxGDEAiY=
Received: from SJ0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:33a::35)
 by MW4PR10MB6370.namprd10.prod.outlook.com (2603:10b6:303:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:34:47 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::1c) by SJ0PR03CA0030.outlook.office365.com
 (2603:10b6:a03:33a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Tue,
 20 Jan 2026 08:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 08:34:46 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 02:34:46 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 02:34:45 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 02:34:45 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60K8Ygqn767473;
	Tue, 20 Jan 2026 02:34:43 -0600
Message-ID: <e8c7d626-042f-4509-b69b-db83fd70d40d@ti.com>
Date: Tue, 20 Jan 2026 14:04:42 +0530
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
CC: "Kumar, Udit" <u-kumar1@ti.com>, "Rafael V. Volkmer"
	<rafael.v.volkmer@gmail.com>, <j-keerthy@ti.com>,
	<linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<n-francis@ti.com>, Gokul Praveen <g-praveen@ti.com>
References: <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
 <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
 <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
 <xdj2ceubkss3ingkxdvc64zqrcd3wzz2uxa6wqwgvilu2ykukc@hbn6tt2gnxj5>
 <741ec8db-7804-4f31-969b-10724ec06823@ti.com>
 <hvz5lw4xvujmdruoi2h2wk4dvanyg7y5xp5tp2rs4dygmza3s3@idcjbz6wbxh4>
 <29dc86d5-080c-4af2-8e19-99a137c55f2f@ti.com>
 <xkhyvqemt7ox6s3kcwjx2qktwlrvdo2dbn2azlk6tdimjvclky@g3btsovrn5am>
 <80a2c59a-fe7a-4244-a374-bfc70dc46978@ti.com>
 <77e5712b-e1f9-4fb7-85df-45e1ade6a8eb@ti.com>
 <5ncoro6nmu4yoqniijjah3hernt7rigmmz6sjjzxcbbyzzpz5a@2einaw7lox32>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <5ncoro6nmu4yoqniijjah3hernt7rigmmz6sjjzxcbbyzzpz5a@2einaw7lox32>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|MW4PR10MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: d4acd761-a5b0-4216-f288-08de57fec4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVA0QXpHSXpCMlJJVHNBTnY5SWtxVWhZNGN2MW1zdlJVUTVIRHAzMnB6NzBw?=
 =?utf-8?B?UmZCK0U3cVN4UFVrNUI0Ym5HM3hHWkxIOUNhc0F5aFpOcHgwSDRzUytwa2kr?=
 =?utf-8?B?WVlUanZPTHVsSXJNTkljNFFDMUZtT1dBOEF3cTZKUEhZMWloTVU2NzRVZkQv?=
 =?utf-8?B?bjFpUVJ4RTAwd1pUL295SWhHaWtvcjI0enJ5TUw1VTliZEJONlV0V0xGMXVt?=
 =?utf-8?B?ZW55dzlXNXFpUWwyQ3pveXZKYTNOQVRJS3BhQ3VPSVdzaXVVMnRTL2YrQWJN?=
 =?utf-8?B?MXUwWjl3cnZQYjN4S1JsOC9tQVJEbzZtbEpnZlFvV1VXOFkySCtwUWlyNS9x?=
 =?utf-8?B?ekRKVGlsdnhYWkpKbkZlZCs4SmZ5NFczWGNDdUU4aXBraC9KTGUyQkFzNE9n?=
 =?utf-8?B?N3NQZDdzbU53TzJ2QjdrR05ua3BnYlJIM3F0SGpqcmJhMk12VVZqb1JpVUpB?=
 =?utf-8?B?Z2FQT1VZMFJlelBtMjRvZU5tS2Q2Ylh1QWZueHYxUTlCUGYwYU4vbmdTZEph?=
 =?utf-8?B?aTRycVRQREE0RThmVUtjM3FYTmxTemE5VVFZc1ZvOVlvUHRxZ0NURDYvSFp6?=
 =?utf-8?B?SEppNk5hUzhiVHhlS3d4RGJjNXpZcVp1SzhIOFIvcnQvbG5UVUx3RDA3RFY5?=
 =?utf-8?B?K3BSMzV0M2lPdzJQeUoxTEVHWTJyelVJM2JMM083eVNwYklHU0tvTnVYMld3?=
 =?utf-8?B?eVlJUmpHQ1pYa0p1UE9PNGQ4ZVhUWUFWdTdYdmUvWXU0dElIbjZia0pkaS9X?=
 =?utf-8?B?eGYzaTBMQ2pHSEhBNUJwZTRnbE9qKzFCd0NEdmNIbmM5VVMzYlc4KzBDa3Bz?=
 =?utf-8?B?ejhLdGtnd1FIN2owYk44RStsQW43UTFNbmFNME50WXRPdTFWWTdyS1F1TWo1?=
 =?utf-8?B?dXBvSXFack0rMnNLdjNHRzZ6clp1V3ZnU0hjYlFPV2E0SGVnRDdHaFpUZnNu?=
 =?utf-8?B?ZHZ1c2EyYVdqZlRlVFdVQXNTUXdldisrelVNQlRrb3NMOTI3aE5SR1c3cHIz?=
 =?utf-8?B?aEtjclhCSlYxNkVqTkxOMWxTait4SHBIVGZJd3d1Y3gxWUN5SVZqMkNWM0Y2?=
 =?utf-8?B?T1I2QjduQjhZdG5ib0hFSGlqRm56aC8xek1WZUVtUGFsWXl6RVp6YmozYnpM?=
 =?utf-8?B?bWNMM3pzby9CdTRwaUVjSFhJNi9yZHk0ZVA5WjdENExwd1NiVGdPZko5eHoy?=
 =?utf-8?B?OE1NS054R3J6U0kvNjk4cm1qNWpodGd0ZkJKZzRORXJ4Y3ZiR1dIUTY3Rk52?=
 =?utf-8?B?UXBONUxQWFBieUpJOUF1SlpZL2FCM0hXYmFiMjZBWXBabWJENHBRSkNhUzhv?=
 =?utf-8?B?ZFF5eFBUdFVtSXJZTVptQ2I2T3pLZFVJZ0Y3NURsK1NJUVIwOFlUMG5jZjRT?=
 =?utf-8?B?NThMcm5rZk0vM1UwZnlVMWlxWVFFdm1rdW1LMGkvNWN4cVZMMkd0VkVEcmR1?=
 =?utf-8?B?aVA4QjduMXQwZlFVT1FsV2tOYmtQMnFuVXpOenVLdituS1k2dGQ4c1BhaEFs?=
 =?utf-8?B?dlJDZ2xBbnQwd3NmVFBvb3grVEtmTmdmU2hoUEdvSkQ1SDA0akE4aEVOejhQ?=
 =?utf-8?B?YnJJY3ZLTWdrSjdGVnZSWlhLcllzV0duNlJkUXZwazZndUorN2JNdm1OMWRF?=
 =?utf-8?B?cFFGZG1ORzRiQ2t5RGxGelhGcW9KYjU2UjJxRSsvMWx5c3Jid1kwTE14eGtL?=
 =?utf-8?B?dFd3cms3THhvME5YWnJRTUlTbDM5Z1loRlhqMmtPendwdXE5WlNIaWRGdDR1?=
 =?utf-8?B?dGVQSEVhMnZEZmVPY1BlNlRkamlFcnZxY1V0dWxranhtaW1xWmo5b1Bqb2Na?=
 =?utf-8?B?enNESGJ4L2JQakVkWHd1M3QrUUoyblJOYUt0TXhCeGdzWWpGdVNJZWI5Z1l3?=
 =?utf-8?B?aDVFNUcxaytyUTZZSzVWdGxlNjNOSjRqc2xuMFp6VVgraXE1U2t0dDhmUVRV?=
 =?utf-8?B?TytDNDRXaldHOTB2SStSK2ZvRGRKVyszaUI0c3QvVWtaUGZjY1dJZ1VCTnlC?=
 =?utf-8?B?REFGd3NLTzhVMWNhc21POVJmNkVDcVlFSUxHSmZjbllZckR1UUVldDR2eHc1?=
 =?utf-8?B?ZkNicHg5Z2FUY1Mrd3QxUkVpOEtLWGJLejF6RUMxOU5KTGhIa3VVZEJ2Z0VW?=
 =?utf-8?B?NkRweEFNRkRmL2cza1huclI4N3l1VythTGZGZjVzNmoyMU1SeW5pSWNrTDVw?=
 =?utf-8?B?TzRYSlRXOXd5TzVkWFJGNWhzRTBXSzJFNXU2WGlNUXdYNkxlYUs1aE9hVFpy?=
 =?utf-8?B?LzAxWFJFakJlWnpubWxOZ1NRQzd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:34:46.5710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4acd761-a5b0-4216-f288-08de57fec4ba
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6370

Hi Uwe,


On 20/01/26 13:53, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Jan 20, 2026 at 11:23:54AM +0530, Gokul Praveen wrote:
>> On 20/01/26 10:10, Kumar, Udit wrote:
>>> On 1/20/2026 3:03 AM, Uwe Kleine-König wrote:
>>>> I doesn't look good to me, it's way to complicated. Unless I still
>>>> misunderstand something, I think
>>>>
>>>> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
>>>> index 7a86cb090f76..4942689105f3 100644
>>>> --- a/drivers/pwm/pwm-tiehrpwm.c
>>>> +++ b/drivers/pwm/pwm-tiehrpwm.c
>>>> @@ -378,6 +378,8 @@ static int ehrpwm_pwm_apply(struct pwm_chip
>>>> *chip, struct pwm_device *pwm,
>>>>        int err;
>>>>        bool enabled = pwm->state.enabled;
>>>> +    guard(pm_runtime_active)(pwmchip_parent(chip));
>>>> +
>>>
>>>
>>> Fair point,  only need i see to keep in hardware active state after
>>> dropping count at
>>>
>>> https://elixir.bootlin.com/linux/v6.18.6/source/drivers/pwm/pwm-
>>> tiehrpwm.c#L293
> 
> Yes, with my suggested change you can drop ehrpwm_pwm_config() grabbing
> and releasing the pm_runtime reference making the whole change:
> 
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 7a86cb090f76..2533c95b0ba9 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -237,8 +237,6 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (period_cycles < 1)
>   		period_cycles = 1;
>   
> -	pm_runtime_get_sync(pwmchip_parent(chip));
> -
>   	/* Update clock prescaler values */
>   	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
>   
> @@ -290,8 +288,6 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (!(duty_cycles > period_cycles))
>   		ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
>   
> -	pm_runtime_put_sync(pwmchip_parent(chip));
> -
>   	return 0;
>   }
>   
> @@ -378,6 +374,8 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	int err;
>   	bool enabled = pwm->state.enabled;
>   
> +	guard(pm_runtime_active)(pwmchip_parent(chip));
> +
>   	if (state->polarity != pwm->state.polarity) {
>   		if (enabled) {
>   			ehrpwm_pwm_disable(chip, pwm);
> 
>> The above changes looks simpler than the one I had sent earlier.
>> Shall I send a v3 patch with these updated changes, if it is okay for you,
>> Uwe.
> 
> I guess that's the only thing that brings us forward, and as I cannot
> reproduce the issue but you can, yes please.
> 

Thanks for the confirmation. I will make the v3 changes and send it /

Thank you for you great support,Uwe.

> Best regards
> Uwe


