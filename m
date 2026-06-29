Return-Path: <linux-pwm+bounces-9465-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IykQAiNuQmru6wkAu9opvQ
	(envelope-from <linux-pwm+bounces-9465-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:07:47 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1D76DAC53
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:07:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=oCSgf4YN;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9465-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9465-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC79C322671C
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E145B405C48;
	Mon, 29 Jun 2026 12:39:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020104.outbound.protection.outlook.com [52.101.196.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED61403AEE;
	Mon, 29 Jun 2026 12:39:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736789; cv=fail; b=W9LW9Z7WK6oCo4tKsx+Xsp9eUyWIDR52NeXS7T/T6Acgvp1n0jTR7vE9NeIQnONpiIniGtVblIyOc9YhZaIQmP/Fy8IUD/cw0Q7Hau95CVfnksN0UVE9zZHMZ2uBiCdS4V3SzNkgrq/7sp27wHakvYWFx9P738HM66iOVnzFcaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736789; c=relaxed/simple;
	bh=Gk/s1QmKWOyRkFbSOYyHTIq83dai7AhdGM7SfFaBuPI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FT4ZahA4xRRHN0PBySwS4b52sC+tQCldLU0iTM2Yd2OpG/DQIp3semPewCqHgkTbGEo1Cy/mqfZTT+5br1c0+m7GuvH3AdrNX+87r9ZtO4SlKr2Ly3qCY/++X+Utzi/CYrYXJyydE9m2vPHsDsBBBCNvqRMhOmjgWKcJsJP+gCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oCSgf4YN; arc=fail smtp.client-ip=52.101.196.104
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBBXGSIOINYr2x58CDmWMdUuq1sd5G7ngAAEkMEw1+UmPQB2gsj9G9ZlMgn25k9Uo6SqeKpvkujV43ewF7rAHxn6Ung4DF6vbuRIxFhvlyNTiOMkCPgczO82FVy0HBU7W4ESYK9e3KRzvLf7xkd9iDX2Ta1OXlH2kHSQNMM6QrvnKtb8bW8LVO1h6Z0zmgQeyl1FPuzY8QXJJeTQ+ZvmbgV80BQ/lV9Q1gyzqyE0rnkziWuud1PV020l63pqqvU2oxrMQrzEXZI0P3XcD3c8raHrcPMw0OblcmIVn7qvgObgJD1ZmgZFwHS1wXgaejXlHGu0kCf+1p1wamn7mceB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kh1aAM79nSSG3iJeQxH9mLkI+xzZ7w6p/3GFSVVcQo=;
 b=CF+/6WRZ7pqU8/+yUqjCg5cOOHxM/0DGKGr6iphy+1cixQjmeFrqwlKjdMVUQwnrzBUBsZ9rhF7JvmGOrm8dNzb4bfxnM+wfNKrzuGcOXnFZLRAYrxqFD/6pA/IdO8b2SSUqwQELh522kD0tnmkSyMQY9cUKqDxIMS6AYY367tK8H3gL4r9P7S9aI8NMbPtV3pCE9f2SbwYpAYD7heqn1qGqMGFcEr6rnIwNR0jip0DuNozsT+txsa1+9pEArDnZdoMlXS+UK6c7+FMjscOEp7+dphfTM33OG1XZbcxIkfV+rrrVnqgbtkJCHJ98ZVenibea40I0G2Xd2es+W4rfAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kh1aAM79nSSG3iJeQxH9mLkI+xzZ7w6p/3GFSVVcQo=;
 b=oCSgf4YNZiBUSIlwrnYetp9QrXYp4MMx5nhRPayibjPouDi5PcU9SMkjLOikSFuXHfJ/3PPLsm6M2IpvlWDH0mSmz0sqrVoJFAj60S890VAU4kUyhTaRgnrfkh4xYjVFzrWsjJ90m/F++/HOcheefkNxhdt0fQ+XByH2Ez7Qm3w=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3081.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:174::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:39:41 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:41 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 29 Jun 2026 13:39:36 +0100
Subject: [PATCH v2 02/11] rust: driver: simplify
 `IdArray::new_without_index`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-id_info-v2-2-56fccbe9c5ef@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736778; l=5841;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=Gk/s1QmKWOyRkFbSOYyHTIq83dai7AhdGM7SfFaBuPI=;
 b=JuFJuxclCOq4uCGOxbX8Y1gwj22ARIonlrr/HrJ/ry1MGWtbgnhrKr9Emm6A4HInfQQKlKnTF
 wHgUh4azf+tAVHqF7pITtOWnjwej/zUJ2PoG9pMYmPWbDhkVbTG8S7d
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3081:EE_
X-MS-Office365-Filtering-Correlation-Id: 855420bb-ea3c-45a9-4043-08ded5db7d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|6133799003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	rTgbaTI7Ip8432sjFNGeZPmQKb6had8DzD4d+7l8hHGd3X6tAAfGm/vWba/OonQ1DWGEiccjFrRWOFhy5NG6GGSZMFU2c+1+hbxTLxxzPOV/diHTElG6V4zuJvCdzx7D2CXZ8im86lEwgZI1FB/vWCRVxtZQVMWPn8kpBr6R9o5Joqlj4ue//hDndC5sJfCOs07IcZ8nFL2pAa0EpHidCAxQ+me4pbPzyoXPLKK8t7Db97P7Z8M49JEht8Ol+MGqKg/+wYXKRlGI8UpkPfT758JY87ELAWc5xl5CyjKxrbQ6N4vCypUCDB3PMhLy9kLx0dwBKqQ8xm+PXGfaYCEl8EfE9A7dpF2zAvZa4h/IUSJcdxJ2ZOwWgdp7yjlBOn/DwTSQdRzok9HUccfL1XQUEbxpG15xC85HeLAFiUhl0JwaLs4LWRycP9UTzZ5or4maZGM+MV6jXnbsh7jUcC5baFxznz551eBN1/TQZQBfaf3rsy739Ei9NkU2U22GT0SDfwtgAyV6wpI++jEE5j8xBwUepxAnX3UdpSn5VarEXqGS+fvpLpgr7H8YKajF6Kr8jTFavrcP+YP3jQ8SJ3+pXXG4sTsIYiyjSnD4hVzhFz1uV3+66e1lV+PWh2bQQxp8Qd7K41zKUKyJS36XXLlWHpAVe0CiEjAGte6txA2TMx9N+nbexRtPcF6kfga7l9nla6C99cG6X/sMi6BkMXhc1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmNvMDZvTEZySmhURWw0LzBWOCtTWHlROVBwWnZsdWdGUitDNUZHQkdyMVBM?=
 =?utf-8?B?NU5FNk1wZXY5VlBXNlBRM1pMQTcwME1ucXR3VTIvWFdjVDNEYmYyL2pGMmJC?=
 =?utf-8?B?Um1hY0VLR2loYi9COUxRVmlTL29oS0szNzJMUFRBbHpKOVRwaTJjSHVtVTc4?=
 =?utf-8?B?emJoODFXdVRBaXkxOVdEb1V2TTJOWDZ4aFNaSWVsOUxXRkx6NmJETzRTa1Fq?=
 =?utf-8?B?dFg2RG1WTnI3dWxSTVNQZFVGa3lEblE2bTd6VWs1a21sMHdOOVk2MlU4UFlj?=
 =?utf-8?B?ODZOcGxFa1pJTjVkMS9DaXd2cVZzeCtTU1g0YWtkdVhkaC9qYi9MaTZzRjc3?=
 =?utf-8?B?STk5SEFhYjVTOXVpeGZPb2ZJVi94aVlVcFZ3Sm1sdVdvRnJhY0paVmNoTVVN?=
 =?utf-8?B?SVZBYUtkRHhlYTk3MEtFZjVCNU1GOGcyM08yZWlGRFIvNzZueEhLdEVOZDk0?=
 =?utf-8?B?ZmxVK2Y0My9GRHVvaEdYaFdBamtiSUpDOEZkSDlrRFc0WFo3NlNaaVBCeGdy?=
 =?utf-8?B?R2h3NVZOLythVmhGYU5JeGkyMm5hTlM0VzN5YWsrcGlnQ0RJbW5nMkJyRmtL?=
 =?utf-8?B?NGM4N3R0VWw0QkRlUmlybHBTb1ZLbURpR1ZML2dBQnI3djdpRG1KWmQ2dEZN?=
 =?utf-8?B?MUh0REtmeTFmUXFTUmtWSnpMMlBhL1p1NHhacE9nQzYvRkNadk03TlhTT2Jo?=
 =?utf-8?B?aVFrbDI0NkNKc3NKM1NyS21oRng1NFZwZHcyUVVITmxjR3MxTm94L3hrSlB1?=
 =?utf-8?B?MzNVVDNZbDRSV0JKanRQdnNrN0t5MDVWb1pHNUR2T2dZR0xid04ySldFQXFz?=
 =?utf-8?B?UDdwWWFqbkVGUENQMkFWWVlVN3daaC9kNGt4ek5kaVB4QWVzNHlpY2VhOHBE?=
 =?utf-8?B?cnY4U3lRYVRNT0dkQjRxOFB1RUR2UnA1ZU8xVmVCYUpiYnJFcVEybHczSi8x?=
 =?utf-8?B?R0piSmVwd2k0RGxPZ2VRNkd1Y1EwVDA2VnhNcTZkU3IvMUx6T0tuRndBNUl6?=
 =?utf-8?B?VWd3MnJWOUo1OVliRU5KWUlLVDhJNzJ3ampXNnVvZ1J3cE5qbG5sZFVQRkZo?=
 =?utf-8?B?TVh6ZERqM2VldmorZThzcDc2RVdHcU5sTlo0WlVIV0ZQSzd3K3NFZXdtUU9m?=
 =?utf-8?B?dWVnLzlzY0t3aEh0TWVGb0EzUVFCc3c1eWt5WWtCMmJZcnpFR0VtaVhWRHp0?=
 =?utf-8?B?bEVWZDltY2Z6RVNXMklmdzJFMzFSc2tnaGNvUWNrUTBZTFp0NDM5RllEYlNq?=
 =?utf-8?B?b2ZjTlNqb2hrQUJBWW9TNFU1aW8wNk52aTlBV0k3S1Z6TXVaZWJvTGNLcFpt?=
 =?utf-8?B?ZlAwdkxZOWhoM2hqNnlEMGQwZ3czUmx3c21rK2F1VmNXK1pWdFptOThTREhw?=
 =?utf-8?B?MWZsVHp2R2JPbHNIWGR5SkJZMmFRaGhOMnRyMGxwTE9xMEhUM3haY3hOejhR?=
 =?utf-8?B?RytKUXVQTFA3RVkrbFcvbWFUT1lNZUNVYkdzbU15Mnltc3JaZVozc1lPVTdw?=
 =?utf-8?B?dG80a2F5QzJXTmNhak5ldDBTR05kVDVRdkhPWkE2U2RweE95ZTFoeHFSTmNh?=
 =?utf-8?B?azM5MHdub3JDOGdUbThRZThoYmxaN2c2ZkRITURxei9KL3JzcUYvZGczWHdy?=
 =?utf-8?B?SFE5bkh5UFVjQnBZRXpIOHpsZkdldDMvVGNkb3BvdUZCYjNDS3BtWklDSDlt?=
 =?utf-8?B?YmNOR09HZFJ2czFQbWViYmM2VVhtZytuMlM0bVRoTi9pWkhpR0tkWnRpR1Jk?=
 =?utf-8?B?ZXA5RU92NksvVytRaFMvOGtOUFR3eEFWazlYN3h3bFFEWUQzRVNHZ2J2NUp3?=
 =?utf-8?B?azRRR2htQnprM2dYcklNM09lZ09xbFBodVpGbHgxM3JzbE9ZOWFhRmhic3BK?=
 =?utf-8?B?UmtSTGhNbHNNV213UnIxVlA2VzBWV3VCQTl0RTF2aVFzcE1jaE9ubXBaU3Rw?=
 =?utf-8?B?ZXBoQ2tzd1VTMWtxcE9nTVp2TUVWZmhSSWVZcnZsYWpsUzlGUkdJZUJCMVBo?=
 =?utf-8?B?bFduRDNMOHltcW1QSFJDaUZ6NjBTRlBUSFlJTER5Qms3MUE4Y1pmbEt6QlE5?=
 =?utf-8?B?Qis5dkVWR2VQcUdYOTlSTFhnWUw0M2JCYUJXVU1xZ0RRNWRJK293SHh1TjFZ?=
 =?utf-8?B?bkYvWXJidlBnUzZjNlowRUxoZkVhbkhMMjNkcVBOR0R4RndIekpkczFobHRO?=
 =?utf-8?B?aXVIeUtZelR3ZDZvL1ZPMm1hRXFVZElUUWJJQkNtWHFRZU5oMU9VWSsvdWcw?=
 =?utf-8?B?NkVVd24vNmh0amEza1VLVlA2VnZGbE5FK2t5bE53TVhTQ2hnVDhLbzZSbnNv?=
 =?utf-8?B?VnpkR0Zyc09ZeVFpYU1TY0tsRThBaVJzZmszOEo2eXFiRlE0SGR0dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 855420bb-ea3c-45a9-4043-08ded5db7d3f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:39:40.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mD7o0aIjlrt8AzjlzgvR2jyvpvvST8pnaFzf6sTXTkEZ5EAAVXmC8LF36ge52zm4zmILX9ptZd4Iav7Wjtca3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3081
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
	TAGGED_FROM(0.00)[bounces-9465-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D1D76DAC53

This method can very easily construct the `IdArray` on its own without
delegating to `Self::build`. Doing so also simplifies the phy device table
macro because it does not need to construct tuples anymore.

This also allows simplification of `new` and `build` which removes the
`unsafe`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/device_id.rs | 64 ++++++++++++++++++++----------------------------
 rust/kernel/net/phy.rs   |  2 +-
 2 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index fbf6d8e6afb9..eeef3f5e7b63 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -73,19 +73,11 @@ pub struct IdArray<T: RawDeviceId, U, const N: usize> {
     id_infos: [U; N],
 }
 
-impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
+impl<T: RawDeviceId + RawDeviceIdIndex, U, const N: usize> IdArray<T, U, N> {
     /// Creates a new instance of the array.
     ///
     /// The contents are derived from the given identifiers and context information.
-    ///
-    /// # Safety
-    ///
-    /// `data_offset` as `None` is always safe.
-    /// If `data_offset` is `Some(data_offset)`, then:
-    /// - `data_offset` must be the correct offset (in bytes) to the context/data field
-    ///   (e.g., the `driver_data` field) within the raw device ID structure.
-    /// - The field at `data_offset` must be correctly sized to hold a `usize`.
-    const unsafe fn build(ids: [(T, U); N], data_offset: Option<usize>) -> Self {
+    pub const fn new(ids: [(T, U); N]) -> Self {
         let mut raw_ids = [const { MaybeUninit::<T::RawType>::uninit() }; N];
         let mut infos = [const { MaybeUninit::uninit() }; N];
 
@@ -94,16 +86,14 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
             // SAFETY: by the safety requirement of `RawDeviceId`, we're guaranteed that `T` is
             // layout-wise compatible with `RawType`.
             raw_ids[i] = unsafe { core::mem::transmute_copy(&ids[i].0) };
-            if let Some(data_offset) = data_offset {
-                // SAFETY: by the safety requirement of this function, this would be effectively
-                // `raw_ids[i].driver_data = i;`.
-                unsafe {
-                    raw_ids[i]
-                        .as_mut_ptr()
-                        .byte_add(data_offset)
-                        .cast::<usize>()
-                        .write(i);
-                }
+            // SAFETY: by the safety requirement of `RawDeviceIdIndex`, this would be effectively
+            // `raw_ids[i].driver_data = i;`.
+            unsafe {
+                raw_ids[i]
+                    .as_mut_ptr()
+                    .byte_add(T::DRIVER_DATA_OFFSET)
+                    .cast::<usize>()
+                    .write(i);
             }
 
             // SAFETY: this is effectively a move: `infos[i] = ids[i].1`. We make a copy here but
@@ -127,32 +117,32 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
             id_infos: unsafe { core::mem::transmute_copy(&infos) },
         }
     }
+}
 
-    /// Creates a new instance of the array without writing index values.
-    ///
-    /// The contents are derived from the given identifiers and context information.
-    /// If the device implements [`RawDeviceIdIndex`], consider using [`IdArray::new`] instead.
-    pub const fn new_without_index(ids: [(T, U); N]) -> Self {
-        // SAFETY: Calling `Self::build` with `offset = None` is always safe,
-        // because no raw memory writes are performed in this case.
-        unsafe { Self::build(ids, None) }
-    }
-
+impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
     /// Reference to the contained [`RawIdArray`].
     pub const fn raw_ids(&self) -> &RawIdArray<T, N> {
         &self.raw_ids
     }
 }
 
-impl<T: RawDeviceId + RawDeviceIdIndex, U, const N: usize> IdArray<T, U, N> {
-    /// Creates a new instance of the array.
+impl<T: RawDeviceId, const N: usize> IdArray<T, (), N> {
+    /// Creates a new instance of the array without writing index values.
     ///
     /// The contents are derived from the given identifiers and context information.
-    pub const fn new(ids: [(T, U); N]) -> Self {
-        // SAFETY: by the safety requirement of `RawDeviceIdIndex`,
-        // `T::DRIVER_DATA_OFFSET` is guaranteed to be the correct offset (in bytes) to
-        // a field within `T::RawType`.
-        unsafe { Self::build(ids, Some(T::DRIVER_DATA_OFFSET)) }
+    /// If the device implements [`RawDeviceIdIndex`], consider using [`IdArray::new`] instead.
+    pub const fn new_without_index(ids: [T; N]) -> Self {
+        // SAFETY: `T` is layout-wise compatible with `T::RawType`, so is the array of them.
+        let raw_ids: [T::RawType; N] = unsafe { core::mem::transmute_copy(&ids) };
+        core::mem::forget(ids);
+
+        Self {
+            raw_ids: RawIdArray {
+                ids: raw_ids,
+                sentinel: MaybeUninit::zeroed(),
+            },
+            id_infos: [(); N],
+        }
     }
 }
 
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 3ca99db5cccf..2868e3a9e02c 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -868,7 +868,7 @@ macro_rules! module_phy_driver {
         const N: usize = $crate::module_phy_driver!(@count_devices $($dev),+);
 
         const TABLE: $crate::device_id::IdArray<$crate::net::phy::DeviceId, (), N> =
-            $crate::device_id::IdArray::new_without_index([ $(($dev,())),+, ]);
+            $crate::device_id::IdArray::new_without_index([ $($dev),+, ]);
 
         $crate::module_device_table!("mdio", phydev, TABLE);
     };

-- 
2.54.0


