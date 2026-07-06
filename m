Return-Path: <linux-pwm+bounces-9590-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0wFLC4CnS2ryXwEAu9opvQ
	(envelope-from <linux-pwm+bounces-9590-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 15:02:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A10D710F93
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 15:02:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=CwfUSF5d;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9590-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9590-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64686301DB06
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9E342F71B;
	Mon,  6 Jul 2026 12:44:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021091.outbound.protection.outlook.com [52.101.100.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0C41D4D4;
	Mon,  6 Jul 2026 12:44:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341872; cv=fail; b=fNpt2aCzYGo/3sPOxcQpB1Db4hE0sJxAbW3N9lEGnW4DQ+MHBqJx2mnGWe69cDOI/0f8Y8P97wOxoiRdOU1aAmatqHvY3+/wxyL7yp6DhZ4lrD6wiP8xIuMqQfXOAnDgI9/eWCFbjEA+7xaLDR6Omjx8U/vHACTIjDPGkrs0D6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341872; c=relaxed/simple;
	bh=52m/4Dz1NE8bluAzEmD2YOxaGCrzycZZJdIs7LAKOvc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=TC42G85ZPKJMQJzKJVd38yTRB8WGs9FTsvLL0xq+sQCfFHjfaCaL9xtkZ4n08T51x26pTAApw0tl4DJ3ajkJ+8s/N7pHmE+lZQicXLEzpCO8fbTBNuFjJ1KQn5iRbLMLrmQwtaK/BylELCom3Ai3vYkYPmOKtJ0DvRGkPqIBFo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=CwfUSF5d; arc=fail smtp.client-ip=52.101.100.91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqyII/ArO15ifBpDloT5MW5s0/HWASHK7NFU93x/5wyL7VctiDkjjFJ2+JuBDq3Bjxf6L+ssfCRrjKxGhqT9ek7mUkLSMtPtSlfLyXSrDu3fgzuMipfgilEY4pL0JACfU6B6uVuyqf0vnA2rxYU/wEeihlKiYwrxEg0v39LoISDszubETcpJaO7d1qNEcMgQWm0JghnmyqAYCe2oZ6xMYjglpCJ3ENSQIdFUd37/V1hkccrVXYr7gECdZOQsZfkZ/zNgKu5tjjtubsP2gIycglN2X9KRjo2XA1hDcNKjlvlU5sMf//6gaOWDaTKIVL6R9i8yujvZvnKWifAj13IS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QspqTj0GF7+l+CaaiD3k8a7zZfW0Ig3b+pru2UUR04k=;
 b=wxDNwpDL4iIPqanij/vxyPG/C4NfzORErbcK2+plkxOOqwtGnVt2dbskrojmqKRxuSbXmLXdFcoSe8aAfvFYpFo1cBuG+KboHwVZvYX+LAYhc2WZwrdna3WRczIJcyYSviKEl8wW2AaJx9h0q/+5vQNW/i5J6iPP7Q2Ojg0pUPecJCmR2FEk8R1FTXUUI/AUCU3/SEJbcmELCXRZHFEH4dNt5Lduh4Kr8uaWNV5jyhvebBdzLU9T9ngzZ1YoQkiQn/acq+YRbHYyxvgixWIYpsadu2aN+tTuZGPVBfdLDnBCYdW178YbxUGWoJcpXbvqA6luY9CZD/xrLOql5H1ZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QspqTj0GF7+l+CaaiD3k8a7zZfW0Ig3b+pru2UUR04k=;
 b=CwfUSF5dmn7rjeMV5TugWTFDRC8BBbzONqPEySQN3HesZLDfC4LHVMXYku+/wOeBUSIBWbo4a34C+czP6umkZAuHGYnlOxZtT1UbNcIVeObXdt2++Co3bZa0y9mhl1hHV8HTKx8OicIMRN63gGkXOX7WLrk+NOtXbxNmrKObWck=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6188.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:278::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:24 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:24 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v6 00/20] rust: I/O type generalization and projection
Date: Mon, 06 Jul 2026 13:44:13 +0100
Message-Id: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB2jS2oC/3XOwY7CIBQF0F8xrAcDr0DVlf9hjKGP18osikLba
 Ez/XaomOjouL7nnPi4sUfSU2Gp2YZEGn3xoczA/M4Z72zbEvcuZgQAjFEjuw+4Qwy9hl5tcGio
 d6sqWpFg2h0i1P932Ntt7Tn01taeRRyPSsc+Humdt71MX4vn2iwGm128HB+CCKwQt0SyBarVub
 Dw3fZi31LFpayie3ojFuy+yR42OZGE14T9evXj5cV9lL+sSQFUCHFafXr94MO9eZ+/E0khVSkt
 a/PXjOF4BCtlvgJMBAAA=
X-Change-ID: 20260421-io_projection-16e7dc5ba7e4
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=8599;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=52m/4Dz1NE8bluAzEmD2YOxaGCrzycZZJdIs7LAKOvc=;
 b=ofg59X8k5zhvHkxOg/fvgXm20vJv2UuZzkSz2LpNDYYo6E9d+tDosy1ce//EGgV8E++sVAs8d
 zLz5LmWvGrRAEsU5qCnypI6/NPGqLGhYTNxzPeWy3eMmiYdv4QFX+vV
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de1bd35-009b-44dd-d3f1-08dedb5c4f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|18002099003|6133799003|5023799004|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	+Q9rBsvLpoAxVlyjAWjBK7k6qZ9pInCtxaqHX3R8Wtc5tCb36Q3SVaoTyq4/G+LZKddNrW5DOH/kHAzAoUmpuZ4xI7F3iDxZlqqhLyrNZ49xQ75d32V9xOw+AcvwHcdYjb7EKmvxGrYPkEkumIiq3iBbAdBU43MaPxaYyYbR+PU3Wjj58iisB1FxI81+mRrnEAsoFeOUXMzM66Or/Viz6CnTWBaDvaoO61Vw1Nj+/TeXywTLlKQ4JcpeWVn3O5/M0N0+CqzDygr1tTuAl6JzsxPjvwFxz0tpN/37YKPLH7WOo5DBTh7f/MYxykrz3+dcjrJfUySn/1n/ZnHXrfs+1ZDSw9JGbKIWazj5rsOdwMpf6hf9HkJt1MKIo/1CaCFBYtqjDLJNvKx0WfPryRDUzysfAhGC4TX9/nqnk5sAtm+kmIYqmJjlP0IXUx7HJkd3VZJ0/rix7Zi4QLOOOYGgrCMPI4hxqhhrEN4iUi3nOnY8tLPDZsxRRTrLiH8owAtkDAi44XjoFdc06NMQ88s+ieHBWwwjuwJ0Z/OUU9HxxXtVrIvdv7MKjUSuxhI3rtVytqsmLMQabp38OhMSnG3W6VhxIynAGVMQo6WsHYhoxwfSN6dUxfOMJz+Zi4+E2B74LqsYQ11qvNpdzrSDJFHXBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(18002099003)(6133799003)(5023799004)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1JKcnBoZTc1cE0vL0s2L1pIc0NZMnhQdmVBVERBQjFmZ05Ed2ZudGoyOFhQ?=
 =?utf-8?B?WWNqOFFNQTVmMUFiOW1VODNJVHFlQXE5Z0E0cGNoSUhONFA3dUpWLzBFKzU3?=
 =?utf-8?B?SHJhRUlQRzFxNWgrd0NDbENndklIdlY5TktqSmFFUzVnYWIzV1Y2N3ZrWGtE?=
 =?utf-8?B?L1dHVDU0Q0pIY2tlQm5jMGU2K1JmcjRmenE2V3BwdnJDZ2NaYWVDN0FySzVp?=
 =?utf-8?B?ZHo1bWh0N1hKS0ttY2tLM3Q0Z3ptU1MvRytMWGVlTlU1Vm1HNGJqNndlVnhp?=
 =?utf-8?B?SkNueHozV3pwbjRrSjFtMlYzdngwTm1oWE1tR1RpZ0FPYm81WEpQSUJiaklK?=
 =?utf-8?B?WkxkdDFrVy9uTFVDbW04OGlKRkpWWXlkZVlEM25rSWJjaGhKUWtXbzkvaktD?=
 =?utf-8?B?aDFwY1dGL3ZYUG5aeGc1Y0wyZHczZHZtQkZHUXJDaForK3JPTE40eTdqTTFF?=
 =?utf-8?B?SHZ6bnNna0lpU0hIZ3lOUkN5cUZoNkNQRzNwMTIySFN5VlIyMER1NGdxZCtr?=
 =?utf-8?B?ZEp5MVBFd1E4UjdpT0U2MVJ1WXZyTitZT2xLOWp4Y0tVb0dSOU52OHFVOU1z?=
 =?utf-8?B?MU13STRVWTJuT0xzSldzVXo5QnRrV3hLY3VhbU05RGVHb21RQy9vMFpMUEZK?=
 =?utf-8?B?a0xoM3hpRVNINlY0aXJIZWZLTTJqcGhYS0lrOUhXeEUwMHJqM0EranpONGdy?=
 =?utf-8?B?bWpGZi9makFQSXFHUENwNzIvTzB4bGZpeXp4SXJDWllXdVM2eTkvY2lUQmVn?=
 =?utf-8?B?bU5FZE5oMFRnQWkwcEQ0YVdHdTgxS01teWsrTnNFdGRGVkI5TlI3NEVTdHpp?=
 =?utf-8?B?aVFaRTd3OWlWUFF6YnBaREhYRzc5RWU3NGlTT1NIVUNiYitQTmcyWmI5Q1Zl?=
 =?utf-8?B?ZEN2dGdGS0JLb3YzK3had3d6UkpLcnZkaTcrenN5eVlTWFJ6T2dwdGYySWd3?=
 =?utf-8?B?QlRYOVVkMFBZV0dUb0xEM1doYjVwaEJMa3hJUHJPMG1ObzhYNFo5TjdzV3Jn?=
 =?utf-8?B?QXptNXByK0NvT0ZHWXpjWllyNkg3RDlmSTRacFNyVWpkUDJrbitoMTg0VGxW?=
 =?utf-8?B?RTREeS9ZWXNHSjlCQk9ucm1NTUcvQ1lrVDN3eDNDcFMxNEpmM1RkbHFEbHlR?=
 =?utf-8?B?ZmhUYnZNcXcvRXpxTklpSmExL0R6NW5oTWYreTRSMjNmRk5rVkhOenYzdDRn?=
 =?utf-8?B?Q0syRGxSbkxXR1NzcU1CMjlrN0FLdHpidVV4eWx3aWIvNnVqL3UyREZ2VXNr?=
 =?utf-8?B?dzBtT0NmK2N5ckcwckJvdHJ6UzhoeDlnNFo3N3oxQWNvMHgzcUJHSG01a1Ft?=
 =?utf-8?B?bVZRcHlsd3ZPb3VUWGx2NmxHTXBOd0JibWk4R3pjTnd6UVI1U28rSUdxM3Q5?=
 =?utf-8?B?RHR4UEtIeVAwdTVNMG1JSlZwL0RsY3N0azRqMzFGNGhQeFBKMnFYOGNqUGgr?=
 =?utf-8?B?ZFk2dWNpUllETit1SUg2MnNJeFdoc2E5N1k3dlNPZ0lNdlJJZ2x2NjdHamNi?=
 =?utf-8?B?Q2kwVXF2UXFXNWFIQ3d2bHVUVjBwdjR1eCtsbDdzUC9IdUQwSUpScmJKL0w2?=
 =?utf-8?B?ZWtWeDEwTW94aVlQa0c2Rzg1RHV3cGQxeGU3NGowUmVhMnBvWE56VXVPY0lY?=
 =?utf-8?B?SEl6NjBvRGIwY1V4RDRjNG5YOE9yaDdXaGM5MDZBS1lVMC92ZlpNZjErUGti?=
 =?utf-8?B?Zm5JdGc3b2tFbjgzUHdJR0lMRzRwd0FRdTdsbHBIcUdkbU95MFozWHowbUgv?=
 =?utf-8?B?cUpid0VMWTNHTDlBdzdaYU1zUUwvU1haYjRpaHpYQ2lwelFOemVGNWxqSWFk?=
 =?utf-8?B?Q1hIUng3aHZDdWpLUUcraW5OaFRjeUY4cWJYMnJWbUs0VnNwY0laa01TTFhK?=
 =?utf-8?B?dXQvUTd0T1B2K2ZRaWdMMkd4Qkk1ZlFaQTQwSDAyNVRxR2dkc3dtTlV1Wisy?=
 =?utf-8?B?OGFCSlppRTkyMUNyVTg1LzJpTjlaTnIxY1hnOFVpSldlRlNvcVRkbEMwZW9y?=
 =?utf-8?B?QjJhbzE2Y3pHMnlhUjhpZmRRQmdSdjlldTdWZ2Y0YmI0NnZiQ2dudWV4Zll0?=
 =?utf-8?B?MTYxcGJGalN5NENaRS9XVThNbTVJdU53Zjk5ZHE2UE1KMFdGaVJBbUNhSEJv?=
 =?utf-8?B?RXhJMGlBWTZWYk9zd28xU215YXZ4Z0ZwaEdhZDR0TzR1ZUxnSmJyaXRLM0JH?=
 =?utf-8?B?VnV0SE92VW1HYXRXOFRYUUlab0ptTUhJelJMUTRjYXlKcjJ5Zm1LanhFUFFt?=
 =?utf-8?B?dnBIVDBVaUVXUTR4V1hINXorVWdRSWY3Z3lZYkdVWUttazJDZm1yR2lNcHdv?=
 =?utf-8?B?RWZBTjRmT3daaXY4c3R1dnZZalF4bk9xQzRMZ2RSTXo5U3NBTnlRZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de1bd35-009b-44dd-d3f1-08dedb5c4f1a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:24.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0taJSqL/lW03vAwNyRG1FqzrGsAqvEdek7vxdFB1JJv99XPYyl7+7tNQwUrQ5mnnQC694c/jKSUQWAQ1p9ZVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6188
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
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9590-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A10D710F93

This series presents a major rework of I/O types, as a summary:

- Make I/O regions typed. The existing untyped region still exists
  with a dynamically sized `Region` type.

- Create I/O view types to represent subregion of a full I/O region mapped.
  A projection macro is added to allow safely create such subviews.

- Split I/O traits, make I/O views play a central role, avoid
  duplicate monomorphization and less `unsafe` code.

- Add a `SysMem` backend, and make `Coherent` implement `Io`.

- Add copying methods (memcpy_{from,to}io and friends).

This series generalize `Mmio` type from just an untyped region to typed
representations (so `MmioRaw<T>` is `__iomem *T`). This allows us to remove
the `IoKnownSize` trait; the information is sourced from just the pointer
from the `KnownSize` trait instead.

Building on top of that, `Mmio` and `ConfigSpace` have been converted to
typed views of I/O regions rather than just a big chunk of untyped I/O
memory. These changes made it possible to implement `Io` trait for
`Coherent<T>`.

Shared system memory, `SysMem` is also added to the series, given it
similarity in implementation compared to `Coherent`. In fact, the series
use `SysMem` to implement `Coherent`'s I/O methods.

Built on these generalization, this series add `io_project!()`.
`io_project!()` performs a safe way to project a bigger view to a small
subviews, and some Nova code has been converted in this series to
demonstrate cleanups possible with this addition.

New `io_read!()`, `io_write!()` has been added that supersedes
`dma_read!()`, `dma_write!()` macro. Although, they work for primitives
only (to be exact, types that the backend is `IoCapable` of).
One feature that was lost from the old `dma_read!()` and `dma_write!()`
series was the ability to read/write a large structs. However, the
semantics was unclear to begin with, as there was no guarantee about their
atomicity even for structs that were small enough to fit in u32.

For completeness, I've also included the support for copying methods,
although this does not need to be taken together and can become a follow
up.

The last commit in the series is a reference on how you'd implement
`iosys_map` using an enum type. It automatically gains all the methods via
`Io` trait and can be projected with the macros.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Generic.20I.2FO.20backends/near/571198078
---
Changes in v6:
- Various typo/comment fixes. (Alex)
- Rename `CoherentBackend` to `CoherentIoBackend`. (Alex)
- Reworded "rust: io: move `Io` methods to extension trait" to mention
  `size` method as motivation.
- Fix DMA sample driver build issue in the intermediate patch. (Alex)
- Fix rustdoc warnings. (Danilo)
- Link to v5: https://patch.msgid.link/20260626-io_projection-v5-0-d0961471ae50@garyguo.net

Changes in v5:
- Fix bad squashing of `Region` safety invariants. (Alex)
- Fix compiler warning in Rust 1.87+ on `only_derive_is_allowed_to_implement_this_trait`.
- Many typo fixes. (Alex)
- Rename `io_addr[_assert]` and make them standalone functions. (Alex)
- Fix safety comment for `copy_read`.
- Add note to `copy_read` and `copy_write` that they can be different from
  `read_val` and `write_val`. (Sashiko)
- Link to v4: https://patch.msgid.link/20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net

Changes in v4:
- Added `Send` and `Sync` for types that internally uses raw pointers. (Sashiko)
- Make `Region` always 4-byte aligned. (Sashiko)
- Removed `copy_from_io_slice` method due to unsoundness when regions
  overlap. (Sashiko) This means that `is_mapped` hack is not needed anymore
  so I've also cleaned up.
- Switch `FromBytes`/`IntoBytes` to zerocopy from kernel::transmute.
- Changed `Either` to specific-purpose `IoSysMap` enum (Miguel).
- Link to v3: https://patch.msgid.link/20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net

Changes in v3:
- This version presents a major rework from the last version, mostly inspired
  by discussions that happen during RustWeek. Notably, the new individual
  view types are now the central piece of `Io` traits rather than an ad-hoc
  addon using the `View` type. They also benefit from type-erasure; the
  original type of `Mmio` or `Coherent` doesn't matter anymore for subviews.
  This removes the need of specifying generics on types that take
  `CoherentView` on Nova code, which is something that I'm not fully happy
  with in the last version.
- Add `SysMem` backend and use it for `Coherent` (Laura Nao).
- Add examples to copying methods and read_val/write_val (Andreas).
- Add a reference patch on `Either` implementation.
- Link to v2: https://patch.msgid.link/20260421-io_projection-v2-0-4c251c692ef4@garyguo.net

Changes in v2:
- Rebased on projection syntax rework
- Added a new patch to forbid use of untyped I/O accessors and register
  macros on typed I/O structs (Alex).
- Fixed a few safety comments (Andreas).
- Added a new patch that implements copying methods (see above).
- Link to v1: https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@kernel.org/

To: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Trevor Gross <tmgross@umich.edu>
To: Tamir Duberstein <tamird@kernel.org>
To: Onur Özkan <work@onurozkan.dev>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
To: Alexandre Courbot <acourbot@nvidia.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Michal Wilczynski <m.wilczynski@samsung.com>
To: Uwe Kleine-König <ukleinek@kernel.org>
Cc: driver-core@lists.linux.dev
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: nova-gpu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Cc: linux-pwm@vger.kernel.org

---
Gary Guo (19):
      rust: io: add dynamically-sized `Region` type
      rust: io: add missing safety requirement in `IoCapable` methods
      rust: io: restrict untyped IO access and `register!` to `Region`
      rust: io: implement `Io` on reference types instead
      rust: io: generalize `MmioRaw` to pointer to arbitrary type
      rust: io: rename `Mmio` to `MmioOwned`
      rust: io: implement `Mmio` as view type
      rust: pci: io: make `ConfigSpace` a view
      rust: io: use view types instead of addresses for `Io`
      pwm: th1520: remove unnecessary `deref`
      rust: io: remove `MmioOwned`
      rust: io: move `Io` methods to extension trait
      rust: io: add projection macro and methods
      rust: io: implement a view type for `Coherent`
      rust: io: add `read_val` and `write_val` functions on `Io`
      gpu: nova-core: use I/O projection for cleaner encapsulation
      rust: dma: drop `dma_read!` and `dma_write!` API
      rust: io: add copying methods
      rust: io: implement `IoSysMap`

Laura Nao (1):
      rust: io: add I/O backend for system memory with volatile access

 drivers/gpu/nova-core/gsp.rs      |   53 +-
 drivers/gpu/nova-core/gsp/cmdq.rs |   66 +-
 drivers/gpu/nova-core/gsp/fw.rs   |   82 +-
 drivers/pwm/pwm_th1520.rs         |    7 +-
 rust/helpers/io.c                 |   13 +
 rust/kernel/devres.rs             |   24 +-
 rust/kernel/dma.rs                |  281 +++----
 rust/kernel/io.rs                 | 1499 +++++++++++++++++++++++++++++--------
 rust/kernel/io/mem.rs             |   29 +-
 rust/kernel/io/poll.rs            |    6 +-
 rust/kernel/io/register.rs        |   44 +-
 rust/kernel/lib.rs                |    3 +
 rust/kernel/pci.rs                |    1 -
 rust/kernel/pci/io.rs             |  168 +++--
 rust/kernel/ptr.rs                |   12 +
 samples/rust/rust_dma.rs          |   12 +-
 16 files changed, 1624 insertions(+), 676 deletions(-)
---
base-commit: 5dcef303b29f004a447d9c69e62963328da9c608
change-id: 20260421-io_projection-16e7dc5ba7e4

Best regards,
--  
Gary Guo <gary@garyguo.net>


