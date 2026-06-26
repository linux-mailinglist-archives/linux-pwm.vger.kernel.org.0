Return-Path: <linux-pwm+bounces-9410-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HL+9OhGRPmqUIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9410-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:47:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 178146CE1BA
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:47:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=YlHCfQXh;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9410-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9410-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F202D3033039
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73143FB7FC;
	Fri, 26 Jun 2026 14:45:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020079.outbound.protection.outlook.com [52.101.196.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB13FA5EC;
	Fri, 26 Jun 2026 14:45:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485141; cv=fail; b=o1xpOKah3lzPuausfG7qEQj4F0Fq1vv4Fg7zwwhQUTlsTn+76M6IS5jdP0WyTK403noDNUiyBJyyGDH4w4Zyx1/F9lLoFM6RVNbFna/jXIfz3ipkLVUnwOUtly4ylLvGlU1IOQJ7iCpXGvAiD/umsS4yEljaYQxhA/LPnLWIsyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485141; c=relaxed/simple;
	bh=F5bGCqFkVx5u0fZSyaG/xN6wOWqT7osen1PoYUXenCc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ukUmLOSFh5p2dX2pNmNnW28jjIx124Uptv9wmUyvAexNE2v2oP+j9decPlBkM04wDvlR8qEuh8PgJtvh12Px/p8DRUJj8YqoBosWBAgRILzFsJMfaNwUddYryx60ARs0t2RVMNa8gS/olb7JApVpvitzv95fQPAybFsN2xc4E7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=YlHCfQXh; arc=fail smtp.client-ip=52.101.196.79
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFf1Pug2qeeDQa8LE20s+rHfTmkzoM6lq6IW7Pv/JtsaCAcm73uY1Unzf6ns0OFzm0aKNswMqUj1xHpCtb0ztFoRB5TIyRsJhyGeQkVdzruMLkZDVbBCWEXAy2MArNOZEz7XllQcjYAFhAW1UEv8x+7EuTarGwh22oFRGrz/EOqd20Rv0QPW1qlLA6/iNR50Y5WKRcKRfJ5/DicJ2X3HDVuTC85MjMhgBaXXEc21QNwdramCii+cTT3pLVkupokhc1v2yAEBwVUr7mu3FxXcxTjpe6X0wdHiNx6C5yd+CEvk2vv16SvqY1kl5BuTzne+skFvRHoRm8mJEUwWgNgppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mexKlJxPHt69pUM8edn80nNxxWqmpkg22miiWh9UYI=;
 b=jqTFAYsya6DHRiFd7iulHrtmrAiCgRvKaAtiMc20jyyIV4DVNSqr8UPPfTjfqsu4f8AfdSCsrpkJyFtlIO0Kxsc/QA0NA/B8OALiB0zBm6XT4MHISBOr04TYlh9woYYI/Fqzo7rwglB9UDaBi2+hoFnzJ6WMe+ys9nVYkRK3whbg2XnfgvMebJV4th0/WVovQ1rsL1tpVYQm8u9BlZsp2JJqucoIjVN95viW+Eab8ogHsXAln7kTq9KoFJyezNv0JPlcYxewAzdCE3ztzejBLUI4sUF7x9cwelmpAauOrT7lGsHsPTpyOuiw0J+Fj7oZSzL8GHZJkLblAh3lV/eqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mexKlJxPHt69pUM8edn80nNxxWqmpkg22miiWh9UYI=;
 b=YlHCfQXh9AF1IxJkVb+SH+4m/dcjzEBjWMaTVT0mgJ7AxTcWTRIDZRafQZi6yYlzyaFX15lDNyDkmDbzLXJ6YY6x0AAnP7gMLj7JoQvooUz+Zwg/3fD0fFN/nJ+BjMcfjYBCFnee4qNmvBZ89+xXutPqFexhKfHgmnRRXSbL9tU=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7248.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:19 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:19 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:08 +0100
Subject: [PATCH v5 04/20] rust: io: implement `Io` on reference types
 instead
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-4-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=16372;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=F5bGCqFkVx5u0fZSyaG/xN6wOWqT7osen1PoYUXenCc=;
 b=BjIGH7ZDHTzcWZ7jJpv4mKm0lR8DwsLpLyomavk9eykXd8DiiMSLr6SyRLAAqFIbcGyT5zOoz
 aJCVeMWNB/WBRVzpA0GOtSwZZyLOjl+cbn4QEnGqGngNg8FlQnbN0Ta
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
X-MS-Office365-Filtering-Correlation-Id: d8806832-a903-4625-d5e8-08ded3918b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|7416014|18002099003|22082099003|921020|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	3PMRDXV/NfS3YWTXaT66m+9et5Y7Vd4UcDlEM9C40JD4hvbYEOjL/juPQpJbd40GFyQFLbkLk71WBddT4gUEIfK2yBPtb6UD8lLzvPbWwnBLM6jkieb26yBi+zmbRrgeLn9TDk9FW+NczVPp5YezCihqvNIxq35snAYArEfDgs6CeJq3MeIpLZzfrs1wsXFBPy+N8gDrp/hUF0uktM2TcxWW6Sl8T9mOUOnFpRW6iw5GRPb9igK09VzhkZcjazlXAowxLXQH5tyHXXXHFpBXJWYsWMJw7KpUzuTCPrN3LXIQXGDYMfRcG1vHBaykW3bBSBSJ98lN0VLNiP1rBV6uaXcmY/stwxWhBZVQnKauGFfIm2TmL88YoxwJR0dIRhaABcX6jAbijiEPotKOtxFtyoZtFZ0gkql5JBGUiF3t4Bk5JXh3Wr+KEc9wDp9PI0UlMjdod/VGpUSTjvLe8MH65sBWDDHP2Bz6cXI92y2tKkh5pUleHnROrvy0IJ9rG0LASys0l1m2iJO9Gjl4mbookDzbetRLBfNxbrFm6PatLvznDKsFawkHXC2YbsqHesupQylR5dV7Sl151IEYNtvmhiDrpD5V2ZnrMvBB2drIOBR1mEMN1DmwDo+92UY0Wu4oTVEYP+XSqEzYV3P3UyX/K9jfaELKnJh3oN7kEQcBgMqDNDgqIbE+VuZv2xmXojUAvB2mqqtyQR6XyYp2BQAWDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(7416014)(18002099003)(22082099003)(921020)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTlQdEdxZ1g1Y3JkWlM2WFo1em9QT095SXpna2QzVFR1UWJwcFhTUUJ0bDdw?=
 =?utf-8?B?czZMQ25FcTA0M1N1TVE3TDJxMENrSTVLS0kyRVVBeFV5ZmtNMW9wMmIyNzhj?=
 =?utf-8?B?T3dmb29sa0NycC9RN2lPVUVaa1ZnRzltVVVJU2VlSkJOcmErQmpScFFGenhV?=
 =?utf-8?B?SzFMR2Nxd2pJKzNaT1lGU3l2VTZmbTFieFJkUWJ1T3VlektUZFMzRDVESHpj?=
 =?utf-8?B?L0hYd3dZOGlJRkIwcFRucGs3cnZiSUFRK1ppcGxQTlBZUFFVUXpYV2s0d2l4?=
 =?utf-8?B?cEliTmJjYm5HVk9oVjg5Z1R5RVNVNUVQVXdtdHVCdklIVkpXVDV0VllTSWtP?=
 =?utf-8?B?aUFQMjdZbVMrb2V0cnk1MmV3WlZhUmYzWlU3VkVNc0dkQ21QM01qeEVwdFVI?=
 =?utf-8?B?UTk4OW1iaGJ5Q2NCWmdqWmFMOVViS2d2bTdEWlQzYjAyOVVWTmVleTJsazEx?=
 =?utf-8?B?bFRCcHNhRXdub01Va1RaSTlGdnJBSmlZQm8xQWluNjNUeTVYUkNPUU1QQjNM?=
 =?utf-8?B?cXorZXJEMzZ4WU5KQ1lkOU5PNzdOSnpoUzJOUnpQN255UmlLYUxTOXQ5bUw2?=
 =?utf-8?B?Rmw5cVVPM1BqWVVOTDR3VllwNU1UTVVkK0o5eTZoMlEzTUNUZ014NUFHbmVn?=
 =?utf-8?B?UUtKaExERFdLN2pEUno5ME9ZVWdueWpveEtYb3R5TGg2b3ViWmt4NmtMWklw?=
 =?utf-8?B?VGdtdXp4WVZzTXYwOFpMNzF5S3VKR05WU1NFYTFXbWFUUEtRVnlpc1dQOU1Z?=
 =?utf-8?B?c3lLbjJWQVVjcEJpeTJ4ajBtelBDRFdCZXFTTFA5alNxdXlSZU9mbkRvOE1X?=
 =?utf-8?B?ZVU2M2ZUUDB3d084d0RmZXR1Z1VqZVhDZ255VVVJU3VraWVpU3Q4ZDk0SXY1?=
 =?utf-8?B?OHhHZVVqSGl0bWh0NXNONDJqNjl4dUY0YUdXOGphMnJzU3lxMFZYY2R3d29o?=
 =?utf-8?B?YjZwbnJiQTIwYklKdmsvTXRhKzdKVnEyekJ3Q0l1MDR3bVR5QkVUVnNNMjRW?=
 =?utf-8?B?U3ZwNzhPNXVkTlhNS3hiMU9jeHFqUUJHRzAzRTYxcXJJT2RXN3hxVENJZE1o?=
 =?utf-8?B?Vmc2aW52WUpUUUM1YXRkekZkVWNaNnpzY05vK2JZNHFlSDVweStrTi9YL0Z4?=
 =?utf-8?B?U0pCaTk1VlNvb01jL0poLzJZS2xpaXIraVFMNUVuL0ZwOEMrQml3Ty95aU5Z?=
 =?utf-8?B?NU5KL3c1TmVYcDVxZUdLb3A2T3ZhSW1JbVlVUFMyMHo1MzMxSEZnNSs1cFcv?=
 =?utf-8?B?VThUNytJUDVOUGQvZk5ibUdVM0phSktsS2hPZCt3QTFpUVJseUt4RS91RjR3?=
 =?utf-8?B?UzdrN09lRjNNaCs4U2FDSC9HNWppaGhIejZLRnM5Y2pNZm1BeEVlbC9Fd0RO?=
 =?utf-8?B?WlZrU01Wa3BTUE5PSkJBYXA2MVBheFMxbmIwNCthTjBuckRYNTR3SUNKQTdY?=
 =?utf-8?B?TWhzRnVyaStneFVJdGEvVGZ2N3Z1alE4bEtFMTNWdThQOWJDUFBzRDFBaExr?=
 =?utf-8?B?U0Z3ZHhkaU1CcHI0eTc1V25VZ0REeCsweTFkWndvYXdZb1B3cnlCcC9XRjZK?=
 =?utf-8?B?YVNmZHJWUTBLS0lkRGgwRW1WY0d1cXNwZERsOUJxY3FHS3YvcVhEczFLRkhP?=
 =?utf-8?B?M1ZCQmNPS0dxSDJzOFdMakxIeTZsSGxDNVpFN2cwT0dUWm0xWlpLbDJ3S2pS?=
 =?utf-8?B?UDhFRmJPVnpLcG9KVER3N01xQXBKSnBReEtoMDM4enluYzNaWXFLSHRoK2dm?=
 =?utf-8?B?bTd2aHZ5b0x0SnVBOU5MK0RRbmFlTWtzMTQzMmlTUWkzeXlWbnF2WC8yK3ZH?=
 =?utf-8?B?MGMxSEJiemRoV253NUxCdjB5aHRDWlp6YXpQVzZOakQybnpnaEczR1NZTXZj?=
 =?utf-8?B?UWhxKzdQNXNMRXVDZjVaa0RTVnFUKy9EYTZqZzFMa2JQVHBSRlRYcDZaTUlj?=
 =?utf-8?B?ZmtPWUF6NzFMRVlLbGJmS3pMVmJ2K0ROWTB6ZUZHLzVQM0dsaThMSjhWT0U4?=
 =?utf-8?B?amY1dFVUVkwzTFhhWnV2M0FoOXMyZjZMUCtEWndTd096TXZjTStVdXlZWURx?=
 =?utf-8?B?Y3FNRE5iUTk4c0VNbUp0VkNEZ3JLU2tBSUg3OXZ0c2lvQXF5aVdVMVJxZ0pm?=
 =?utf-8?B?Wkc5b0lXSkVwSk9pMUJNN3FkNk9qOU0xNE04dkhBbFZnakQwdUU0SlRVaW9o?=
 =?utf-8?B?QTVpaUhSUk82Wm5Ob2RkVHBWRkMrOW8vVDFoMVRQN0dCc0FJTWpBMGR5dGw1?=
 =?utf-8?B?WEhjeE5pMW5OaThmaHFScmNQa0FYRG9WNGE5Yy9BS3J5ZnByMWhWaUg2K2NN?=
 =?utf-8?B?elNrMUpLK1NTQU1Tdk43QUZtd05OdG12RlJ4VWZjeVk0NXNZTEVHZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d8806832-a903-4625-d5e8-08ded3918b21
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:19.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlG2k0BDF67BzZ8Jwx4U9bT6hmGe+/kZnVnYkKfv7RGyG8W2wcgP5RVHCypCvl55HENo50N/vu80Mxp5UY6mUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7248
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9410-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 178146CE1BA

Currently, `Io` is implemented on owned I/O objects (e.g. `Bar`). This is
going to change with I/O projections, as then `Io` needs to work both for
owned objects and views of them. Views are themselves reference-like
(however they obviously cannot be references, because they belong to a
different address space).

To facilitate the change, change `Io` to be implemented on reference types
for the owned I/O objects, and make methods take `self` instead of `&self`.
When I/O views are implemented, we can then naturally implement `Io` for
these objects.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs     | 82 ++++++++++++++++++++++++++-------------------------
 rust/kernel/pci/io.rs | 12 ++++----
 2 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 87141eb07056..9f060dd29182 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -223,7 +223,7 @@ pub trait IoCapable<T> {
     ///
     /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
     /// - `address` must be aligned.
-    unsafe fn io_read(&self, address: usize) -> T;
+    unsafe fn io_read(self, address: usize) -> T;
 
     /// Performs an I/O write of `value` at `address`.
     ///
@@ -231,7 +231,7 @@ pub trait IoCapable<T> {
     ///
     /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
     /// - `address` must be aligned.
-    unsafe fn io_write(&self, value: T, address: usize);
+    unsafe fn io_write(self, value: T, address: usize);
 }
 
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
@@ -294,25 +294,27 @@ fn offset(self) -> usize {
 /// Which I/O methods are available depends on which [`IoCapable<T>`] traits
 /// are implemented for the type.
 ///
+/// This should be implemented on cheaply copyable handles, such as references or view types.
+///
 /// # Examples
 ///
 /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
 /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
-pub trait Io {
+pub trait Io: Copy {
     /// Type of this I/O region. For untyped regions, [`Region`] can be used.
     type Target: ?Sized + KnownSize;
 
     /// Returns the base address of this mapping.
-    fn addr(&self) -> usize;
+    fn addr(self) -> usize;
 
     /// Returns the maximum size of this mapping.
-    fn maxsize(&self) -> usize;
+    fn maxsize(self) -> usize;
 
     /// Returns the absolute I/O address for a given `offset`,
     /// performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
-    fn io_addr_assert<U>(&self, offset: usize) -> usize {
+    fn io_addr_assert<U>(self, offset: usize) -> usize {
         // We cannot check alignment with `offset_valid` using `self.addr()`. So set 0 for it and
         // ensure alignment by checking that the alignment of `U` is smaller or equal to the
         // alignment of `Self::Target`.
@@ -325,7 +327,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
     /// Returns the absolute I/O address for a given `offset`,
     /// performing runtime bound checks.
     #[inline]
-    fn io_addr<U>(&self, offset: usize) -> Result<usize> {
+    fn io_addr<U>(self, offset: usize) -> Result<usize> {
         if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
             return Err(EINVAL);
         }
@@ -337,7 +339,7 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
 
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read8(&self, offset: usize) -> Result<u8>
+    fn try_read8(self, offset: usize) -> Result<u8>
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -347,7 +349,7 @@ fn try_read8(&self, offset: usize) -> Result<u8>
 
     /// Fallible 16-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read16(&self, offset: usize) -> Result<u16>
+    fn try_read16(self, offset: usize) -> Result<u16>
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -357,7 +359,7 @@ fn try_read16(&self, offset: usize) -> Result<u16>
 
     /// Fallible 32-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read32(&self, offset: usize) -> Result<u32>
+    fn try_read32(self, offset: usize) -> Result<u32>
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -367,7 +369,7 @@ fn try_read32(&self, offset: usize) -> Result<u32>
 
     /// Fallible 64-bit read with runtime bounds check.
     #[inline(always)]
-    fn try_read64(&self, offset: usize) -> Result<u64>
+    fn try_read64(self, offset: usize) -> Result<u64>
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -377,7 +379,7 @@ fn try_read64(&self, offset: usize) -> Result<u64>
 
     /// Fallible 8-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write8(&self, value: u8, offset: usize) -> Result
+    fn try_write8(self, value: u8, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -387,7 +389,7 @@ fn try_write8(&self, value: u8, offset: usize) -> Result
 
     /// Fallible 16-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write16(&self, value: u16, offset: usize) -> Result
+    fn try_write16(self, value: u16, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -397,7 +399,7 @@ fn try_write16(&self, value: u16, offset: usize) -> Result
 
     /// Fallible 32-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write32(&self, value: u32, offset: usize) -> Result
+    fn try_write32(self, value: u32, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -407,7 +409,7 @@ fn try_write32(&self, value: u32, offset: usize) -> Result
 
     /// Fallible 64-bit write with runtime bounds check.
     #[inline(always)]
-    fn try_write64(&self, value: u64, offset: usize) -> Result
+    fn try_write64(self, value: u64, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -417,7 +419,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
 
     /// Infallible 8-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read8(&self, offset: usize) -> u8
+    fn read8(self, offset: usize) -> u8
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -427,7 +429,7 @@ fn read8(&self, offset: usize) -> u8
 
     /// Infallible 16-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read16(&self, offset: usize) -> u16
+    fn read16(self, offset: usize) -> u16
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -437,7 +439,7 @@ fn read16(&self, offset: usize) -> u16
 
     /// Infallible 32-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read32(&self, offset: usize) -> u32
+    fn read32(self, offset: usize) -> u32
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -447,7 +449,7 @@ fn read32(&self, offset: usize) -> u32
 
     /// Infallible 64-bit read with compile-time bounds check.
     #[inline(always)]
-    fn read64(&self, offset: usize) -> u64
+    fn read64(self, offset: usize) -> u64
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -457,7 +459,7 @@ fn read64(&self, offset: usize) -> u64
 
     /// Infallible 8-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write8(&self, value: u8, offset: usize)
+    fn write8(self, value: u8, offset: usize)
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
@@ -467,7 +469,7 @@ fn write8(&self, value: u8, offset: usize)
 
     /// Infallible 16-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write16(&self, value: u16, offset: usize)
+    fn write16(self, value: u16, offset: usize)
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
@@ -477,7 +479,7 @@ fn write16(&self, value: u16, offset: usize)
 
     /// Infallible 32-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write32(&self, value: u32, offset: usize)
+    fn write32(self, value: u32, offset: usize)
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
@@ -487,7 +489,7 @@ fn write32(&self, value: u32, offset: usize)
 
     /// Infallible 64-bit write with compile-time bounds check.
     #[inline(always)]
-    fn write64(&self, value: u64, offset: usize)
+    fn write64(self, value: u64, offset: usize)
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
@@ -518,7 +520,7 @@ fn write64(&self, value: u64, offset: usize)
     /// }
     /// ```
     #[inline(always)]
-    fn try_read<T, L>(&self, location: L) -> Result<T>
+    fn try_read<T, L>(self, location: L) -> Result<T>
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -552,7 +554,7 @@ fn try_read<T, L>(&self, location: L) -> Result<T>
     /// }
     /// ```
     #[inline(always)]
-    fn try_write<T, L>(&self, location: L, value: T) -> Result
+    fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -598,7 +600,7 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     /// }
     /// ```
     #[inline(always)]
-    fn try_write_reg<T, L, V>(&self, value: V) -> Result
+    fn try_write_reg<T, L, V>(self, value: V) -> Result
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
@@ -631,7 +633,7 @@ fn try_write_reg<T, L, V>(&self, value: V) -> Result
     /// }
     /// ```
     #[inline(always)]
-    fn try_update<T, L, F>(&self, location: L, f: F) -> Result
+    fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -670,7 +672,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     /// }
     /// ```
     #[inline(always)]
-    fn read<T, L>(&self, location: L) -> T
+    fn read<T, L>(self, location: L) -> T
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -702,7 +704,7 @@ fn read<T, L>(&self, location: L) -> T
     /// }
     /// ```
     #[inline(always)]
-    fn write<T, L>(&self, location: L, value: T)
+    fn write<T, L>(self, location: L, value: T)
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -745,7 +747,7 @@ fn write<T, L>(&self, location: L, value: T)
     /// }
     /// ```
     #[inline(always)]
-    fn write_reg<T, L, V>(&self, value: V)
+    fn write_reg<T, L, V>(self, value: V)
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
@@ -778,7 +780,7 @@ fn write_reg<T, L, V>(&self, value: V)
     /// }
     /// ```
     #[inline(always)]
-    fn update<T, L, F>(&self, location: L, f: F)
+    fn update<T, L, F>(self, location: L, f: F)
     where
         L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
@@ -799,13 +801,13 @@ fn update<T, L, F>(&self, location: L, f: F)
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
         $(#[$attr])*
-        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
-            unsafe fn io_read(&self, address: usize) -> $ty {
+        impl<const SIZE: usize> IoCapable<$ty> for &$mmio<SIZE> {
+            unsafe fn io_read(self, address: usize) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$read_fn(address as *const c_void) }
             }
 
-            unsafe fn io_write(&self, value: $ty, address: usize) {
+            unsafe fn io_write(self, value: $ty, address: usize) {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$write_fn(value, address as *mut c_void) }
             }
@@ -826,18 +828,18 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
     writeq
 );
 
-impl<const SIZE: usize> Io for Mmio<SIZE> {
+impl<'a, const SIZE: usize> Io for &'a Mmio<SIZE> {
     type Target = Region<SIZE>;
 
     /// Returns the base address of this mapping.
     #[inline]
-    fn addr(&self) -> usize {
+    fn addr(self) -> usize {
         self.0.addr()
     }
 
     /// Returns the maximum size of this mapping.
     #[inline]
-    fn maxsize(&self) -> usize {
+    fn maxsize(self) -> usize {
         self.0.maxsize()
     }
 }
@@ -864,16 +866,16 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
 #[repr(transparent)]
 pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
 
-impl<const SIZE: usize> Io for RelaxedMmio<SIZE> {
+impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
     type Target = Region<SIZE>;
 
     #[inline]
-    fn addr(&self) -> usize {
+    fn addr(self) -> usize {
         self.0.addr()
     }
 
     #[inline]
-    fn maxsize(&self) -> usize {
+    fn maxsize(self) -> usize {
         self.0.maxsize()
     }
 }
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index b4996aa059d8..505305cd9b86 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -79,8 +79,8 @@ pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind = Extended> {
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
-            unsafe fn io_read(&self, address: usize) -> $ty {
+        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for &ConfigSpace<'a, S> {
+            unsafe fn io_read(self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
                 // Return value from C function is ignored in infallible accessors.
@@ -94,7 +94,7 @@ unsafe fn io_read(&self, address: usize) -> $ty {
                 val
             }
 
-            unsafe fn io_write(&self, value: $ty, address: usize) {
+            unsafe fn io_write(self, value: $ty, address: usize) {
                 // Return value from C function is ignored in infallible accessors.
                 let _ret =
                     // SAFETY: By the type invariant `self.pdev` is a valid address.
@@ -112,18 +112,18 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ?Sized + ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+impl<'a, S: ?Sized + ConfigSpaceKind> Io for &ConfigSpace<'a, S> {
     type Target = S;
 
     /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
-    fn addr(&self) -> usize {
+    fn addr(self) -> usize {
         0
     }
 
     /// Returns the maximum size of the configuration space.
     #[inline]
-    fn maxsize(&self) -> usize {
+    fn maxsize(self) -> usize {
         self.pdev.cfg_size().into_raw()
     }
 }

-- 
2.54.0


