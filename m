Return-Path: <linux-pwm+bounces-8976-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id snz6Nak1C2o9EwUAu9opvQ
	(envelope-from <linux-pwm+bounces-8976-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:52:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFA6570568
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A25713080FA7
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 15:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510E73FE34D;
	Mon, 18 May 2026 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kMH7/M0W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA073F075B;
	Mon, 18 May 2026 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118926; cv=fail; b=LILItxo2Xvob+z1KaanVewv4xI5BTt8O4s/UJr7syjSeFZhP0PIcOf+0XaidZZVF7m2ADxbrJA+RgtevNOf2Lo54sMC0wBO4Ex0XqMBTgqiZYehnc9YTpiVAZFgQolOH754GEJv6/kyuCWDOAuNUsrSEFkXlB0WcM2pIN6vx2Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118926; c=relaxed/simple;
	bh=ViY3bm2bC8Fu7h41iHOKOmXCLh4gRCw3++oGcTXTdyk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=q4IKdrWrFIHSn5x8dhssBxGuflqyj4u+zMjuflF0bp8mx/jsudos2mOy+YD+V3boN3vQifZdPQHy2JTRxeEesZwv4nnZ0oU8TPHd6RROIH3QXfIwOEl+DeMbFa2TqkoVDiKgP7cGAW1qjux/jR2TdeI0WMnGca0jLx1GKSUhBlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kMH7/M0W; arc=fail smtp.client-ip=40.107.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Be5HkI41PB5G/qBUB6ujSOuvvaR7CSGTc2fpI5Yox/vJ0ia38Sqxhe52h2+MCSG8UVKE4ZkEfHIHkxOWQ/fmrAUvhLhh6C4FBGqUOlp8jf17VjMwvCgubsrd+ZwniMV+ufMty9zm67g1LREsww+iSdvL/a39iYiGRdSkACSeIx5k5HwCOtyzcxHZyth4T+4tIAeH+NHZ+/huAqQLWjqz7wjz6vvsJAvmdVsoMDKnGcDZx7g8sJm7AoQAAkVsQjNOK1VwNRanhaJAciaH/yXmyygVOFJrGdyZpvKOJsvDBl4smxXhuy5sRPn4vkRgywuZ0GBUhhySIVM1+VsyMLvgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViY3bm2bC8Fu7h41iHOKOmXCLh4gRCw3++oGcTXTdyk=;
 b=FNFSQ4mVOBjZNtimr5LTIk32Kkex3EXz+HW0Xmnay1/Nl2gCGfg/yv5/besRsVke8SM0FyDcT3hBh53n/P6oGnYsr9MTZ6pbk1YOA2ZNdp8mpmP/22qxCypiAxlRtvmGIKY77oaH+cRRqtVAQRPq7xH2rnWs8rdtZfdJccQdd6t8AheMoM8XGEqa2XtUKYZ7IWwC4CmNyaL02a1MuzZ51votNzGakQUSer3+r7NRH+HbO+He5oqRMzDnVL4Id+cf4muSiugJVaUTqvZ2bEtJfThIkh6sOQKuDtt0uNC+e+NPsU71k685LcVX1T7QMitQkF63pKLxEvu188ttnsMf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViY3bm2bC8Fu7h41iHOKOmXCLh4gRCw3++oGcTXTdyk=;
 b=kMH7/M0W4Az7w8l4yFCNWtyNlWZWQrvPafbuyLPTC2zBfZhs0U5tlyEW68CF64oizaYIoxxyXOsClDYyWViu2yPnplVjSIWqczlw9uTfTIXpSXzJO1qVpjdv/GWL9X+gB9EU7GfOvg8TWJDqap5ibK4LlybIn2UHNDCS9dKH5Z9hb6T/0eq8Ej/RR97Z75m0lPyCVp+dd80oUAyJw4AzdI8fJv8yEvq4k9yyIfiJzLy7Ll2AYdICOvOqKLu9Ubxp5T2ZUnX/8ouLTmk4fHQt/nNDjQsjYqxDQ7Qy1uAUy7QWWiiLYmyqQJ4LEbHLND5jjTxvhzZNbPL715HNqDpvDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 15:41:55 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 15:41:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 00:41:51 +0900
Message-Id: <DILX0OR9JATR.2OO0HM7QBN5AU@nvidia.com>
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
Subject: Re: [PATCH v3 14/27] rust: i2c: make Driver trait
 lifetime-parameterized
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-15-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-15-dakr@kernel.org>
X-ClientProxiedBy: TY4P286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS5PPFA33D606F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e8fe79-ad86-47a3-b6be-08deb4f3fd11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|18002099003|22082099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	wxFOcRBaBQ1JEoMWSHlnjdpZV/AGlVdras2r8fJg7L5hQNR+6UD4hlho2ivf9EEun/CQeWu3JBlEO2YTS5nvFBbp0QcsifSsf/6TihO0XfsTwAGBo7iYptMTYBg4sbMYfNi03A01EyrbB3oZbpcjVnn0QHBTERcVFHU8f9zXKg0mmSthGIw6Y0l/sYeXbRfpJgg917HA412YlmHjYUm7ajMGckAaQO03qHmMSzP76efl5J5GL6JlSHRVIAHNDnLPC1Pca4Jt5CjWK4dRThXePWV0k7X4/rfqyLdn8aaDy/sgAiduTewKbHHqD6C5cN/UkHv6sXhxZ4rsnOajEfh5ccpZI3c2r025YDG0A3SBSjK2aIbbMY9j1UPvQ+Qovn41e72Brk4mzAoosr7TvFQZn1OnM4NhCQShkQn/LLAYQ4l1vs61eNVZqRP8JS2bbrQZKMv9C7iIXIvnp0Mb9gblQDRPHoTLCCJxkqVGY7+TKM3GRa231as9szV1Rk5P+2ullV3gLEuFaJzOGgAXmM5kInIGI14vsJkSHmToK9TyTdpSXupYBC+wLjqX2or3zSvkmLluT1VQvReuV2wp3AvL7fuSGFwRXek8qP4yqCYjbmq7NjNAJRBaV8sJ1sdu4M8qNAUUj9mJIqQUUq1cfFIFEDN8APueG+8gxji8YFh3awaH2+uuE9oRDzYYrYB17e2b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHprMTJtSDRtbG1LNXVDQ2xWVzNEMEtlWi9BbGFNalR6cmVWQVJmQ3BXczZI?=
 =?utf-8?B?TjlDaThSd0IrSENoVVdYU2tyNFJ3cnRSOU1PRXVRbzZ6TWJacFh5OXJRVVBE?=
 =?utf-8?B?NjVzdXY5R1FMelhqalNtZ1RpT0xySEpqZUpCK0NoMUhLM2tZNGlGRENLS1cz?=
 =?utf-8?B?VS8rOVQ4QmlzZG04OUNhTnR2ZUEyQXZBMlFQUVRRT2VRRUJuMldBYlQ3OGFR?=
 =?utf-8?B?cXlpV24rL0ZiZHlhbk9DRzUzV3ZqZlBtNDVYZzVyV1hsemtzM1RlOGZwbEZN?=
 =?utf-8?B?U2QxMnYzS2lpRFV4RUkyUTlyK2t2RmQ2dFlUVlEwWjJLQWdlaEFqYTFWdjc1?=
 =?utf-8?B?NHBpTTExTmlOOGZUL28zOTNMY0ZIb0VDSEw0MERJWTA2V2dhbDdSSm51cWFI?=
 =?utf-8?B?THU4YnZtTzFkWTdYV3E0QytVam5YVDRiQ0hHNjBQSmhwanFuN2lyQnhLalY5?=
 =?utf-8?B?ZmZpZkJ4THNISDh1WGpXUGlkcXd6clBhUHE2czdkWWNTNktpU1pkZUxNVHAy?=
 =?utf-8?B?MVNSTnJEVjAwMVQzb3FxdklLZURTeHo1bE9kUWJPRFJoWkhYTXhVZXdNNER3?=
 =?utf-8?B?dGFaa1Y5WkU3WTZ4Wk1nMjIrK3RjYk5rUkIyMFhHS1pHL0gzYkZLWUdiWDAx?=
 =?utf-8?B?L1JJZVlFUGY5WVVVRVFydFJWZnZpbm80ZVUvM1FIakVTUFhYREFNN2N1T3Ro?=
 =?utf-8?B?c29WQjJlRXZNL2t3T2J1Z0RTNjR3OEQwYnFVa2xPb1RsTGxJNmtTU3c0cW9U?=
 =?utf-8?B?SWY3bHJnZzIvT1N0U2dCMERmZ084ZWpCK0ZQY2lEKzQzcndaTWdvSlBzK1lp?=
 =?utf-8?B?VXpyaHNHRXRycE1rN3dTSkRhaVM2SFByNnZHcUNEK003NVc2Ky9USkJXRUZk?=
 =?utf-8?B?UnZEd1NzNEFMZUtBTnpFZmo3bzVWOVIrZE9VY3FXY2lmaURRbkI5MnM2Q0FI?=
 =?utf-8?B?d1ZqSjhRVUFCMVlLaXdnMDkvLzBNQTlodXFUWjFQdzlZcTJBcjJndnZDRXBZ?=
 =?utf-8?B?ZFhCa242YTVWZFZpMXlMM1BzRE5HL2syeWtHdVEyN01WSkdBVTN5YlQwRTJl?=
 =?utf-8?B?czFodDlDSVdSTFlGOTBaVTZPSXNyWGRlcmh4QnVPZ2ZpQjc1VjljUlZXak10?=
 =?utf-8?B?SWcyaGFEY2pROVFIUytRMDlLTkdvcC9BbEpUZ2dzK3JXY1lucDI4S056MjZL?=
 =?utf-8?B?OHlRY0RRWDNEMFVFejlmMFZXOHZmdWE5NFpWTGNhNVpMdXEyN0dzZ0g0cjYz?=
 =?utf-8?B?emc3ZjAwTjVESHhxU0UxYVJ6RzkvaDVjNjJyajlnQnBDV1VMY3A2aEdUcHpU?=
 =?utf-8?B?a3VFN1duZEhmckhPcW5CWkhEWVVVdEloMHJkUmdqYVlmVDFvTVhJMTUvR1Nx?=
 =?utf-8?B?SUJGRmYrM1Zod3pWT0NYTXQ5UllVK0tPaXRHTTJYTkNYRXE1cFNLVUkzUThC?=
 =?utf-8?B?TWE5Z2RtSnB0cG9VaVI3Nm1QNXpGamRYUHMwZnIyVVFndTZwZ2RkVVpQVUs4?=
 =?utf-8?B?Y0JlMGpycENVZVgwRE02cmFVTWtPM1BLRjgrOUdnUlRXZWdUVmxjK2xGYS9T?=
 =?utf-8?B?QVZoQnU4UUVkNGI1TTZoQlVIbFA1NGhIbFJ1VXA5SUxnbUlRd3Bha0pBYVhz?=
 =?utf-8?B?bG5UQnFPSTRWVVViNGJvd1N6RU5BN0k4Yi9TTFB4Zi9BdFpXbEQ5SXR5Q1VY?=
 =?utf-8?B?K1JwbGJlZUhLU2EvZGMwWVBlSmZzUDBYdkkyMGNCZHpyWmwxQVdJN0Z2QmdC?=
 =?utf-8?B?N21uMGN6dm5iSmJ5b2ZvVDE0K3NnS0x3V3hBUFZrRWNLY2dWN2Q0Z3AycVlQ?=
 =?utf-8?B?ZkZsVW93TmZFU201NGNIVW1YZUdJdFRzRCtZejJJU2QxdVBaTmhyTUVCY040?=
 =?utf-8?B?b3RFOWxUNUJ1d3lJZUwzRnFnL1FxN3J3cElPRTNhUXZVT2tWRGFDbVY0SmNP?=
 =?utf-8?B?YVBHaDJBeUhjTjlUODNjT3laTDl4VDlPWWYzTmFpOHFQc3ZETXJGOGN5VUNG?=
 =?utf-8?B?dWhsdDRnd2xtV0U5OWJrM083Q09hckpIMUJTTmlaVVpYZkdhd3FnRFlEZjlV?=
 =?utf-8?B?RmlBcndScFgzSHhZR3hLRW1iTVZlT0l2c3ppOGdPSU1oOUI2RGcxZ2lHMWda?=
 =?utf-8?B?dUpsVGZEYjVJaHdDU3FWZlRXUnNZWm5iSm1PUEZxaFgvVzlVbFZqb1prbVJX?=
 =?utf-8?B?TXd2T0pWVnNrRzJyb1NKOUl0d1lpREc1UEFiVkVkTGF6a2FaZkNxTGJsVGNX?=
 =?utf-8?B?WkNPV0xUdkd4c3NCSWlCTitGWm90cDU1emZ3N0dlcHZYeStJMjR2SzJFQUJ5?=
 =?utf-8?B?SjJoRUdqV25LY0RJeDNYNHdyd3VCMXlWL1hTWkV5TlZjb2gyZnZtZWN2MU15?=
 =?utf-8?Q?MvvTl6FAfwnbGslnZWmRhCC53BIj+rfc8bj6Y9PGlXOWn?=
X-MS-Exchange-AntiSpam-MessageData-1: Xx7G0hPD+2bO3g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e8fe79-ad86-47a3-b6be-08deb4f3fd11
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 15:41:55.0684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+QiD+lFZEwiVFpDzVCLcEDP5RiBVA/KbATrbcfvVQfJsbHrsSBB7e4llAF6xGRIOYPjUcC/SniCiO0GHBugBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-8976-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 6FFA6570568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
> Add a 'bound lifetime to the associated Data, changing type Data to type
> Data<'bound>.
>
> This allows the driver's bus device private data to capture the device /
> driver bound lifetime; device resources can be stored directly by
> reference rather than requiring Devres.
>
> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.
>
> Existing drivers set type Data<'bound> =3D Self, preserving the current
> behavior.
>
> Acked-by: Igor Korotin <igor.korotin@linux.dev>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

