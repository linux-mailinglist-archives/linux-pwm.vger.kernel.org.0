Return-Path: <linux-pwm+bounces-8977-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHQPDxc2C2qgEgUAu9opvQ
	(envelope-from <linux-pwm+bounces-8977-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:53:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E6A5705FC
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAD2F306ABAF
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BE4480DF5;
	Mon, 18 May 2026 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pl1CfxI6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C73FBB7D;
	Mon, 18 May 2026 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119208; cv=fail; b=dcXXtfShCJwPqdSDXNas/iD1ybMauTUtDpOoNH5aBk+9aAvNWmqB0IQ/mslTLUKpSwrZ9oPwKNvz+I/rRgh8h8Tot5UovcIttqgND91mXQMpj0qeXnI1xsYc63unpPko65iFLZKibTzLUKOtP2Abqr1DWXGzsLvn4PjxTyJlM3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119208; c=relaxed/simple;
	bh=KPjvj9emmxpviieJ0oZD+xoD2E8SVItaZQ6AffDsyTQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=inbjvgNQkVSMuepneQN91mV7oRxKkPHEU1OEcWJDSb6pVR5o+5eWGrf6mD4Rx+NMyHtT/98rxr3rW7fOApQi9k5XqOECiOX1KL1TwjYizR7yNV3MOVuU1YpunlPVOuLYS3pqE7xT1k0qsoYlQ3Ix51HpPHXgO/NngoKvEKKNmMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pl1CfxI6; arc=fail smtp.client-ip=40.107.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giLwvE3FXMwKhw5K84l+TmTL4D+7yv7REbJXRnSZkf0sMZ1SP3g1pCaSPm3jhAxFHEA/x/PAKVnwRTydm4m60ri1/Ti39GNz6WbJI/3sbHyu4pUZWTLyKB71wOleS/F/4Ba/FD4TkrohMcTbV7qn6VExbW3ZC2G3uL5qRSjSJ1jzWQZksiiX/fONrwQU7zf2NsdLaUklgs3SVpbzF94g3cDAY4ebLRrd0Mvf2cLk+vbmJ/rzRki17QlxpJGl5xSr9M51tJFuK6xgHdOdyIz5h0np216cMLRMmhCiwNhgT91WwyPdk+5nau9BTU3PqpSYoX6cJ5TIjv+JBdcd31VSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPjvj9emmxpviieJ0oZD+xoD2E8SVItaZQ6AffDsyTQ=;
 b=ebv1KdNML0s+Sw2OCIhPtCH6nuAv7tmnAWPH1FQc2KGlaLm6k6UPCrcixD8UJkzzFS+nB/6fZZ4kJoJWcMWHnQ8WYqJZdK1kpq+9dqGXj7Hm7ZyRhjlEIwS+7Fqz15Tr7a4blHukZoP5NN7plVEQyTgvhDcMT8rkmbdKmqyFd0obvY30HRUUjmBGs6jMR9i0hHqugvpOf6o2akvo0BLEnZ7GpxDnB0MFA8sJzdLUzf0b7RHgCNbgE/B3ORobJRPChadvsn92WievKVhdJ8BmK83YQhO12gxxXZUcaJfMrzEB8eXET1Xyyb3kuZmmyNz4+f9PT6rJGXArW99+irr2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPjvj9emmxpviieJ0oZD+xoD2E8SVItaZQ6AffDsyTQ=;
 b=pl1CfxI645FLgWOhYA0rQMEOxLpVM78wyq0uYADpceBwQu1Ddc3www2DvaIa7Kg+GfOMM5xXRtsIRGxXp4G9LM/seb4c6/HVQxUo+OsTmxf8EZ7ANSoht9Z5k7qOUrXL80xzWt6HU8p0XFpb518KIvijLU1qvxJT7E/1OWBNHcIGFm/efV49GUtoYKzQ2Pg1Z9QJ0a1ts/iLAfEfXzKaMbGc+I6B6As9zFkPPil2sxu76+Xy2CA8J80jtUsNbW3MstcdxCd3H5W2T8ZAC94lCKagkneGMhaJoTD2BGArk0E4lyl6VV0z3fwHDisN3f0SQYEiqpcsvQYGfwAKgP2F3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 15:46:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 15:46:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 00:46:24 +0900
Message-Id: <DILX46DSEV6A.22GRBTCULNEQL@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 15/27] rust: driver: update module documentation for
 GAT-based Data type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-16-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-16-dakr@kernel.org>
