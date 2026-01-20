Return-Path: <linux-pwm+bounces-7954-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0266DD3BE83
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 05:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA2D94E8E15
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 04:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCAC35293E;
	Tue, 20 Jan 2026 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NK86InAp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3189348465;
	Tue, 20 Jan 2026 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768884016; cv=fail; b=tVOAyZbTsmmFx8zoMJtzSYbUC71StYWchwHIP3Lu5z3gpL1vttA7rGBNaRg2YS1dqFc2P6aweYXh0SoJJZdY18ODDrTv95ljm/QdxTwZLGVFtPHT42GRwZU9cas0i8IRvLN0elbPpZChAqQZGDT0brXHeBTfJSmAWCmsiMjPl7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768884016; c=relaxed/simple;
	bh=SMp0XOUw5Su99Zc/h3Ji7/kSInHiR/rxkxYcmxMlQ1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZZjLrOQGRUdosN1QGespE7GaJBTkf3pqjmxIeBIuTMFGI6dqQZc1tpKNBHXTb2Q8W/ke9n621kFwTGa2if+JvbP/4DFfhioURVl5GvT7LSXb0ovcjU9r2WmGjZH0ADtUjmGyHZamNgXrvsKmaMSzZ6QItxH92Z4IRTWiB8nVCC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NK86InAp; arc=fail smtp.client-ip=40.93.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3ymzFI9jTyq0yeviP7xezGIIaI/icgBDCT1rKRIue58LDu9hc6KcvWaFuTVvHiFValn1WpVj4v9AOlDO+xNH8DOP0Ew5UT2iWmNauURg/vn+CAiuq5OhRw5dP6DAdPXt8kLGjEnstYg8zGIbPl6bbWe5bqIpmWyBOw5rgVOw0aZyMjDDNnFIj7BLdLoLamUNFCBFAEv0I2ux0Eiod7uNaSei+q1E5B/s6XrnCcHyJsz40mRI3Kuy9DcBqj2i8lRzHoGE12BEeDyAJKtuYhoVcL2A6sTAhywZzJa6Ian2zVCvb07v+4rxdkpUi0qkGvMvjnbJuTZl3dok+9/Co1h0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzJl2lKoV1/dAZfc04/71SrJiWufF2UkpHeuqR4tfcA=;
 b=YvKwloXxcrcik7QlbfShySbtOrEDGRNHfB6WjqDvo/ie/Ad7a9dlunUEhcuMCWMtvDVrJSHHZ4c25N/W6+l+B2gm5k0j+6SPdYjOSS5awnYK+dOFLIr6w7Kk/atGEexmoBGoqfgGO93G2n8oP9ampIY0l5dgqbeNCyG3RD9EyMPYDqLEiGHgP2wL35M7dI5xfVf0fdzXUrSQNQg1Y9bi7Ay3cN7EFtkvqykdyoLeyYWxGXy3OWT3d0zBxMe1sHJwv+G/pAwnUCdTH6+uAq79x7eRrrNAF107SCaPFG+GiTzFOr3cObzUKaC+rHidEForJlhVG2YRrmWt4TfKw2Pfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzJl2lKoV1/dAZfc04/71SrJiWufF2UkpHeuqR4tfcA=;
 b=NK86InAppyPji7UnhJ7mKjTfaekXYVNshV/wS/OqAHhZMjiPty4kzuEBCNQX+VuQ0tSq7xcmuGAtmM1XW3TGLPqCIO5TbFVYsJq9YrPe9mYAS5pykLnc5qSGpb24HE5q/giURcEWMU4TVqRezm4VIQwznS7wNK84fMObVYMtpLw=
