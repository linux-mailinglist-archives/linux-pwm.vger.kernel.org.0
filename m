Return-Path: <linux-pwm+bounces-9555-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SzWTMl5JSmoIBAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9555-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 14:09:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CCF709E98
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 14:09:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=iRVGNrnK;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9555-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9555-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 215033005EA2
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 12:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B427D37DAD0;
	Sun,  5 Jul 2026 12:09:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021101.outbound.protection.outlook.com [52.101.100.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B355347C5;
	Sun,  5 Jul 2026 12:08:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783253340; cv=fail; b=SwOcvJubZikcYgtIe/kRO7yhvY0tc9KE2ug7iyA+1di3N+MgK0vEsNm3A9Wde83ZrrvIUz/wkSgODyWtulSB4USKUNj7C43YEVKuvIw/+L1OtyrRqibHNoEEJ6RkodgLlyswSq2G7FKhTzQAB+RNOeCqbFpS9EyOO6yrIo4kZSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783253340; c=relaxed/simple;
	bh=DY/ZJQ3rqnkCC0e1X/oyZqJVF8kR1+OKPNDi0K/7Hls=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=SoPW6M+F/x8o+dBJmHPDPn1kh8GX8pkvv9D5z7LcnFOBv/xSlHJCZx5RshPzZosYiTdgmqDsdE2tX11R7YsT5qfJGZqbyYc+NVIm20Rg9XEGR4HOYQZ0Z7IlCnymvwL9L0+W2+hkAubRNvEtJd+bLk8DQTZJnuHnoqJ+BGbhGCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=iRVGNrnK; arc=fail smtp.client-ip=52.101.100.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7yuJ/XJPfB6H416itnidLvU2Q+SFBYEPsHwzUllF3OUNw6M+GewX8/7QXzRkpX0KQXWtEBeI0dc9x9E+qAj64qyGOf4SAduLbiHyEFPXm692n5BwQgcBUmuE7QFcuRO53LUqHl9vhbQ1T9nGQVhAifdDgvjAaU2Jz/D/zEakDgya2lnzHKuvDaJGUz0wOqqZgKwJoOq0ypfdkSfa8BXHISmKETY0SZ8DRVpOqAS6N68XvGuSYvc+DEUBzpkKDv3a0CMedz2QM/lCWSIh5GKcZSeTa6kIcWSbFTBni0lKzGD1uAG1QfYN+7arxhoZ3uNFjl0YlpyfQ0mub1LcFdM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6geqeTZ8oVqFzJKnxN6Ou9cSnOXfd1QdLC5R6btzXj0=;
 b=OfEoDDAsFCWl7+OkmDFrXDqZLI58LRqwqX6MbiyPwI47sYjRgxYzAtPwpmKhOXPTBdf2BoK51C4kzyAz8U6KmpYyaIHFxiIwIZ3E3qMtDBUTL1JbSaNFoBU36HLGO9/MMrKXDm4UcFhorpEie760vgrPp3NcFWbFanBnhHsNTPK0v6JLUYWBlER0TI462JsF0D5VLt4/XyPJfEwgI5pjJrQx5VELQQbPGzRKgoDdB7xyHfQFymUnNoGXC3hyZKVUMMzXZW824jDqpRvpqku58ryc7sfUfUfxFd4jfTTifnCnhy0wda+pYByAy2gOlHWAQyqin2F9u5c1epudpqTL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6geqeTZ8oVqFzJKnxN6Ou9cSnOXfd1QdLC5R6btzXj0=;
 b=iRVGNrnKWi7fAz/tPSANgq3+NUdr2BXG7tq8skjuWq8+CH/moPYvnmZjey9Ezpl6qKKybIJsjSd4F2/IfeozZ9k5si7TR8KN0Lq6cKwny+Qp4cK6+kyr2whZyxA9gHaDGMPFzMzSDUM4fDu37gj+sra4II4Yn0PSZ0FGHLBRjIc=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB7266.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:225::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Sun, 5 Jul
 2026 12:08:54 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Sun, 5 Jul 2026
 12:08:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 13:08:53 +0100
Message-Id: <DJQMJS0C3EDQ.278WBLVP566HU@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Drew Fustini" <fustini@kernel.org>, "Guo Ren"
 <guoren@kernel.org>, "Fu Wei" <wefu@redhat.com>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "Jens Axboe" <axboe@kernel.dk>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <driver-core@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <netdev@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 0/7] rust: Use kernel style vertical imports in various
 drivers
