Return-Path: <linux-pwm+bounces-9608-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sASgBlylS2rzXgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9608-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:53:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D87ED710D21
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:53:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=yBWsdBl9;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9608-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9608-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13FE23094B6A
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741943F4BD;
	Mon,  6 Jul 2026 12:45:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022076.outbound.protection.outlook.com [52.101.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92B438476;
	Mon,  6 Jul 2026 12:44:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341900; cv=fail; b=Wh8AHOB4XMM/05YX7qo6wraIRCKZqmkoC8haijZg+2ittRakEOsHNppTR09+IYACkD25POM60qxZ9luec2tUFQ8oXWx3wEXdcxm00J/r9iXJp4bGqxJVFtHCE++efSSXOZ0S7C+LgkgjOzBDcyPF/4Btdf3HGDxYNEnYAH73I1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341900; c=relaxed/simple;
	bh=HKi9hwYdpjEBRaCrqGl48lsLJFiatgMmWVT8hypHzSI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GExxHYvNf2otFLXyWJb8s/dkRhMGT7Ax6VIBlGMql3VzLAMjogFFW3cywH+R/69qyF5VDeggOSMTAi0FYKpLP/clyof0AeNVk2uG3PfveOKSOb3WNBqE6wkNLLtlhcjIO8XCTXCgWJS6tW0GEmlHLOIJ5cjnBS0HQKJw66YyMSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=yBWsdBl9; arc=fail smtp.client-ip=52.101.96.76
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaApEIBkMfhjIdizbaZZMNFXAgRSkldbUTuuGL68EPJK7fozAZCBXLhsN3FPaPrhlx3nG6piSKdVnVFTfvtc1P9mQwdpJjyzv5tzlIjQLn3XnnOm5ddR5qfMJRvZHYElwx83bO93Z4w17NzSRCjEuIvhgWWIDrXqYeNHg/aiiRZY1NhPqrbbfFyyKVGAhY/dby2+mUoqjPTAmzbPQ4afgp2cCgyldKzgC+hN1Cxo0gqMy4rZdg550eEQxDwcdp2ABCw1KqkL13jkBzo7+/uEaF4Lv1qKSY//SOKpe4mI3vxj4eS2/lp7AsQLxk1M1a149vcaFFjtzriXr1BUqHpYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkTkMNy8dei3NgJZXZ+X/gFRrX6EQlrU6YQnsxP665E=;
 b=Qa96rGzK37yKPBGkpY7b0sAy8nWsjTojg5MMmh3jc1ORvi/IwAxf5NIGtGObJN4nvlo1OMESySekYozFwWbX48SsaweC+KLuAOAsDBPjf7RdIDa0PwCbQ74eLedil0MxiEs/Uy+6vnmrpBbujoYaMJM8BqhDApb3LwS2YHuF3PnE2n6NfK5RvMCXGk2fxAPZvCYajnc88iv78WkcB9YvEyUFw1LIyZADav72r68uARYZ1tt2xrB5yjvp6GJHDVaEBXhmpQjCV0qMbVKR7UBxHGs5aO0w+/R3a0zt55Tg63zscArzHSvO8svlujeRNoVmtj4gs7E7Q1SxxtR/b0bM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkTkMNy8dei3NgJZXZ+X/gFRrX6EQlrU6YQnsxP665E=;
 b=yBWsdBl9zhHhZkdxvHRG8H43qaKUuv1D1t9SPyUEDOZpk7bnCb7NjW4ASo0BA2f20N4X/OmTAKTVW0BKd6mr8l4W0CbRXQqZjTkq0B34/qlt+K7pMhGh2BsOoSFCOKEOcxad9VuuOKSwDERcuQuI6FNqLUL9ka8BtII8YP2yg60=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:32 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:30 +0100
Subject: [PATCH v6 17/20] gpu: nova-core: use I/O projection for cleaner
 encapsulation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-17-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=13153;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=HKi9hwYdpjEBRaCrqGl48lsLJFiatgMmWVT8hypHzSI=;
 b=V28KLqAn7Myf3nRwVRHofIpOjsFh76FlHTYksJouFynM2kuJHaj20kUs+jm2EI5Jf95P2V0yW
 UFlDUdR/kBZDuuOP9Vrk0NgFi67WZv9v1iWhTq+0Srgv8Y3x/gWCsbr
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
X-MS-Office365-Filtering-Correlation-Id: f73cb439-c137-41f1-48b4-08dedb5c53cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|3023799007|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	j9WZESZV8uYtQ1qG56/MQA8TNdiDhOi7czqbJoErdI7DLgzeljY1c0VVKlQujzYhqxkDrSteWk7ELUGMBY+17vVZfiZqA9A4vNK+wlX1dfpbnhlJ+3rnfwm5uyOXK7IONxQtWC7Gx7KxFZe3FmfwbdtrDcYlspwp4Xj8rR/C6g2MuCCMsUnJltPcGQtZEcbySLjr9AV/doxPNTyfFp831XvZ9RZHE58GfqdyhfcUdysy3WRX7TAZ8jXEOfl0WqB5pB162A70ePA+Nl3f6QWR4KdqB2X77ZmbDv0b9k7bIjvvC65dBibpB8duzXnEAMxyG+vw8c+RNdq7TBSkE64id4aL2guh4/55p9ULwUL2Wy/a3OVMfceThxDPL3EUV1yk27wCRlkCQWktLtvwqkrglY6PKE4difBjE+kKes+n5LCoMOqaMSxnsaDHBtthG6/Gf0F1fQXuxMDbr7Ua65+6MFco/zLFCiJl8qBPAFY3ahkxqZpffMiKLQQIlrnrUb/1KCvDOWM2JqYxHkncMGbiEt1ABwFQ8upBgKmP/UUoA0GiZfMS7uG6ZzvOVm9QkjUDpI95lFsDsyHLDKlzXRI/2L5cyeR10aWCjz6q4z91ettGh7J4/PbMKKZRK7Nok1Ne0XhMiPa4dNTAe7rey3M1M1zxS8M3HnOsEPvhacjzmEcZhZxc9jFjg9XwwmUNNxQl4ieyg3mSt5+qmAo7AgpYeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(3023799007)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHBTVUFaM3NFaWRab1hWTm9mNlJOajJ2YlJaR080T3A3OFZ0bi9UVDF1V2s2?=
 =?utf-8?B?dGJwY253T2d5a3BVKzlEejB4TXZJWkhHZFRmVGpuQzM5UmxkUTJDc2x1Z0dX?=
 =?utf-8?B?alNwVFQrM1RjUmE4M1liY3JPSXpqa0J4UXVrL3lZVDlQS0JqUlVrSnFhQ1A5?=
 =?utf-8?B?MVQ1dVc2eUVVdFBCZ242S3Rlc2QxY2tvdm5tM0UxL1lTQ0I3bE9lTENqRDFX?=
 =?utf-8?B?TUJTSHpSSnV4NG9veWUxSURmTDQ5c1VMcC9EUGREV3YzVUZUczB4MGE3S2ZG?=
 =?utf-8?B?c1NlQjV4T0VOUVJDL21GcU92clZKUXBJRjN6NFFwNkdRYnRCVU52aUUzQ24r?=
 =?utf-8?B?alF5OWZoY0VESHdPRWJPQm52c1oyNGtqR29hc1VxOC95azllV3RiV09xb3FQ?=
 =?utf-8?B?MEVNdFE3c1gzR0pIT3dDU0JxbCtROHEzd0xLWS8rd0lPNGVCb0MzVDN6dVdO?=
 =?utf-8?B?TjVXd3JOU1hsalhpOVkrdDU5QkEwTlM1QUtXWFdyOVNCZGFhQjBidjdETVNk?=
 =?utf-8?B?UWhlS0oyeU52Nko1TXVCZ2l0TDNrM25jZWdiZWpsYmJWTWhIdzBzVlQxdW5w?=
 =?utf-8?B?aHJrMWgzOC9MOWh6cjZPOUJyNXppbjkvYnl5SFJKSS92UXVNVkl5YVA0VGcx?=
 =?utf-8?B?UHk3UGdDRzJLV2FtWnJiVlRrUnRXOHhLeUFGempLd0hOcHYwUVlJN1krMU9M?=
 =?utf-8?B?KytESy9SNjEvVU53UUhTYjdaQ0FBbzZvSnRlSE9nYkJVYWY1THZXVitBM3VV?=
 =?utf-8?B?cm9tWkE2ZnIwMXhZS1Q4bVpmR1l0aEEzc3JOWWJWSEhtV2JRdG83eTJ1dmxT?=
 =?utf-8?B?a0NmQkZjSWd2dXpyV0kweFJrZU8vRGl6TURGSGpCK1I5d2JqSmQ5T2Z3M0g0?=
 =?utf-8?B?aU12OHRqcGNDdnp3TWJKRzdNWmRPL01YOVh4SjR4aFBybFk2cktFNGR0V3Ju?=
 =?utf-8?B?Q1FaMytWNlN2c0JrQmJvZjk4Z3cvRENyaXo0TGZ3WHJnRGVZVDZDWnBvY0xK?=
 =?utf-8?B?dkdlTy9vL1lUT21iTjJCNmRQSGtaN0NtbTRNMDZTYWlyUW5wSkg0RTNTc2ZQ?=
 =?utf-8?B?S2ZoelhicWYyb0U4N0thL2dTY042RTJ6QjZFNU1HZ1RLZ051eXVMaGRzQnh2?=
 =?utf-8?B?UUJyRFU3RzFxajRvWk0zUDlQT09KNGFGNkhlZDR0UCtma1lTczB5dnhoRDVM?=
 =?utf-8?B?OVNWSUJlQnBMV2IrODNhYXRvTjFpT3lhOWJ3cXU4WWtoaVF1Q0Vsdmhoc3pZ?=
 =?utf-8?B?WHZTaUhYdzErR1c4UlRzYkI4RUVvOFNIWWlmaHFhb0c3TFFNcmpIaHNqL2lj?=
 =?utf-8?B?dmFlaTd5WUYxWUR3VXduZ2tCL1dNakloUTR4eFI1Q0xoZmJvVTRZUlBEaU9K?=
 =?utf-8?B?K3F2dERsOVZqV3ZIS3ZTS09RWm5yNHkwSk9hdXJNb1RyeGVlNHEwMjdVUVpQ?=
 =?utf-8?B?LzJ6eVdOVXZORnRFcCtjTmpzNzIxNndkOWxvQ2w0VEdXdUVXMFNIMU9lRFdM?=
 =?utf-8?B?QlVMRG5KRm9iWW1RaWE1VVZGWmdSNVp4TXV6UmgrOWFQU0pTZWNDQng2eFFp?=
 =?utf-8?B?SUx4UlltdlZReC9DZzlTWkJ1Z3kyZGFQNGx3aVpiR1BYTjl6OUxMaHBIWktL?=
 =?utf-8?B?Yzg4M3N1N3Vtd1FnYXNRNytaanVOU1Q2RXVDa0RVak1qWDJLcTYycWlwTGph?=
 =?utf-8?B?Ujhob0VqMVh5a2MyL2t3aVFkTzUvQnFEMGZyVUZzeFlFdnhCQkVIWWs5Y1hC?=
 =?utf-8?B?TWZiZXdFNEtUQTkvYXdENFpJVmE4VUU1bjdsMngyN2JCMGNGMUVSNlpDRGhD?=
 =?utf-8?B?WUZhdy9Od21mY1NHUVFzVUpiNWdaK3ZiOXk0d0F0d2J6ckwvVURQUGwxUnd1?=
 =?utf-8?B?WURrOXlRTnNlakRscUdqcmYwaHkrODl6S1JlMVZuVkh0eWhGOFBvcWE4WDFR?=
 =?utf-8?B?N2d6OGxwOUZROVZmS2FlNGphVEVhNW1FaWoyNUJzVnd6WXdNaGxEelRLUDZq?=
 =?utf-8?B?bnpqb0hid0JWTkZNK1RUdWhIZ3ZaNEZNdVFCdWhDTmNocFhxaW1kVVRoK1RI?=
 =?utf-8?B?THlMaTJnNTJ6MXJMa2xZTkk4SEEvNG9uV1p0QzR5dGt4OGpWWSsyVUhXVW1V?=
 =?utf-8?B?MGNrOVpqaHF1QlYySE5ocDBOUklhdWJ4UnRCNFFDM0cyYVFmcE9JQXo0K281?=
 =?utf-8?B?dG1VUUpCU285SjhaYWlYRUJ5a1hnUWxtaTd6bVhzb21RZDZkZjMzUmlNakx5?=
 =?utf-8?B?Yno5bzJ1cWtYNlVUZ0hEdXBreHY4ZlVKS1JVYlNrcXFuNW5tQTl6SGYvRldw?=
 =?utf-8?B?cVRaMTk3RWV4Yzk2eUVMYlcyOWdKeFNMTzE0Q1luRTdBQ1JFUXJFZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f73cb439-c137-41f1-48b4-08dedb5c53cb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:32.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsGJObjyz7WPl9en/nC1nwxzg2EC+x71h07MzsucH4sUy9zOs0gMZ2gTATNla+Oap1+f1waS98M3JLz4PeWr9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9608-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D87ED710D21

Use `io_project!` for PTE array and message queues to restore the proper
encapsulation.

The remaining `dma_read!` and `dma_write!` is now only acting on
primitives; thus replace by `io_read!` and `io_write!`.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp.rs      | 53 ++++++++++++-------------
 drivers/gpu/nova-core/gsp/cmdq.rs | 66 +++++++++++++++++--------------
 drivers/gpu/nova-core/gsp/fw.rs   | 82 +++++++++++++--------------------------
 3 files changed, 90 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 69175ca3315c..cfa7553cd820 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -9,14 +9,16 @@
     dma::{
         Coherent,
         CoherentBox,
+        CoherentView,
         DmaAddress, //
     },
+    io::{
+        io_project,
+        io_write,
+        Io, //
+    },
     pci,
-    prelude::*,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    }, //
+    prelude::*, //
 };
 
 pub(crate) mod cmdq;
