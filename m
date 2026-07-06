Return-Path: <linux-pwm+bounces-9595-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MzlOM1mtS2qHYQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9595-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 15:27:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D3711434
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 15:27:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=TbITF6qq;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9595-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9595-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31F9230B0EE0
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28427432BDA;
	Mon,  6 Jul 2026 12:44:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022091.outbound.protection.outlook.com [52.101.101.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3FB430309;
	Mon,  6 Jul 2026 12:44:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341881; cv=fail; b=pVCLzV5a8eeiuy6j+2pUT/euzatfgddj/AMJMa+x6/lzGTUpQh6Z2c8BraWxUIWhnF01AraLPSJGIb+Vt4K5gAdc6MZFSiviU/T8DlHWsjOiJ5Ve7GxWTvHhOkVbRHcUsWkDh9qL+XYkw8uLo1de127Hqgib0hJKSWXh2EcQUQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341881; c=relaxed/simple;
	bh=n5UrZ9SCmnFd6xU3RIIZmJFgcitHRD/BCqgTnxgpwoc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=th2CJSzIOdVWpz/xAmt8JuK1rm2RxQSVfUbiuSrH7pVwXCmqWbPNW8AakpPN5RSwdwS3kKpDQkyb9va9dRJrBCQ2nZ3abipqbFYJiTnpZ3KZEMm/PlRRGB58Cc8iDx/CBx0jFM5IF9AO6GyDI+Mou+KXGIZvpet5EjjbEEYtjaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=TbITF6qq; arc=fail smtp.client-ip=52.101.101.91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcy9Ry7/jTAk6JGRPjRUHY2mngZUvSH4rYISmw4VygdEKFtrd40SSxEMIQNey71TpRKi84Mh0oR4nFEaccSmhI0gvlJEHK8xf/Wc7MHIHkAT4A6IjBt7zpTKTN9K4/GqddqJc5f3M7nucukNFdiU6SSQXx/bVKDjpN/OqN7rZIW6be8fhyFvyXcYLC8oXgxApsHAuzE6Rj1oS+Nr9ed1awajw2RJz/grJfdXiwpqBDLdg54V/lEB6/Y72DoJZBBk6hWpYBjTeYZ5Xp461dbPFUaPoq8yLMta1HHouHZh5BxUk9L/GZUQxLwN0oUh1wjdONjIO/bNQNx33hN2qeraaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL7RlrJRDp+0TKzakDvalK+fyBG5HK4GPZ7tNIVutFE=;
 b=Ea8GWaWTGHRRs7rnoGjLvA1e+Key+O093OesFmm5kdm6FPn30McBWPnFgNtdZ0qrtUM3S089hVHHF8jljgfRG+hNlTfcpMxv+yO3dZ45Hz5OuFf6XnJfBekA2PJ9leSbu+D17xWR4qIkdMIwyoAzncMXTrZPYBF6/XSn+o1bjv3LHaUM0ZdUYldSKFScAa+TuQSqi7ykaCe1JWiewjFw/yIkujZO+CX7Ypxvx6b2PzxU+GniDpvWdRMDlvRlTAXhN+UceWqUstvXZq51URMQW+rrI8bFqRX2CuMFM/RlU9KAUnzJiIO2t5FA3WRP4zviGyEjGjm4tnNp9yK4dmnhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL7RlrJRDp+0TKzakDvalK+fyBG5HK4GPZ7tNIVutFE=;
 b=TbITF6qqmp36rGa0K7JA70g3bVbixj3jGBw9LHiKTI4aBkF7NP2r3kHRHd5atPkNPYUnEQrNbVBLmi7/Y9u8tU19gq2O4ij1xhqtlgF7LDmL0aoEL96O9bD0VxaDB2mQjb/GO9a9h5EB/nAwnv85mfuTQT24nD3Ud/DzGVODy9E=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:27 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:27 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:19 +0100
Subject: [PATCH v6 06/20] rust: io: rename `Mmio` to `MmioOwned`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-6-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
In-Reply-To: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=16892;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=n5UrZ9SCmnFd6xU3RIIZmJFgcitHRD/BCqgTnxgpwoc=;
 b=VzwDKnux/VHJFxp8ypHV2Ww8ZaRZOfPlgvGPK9Ll90UL7gVZdvaV+EX8JkSzB/yZdAPw/pdLt
 gwurGg4fD5XB7NpULB1bAq66XDojXOrHC1JoywE1819+34+ibpohYbK
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b67c77-63e0-455f-b02d-08dedb5c50d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	3nYiKMvlH4C3sHnyxy+Fk7ai1lYDDOJcSE4LC4H213lMXb7lDmf5ZMKj2YALSL08xCFY/MG0o6DiefTx/IF4G3x31I6O3Vi+F+kQH5S9Loq23GBydBnoTykR3XKAuShG6vXWXLqkX1CTO2IFrLNWOmDzOu6FD6d3a36BMVqKjj51GYB+jDi/KPhX6CqTIcTk/RcqYpNzuR+FY8cJglFcdNBss+vzkoJUVQg7L3VaNJ/JkJtzEGZ3BXX25J0CRtkQdG2uZuKim7A2nLdsyhMp+PjLiGFpblh1vyPKcdLl3qozdt1jjHyT349EIHSeE5qT4cFoaUQLad9ewWQEh1HPuM8KX9c0UdaefKI9dqj4y72fn3MIEQXlTbPAIjSHQg8qT5TRIZTYgCy6DTztfI/d4Qa5/oSELB7RKATiXJJLWEsTHgAVCFeP3TVSF7/ryMa4vG5ex1aFcHzHO+DdXAHcsNzXjCu/lmARSJv4M+Ky4dq5n2eZYX8AlZVjUABzetPZ+wyk3Q90hzsDruWRdIpaM736SQJ7Vb/Xl2TGQxxbLw8dIu9Rn4QqALinB57HKNyCusiDPHEQ3yX5yC29gua0oRMCZqj813/ucZhpZ3aZiwoMF0COVZNYL3FnyiRS/jyO8WPEB36WKTVKdhAirQK5OdL4VrOzoYDcfhlDD0e4LOJ8Ihiy928jYxCefEmbP/nfIZbL2G7TK54/TwkvCdU1yQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGUwd0txTlExZEE3Zmx4ZVJIQ3VBWXczaGFUc21uU05VNDRaZTZoblArM1hn?=
 =?utf-8?B?RGZBZ0hjUUVIampCOU9TTS9BTHhBYmwwRXE3eVlFSTFJbGlsS2t3NWFPRDYv?=
 =?utf-8?B?UHE3S3JyOFF3a3ZUTXhCbTl0ZWtwak1pNm8zeWxzVHFJNWhwZ0pHdDBYU0Zq?=
 =?utf-8?B?b2E0Rm5JMFF4aVVBZDVTbjR5Q2M5clhLOXdDSjNVd2pSOGc3cVJKcE0wL0Za?=
 =?utf-8?B?V2FYZlhhSkkxUzdkck80ZENGWTRPS3l3aER2L050M2RTdjhSaUFnaDJzTVJW?=
 =?utf-8?B?aHI4dEE3RjZlYmJUNTBibXIwa3I4MG84dlN4cjQxNVY4ZEZ0NVpHMjNJdWN1?=
 =?utf-8?B?bUh0VFIyYTB0bzcyb0hhYXl5SWpaSDlvZjVXY3RGTnh3UWV6ZGxVU2hOYWt5?=
 =?utf-8?B?TkpTUnU1YWJUbEFnWkZMOTVwbU54UDFFU0dkWktzdzQ5QkU2VUdlMnFqN1ZL?=
 =?utf-8?B?UXczUXBTMFFiOWkyZW44OFZpWUZlVVA4MWZCb0FnL3VXT0wxVHdpcHJaaU1w?=
 =?utf-8?B?RUpOaW5IMDl0WC9hWHpTYjhKZ2FhWmNwbGRvK0ozQVpxVWpMV0ZsL0plYmxJ?=
 =?utf-8?B?YlBiUDJRNDZvdkVPdFBvbTJQSXNQSUFLbjlTekt4VnJFdUFtNlp3R0svcnhx?=
 =?utf-8?B?VkpsaEVjaHcwa3RIWDVyeS9RNkNoK04zOFc3NTJyQm5iNDN2MTQ1bzNCYlRK?=
 =?utf-8?B?cDExSmhHbkFudkh4OWVadEpwN25DWHpYbnZ2QjBjQ3FDK1doTE1rMEtzWG9Y?=
 =?utf-8?B?ZHVFNVNTbEloTlRZV2lmUnpCckRJWmNmeGliSnBMbEk5UkN3UFdsM21iUGsy?=
 =?utf-8?B?Q2RJMXFLdXRNb0JPZkoraU50N2RZTkdVVXFyRzcySFI3YUJsMEtRYTZXRDU3?=
 =?utf-8?B?KzlRdW4xRGVRQkFOWFpnckx1NXQyTVFTVFE2QVN6Wm5hSHJLMHRvQUUzalZQ?=
 =?utf-8?B?SXlrbXI2QzdrazV1T2d4YU9BMFpuSkROQkZBM0pneEVGMWZ5NmJEUjJQQVVE?=
 =?utf-8?B?WDhBUVkvVVE0MERGSDJza2s1cmVlVWpsZGNMdGV2VE1pNlorMlJsT05IY3dq?=
 =?utf-8?B?M0wzNzkzTEx6bjZxMGgxSkxFdjA4bFJoYmV5SW13RUxUektwdk9YZ1dSYlM2?=
 =?utf-8?B?akFlTzhXYTROWklPdktuY2x4b0U0VUNoWHZkMlNuVmJIc2MyOTFxV2RVeFNF?=
 =?utf-8?B?YzVJTnlkTHVocExOeXpRdTBHaFEzS3Y4R2lGRmRsY0tnSkZVMEt4cG9ONlZS?=
 =?utf-8?B?bjk4cWZ0V3ppZFdBQ25XT1pEVmJQcXI2a1paS1hpRlpYb2Z1dm1iMU8rcURj?=
 =?utf-8?B?eFdvd0JKWDMzb0o2ODRkRFVKR1MreDRpL0NISjA5TzdSZDJUK0VOU3E3QVMy?=
 =?utf-8?B?VlcxZW1BSVF4WTJ0Y2lKaGZOckZOUm1MNDBYTm5PSmFRY0NuT0xROU5EK1VI?=
 =?utf-8?B?R0oyVG56SDZWamRyMzFyb0ZteU9wUyswdkpIandDaVlMaTlPZFFZbEE0VnJu?=
 =?utf-8?B?a282R1dMOHlrN0JQRCs2bDVaYzFydko0c2ZuUXZlOVF6VXNDRlU3enNLS282?=
 =?utf-8?B?cWUxL1d1YnIyZzVhVjVZTkJhSml3S01LSklqQkxIMWlFdlI4Z0VucWZOZnVY?=
 =?utf-8?B?akhySzE2dlFVUUV5RUhweFpLTEhPNEo1OFhXQStvcno0M2FZMnBBZXBGRFZh?=
 =?utf-8?B?NFU1K2ZrY2t0elhJbjMwQi9VU09Zd2tRZTRMMXZsMXJFRlpXMWRuSnZpM0hW?=
 =?utf-8?B?ZGFXNFErR2xDU1RnVUxHOXo1WTc0ZVc3bUdqeGI5dktEeXJ2QjFNRHhJOU8v?=
 =?utf-8?B?VVdWMGs3ekNGQzJMSithL3JTeW9nUmpTZENMUm1YWU8rZkNRWnpGZUZ1NzdK?=
 =?utf-8?B?bnhwK0xzUCtQQWt3b2gyVzI1NDdWeUE0bHRwSmxkeXR4aVduRXBCdS9CZEJm?=
 =?utf-8?B?QkxwSDBYQ0RnOW1TOGc4eWl1V0xkRjlwcVN4UTl2NDFRNXRFZzhFS09aTFlr?=
 =?utf-8?B?OURiNVA5VXJCcm9ZWTR0eFRRcXc0MG1oWTFHUTAxeXB4SnBnS3kxMXFBSTN0?=
 =?utf-8?B?NkpCZkVoUEp0M1NhcVhpdjAzbE9tUjAxbEZFcXNjSm1vbnV2dWJmbG8zc3Rk?=
 =?utf-8?B?dkhxMmVDM3VoaHplODlJcGthNEpTVEk5eTl5UUl6N1Q1ODlYMjdwYnJJN296?=
 =?utf-8?B?RUU2UUlDL0M0NkYvVGc1UDNnNUJOVGljUFhDRjB4SnlQVzdvNUoyZ0hXcHRx?=
 =?utf-8?B?ZkdRMjVIbXRqOFFTdDV0M0I0ZVJ1d2F6STAvTXBPU0ZxN2R3ZTQrVEtDTWY1?=
 =?utf-8?B?OHIyRmpoNm5sUk03akJhNTB3eDJIUUhsc1dJWmI3V2kzdW5yTFJ1UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b67c77-63e0-455f-b02d-08dedb5c50d3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:27.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPagT0Du7B8Ep1FSklUQ/iiJ1lRpSmwnAQ24UA5y2JcxYh/auxf5X8LHtG+QiwYrCPhd3FBoqgSxHO0zonnWjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9595-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E79D3711434

Most users would more commonly reach out to a view of `Mmio` rather than an
owned instance of `Mmio`. Only implementor of `Io` like `Bar` or `IoMem`
would need the owned version. Thus, rename `Mmio` to `MmioOwned` so that
the name `Mmio` can be used for the view type instead.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs      |  6 ++--
 rust/kernel/io.rs          | 77 +++++++++++++++++++++++-----------------------
 rust/kernel/io/mem.rs      |  8 ++---
 rust/kernel/io/poll.rs     |  8 ++---
 rust/kernel/io/register.rs | 24 +++++++--------
 rust/kernel/pci/io.rs      |  6 ++--
 6 files changed, 65 insertions(+), 64 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index d0c677fd7932..aed0c994fd30 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,7 +68,7 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
-///         Mmio,
+///         MmioOwned,
 ///         MmioRaw,
 ///         PhysAddr,
 ///         Region, //
@@ -105,11 +105,11 @@ struct Inner<T> {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Mmio<SIZE>;
+///    type Target = MmioOwned<SIZE>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Mmio::from_raw(&self.0) }
+///         unsafe { MmioOwned::from_raw(&self.0) }
 ///    }
 /// }
 /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 12be266d7ed7..f93be7f78069 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -94,8 +94,8 @@ fn size(p: *const Self) -> usize {
 /// the represented MMIO region does exist or is properly mapped.
 ///
 /// Instead, the bus specific MMIO implementation must convert this raw representation into an
-/// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
-/// structure any guarantees are given.
+/// `MmioOwned` instance providing the actual memory accessors. Only by the conversion into an
+/// `MmioOwned` structure any guarantees are given.
 pub struct MmioRaw<T: ?Sized> {
     /// Pointer is in I/O address space.
     ///
@@ -170,7 +170,7 @@ pub fn size(&self) -> usize {
 ///     ffi::c_void,
 ///     io::{
 ///         Io,
-///         Mmio,
+///         MmioOwned,
 ///         MmioRaw,
 ///         PhysAddr,
 ///         Region,
@@ -206,11 +206,11 @@ pub fn size(&self) -> usize {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Mmio<SIZE>;
+///    type Target = MmioOwned<SIZE>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Mmio::from_raw(&self.0) }
+///         unsafe { MmioOwned::from_raw(&self.0) }
 ///    }
 /// }
 ///
@@ -224,7 +224,7 @@ pub fn size(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
+pub struct MmioOwned<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
 
 /// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
@@ -537,10 +537,10 @@ fn write64(self, value: u64, offset: usize)
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_reads(io: &Mmio) -> Result {
+    /// fn do_reads(io: &MmioOwned) -> Result {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.try_read(0x10)?;
     ///
@@ -571,10 +571,10 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_writes(io: &Mmio) -> Result {
+    /// fn do_writes(io: &MmioOwned) -> Result {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.try_write(0x10, 1u32)?;
     ///
@@ -609,7 +609,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
     /// register! {
@@ -625,7 +625,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &Mmio) -> Result {
+    /// fn do_write_reg(io: &MmioOwned) -> Result {
     ///
     ///     io.try_write_reg(VERSION::new(1, 0))
     /// }
@@ -654,10 +654,10 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_update(io: &Mmio<0x1000>) -> Result {
+    /// fn do_update(io: &MmioOwned<0x1000>) -> Result {
     ///     io.try_update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -691,10 +691,10 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_reads(io: &Mmio<0x1000>) {
+    /// fn do_reads(io: &MmioOwned<0x1000>) {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.read(0x10);
     ///
@@ -723,10 +723,10 @@ fn read<T, L>(self, location: L) -> T
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_writes(io: &Mmio<0x1000>) {
+    /// fn do_writes(io: &MmioOwned<0x1000>) {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.write(0x10, 1u32);
     ///
@@ -757,7 +757,7 @@ fn write<T, L>(self, location: L, value: T)
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
     /// register! {
@@ -773,7 +773,7 @@ fn write<T, L>(self, location: L, value: T)
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &Mmio<0x1000>) {
+    /// fn do_write_reg(io: &MmioOwned<0x1000>) {
     ///     io.write_reg(VERSION::new(1, 0));
     /// }
     /// ```
@@ -801,10 +801,10 @@ fn write_reg<T, L, V>(self, value: V)
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     /// };
     ///
-    /// fn do_update(io: &Mmio<0x1000>) {
+    /// fn do_update(io: &MmioOwned<0x1000>) {
     ///     io.update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -847,19 +847,19 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 }
 
 // MMIO regions support 8, 16, and 32-bit accesses.
-impl_mmio_io_capable!(Mmio, u8, readb, writeb);
-impl_mmio_io_capable!(Mmio, u16, readw, writew);
-impl_mmio_io_capable!(Mmio, u32, readl, writel);
+impl_mmio_io_capable!(MmioOwned, u8, readb, writeb);
+impl_mmio_io_capable!(MmioOwned, u16, readw, writew);
+impl_mmio_io_capable!(MmioOwned, u32, readl, writel);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
 impl_mmio_io_capable!(
-    Mmio,
+    MmioOwned,
     #[cfg(CONFIG_64BIT)]
     u64,
     readq,
     writeq
 );
 
-impl<'a, const SIZE: usize> Io for &'a Mmio<SIZE> {
+impl<'a, const SIZE: usize> Io for &'a MmioOwned<SIZE> {
     type Target = Region<SIZE>;
 
     /// Returns the base address of this mapping.
@@ -875,27 +875,28 @@ fn maxsize(self) -> usize {
     }
 }
 
-impl<const SIZE: usize> Mmio<SIZE> {
-    /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
+impl<const SIZE: usize> MmioOwned<SIZE> {
+    /// Converts an `MmioRaw` into an `MmioOwned` instance, providing the accessors to the MMIO
+    /// mapping.
     ///
     /// # Safety
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
     /// `maxsize`.
     pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
-        // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
+        // SAFETY: `MmioOwned` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
 }
 
-/// [`Mmio`] wrapper using relaxed accessors.
+/// [`MmioOwned`] wrapper using relaxed accessors.
 ///
 /// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
 /// the regular ones.
 ///
-/// See [`Mmio::relaxed`] for a usage example.
+/// See [`MmioOwned::relaxed`] for a usage example.
 #[repr(transparent)]
-pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
+pub struct RelaxedMmio<const SIZE: usize = 0>(MmioOwned<SIZE>);
 
 impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
     type Target = Region<SIZE>;
@@ -911,7 +912,7 @@ fn maxsize(self) -> usize {
     }
 }
 
-impl<const SIZE: usize> Mmio<SIZE> {
+impl<const SIZE: usize> MmioOwned<SIZE> {
     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
     ///
     /// Relaxed accessors do not provide ordering guarantees with respect to DMA or memory accesses
@@ -922,19 +923,19 @@ impl<const SIZE: usize> Mmio<SIZE> {
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     Mmio,
+    ///     MmioOwned,
     ///     RelaxedMmio,
     /// };
     ///
-    /// fn do_io(io: &Mmio<0x100>) {
+    /// fn do_io(io: &MmioOwned<0x100>) {
     ///     // The access is performed using `readl_relaxed` instead of `readl`.
     ///     let v = io.relaxed().read32(0x10);
     /// }
     ///
     /// ```
     pub fn relaxed(&self) -> &RelaxedMmio<SIZE> {
-        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `Mmio`, so `Mmio<SIZE>` and
-        // `RelaxedMmio<SIZE>` have identical layout.
+        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `MmioOwned`, so `MmioOwned<SIZE>`
+        // and `RelaxedMmio<SIZE>` have identical layout.
         unsafe { core::mem::transmute(self) }
     }
 }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 9e15bc8fde78..8f6c257c5b8e 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -16,7 +16,7 @@
             Region,
             Resource, //
         },
-        Mmio,
+        MmioOwned,
         MmioRaw, //
     },
     prelude::*,
@@ -211,7 +211,7 @@ pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
 }
 
 impl<const SIZE: usize> Deref for ExclusiveIoMem<'_, SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = MmioOwned<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         &self.iomem
@@ -291,10 +291,10 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for IoMem<'_, SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = MmioOwned<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: Safe as by the invariant of `IoMem`.
-        unsafe { Mmio::from_raw(&self.io) }
+        unsafe { MmioOwned::from_raw(&self.io) }
     }
 }
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 75d1b3e8596c..79828a8006b5 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -47,14 +47,14 @@
 /// ```no_run
 /// use kernel::io::{
 ///     Io,
-///     Mmio,
+///     MmioOwned,
 ///     poll::read_poll_timeout, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> Result {
 ///     read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
@@ -134,14 +134,14 @@ pub fn read_poll_timeout<Op, Cond, T>(
 /// ```no_run
 /// use kernel::io::{
 ///     Io,
-///     Mmio,
+///     MmioOwned,
 ///     poll::read_poll_timeout_atomic, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> Result {
 ///     read_poll_timeout_atomic(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 1159e5168ef9..fd3bf6220f95 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -58,7 +58,7 @@
 //!     },
 //!     num::Bounded,
 //! };
-//! # use kernel::io::Mmio;
+//! # use kernel::io::MmioOwned;
 //! # register! {
 //! #     pub BOOT_0(u32) @ 0x00000100 {
 //! #         15:8 vendor_id;
@@ -66,7 +66,7 @@
 //! #         3:0 minor_revision;
 //! #     }
 //! # }
-//! # fn test(io: &Mmio<0x1000>) {
+//! # fn test(io: &MmioOwned<0x1000>) {
 //! # fn obtain_vendor_id() -> u8 { 0xff }
 //!
 //! // Read from the register's defined offset (0x100).
@@ -446,7 +446,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::Mmio;
+/// # use kernel::io::MmioOwned;
 ///
 /// register! {
 ///     FIXED_REG(u32) @ 0x100 {
@@ -455,7 +455,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>) {
+/// # fn test(io: &MmioOwned<0x1000>) {
 /// let val = io.read(FIXED_REG);
 ///
 /// // Write from an already-existing value.
@@ -559,7 +559,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::Mmio;
+/// # use kernel::io::MmioOwned;
 ///
 /// // Type used to identify the base.
 /// pub struct CpuCtlBase;
@@ -584,7 +584,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: Mmio<0x1000>) {
+/// # fn test(io: MmioOwned<0x1000>) {
 /// // Read the status of `Cpu0`.
 /// let cpu0_started = io.read(CPU_CTL::of::<Cpu0>());
 ///
@@ -601,7 +601,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: Mmio<0x1000>) {
+/// # fn test2(io: MmioOwned<0x1000>) {
 /// // Start the aliased `CPU0`, leaving its other fields untouched.
 /// io.update(CPU_CTL_ALIAS::of::<Cpu0>(), |r| r.with_alias_start(true));
 /// # }
@@ -638,7 +638,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::Mmio;
+/// # use kernel::io::MmioOwned;
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -651,7 +651,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>)
+/// # fn test(io: &MmioOwned<0x1000>)
 /// #     -> Result<(), Error>{
 /// // Read scratch register 0, i.e. I/O address `0x80`.
 /// let scratch_0 = io.read(SCRATCH::at(0)).value();
@@ -724,7 +724,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::Mmio;
+/// # use kernel::io::MmioOwned;
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -752,7 +752,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>) -> Result<(), Error> {
+/// # fn test(io: &MmioOwned<0x1000>) -> Result<(), Error> {
 /// // Read scratch register 0 of CPU0.
 /// let scratch = io.read(CPU_SCRATCH::of::<Cpu0>().at(0));
 ///
@@ -794,7 +794,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: &Mmio<0x1000>) -> Result<(), Error> {
+/// # fn test2(io: &MmioOwned<0x1000>) -> Result<(), Error> {
 /// let cpu0_status = io.read(CPU_FIRMWARE_STATUS::of::<Cpu0>()).status();
 /// # Ok(())
 /// # }
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 42f840d64a6f..e0acb62f58a2 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -10,7 +10,7 @@
     io::{
         Io,
         IoCapable,
-        Mmio,
+        MmioOwned,
         MmioRaw,
         Region, //
     },
@@ -242,11 +242,11 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for Bar<'_, SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = MmioOwned<SIZE>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
-        unsafe { Mmio::from_raw(&self.io) }
+        unsafe { MmioOwned::from_raw(&self.io) }
     }
 }
 

-- 
2.54.0


