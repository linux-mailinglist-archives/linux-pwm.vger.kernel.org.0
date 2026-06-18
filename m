Return-Path: <linux-pwm+bounces-9327-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KXayE4smNGrhPwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9327-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:10:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9DE6A1D42
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:10:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=cUfLjIHH;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9327-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9327-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01BBA3086413
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0473D34B9;
	Thu, 18 Jun 2026 17:05:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021095.outbound.protection.outlook.com [52.101.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B069A38D40D;
	Thu, 18 Jun 2026 17:04:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802301; cv=fail; b=D9hGUVHYQYkOZSiGhbzTRtuDEgeNuYlnM4beZeoz7zGK2yb0Gmzwavx5d3Zd+cpGA3G4OJ6/LgHXQxZV/BHfm8FeINa4iMdXXjMo3EvCi7JIWNnnq216MMJ8Dvnh/U3+fhVu3KlW0+qJz1JmPdD4l1hF8sjIa7p8IMbvmxCgZbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802301; c=relaxed/simple;
	bh=7zpVkHCR9h1gLWrM+Ap5JrIOi++3AqwCQrZPkd+l48A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Vp9yjJd9JXhuIM3SCxMzMZLjhQ5ivM8de6d55i3v0naegjmRtAY/Yh5pBNrFfOACVH4pFJ915TAoAPGkLko9nDsxx3M57TmLOcwisl1iptadViFXMmjp5YS+qXa1gttkQOpGrkunByVPm19yDamuLmOmXakAnCu1FeStwRf0VuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cUfLjIHH; arc=fail smtp.client-ip=52.101.100.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQiqm935QXTxX296o39TiwFkblNKCVp6ixQZhdddPLwiXJOOFXH3XdtdP32gzxaxb1kNO+CYfO+rtTUP0MkQUY3ZjGlZte1EN3QLlRBupAUsL3I4YF82WM1ejdkmjcK0ulPHjj5Tt8tUn7d6ldiitqRpV9BONWekjy39NURsPK5mlQ2Nqlgc6LoGWdrQseiSy197MaqLWVo2Ta1r/j7Pu3Xz4pTmZSCtS3IENXGyp/e9yF2F6I6R/tTqG+fwnfe2uwjUxdvW3dWdtrGobHitul3kdQmwOhJOyOHMZq5TG++hAB2c7gLk6rNTvytWTQJ8dtkhvHBoZVyWKW0TbOm7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUNMivL21AeW8IKEvavxjLaGvrE0kGH/DYf+mDHcDb8=;
 b=Dw3gXJlmJWznQr0V9yk42RZnY84mEyf3SeW+q6/Fejwl2dWyjspvu9gHv7enSZ0bsOpNQf9bcdd1EIMCKjMBmVnjEAPNKxdbCL9PeUznX0M3euMbHjT5glT/ZzN8KmXehZ+9P1mVK4SSi5SooNUQMR4Yt5X5kJNhBqXKqxDcLccCFyf/Ygi+G07r80XX6xxA5cK0w9mS2ESP6jdU5t2kx2C4sgld08WTUlVyUzvHh8c6vJiNyyANA72mFiK/LoP4YGVwUEnJxd+GGwJmNYi/LqnC7DR2QU7YqPhYm7T3vR+2ASIwR0B7HAuX4P+JLrxsgHQJDAFcG6S047QeDiqHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUNMivL21AeW8IKEvavxjLaGvrE0kGH/DYf+mDHcDb8=;
 b=cUfLjIHHpyubYDhJvjcs7ocofadpXWe4nCG48IYVElUQN4roEWK9J0x08LS/9Gr1OwxNAhfi5GRgzEi1xkNyNiiDnNhTlCf1tjATqmIC/uIWgRcrFObWq4Vf7ssJnnFIKQAYQk4nfhxIHt+u5Dc1JijtsS0Izmjdlg3DItaOKN8=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6966.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:04:48 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:04:48 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 18 Jun 2026 18:03:45 +0100
Subject: [PATCH 08/10] rust: driver: remove open-coded matching logic
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-id_info-v1-8-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
In-Reply-To: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Dave Ertman <david.m.ertman@intel.com>, 
 Ira Weiny <iweiny@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
 Len Brown <lenb@kernel.org>, Igor Korotin <igor.korotin@linux.dev>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781802282; l=7838;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=7zpVkHCR9h1gLWrM+Ap5JrIOi++3AqwCQrZPkd+l48A=;
 b=Ee2Xur8kUcl0h6lcFW1aCU4aqzMtdZ2we2EuMJPIa4WLN9RExdhTagHpgygZzjbxWw86drCDl
 HQTbU+PQBg5Cr1jDxjYhefbpszfU9IbIt7G10IXWnAjIJDBQ7iJF+VD
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0548.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f704c9a-812f-40fc-1e88-08decd5bb44b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|7416014|921020|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JHc9XuTm6I9ncDTdLXLjeeapDkXj1dfkTewOs9cnJv77xq7x5TJRD+SP/J+PwycMH+IFxH0dXLz6SRrjKWnW/eANNePn5XsQ4FEd/Gyq4ryMRvLru0QonarpQ25SvN858dHVpRETqwFzjQcMUwMz9Tec7lddHVSBZ3R3n2ttYo1Wrw2rtQk36dY16Yr8ynt/3jNuhLj7r9RxFKpnkkqnhEA+/asSqlAHsGTrnsNM6tBms9tqBaW0TDra4LnOAqlwXzcov5vz8fKTHUp/hWgi6rU9wNjLT8pFIsMq2eOU17X4PpPTgmYTXTWxT6EKj9BxGvTWmjcvzoA4gcBT6RLNthaKLhXpzH/xjziG7u1bT/SO0lhKgUpjacHGpzVq0zw8f1qcCTuikQEi4zTySDjvRsnYBxqNOMamHoJYZqTOxmZB0tBnfFX9f19MEfsxIYfL8U4L8eprAyG8GL1I3c+e8DZupJ3u8TQ0wxymIC5o7HAyeOu1uxVzeEeyjM8YXyjmUFy6c+ELeNlbklKfv2pLgVJAxR9dLKUuaJ0PAxSFUMhZnn5or9Y9kMvzXDOkD3B5cltlcP8Yi/IJICUJsATnYDx4wsSUOo2VrjcwWNOcdnrUctgAcvPpDZdh5NFnSZSQO7XS5mvPr+hBnKT+pSEOwdZ3hyo3tMfmk340voozB/EUkiwzFOAUsYMyu1SYW02Ik8uKZDV6rjsH412iklYNxDagEPywzrms1yl2gZYcFRE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(7416014)(921020)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFljTEFQanlwWVlJOVk1YUhETTR2cVJSbHJXK0hDNnlUU3UxUHN5TDdHcFVZ?=
 =?utf-8?B?T2d1QkxjRkRsTWswMzNEZ2ZtYjNrMjNNYitCQldqeU5qZUs5aFF4WWI2Y1Yx?=
 =?utf-8?B?VUhlUHJreU1HSkNiaVFoaHlMR28wb0ZPdktucHZwNU15MHhzc0xSSGlBd3R2?=
 =?utf-8?B?ZHVyMDdiRDZENTZIRnNCQ1JLay9mWDA5b01pYXE0WjhYZFl2RGxGbEJVbUVw?=
 =?utf-8?B?TnBiV3c2dXFGSkdvWWV4Q2FYL1IzVnBtVUs3VStLV2FHMjczL0ZDTk5LTWYw?=
 =?utf-8?B?YSs3eEVkMkFiQWZIYlM4OTNwTkh6czlHd0NabUNmMktCM2ZnQmh4VjNIL2Jl?=
 =?utf-8?B?SjlGZHl5a25hM09lSzc5MTJWNkFMTER3UzJ0bERFeWJVeHRuZGRDRTRibG5o?=
 =?utf-8?B?dmNqbkVVNUhrN0YvdEt3UmlMclF2Z2lnQU5WbHJPR3d1VVoyR3Exa2tTT3Vt?=
 =?utf-8?B?TittVS9sdklZNXcyekRhaUpWb1JOcXEwZzFZN1h5L0IrUkgyWFBtZURwSHhq?=
 =?utf-8?B?NTNERlBRSTZraVpLTWlHU0hSbnRKWUJPVEJSYnJWT1RvL0tFM3phb3I0RCti?=
 =?utf-8?B?Z3hxVEt6QmlFTzY3bUhNTTQ1OVpIU0UxVG9OZjlWV05pVyt1VUJ3R3RDRmhz?=
 =?utf-8?B?K3prV1JEbUwrRHVlMVFTa0xIbUZRYk9Ec3FmclBNMVhYNDkxdUlTV0Q5N1cv?=
 =?utf-8?B?N05CSDhENU9TdFJsWE9xbmFoYkR4aW96UW13RDFHRW5tSzZaaWM0dW1JNzRQ?=
 =?utf-8?B?aVNvbHNaVnpiQ2IwY0hUSzA3MElnUkhzWTcrbUFyWkpsWm1tLzMrb0pZYk52?=
 =?utf-8?B?cmFlelhtOWZER3Rscm4vUWk4bGdBZVBZQkVJOHgxR1B6WnJIVTRlMUdkbnJ0?=
 =?utf-8?B?cjBETnZnYnFjeFdSdC9Kb1Y0SFE2YkJHUExzTlFFWEJrbHNoOHlzOThsanIz?=
 =?utf-8?B?SmdqdVFuLzF1K0pyVzJhZEpOZWV0OHFQaWFSNkhkb1QwY1dKM1FvQ2tQREQw?=
 =?utf-8?B?cEpsOUpSQUovMVBYRGxHcHlKZG55MTJ2ckRHR2ZhSnRxbkQzaXgrOXIxelNs?=
 =?utf-8?B?TFdnTnplMWlrNU5DUlltQXV4ajUwNjM1NURMNnQ0dXFMeURSWmVMSS9wa1NP?=
 =?utf-8?B?d0sxck41TGFseWttZENWSk9aVDJubVBoLzZhQXowaE5mUTJPeEtzenJDVXdp?=
 =?utf-8?B?QUVLZ2JaNjZWZmxodUQ2SnVNWXlmSEtDTnJRdzlTclVuKzFJSmxad2xUU25j?=
 =?utf-8?B?VTdKbnVLYnB4MlZRRnN0R2xHZ24xMnd3cnpYR2VPcGFRZUdVYWIrKzlpME9F?=
 =?utf-8?B?K1lYQyt2VnRoTzhxQkFML2tUenVacWxvRjE1RFVlSXBoU3JZVG41ZlViMXBt?=
 =?utf-8?B?cUwvZTh4ZjlzRUpsakpMcmZBbkJGY0JqODM1ckpJQWgvWTlLRVk5UTNmeEZC?=
 =?utf-8?B?N2lEbVppTk9GL25objZLWXBzRFQvMGdrTFF1b2hXQ3BSUTBHaXlIL3V5aTVG?=
 =?utf-8?B?Y1RiMGw3NFIvcGJXdHlPaGlkQmhBTWJiaVJybUhvTU1jM1JkUU0xNjlpcTEw?=
 =?utf-8?B?eUZWdEs2QW9ER3g4S21hVGZtZ3pGR25QVTFkakxFbExDc3VKSXp4U0EwYjU3?=
 =?utf-8?B?eDdKaWxnU1JnT2RuNjJxVWg1Y05CemNtb2xkTDQyaVNnbnFpblVmbElOQmo3?=
 =?utf-8?B?ZytjSGFQQ2VudjN5SzdyUm5iU2xFKzE2VVg1d0lwS3BONnFneG5FN3hOTGlM?=
 =?utf-8?B?cVV0SVpnVksxNjBlOWt5WnZMMnNVdDNlbFp2elg0WGUwVGVNR3J3ZUNIYXQ5?=
 =?utf-8?B?S2xYQStZTHh2b3NWY0NEdU81RXJKc2c0T1N2WjZaN3o2cjNHM2hTSGpheXh4?=
 =?utf-8?B?N3dEejBwOTFZS0ZtTlBWRitsVTBta2M1a1JOdE4rM1Uvazg4RGhFaWtyQUFm?=
 =?utf-8?B?SWxYQVFYT1JmbjMzS2dFMHBhaVdsMEpXQnMxYW9QNW94K0dJZU5yVTJTZFRI?=
 =?utf-8?B?TW5CYjVtYlJlVjdDc1plK3E2R0dlVER2KzZjcEdud3B2ZTZyNzNLTGhJelFE?=
 =?utf-8?B?SFNEZUJQYTQvb2hBTU1ic3gxdTBGM3RmRE4rRG9qRzVDMzZuTzlVY3doek9t?=
 =?utf-8?B?aW9NMHlYdUlhaWpXenVIY01xVjRxRk03eWR4NXlvNmlWdmROZ2xiTUQvMXhk?=
 =?utf-8?B?V0JYcVdDaWJ5eGFqM21adDBpWjJPV1JCTGkxQnBYQ0g3ZUZGMXRUWHJ1RmFS?=
 =?utf-8?B?MkZiK2tWcWlEdVVwK3loekoyakN2Z3d3ZHN5Z3VxYms1R0w4WGM2SWkvNnNr?=
 =?utf-8?B?N0VoWjQ5Rkl5aXhud3ZNU0xLWnFyOHBDVlhWZGJYMDc5SkdZMjdJUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f704c9a-812f-40fc-1e88-08decd5bb44b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:04:48.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfgQ70mTnAdNUFxTpAhJ/5SPgfSgeeWQHKFeXPgpe7WemLdkFbXI2PL4B30ra0tEmP7Mw+nwpfiMtvEJe7C3Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6966
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9327-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,gmail.com,ffwll.ch,arm.com,intel.com,linux.dev,linaro.org,samsung.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fujita.tomonori@gmail.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:david.m.ertman@intel.com,m:iweiny@kernel.org,m:leon@kernel.org,m:lenb@kernel.org,m:igor.korotin@linux.dev,m:robh@kernel.org,m:saravanak@kernel.org,m:viresh.kumar@linaro.org,m:m.wilczynski@samsung.com,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pci@vger.kernel.org,m:lin
 ux-acpi@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:fujitatomonori@gmail.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB9DE6A1D42

With device ID info now including pointers instead of indices, the
open-coded ACPI/OF matching is no longer needed and can be replaced with
`device_get_match_data`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/driver.rs   | 114 ++++--------------------------------------------
 rust/kernel/i2c.rs      |   6 ++-
 rust/kernel/platform.rs |   3 +-
 3 files changed, 15 insertions(+), 108 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 824899d76fed..a881f5ef99ec 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -107,7 +107,6 @@
 use crate::{
     acpi,
     device,
-    device_id::RawDeviceIdIndex,
     of,
     prelude::*,
     types::Opaque,
@@ -325,117 +324,22 @@ pub trait Adapter {
     /// The [`acpi::IdTable`] of the corresponding driver
     fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>>;
 
-    /// Returns the driver's private data from the matching entry in the [`acpi::IdTable`], if any.
-    ///
-    /// If this returns `None`, it means there is no match with an entry in the [`acpi::IdTable`].
-    fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        #[cfg(not(CONFIG_ACPI))]
-        {
-            let _ = dev;
-            None
-        }
-
-        #[cfg(CONFIG_ACPI)]
-        {
-            let table = Self::acpi_id_table()?;
-
-            // SAFETY:
-            // - `table` has static lifetime, hence it's valid for read,
-            // - `dev` is guaranteed to be valid while it's alive, and so is `dev.as_raw()`.
-            let raw_id = unsafe { bindings::acpi_match_device(table.as_ptr(), dev.as_raw()) };
-
-            if raw_id.is_null() {
-                None
-            } else {
-                // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct acpi_device_id`
-                // and does not add additional invariants, so it's safe to transmute.
-                let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
-
-                // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
-                Some(unsafe { id.info_unchecked::<Self::IdInfo>() })
-            }
-        }
-    }
-
     /// The [`of::IdTable`] of the corresponding driver.
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>>;
 
-    /// Returns the driver's private data from the matching entry in the [`of::IdTable`], if any.
-    ///
-    /// If this returns `None`, it means there is no match with an entry in the [`of::IdTable`].
-    fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        let table = Self::of_id_table()?;
-
-        #[cfg(not(any(CONFIG_OF, CONFIG_ACPI)))]
-        {
-            let _ = (dev, table);
-        }
-
-        #[cfg(CONFIG_OF)]
-        {
-            // SAFETY:
-            // - `table` has static lifetime, hence it's valid for read,
-            // - `dev` is guaranteed to be valid while it's alive, and so is `dev.as_raw()`.
-            let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), dev.as_raw()) };
-
-            if !raw_id.is_null() {
-                // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct of_device_id`
-                // and does not add additional invariants, so it's safe to transmute.
-                let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
-
-                // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
-                return Some(unsafe { id.info_unchecked::<Self::IdInfo>() });
-            }
-        }
-
-        #[cfg(CONFIG_ACPI)]
-        {
-            use core::ptr;
-            use device::property::FwNode;
-
-            let mut raw_id = ptr::null();
-
-            let fwnode = dev.fwnode().map_or(ptr::null_mut(), FwNode::as_raw);
-
-            // SAFETY: `fwnode` is a pointer to a valid `fwnode_handle`. A null pointer will be
-            // passed through the function.
-            let adev = unsafe { bindings::to_acpi_device_node(fwnode) };
-
-            // SAFETY:
-            // - `adev` is a valid pointer to `acpi_device` or is null. It is guaranteed to be
-            //   valid as long as `dev` is alive.
-            // - `table` has static lifetime, hence it's valid for read.
-            if unsafe { acpi_of_match_device(adev, table.as_ptr(), &raw mut raw_id) } {
-                // SAFETY:
-                // - the function returns true, therefore `raw_id` has been set to a pointer to a
-                //   valid `of_device_id`.
-                // - `DeviceId` is a `#[repr(transparent)]` wrapper of `struct of_device_id`
-                //   and does not add additional invariants, so it's safe to transmute.
-                let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
-
-                // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
-                return Some(unsafe { id.info_unchecked::<Self::IdInfo>() });
-            }
-        }
-
-        None
-    }
-
     /// Returns the driver's private data from the matching entry of any of the ID tables, if any.
     ///
     /// If this returns `None`, it means that there is no match in any of the ID tables directly
     /// associated with a [`device::Device`].
