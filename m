Return-Path: <linux-pwm+bounces-9324-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZMrvD1knNGpGQAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9324-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:14:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B37D6A1DAE
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:14:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=Kl3DAGtS;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9324-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9324-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D33E3121D3E
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 17:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB6A34D4CE;
	Thu, 18 Jun 2026 17:04:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021095.outbound.protection.outlook.com [52.101.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5036734104B;
	Thu, 18 Jun 2026 17:04:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802296; cv=fail; b=XcHZ6q4wAAN2lwam26wNaTCIcEnxROs/4Yr/alM/a8p3rcRt9e+Eu37RXvb3nQvM5PYBdO6Qo6DUaKe9UsB1RwSUX1qY5c8wQPZUR/cTnSuroRyqSNizztXeeU8AH6QnSD7DJSYZkX/eB8VZOXf1DPe2OMU047sQB7oP/SXoOu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802296; c=relaxed/simple;
	bh=94x1O4HxKsoPKOLm7uWBT+HZHDbp/uUOwGwZO67jScE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MiKRyNJLQHaNGTyIkjUHtBFfEidrmzsJd1OnlwvMLvPnvY59CJl+0GhwSjFzGKd8wt0vobXiLqpMmAYeFNc6uTrthPFqqGjHWh/GPghz0j0ichQpzp+TCAD+RvNHcR41e/ePzLyAQH5+QX9/AtdCQ/65PetTQbOOkr0IdJ8P+4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Kl3DAGtS; arc=fail smtp.client-ip=52.101.100.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrEyi4IUzZu1CWi1xBn9YC3qxTXEG07ZnWCUCLTSboRrh4NlgC4HWMVwa7em6UGjdwmqFv7MdilIRzmHjIoOwGztrFR51zKEbufo2kryiugc5L6dvxg7syFT7e5/3BQ3gkudBviMq4j3Fi4aXJRnooWTFfYfNMmk+yoiiqoZe3ESpp3o4AX6MLDdNomuLL1IhzndT6hNxR2TRKPp2l6WOr7/PQ0fh07D+NMJUodW2qLBfuAgk30eS3hZppIORY4iYr7AZiEBL1lp3Tp5t63UfUdRDLKOD3Y/Xkj7zeTX7ySsFu4p0ap9fz+QPgYcY+lnt39YbLHnJ0/auy/6MjBiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6L0D4MRDsHLl3Ar1NZKYzJ4fW37yj3gVztpQIVKWOJk=;
 b=FcIqOZQtJUyDJiwFEVT9+MCQjS5g+x4jFVWEakA3LcumVxvtTpaRVW+ltYnb45vsete+cyvjW9Y1c9OQYjkH5w1gkcKhWL4RCxz5xDbQlARvbSAKVEIhKEDYnTxqFIphCjQONhK7r8u0XqtYQzyUUoosAUD9eLnJq5eymU2HW3SfcRkGCCFmA1h32p+zHkhu2CFViRdefF2TU5vgn+hOB9HdL7Z3bHK9sSlRBOp3W4sVtZcE+TZ0YTFnz+F0E91tRljweuSkzPVgWWb5oA9FYhy+9XpSiHymxkDK5YOEyLg+/lXP9Z/j6KW860IpRwJHIv6PASP/zdpcZc4McEdo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6L0D4MRDsHLl3Ar1NZKYzJ4fW37yj3gVztpQIVKWOJk=;
 b=Kl3DAGtSMPPwaUxcSCdwItQCMGNsgf+hDYyTuQqFnNWFWwOcieoea9TyxdP1dXOXeAOaJq+1z6Lgz+Qt/mpr3IscZIo07gALpb4P5X37j+IzWkDiWGKTVm/j5TrQC9zqK4Pp9O9h8m8VVMiB61XQjOWQEl8jFZUTooS3exLwheo=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6966.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:04:46 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:04:46 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 18 Jun 2026 18:03:41 +0100
Subject: [PATCH 04/10] rust: net/phy: remove expansion from doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-id_info-v1-4-96af1e559ef9@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781802282; l=2400;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=94x1O4HxKsoPKOLm7uWBT+HZHDbp/uUOwGwZO67jScE=;
 b=kFO0WCbCCxhQ5nfGokDJ5UGEyp9tpDRzOTJd5ADVaRSBeC3prZPcB99f+JfPP44dY6Bo4kraR
 +bdUz738cOHBIEiUZ85ecYIQ10j0OG3IaFqLrjRuZTs5LYvDE5Qi9G6
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
X-MS-Office365-Filtering-Correlation-Id: cc2a19d2-bdba-4989-644a-08decd5bb2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|7416014|921020|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kwt4SqLusHlJ11InK48Wurt5o6uAx++a9xzeVM1aaHjeIHnymszNSQ8s5QJCzS70cJUs2gSdYseLX2NqhydvU1M6ayCgJS3PaUmaqJxJQpBULdd4zzLS/Ouc42yUxxUHc2HCnx31ONj63kpOuVH4PEsEJWr83+sUdL80ExiOm2o8g+NFEutBfPZy9dPjwIl51My99z92p9x7S0yYaCeSFSMqJYl5Wv6GgSAeEuHztiXkb2oXTRDwrasDNvzN6TTUTrDSy2y/jW79A9wW+TovM28y1j3jX+BH+2VzY0gW+828AeOqqVfxSwNAPV4LqhOTvg/A/umVvRC6AgbTZvM7uGRO1SVIbWt23TrR4yb6sMUmTvNpxTLUpqZw10WtkmIOM/n+0KuLGPCVi5z4ORiccunBlPSu/nPfMYyfshnUDydDyepqdI2I83K3IixkeDM1mO7wPTMgMcXRPnu87co+E0R+o+ChakstfIuaCM0Ld74iR5kT5WIbXletqnH4P2wRYQpaQOMPuJMOtd7BAp5aCsIOmdatNoosEUYLSz2eOKLm1Kmnr6lMam2wwQDCaewREKXG6dzdpmHfvaQ+FSGWpsmFssy5/BPBBkhKhX9dBciIULZAzluYqVFcQw5WM1Vq6NambVRpkE8xP3YgUz6fGOeDtTylZLVv+oRcVatbRecga4+uFFbID2Rjrt80JxBo5w5Mpn8f08RXXseXtXK9SGdQZWpo44mu1N+8FoFn3co=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(7416014)(921020)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVlyT2tWNVNmdmJPZmhaUTd6dkxrWHpka0hvYnpMRm16K1pZYW5UOU1FUzQ4?=
 =?utf-8?B?VlEzOEwyajVPUlJGcXkyQWx4OHk2K2hZbEc1YUd4TVFqK1NjMUo0Zm5EQTRF?=
 =?utf-8?B?eG8vNnNOTWhVTEdrUkRiZmtXTEtGSWxYOWNPdFdvem9FTUVpamk2aVBuMWsr?=
 =?utf-8?B?WDdxalFvYmpTTHY1U0NnclJiN0s0ZXhIVzIvejFIb2lDNldLYnczVzRvZjNr?=
 =?utf-8?B?Nmw2Q1A5c0NHWW1EcWoyZ3ByRmowNHY0cGJHKzB0YWl2Rml0RVBlNnMrVGZa?=
 =?utf-8?B?WVE5Vi85QmJZZTJYbzE4T3htTXVIeGxFS09MUHhBVGxiaGFLRG53L1NMYWlv?=
 =?utf-8?B?bmUyMjVobCtYdmE0NTJMam5BVUdjeTRHYnBsM0pmdWNjUTNtYURtU0lBenR2?=
 =?utf-8?B?eE9MdXk3R0R2OEcwYU9taytWOGQrZXR0Tm1kUHdKek5GM1U4WHprdi8rT1lx?=
 =?utf-8?B?UVB6WkdwSlBUTEsvVlUzb3RLdGZEOXRrcGVmRjVZR3FZQWhvNDZMRlhqVGdy?=
 =?utf-8?B?VEg0YU8xYzBiaytlZWtOcmc3NFNCOUdDUlVKK0l4bjNMMjE2TUhLeXdVMFJW?=
 =?utf-8?B?MmdVRHJ2K2N4SVJibWlUN0gxYmxGWlpMR2I1dE9TcUhJNmtYVTIxZzZ5aUZk?=
 =?utf-8?B?cDFLUHFmZ2dyR2hvcWlBNFZRQURXZlVtZk80ZXNDUGREbG56SjNpQ1M5MWJ0?=
 =?utf-8?B?QkpUZGdtMStRRGE4d2xwYVM4ek5tSFlJc0NVeUN6V3NYQ0xMSUJxVVBnVW1B?=
 =?utf-8?B?amRLNHd3bHRER2pub3Q1RFVUTjdWRlREeGFDODQvRGlpYWUyZm1RQWJKUlU5?=
 =?utf-8?B?NUs1WHJHaStVL2c4YkJhNlRFRVhndFYxUEJnWTJJVDZhSjNEWjI4ZHhFZ3VY?=
 =?utf-8?B?U3h0R2VYSHh1bWFiYmtMOEtOUFF1YlI5cWVuNnN3d3hST0k3S3ZoM3d0UlNu?=
 =?utf-8?B?bmRaUC9WTmFQeDNMOTVmcXMxbk9xVjE1NFNxZkd2dFUybU84Z0ZHcmdFclUr?=
 =?utf-8?B?TG1rcU5hSzRHMm5LN3o4a0ZrZDFqTU05Lzh4eFNUUVJOeU5NaFRhWi9uM1Ra?=
 =?utf-8?B?aCthS3UwMlF3VFJkT0ZINUtRMWhIdC9lbTJMakpHcnhyYlhna3FOQ0llS2c3?=
 =?utf-8?B?Z0h2VGhneUl3TEQwdHp4OGlpUmFVZUJJeFJJOXg2R3F5dFVmcElyYkhYRzgr?=
 =?utf-8?B?K3M4VGkwanErZjNRWmt3N2VEOGM3MEdlZTk0dUhZVjdaNDZrSkJxbUgwOHps?=
 =?utf-8?B?SEUxMEgyazJOcTBOaUY3Z0E5a2tBSU5abDQ3T2VkY0xob0V1YVN3Um8wU3B3?=
 =?utf-8?B?cmY0ZWhNVVlBeXVZanZBaFROUFNLSDB0V1NsQkFsL3dPT2VzT1MwcEI3UTNq?=
 =?utf-8?B?a0RGWHdKQ3M5T2s2WG5xT2tkZVFpOG81cC84U2Q2c0V3dmdDTkt5czY0eU8v?=
 =?utf-8?B?SVA3Q21aVDRpbkRmK2IyNll0bVN1NUNFWjBRanVuNnlva3RPNmZld2lZbnlB?=
 =?utf-8?B?a0NXQ2M0Y250enBoUnNsWE50SGpzM0dScFV5ajdtcmthd0JkK0IramVXQW1V?=
 =?utf-8?B?amM3TXJjWDV1eVoycTBNbmZ3WTRnUVBNYXI3UjBXRVpMWFJvMFFQVkpTNi9D?=
 =?utf-8?B?MDE0Ujh6dWNhWG4ycTQxN1pIeUdsYkRINVJkb1JFTVJlRXU4RmJXNlpBbTJt?=
 =?utf-8?B?Sk9QV2QrOGtUcjRoVHZxYXNPNmVmMnQ1aWsvSzZRU3k4RDBEOEVCb1dOSnJL?=
 =?utf-8?B?eElsZFg2NFlVa2pQdHE0YkxFWDFlcnZtVVBrbHlaVnZGKytJbG9MTWRkYlBM?=
 =?utf-8?B?d0xFZ0NlYllsTlVLVEY1d2crUlU2QVJhYS9xamQ3V3ZtRzFwRjBTKzNvMjZR?=
 =?utf-8?B?dUxPQTBnbDVyT3RoZldGRlZSaENwcmk4Q1Y2Wk9SNFVVSm5tOTNBZGlidDlX?=
 =?utf-8?B?ZmNXUnR1ZDJ0c1gwNklVa1l2dFB6VGZQQmE2cmJUaU1rdFBWNnNJajJubDNO?=
 =?utf-8?B?Yzk0WFQ5UGgySk03dWZZS1B5MlcxUDl4b2NyRU9pcnlRYUFJeWl0R000amhZ?=
 =?utf-8?B?QjBSc0l6TVREbmdOUWgraEpEejQzaHNsRGtEMmdEQVZETU1TRzJlenZlenRZ?=
 =?utf-8?B?WmlHZDZOOVNaUkV2akZnT3lzZkphK25DdjhqL2x4bkhBN3VNNG1oaGtNeHV5?=
 =?utf-8?B?UmhiSXpsNC9YRTRydktJL21yL2lvQ1NKMTBSWDNYekI3bFZFaVpuNWJTekgx?=
 =?utf-8?B?cHJvVmxSaFEwZjZwS01KY3ZrYWp5cHU3WmN2Q2xXQnRhLzZKY0R0SjF0cDlC?=
 =?utf-8?B?NkVnMVBTT1haRUpQMmhOUncxcGRITy9zcUNpekZNZlUzbml2Qk53Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2a19d2-bdba-4989-644a-08decd5bb2e2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:04:46.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtckHHTZCiOIi1eDPagr3kd02cSkefuKnFQHxYQKTFqCjpBfX3dhbaPZA9AzWgnhDL5/UCqWaCGXZtYwwKTXfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6966
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
	TAGGED_FROM(0.00)[bounces-9324-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B37D6A1DAE

The expansion serves little purpose and it can easily diverge.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/net/phy.rs | 56 --------------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 2868e3a9e02c..965ecca7d55f 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -800,62 +800,6 @@ const fn as_int(&self) -> u32 {
 /// }
 /// # }
 /// ```
-///
-/// This expands to the following code:
-///
-/// ```ignore
-/// use kernel::net::phy::{self, DeviceId};
-/// use kernel::prelude::*;
-///
-/// struct Module {
-///     _reg: ::kernel::net::phy::Registration,
-/// }
-///
-/// module! {
-///     type: Module,
-///     name: "rust_sample_phy",
-///     authors: ["Rust for Linux Contributors"],
-///     description: "Rust sample PHYs driver",
-///     license: "GPL",
-/// }
-///
-/// struct PhySample;
-///
-/// #[vtable]
-/// impl phy::Driver for PhySample {
-///     const NAME: &'static CStr = c"PhySample";
-///     const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x00000001);
-/// }
-///
-/// const _: () = {
-///     static mut DRIVERS: [::kernel::net::phy::DriverVTable; 1] =
-///         [::kernel::net::phy::create_phy_driver::<PhySample>()];
-///
-///     impl ::kernel::Module for Module {
-///         fn init(module: &'static ::kernel::ThisModule) -> Result<Self> {
-///             let drivers = unsafe { &mut DRIVERS };
-///             let mut reg = ::kernel::net::phy::Registration::register(
-///                 module,
-///                 ::core::pin::Pin::static_mut(drivers),
-///             )?;
-///             Ok(Module { _reg: reg })
-///         }
-///     }
-/// };
-///
-/// const N: usize = 1;
-///
-/// const TABLE: ::kernel::device_id::IdArray<::kernel::net::phy::DeviceId, (), N> =
-///     ::kernel::device_id::IdArray::new_without_index([
-///         ::kernel::net::phy::DeviceId(
-///             ::kernel::bindings::mdio_device_id {
-///                 phy_id: 0x00000001,
-///                 phy_id_mask: 0xffffffff,
-///             }),
-///     ]);
-///
-/// ::kernel::module_device_table!("mdio", phydev, TABLE);
-/// ```
 #[macro_export]
 macro_rules! module_phy_driver {
     (@replace_expr $_t:tt $sub:expr) => {$sub};

-- 
2.54.0


