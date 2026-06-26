Return-Path: <linux-pwm+bounces-9404-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id djANDKCQPmpiIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9404-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:45:52 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B926CE11C
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:45:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=jb+9qKNw;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9404-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9404-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 753A13005153
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AA03F9F48;
	Fri, 26 Jun 2026 14:45:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020077.outbound.protection.outlook.com [52.101.195.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3737F007;
	Fri, 26 Jun 2026 14:45:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485129; cv=fail; b=HNioFcpaigkH09Q4NCF6j830XGs/BuLIHKzKamfNhbaCiPjtPOuoZ29uEbG36FdI/9r1RdFCCfq6cnv2Er0S0Zswfc3GEBDj0hLZsXXCRazsAkbB1ixLV0pYs/1ql/42MDoJRoGACXc3l5a4dNYa+IT5eODFY/7FPS/PgdLtoEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485129; c=relaxed/simple;
	bh=fihaNEvBsUOHv/rajYVxMKB3dacL3pnz1EOCGPpcawA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KoocmWIErv6wGYkrF9D2/Y/0GRGPkYGsVNe0PZ7C26WaVnriyzFBKNgsOPsi9Q5hlYkR+AUgZDGLT2uqsl+4s8qABZ1gr9kyn4RfJSS69SyxfMteDpAUQPz1PdtqSOxD4VCvck28r9qsk76AzsgI7VD2oVmZlPnw8K+uic4j0fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=jb+9qKNw; arc=fail smtp.client-ip=52.101.195.77
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJggK3FN16A9wdp5i9thhFePpwJH2Hu6tFLzvO4RRMpg29Lq8cgOr964iQK53OHEYrA0Zj9HKmcJJSfeyrrSBvr5CuGGvR+XIlzcdaZp8hpT+Y3zdThmH2hf559/u1/lVnvIPkBwm75fBWeKkLx5mTdVwzpFEZcSAvrAuVrZvnI5foBEoX0fT7N5OnEZ0s6BqXXbB/H2+egoR962wvtx04GTtyq1R2EOy1WCu7LmnCvdNozakO7FbCqkp4C5r4jWj74bWwLOluo2anmGnpNN4yj8XQWIcSy39xyEyNTMhmRjAwBewEazwn2KoD0vh8UoV7J0/qmwMUNaGZfe8ZULlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8bLK5UA8+n0FfxqSaZGj8XCfzPJEMK5kNCq/p82M5g=;
 b=NG7TsgKqx4lI4cPskYlLhr+WsuJExVRV7SPmpOY9gUjSYvqelwxWcoDAFQxuF/vVIkiTotZVLh7lH66JzoU1PhiFeCpfw+XWVHuFfSI/OLsrcjoJO4jpDO3gAVOTuhCHmtH4yIZB/XhbzmNFew8nRbb7GBKIRrpU/1bv/FhPlc4CKR3Q48LyJB8SyyBJD2TgEASQXmh929S8F/gVfcQJnMXNaTyNnp14egeP/FKNa4To2PWOJfw3hvxYUh3HSbZtKsrpMtuS/+j3FhtjD7bBCh9EmOW5Ucvj8zSyW5jQ6axZQXvuqvFitlchjB7bkmBxJ8t8Fu/TI3QFQb0QJNLVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8bLK5UA8+n0FfxqSaZGj8XCfzPJEMK5kNCq/p82M5g=;
 b=jb+9qKNwgmMVUt/+Cq0klPPfOjgZiZmkYA+jW8Tbjja7V+bEb2GCZ99iElxthG7v5ek36MjJoFyoI1+6GjJiJptlFgvIr8/BjIVu7xPJviDLuWr3ZFI1wU/0BhPC1PRU20vm2wQaXVnNueXUMo8lAQ+zKN+sYrC6xwnVsggNzR8=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:21 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:21 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:12 +0100
Subject: [PATCH v5 08/20] rust: pci: io: make `ConfigSpace` a view
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-8-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=5908;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=fihaNEvBsUOHv/rajYVxMKB3dacL3pnz1EOCGPpcawA=;
 b=4U6K2y3yHbcoEIoFOF6udWUNobuNqxq52fbS7cTBGbtUCowk9rqxCE0Aw9pGmF8mMtIXGzigr
 ORyQkNAR2ZJAqF1U2OWYzhwidU9m0TRGUyRfYJwIj/YrC2u1Nwct4OO
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2694:EE_
X-MS-Office365-Filtering-Correlation-Id: 7236f7cc-e036-4b61-123a-08ded3918c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|3023799007|18002099003|5023799004|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	+1k87Rxba5G8D1ovsAcx51quZ5ub6qssO/qCf40xkH9mA5RyeO2+vQE2Dt93q0UaNbIxJ+BlsbJKSSoPUmlQmbgPXDYJf3WpSGE4l50EykS6sBfCPeEkne1NvPwmVd/6ku7KGO16Y2u1V/rsc+seukoKIoDADc97mwg9bGCFtG8F7WSL0DPXH+YkOAKtQ9iw5zDvLzcnWxHjwXuR+Dk9UbO46yvYbPwJRNRfVNIWf6az06a+98iQSy5XDMxNts6yPaeW79A3pUAh3+5s7M0EGEwtyqjd4mHftkQATRwfkVUquCUImb5Vn6SHhWCJf5ilIoqHUFSTNSMc39+buT57kLBHZjnv4LOYcnWihlTaatZY8SGWNJl1X2Pz1Q/iMZ3fjpZZ5er64CMgVeh0X0IpTsxdhRlAyOs3JmYYoa7Nm1hDTEWeUEGtwOMzb2qi7vXEbzvBXC84xS8vMJ4wmKSup37ndKY9efOyewPeH8/S1dqajeSvxtoiLIpKL8DhEvg44a9cbqmH+TtB8ycJNSM0lSLVlEeoddFqT4XOhWoVK3QUnCevPDqmMnuzyFgwB18LumkDnlMtnUF/32iyvEf1+y+bpNdCvMeaBpUuzoVsBinpLrLN6fxUx1QhuoKOIZRJeMuGbbL0EG85KPqQ7/ntaVTXUMONkg8O9X4Vq236M0Pt3+A3I3Jb+jWFV8MeAoQgIUP/NNgDV6KYLMVAmb7V3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(3023799007)(18002099003)(5023799004)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkYvemZ0MXpkQnBqMGdvb1NrMjRGVEpHV3I0VTd3QUpnaEFrSWZQN3I0Yk4x?=
 =?utf-8?B?cGFDMFN1QWxvVVJJcUViVUY0M0tyeEVMNDNhd2I2V2VVd3ErbXRTSks0VDg5?=
 =?utf-8?B?Zms2TjVzTlpIVVUxYkVrUmxub0tCZTRTajBPdGtXamc5UytVaGtYS0toQUxN?=
 =?utf-8?B?OHRGcm9QdUdOb1RJYUZZRjg3a0tTK01vaHhWdGVTaEhhNnJ5dDFCMmhQNmcw?=
 =?utf-8?B?TUQ1Ump2UFZMZVE2dTA2MFUxZmVISkdkaFp0QU82WlJhMWpNK3JKdlg5MmZS?=
 =?utf-8?B?UFluUEZ6Q0p6ajlQak53ay9yL0JHKzlWb08xWUdSWXh0VTdDcG1raktTSmxo?=
 =?utf-8?B?T05Vem4xU2hQc3pKTU1KUk9kUWpnYUdUTytUTSs5czZmTjlIRk9jS1B1dDhR?=
 =?utf-8?B?cUpRUDJycXNvd2F0RUhMNHlsWjJpWUVJaW5oaEpzcC9pUDUvaDBHU1J0ZHlj?=
 =?utf-8?B?b0RDTXdPUExCb283NXkzRDcxQjF5S0lJemhjbGNkWU16dklhSkVIOTNJOG5h?=
 =?utf-8?B?TmxQZFlIYTYyU1dlR1VsNGViYUo1Qko2RXdCUmx3TitTaUpxNi8vdjVTcWMv?=
 =?utf-8?B?WDNxdVlkS2l3NjYxNkV5OXlXS3U3N0s5UkEvOXFyZkxVMmJMajlhNnl5NWNV?=
 =?utf-8?B?eFFGN0Q5aGpDNEd3ZGkwU2hkamU2NStRMERydlVZKzFNdnpRdDc2VEhKZmhp?=
 =?utf-8?B?dnpkb0JSNUFlc29vN0Z4Z1AyMVJPYzRTbUNPdjhMNzdhNlhpTWJveDU0L0pq?=
 =?utf-8?B?RzBrMXo3aDltbEVCUUx2NW5UcTIrMVhXQkp2TWMxL1VMaVYxK2hUd2hyYVFM?=
 =?utf-8?B?am1nRndaaDdGR09xQjF0WE9qMll5VWY0TlhZWHM0Z2lpM01wdkxkc3RCaUh4?=
 =?utf-8?B?Y1MyU0FiSVlFTmQ3RXdqTjF2NWtNcUpuV1Q3elBwanRNZXI2ZXF3WUw5aW1u?=
 =?utf-8?B?bjhMVGF3bldXSDZZaGlHZUo0V1RiNm83WnRpZU5hdmdZWWM1T0RQSG0veEdY?=
 =?utf-8?B?V09JQmxoNGcyL3J6bVFNVmxmYnEwQjA5aWc2T25iZnNKZlhuaENpTTdCbW94?=
 =?utf-8?B?UDlISWVOVFNZL2dWT2I0SDFpN2NaWU9BTDYwMXA1Yi9oL1BnY0l5dWlYOTh1?=
 =?utf-8?B?RVppZFg1Q2Z3Ull6M2UxaVhpYjd5QzYyQ0ZMNXZCMTh3M3JNeUdPSmZYSi9q?=
 =?utf-8?B?R0xIaHE1NGJCeXJUQzB1bWNXZ3YwdExJc0p1NitGcThHTkYrZ0pMdzZvZTBX?=
 =?utf-8?B?enNXelAyR1hFcnljNTUvVHhkb0ZHaytRS3FIZ1FtRVp2dnRKUTJ3c09MRFg4?=
 =?utf-8?B?YVEzUTJxa2xPWWJXdkFMUzJ3QVU4bDAyTC8xeFpxbXdCVlhleDM4a0ZUNjhz?=
 =?utf-8?B?MWpTeUFXNW0zVndYTjhDYS9DTlh3ZXBtVXRtbGxpclRCKzBZejFWQmUzbWxn?=
 =?utf-8?B?UW8zYkVIQ1QwTmdaM09vdG9CaExNWHVlTkhOcDhQOWpjMmFOZ1R6eFlqNzB1?=
 =?utf-8?B?K2NXQVpGOC9VRVZpanNhSnU4SlFjYXovcFRrV2xjVkQxczM2TVFieSs0ZG5J?=
 =?utf-8?B?TTNrejJVVjBRL1EzbW1TN1NnbXVzQnlmWWdXTC8vaDZXUWJoczVEMmZoWFNl?=
 =?utf-8?B?ekVqQzlnckVHZzNYZTlIaW5FY0VYVU42ck5MK0s3Z09yRUhTblJjU2NlVGtw?=
 =?utf-8?B?SXN2djlWRjlxUEFqeUtXd1JSdDVpOU9YVGxRNlJEa1o5c0NlV2labjBqS29K?=
 =?utf-8?B?aDdFYzNVaitBNU15ODlleEpFcVhWQUZONXJxdFZkbno5d1lmWWFIeDNhRFla?=
 =?utf-8?B?OWc4czk1dXV4TUJvQ2Q3V2lvejBGK08zWFFxZlkzUUVKV1BPZmM0YVEyVlFB?=
 =?utf-8?B?L0oxU0xBV0g2Q2FvL3ZjcGZzcHA4QWl6L3RGV1hoQVdXQVFDR2cwUlRsTXlQ?=
 =?utf-8?B?akovdWFycU9OQWMzdXJFWTAyc0tjaWdDTU9nbkJKRkhrVWtsTER0OXFTZStw?=
 =?utf-8?B?d3BQOGlmZFZjTTRMajU2T0xMQ1FNbkRpOCs5SDVEYUdPdW1ybVR3RC9CZzJa?=
 =?utf-8?B?Zm5UVmpWOXNvamxuRVBLRDhxOUFBajc3aGVnQkFBV2FmYzFSZCs0NnZacmpT?=
 =?utf-8?B?czh1MDdaUHUrcm5FMjc0NHAzd0FxMjVXQXlTQm9Zcmp5SmtwYUJwNG43ckNj?=
 =?utf-8?B?SitUdVh3WEo2dU40bC8rOE5USldwMnJsMDBYdTlYc3ZhNHlZcVFFZmpZMDll?=
 =?utf-8?B?TFhWOUNzeXR4cUozTUdERTV5YTEvTDE2L0x0QUJLQ1pmcTFxQ01tN2tINWJO?=
 =?utf-8?B?NERFemJydWYrVmhJZ3RrUGFKVHhtcVVlNTc5T2dkUnpLWWFMdjVyZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7236f7cc-e036-4b61-123a-08ded3918c55
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:21.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhcfCU+U8O0F7IpSp1Skvw9vWdSn1tJmNwgqIE1Yvnm3T8VLdsBsaS4ymDfn97NkUd/5Rvgeyx7ydi+6vQQcUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2694
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9404-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26B926CE11C

In order to support I/O projection, we are splitting I/O types into two
categories: owned objects and views. Owned objects have a specific type
that is related to setting up and tearing down, while views can have their
type changed with I/O projection.

Things like `IoMem` or `Bar` are owned objects, which requires setting up
mapping and cleaning up on drop. On the other side, `ConfigSpace` is really
just a view, as the resource is associated with the `pci::Device`.

Remove the `ConfigSpaceKind` bound on `ConfigSpace` and make it a generic
view. This means that `ConfigSpace` object now represents a subregion and
therefore encodes offset (as address of pointers) and size (as metadata of
pointers) itself. The full region case is still supported with offset 0 and
size of `cfg_size`.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/pci/io.rs | 64 +++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e0acb62f58a2..89f4bb483a7f 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -18,7 +18,6 @@
     ptr::KnownSize, //
 };
 use core::{
-    marker::PhantomData,
     ops::Deref, //
 };
 
