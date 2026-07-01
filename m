Return-Path: <linux-pwm+bounces-9500-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wO/gMTCIRGrbwQoAu9opvQ
	(envelope-from <linux-pwm+bounces-9500-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:23:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BA66E9718
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:23:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="r2pih9/F";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9500-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9500-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B85730A088E
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 03:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D63C363C43;
	Wed,  1 Jul 2026 03:21:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673635A38C;
	Wed,  1 Jul 2026 03:21:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876079; cv=fail; b=PnEKMqEEsyJCZTtpq1kN3rIyVBYS63xAAtL462v2j9epzmaqG2cKYyjub1KfW07usdyOLywNUQb5TZ8V7MHtBk8vwZryPnHt3a2d5pZOd4fmkbvSJHmX6gCj6f7/MV4Y1LO0KnZyNvgBga0jN71HolubEMflfLkrLYcA03AM8gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876079; c=relaxed/simple;
	bh=sBi8SdXqothDkKIsBbL9jwhHpo7rTWoqUuxxoxaFI3o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rNGR6Q0K5ifv6Ap6cOzePsE0Z7J9KnnnZ7UGFJ6wlxQSPrGYBIhRbHb6AOjMFVdk2Oo8dKl+hK8dJZnm05vtEFV1bDBfsdAAeO5PgCJkjegkbaxhI5+HKbCGQvm4wNm+n2YHAxkqgPjEIIFLWwuTepAmtyQlzf3YTOhpz9E2vuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r2pih9/F; arc=fail smtp.client-ip=52.101.56.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCPV3NY2t3WHZpuM6k3hC0pkLQNGx9ftGFlAmCFSRBrKF559SNk81Rcu9RVEgTHWq6c1hAc7kelHp5jtoPcaqORveJxXtaDERb7DKkaffGx7a1dCf/xQ94ByrQJYNf5J0jE+VUDh9c50HcEArHszhxfaF/YooURJ7Nmqb1Vgg5Q/LU5dzXriomwwXjdKmhr3KjEoi/VjEW09SJ/gT3rvN23INXwsSlG5ML4m7EQSLr6WATgGwnubsYu7EXFP3SJAeAQo246Ex/qCYJV8DgSX16Y5pIL9HWxWPffUnI50eUDox8ODpflrwnq+TUYtjY7rM2KWornJFhRziF9qF4/Grw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6sIk03QmOjPpQFa7ubKXNkkl/qOKarkJoBYWMbNMD0=;
 b=pjTAqy9kWVMwrWdHXjKd/Ikjp+IXPFr3V0Q1bbcY0SuX4eHJu5TaYG139TfSPdTDZKcUAM6mxk+sSArxCqd/cmxcgjIv9guWgyzirzcS+SfWCX4UWYhchJbsMfd6asAt0momL2NDzHBFUckqd8WE8IZ+HnNmBUlbz+0e7JkF9iYUUaNyHgZd+SrzO/Uy2dJNdmFQ975EArhos82xMST3xBPGUVyTW6uofeZ1A3pqwX8taZnhis27iQwKv9XHxG0H+3FdR8xHnQPkEXBlAlLvqrVKQq6xKsr6Iw8qWUmPiOAudIWDhN/wTB5pt5ziMmMe+N4FCyegG0X4w3TO2SLUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6sIk03QmOjPpQFa7ubKXNkkl/qOKarkJoBYWMbNMD0=;
 b=r2pih9/FqiCbwiKRxGQTl1mVVyU8xdMcUltv8C02ngdVdjLgwYRpfUWL52MIstmYTORwnjFQXv3uFjApDzdsdXjW+ikRG5+CnQ93uYNj4gYbhHNJldIx6jdZ4BwAmKTNYhotOARwDAy8vD04O8prEJdlafAqQ6n95eWgsxH2zRiXSCFViA2BU+xqbJZtjMj2/V50TKLyWjDYjA9Ery1Qa0mbGXzvDEBUNhnj6FsH8lfTtQLBidnmZtOBiJkbZWcd/LSm7WyHeixtXVf23aP2dCedQCY2vaDNa8jTEfoGhnOCn0ZhvXmPOHOFgYnb3WL9b4S4S4TBtGDy5x8RUN9NlQ==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 03:21:14 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 03:21:14 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 01 Jul 2026 12:20:33 +0900
Subject: [PATCH v6 4/7] pwm: tegra: Modify read/write accessors for
 multi-register channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-t264-pwm-v6-4-2718f61f411f@nvidia.com>
References: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
In-Reply-To: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0079.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: b67cd1eb-f533-4f99-f5a6-08ded71fce3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10070799003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cQ3m/j4GNqCHIz0pkMlF8JtlPDvr1yd5RVsTirLqhqYNsmqPZdZTERr6IgbUvOU8wnhhvPWPsuPJwIRtBAaGUN9Jvc9bDqvV1Z1yEmo6wTzQ7EHbKhZAqrJDOvYzntyBF4yR5K2+mY3zcvQkm0GOfTEhwH/xWh96xWBBSUpnNSY9/mAPL0i3wIFSHUyFZjHi4oXkGySiBHtLngjQjT0oD1Z1ETsDUAQbPotkDbIJKTraAaNk9NmAwzMKHbe9jJA8cZMdvmEbApINJy2ctPqMw18+D+85TViS7TNuFiBH0wkgEYKBS3chL7zcVRkN7u4m4rvJuu5an4+7dWLub7zVrAM7K05RMTteiOshHH+spvjIaZGPLeB8fY25E7gKLPkvRCBdo1959GV5qhqSkOGpmxLTzXzt6O7ddLtroMbRHOOP+hPPLwFuSAHxV2nMgVjCJ5pcrSDmNKhUohOKu04sGzmv0IDzkXBoINAVVUUAuy9GXmlMnoM7HhacPloHiaU7y3VYVsu6KI+YFV2BbxvO38yMjzGP7nKCD0V8406R32r6QIoSJS1Skn7yTrsUOLsefSFYAQM0kEgLVFh59QD8R4OrMMQgR91KgXAroeSt27aiige/TaCYaUXriJXUoK/p7NfcHyt+S6u7Ur9VSdWX6K3S/xT7qTawl558QJ75FfA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGhvQ0dkbmRQSWxYKzFTTXByMDdZL3NrVks3VjBrcWNtU1V5d25rYmFwVjRY?=
 =?utf-8?B?ajgyUHpaR0czQTQ4L0tYTHQzQTRSQjFuek1uZlF0WkxrMDdLUFZuSG9DZjla?=
 =?utf-8?B?RzYwVnNmaFZNbGVqWUlyWHpNd29QeHQvZFBVQ29Oem5vdjlWbHBBR2EzK0NI?=
 =?utf-8?B?YmhKMTEya0pEbXZQQzFLZUs1TEtwZGtnZURicVpzVFlXTGxUTFVWSFVoYWM1?=
 =?utf-8?B?SmJtSldreEo5akRwL2w5VUd0VVpRam5JRnEwS296ZlY0enJOajdkYnZiRGhM?=
 =?utf-8?B?clNNT21XcWVqTWJLMWs4VXpackFQRzJTb1NpUmJobkpzWFcyWUpmWWVIQjU0?=
 =?utf-8?B?eGJlS1l4M2JHV2tRcnltaFNtTkVOc2FLUHJaUGtqbWM4WDVYcVFLb0pFd25x?=
 =?utf-8?B?ek9GMkVHdTIrNFdYeVpDRzVTaWtNQWl6bEduUWVqL1JnUXA0MU8wV1I2QUx0?=
 =?utf-8?B?NGN0Z1NQajAvTDVOK0hjTnF6TkhvcUUyQ2dVMTJHRWJldWdSTDZzRjBMSjU5?=
 =?utf-8?B?eElBc2l1bnAwYlZQcXRUSDMxaDQ0aUlKUEc0VzZaemQ5S04yV3cvRUxnamhD?=
 =?utf-8?B?TmhnUS9pVC8xSFZrZHBUQWZnb3lVWGJNSE1WZzlFMXNzL3NDTmRXenFtK1Jz?=
 =?utf-8?B?OGNHMGtKdzlwQTRYRHl2MnhRbmQwMTl3OTY4UloxWGZtdDhqSG5IaE1jakMr?=
 =?utf-8?B?Z2RXWXpPQjNkUVhuOWtFeDQydWY3Ymk1Y2EwWDU3YzAwLy8rdFFBUTFGUWxD?=
 =?utf-8?B?K2NSTTRKVEIxUkNTT2tYb20zdTc3dlJtZGFSSzh3NXVwTEovK1hkcW9icUFX?=
 =?utf-8?B?NHNnSHlXalJIOXhsVS9NYWZvRkxVY2VyaStHU2h0T2N3aTFwVlVKWWtPREpX?=
 =?utf-8?B?cW95VlVyKy9RaW4xbXJZaEgrL3JSMU5Ra0UyMGJwb0hoNStNL2dTT1FJVUMv?=
 =?utf-8?B?VnFDcTZkdkFEVVpJSVp4UytQYTRLMjdJdFNkU1kzWlFvR1hRTThORlpocWd2?=
 =?utf-8?B?YU12WkR0N04zbWlmekVUZGNxV0Y0Y21ROWV0Uy90M1V0Q09tbUtTdHFqaUd5?=
 =?utf-8?B?N0xRa2VLeGtnYWlXZzdDUWdkWGYrMjRuTEJ5TEJLeGxlMHhXdWtKbGxrNk5M?=
 =?utf-8?B?ZnQ3QUxTYzlXei9EZEZuT1pOS2lrSEtlMm1iL3V3VmtablJjSFVwK3ZkMGV2?=
 =?utf-8?B?YlZ6ZFhLeWVpcEV2T0FwcVFZQVJwaHdtMVlFTENVZzZNTmRiUDJGNWRrVW5W?=
 =?utf-8?B?SjhLOVZMemRIR0M3Mmg4NkpBeHhTdmlIRkR6Y2R1WUxYY3dyU3A3V2xwakNx?=
 =?utf-8?B?VlFSSWRNNlIwajUzQ3A4ZXJUblVKTEFHcmhTRVRTZWMxM1FLSzdSOTFmblR3?=
 =?utf-8?B?clR1bXhmQlNCbnRUejhIU2RjZHhwYTZjemxyREtabEYwcU5UNGRiUmRvcXJQ?=
 =?utf-8?B?UnRzY09rUW4rTGRnNDQwZWtoTysvZUl4bFo4REc1MklZVGdHbmtMeUlxd3Y3?=
 =?utf-8?B?NTRqRm1Hc1BZTDFjQmRXTmpTZUVhTjZsTlQzVmtsUUFhSWJyWFIyNEZjRlFO?=
 =?utf-8?B?WmdRa0h3Nm5hQllhb25RTll1ZzFtYUNZNnZtRUFlYzFiVk5QR2psUmRQQkk3?=
 =?utf-8?B?M1JUeXNKckVlWVZlVEV5aVBzclBlc09JMWZSTUo0ODdqZ3g1RDZLenJMWmxx?=
 =?utf-8?B?OWl5OU1UUFNoZXBEZFhiQUNualZqMFQxcE1aZjk5QjQ3dkw4dGVYODN0aThX?=
 =?utf-8?B?UmlDMWY1V2FtaUd1UEp0Y1FVb2FYc0dNVmRtamZzK0wxcUFSZGZnVTRzLzFD?=
 =?utf-8?B?NlptZ3VKRjRkSkJ6eTVEZFlOK1Zub2hIS3A4cldmOU1jQzhvcXRFYlB3ZWUw?=
 =?utf-8?B?ZVNHSXlRV1VEOHhpWFVFU2hKbDE5MG4vUDRRWTdLY1NCZjg1QmpxZDkyaFNR?=
 =?utf-8?B?TEt3N3RzelJVVFBtZTdJSjIvNVR0cVFySDlZbWcxekJIVlNRd2VQaDlsaHZ5?=
 =?utf-8?B?YjFHcWNwNUFGS1hQeUV4UU0wZ0xrdjk2UGhuaHR3OXoycXZuY0g1bWs5MHhQ?=
 =?utf-8?B?U3BlL3VOY1VxQUxWdnNobXBpV0pRdjFwRWxVRTVMQ2RJblFLdTRUL0tyMDZz?=
 =?utf-8?B?Q0dIc2FGL1N2MEtBT0N6VHZqbnBBeWZtdUtaQ3JHdDlMaGNqdjhJNFBRU0tL?=
 =?utf-8?B?eFZiRlJtaXB3QkRHMDg0eCs5VnJadUJCYUUzRVV3M1N1bE1FZmkzT0NLd0xG?=
 =?utf-8?B?NzY5NmZucGpmWVlrSUlaaTFCdlNjbUt1cVc1K1R0NEUzQnBuUjErU2toMEwr?=
 =?utf-8?B?V3FlUCtIdlFBN28zQlFOMHdFaWtuakFGUEZadERIc0VZdDdaMHZLVS9wNDhS?=
 =?utf-8?Q?zd0gDV4SMx6j//y5binsLMbV/nCVvECJpz9C6u366M/c1?=
X-MS-Exchange-AntiSpam-MessageData-1: 546/vJUe0Gaddg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67cd1eb-f533-4f99-f5a6-08ded71fce3d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:21:13.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+ZKEvURkzBClGgxiyyKeDDppoIUshMZ3NQdCXL/T9y7QjOXjiYC93zrKTVgFBNy/fXtTe0kdV/OKFr3nAH5gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9500-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@gmail.com,m:ukleinek@kernel.org,m:jonathanh@nvidia.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:mperttunen@nvidia.com,m:thierryreding@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42BA66E9718

On Tegra264, each PWM instance has two registers (per channel, of which
there is one). Update the tegra_pwm_readl/tegra_pwm_writel helper
functions to take channel (as struct pwm_device *) and offset
separately.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 3eef299c51f8..55a3e8657013 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -57,6 +57,8 @@
 #define TEGRA_PWM_SCALE_WIDTH	13
 #define TEGRA_PWM_SCALE_SHIFT	0
 
+#define TEGRA_PWM_CSR_0	0
+
 struct tegra_pwm_soc {
 	unsigned int num_channels;
 };
@@ -78,14 +80,18 @@ static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static inline u32 tegra_pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
+static inline u32 tegra_pwm_readl(struct pwm_device *pwm, unsigned int offset)
 {
-	return readl(pc->regs + (offset << 4));
+	struct tegra_pwm_chip *chip = to_tegra_pwm_chip(pwm->chip);
+
+	return readl(chip->regs + (pwm->hwpwm * 16) + offset);
 }
 
-static inline void tegra_pwm_writel(struct tegra_pwm_chip *pc, unsigned int offset, u32 value)
+static inline void tegra_pwm_writel(struct pwm_device *pwm, unsigned int offset, u32 value)
 {
-	writel(value, pc->regs + (offset << 4));
+	struct tegra_pwm_chip *chip = to_tegra_pwm_chip(pwm->chip);
+
+	writel(value, chip->regs + (pwm->hwpwm * 16) + offset);
 }
 
 static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -194,7 +200,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	} else
 		val |= TEGRA_PWM_ENABLE;
 
-	tegra_pwm_writel(pc, pwm->hwpwm, val);
+	tegra_pwm_writel(pwm, TEGRA_PWM_CSR_0, val);
 
 	/*
 	 * If the PWM is not enabled, turn the clock off again to save power.
@@ -207,7 +213,6 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int rc = 0;
 	u32 val;
 
@@ -215,21 +220,20 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = tegra_pwm_readl(pc, pwm->hwpwm);
+	val = tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
 	val |= TEGRA_PWM_ENABLE;
-	tegra_pwm_writel(pc, pwm->hwpwm, val);
+	tegra_pwm_writel(pwm, TEGRA_PWM_CSR_0, val);
 
 	return 0;
 }
 
 static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = tegra_pwm_readl(pc, pwm->hwpwm);
+	val = tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
 	val &= ~TEGRA_PWM_ENABLE;
-	tegra_pwm_writel(pc, pwm->hwpwm, val);
+	tegra_pwm_writel(pwm, TEGRA_PWM_CSR_0, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }

-- 
2.53.0


