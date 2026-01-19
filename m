Return-Path: <linux-pwm+bounces-7935-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6601FD3ADF6
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 16:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A22F3011701
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 15:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247C387346;
	Mon, 19 Jan 2026 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C/64dkPW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57C37BE62;
	Mon, 19 Jan 2026 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834820; cv=fail; b=rTPDyU4cXDHK6jtzqQC7gq5D7bNsZuE2HreUIuToERVtTojZeTXuvzSBufB2Yb37nhtVTZmYXODihhDjaSHGW2eXgO4PZ2gHb9/ZRLe5Nww/sohwxI8dysfaRFg8kN+hXVXbJTsgC/+MCdvwC5Mcm9DszZ7sevAflrtXLL1WSZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834820; c=relaxed/simple;
	bh=wuJwa59H6cy24o+VuC4Cgxn9dP0v3bXKYQlkzbwgXGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XPzEBJlpT9hu7anaBst1wADm2CdASntea+jPHpwVxZE4nIuuwmuba4BHP0OB/gOO/Axz+/uRoI3YeBBAjFMDex4diPYaw0V7X0NRdqNmXiT7szYQBAVcMZzrZHs9djctqpycINFZ+EV7W9+KxP/bB8qml8TR03tjUwQp0kffoJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C/64dkPW; arc=fail smtp.client-ip=52.101.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3eIKy1ZlfY0Ln94WVbTX0wAVIZDhze2ENyaHK9Hxt5pCYUKoARWEneUf5xWbFzPzTWhb+TjCu6l4iSobT0qdlEDVpqusEsqtkJqbmUOtNOVNhHQuurjgLDY26/3UVxkEtiSxQhUOplJcgaP/3PWPRQWiDVKlnIwtRprFHQNMec6g4hnQoz+6GDqN9pQaQNizijYeCkDdtlgpws+3NctDHJw3kgZ0Yijy9Asmqj+CziLXI4OMmcethrlyTU/ERus2nhh5qYUwEScMSjBX+UTSsyXmJ0DYHiI0CEnGAWQL8rcUc9Cyb3+rJofTEpTm6vHOuXOoUNrQhH5YxM3dQh0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spWwfcBmhPvGtesR4z/jKbF9qHTyPYcdQY0uNrYP9fc=;
 b=yqKnU5gjt968BJntcJ3R2970w/HU5boBbnCEhHk31+vgdI3j9xCZemx5Y7QzNLZkWnn30RzSEsU98+3ggqZOt1J9MfZurs6HNW/B+gtwW0yH0NfHdd69NyxbPT1Y4Qq1yQOfqUYpqTroM7bE8tWMzEv+zNNAgNFTtbT5+x0N699AL8BcAQDmLgt3Uz8IjJfr5tiqitrKWU9FmoODlCXAfwypkdagPA9f5f9jm3nujYX63Tq8V8WjgHEZrM8hCkRZSpPDjK++HutcAOBzbErn7BUERnaZqlpAnSsk/tHbVSqGGLQXRjNcmEDG8aJeDwKJ3+8Ryo6c3a3Cafrp15Ufmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spWwfcBmhPvGtesR4z/jKbF9qHTyPYcdQY0uNrYP9fc=;
 b=C/64dkPWrl1r58mf0aqGIZII0+bsZQ7rm3sFUk9YHfkLJxPgQUVhrpIz6szu/GQSU4WI0dCCfVfFyR7q82dWvMMfbpwqpOHh5TQREfbxn0fMG1x/onh9uzF6YR0CMZINERqzto3vwv29Pg9L6Gi0YnedZ1vRdx3JUdA/B8kNSak=