@@ -48,21 +50,21 @@
 
 /// Array of page table entries, as understood by the GSP bootloader.
 #[repr(C)]
+#[derive(FromBytes, IntoBytes)]
 struct PteArray<const NUM_ENTRIES: usize>([u64; NUM_ENTRIES]);
 
-/// SAFETY: arrays of `u64` implement `FromBytes` and we are but a wrapper around one.
-unsafe impl<const NUM_ENTRIES: usize> FromBytes for PteArray<NUM_ENTRIES> {}
-
-/// SAFETY: arrays of `u64` implement `AsBytes` and we are but a wrapper around one.
-unsafe impl<const NUM_ENTRIES: usize> AsBytes for PteArray<NUM_ENTRIES> {}
-
 impl<const NUM_PAGES: usize> PteArray<NUM_PAGES> {
-    /// Returns the page table entry for `index`, for a mapping starting at `start`.
-    // TODO: Replace with `IoView` projection once available.
-    fn entry(start: DmaAddress, index: usize) -> Result<u64> {
-        start
-            .checked_add(num::usize_as_u64(index) << GSP_PAGE_SHIFT)
-            .ok_or(EOVERFLOW)
+    /// Initialize a new page table array mapping `NUM_PAGES` GSP pages starting at address `start`.
+    fn init(view: CoherentView<'_, Self>, start: DmaAddress) -> Result<()> {
+        for i in 0..NUM_PAGES {
+            io_write!(view, .0[build: i],
+                start
+                    .checked_add(num::usize_as_u64(i) << GSP_PAGE_SHIFT)
+                    .ok_or(EOVERFLOW)?
+            );
+        }
+
+        Ok(())
     }
 }
 
@@ -89,17 +91,12 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
 
         let start_addr = obj.0.dma_handle();
 
-        // SAFETY: `obj` has just been created and we are its sole user.
-        let pte_region = unsafe {
-            &mut obj.0.as_mut()[size_of::<u64>()..][..RM_LOG_BUFFER_NUM_PAGES * size_of::<u64>()]
-        };
-
-        // Write values one by one to avoid an on-stack instance of `PteArray`.
-        for (i, chunk) in pte_region.chunks_exact_mut(size_of::<u64>()).enumerate() {
-            let pte_value = PteArray::<0>::entry(start_addr, i)?;
-
-            chunk.copy_from_slice(&pte_value.to_ne_bytes());
-        }
+        let pte_view = io_project!(
+            obj.0,
+            [build: size_of::<u64>()..][build: ..RM_LOG_BUFFER_NUM_PAGES * size_of::<u64>()]
+        )
+        .try_cast::<PteArray<RM_LOG_BUFFER_NUM_PAGES>>()?;
+        PteArray::init(pte_view, start_addr)?;
 
         Ok(obj)
     }
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 070de0731e95..c34b48961496 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -2,16 +2,23 @@
 
 mod continuation;
 