@@ -53,33 +52,42 @@ pub const fn into_raw(self) -> usize {
 /// Alias for extended (4096-byte) PCIe configuration space.
 pub type Extended = Region<4096>;
 
-/// Trait for PCI configuration space size markers.
-///
-/// This trait is implemented by [`Normal`] and [`Extended`] to provide
-/// compile-time knowledge of the configuration space size.
-pub trait ConfigSpaceKind: KnownSize {}
-
-impl ConfigSpaceKind for Normal {}
-
-impl ConfigSpaceKind for Extended {}
-
-/// The PCI configuration space of a device.
+/// A view of PCI configuration space of a device.
 ///
 /// Provides typed read and write accessors for configuration registers
 /// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
 ///
-/// The generic parameter `S` indicates the maximum size of the configuration space.
-/// Use [`Normal`] for 256-byte legacy configuration space or [`Extended`] for
-/// 4096-byte PCIe extended configuration space (default).
-pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind = Extended> {
+/// The generic parameter `T` is the type of the view. The full configuration space is also a
+/// special type of view; in such cases, `T` can be [`Normal`] for 256-byte legacy configuration
+/// space or [`Extended`] for 4096-byte PCIe extended configuration space (default).
+///
+/// # Invariants
+///
+/// `ptr` is aligned and range `ptr..ptr + KnownSize::size(ptr)` is within
+/// `0..pdev.cfg_size().into_raw()`.
+pub struct ConfigSpace<'a, T: ?Sized = Extended> {
     pub(crate) pdev: &'a Device<device::Bound>,
-    _marker: PhantomData<S>,
+    ptr: *mut T,
 }
 
+impl<T: ?Sized> Copy for ConfigSpace<'_, T> {}
+impl<T: ?Sized> Clone for ConfigSpace<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+// SAFETY: `ConfigSpace<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Send for ConfigSpace<'_, T> {}
+
+// SAFETY: `ConfigSpace<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Sync for ConfigSpace<'_, T> {}
+
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for &ConfigSpace<'a, S> {
+        impl<'a, T: ?Sized> IoCapable<$ty> for ConfigSpace<'a, T> {
             unsafe fn io_read(self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
@@ -112,19 +120,17 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ?Sized + ConfigSpaceKind> Io for &ConfigSpace<'a, S> {
-    type Target = S;
+impl<'a, T: ?Sized + KnownSize> Io for ConfigSpace<'a, T> {
+    type Target = T;
 
-    /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
     fn addr(self) -> usize {
-        0
+        self.ptr.addr()
     }
 
-    /// Returns the maximum size of the configuration space.
     #[inline]
     fn maxsize(self) -> usize {
-        self.pdev.cfg_size().into_raw()
+        KnownSize::size(self.ptr)
     }
 }
 
@@ -281,23 +287,25 @@ pub fn cfg_size(&self) -> ConfigSpaceSize {
         }
     }
 
-    /// Return an initialized normal (256-byte) config space object.
+    /// Return a view of the normal (256-byte) config space.
     pub fn config_space<'a>(&'a self) -> ConfigSpace<'a, Normal> {
+        // INVARIANT: null is aligned and the range is within config space.
         ConfigSpace {
             pdev: self,
-            _marker: PhantomData,
+            ptr: Normal::ptr_from_raw_parts_mut(core::ptr::null_mut(), self.cfg_size().into_raw()),
         }
     }
 
-    /// Return an initialized extended (4096-byte) config space object.
+    /// Return a view of the extended (4096-byte) config space.
     pub fn config_space_extended<'a>(&'a self) -> Result<ConfigSpace<'a, Extended>> {
         if self.cfg_size() != ConfigSpaceSize::Extended {
             return Err(EINVAL);
         }
 
+        // INVARIANT: null is aligned and we just checked the `cfg_size`.
         Ok(ConfigSpace {
             pdev: self,
-            _marker: PhantomData,
+            ptr: Extended::ptr_from_raw_parts_mut(core::ptr::null_mut(), 4096),
         })
     }
 }

-- 
2.54.0


