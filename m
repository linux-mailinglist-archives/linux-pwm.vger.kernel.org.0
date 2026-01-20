Return-Path: <linux-pwm+bounces-7955-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D31C4D3BEE9
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 06:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 618AC4E7022
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 05:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25599362135;
	Tue, 20 Jan 2026 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RNwQUeiD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F433FE09;
	Tue, 20 Jan 2026 05:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768888447; cv=fail; b=hB04pSbjAZNiZNri8edRzxrbkZOIed9EyFKIaNWwyOWUsNhQDnvDcEJJuDWD4FjXfxczz8gyxfdgcwYxA1nLW0IqRb2yXvhsFiI6K0bKQmH2AaqUbCFVGG7gKmby9ht8HIIKxKQGRqqiaJVWIOZfZ3K6dxr0Bm5tMgTJM7LWvso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768888447; c=relaxed/simple;
	bh=N8+S5XEHH+66tFQnEdLiFqCUsly7ufUVjIkOlDCy4fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oG4h9H6QmblifiaJvrRVlW+TmdhhC+Q+ROmGZbufr8Z0oOR4fkBLd3UqUfErhTNPdP3eZ6iQQ/YTgbVKYFdcwd8AYuiYlv0eC3PlP3Qnzt4EAZyzrA4tY2bMGhr4i14hKywI/SJTLDLlKofjblx/QqcJop3Dxl+tmkDqvE6xw3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RNwQUeiD; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvrsM2aQpztHXuj2gfPIWKeG3b3fQo/9l2ibOK29Z+ttNPhlTKBWXIbwTbMtDrp8OKJfpvJJxAAIWWmw9TXfRkVtdUNZmvgiS71jc3Cv2g/pfhGx8mRpQKnZkWnGKLxgpv6uQyRMhJWtSuj76EwxROq+y2UfPHM+HnOc474GgO3S2JWrf6HKEi0mE5eF/IVzQIMeBfa9ujq+NYv330uYrFmFm95w58lrDW7XKLXFJTlLTDLodAyPP8BZCwzCbjrBgz2Was6Qr4WnSo1cZeNsQfLGWGkRqaqbR0NvLLUkWtlpLcyoIOIwHCHenVXI3DLOVYbS/Dvw6M1LxDDtcqx47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qifpnd4Pvmaev4ZM/yc9IVOMnKSUH1LWAOCeiEnb9YU=;
 b=Y5aAPiBUuyfsyx7W62amlYwJhtwtD8h90wJILt+oJF1Z/PoRK0sIBp7HD48zSDXR8LD2L3Y5N6pbZ6i5+1NEzDuVr8bQeepXnY0JCJCLwfi+MygZn+bZo+G3lOfd+90svTmLxBeL9J4XRE2rybgWH6NOSGsRo2SxkGREmW1cK8ljhZ0b8KPGuHEJF0VyxcazNC2ci0geiPt5pjUwhu9JEdTl6dahFeWvQwi3IwnrtJUI77eM2FsAnBLGxNbaNnchIGhM9Sf6+kEwIkyNm4K5CUJutyKLP+Shl/5l51hDuEhBhK68keXsMg2i5eFuRksJu3ZD6DVZ7NdlDbYFSKh4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qifpnd4Pvmaev4ZM/yc9IVOMnKSUH1LWAOCeiEnb9YU=;
 b=RNwQUeiD36XyriEjnSy0M+K/zSI3QjqjbndsEyfP4VBRGtBinvYQUK80f9ZTfO/0xT+KzmRq7WEYRZobTpa5qEpawYlHXr0cOkg55JyJJMtAcDzk6USIIB8CaTwbPbRgjMoAWt/O9Im7tb2ztG7v3zizaVkRL9aMsc5R0zF0udU=
