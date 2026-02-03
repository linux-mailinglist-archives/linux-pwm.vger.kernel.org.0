Return-Path: <linux-pwm+bounces-8078-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNZeKFpcgmlhSwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8078-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 21:36:42 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC239DE88D
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 21:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20AAF30015A7
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC12FB0B3;
	Tue,  3 Feb 2026 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="JNqLK/H8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021138.outbound.protection.outlook.com [52.101.100.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF52652A2;
	Tue,  3 Feb 2026 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150996; cv=fail; b=MUqshQ2qJMJTIxQhz57+oof6Is1Cmx1GT3JoQBPJX/DeSg4tNwrNiRtu4kAQMWFeq/umQtB/25CqtCsFyKaVVQn590KmInGBU44lriTiIzdnZcPa/3TkKM2MF57XjtyhYpjgkgOEWmdqSdmZvd/ieUSWjxYCA+gYQRHzLLq0jvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150996; c=relaxed/simple;
	bh=It3FjfN1X9a3NJol08KaA3a1KtRaQMEvFG444dK7H98=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=pLCQ9JyQrYnEUefiKWBu27ghRtnQRwZf/Qj6Tc1/b6aE9/QHjOcsbdQbt+P9Wy92eyoPXpjDY97wIF+x80mDd0KQM79Q9T5rZILpN2Lyu6MxogS2npPDW+DHPk4LcOuj+be9GHdVYcRaMxZWTIGxK0xsQH34ybCbhZT2U1l9alw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=JNqLK/H8; arc=fail smtp.client-ip=52.101.100.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+P6nN4xhyXA0n2qAgpzaBcVj2xomkCrnCMbqMSDDd7RrUGg/FkmQ+03yEPMOkmdOvnzkWERPN9/l0XQlZMgvx6IokewlvRGRNags97Z6lK2aFlmnHtrBmb2Ji1nSDqK9pw5XprNiTzQ0YK0YRbmCc7ig9to5n1xinlKxGUkdYTCajsAqfFleJgdH1EAyZPgS5fKHKC1EOoxI8nALO5W/z2L58W6XESMpsAZeTyKdDxWA+ZXbafe3VjNxZwa9EfOKsWVljv1So73x+jSyAw/ZfK9qaXUvlaclaKfE9V4zziDyVxYERTgf/en7KLTUiWz3bp7OvLbEOJjYuLaiu4v/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2ZlCu1SQcj8SZbgt6TXmLfCj8eK/4dGeANGducE/uU=;
 b=PY4ftXhPB1eel22vGhOw8hfnjuGqoKgGdKS6W1WjtyscVx2qlsoMSoBl/vjvi6hAThK88WKVQWmjDpJlcZgg7li542XrzLVipWSlsX2vpTqT7W7reRBOZw9jD67HSXLpi72tiSoYw74vpWDlGPDQnz06Iyn6adQKR5Y91uwnYDpAnUKCuMQqml3Cl15SP32C9ixoyVniRTscywtkI2ENclJJX1WbI7CCuwnccmdt6jy3u+wK+5yneLf6fg+qybD3AhCaqvR/Wq3sNLLRNUzqq7iRHpUAVpT4MljCJ5tWGGU2UsnrERvGtjZ5IUu4Q7l7lUiW/RmCWW9vbjZ6I4R47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2ZlCu1SQcj8SZbgt6TXmLfCj8eK/4dGeANGducE/uU=;
 b=JNqLK/H8QzrK+mntD+9bi4H8I4i4peh/wJGPH4MPNXJSdShTA7Uk02zwISZlCYNFLA0Mqidm2mI09q0n6Wy0s/B1c3jRWrno+A+DYiDCzAOtegEmno7x+hGHZOqNLY40ZQHWK9ODfASVjDsRCAOZvtbT6hjYBg5UKeYNiK+Pgkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB3445.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 20:36:31 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 20:36:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 20:36:30 +0000
Message-Id: <DG5M5MVHTNS4.1CUD61S0PD9NU@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Boris Brezillon" <boris.brezillon@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Maxime Ripard" <mripard@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Drew Fustini" <fustini@kernel.org>, "Guo Ren"
 <guoren@kernel.org>, "Fu Wei" <wefu@redhat.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
