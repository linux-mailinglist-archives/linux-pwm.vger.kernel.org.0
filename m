Return-Path: <linux-pwm+bounces-9604-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id egytE8W5S2oGZQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9604-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 16:20:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21B9711E05
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 16:20:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=jPOc2+Ej;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9604-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9604-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACF6F309B057
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18286438471;
	Mon,  6 Jul 2026 12:44:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022076.outbound.protection.outlook.com [52.101.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E84435A91;
	Mon,  6 Jul 2026 12:44:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341891; cv=fail; b=CVpXneYc8c94Yi/CaSLf3EEdLxY/DQW+CTqt7QIKmkRLKEea2m7nhoyRxK2Mj7gQ+RzK/nBc8IBtUh6yTVjyNjx3SbdeKBplb8qdhCWQYfriOeFrfdY2+ujflq7I7VN6Ye7pUkdY+BHxa6J7nJhHueYLgHYeBTjJI8pl9V2YGB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341891; c=relaxed/simple;
	bh=FcbEdyhZBdxYKJ9aSp+byJgqDnoTz5fH8sepIK14zAA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gDCz/ZO/nSHwqct5B+EQueVV1yqIMOB4SCHCo/a6IeWqnDQQz/bJ08GcYS0ENKEI0JJyJObUYZkD4BLMMUSsrrqzWgmH14PLfN2i2wgrPVr35OgKDtYyr4COIPLOpu83X6uouOzhsZaybjkBZhSreRqf3FNzQO7oVyeSiDzKLCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=jPOc2+Ej; arc=fail smtp.client-ip=52.101.96.76
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+0C0M5N19Tp2GlVdIhopAsHOoJi9yA7nBRPIwvR/kOdzoJsoVh10/OoWvYSKE5nFroUXzgX2U7qnuP19tjugdV+mcyU5dDOKub2Cb9d2KGTSzCVHb+ZJhdpOQbo60fBKjh0ZnKqjCTwwTbp91IUqWqaHT/wjZuvxbLtlG5FQgOJLOpSJ7BQxSNBv+G/H7hhM5pbqzYkkpLzmBxGC9m239i8GZZQKzCK5ozmMhyqg4HZP4CI/+FdUqVQIpRLketmstSPPoF2i10nnK62pZd/MeUcS1IWPRa+ku62eaf45ucsiXNFoK3t8nl8cQg+vwhSvPACEdp+KduUL2M++mZ63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eApU9nREzvPqxoSO2eUOt1k/2nUNXPLYi91GdKENVU8=;
 b=K4tUa6ehrflAgxVctTQOn6X5QHfjlQLniCKaeAfMGzxJlYmWmD6K0fMIlQUxwQ5opf42i5KgmQ1xSobyIyBi4V9hpxpdGddA18lgNwVT8fWqHuuRLwetBFeLOMUo0koIPFvtdXwao1X4ujA1zmNM7RDunfl8VsLjbcW9mLLQS1k37sk+UVvILO35Kgiy2eVSk+wX5vNHqhXD50ok+fjc0wEkK/mQBw9GlD636PGYJJ/iN8So2J9lkk2kcgrLutsBTMsMFpb2dYRbv6K1VocHQgu2yQJ+8y3sXQe+BmpCZdUO1N1EBQHqJ/zrskbtS4cuOh+dap6bxDfrdw6h8Zb3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eApU9nREzvPqxoSO2eUOt1k/2nUNXPLYi91GdKENVU8=;
 b=jPOc2+EjAQGdD40s5DzeHcqnlPbtqVVwxQKLm0P5PZOXzs7e/e7j2jDJIrjiU5GSl7t8XyqwSfTTtmRH26dBiJ+7fMC7aENkJTE5WTpLhs+0WA6OMOzigFyTQkLCfpNOd3RsHZjbZyYfuRCWYvd5nF5RrgUwKx5mqlTtRS+fleA=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:31 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:31 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:27 +0100
Subject: [PATCH v6 14/20] rust: io: add I/O backend for system memory with
 volatile access
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-14-72cd5d055d54@garyguo.net>
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
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
 Laura Nao <laura.nao@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=5328;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=WVyNphkQnBa/m3UwVD6oWZfIOnK1r8nU4Zwse3BHU04=;
 b=JfcCBKrPSDgU6LnrTOmS3GvdAgLgj3RorTuIxUHkAY2DcCn7jncT+8mfQGq3DgtOudvWTrt5v
 9kCYx44twS5C1CotEc9fdGua8WECgpDMyT8yGFERCi9oOxBrONDAcA5
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
X-MS-Office365-Filtering-Correlation-Id: 84c9557b-36f3-4c19-20e1-08dedb5c52fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	wmpwzeileoPMfy7IfWeXZIMCSy9TYGXDvKvoJ9w/mIIUf1ONSuZoICA/P2Xip9OsqiiIXUEPaGN1Po7QK2O1NHDJF3YMz3plnvZ7BuwU3GPY2Myq3iaLwtNb9SGHq+IFYKSlb6vxWtugHbsm93iBAFcGAdUB2SDuHP7pTKoH91IhwP8rs8XGtz3y0PIRABpi0hi1UF+18vH87fbtErJi2gHLh7+gIUz74pR/2Edvg29A7/HVhkp1SjBtlflHBwyCoGxVlk8poMRodWNRRjcMEkgfTSmEZcakjymp9UgXrwRsfGzi/kFyedIamYcBUYGWMEJprd2PJHuGR0a1SZcPpHAKSkGFgHxQF59S1aB7NsI70uKcfHtv8oNzQY0lJIi1B+/u3/s+/zAXDxoAFbGwrHFihqUsU48eCV884NcpoiDFEyYFrdPyCKqnKIuhuHF3QgmUwQhhBHUZvHwc1/mMB97c6CyP9j/twY/iAGNW+DNNZCX+bD7syZ7SrvM0+ZXLhxOqp+7OQJpBi/gxaq9xVCaPElyPimh3qGVbkWMiRIGqoZg1tVWGCx/38rzKvYwb+Qq5A+jEE4bEBuCDCvwZ3Xjrwzrh4tAb4/A0Goo/wNVZ1RQl/v3s5sY3i359fa7Jnl3Dd5WqtyBd+IYlOZ3+oyZbiW5qWdxQLF7foY59qhapALGVSV4VRTxbo/q71WdlQBRVDWvx5NN55geCK+TzlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmZiN3grRzJFY01ZemtoWXBPZndvdmFFb2NvUDlObDRZMm5WejZ4aVBDOXk1?=
 =?utf-8?B?OWJ4bkFORC9PVmsxczNhOEF5bnI3TlhIVUVZbDNuV1N0UEt6MU0vRXA2TDJn?=
 =?utf-8?B?RFVXSEV5N1RBUWc2QWlyYTl2L1BPVUNKRjJadFg2Y2xZdkFnT0UyZHVZZ2o4?=
 =?utf-8?B?bm9Gdi8xdnM5ekkvaElEcG1wN1NRem5IOFNTVEY1cVBUaU9RZ1NvUzJZZVE0?=
 =?utf-8?B?b3I1MXV2aEpnckIrN2Ftb3JLQUhqYTVsK3JJVWh1UFJXYXZKNnpvWE9xdjRE?=
 =?utf-8?B?ZUdlRnhaNEhaU1pyRWNWTW8xMTdwdTBkUGFwYTk3aHMyZzB0a2VEZWppOTdy?=
 =?utf-8?B?UDZLM0cyZXNVUlM2a0tWbmxWZ0ZKUm9kY21hRjNYYjYrU1h2V1pWd1hxTllE?=
 =?utf-8?B?S3Y2TDhoci9sYXpMSmhKc1VkZndVakxHRGozblFJbGRXR1ROSnBua0Z0bXhE?=
 =?utf-8?B?RlZEUWdoWkdCbWJJL3NSYkVDaEJkVHMreXFGUFo5dVlqVUdUVlJ2Yi9WSmZo?=
 =?utf-8?B?M3ZWZnVxaTJUQlhuU1dIWUFSTnFNcUFjLyt1Q1FWRUZpcy9YanFvZ2pPcXhU?=
 =?utf-8?B?d280eUlRdytWTm1aNzVyaURmL1pHeGlITTlieitUVW9iclkyTUxMZkwxanBl?=
 =?utf-8?B?RGJuQmtDOWVLcC9aT1cvMFYrMER1aVB1aFl0UDRYYWxCcnErMVFqK0FrYW1t?=
 =?utf-8?B?TC8wQkJkRm13STNFRTNrWFNMSVg3Q3l5Q1F5RENuZlFRaUpteDZMWldPVkVJ?=
 =?utf-8?B?eERFNWp1aFg3Q2hvMlZ5L0NidHhING4zVVYvak9hT1E2U3pLMnhQaDEycFlr?=
 =?utf-8?B?QXR2LzY3bk5hOTJrQ0hRYW12U1dsZ1lUL2RSb1hyRCtJQWYyYUV1bmhSbzNW?=
 =?utf-8?B?YTZvUVl6Y1RjSjZseCs0MEhsemlDQkFRVHZJUnZNM3R3TGdZQ0crNkN3bUtG?=
 =?utf-8?B?Y1RKajVBbWZsREp2bFd2V0gxOHJGUFpLaUNVNnR5YktNcGVkbEs3eTF1NEFh?=
 =?utf-8?B?OFdVakcwVytqd1JKZU5LVVVaZU5DYlVsT1JGZTlaK3RJN2RxWU9MREFRRVg2?=
 =?utf-8?B?UnFJYUlOanowdVV5TEhXMjhHaWhFaytCL0gxWTFhcVR2dXRVL1FWZFRramhz?=
 =?utf-8?B?UXVSYWNXWFgrR241WENZQk9wbk5YbUdBL082N2pZSlMrcVpGaWJxUGw4bkMx?=
 =?utf-8?B?NHJITUMyTFdlKy9ZdFVISnNscTIrMDBFR2tSMWdVN2ZyZUZQWDJmS2h1MkdN?=
 =?utf-8?B?eEpMZVhtanZHUi9jOWtVMzRXWlk2Vzd4Yjl0aFZKRjlwa1FsZWFCMVovd2Ux?=
 =?utf-8?B?bFBOaHdBM09MWW9qL0xSYTFHUU1yeGlSWmlncWwxaUNEUlYrNDZrMHZRZnRJ?=
 =?utf-8?B?YUlnTFNBcEpqL1FTS0IyeCs5LzdDcVZkMUZZYUErTDV3ckVSclh4V3doVy84?=
 =?utf-8?B?am9VVEo0SG1OdkpEWXZCR3hpWHM1QzdNdmZPeW1pL0JlZmpPUldWZFArYzda?=
 =?utf-8?B?TjBCM3JHQWF4eFQ1NUNvVndVQjNrN0R2Rkwvem01K2M0WEt5TnBPcGYzaG1a?=
 =?utf-8?B?Zkx3bFh2V2p2SXd2Z1lwM3diV3p3d2loNHpuT1BHTGg5MTVPS1U3SHluaXVj?=
 =?utf-8?B?cC8xaC9XZllDSnVJWit5NEFkWkhNUUw2eHNmQ2EzcDNiUDBlM21OQ3QwZGpH?=
 =?utf-8?B?UndiWC80eW5HcU9iY3haR2NBZ2tGc2V5ZHJrcVJrNTlxd1o3Zk1hV2JYQ2dY?=
 =?utf-8?B?dk5YcWUvVEVyZXUyRnJUaENoNkl0aTJoRTZWRFI5NmFlSUhWS3dsdTdLUW84?=
 =?utf-8?B?TFU5YWg2K0xpd1RWNXhiekVaT2dtRlltNHN1YmwrZmo1MitTN3ZyVWhjSGcy?=
 =?utf-8?B?UTExU2pnSm5KcDlaWnJ5QlRMRGsxWVZVUnQzV2xqOFR3T3lDR2Q1RnF3b3E2?=
 =?utf-8?B?azZjVkJLUU44TDdjWFFUYktSaFBBTGpKVVV3SGJpaE05OHd4czh1NXlzK20r?=
 =?utf-8?B?bnAxK2RiUEc5TGtEVVZUZ0JJYTNpK1owVTNiN2UzTXJDV1FzVUc2MG1YUHBj?=
 =?utf-8?B?azJmMDlGbnVmNmlzSVZHbi9xZE9VUXNYM3ZoNTVuQVdkV2Y3YjFKQVhQR1Q2?=
 =?utf-8?B?UkdacndjOTJKNFIwbEs4YWpsTVkrSW5oUU9QQ0VmRDhWYUdnT0NDSkNoU2wz?=
 =?utf-8?B?N2ljeGdkVjNhTzkxMm9hejYvT0NITGNOWTBoV0QrbDFHUElEeis2eGI2OUl4?=
 =?utf-8?B?UFJ1QWhPdmJEQkVnb2dFL0dSdXBKQ2JlNkFIblRIZjFUeWdLeDNEaWtXQkVZ?=
 =?utf-8?B?MC9ra1hlUDVyMHVuZWk4c0ltNElFamVEYmZONnFmNXhET2p5aVRmUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c9557b-36f3-4c19-20e1-08dedb5c52fc
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:30.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJf0EkfUqOzUhHClolcl3cQ0nWj0l2wg/0UvOkGbyvUGAxk1NYf59PVglQTpudWrEOdUYNgkSxNjN7ZXvxpMfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9604-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:laura.nao@collabora.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,vger.kernel.org:from_smtp,nvidia.com:email,collabora.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A21B9711E05

From: Laura Nao <laura.nao@collabora.com>

Add `SysMem`, an `Io` trait implementation for kernel virtual address
ranges. It uses volatile accessors to provide safe access to shared
memory that may be concurrently accessed by external hardware. Implement
`IoCapable` for `u8`, `u16`, `u32`, and `u64` (for 64-bit system).

This can be used instead of `Coherent` for cases where a different layer
takes care of mapping the system memory to the device (e.g. dma-buf or
GPUVM).

Signed-off-by: Laura Nao <laura.nao@collabora.com>
[ Rebased and adapted on top of I/O rework. - Gary ]
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 62643b23e904..78c6ae2a0db8 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1039,6 +1039,128 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_relaxed);
 