Received: from BLAPR03CA0058.namprd03.prod.outlook.com (2603:10b6:208:32d::33)
 by SJ0PR10MB5891.namprd10.prod.outlook.com (2603:10b6:a03:425::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Mon, 19 Jan
 2026 15:00:15 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::7e) by BLAPR03CA0058.outlook.office365.com
 (2603:10b6:208:32d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 15:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 15:00:13 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 09:00:13 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 09:00:12 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 09:00:12 -0600
Received: from [10.250.148.83] ([10.250.148.83])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60JF09Gg3734578;
	Mon, 19 Jan 2026 09:00:10 -0600
Message-ID: <29dc86d5-080c-4af2-8e19-99a137c55f2f@ti.com>
Date: Mon, 19 Jan 2026 20:30:08 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before setting
 configuration
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Gokul Praveen
	<g-praveen@ti.com>
CC: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, <j-keerthy@ti.com>,
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
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <hvz5lw4xvujmdruoi2h2wk4dvanyg7y5xp5tp2rs4dygmza3s3@idcjbz6wbxh4>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SJ0PR10MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 138cf8d6-3392-4255-de99-08de576b730d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjlUODhNZ0dqM2txcjgxSVowU3BWUGNabVpGaS8zZlI3S1pzRXo5N3ZZWVRs?=
 =?utf-8?B?U2h0cUF1cXNua0Zzam9vVmpoVDh1dTNpRW1oa1VqSkhjbFAvd3pNYkpUNmZX?=
 =?utf-8?B?dm9EOWl2ekVPTzFkVWJKMnpoblRUVk81M0tMMzVRaURjZGRCZ1IxY212dDlp?=
 =?utf-8?B?Qm54clFRUWpQeW9zbmdOVDJGemowNkliNHAvNkNDc2E0bU1ZS2I5aTFCcjl4?=
 =?utf-8?B?UXM5Zk1WSnhETmdBdnUvVXo3U2VyWVFSVmJLK0tmeWcvZWJrbklMYlRQanV4?=
 =?utf-8?B?dC9aWVEvSENKT2U2WFRUSGNkVnBaUnJaL1dTa3hLeVBNYzFYUE55TUtrYldC?=
 =?utf-8?B?eVh4aFNNY1NKaEhGRlpIRldiejdTNnhkSXRYbnFrWENhTDZWVkgwQ2NLTk1Z?=
 =?utf-8?B?MlBPRTMvSTJPa0w4b1ZVRzVOM3l2dnNuQk9WNTJOeUxEOExCbDlVaTI1SzJ4?=
 =?utf-8?B?RUJOOG44WmVwNStrZS9JUTFPN2JTakIyUXBKazdXWUtOMzBlT3ZSTEhWbEdJ?=
 =?utf-8?B?VlkvZHk0U1dIZHNZd2R0UXM4M0JMWk9pR2tYMEtKUDh2aFJtVVVFR09mckNh?=
 =?utf-8?B?YjhPUlZZaGRMc3NqYUluVFc0Q0YybFE3ZG53ZEZleVM3UkNUN3ZyZDZaaGZN?=
 =?utf-8?B?MGxOZ3pLNU9Gd0dRK0JGdXdpUW82RUZDWnU5YTk4UVkvZWhIR2lpSEVtMTJV?=
 =?utf-8?B?TmY0dHVqUytBUEFBWTZialJTWEVzYVZ1SEJDZDBIdWtIVnZ2YmJVbnFSV3h0?=
 =?utf-8?B?ZjBJbjlFQWhpbnNjMjBGVVgxNUtuRFd4TFVibDNiN3RvOHdhUWx0WlYycnNs?=
 =?utf-8?B?L0NmVHBxYm1CbXhDNGNZTW8wV01YaFNyWTdCWmxIVmNVUzFKWVd2L1VoYTlx?=
 =?utf-8?B?bFNwbkQwY1hQeG9aVm9ZdHd5cjZjWlRaQ3VRdDZUcnlNbmx5U2k5cHNKVnZE?=
 =?utf-8?B?SUd6aHV6d01USkJFdlEyN2FhRjEyWlIvbFNrbGR3TzAxWDlDKzNTM25lUGZF?=
 =?utf-8?B?TjFsZTJXcE9ZcWc2OGdEeFNyYUc0NGFsc3FTODhvTzRoVE9rd3BRLzJodVZN?=
 =?utf-8?B?d1ZrNCt2ODRIZis2V2J2YmFaYTAwRVhBcE9QVGhkRmMwck9oUzdYODNuc05a?=
 =?utf-8?B?OUtKdDdtZTdLbEQ4L3VtUkJBaUZNUDR4SDVoUGpLUnBYQXVTTVFsUzdrSTNC?=
 =?utf-8?B?alJMZVhlNmpsVDExNGVrb1A0V2NHOTErd2IvcFNTbVlncTRueDhTeEFGUU54?=
 =?utf-8?B?VTZXVktoajZnWDZ2RDUzOUNFdTkzTWJDcFpoZDl0cEZtTm1zVVl5bVhVMk04?=
 =?utf-8?B?QnZhaFVDbVJjcWNqTE4vckk3S3RSaG1XV3V2cEZWN2dvSFYxUVFDZDU1K3c2?=
 =?utf-8?B?MWxkM0dMbHo3K2ZOcmkwRDBrSjVDeGNFMVBmUDU5bFJMRGhIYnE3anV0cTF4?=
 =?utf-8?B?UkhMbnZhWFM0Yld5N3IyaFUzYnJTNlBRTjFsamVkemxqZWNGclJiVG5XVkRO?=
 =?utf-8?B?bHZFRVRzQkJhMkZyNFVtNkZpVkI2TVNpNEtZQ254d0JkemJNSXkwRDkwTk54?=
 =?utf-8?B?R3laOU55OStkYlc2N2YvZHk0REtqeGtNMURpZGN4WE9pZVMzWiszdGxJSEFI?=
 =?utf-8?B?ZlN4ZGdrdjUzMVVBNGpPUzZnak1ySHNUdytTRnlQU2pQWC85aGo0ekZORCs0?=
 =?utf-8?B?eUp4aEpjNWxmeFVUMEZPV2ZSNnhQTmttRjRjenpDcFY4eTBqZEY2WDNrbmw3?=
 =?utf-8?B?ZkJhZC85d1ZyT25VWlRwMDc4dStJNXNNZGhoSStLSGJ3YnlWeUF3cVpuRkNK?=
 =?utf-8?B?TVlFUzlPRHBGM1p5SiswSTR5eXJOVVloaCtnRkRTNXFyMkpTcVhobThuS1g3?=
 =?utf-8?B?OE9XdmpZYXlvTldndWMraVBMNEwyb3o2VGxDWStuNVVRTFd3NWlnc0lnR3l4?=
 =?utf-8?B?dXpoUFFuLzB2Z1hNWlIzOXBQTXZ0UExlMzBwcDhQV3cwZGdBOVoyUitvNGJE?=
 =?utf-8?B?blgxZlh4MG1BZTlkZ2pXRWJDY2tGZXdQb3ZaVU12OUp3ZkxSL043eERaU2Ir?=
 =?utf-8?B?VSs3SDVuMW9Fa2g1OFNPeHhoMUxGRDkvWUxFbkVNTlJzakFyNS85STk3aUl5?=
 =?utf-8?B?dnNCcEVZZGRLc29WZTBlK0ZtZDZOSlVlRHNBSDFrVTVEeDZBd3N0SHFRUExI?=
 =?utf-8?B?cFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 15:00:13.5324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 138cf8d6-3392-4255-de99-08de576b730d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5891

Hi Uwe/Gokul,

On 1/12/2026 12:52 PM, Uwe Kleine-König wrote:
> Hello Gokul,
>
> On Mon, Jan 12, 2026 at 11:21:50AM +0530, Gokul Praveen wrote:
>> On 10/01/26 04:23, Uwe Kleine-König wrote:
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
>> sure Uwe, I will try this from my side.
>>
>> In the meantime, will you able to test the same on TI J784S4 EVM as the
>> issue was reproduced on this board.
> I don't have such hardware, sorry. The boards with TI SoC on my desk are
> only a Beaglebone Black and a BeaglePlay. (And I didn't setup the
> BeaglePlay yet, it was already quite a hassle to make the boneblack work
> with a recent kernel. In the end it looks trivial, but
> https://salsa.debian.org/kernel-team/linux/-/merge_requests/1777 plus
> unreliable netbooting in the bootloader took me several hours to sort
> out.)

I am able to see this issue on J7200 hardware ,

LTM, it may work on certain devices, depending upon how LPSC (Local 
power state controller) and PSC (power state controller))

are managed.

In original code , while putting sync at

https://elixir.bootlin.com/linux/v6.18.6/source/drivers/pwm/pwm-tiehrpwm.c#L293 


will leads to calling genpd driver [0], which may put PWM IP in powered 
down state, leading to loosing contents.

So, we need retain pm count (genpd on in fact) between config and enable 
call.

Therefore this patch LGTM

https://gist.github.com/uditkumarti/6e36ca14423afc06378b8fa447ca3fe6




> Best regards
> Uwe