-    fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        let id = Self::acpi_id_info(dev);
-        if id.is_some() {
-            return id;
-        }
-
-        let id = Self::of_id_info(dev);
-        if id.is_some() {
-            return id;
-        }
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the `dev` matched data is of type `Self::IdInfo`.
+    unsafe fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+        // SAFETY: `dev` is guaranteed to be valid while it's alive, and so is `dev.as_raw()`.
+        let data = unsafe { bindings::device_get_match_data(dev.as_raw()) };
 
-        None
+        // SAFETY: Per safety requirement, `data` is of type `Self::IdInfo`.
+        unsafe { data.cast::<Self::IdInfo>().as_ref() }
     }
 }
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 9e551c7e8e41..07680fd2f3fc 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -149,8 +149,10 @@ extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_
         // INVARIANT: `idev` is valid for the duration of `probe_callback()`.
         let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal<'_>>>() };
 
-        let info =
-            Self::i2c_id_info(idev).or_else(|| <Self as driver::Adapter>::id_info(idev.as_ref()));
+        let info = Self::i2c_id_info(idev).or_else(|| {
+            // SAFETY: `idev` matched data is of type `Self::IdInfo`.
+            unsafe { <Self as driver::Adapter>::id_info(idev.as_ref()) }
+        });
 
         from_result(|| {
             let data = T::probe(idev, info);
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 210a815925ce..e12e88113ca5 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -100,7 +100,8 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
         //
         // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
         let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
-        let info = <Self as driver::Adapter>::id_info(pdev.as_ref());
+        // SAFETY: `pdev` matched data is of type `Self::IdInfo`.
+        let info = unsafe { <Self as driver::Adapter>::id_info(pdev.as_ref()) };
 
         from_result(|| {
             let data = T::probe(pdev, info);

-- 
2.54.0