+/// I/O Backend for system memory.
+pub struct SysMemBackend;
+
+impl IoBackend for SysMemBackend {
+    type View<'a, T: ?Sized + KnownSize> = SysMem<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        view.ptr
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        _view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        // INVARIANT: Per safety requirement, `ptr` is projection from `view`, so it is also a valid
+        // kernel accessible memory region.
+        SysMem {
+            ptr,
+            phantom: PhantomData,
+        }
+    }
+}
+
+/// Implements [`IoCapable`] on `SysMemBackend` for `$ty` using `read_volatile` and
+/// `write_volatile`.
+macro_rules! impl_sysmem_io_capable {
+    ($ty:ty) => {
+        impl IoCapable<$ty> for SysMemBackend {
+            #[inline]
+            fn io_read(view: SysMem<'_, $ty>) -> $ty {
+                // SAFETY:
+                // - Per type invariant, `ptr` is valid and aligned.
+                // - Using read_volatile() here so that race with hardware is well-defined.
+                // - Using read_volatile() here is not sound if it races with other CPU per Rust
+                //   rules, but this is allowed per LKMM.
+                // - The macro is only used on primitives so all bit patterns are valid.
+                unsafe { view.ptr.read_volatile() }
+            }
+
+            #[inline]
+            fn io_write(view: SysMem<'_, $ty>, value: $ty) {
+                // SAFETY:
+                // - Per type invariant, `ptr` is valid and aligned.
+                // - Using write_volatile() here so that race with hardware is well-defined.
+                // - Using write_volatile() here is not sound if it races with other CPU per Rust
+                //   rules, but this is allowed per LKMM.
+                unsafe { view.ptr.write_volatile(value) }
+            }
+        }
+    };
+}
+
+impl_sysmem_io_capable!(u8);
+impl_sysmem_io_capable!(u16);
+impl_sysmem_io_capable!(u32);
+#[cfg(CONFIG_64BIT)]
+impl_sysmem_io_capable!(u64);
+
+/// A view of a system memory region.
+///
+/// Provides `Io` trait implementation for kernel virtual address ranges,
+/// using volatile read/write to safely access shared memory that may be
+/// concurrently accessed by external hardware.
+///
+/// # Invariants
+///
+/// `self.ptr.addr() .. self.ptr.addr() + KnownSize::size(self.ptr)` is valid and aligned kernel
+/// accessible memory region for the lifetime `'a`.
+pub struct SysMem<'a, T: ?Sized> {
+    ptr: *mut T,
+    phantom: PhantomData<&'a ()>,
+}
+
+impl<T: ?Sized> Copy for SysMem<'_, T> {}
+impl<T: ?Sized> Clone for SysMem<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+// SAFETY: `SysMem<'_, T>` is conceptually `&T`.
+unsafe impl<T: ?Sized + Sync> Send for SysMem<'_, T> {}
+
+// SAFETY: `SysMem<'_, T>` is conceptually `&T`.
+unsafe impl<T: ?Sized + Sync> Sync for SysMem<'_, T> {}
+
+impl<'a, T: ?Sized> SysMem<'a, T> {
+    /// Create a `SysMem` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr.addr() .. ptr.addr() + KnownSize::size(ptr)` must be valid and aligned kernel
+    /// accessible memory region for the lifetime `'a`.
+    #[inline]
+    pub unsafe fn new(ptr: *mut T) -> Self {
+        // INVARIANT: Per safety requirement.
+        Self {
+            ptr,
+            phantom: PhantomData,
+        }
+    }
+
+    /// Obtain the raw pointer to the memory.
+    #[inline]
+    pub fn as_ptr(self) -> *mut T {
+        self.ptr
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for SysMem<'a, T> {
+    type Backend = SysMemBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target> {
+        self
+    }
+}
+
 // This helper turns associated functions to methods so it can be invoked in macro.
 // Used by `io_project!()` only.
 #[doc(hidden)]

-- 
2.54.0


