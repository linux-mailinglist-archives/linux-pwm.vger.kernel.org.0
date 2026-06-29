Return-Path: <linux-pwm+bounces-9472-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /d9SLL5uQmo47AkAu9opvQ
	(envelope-from <linux-pwm+bounces-9472-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:10:22 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BB96DAD68
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:10:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=vmkguXTN;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9472-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9472-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B80E5335415D
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A3540BCC8;
	Mon, 29 Jun 2026 12:40:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A940B6D4;
	Mon, 29 Jun 2026 12:39:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736801; cv=fail; b=f72mYcR7CaC64lNZJhYlBWGUSlNY8a3DDBMKL+ODY9GV90t9DWpQ9u4IwyaukjmWs0B2GT32l2Uz6wz5nrktS2RULphq+oaP/6E5/w5cT2Q2OI67IvgK3N3liXfqfzXyV4v1o2QZavoc8A9GxPMISJnE6hQkt2bfmM9OYs8dNBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736801; c=relaxed/simple;
	bh=FFnhY5S/CcGx97UsN+mEajk54LmAv3/hX/lIKREJW0g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PpicyGuqZUvEmvxHBwNJyjMmyWJ/79GT1BCMSSqAarWmjpWFGzOhUsrHV1F74xXxIjO61zw/2cGXD+0cNqvjrU3i/nmZqPt0Sb/gmVsdzmUrkOtXFBtnKaLuPCYk1Qvb7mBfhXWHrboNZnIxnDqXm1GFUcZF/j0JpAVKUqRoLyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vmkguXTN; arc=fail smtp.client-ip=52.101.196.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jY08RRMmlqTRu+CtEbzSBPjviJx9JhsMqXmOYMr3RngIS3F6r0ZNWb9l/or61KoFNX+ECfNAus90UsGRzEwGoTPHI1GJndfA1VU+0QzUarRMUHdDDnHEBaa6Xl6XUhHojearuN68ZcmUfingpmTIZcpPSodyLHbsumEr8Ln2jz42oYeW9SMCeYAVHc5b8XQPsJW7Kd0OSSJDMZqq7enWh/y4laAO8Cc4WlBI/fCqnNPHpi1Az5ktg8oGxfa6V0GhfxhRom7rCTrwxlHAsDu9/G6tEWEPI2Ij+0fAnAk8/7aKH78F2xtinAwUmaJ37wWqz3hwV64LSRocShfrRyzaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4DMXcK0n/G7re1MylOgaBrt09Wk4VRH7+JBOMcPHxo=;
 b=SDg6nEtaqHPZ9F5rs2YMQRIS8czNCLxauPQSGn+d/nBCN87XuQcgMQm/4zAxMTXwuzq4UDiXJyVNpPH1q9pWpKfg8VzaBrQ5C6Y7zXleKWJfFadqUtK9UFstOxL7+AGzUc3ShpEp3icKzwZyRM6h0Fu3+yigMKyrDH59fSjc+gX2zFND5O8j3wgJWTOztDPG1Rg0rhfx/eFsWUFD8G6YJlANZhLQvOUJuESDcjEfbvESv5BQdVfKfRcO2hh5o/dMBDfUwNjMGhCMqLi8T357zzt571+4LaJTEKcFGVMNy6HdBGMv0vqe99TtuZWfciL8jKBNyM6yc7zL04wGxlO/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4DMXcK0n/G7re1MylOgaBrt09Wk4VRH7+JBOMcPHxo=;
 b=vmkguXTN5RgWzf1TCWXokFRRBZhoO+bTFhPYcQv93S1xHpE9+0sw9Hu2iCisjNBtCm4ZiUZ7Pzh6QhhkSK17emRrzdflc6JPrL7dPbeRlsCxtkhbSGYDURTcc7Z/e1Ol65jkvz7IcwPCWm2Orqt4qNe31u/NQsSLUMFESAF2aao=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2670.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Mon, 29 Jun
 2026 12:39:48 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:48 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 29 Jun 2026 13:39:45 +0100
Subject: [PATCH v2 11/11] RFC: rust: driver: support map-like syntax for ID
 table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-id_info-v2-11-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
In-Reply-To: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
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
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736778; l=1761;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=FFnhY5S/CcGx97UsN+mEajk54LmAv3/hX/lIKREJW0g=;
 b=hmERbGq5QGhZ7/3eJMR9qp+56io6OS5xQOVTErPcs49pIpAhEhpjkHEPFJR4UWUJd1kOEyQDI
 mxPq/YlaGxtDjvEMwYVB9nSmPmFdwWjwmYPPiBHfDo+ThZZfwygMQAW
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2670:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7c6b5a-0438-4b4d-0f83-08ded5db8183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10070799003|22082099003|18002099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	H9q5QbXrex0v7pHK07r7ZE1m+6HG5StiL8znbANTOx73MLf5PzQGOkjbP/BEq4JgowFFma4o4Fezvz+/6U4haISSkQz+HWwHA4u6GEpMCUbyVEVsuumSjNlKVZloPr96AYJ5bSviHTP6JrrRii4phrNghSdmZJK3eA/wj5m8vqHiOR5RW1uZftDrqdCsQAZPGBasMtvOT5NHN2sOu0lKjbAKs0G6orhn3eHNuLt+YX+gi7wF4USI/jyF0uGsIHi8NYn53nPOxXp4INnpBQnlT4p/p0JXmzHrlwUCvHaiMQOiiuwksB6GktiGUPGBClz8Za20KzXFMi+6boh0aYZgd8ahF4faimCe1oXzBIaVo7h+wlD0swccnFzlcT2pP+R1o3IQOPUYsgVvhIDaX4iBS4lxUTkL/1x7eihtklbQ5m7WLCwHz4sPRuIJHhrouvSi4X2u2ASX0W2gR8V2WQE1SN+d411p3ArhVsINvG+w0eK/Z6saEW+AGUbGygggXyxpd7Cp6wXXCY8eIlDdJwIz5W6jXH1mju8IAcLURj8URfkTNVUjL/49AcoBVAE8IN4O5rSi76iZx1AeVX7DqzygRr1qYXefn9uvDGmEglBaUJRZih+BUjBSCrJXqHvkfR5KjIo7Jba+L8bwVDAr/WXuqUz0z17fS49ypGcXHPa0jYUC5qS8NaODWlK2A3KuG4EFgoD0g4UlLDJnRFQgmAAhmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10070799003)(22082099003)(18002099003)(921020)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm1kWEx2b1hvb3RsYUYvTGRRbm9qN3AwNUlUY1BpWTI5MDlqcVA4WkFFOWxh?=
 =?utf-8?B?RUlNZ3VidG9PRC96NFl2NWNWUXBjaGV4U3hGcmxKazFEUVhOUlZBTk9HOTlj?=
 =?utf-8?B?dXk4TkE3dWZvRm16SjN4WkFGWmxnSVZRdXZGUkt5aDY4c3o1cTdMOG4zR1Vs?=
 =?utf-8?B?Rmw0L2tBK3RLMGlMd2RvRVNpRG1MdUY3Wk4ySGdPRlNKSFlETUlFVEcycERN?=
 =?utf-8?B?U0pCdi9aM0kycks1aVFSRXRSWGNFQ3VBSDJzRnk3OVZlenBMdEZNSkU0THhP?=
 =?utf-8?B?RFVqVzlBZXFNQmUvbEQrUGd3U1Vuc055OTJSR2E0Q250UWluVnExcUw5UkRC?=
 =?utf-8?B?WFNpQ1JuZmNuNnJjMkUrZ1ZkMUdoMkJjTkNvcVFNNlB0bWFpeS80cEM5UDho?=
 =?utf-8?B?OEZUREFPQW00MU4wUEhjVDY0eC9jMVdydEJ4UWVyMGN4b1FIZUcrQi8rSTQw?=
 =?utf-8?B?cVlPb1VhNU9XY2RYMjVqNEpaNW4zanNzUEJtT1JVaDZVQWV0Rm5hUkg4RmV1?=
 =?utf-8?B?L01XU1hQU2dOQ2tvbDFzZi9VczB4M21wUjV6K2JjY0FTV3dTTXZ0MEVjcFZG?=
 =?utf-8?B?VnRLQWhPR2s0MnUwSi9EdG40SksyRXp3clJpSkVUWWdEeERrQ3NpemQ5Mnh2?=
 =?utf-8?B?RWZwQVBITmM2a0VHU3JNb1lhQUp2SFVUMXpYZDBWdHJ0elhEeFNOZzFDQWd4?=
 =?utf-8?B?VTFQODFVUE01eXFBbGpkK3ZKaW9pbHg4c1FoQTRla2lZbVJyb1dHM2pUYmpN?=
 =?utf-8?B?SlU3RHE3SVpYRjRBdzcxWkFLdHpPYndqd2NTbGZBU2VyZUxrRlZGOGVzRWFt?=
 =?utf-8?B?NkNBbUVMZ0VreDhGSTQyUk5tUnBOQlJ1UysveFdHVFFsOHBwcmh3dEg4OGQy?=
 =?utf-8?B?aXc3MWNsdXc4RWhLQ2JsKy90Mzl0TDdFNTk5dzd1VjhkQTdJTVUreEZ0MUFT?=
 =?utf-8?B?L0RFczlnZTJXTmV1ZXBXVXZ5ZDdSU1lnV3pvMVdIaDhIaHB6RUpmU1hxNjhM?=
 =?utf-8?B?VWh1Z0VVdm5KUXpSTVc5YkZmTC91U1V5LzJFdnl5Tm1lcHVXWlcwMzRmajN3?=
 =?utf-8?B?VUUweXlHZTRXK0ZuSEs4ZUVieUp6UFB3QTVaTFpuZWNicGtPNnBJeVU1YUhm?=
 =?utf-8?B?QXZFeDNSYWJ5VTJZTElpcFhUWFFWYitqRGh0R3hzbFNpY09YbmVlVmt2MFNr?=
 =?utf-8?B?bGdGV0t5TU54cFhZQTBPdDdtMjFya1ppa0JUaHdGRXAza3hnVHlNVlJqbHk2?=
 =?utf-8?B?Sm51MkNCSEpCK3JoTWdiVUdNaFZiWmwvTG9TS0VoRk9WSTI1QmtpUDFQMHlN?=
 =?utf-8?B?bFloL2FRdDVmRDJWS0YwQXlsTC9WT0V6dU1IdmwzNUxaKzd3cXdlQ1pVTTZr?=
 =?utf-8?B?Zk9kamxiS0x1R1pUSlVkSm5JMEdBY3ZrQW00OERQdTVkcGQ0SStNWXFuZ1Ji?=
 =?utf-8?B?bkQ5RXVQVDFsM1cyUGZ2UkprMVFUc0dDY2NQelN1NUtuQ2VFc3lXbG1uajI4?=
 =?utf-8?B?VzVUdDY4MFJUdUZtRmFOOVk1bzRhSXI0S3ZkNjNaU3poSFF2OTZrUmtJSUFE?=
 =?utf-8?B?Vk1sMjhIVFJ5YWE3NE1GTGI4dUNadVUwa1N5OEgxZEF2SndiTVM4NkdDdTFZ?=
 =?utf-8?B?Y3FtbElhdXYyYm12cFlPSUdDcHhsYWhWekwxdXBxZFNZd2NrcEFwQ0RZV2pJ?=
 =?utf-8?B?ZVZvMDRrcjY4RkFXai91S1dJYnVNWm82cUJKejNWV2RKQVp4ZEJCeHpFRkxQ?=
 =?utf-8?B?TWVUbnZEV3I1TksybUlDZEdUU2tqZjlUYWFpbkQvQzhIM2ZwN3ZMWjAxZ01P?=
 =?utf-8?B?YkVQZmpHRzFHWmkrKzJFa1B4MDE5bzZ3U003enFhM2Ftc3VrK2NGVUN6NjVJ?=
 =?utf-8?B?cm9EMWptcnZNVWdWTDBsdkpFLytuTFlWMnc5bW5xZk8vdVczL3hyYzhiWkJQ?=
 =?utf-8?B?SU9pZDF3ZEozenNsUTdiVCtOTjBCODMxK1VmMDFvRGhxYU84MXBiQklTTHZR?=
 =?utf-8?B?djFpMnFEaU9FMDhROUVvcHd5R0R1TmtYTlZ4R0xuOHhBTnQ4Mnh6Qms5R0JB?=
 =?utf-8?B?ZFp2Qkl0VFNHYVk5cFN4WjZ4bjF6b2M3a1VTSXc0dFp0bDdFK3JTaDBySHVy?=
 =?utf-8?B?NTBZSDlJNGZjUTA3a1ZzaXliNEl6bFVLNmFwd3hBYm1OSlEydUtsMjFETkZH?=
 =?utf-8?B?YzdoOTh4dVlleXBNemRCbG91TjM2bzcvczhQc2tOL2JaaEl2c0sxaFdMSll4?=
 =?utf-8?B?bW53V3hLMkZJV2xHb01ueTU5ZmhKMU56SGUyTFRNOE1FMEhYajB5MnF3NzQ3?=
 =?utf-8?B?MTIvcmFvcWpZL3hIV1B1VzhqWEd0RTI5NmNTa2RlSmQxenExUFF4UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7c6b5a-0438-4b4d-0f83-08ded5db8183
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:39:48.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eh4QiKkc6RenpA9f2m7zPXPacVHA3KmrI/jtpTWwD5dfN+GY7VaABuRtkVmAHXmGW9pyTpQAtArX83Eza52qKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2670
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9472-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,gmail.com,ffwll.ch,arm.com,intel.com,linux.dev,linaro.org,samsung.com,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fujita.tomonori@gmail.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:david.m.ertman@intel.com,m:iweiny@kernel.org,m:leon@kernel.org,m:lenb@kernel.org,m:igor.korotin@linux.dev,m:robh@kernel.org,m:saravanak@kernel.org,m:viresh.kumar@linaro.org,m:m.wilczynski@samsung.com,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pci@vger.kernel.org,m:lin
 ux-acpi@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:linux-usb@vger.kernel.org,m:gary@garyguo.net,m:fujitatomonori@gmail.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54BB96DAD68