X-ClientProxiedBy: TYCPR01CA0203.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8f797f-b3e3-4e0f-584c-08deb4f49ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|4143699003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NZMI1PfBJj4DqA/ECEQAMkNYstnVwLwibUsaIXVny3WABnnj7BvGwkYA5TrW9MC2eTepBcOw1sFTC5uMBxVLo5sHZC59ScLZz2vyaIrOSGLroVHmqqi+kQn0j/GprMTlhSyPaaIt5DOeAkl05yFzZBDSESQoyphly0MpWecCWd98f0NA7Ti1rGPCIZlGIcE+csRERnOg+5v3YYCEwhiCIT/BY0EYLHUe9K7ZyVFMWSLhafGmDKb6MHpiMQOYV+j9rVb8QFdogFi4lP1UKv4LDJdA5qlcmaTyehZmPNgcALasXTP/MLfJxm4cv6AeKiJCjj4cM9JY+5bfe9bsGjAQ9UKC+fI4Pnm954cdLoLxqjFIWgeiw8TvOb2FgOJEkhwrJ8SAfbHmYh/dC6IhPb73jIAsFo7x97mqY8drPSp83gAlutfv2ZJXdYz/gsPSSAHynTd+cvAcYsUMsoeCcgaRMmBzwO+4IpcJ7K2GqL12gE0RsleKKdbVHbA5tRnpE4KfckPQwuhB94Pak+P6N5S3c0OP8s7l6TE50Yn4IEOoIGUHkzUNjxbv73WtsNhG/NypJE1iayYFF3TzBEMfHX8KHY5yEjf3UL43WjOHC379rbqc8iXTb1hYr7/szesd91rd3AUvof47T8m+4xhfoxEd1N+jc1T+7zcBb5d0Do29LV78QKXWkkhYiewikJv+9Vmg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(4143699003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkVzMTRzK0k2N05OZEYwY3NLNUp3U2d2dmVKSG9YVWxOZDd2bU14REJkWDd5?=
 =?utf-8?B?YUFDYjBNVFRzK0ZxalBsRWo3bU1qUnBYWnFCT0xkZmQ3WERobUh1MzZjQlcz?=
 =?utf-8?B?bE1wQituWXErY3RqUmcvUjg4NEpKMkkxY3d2UlV5VzJzQmpYZ01XN0hFbDNW?=
 =?utf-8?B?cjhkbWp5TmEvV1VMZndlaVk1bUVMY2pqNW1wektic3dJYkcyMzhja0FhWjZF?=
 =?utf-8?B?Q0c0ZFhYQ295YzA2K2llb3dYRVlsMll4K0o0NkJHRjhaQTdxbUNLaXpuVE5X?=
 =?utf-8?B?VlVqa3BxNXcwdHZGci9aNW8raTB1eXhiY0djeCtzc1BCU0QxRVJKYzRuam05?=
 =?utf-8?B?SHZ1UDhhM0NVSmtUZ1RCa3c0TnpVeVROaDJtdEt2V2tpUDV2Q1R6UWduWW01?=
 =?utf-8?B?ZFd6eGhwZTFYdjB0a09YME92S3FyZHBScDJFSFZyaHV0MTVlZ0dMZElXQlRI?=
 =?utf-8?B?czF4N0dRZDdJVGo3bC9FSERXeVFPNjNzbVVHNVJlTVJFV1lBMEJrYmorZjJR?=
 =?utf-8?B?Tk5rZ0lpTWRDYmxDR1N1d3FBcGhVeHFpNkNRMnZnWW9pUVZsTVZSckZMYVE0?=
 =?utf-8?B?ZHdTc1Y1VGhFQkl5M0wxUzBESG1sZTVSN2R3RndQeW11ZXRaZUZ5UUpweXN0?=
 =?utf-8?B?Q05YYml6Sy9GZkNuOWtQYjBaVzlrOEw0Nk4wcjM2VmhnU25Od0ROd2d3NWZy?=
 =?utf-8?B?UUoyZTEyaXNyZitMVjBQY0NJNUNERGJjN2dUdHdTbmtiejdZcUxGaWRlbnB2?=
 =?utf-8?B?MGluZXZ2MWpXemthNlg2Y3AwM3NZbjcvRnZxRW05NW9yaWhPckVHWEJHNUc1?=
 =?utf-8?B?ZjFRU3FReFUxUHR3ZDNBNG1Dcm9weVM4V0JDU1ZjNlFIL1RrVHAvSVJmYnNB?=
 =?utf-8?B?dC8wYW1iOFdEQzNSVGdPWDdBdFd1V1NxRFd3azU0bGxwWmo2Zmtia0pwT3FJ?=
 =?utf-8?B?R0hzOExIMUp2ako2T3Z6TXFGM25FU3hoU3pkdVFyakJUdlk0T1RBQnhBYVZ2?=
 =?utf-8?B?eXBBdGhXcGpSUk9JL2NtVHFmV0p5VFpydldGVzlkQmdLL2d1bkRiMDd4b0Zw?=
 =?utf-8?B?M2xMWjN5RDMzVjBsQnNlMDB5Z0trNlR5aFRldFFMK2ZpYUlVUVpNWHYxa04z?=
 =?utf-8?B?RHdZdno3MHAyeWZ6Y093eUV4U0VzZDF4UFYrMm84cU1FYWY1ODBPMkVDN2tZ?=
 =?utf-8?B?OGZTOTNBSlBhV3hxNk1HWUpqTmF2NXU1cHY5K0tHVnI2ak9SSEFwMFF6dlpu?=
 =?utf-8?B?VEk3K3JIZU9sTnA5TWJQamJpeXUxZFNCUFAvYXZGTnV1TUxHZDRObm9JdUZJ?=
 =?utf-8?B?QW9HdVBnd0lZaG1RVUpnNFJBMU9uVHFFQ0gwYkh6bkoydnZ5YlU4bzYrRGFh?=
 =?utf-8?B?c3FXZ25mL09PdktDL0FpV0RpMEphRGNteThEZndrV0liVVpwUlprRGlEa3Jq?=
 =?utf-8?B?SXo5QkMybDV4MktURFZuWEZ5Zzlia083dGtzalJSZzhtTTdnSWN0bzFxRTlR?=
 =?utf-8?B?TGUyRytoOEFmMW5VWGJ6NUVRR1ZEd3BjdXp4engrZkZoMHVNVUNneUNPby9N?=
 =?utf-8?B?NHZVd2F1bnVDbmdVNUZjVTRldzVQUzZUSE82UVZHOEtWcUxvVnNoVUhPS1F4?=
 =?utf-8?B?WDJkYzJQU1hDME1iWHQzNmowSWRJM2pXY1dxYTI4S0Nwd2FNZEtsNHR5VFJN?=
 =?utf-8?B?R1J0NG1tOWxmRXNaVE5sUmpOdlp3b3RORUpsVi9jcC9vZkJLdU53anhBQmkw?=
 =?utf-8?B?ZWFoNFNRQVVMb1dnVndyaE1XRHY1aGppOExZTThabUk2MlBlS2p4WjdqMVdR?=
 =?utf-8?B?b0UrcXAzRmc2ZTFjaUt2aWZZMi9aTEltK2tHTXYvcXh0TVQwalRwMlZMVWxz?=
 =?utf-8?B?QmVEWm1LN25DT2daQVY3U2tiRWF3UE1XeW1MNFJTckNhSFFINmZ1dGlGaEN4?=
 =?utf-8?B?eGtJcVFuM0hzNjlRWVF6NzVkUGU2MzZSUnhjNU1ZekFDTWMrZ1VTeGpBa3RV?=
 =?utf-8?B?VTZLcFZsSktvaldhVnJxR3dwUjRwSzBJQ0RkVU5ScFVFV1ZYVFcrVEZEb1NX?=
 =?utf-8?B?ZVdKcVo4d2Y4cmQ1blJ2ODkwdEdBbkI3UUR2d1JWdlQ5Yy9OMzZCU3BTeDZp?=
 =?utf-8?B?L3QxZXNWOG4xZzFId2dlU3ptU2c2R0grRENnRGY3cnl6bGZ6b1pvS1FmOU5w?=
 =?utf-8?B?bU14ZVpXMmpSaVN5UGllQnVnOVhaVkQwdFo5TE9ldytpNW9sUHFCNm9xWHFF?=
 =?utf-8?B?a1ZTbzl1Vy83S2NBZys3VEdYMFlRZTdlaWY5QlF6T0t3dC9JaEJrS001Unht?=
 =?utf-8?B?aXh1bk5mNU1VNFZXaHBQOE1JMUlyTnBDWU1uQUpDLy9Gb3V5eGlnRjFDOHdv?=
 =?utf-8?Q?2QoXHGBQvswuUKQB89v12Sh3HocvLkRu5PHBjzCc9twCd?=
X-MS-Exchange-AntiSpam-MessageData-1: vsMinfR2al6TMQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8f797f-b3e3-4e0f-584c-08deb4f49ffd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 15:46:28.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8mx/3gJt+M1N1A2pTHIJo2+COo9tpch7nR1TiTqD80KJ7wTCefdqaBzQG/JnHHoKNs2BOTA3mR0hk/TtdW3Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-8977-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 23E6A5705FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
> Now that all bus driver traits use type Data<'bound>: 'bound, update the
> illustrative driver trait in the module documentation to reflect the GAT
> pattern and lifetime-parameterized callbacks.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