Received: from BYAPR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:40::28)
 by SJ0PR10MB5693.namprd10.prod.outlook.com (2603:10b6:a03:3ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 04:40:09 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::f4) by BYAPR04CA0015.outlook.office365.com
 (2603:10b6:a03:40::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 04:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 04:40:07 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 22:40:06 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 22:40:06 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 22:40:06 -0600
Received: from [172.24.21.248] (lt5cd2489kgj.dhcp.ti.com [172.24.21.248])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60K4e3Fa451585;
	Mon, 19 Jan 2026 22:40:04 -0600
Message-ID: <80a2c59a-fe7a-4244-a374-bfc70dc46978@ti.com>
Date: Tue, 20 Jan 2026 10:10:02 +0530
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
CC: Gokul Praveen <g-praveen@ti.com>, "Rafael V. Volkmer"
	<rafael.v.volkmer@gmail.com>, <j-keerthy@ti.com>,
	<linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<n-francis@ti.com>, <u-kumar1@ti.com>
References: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
 <20260107194802.3917-1-rafael.v.volkmer@gmail.com>
 <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
 <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
 <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
 <xdj2ceubkss3ingkxdvc64zqrcd3wzz2uxa6wqwgvilu2ykukc@hbn6tt2gnxj5>
 <741ec8db-7804-4f31-969b-10724ec06823@ti.com>
 <hvz5lw4xvujmdruoi2h2wk4dvanyg7y5xp5tp2rs4dygmza3s3@idcjbz6wbxh4>
 <29dc86d5-080c-4af2-8e19-99a137c55f2f@ti.com>
 <xkhyvqemt7ox6s3kcwjx2qktwlrvdo2dbn2azlk6tdimjvclky@g3btsovrn5am>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <xkhyvqemt7ox6s3kcwjx2qktwlrvdo2dbn2azlk6tdimjvclky@g3btsovrn5am>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SJ0PR10MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: 687e2e99-25ff-4b67-3c31-08de57ddfd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWJIKzRESmVqQ2x6R01WT01IeE1Hd0JqZE9mMmFrOFpKd1htUEdsUHNOREhn?=
 =?utf-8?B?dHV4ZGh6QXFRVDYvWVAvRTFQWXNwakxXWG1kQXVObG5RMGh3cEpQclY0ZGgz?=
 =?utf-8?B?eWQ5MG8wd1FnUTFLTHZhT0dOcUs4ZGlwa0FFMVlpRnlsdzBoNlk2Wko3UVhV?=
 =?utf-8?B?WmpLdlNROWR0VmwzSjZqajc1eUtRa3VGUUhSeUZPNnZXS011dnFXcnpPZG5s?=
 =?utf-8?B?VEhNQjRzcnZLSE9CVnpHcUhFZy9Zb2hxTC9lWXZzZ3NzazFsMkt3MkxTQWVu?=
 =?utf-8?B?SVEvMHM1L0pBZC84d3RjRWR2cmRpZEdRMVlVNDgrRHZIb0YrS3hXeTNCWjVr?=
 =?utf-8?B?aHIrOVhkZkFUMDdqU0RvK1FFTkt5VGN3OFpGeTl4aEE3cjltS2Z5R2dqNFp2?=
 =?utf-8?B?V2x3STA0OCtBSytZOUw2MzMzRUlTU1BsYzZ2MFZRaVNGQm9XZ3gwOTdVSWpO?=
 =?utf-8?B?c2ZZME92ZW5tOG5Xbm0xMDFQNkEvTXQ3bFhxUHQ0UGhVb0hOOHRmdGExZXRT?=
 =?utf-8?B?K1Q3dS9MY1hHR0xKKzRzM0dGR2pTaStlM0RNaHVuNWc2ZGFyTkExYnpSRCt0?=
 =?utf-8?B?K3gvbnlpaXNXM0M0QUFJTjlqZUdOUHk1clZrbHVhOSt2S2VoMjU2YkJGbW1w?=
 =?utf-8?B?bVdoNDdoNWZvL1BCZmYrMWZUekZZYWcxNW9JTXhYZVpKbGVxRExjR3cwVXNF?=
 =?utf-8?B?K0oyMnFQYS9JRmFKNm1veGl0VUFrSWd6VjBWOGRMdThwOE83cy8wUlFYRmtu?=
 =?utf-8?B?K0V5cnlMMWZWQUdrQ2Jnd0ErYnk4bUVHdXR3M2pTdDd5R2hjQW1KR2J5ZG1T?=
 =?utf-8?B?SkhoSUx5NFJGV3VCQnZ2RnZDeFhOVy9PVUhtTEZFUDBGd2p2NFo3cFdlMXhZ?=
 =?utf-8?B?VzBnNEV6S1U4UUo3WFp5SGJueEtwdCtYOE5aZGxlZmhRbHc3SUk3UlM0TG4v?=
 =?utf-8?B?R0ZGWlJNaStGVFZOQXM3OGkxTm91aC9VZWV3bytxTWtkNDBEaEl6NkN3RG9a?=
 =?utf-8?B?M2x5VGo4QkVSSEZWM214ODFQemppdzQ5UXhnUG02RTBVWEJSQjNjSXdsd2hS?=
 =?utf-8?B?TUx5ZG9oUm9vdDhXZWczcnNSK0FHR3VsTVdUb1QwWWdJZnFOa0RlUnJuUGgv?=
 =?utf-8?B?U0l6VVRrZzc3eHY3d2YzdGl6dGhockNMcjFmNUxMVFVabER1Wjg1VkFnY01a?=
 =?utf-8?B?emVhdkRTRTNaS3M3eTQreGY4S2huNm9yNkNxaHIzRHgyTmppT3Y1NENWbjdn?=
 =?utf-8?B?UTAxWlpMTzl0TytxM1VkWDJ1eEM1T1hyRXZEYjl4NlM5R2Z0LzF6OUU2eGhk?=
 =?utf-8?B?RVZhUHZUVzdXY3M1R25nMlN4MGJFYTl1dURIY0RJSVRWamJrUUZadktKUXl2?=
 =?utf-8?B?Y1ZCbi9QWDljT2JURUJhTlh2Wi9BcXljWEM2b3FMMFJzWkRRNUllY0d1aHVo?=
 =?utf-8?B?b3N1OHpBcmVIQkRiRlBZZWJSYk1tamNLcVgxblFFejZUalZQTEkvMno5VkY0?=
 =?utf-8?B?b3FHa3EwYjBuZ3g4ZzA5UXlnL3JIcHlnUlAxd2pxQnNlNURROFJuTGJ0SEZx?=
 =?utf-8?B?MlF3MlBQOXRwVXZIZThxMWZPak00ck5sTkw3U3ZHVUt5ZmdkMDNrbXlxMDNu?=
 =?utf-8?B?WG96MCtNOEZiSk1rdVprd0xUdTRUUHhIS3NMN1l5UVNzaUhacGs5UFpGMXpN?=
 =?utf-8?B?ZlVXbUU2am9sR3RYWnhFWFBrcmlSanczNXZoOWxYbVMwbDZTaWw2dEg2a3RF?=
 =?utf-8?B?Yk9sbWI1dlNqdkVteUdEYkFwNC83UVRsREZoYk45MkdiRFNwUGY2SWttY2o2?=
 =?utf-8?B?bVNsa3RnWk9kaUFpU3FKcmVmbWtZbjRWQ0N1NEQwTi9UaW80V0xrYjMzR0ox?=
 =?utf-8?B?bWZ3NTZ6V2I3OWFNbGhZMEtZL3ByNVVIZ2hhTzhTQXhoUVlFUWJMVGZhaGJa?=
 =?utf-8?B?TENzR0RtaXhWTk1Ld29qWGNwTzI0RmJkVTZiWWhONmdiZFVTNUtlT1FQOE95?=
 =?utf-8?B?ZU9RRER3LzFzeVgyNUVlTm5kbWVRNnRIaXFnWWVjTDhoQWtDWnV2Y0U2bHNF?=
 =?utf-8?B?MldjM2ZDQk03c2hmSGpEaHdRWC9oRGpDZkVzbXRzZ05uWEtOZlRGL1M1a3ZP?=
 =?utf-8?B?TUVkWWY3aFlmMUl3ODdHNklZS3pTV29DSDUvYWxsT0wwVkZYUkVpZUlzVVg5?=
 =?utf-8?Q?j60xAudxRIJCxPbloVlgXKA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 04:40:07.6168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 687e2e99-25ff-4b67-3c31-08de57ddfd03
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5693

Hi Uwe,

On 1/20/2026 3:03 AM, Uwe Kleine-König wrote:
> On Mon, Jan 19, 2026 at 08:30:08PM +0530, Kumar, Udit wrote:
>> Hi Uwe/Gokul,
>>
>> On 1/12/2026 12:52 PM, Uwe Kleine-König wrote:
>>> Hello Gokul,
>>>
>>> On Mon, Jan 12, 2026 at 11:21:50AM +0530, Gokul Praveen wrote:
>>>> On 10/01/26 04:23, Uwe Kleine-König wrote:
>>>>> As I cannot reproduce the issue, can you please check if adding
>>>>>
>>>>> 	pm_runtime_get_sync(pwmchip_parent(chip));
>>>>>
>>>>> to the probe function makes the problem disappear? Also please boot with
>>>>>
>>>>> 	trace_event=pwm
>>>>>
>>>>> on the command line and provide the content of
>>>>> /sys/kernel/debug/tracing/trace after reproducing the problem.
>>>> sure Uwe, I will try this from my side.
>>>>
>>>> In the meantime, will you able to test the same on TI J784S4 EVM as the
>>>> issue was reproduced on this board.
>>> I don't have such hardware, sorry. The boards with TI SoC on my desk are
>>> only a Beaglebone Black and a BeaglePlay. (And I didn't setup the
>>> BeaglePlay yet, it was already quite a hassle to make the boneblack work
>>> with a recent kernel. In the end it looks trivial, but
>>> https://salsa.debian.org/kernel-team/linux/-/merge_requests/1777 plus
>>> unreliable netbooting in the bootloader took me several hours to sort
>>> out.)
>> I am able to see this issue on J7200 hardware ,
>>
>> LTM, it may work on certain devices, depending upon how LPSC (Local power
>> state controller) and PSC (power state controller))
>>
>> are managed.
>>
>> In original code , while putting sync at
>>
>> https://elixir.bootlin.com/linux/v6.18.6/source/drivers/pwm/pwm-tiehrpwm.c#L293
>>
>>
>> will leads to calling genpd driver [0], which may put PWM IP in powered down
>> state, leading to loosing contents.
>>
>> So, we need retain pm count (genpd on in fact) between config and enable
>> call.
>>
>> Therefore this patch LGTM
> I doesn't look good to me, it's way to complicated. Unless I still
> misunderstand something, I think
>
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 7a86cb090f76..4942689105f3 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -378,6 +378,8 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	int err;
>   	bool enabled = pwm->state.enabled;
>   
> +	guard(pm_runtime_active)(pwmchip_parent(chip));
> +


Fair point,  only need i see to keep in hardware active state after 
dropping count at

https://elixir.bootlin.com/linux/v6.18.6/source/drivers/pwm/pwm-tiehrpwm.c#L293 


Above changes will achieve same as well.


>   	if (state->polarity != pwm->state.polarity) {
>   		if (enabled) {
>   			ehrpwm_pwm_disable(chip, pwm);
>
> is enough to fix the issue. (We need something like
> https://lore.kernel.org/linux-pwm/20251123233349.2122-1-rafael.v.volkmer@gmail.com/
> to make this really robust.)
>
> Best regards
> Uwe