The device ID table and its associated info is really just a map. Add a
syntax to `module_device_table` macro that reflects that.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/device_id.rs        | 11 +++++++++++
 samples/rust/rust_driver_pci.rs |  7 +++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index c81fca5b4986..5f4d191fce51 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -183,6 +183,17 @@ macro_rules! module_device_table {
         $table_type: literal, $device_id_ty: ty,
         $table_name: ident, $id_info_type: ty,
         [$(($id: expr, $info:expr $(,)?)),* $(,)?]
+    ) => {
+        $crate::module_device_table!(
+            $table_type, $device_id_ty, $table_name, $id_info_type,
+            {$($id=>$info,)*}
+        );
+    };
+
+    (
+        $table_type: literal, $device_id_ty: ty,
+        $table_name: ident, $id_info_type: ty,
+        {$($id: expr => $info:expr),* $(,)?}
     ) => {
         #[export_name =
             concat!("__mod_device_table__", ::core::line!(),
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 2282191e6292..652819dff082 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -75,10 +75,9 @@ struct SampleDriverData<'bound> {
 kernel::pci_device_table!(
     PCI_TABLE,
     <SampleDriver as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
-        TestIndex::NO_EVENTFD
-    )]
+    {
+        pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5) => TestIndex::NO_EVENTFD,
+    }
 );
 
 impl SampleDriverData<'_> {

-- 
2.54.0


