Return-Path: <linux-pwm+bounces-9416-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /WfPNOyRPmrNIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9416-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:51:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D8D6CE247
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:51:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=MgNYw0Zm;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9416-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9416-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1FDD30F168A
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FB53FDBF8;
	Fri, 26 Jun 2026 14:45:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020079.outbound.protection.outlook.com [52.101.196.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839553FB7F1;
	Fri, 26 Jun 2026 14:45:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485148; cv=fail; b=M6D5+mV8tuqGSTDKxZb5X2cGcu3CED/AUd2NEiApnlhe/BpbpBoFvnm5juF9uUtA5itWXZnbZX+0Hvq9QcGjBBo+nxeduDsKNulIHFECDkbHBJNdRLoQrQefY0hhnCa95oG1ivl2eI7F2HJx4ewFm1PZHn8Gn+90P2TTnFD0aaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485148; c=relaxed/simple;
	bh=N67eh/4rU5E8dRAmgsMaWwryS/NjkdV2W/BN7X/Q9po=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X+tYoHNtai9eEUivti2dFX2hhKMyE3mAmt3AoFOVXSV66t0E4XOScjlpcJNeB//KWjtd7ovl2UCKF3J+pHwShb/soMBsERRDm9LiqxoXv9d5woHuZ2YUaJAYBdaRjG1dsl9tAWwTTYYZCH4RnixcfFtdnakMjUTdmM1T1dTsN/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=MgNYw0Zm; arc=fail smtp.client-ip=52.101.196.79
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TffBC+J71xvAYY8OxFzqphh5ew7nYzNKXHaK3XJZg5iDOVVQRCiUbGMBx1WF2snS7zdy+9ycHyjJXfqSsGN4so/O7xQRFmqppapUfoi9kXjXKsM3AFq0ggFIxw0FPgErx2DzKFLd1e6/IxhmwRoogpWmqEnO5BtyqCQ2gTKgxc7VnMiWQmz53KwfEmUVdwG/DbOq5QW7hxRwFVvz2arzRoaI48Rt8r2LUY/Gy0s4V/cknvSkODsiZNnZQCp5y4rVjsz+YIftjScJBpWeXUXzN/iO9Iy6jGGUeZhlBi4yEM2bGrKvB5/ALzMbIVm4sImQySSLFgGaSOAKriQXJqFpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tG50iuVdI4iSFg2IPsrWpQQ104uvAcox4v6GMExQ3A=;
 b=dkuDOIaULnRnb6Q7oMFn2yB8fZe/WiMF0QpkIS6e7wJFaQOmj2lpslLz+/rOh+EgrrNu3dYMkUcfjO6QpNh2WyMmEdJTi1rcVW0MY0wSFrdGBHAQAklxjyp+LEb8NU9GHo3Mnq0S3/eSvH2kmykoW48K+boJLJtYeQLOqiTHCaV255keteTHeY3avrF1+hIbOXMxyzFRIa+0AiFd8P/L3o4StbvBziMPmhWAPLHp3Tmy4FTzDl4bVEpXOx30QzWxG35iaD2laUEN4Fe9ueJ+ORrXK6cFKtO957dG9LSjp81UpET0vzJBw6yxok13XrvWo/ktB6eHH3fHIieXx4SrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tG50iuVdI4iSFg2IPsrWpQQ104uvAcox4v6GMExQ3A=;
 b=MgNYw0ZmqwQt0fBoO3n7TLLuxkvcHd8OCTJkg1TzjCs7JmhEE9czkspFn3edcw+j9gYIngy5yhc2kwgxQxFrwY88ZHwtDuoEzQ7dts1xPl8ftTLPYO3QFRGv6PTkWHv+3eBmjot2ksv+ZX2JcjQcGw6TpwmeKJh/XPI/kXMstvY=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7248.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:20 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:20 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:10 +0100
Subject: [PATCH v5 06/20] rust: io: rename `Mmio` to `MmioOwned`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-6-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=16892;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=N67eh/4rU5E8dRAmgsMaWwryS/NjkdV2W/BN7X/Q9po=;
 b=MULx1Lc1qFdivmoTNx7Pz/YKQPzyH99Cyz4hjGWLbTfiymBBI7pWH+QS2WewCEmLyrK6If60J
 dzWlL7WiMIzDT+4v2Z4oFSEcSDHZ5YEgDSl9t/kzmVrCaURDgHbNu0D
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e9042d-d726-4ebb-d472-08ded3918bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|7416014|18002099003|22082099003|921020|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	/AqxJge9htNiB5z1yQV0U+IC7/BaxTKX3hIHfguxu4RD4MikiU/2QKzKdlARvaTJe7uRyIF7LwoT3sum4bIZ9EtF6Mxi7+xQiWSu1LkLdG+bPH6vSUh0AOaOeNUEAIx//gEXP3InM0UGgY06a+jRHgYiRW/wZ5BNGUHzErougpEVWrUAZgZ5xSbW0UsrLgi4RrDWVhqHZtoRNGglHPhT/l29XOWZStN54yctp62/0eA7/GiAB7+510kg4iroWKQ5mcPiepn942/Sd2UknWHhxnFddGnhNxCQcaBPGMlwFSuWXvR6QCNC+wPQbpberF3iFA3Vmi0oXO6KoxPvGnbb6TpxAW4MSSD21Z0BTomKJF66aciEefj+CqjHkgeaVPThI06U+8Rg73R/8D3JJWUEdlXzI4ZSFmjnucBEBuPJnYnmpiJcNwxMb7izjvk7wG2ATMJf/KixrjLO2m1VMCfZQlqYSfnT5sk0b1aALdQfxwV64DiJbI9KClTi7GOaJOf+qCsNaPy/3SEGxcAXlukc/FnHpgCPnFIz0or7bODvx2mz5WKLpxTDOM1mHtTAgAm9DskwY+b0Aqz1w22WPYp8fGp+rTMhKNTu1t8kZQwwOjunGGf1l0JmXpYD0UobOD5r6XvYs2LbUSRZEJW+uGPVZ0osl47y4MgHrfQPLoE7L91MQx523WnGL4/ULdTwO1PeQ/siUqzPdbRrloyneOsv8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(7416014)(18002099003)(22082099003)(921020)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmNyRmFhSHlscVdxbXh0N0RHNW53aEI5cDFpWTBwMHBTd3R5MndjL2Y5bUNw?=
 =?utf-8?B?dEJzVVFJZnZFQXBIK1hZODJ3ZmVFdWZzakp3N2twcVpyQmJUSUFRWEZVSmZj?=
 =?utf-8?B?UE1ERGl5a3FwaDErcXd3d0pNUUdGdGdVZ2pKS1ppVzZwcEFJcmZqalJOU1Y4?=
 =?utf-8?B?MzU5NU11UEpjVW40WGxDRU92T2ptenYyTERSRjZUTW1udCtEUVJWREVSekpS?=
 =?utf-8?B?UWFuNk5INVlhbVNwekRxYWhCdGtMejhkbXlGdkY0blg4VFZwZFpHNDNLYWpu?=
 =?utf-8?B?YUp0RjFja3FHUTZjRUxGakZRVmtiVTljVDBkUDI1UEJGcVJFK1l0YzZVYzha?=
 =?utf-8?B?cXNpaGZ5RFB3TDJRalplZ3RaaXNBR1pFdTFDN0tmVGxBQjNkTzJJSVZJd0lQ?=
 =?utf-8?B?ZWF6L2g5SThpVWtjT2dWSVB0QjBiQ1BhbEdrejdwbmZNVGhkVWR0UWYxdmJy?=
 =?utf-8?B?cDdxZHpMTjA3RHdnTmNUcGZrT1JYQzZFTy9jN1JLS3U0V0tDcXFtNDN1cU5p?=
 =?utf-8?B?TnJMT0pGRTBGV1VkSWpnZk5QSldtRUxyV0hSRTBjUk1TYlZWKzlQUHlKRkV6?=
 =?utf-8?B?cHA4OU9HR01vQTdQeW0xNTNhcWlSak1LNld0enNuL3pyK0JReldqUHlXaE5M?=
 =?utf-8?B?b1BLTVRJUmYzeFdWUEUvckVJalhRb1ZEeXFqWmpFeXBORjU1bFBqNDZBZkYx?=
 =?utf-8?B?c04yc3dwdzVQNU9sMTB6NWNmV1A2cDBsQmJBY0VkK2E1MW9ob2lyNStyYmE3?=
 =?utf-8?B?Zy9OeEFjNys0azhoRzcyejA5V0pLZ2E5WmhtMW92M2c5VnhOVnhrblljV2tk?=
 =?utf-8?B?U0xLMHJ2aFQ4M1FOZXJWdUk1ODlOZzJxRWNLbG9ucXhJL1l1ZjZpM1ptN01O?=
 =?utf-8?B?USt1SkI4VFJ0TnRiTkRlR3ZveEpROU1nMU0vUG1wK21iTHRKZEdnY21aSXoz?=
 =?utf-8?B?NGNidEFmT0xPS2RkalpuT3BaRUFXKzg0WFgra0t1V21scmp0OFFGbnk0Vjly?=
 =?utf-8?B?Q1hwVWN1R3pXS0drL3BYajIzK2tHdElRRXJzK0VQN0ZzVGlITkEzTnNuU1gv?=
 =?utf-8?B?WTVYeUJ2Z0NxY2tFdHlxaFU1S0N0VE9sYzRvYWtzNUMvNjdKTUJGUjEwcTQy?=
 =?utf-8?B?OWdpNS9qNkFDeGVMOVZUdUQvcnVDVmI3b08zdVM5WDVha2JzMjdXZnpudkpw?=
 =?utf-8?B?UFJiSmc2WFk3dktVS2RYb3MvNzVTUGNkN1NKdXpodHJ4SkJpL3hoaDBwMnNu?=
 =?utf-8?B?bnVrMmtSZ29yRThDa3NZS3hURkx2VXRITWZIb3JrSnNYTU16RGJDcno3TGp4?=
 =?utf-8?B?YjI0dG5VZjZoQnRJaVh5VlJqSWNIWDU1UC9ma3l5cnJmWUJpK1dqUlp5ZXly?=
 =?utf-8?B?MCtzTjQ2VTRMMS8yQTdWTG9UMzd5b3lrby9UTThrNFdzbVNIZG8xUFJrcldz?=
 =?utf-8?B?Vmo3MFh4NzEzMHljc2pHemU3eDJ0cVpuTHJEbVNYQ0U4dk1rTzJyTnNYcU1W?=
 =?utf-8?B?ZjRHZlRpazZrbFNSNG5BT3dRR2dnNm9wd1h3T3U4cDh0N0kwTVhxRjN5NWtE?=
 =?utf-8?B?enNkTFJYWVVtUllwcjF3NnFQb09UY1pyeXVKcEh1LzNhbENSTERYS1M5TE8w?=
 =?utf-8?B?a3FtLy9VMGhhTFV0SWJtTnM3Z1JkNUxDSVFhVnJmMTlONkVhN0h3WFBhc0tt?=
 =?utf-8?B?eitlaHd4aWhCZDBEN1cxVXNUN1M3SXk1ZFVMb01VVlBiWWV0UkVBcDFkamZU?=
 =?utf-8?B?cWIrbzA4UnRCdXk4VjgzTE1OYjVRNGhwc001U0h1RzcwZkdPYzFwNmc2bmFE?=
 =?utf-8?B?aWhCR2toeW9HMnpTRVZlQi9kUVVvV01Kc05yOEZvMjdHQ0Fjbk03QzlPNGg3?=
 =?utf-8?B?bFV1bDYvbTVxOTBJcUsyTEVjaytCdGJQQ0RQSWJIQWsvNVpCOHAzWk44V2Fo?=
 =?utf-8?B?RmtMSzVwZlUwbi9UUmtiWlpuWTJVQkdxL25DVFVnY00zQWYzckpSNjFPNW5q?=
 =?utf-8?B?eDdja3p4L1FlWVZhUncwUlpMVkhwRVF0YjVjY3cxR0IrSmMxT1ZnbmlxdEsw?=
 =?utf-8?B?dUtFRXY5ZkNZL0lSMWlZeDlCb3pRV1dzMUJtdURhbi9IU2VQcUdXenJidHhw?=
 =?utf-8?B?OUtOcnZCVmFPUTdlSjAzT3pwcmFlc3BtTnB1TVNPc0pXbkdVZkIySm1TYVRW?=
 =?utf-8?B?TEwrSklhVmFTSlBDWlp5eGZWbmszQld3R2c3eitSZ3dER1pqaGVXeEhhWnhZ?=
 =?utf-8?B?MHk4SkdJcTduVkpWV2JBNzhuT01uckxDRHFlTVFiNGowTVBrdGVkdnJkclM0?=
 =?utf-8?B?NFJiU0FsQmk1Tm9nZjZtTFhTOFQvZzJCZCtab0hkRGFCZDJyeVpEZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e9042d-d726-4ebb-d472-08ded3918bb3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:20.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vk37OaX8J/RaOAlTaWgK2UQj2VMoqwjjaW6R4r3SVLR8ZlarC/TTMs3wBeQmJgmKBUc31zMQDxuTmNBSqg1HuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7248
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9416-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43D8D6CE247

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
index 3122b17098ee..43284d9fba96 100644
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