From: "Gary Guo" <gary@garyguo.net>
To: "Guru Das Srinagesh" <linux@gurudas.dev>, "Andrew Lunn" <andrew@lunn.ch>
X-Mailer: aerc 0.21.0
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev> <c89a1bc8-6cc1-4e16-ac95-add389e45a2b@lunn.ch> <akmnh0AKFfu9-OYn@gurudas.dev>
In-Reply-To: <akmnh0AKFfu9-OYn@gurudas.dev>
X-ClientProxiedBy: LO4P265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc16130-6fad-4dd5-d084-08deda8e2efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10070799003|7416014|22082099003|18002099003|4143699003|56012099006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	QihblXpvdEklQsRNqW5pdvrh4cjhymtOwvrUSKJkhXQji/x84dL/C8nM0EymlyR52WUCDwTjlyxAMJ8kFjG/5Ie+nnA16WvQbLSxfIZGz0PIOF7pnN6Kyfbt8vYUL64jlg8LFH3ph49deno3tfqTqwiApzuoSYQJZDDXIciAeonmyMnSxY5hJ+k7D9LaGtJodPPnUKd4NtBH5okovKgm3NKsDXCfEEtNEhJTwVC/X5AEi53N/ekfeIl4v1SnWeUh4yoxa3WirdyqimaCjGzSGXT2mAoiaGkSUNNQTcEbkQJLTA6mSLssAhznFWOj9TYemH0UXjw82Fu5rAlg1gMyJgEHGgerhkzuep9RE/rKTo2akbuyuGKH6vw1pVM7pkkNI8uPuSAh34IxLidBA2OOY6GyiOMBREMy03JVFtzzfaXHfmYQsZspqR1UZeAfQ0/uqP4nsi3gEnXi9yhy1sy8JKJTqt4o/XFuFo5RTet4NH3fuKKgr+aY2zbROLQ8u3YwnaNU+kFrFKANka5Nej3/w+vWc9AV2lnRzVKWplWe90kxiqtMVa5b2gRdnfZWEIJEEv3H/8PQg1pyOH1z7G6j7PMxiTcOA94kCz2vHvc1+xlJOxv5UOqG2/mYFbmkWPJJBFF7P2R5AMRKEaDaME0ZD/e/uPPzd8FL8zavBSDguco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(7416014)(22082099003)(18002099003)(4143699003)(56012099006)(5023799004)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEtFRy85QkZxdkNDVXp5NFA2blRYQk5TRWJQTW1CTFFrRzZqRHhZTSt1b0ox?=
 =?utf-8?B?QnNTa3c5R2p5MXlOUURMTzNCZm9adDlzQkkwdTRGRC9aWDk3MEpiUk9GQ1BB?=
 =?utf-8?B?Z1JmK1lEbTJRanBKVmJBbUFERGpIZlArd3NxYXl5NlZHY3QrdzZZUHoyblll?=
 =?utf-8?B?aHAxTHhWOWw1OUZpYlZZK2FkOXl2NFVJNGU5ak0wQk9oYnRwVmE2T0J1RkJC?=
 =?utf-8?B?UjE2aldZSUV4MFZ6MzVReUZMeGo4dGxzZDdFUzdCSnBXU1RBcVlQMXZHTWUy?=
 =?utf-8?B?dGZPVkRGN3d3S0hHUjJSai9YdmNCbkMwbDR2QlpQcTlCc1V5VFcxVXNCb1F5?=
 =?utf-8?B?TytPUExhcVVwdldQR1cwQ0h6dnRmRXlyalVydUxVU01vYzQxQXdYR1orU3Rj?=
 =?utf-8?B?b3BCbEJlNmtMaWI5YlNZRCtYcVY3S0V4WmJhZFRONVpkK012bDBSd3lnNmZj?=
 =?utf-8?B?aWx5L3kyNExVR0JzVWU3TlBnWVZMdFJPdmpFdGpxYXdMQmZSV3BRWDV4dVlZ?=
 =?utf-8?B?YUVBQXJZYXNWL1NRckkwN21YbzRVWnEyNUU4bUwwb1RUUjlxd2pQUVJqaWRW?=
 =?utf-8?B?R24rc01McUM5MGMyM0htTllnaGxnNlhxQ1k5VndOUVJNQXR0aHdyL3c1T1FX?=
 =?utf-8?B?UUYvTGdrdFBIUGhta2dLTUt3NENOczBla2VWNlVIOGc5S1YwT3RUVDJOT0Rl?=
 =?utf-8?B?Z0dTcldabEtML05vdEZTNVlvTW4xSzQyeVVnYlNrcnZEM0doRnQwem5FMjlo?=
 =?utf-8?B?UEVYYXpDR0VTRVNhczRTQTdzYU9LNHBtVGxIWjhycjR1N21Ic0NFVFdvdXMx?=
 =?utf-8?B?YVJpNnN3TnEwM1VaeVF5enc1Unh3R0tXUHpwcUlSUE00RmhYSzBSTnozejQw?=
 =?utf-8?B?OHUzZ1FnNjFMQnI0ZzBtNG9HaHFab0tQUE9rSWxnTzU1Z1V1TDRKUjduZllO?=
 =?utf-8?B?NjhaL2NWckJwUVNWVC9oblVvNE4vZFFiWTNVQndYc01TOEx1Z0h5M2JMQVJF?=
 =?utf-8?B?bzNTa1p5V1dBVWh4YzgwKzVWRGdTK0w0RjAzalNiYzJmTmdDOWtzSEdFZVZk?=
 =?utf-8?B?cTd1L0R1ZEJjV01YVjlBOXNjT3NQRXVUR1EyWEQ4SmUzc0xkb1NnL0oxbkhW?=
 =?utf-8?B?Tk1WdW1DRjM0NjBCNUJRZDNwSFVpMDAxb2pNZE9LdER6d2h2bG50R3FGaElJ?=
 =?utf-8?B?YzdmUUdIZVc2UVhJWTRKalBkelJkK2dRSUxVd1dmV0JJTFFEeW93OVh0UGFN?=
 =?utf-8?B?NmxuSitiMTJ4MnVCSnZtRno1ZzZYYnRsZUNtZjBYNW4vVmh6ajNvMFlnTnZl?=
 =?utf-8?B?aERPZkNpaFdFejUwRUVwSlZGaDhlZGw2SUgvYTlvNmMyZTdYamRqeEc2NmI2?=
 =?utf-8?B?ZG9vNWM2ZzZYL0RBUUIvanBHSGVjdmxzY3JCc0lYMjFCY2Y0bTBNbkM4ZXpD?=
 =?utf-8?B?aXlidm9iUUc3Szdid0dTc0Q0aTNzK3NXN08zYVA2dTlIUVRaQkUrNlFPVXRD?=
 =?utf-8?B?RHBuN2d1OVVxOUtYTGVhY0xGYjNiQjMvNDkySFFMZHRPRjFmWEFiQ3U4djRn?=
 =?utf-8?B?WHpBSHV1RmRzeXZndnZ6N0REdmZKRzdtc0dNU0ZxYzM4S05yY3o3d1BUd2R1?=
 =?utf-8?B?bnFQNFFlR2ZPQldhK04zNURrOWYxQno4WVlwRE1ndUMzYjc4M3E4d3c2Mjgw?=
 =?utf-8?B?Qk4rN24yYnFqQjQ2WnAzdHdURUY3SSttQVZzTFJLbEhscDlBeGN1Y0JNU3ov?=
 =?utf-8?B?UmozUG9TY29jb0RPN2xZZnIxZjJyWVJmOXZRc29mY3loaHBiai9LWkl6TDRJ?=
 =?utf-8?B?eS9rYXVpNXNCd2FveUY1aE5wd2lnYkJQTjMwRkd5TDBiYklGY1BsVVBlcFcy?=
 =?utf-8?B?bWlPKzVQRWl5NDFGYjBiWjZMbkhNRXVnVjErRTBsY2puSzFFLzRNNjFNN1V3?=
 =?utf-8?B?WGVhRDRoRTEzSUtPamNrNkpIMVBnRnpjaHJud2wzQTYvVDQrTTErc0Y3T2d0?=
 =?utf-8?B?NktkRVFJUVJ6SXc2cGI3a09sMklYV3kyOUI4d1BiblZmMlRFMXJhd3VGOHdv?=
 =?utf-8?B?TUlJRVZoMkc1L2s2R1g4OUx4eVhHWEI1NjZSbUg4a1p3bENmZTlrSHJ6N2pi?=
 =?utf-8?B?OWQ3NXVEUUI1QjZNZkNqVFZLbHd6YnZIWEttdjg5ZkhKcGNkbi9qbGRPWmlk?=
 =?utf-8?B?VGtYWThlTElVTjBJUWdqcG4yQm9nL1lPRGt3YTFkY2REaGtCRml3cmJqa2pj?=
 =?utf-8?B?a2RNUkxLV0JxMmszY0c5Q1Q5NmpkYnNOdHNBVC83YlFaYzM3dzRMYmthcWVH?=
 =?utf-8?B?UjBtUnltUlZEL1Bwc1EvTkZOV3dTRlh3N1lvSDNISlVpaU1jZVZCQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc16130-6fad-4dd5-d084-08deda8e2efc
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 12:08:54.2533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdwnKBPxCCwEeEGzF05qXAmbhqYKudY/Xb6P52svQLtX7DqZrHVHWxwaofl6FWN6ARCYIhokMbHTLyBvf36efg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7266
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
	TAGGED_FROM(0.00)[bounces-9555-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	FORGED_RECIPIENTS(0.00)[m:ojeda@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dakr@kernel.org,m:abdiel.janulgue@gmail.com,m:daniel.almeida@collabora.com,m:robin.murphy@arm.com,m:a.hindborg@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:axboe@kernel.dk,m:fujita.tomonori@gmail.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:driver-core@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-block@vger.kernel.org,m:netdev@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-d
 evel@lists.freedesktop.org,m:linux@gurudas.dev,m:andrew@lunn.ch,m:abdieljanulgue@gmail.com,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,collabora.com,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,onurozkan.dev,redhat.com,samsung.com,linaro.org,kernel.dk,armlinux.org.uk,davemloft.net,ffwll.ch,lists.linux.dev,lists.infradead.org,lists.freedesktop.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:dkim,garyguo.net:mid,gurudas.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15CCF709E98

On Sun Jul 5, 2026 at 1:38 AM BST, Guru Das Srinagesh wrote:
> On Mon, Jun 29, 2026 at 04:06:36PM +0200, Andrew Lunn wrote:
>> On Sun, Jun 28, 2026 at 08:38:14PM -0700, Guru Das Srinagesh wrote:
>> > Came across a recent commit bc58905eb07 ("samples: rust_misc_device: u=
se
>> > vertical import style") and found a few more locations that could
>> > benefit from this cleanup. No functional changes.
>> >=20
>> > Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
>> > ---
>> > Guru Das Srinagesh (7):
>> >       samples: rust_dma: use vertical import style
>> >       pwm: th1520: use vertical import style
>> >       cpufreq: rcpufreq_dt: use vertical import style
>> >       block: rnull: use vertical import style
>> >       net: phy: ax88796b: use vertical import style
>> >       net: phy: qt2025: use vertical import style
>> >       drm/nova: use vertical import style
>>=20
>> You have multiple subsystems here, so you need to split this patch
>> setup, per subsystem, and submit them separately. Maintainers only
>> accept patchsets for their own subsystems.
>>=20
>> For netdev, please take a read of:
>>=20
>> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>>=20
>> You need to get the correct tree, and set the Subject: line correctly.
>>=20
>>     Andrew
>
> Hi Andrew,
>
> Thanks for the feedback.
>
> I was aware of the per-subsystem rule, but reasoned that since these chan=
ges are
> purely about Rust import formatting coding style with no functional impac=
t on any
> subsystem, they might go through the rust-for-linux tree with acks from t=
he
> respective subsystem maintainers. The Rust coding style is independent of=
 any
> subsystem-specific guidelines.

Patches should usually be merged via their usual tree, otherwise you're jus=
t
creating unnecessary merge conflicts.

There are obiviously exceptions to this for series that need to touch multi=
ple
subsystems and cannot be split, but it is not the case for this sort of sma=
ll
cleanups.

Best,
Gary

>
> Is that reasoning off-base, or is the right path to split these out per s=
ubsystem
> regardless?