-use core::mem;
+use core::{
+    mem,
+    sync::atomic::{
+        fence,
+        Ordering, //
+    },
+};
 
 use kernel::{
     device,
     dma::{
         Coherent,
+        CoherentBox,
         DmaAddress, //
     },
-    dma_write,
     io::{
+        io_project,
         poll::read_poll_timeout,
         Io, //
     },
@@ -171,20 +178,18 @@ struct MsgqData {
 #[repr(C)]
 // There is no struct defined for this in the open-gpu-kernel-source headers.
 // Instead it is defined by code in `GspMsgQueuesInit()`.
-// TODO: Revert to private once `IoView` projections replace the `gsp_mem` module.
-pub(super) struct Msgq {
+struct Msgq {
     /// Header for sending messages, including the write pointer.
-    pub(super) tx: MsgqTxHeader,
+    tx: MsgqTxHeader,
     /// Header for receiving messages, including the read pointer.
-    pub(super) rx: MsgqRxHeader,
+    rx: MsgqRxHeader,
     /// The message queue proper.
     msgq: MsgqData,
 }
 
 /// Structure shared between the driver and the GSP and containing the command and message queues.
 #[repr(C)]
-// TODO: Revert to private once `IoView` projections replace the `gsp_mem` module.
-pub(super) struct GspMem {
+struct GspMem {
     /// Self-mapping page table entries.
     ptes: PteArray<{ Self::PTE_ARRAY_SIZE }>,
     /// CPU queue: the driver writes commands here, and the GSP reads them. It also contains the
@@ -192,13 +197,13 @@ pub(super) struct GspMem {
     /// index into the GSP queue.
     ///
     /// This member is read-only for the GSP.
-    pub(super) cpuq: Msgq,
+    cpuq: Msgq,
     /// GSP queue: the GSP writes messages here, and the driver reads them. It also contains the
     /// write and read pointers that the GSP updates. This means that the read pointer here is an
     /// index into the CPU queue.
     ///
     /// This member is read-only for the driver.
-    pub(super) gspq: Msgq,
+    gspq: Msgq,
 }
 
 impl GspMem {
@@ -232,20 +237,12 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         const MSGQ_SIZE: u32 = num::usize_into_u32::<{ size_of::<Msgq>() }>();
         const RX_HDR_OFF: u32 = num::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
 
-        let gsp_mem = Coherent::<GspMem>::zeroed(dev, GFP_KERNEL)?;
-
-        let start = gsp_mem.dma_handle();
-        // Write values one by one to avoid an on-stack instance of `PteArray`.
-        for i in 0..GspMem::PTE_ARRAY_SIZE {
-            dma_write!(gsp_mem, .ptes.0[build: i], PteArray::<0>::entry(start, i)?);
-        }
+        let mut gsp_mem = CoherentBox::<GspMem>::zeroed(dev, GFP_KERNEL)?;
+        gsp_mem.cpuq.tx = MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES);
+        gsp_mem.cpuq.rx = MsgqRxHeader::new();
 
-        dma_write!(
-            gsp_mem,
-            .cpuq.tx,
-            MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES)
-        );
-        dma_write!(gsp_mem, .cpuq.rx, MsgqRxHeader::new());
+        let gsp_mem: Coherent<_> = gsp_mem.into();
+        PteArray::init(io_project!(gsp_mem, .ptes), gsp_mem.dma_handle())?;
 
         Ok(Self(gsp_mem))
     }
@@ -406,7 +403,7 @@ fn allocate_command(&mut self, size: usize, timeout: Delta) -> Result<GspCommand
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn gsp_write_ptr(&self) -> u32 {
-        super::fw::gsp_mem::gsp_write_ptr(&self.0)
+        MsgqTxHeader::write_ptr(io_project!(self.0, .gspq.tx)) % MSGQ_NUM_PAGES
     }
 
     // Returns the index of the memory page the GSP will read the next command from.
@@ -415,7 +412,7 @@ fn gsp_write_ptr(&self) -> u32 {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn gsp_read_ptr(&self) -> u32 {
-        super::fw::gsp_mem::gsp_read_ptr(&self.0)
+        MsgqRxHeader::read_ptr(io_project!(self.0, .gspq.rx)) % MSGQ_NUM_PAGES
     }
 
     // Returns the index of the memory page the CPU can read the next message from.
@@ -424,12 +421,18 @@ fn gsp_read_ptr(&self) -> u32 {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn cpu_read_ptr(&self) -> u32 {
-        super::fw::gsp_mem::cpu_read_ptr(&self.0)
+        MsgqRxHeader::read_ptr(io_project!(self.0, .cpuq.rx)) % MSGQ_NUM_PAGES
     }
 
     // Informs the GSP that it can send `elem_count` new pages into the message queue.
     fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
-        super::fw::gsp_mem::advance_cpu_read_ptr(&self.0, elem_count)
+        let rx = io_project!(self.0, .cpuq.rx);
+        let rptr = MsgqRxHeader::read_ptr(rx).wrapping_add(elem_count) % MSGQ_NUM_PAGES;
+
+        // Ensure read pointer is properly ordered.
+        fence(Ordering::SeqCst);
+
+        MsgqRxHeader::set_read_ptr(rx, rptr)
     }
 
     // Returns the index of the memory page the CPU can write the next command to.
@@ -438,12 +441,17 @@ fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn cpu_write_ptr(&self) -> u32 {
-        super::fw::gsp_mem::cpu_write_ptr(&self.0)
+        MsgqTxHeader::write_ptr(io_project!(self.0, .cpuq.tx)) % MSGQ_NUM_PAGES
     }
 
     // Informs the GSP that it can process `elem_count` new pages from the command queue.
     fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
-        super::fw::gsp_mem::advance_cpu_write_ptr(&self.0, elem_count)
+        let tx = io_project!(self.0, .cpuq.tx);
+        let wptr = MsgqTxHeader::write_ptr(tx).wrapping_add(elem_count) % MSGQ_NUM_PAGES;
+        MsgqTxHeader::set_write_ptr(tx, wptr);
+
+        // Ensure all command data is visible before triggering the GSP read.
+        fence(Ordering::SeqCst);
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 4db0cfa4dc4d..b0e7de328eaf 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -10,7 +10,14 @@
 use core::ops::Range;
 
 use kernel::{
-    dma::Coherent,
+    dma::{
+        Coherent,
+        CoherentView, //
+    },
+    io::{
+        io_read,
+        io_write, //
+    },
     prelude::*,
     ptr::{
         Alignable,
@@ -44,59 +51,6 @@
     },
 };
 
-// TODO: Replace with `IoView` projections once available.
-pub(super) mod gsp_mem {
-    use core::sync::atomic::{
-        fence,
-        Ordering, //
-    };
-
-    use kernel::{
-        dma::Coherent,
-        dma_read,
-        dma_write, //
-    };
-
-    use crate::gsp::cmdq::{
-        GspMem,
-        MSGQ_NUM_PAGES, //
-    };
-
-    pub(in crate::gsp) fn gsp_write_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .gspq.tx.0.writePtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn gsp_read_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .gspq.rx.0.readPtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .cpuq.rx.0.readPtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, count: u32) {
-        let rptr = cpu_read_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
-
-        // Ensure read pointer is properly ordered.
-        fence(Ordering::SeqCst);
-
-        dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
-    }
-
-    pub(in crate::gsp) fn cpu_write_ptr(qs: &Coherent<GspMem>) -> u32 {
-        dma_read!(qs, .cpuq.tx.0.writePtr) % MSGQ_NUM_PAGES
-    }
-
-    pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
-        let wptr = cpu_write_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
-
-        dma_write!(qs, .cpuq.tx.0.writePtr, wptr);
-
-        // Ensure all command data is visible before triggering the GSP read.
-        fence(Ordering::SeqCst);
-    }
-}
-
 /// Maximum size of a single GSP message queue element in bytes.
 pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
     num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
@@ -720,6 +674,16 @@ pub(crate) fn new(msgq_size: u32, rx_hdr_offset: u32, msg_count: u32) -> Self {
             entryOff: num::usize_into_u32::<GSP_PAGE_SIZE>(),
         })
     }
+
+    /// Returns the value of the write pointer for this queue.
+    pub(crate) fn write_ptr(this: CoherentView<'_, Self>) -> u32 {
+        io_read!(this, .0.writePtr)
+    }
+
+    /// Sets the value of the write pointer for this queue.
+    pub(crate) fn set_write_ptr(this: CoherentView<'_, Self>, val: u32) {
+        io_write!(this, .0.writePtr, val)
+    }
 }
 
 // SAFETY: Padding is explicit and does not contain uninitialized data.
@@ -735,6 +699,16 @@ impl MsgqRxHeader {
     pub(crate) fn new() -> Self {
         Self(Default::default())
     }
+
+    /// Returns the value of the read pointer for this queue.
+    pub(crate) fn read_ptr(this: CoherentView<'_, Self>) -> u32 {
+        io_read!(this, .0.readPtr)
+    }
+
+    /// Sets the value of the read pointer for this queue.
+    pub(crate) fn set_read_ptr(this: CoherentView<'_, Self>, val: u32) {
+        io_write!(this, .0.readPtr, val)
+    }
 }
 
 // SAFETY: Padding is explicit and does not contain uninitialized data.

-- 
2.54.0