X-Mailer: aerc 0.21.0
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
 <20260108-delectable-fennec-of-sunshine-ffca19@houat>
 <98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
 <20260119-thundering-tested-robin-4be817@houat>
 <aW4lCfUyumOKRRJm@google.com> <20260203113902.501e5803@fedora>
 <E7286D12-0BD9-4726-B072-FE5A040312B1@collabora.com>
 <20260203150855.77c93e22@fedora>
 <4DD13AE1-C85F-450F-93F2-C7C75766E518@collabora.com>
 <DG5HJPIYMS7B.152WPGG9MZZJ5@garyguo.net>
 <B94452FD-5F6F-44D4-80D8-4D4B7004C4B5@collabora.com>
In-Reply-To: <B94452FD-5F6F-44D4-80D8-4D4B7004C4B5@collabora.com>
X-ClientProxiedBy: LNXP265CA0077.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB3445:EE_
X-MS-Office365-Filtering-Correlation-Id: e1df89f7-e043-4509-331d-08de6363ea33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elUySnFjZXE0b0dWOFlQT2plYWhNeGxPdnRNcm02RUVkWC9KZm8zS0NKODYz?=
 =?utf-8?B?Z09iTmJIL3lTbGt1d25XZW5rWDlSdG94ZXc2OUpGdzY5ZitEUUc2WFB5cEZj?=
 =?utf-8?B?NHE1MDZHUGVVK2FiZVEzbHNXRWpJaXpFRGE2YW9KNGRYWlYrOE5Gdll2ZDRw?=
 =?utf-8?B?UWExcXlxS1FqTlNEaERia2FxNFZObnpkTHpvLzJJRzAycktpUEV5em1TNHRy?=
 =?utf-8?B?YjNYSDJzQlNjTlV4V0htZHlaT0dIVmo3RWx2QjVVcFFaaVlTQ3ZmMERNRlVX?=
 =?utf-8?B?eFY4dCtMU2tma0FxYkRDbnVOR1A5am9qVXBWYURPL1VheVJPdlV6OHNINk5Q?=
 =?utf-8?B?bWllSGR0UENkcFgxd1RiMlF0dmdwS0l0N0NVZFRuMlpMSW5mcHJPQVRiUEpn?=
 =?utf-8?B?QWRjSSttZG15RnBJTXhOZkZVWEFkcmI3Ukg1U016cVV2bUgxcEp6UGRZNklT?=
 =?utf-8?B?eVdLUGorMzlYc1Boelc2ZGY0amk4UjllT0dFNFJBZ2FjZnZCT1lyeVQvemhY?=
 =?utf-8?B?L3JmcWxpdTB5UUpncHNyRG0rUXMvL1AzL2NvYkNhbWc5QkV5blFJZGxZTGdi?=
 =?utf-8?B?MTlXY3BDTFRHV2FOWkJEdCtqSzNvTlFUUXhab1V2V243UjhJUCtQM1R4c1Fq?=
 =?utf-8?B?dWxxcUhsZUVvTldjeFlLUWN2MnhpS1JETHo4UEJqcVNjQzlMNmU2aXV1aEls?=
 =?utf-8?B?NVlMOVY0bDVQMlpCeTJzODdqODVYUFpGa3pXZjJLZi9QRU05WVErS003WEM5?=
 =?utf-8?B?MnVyTEVicjRUTEtwWVZHaFVxZEFoUWZQTXFrZ0x6cURUbFdaT3FhS3NKM1ps?=
 =?utf-8?B?MUpTOVZjLzFkbkhFbEN2V1dQd0xXREZFV2JEeVFSdDBkZEphK0NVdGlHWXFa?=
 =?utf-8?B?a253cjdXQ3VYZHNOYlhwSVkrODFlZ0pVamhDUDhFSldKZWgrckNjZVBiY00v?=
 =?utf-8?B?V0U1MWNyOVEzQlhwV0hIL25aM1lGb0hnRlpEUmJ3KzYwTU5wd0lZQkd3VzhS?=
 =?utf-8?B?cy8vT0lCYVhPcEVMdGJRTFR5bFpRL1pmZEdodTBFUTBNVDBQaUQ4OFpvSUl3?=
 =?utf-8?B?QkhqS1NCaEROd2RXMzdneDFXNERwRTROdmZRTE9BbzQ0VzUrcm95Zi9mbWNR?=
 =?utf-8?B?QWpXVTNLVVpmaEQ4VXJCWk4yWmVTWCt4Vk13azhma01ySG8zeHVlaVIrcFNY?=
 =?utf-8?B?a3R6NWlwMFYzSG9VME1mSm9CY2pPaHUwbHZkY2Zlam5pWXdrcmN0TGpPYTVV?=
 =?utf-8?B?cForUis5WVhKcjZ6NUhWTVI3bkg1UjRwVXVCUlZmQTZCVC9rRmZidkxabGs5?=
 =?utf-8?B?bW13ME83emlXazI2WVh0VmZyUFNmMGMwWlBNZVFJMU02UHVRblBFNllBdXJP?=
 =?utf-8?B?cEthOEU1cGdXUUhsTUhYVkduSitabENJQlNqeklaSjVtekJEKzZnTkIyMWU0?=
 =?utf-8?B?THhZZkNsS0lmSzZLWkc0R0xjQXlkeWxjZTRpUzNPQWdIVnErY3g0Mk8rMjAy?=
 =?utf-8?B?eWwrZHEwcjIyTDczRkZJeU82eklwOS85L2lFNGEraDVFbDV5ejBVN1lQeHl2?=
 =?utf-8?B?UTNaQVN1dnZvWnluSHd4NHI2d2xKQ0l4MnByLzU2ZVBaaXVwTGI2RXNETmZ5?=
 =?utf-8?B?TGhQWjB6TTJPbkJUckNBdkROQk9lRDBaQTZXZE1vUndpcWNVdjgvYzc0NTc0?=
 =?utf-8?B?NnFpOTF3dGs5alo1RGh1VlB1U2NRSEVHOVpkYmN2eTBBYVhiRDZzSnV1NFRr?=
 =?utf-8?B?T0V4bTZHbmFNL2Qvdnd5TmVvblhVQURnbG5VZFNTMzhNRFhDTko5SUxwL29Y?=
 =?utf-8?B?QWZCb01LOWd3clIrczdlQTR0NEdUVENGM3hBcU0rOElCb3dHUG04MjVsVW5U?=
 =?utf-8?B?Z0ttYlpweFQxbElockR6T2VTbGdoQkQ5NEt3aU16aU92YVJ2TEJ1RnlFVyth?=
 =?utf-8?B?VjhwKzFvNDJJd2V3OGFsYzFGYjlGSFU5MjJyaXJrN1RKZndLdlpvTmlqQm84?=
 =?utf-8?B?cW9nck51ZWJLZUM2clZpK0V4QzRqSmJHSDhvTDBxSEtwLzBFWmZocGxoQUNk?=
 =?utf-8?B?Q1ZmOWxEWGdwL3dwMEwvMFNtNEtjUnU2dkpGREtoNDZ3SXlHbTJMc2s1NnFt?=
 =?utf-8?Q?++AY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWxmUHlyQloxbGpOUTlWTFpSV2pxRUtVOUdMaFhKeXFsc3RhSFBZVUh2VGpK?=
 =?utf-8?B?andWaVVoejg2UnFHd1hLaml4ZDR6MkNBNVk1dWhiWkNqektZSkphS0lkSXpF?=
 =?utf-8?B?QTJucFhpbGpkYnRkMC9DL0RyNzl6ZVp4Z2MvVkRrdm9SaHl1eG8zU3Rpd25Y?=
 =?utf-8?B?TVRrQmlNRjhGNEV3TzNNNFZRQ2pBb3E3cUMzQjk1dEtoTjNxMnhpanB2Rm9R?=
 =?utf-8?B?SlhQbUtmNGxRM0YydnRwWXlOdWNsK0RJbXpzcWEzdmI5L0hLZ2xUa1h0cVBF?=
 =?utf-8?B?QlNxd1Fsa2RJazZWbkpOSGJ3Z3hHSlFQR1NlMEdxMFhpUjQrRGN1eTRFektj?=
 =?utf-8?B?WkVEbk5DZ0VEQzJHSEl1UVZFY0IzZU5kSi9JYklpbjRCSG95RmtndmRpbFdV?=
 =?utf-8?B?UTQ1eitJMThzMjFMaUVyLy8xYUZERlVTRUw3bFoxVmdRUXRCN0dNU2p1eWo2?=
 =?utf-8?B?WDNlRUc2TERMbGZqNWdaaE9Fb240K2hQN1NrN2gzQXJOVjlPenpxOU0yVTFL?=
 =?utf-8?B?UlRUNzJoUGY0Z0VPZk44TGZMd2ViUnBNQTN6SDI1amZMWnBoK1VkbVp2WHBy?=
 =?utf-8?B?MDJFZm9STnRsZVhYZmNCRmEvd3NabnNYTXppZXBkSGlLYmc1Q1FlLzQzNmxS?=
 =?utf-8?B?cUYzcmVkSlk5UVFEZ0l2RzJwVW8weHlvL05HK0VjcVJ2emRHWkEzWmdmWmFZ?=
 =?utf-8?B?WklIZ294ODR2MEdUOXM4WU15WDhYR242WHNMUkJyYjc0ZlNTTjVnOUNuK2F4?=
 =?utf-8?B?M3N6aHNOOVdmUDc1dExqWGFHK0ZwWnJscGRvdWorVVUrYmpwbE1wbFU5WnNu?=
 =?utf-8?B?ZW1KcFNON0NvRHpjVU8yMk00L2sxU0FabnI2U0NDNWRhdGx1ZS9UT082YnN4?=
 =?utf-8?B?TUpCaEJaVW5wdVMvR0o2VFViK3pOalArV2FMSnR4bU0vb2FveTNJQjZKZHly?=
 =?utf-8?B?MFk3VEQ1MzBFR0cyWDl4YzNCcldLWmU2d1A2T1gxb1dOeFJ2MXZMc0JtTzdU?=
 =?utf-8?B?U0k4NFVmbjU4T0R0TVgyTzZUZ1F1cWpQeEgzWGxYZWowRDBkVDNUVHNTNVhw?=
 =?utf-8?B?ZzA0cElIVGJsVnZBeGVQVk8vNkRJS21jbzh2QjZ3bW5DMnJhVTI5aXlJZUY2?=
 =?utf-8?B?Qk1WUU1Sbmd6WGR2YTM5NGhVa1k1TDVKVEZpcXIyUlJZRU8xa1VwalJ2TmRp?=
 =?utf-8?B?ZGphWVBTczJwdVNnd1ZVQk9vbW1DaUJwNDV0b0loK04zYVRTN1N6Zkc1c2ow?=
 =?utf-8?B?Szd2SzJnaDhQNDhnbzhMWW5mN0pFMU5JRFR3b24vTCtrTmloZnVCT3pqam1M?=
 =?utf-8?B?R0hpVkIzMzJCK0M5QTlpUjhPV29ISVFWVzZMalJaVkNSTnhXUmdkVHdkTEtl?=
 =?utf-8?B?N09KenB6NmtHMVFvWnRMQ2xFckdCY2pZTEc1TXNXVkc4NnZ4VWc2MTh2TVFM?=
 =?utf-8?B?MlRrd3dyRGUrOXl0NE5FckRsZXlIU0I2U2MzVGdCZG16ejVoMDM4Z2ZKUm0z?=
 =?utf-8?B?dGcwRUJSMUhzSHU5QVVLMEtEN3Z2UHhEVzM1QXQzWUNCZHBkUDFaNEZnVW8v?=
 =?utf-8?B?bGJNSkNEeVVnZDRFMlZNVW1oc0l5Zkd4bFJsa0hwZUszMEpkWmlPbTgxbm1l?=
 =?utf-8?B?UWJZNE1ReXJ5RzdTS3M5M0c3V1NBd2taZ016bnJ6UFBHVE8zWHNjM01XMGRw?=
 =?utf-8?B?dmQzN0NpemhNR2NNdDJyMCtHcVdXWUorUUl1WWIyZmhtZ0hZWXg2TFBrQzEz?=
 =?utf-8?B?aW5rbXhzdm4vYVBieFIzOWdSZzRoby9yL1hsWnRUR2c0L21tNEhNN1ZSN29C?=
 =?utf-8?B?S1NJY3AvZjJTQzNtWW00Q3oyUE0zNDBPbmxUSVVWa2ptcFBodU1GSFJPSXFu?=
 =?utf-8?B?Yi93b3Q0ajNoYnNPR3dvNzNXR0VnQkVKd2hhd01FeW52ZDZMMFZxemQ5cEUv?=
 =?utf-8?B?LytsY0xFTVdYTnJzZ25iWTVQNG5HbFJTd2hyMHpna2tVQlVwYTFodnpFbHYv?=
 =?utf-8?B?Slh3ZnU3ajBkSkJkTTFhZHBjd0hBblErdkdwMXpsUlJaVHBScnc5WmxsdGk1?=
 =?utf-8?B?OEdNeXV1OHpzY2gxanJJaUpnd0haT29GSWtQYUwwZ3ZMdE9QblVWeDVhVzN2?=
 =?utf-8?B?bnNGdURjeldwQjRsckx6YmpSUlNsWFZZYnJ6ZnBkMGo1M1dVVzhhenhDWjFG?=
 =?utf-8?B?S0lTMDZ0NysrQjBseWZleFVxdjdFRWJOeHNTMWU4M1B0emcrMmdiU3JtY0hF?=
 =?utf-8?B?MmJuMXBoa3YrR1ZxU00xQ3B4aW8yNVc1RVVHcERpeUJTWGlTS3BINFNyaXQ4?=
 =?utf-8?B?RlU4RGk4T3lONUZPVU16L3JrTDJ1ejJuSG5pUkJRbEZPRS8xcE1Zdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e1df89f7-e043-4509-331d-08de6363ea33
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 20:36:31.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnjCkhtfD23JTCYQT4/lUdsBLcDB+ZvNnA3eZwUbQDi3vZP9KfVSPQD9erasKk2lpC9XyvV/VXb4+0RL12BQtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3445
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8078-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[collabora.com,google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: BC239DE88D
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 7:26 PM GMT, Daniel Almeida wrote:
>
>>=20
>> I think it's fine to have all of these:
>> * `Clone` impl
>> * `enable` which consumes `Clk<Prepared>` by value and spit out `Clk<Ena=
bled>`
>> * `with_enabled` that gives `&Clk<Enabled>`
>>=20
>> This way, if you only want to enable in short time, you can do `with_ena=
bled`.
>> If the closure callback wants to keep clock enabled for longer, it can j=
ust do
>> `.clone()` inside the closure and obtain an owned `Clk<Enabled>`.
>>=20
>> If the user just have a reference and want to enable the callback they c=
an do
>> `prepared_clk.clone().enable()` which gives an owned `Clk<Enabled>`. Tho=
ughts?
>>=20
>> Best,
>> Gary
>
>
> I=E2=80=99m ok with what you proposed above. The only problem is that imp=
lementing
> clone() is done through an Arc<*mut bindings::clk>  in Boris=E2=80=99 cur=
rent
> design, so this requires an extra allocation.

Hmm, that's a very good point. `struct clk` is already a reference into
clk_core, so having to put another level of indirection over is not ideal.
However, if we're going to keep C code unchanged and do a zero-cost abstrac=
tion
on the Rust side, then we won't be able to have have multiple prepare/enabl=
e to
the same `struct clk` with the current design.

It feels like we can to do a trade-off and choose from:
* Not be able to have multiple prepare/enable calls on the same `clk` (this=
 can
  limit users that need dynamically enable/disable clocks, with the very li=
mited
  exception that closure-callback is fine).
* Do an extra allocation
* Put lifetime on types that represent a prepared/enabled `Clk`
* Change C to make `struct clk` refcounted.

Best,
Gary

>
> =E2=80=94 Daniel