Received: from BN1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:408:e2::32)
 by PH0PR10MB997643.namprd10.prod.outlook.com (2603:10b6:510:384::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Tue, 20 Jan
 2026 05:54:01 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::8) by BN1PR13CA0027.outlook.office365.com
 (2603:10b6:408:e2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 05:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 05:54:00 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:53:58 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:53:57 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:53:57 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60K5rslh541869;
	Mon, 19 Jan 2026 23:53:55 -0600
Message-ID: <77e5712b-e1f9-4fb7-85df-45e1ade6a8eb@ti.com>
Date: Tue, 20 Jan 2026 11:23:54 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before setting
 configuration
To: "Kumar, Udit" <u-kumar1@ti.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, <j-keerthy@ti.com>,
	<linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<n-francis@ti.com>, Gokul Praveen <g-praveen@ti.com>
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
 <80a2c59a-fe7a-4244-a374-bfc70dc46978@ti.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <80a2c59a-fe7a-4244-a374-bfc70dc46978@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH0PR10MB997643:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a57ea1-1763-47fe-8f76-08de57e84f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWdYUnJGSFBvSzM5aWZoaHlQaGxaY3gzc1BNRWJXbGRUNGtDSWtVN0tUSEVt?=
 =?utf-8?B?b0poTTArN2FPMUtvNitveS9xTlRNNDJpZS9ibzIxRWpxM09MOWpac3ZZWGlh?=
 =?utf-8?B?V3ZrUFRxV3cwazE0NUJwdTZwNXYzT1piT3FWaFRLVndEK3NldzdZWHd2blNX?=
 =?utf-8?B?ODRYeWV5TEhFWVlzdmZ0cURFZFU3SS9IODdiTlpVTHAweng3bXVCWStPRkda?=
 =?utf-8?B?dDF2OTZTdzBjUWw2NW9yTTFKcEZmcGhpWnJFNDJoN3MyOWZGdW1WejVFdVMz?=
 =?utf-8?B?N0UwZEw4KzBNcVVMd3p2M1d5OWowWjZIT1NTbFFiSTY4aGpsZks2SXp3SUw0?=
 =?utf-8?B?V2ZKMEhqMWdrUHhhdzhoOTBzNk1kYWFCNjVNTlZwSzJQbFZRRlkyYjZ4Rkt2?=
 =?utf-8?B?STFxOCthZ2I4dUlKemNCaEZNb2hVMFVwampOOFhrRGJ1MVA5UGpjUiswTkVV?=
 =?utf-8?B?N1p5VDltNmU3VW8yK09vOVdJams3Z1VHTm9FTWdGSXpvVzZ6aFhCS2JjRlZU?=
 =?utf-8?B?VnVRdGdpbEtwNDUrWWU2WjdjL1VIM0dTS2NoMUpVTm94enVheDk0ZkswVTAv?=
 =?utf-8?B?QnYyU3ZJTWZ3MnpkamI1eklzc0ljOXVtYXFtLzhNQXJIR2NnZDBobW82d2d3?=
 =?utf-8?B?ZXYra3FBUjZZN3J6SU1FUHI3dmdVck9KSE1CbFRMWUtzK3NlUWVseElLbjIw?=
 =?utf-8?B?RzhDOXliTVphcHZEVFgrUER1S1ZJRyt1M0c1UWNKaE1nb2tkd0x0V3padE53?=
 =?utf-8?B?YUFxa3p6cU96S0FDTEFZeURUR2svTkIvUHhrQ05PaDR6S2VoZWlOZUZ2N3hl?=
 =?utf-8?B?c3hYUnpxdWhsU2FCWU8yclpLOXN3Y0pjelRacTRVK0g2Rk00MCt6N2ROR0Ez?=
 =?utf-8?B?RExrYzg5ZDZ0K1Bkc2YvR1BuVDhJUU5SbXRTa1BqYjJIeTAvUUl5T1lqdU9C?=
 =?utf-8?B?L2JDTG5xUENXRHFVcVduYjVsbGpmdEZLTVRUNDYvL2FMQlFOdWs0TWZGQ2Jl?=
 =?utf-8?B?K0JvWDNTb0IzS2FuSExJejNseEREL1hQRVVzc3RDODdYUVR5Z3NKZFU4UlhC?=
 =?utf-8?B?dVJkVjZEbG5OTmZkaFc3L0lZQVlpNWx5WGxBb2hFdisvTlRMWE1EcmFxNVdq?=
 =?utf-8?B?Tk9pL1NOUWRoQzVFSmVLanEzeTlVZitEU1FKTUtzVVQ5NCtXcWVkZ2pUTmFE?=
 =?utf-8?B?UEIxN3Zhd2VFWXF6OXlGQ3BCUjN1YURkVVY5UnRyQU00K0JVaGY4R09zclEz?=
 =?utf-8?B?MFBDV3hzTzlkSkwrS0lncUc2UUdTUHI1anQyQmJFUmhMTk5xMUZvMEhFek4z?=
 =?utf-8?B?a012MHhPZEFFd1RMcTFsRzgzNmR4VHA0TnQwRmg3US9hN0lTUVpQOERYMkQ0?=
 =?utf-8?B?c2RwTXlUaG55K0tzSk9Ra1FjNHFPbmtwMUF5QmxQQythN2RyQldqZGFmNTNF?=
 =?utf-8?B?SHVxOHVVUFQ2OVl3RXYyQjZWdlM0NjRsMkd3QXNWbldYQmJOT0JKYXY0WjVr?=
 =?utf-8?B?Z1lZVUhEZnRLUk90eVgxTFl1RTErSXBNR2gzWjFkd3RqU1I5K3JRYUF0bkNW?=
 =?utf-8?B?TjVSNGRxTTgrOHpWSnIyZE5VcHBQelN6dE1pVndGaHVkUitNOWlBMXdIUXhR?=
 =?utf-8?B?OFJBbXZ5c3hCTmlPNVl6YVlLWGVjRHMwcktoY2R3SitLZTJVUWdSVzl3NUgy?=
 =?utf-8?B?Tm5odCt6Zll4NGlnaVEzN204aWQ4RENWOW02SGtCS3ZUdmdpY2E1ZUNTNkxw?=
 =?utf-8?B?UG40b2ZuQkdFY2JmRFFMV29qR00ySjJGU3E2TWJCdFIwZXRZaDIvVXg2eWtm?=
 =?utf-8?B?RHEwaVp6dlAwdEVSV2ZjTDV5MmxPTHNGWjhvTnZIbGdid0U2eFJYTGtCWHVS?=
 =?utf-8?B?dlRKMktvVDNYbWhYS2dFNklDc2gyVi95UXZaOFhOTFFVeCtjWGx6dkZLaUJI?=
 =?utf-8?B?WG9JM1JFZkptVHhDUXl2U2xlT2FvN0tNMlJqZzZ4WjFXbEpnUUtOT0VxNVlR?=
 =?utf-8?B?a3VMWlFIS2xUVGdqeXpxaEhKbFE5b2szWmI1MGVVYjBKS0cybzJqdGQ2VUtJ?=
 =?utf-8?B?bHVCdVZ2MkpBSFZObDN1ZldiZVI4Y21nUEl6aUpweUtyd2JoNXRlT3pLNGtZ?=
 =?utf-8?B?ZVkrZUNXNFVvMmdKVUhBdUtVdHJPSVJBNm1iaFBhSzJaMmNwOU1EaUxVY2kw?=
 =?utf-8?B?bG1YZXB3VG9JQzIrMFpXTkZYMSt5cnRsVE1rY3VkOVVxb3l5R1hqU3M4Q1g2?=
 =?utf-8?B?RklLUHVrbm5RZDY5RkttMVZYU0l3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 05:54:00.4762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a57ea1-1763-47fe-8f76-08de57e84f32
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997643

Hi Uwe and Udit,


On 20/01/26 10:10, Kumar, Udit wrote:
> Hi Uwe,
> 
> On 1/20/2026 3:03 AM, Uwe Kleine-König wrote:
>> On Mon, Jan 19, 2026 at 08:30:08PM +0530, Kumar, Udit wrote:
>>> Hi Uwe/Gokul,
>>>
>>> On 1/12/2026 12:52 PM, Uwe Kleine-König wrote:
>>>> Hello Gokul,
>>>>
>>>> On Mon, Jan 12, 2026 at 11:21:50AM +0530, Gokul Praveen wrote:
>>>>> On 10/01/26 04:23, Uwe Kleine-König wrote:
>>>>>> As I cannot reproduce the issue, can you please check if adding
>>>>>>
>>>>>>     pm_runtime_get_sync(pwmchip_parent(chip));
>>>>>>
>>>>>> to the probe function makes the problem disappear? Also please 
>>>>>> boot with
>>>>>>
>>>>>>     trace_event=pwm
>>>>>>
>>>>>> on the command line and provide the content of
>>>>>> /sys/kernel/debug/tracing/trace after reproducing the problem.
>>>>> sure Uwe, I will try this from my side.
>>>>>
>>>>> In the meantime, will you able to test the same on TI J784S4 EVM as 
>>>>> the
>>>>> issue was reproduced on this board.
>>>> I don't have such hardware, sorry. The boards with TI SoC on my desk 
>>>> are
>>>> only a Beaglebone Black and a BeaglePlay. (And I didn't setup the
>>>> BeaglePlay yet, it was already quite a hassle to make the boneblack 
>>>> work
>>>> with a recent kernel. In the end it looks trivial, but
>>>> https://salsa.debian.org/kernel-team/linux/-/merge_requests/1777 plus
>>>> unreliable netbooting in the bootloader took me several hours to sort
>>>> out.)
>>> I am able to see this issue on J7200 hardware ,
>>>
>>> LTM, it may work on certain devices, depending upon how LPSC (Local 
>>> power
>>> state controller) and PSC (power state controller))
>>>
>>> are managed.
>>>
>>> In original code , while putting sync at
>>>
>>> https://elixir.bootlin.com/linux/v6.18.6/source/drivers/pwm/pwm- 
>>> tiehrpwm.c#L293
>>>
>>>
>>> will leads to calling genpd driver [0], which may put PWM IP in 
>>> powered down
>>> state, leading to loosing contents.
>>>
>>> So, we need retain pm count (genpd on in fact) between config and enable
>>> call.
>>>
>>> Therefore this patch LGTM
>> I doesn't look good to me, it's way to complicated. Unless I still
>> misunderstand something, I think
>>
>> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
>> index 7a86cb090f76..4942689105f3 100644
>> --- a/drivers/pwm/pwm-tiehrpwm.c
>> +++ b/drivers/pwm/pwm-tiehrpwm.c
>> @@ -378,6 +378,8 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, 
>> struct pwm_device *pwm,
>>       int err;
>>       bool enabled = pwm->state.enabled;
>> +    guard(pm_runtime_active)(pwmchip_parent(chip));
>> +
> 
> 
> Fair point,  only need i see to keep in hardware active state after 
> dropping count at
> 
> https://elixir.bootlin.com/linux/v6.18.6/source/drivers/pwm/pwm- 
> tiehrpwm.c#L293
> 

The above changes looks simpler than the one I had sent earlier.
Shall I send a v3 patch with these updated changes, if it is okay for 
you, Uwe.

Best Regards
Gokul Praveen

> Above changes will achieve same as well.
> 
> 
>>       if (state->polarity != pwm->state.polarity) {
>>           if (enabled) {
>>               ehrpwm_pwm_disable(chip, pwm);
>>
>> is enough to fix the issue. (We need something like
>> https://lore.kernel.org/linux-pwm/20251123233349.2122-1- 
>> rafael.v.volkmer@gmail.com/
>> to make this really robust.)
>>
>> Best regards
>> Uwe


