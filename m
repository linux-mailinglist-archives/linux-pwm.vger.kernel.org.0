Return-Path: <linux-pwm+bounces-9625-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xH/0M1tbTWpsywEAu9opvQ
	(envelope-from <linux-pwm+bounces-9625-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 22:02:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A0971F76D
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 22:02:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=G1lbQnNV;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9625-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9625-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E68AD300D31E
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2026 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFD83D3329;
	Tue,  7 Jul 2026 20:02:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020096.outbound.protection.outlook.com [52.101.196.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED5420867;
	Tue,  7 Jul 2026 20:02:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454553; cv=fail; b=ZEhkzTR7hkdlnrqsFd7AQaAyZ6g+DFaH/2u9vDaDnLLH+1LLu2ylkFHJG+iDpQfJ4mb1sRcH36jRPKJR77fLmHHSdT9HTEAPDOljGMHkOkc9LFxxf+5b+sryQfDpb8OGjLXx/XOPuX/piUG9eBcUGG6IesGyKodZlHWCmbbx8jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454553; c=relaxed/simple;
	bh=cCSNlYfeohOKK/6J0luGKxD3NCmfDLHfP7PolBYFyj8=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=cX3gBKfOOYu+fiCZJABXov+JIoUcUDYx4Xq4oiX16V7l5nSzTuY+F0NdcRJi3tANRRfIKl171mhuLsCSvpFAZ9ECRJUhjiPd1L1yLjRl/hq4luCUrOAt6EC2pRQ4V1ptqMEZ5df6s1bOD0wRPUsGDP7lOXdOINbT1W7OwfwmODU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=G1lbQnNV; arc=fail smtp.client-ip=52.101.196.96
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+4jPjXk6rSnBvI5sBdvGVbwHFNnXp4RQ4Fq5Imhxhv0h5qL4v3bMnCPbPbizIAz9SnpCheROIXHsGDEbjCXVe7hJ2cUsIwIxTFHphYZeDHLH1dzCOrAN/eYalOB1wwuCyxCWX+qTVxu+e7oHxjNDnZiYgTt27pp8vUvyM1GdyFwP9hhkERsIVth3+66l1pajfLfr991ymvg/5sVMEdPDRjPnr6UtQDnx0p5pDTgDwQ69YQohxihsSH06Fcn8iVN4AZy2i6ChNX8kg0fKAZza0KgMH+JVKTisrJwZl5mL+dkIKsrvln6tqiyUux4WFWs50oqsEovnVaFxptaXgP47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCSNlYfeohOKK/6J0luGKxD3NCmfDLHfP7PolBYFyj8=;
 b=WF1SDu1iv2Dw6fhbBe4S7SIe9RoPmxojv4y+jfZ47yqNT0pBidHH870sK32KetaUs4atubBfS6abvAcihdNRVu/QMUqSZdo9oRDCvhlnnkDl3ErQcfBNIQG5dfOQm6Q4T1qcKaT4d/jcp+qKCBRUbrI9RUSBLAXEk9idHb4aN0emM/nzIDx1vWaFnICNcgMFrPHOxQp3NqNGj9QCnSLhqzVmrYdjqryDPrd+gM8/QU1fHr3kBbKZEhMzvcy+B0erqYDAAlxIdyJ53n44WZs/hYf16CzqCjXWoaDJ0W63ANG5spWOEtGSPEyfRls3frfe/E5kz7xkW6rGc7sU0iAHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCSNlYfeohOKK/6J0luGKxD3NCmfDLHfP7PolBYFyj8=;
 b=G1lbQnNV+UGnPxmYhZUc8NQOYY1kTxiZFjuF5VlZI4ExJ62eTgWGdlBp46c1AjKDbHdHEM/NcKDrcLUtYzfG6gfFkffv7GOjcEfXJyCr9MivmH84SxERzytOI150sru69i0wYU1dDm4E+8G1Gm/jVM5GmDsM9YhYHtvdcWj/BSo=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 20:02:28 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 20:02:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 21:02:27 +0100
Message-Id: <DJSLVGBW90CT.3W3FHC3J5NPMG@garyguo.net>
Subject: Re: [PATCH v6 01/20] rust: io: add dynamically-sized `Region` type
From: "Gary Guo" <gary@garyguo.net>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net>
 <9AC77170-279D-4C0A-89F7-8D07F418AADF@collabora.com>
In-Reply-To: <9AC77170-279D-4C0A-89F7-8D07F418AADF@collabora.com>
X-ClientProxiedBy: LO2P265CA0494.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 964527ab-e269-4429-199f-08dedc62abbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|10070799003|1800799024|366016|376014|4143699003|3023799007|18002099003|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	RRVgLtZc6wFtJRfabuGOQ7KDg8ROpkf7RDU34e5z1Ud8lEvPCbcmTijr9ELHGwFTqALPH92lBiO+N/8Tzxio6OrJrEdnT3RBM4mcSm59epTpCKBvdY+7OYk7ihpBCVUwu4D0zCQahL2x2Uk+6rf/OWMeUaLFnSfA45Tv1xAZO6uLcJjWRpfodEQJi2GlRclyu8r8YCmS8UeOFijZeNmnuhZD5M/+ugj2V2uSx9kYB8vaneNHtOWqY5rt+pWNUNCeuLPROjT3bvQV2YhFkMJIkGwYqUyA0xXdUAybvmmJ5u9r9eyt4xZZgJW/Dx1OdnoWRCHDggSbWKCdI5aHhQ/CwoPHYuWp7L6/b/qBaGRGK1AZmt1G6anVoCDqLLIo2p1nCHkItrJWC70g/cUJFWTSBzujSCu4m+oghdQXMZcgtJwHrsLmr/z2IiBmR2XtsydzATR4I+hNAq3jhZgIP/HF9r9FLSj4tHjnvJAvisOuk+/wNsZa/EgNp2XmLtpqwoxWsuAv9N6JzUGs6VaXnMwE18nGjL7R6YOptw1uXQskbUo6vczv+qNHuGrJGNf0HtXJEgEuYU9fsWXa2AGgHbEQ83u6Nh3IKD3qCdYMm65N/Z0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(10070799003)(1800799024)(366016)(376014)(4143699003)(3023799007)(18002099003)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm9oUjY3bStxK1F0RzBSbkZVYTUwS1I5NFQ1OU9GeEQvNmRhWFVkc25tY3RM?=
 =?utf-8?B?ZkcxVzJQWUlKUWtJSk5jTUtrSFdVWXhHdklHL01RaHJRb1EzL0VFSCtHVEdC?=
 =?utf-8?B?dHpFQWVQeWlkUjdvOG9aVkZ3VUpTMFR5TVF3TmVmMWZ0MkZKOGNNQjdsNWlw?=
 =?utf-8?B?R2o3SDZqVjlFaEFzRERvWVpoNGxEdjZzR25nQWwwQ1dSYUJmVkdsOFFtd1VL?=
 =?utf-8?B?c3Uyc1NMZkQ5cHVtV29JNmRqTGtwNFZ3bnA5WDlUcXo0NW96cXgwUHhsR01N?=
 =?utf-8?B?WFVyNE1nVTRaS01aTnlidkpGeEg2SVRjT3RNRWdzcjVIMTArSXJUSjBQVmRy?=
 =?utf-8?B?WE1MZHhjNkVLbXhBOWVMeFk0b1dpbzZ4Q1JGVk8vR3VFZ2ovVDgvbndnK0xF?=
 =?utf-8?B?dVVjK3lQMmhwN1A1TzNyTGx4VE9WQUVNYVdDYmlPWFdCVkVsR3hKRkNwaVJQ?=
 =?utf-8?B?QU1VMitoZFJaRUR4K3R5UHJTMGtSS3ArZnRWd21JSExuY3Z4cnpudTZLZk1Z?=
 =?utf-8?B?aXdibklVcEhmalhaM0Z2dlkrTU1CTFgyaTN4TitLcUpFVzcvaWZ5VS9JeEUz?=
 =?utf-8?B?Zm9LVzlGZGtwdURpRDBTZXJjQkVBRCtKUEhFZUxTb3ZuTTlFdjVkTHVlUjFD?=
 =?utf-8?B?eCtCUWo4TzAvajdWQ21qZHZLTDJvMWY5Y1V1ZnZ0bldsWWladzY2UWJySDFY?=
 =?utf-8?B?dWEweTdZdnJDY3lxTW1BODd2bFhlQ0RJWDlsMGFnYTNtcS9ESmM5dmR5ei84?=
 =?utf-8?B?azRKVk9uTUYrUUx3MENIN2pGZHo0VWExNUpEVVRQMzFzUmw3UVNIZkt5dGw1?=
 =?utf-8?B?cHZpRzFIeTA2TFk0SWNrTm1VTTRRMnJxeWZsWng1QVpvR2JjRVdMZlVIYUUx?=
 =?utf-8?B?eVVyZGNncjBqOWdYTXRLTE01cHdvVVJLQy9uZHRvY1FNbEZQOHB0WmtpdzhJ?=
 =?utf-8?B?UWIyc0lpUU16azJCckRiU2N5OGIySlNwQUlRdlFEQUdIRldaSFQxUGRxZjRx?=
 =?utf-8?B?ZkZJeEp4VHRnZGpqTHRQWVVNOGRxU3p1Y3BKSm8zMktZbTFnNVlESThhdll4?=
 =?utf-8?B?S1RUVW9QcGZKdDVzNnBEZ0VkaHpoVnpkRHRhaVJQRTlNRmV3Z095TVI5ZDht?=
 =?utf-8?B?cWtSektrUXY5WGswNU1OK2pYa2M0c2Y1cUxsUVJkcEI3RkE3NmJ4TDdvOE4v?=
 =?utf-8?B?aGl3bjRwOGhUeVBPa1k3VjFocWNNNEhidE9lYnQ1dHU5SnNnWFdkRjFYd2Fr?=
 =?utf-8?B?S3NCbENnV3RQOEczaDZYVDhHa3gzaG9TTitkMGI1YzhHL2ErWnlUTWREQ2hP?=
 =?utf-8?B?MlRZK0xOTFJQbDkxa2E2cVdWYTU2TUZvRGkrNDBLeUVpVmpUNXZuMWJYL3dT?=
 =?utf-8?B?Zy9jcFQ0OWY0NlJlVDkyVkJlcXpGTTE0WWZSNkVqeWNEOG4vK1VaTWIrTFpa?=
 =?utf-8?B?emlERHFvOTFyczJQR1pOejFMK1dnb0FLTW44b1dpYXFoUGZaTSthVnBpSDQ2?=
 =?utf-8?B?WFU4aktCdTI1NVBCRG9xbWtCRjV0QTBicTkzYnVQdmovdG5odGd6cy91Y3Ru?=
 =?utf-8?B?VDcyYnoyQzZpTHBxK0E0ZUk3R2VKdFVkc2dtUDFjVy95ZGl1R1hEZHpYNzRL?=
 =?utf-8?B?Z0ZucFJmWHZleDhCQkdMVTd0SDBYbC9HUGNHdHBLemtnSzMvYlRSK2VlYi93?=
 =?utf-8?B?VkVhKzh2S3RpbFdRK2NPbzhuVXFsaVkyTEN2OXdiZ2lOYTZZWlhvWXRBRlV0?=
 =?utf-8?B?N3ZYTEpJSnRvbGtTWGJQcEV0MnpLVmM1UHpZc2xqWmFMSk9XbUJ1ZTJOdDlB?=
 =?utf-8?B?R0lGNStuRlFFd0VLclBjOThlakpZb1VqODg1QVJwVnYrV1hONGFrVi90Szdi?=
 =?utf-8?B?a1R0dHBLMjc5RExXUHZLdXA1MEtuOWtSYW9jT29PUVo3bkRaQmlzUVRUUnRV?=
 =?utf-8?B?WVdXVjJhYUw3T1l4Q2RBc2JRMGcrNGswbGtHNmRhbStjQ25JSFh4b3V2c3hr?=
 =?utf-8?B?dnczVTUwZTdTZEZlM3hJSzZMa3gra0puSXYyakN0YkJ4NlJRQUlUeURzRUlD?=
 =?utf-8?B?Y1ZBa0NmSFU2T0xKb3lLNHlBQVVYazNOejVHVDhxU0NIQnlxV0kyaXpHTjJh?=
 =?utf-8?B?VmZYNXRJeVZZK1lpQ2I1RitBM2hLWVU5Q21IRnFkdVJ0Y21COWxQR0tVZWdT?=
 =?utf-8?B?dGRNaWxpNmFNSXpiSXF1NlBrQUg2UWo3bHkzUDVCb1JJOWZkUnREZG5scGtp?=
 =?utf-8?B?THdXMDh3dEh5bGU3a0sxRGNRblZKWmdjemprZFN2L0ZPRlpmWS9EaGlXcjF2?=
 =?utf-8?B?V0hSVGg4SFVMNVJwa3NiUWhQV3dBZEJ4cHViMzBhOTRDT1dOTEUvQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 964527ab-e269-4429-199f-08dedc62abbb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 20:02:28.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJj+5zxcwk1DulXAwjxjP8DWnQYa8j3jhCXt2R6Ec/DCFNSDbafxMJKLcKVfy+AXNmPdaR4k55FPgojiNglJjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7871
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9625-lists,linux-pwm=lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel.almeida@collabora.com,m:gary@garyguo.net,m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27A0971F76D

On Tue Jul 7, 2026 at 6:14 PM BST, Daniel Almeida wrote:
> Hi Gary,
>
> A bit late to the party here, but going through this series one by one :)
>
>> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>>=20
>> Currently many I/O related structs carry a `SIZE` parameter to denote th=
e
>> minimum size of the I/O region, while they also carry a field indicating
>> the actual size. Proliferation of the pattern creates a lot of duplicate=
d
>> code, and makes it hard to create typed views of I/O.
>>=20
>> Introduce a `Region` type that carries the `SIZE` parameter. It is a
>> wrapper of `[u8]`, which makes it dynamically sized with a metadata of
>> `usize`. This way, pointers to `Region` naturally carry size information=
.
>> This type is required to be 4-byte aligned.
>
> Why 4, specifically? i.e.: I wonder if this breaks u64 mmio accessors?

It does, but if the alignment is 8 then it breaks a lot of platform devices=
. 4
is the most common alignment needed so it is chosen. Different base types c=
an be
added subsequently when needs arise.

There's some additional discussions here:
https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/G=
eneric.20I.2FO.20backends/with/601411822
and in earlier versions.

Best,
Gary

>>=20
>> Expose the minimum size information via `MIN_SIZE` constant of the
>> `KnownSize` trait. Similarly, expose the minimum alignment information v=
ia
>> `KnownSize::MIN_ALIGN`.
>>=20
>> With these changes, it is possible to add an associated type to `Io` tra=
it
>> to represent the type of I/O region. For untyped regions, this is the ne=
wly
>> added `Region` type. Remove `IoKnownSize` as it is no longer necessary. =
Use
>> the same mechanism to indicate minimum size of PCI config spaces.
>>=20
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>
> If MIN_ALIGN =3D 4 is actually intentional:
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>



