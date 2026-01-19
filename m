Return-Path: <linux-pwm+bounces-7938-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676D1D3AF44
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 16:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE226302B751
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266AB38B7AF;
	Mon, 19 Jan 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="UsXWlLaX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021108.outbound.protection.outlook.com [52.101.100.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346C366DDC;
	Mon, 19 Jan 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837011; cv=fail; b=FcmJuamtH7Y2fYyXh+bpYOWXnNSkPCtUOZB5t9lz+C6zouhBbuLZ6OZa3Vd9NczjvwKa+YQGNGe3aHMe3VfCkzYJBXmczklEYKvDw4e9CVuoaHjwHDRND6EYBrzS+TnAomQQTdlGORI9AEVRNNyeCejRo+EXluvlBhgd8Di3z+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837011; c=relaxed/simple;
	bh=hfxTTpq64bKlx+txJe+HjfyuTNxuXmAAfG7AVHuD3Zc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ArByi87bmXTq9n1xeGhsmJdneTsTFwP+24DelkDLNwXJQXorYqh4X6uZ+bbPJ01ric2DVQfCiaSBmv8Ax2PjCJF1mS6HdgBCy0nkE+haVWiTpX6JeX79UzDhjtJNIERxiG0syxLg+M6TI+mLXUN7XT74uI9iwAuYx0Y8G7pvzRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=UsXWlLaX; arc=fail smtp.client-ip=52.101.100.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZCGIyFFZFNqkEpTYjeoYKsq5vzpB7ACwbTOM2lJW6HyGOI6dVT3fR3DMyYLRq9sFbRfqk7CqWwWSlnRd+9c8gLiEht1w9zq3XNDBIw6xYb9YWkXifyLlSN64ppHz5enZuD/ytZ8pHwo4bn1nAUzbB4tmoGn2mCe9KHME4piOI5JJZ060cQR0JDq2z1oEKkqZp2N43XUCPu8lj6wEulx2bpsBDva1Xxmk6uRg9Vqr1MI8bgq+OtGiR6GEiiAK2wrFkUSiOi1jW7kuA6wJKDduc/jhezpSyBKEZNd8h8+spk277Mh9JX7KTl2gaSlOVuOTfffk6sigOadLdBq3vW8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfxTTpq64bKlx+txJe+HjfyuTNxuXmAAfG7AVHuD3Zc=;
 b=EjnzmHK4melpiXuAXyuo8/QyceFUlFs+B5pf966JajnxBK3243mm6MHUdOcN6BdSwQV+dPsXNde1TLgxBUxAHVVxztfn06hptAxe+InCQeJTffOPsuHbSGQf/l9nyRiW0RhsRW8yNGmHyyLkxgleAoIv4XznLu2i1EjB6qAVARl5CIEbLPdMvhsjtPy1v1ruZruB49kC2FDXXtcPNYFFs5E1xsEdAVUm5RT9SY6ibXqFl/m2tlCWMkA8tJ7STzHFfUj0jGRMitdk33rMBpEUhIyrkR3v+wg+TEJBNzmvJtI+JABnsXHbzr19jTDbGPchbQ+qZVDfbKzFeHvP5iKVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfxTTpq64bKlx+txJe+HjfyuTNxuXmAAfG7AVHuD3Zc=;
 b=UsXWlLaXGFN11XxZmyRxi7r1IUfiuAgog58/ogzcMlHiClHXa1wCLmP9H1bkc3CLoJV5Bj6tWK9uf/tpwcepDAUMyKDOAYB/E4eXdA+CNq6UCTBRJhWdJmK82PsjsUzJzTVVmFnY3t49lQjiIwJmhWbSp46qX/6s5DwZ5+KzMF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7448.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:39d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 15:36:45 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 15:36:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 15:36:44 +0000
Message-Id: <DFSODY3NWRBQ.2VGQWXERVW1R1@garyguo.net>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Drew
 Fustini" <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
 <DFSMRQFIYQPO.1A38Y84XZ1GZO@garyguo.net>
 <CANiq72kcRQShDgMJKZ+ekUEdP1T6Jr=4PDiMJCqnQjgCQEK_eA@mail.gmail.com>
In-Reply-To: <CANiq72kcRQShDgMJKZ+ekUEdP1T6Jr=4PDiMJCqnQjgCQEK_eA@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0281.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: c032b048-9b93-4dc6-7961-08de57708d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0JBa2VwZkt4VGpZVEVTWjVCNS9JVXBYaGRjem9rbFhMN1I2MmtUWUVnbUxI?=
 =?utf-8?B?Z3ppR1hxeVR0eEtPUVdLMllRWmxrWGtNTnpETmNSMTRINUVKOHhMUGNQd0RQ?=
 =?utf-8?B?bjFKYm1TSTVHa1hPR2FNOWxkbjBNQnVhOFdBL2xPa0d5VVh3aFR6SkRYdWlI?=
 =?utf-8?B?MUVXWGExY2JqQjAzS0FBMXJ4V081ekhTZ3lYUjJ4NkpVK0gwOEVmUndreWJE?=
 =?utf-8?B?QmRtTkFvZGtWTk02U083Q1d3dEFkeG1xS01mMlByQ0gveWVuekpoa0RoVlNt?=
 =?utf-8?B?TTJIZU4rdzkrdElBYTV4L1drSWE3aTA4anNPSU9OZ3pOMFFFVHZSRitnUUVa?=
 =?utf-8?B?VlhETUl0N3hZS3RiaHFXSVVRSkl3dGczaWFybURIN3Q1Mi9LVVlZWHRZVUQz?=
 =?utf-8?B?b21yOWhPaEVsbE4vSkxFUUxEUk95WFZtR3FXVmZtUENXTGRjSloxVTZpOUZ5?=
 =?utf-8?B?dnJHZXUvTzRjNG4vQnRiaXhXckZQZkRXUUFFSzRaWTg4aWtNc09vTlBsTFF6?=
 =?utf-8?B?bVYxWDNKMXJ1S3YrMEQ4eEVqbFRUbXlIZHdSc2thTUxwL1lyOUFacDA5bkkx?=
 =?utf-8?B?bVd5RFZHZStSTFR4UUgvcjhicFY4U0ZJTXlRbDhSQW54dDlHN3lCbVhlTHZ1?=
 =?utf-8?B?ODVJY0VZKzlHM2ExczVHUFBxemhvWCs1ZmE5d1RWeTV0YXc4UUc4cFZoakFI?=
 =?utf-8?B?bUlwRlpCV0x0akVLSFBMaHBJWHVVcHZsYTFXQ0x1RWlhVk1GaERrVjRFNURq?=
 =?utf-8?B?K2E3ZXk0SWNRd1h4MlFxVUx4WERKRFk4RTJ6Z0JhMDVnZnVRQTZpR2FmUmJB?=
 =?utf-8?B?M2tJcXBzVlp5a2N4YUNZWEJndG1rMlZseGI3VXpnbDVNZWNoOHJYK25BZmRC?=
 =?utf-8?B?Q25Jenc1R3QxcThMcS9IT0ZKdmhtY0gxV3ZhZnNFcFZPejl5R0Q2b0U2WVQr?=
 =?utf-8?B?cm9HVlJKdkRzNnNKTTd0VDBQU1E4Q0xYbUpYRHBQNnF4VG5BL1VpM2hObmFT?=
 =?utf-8?B?Qm52SVBGSHl0dVNVaEZ0RGEwM3FvbUNNUUFMakUxZWFXRmtIK3hNZGhIYlUy?=
 =?utf-8?B?UGw3Nnl0WExvYzcrNDBRaUJPNjc0cnJzVGU3MnQvRllMNGNCbTl2MUVWQVln?=
 =?utf-8?B?cUhqenpoN09veFVmM0NUaDlObVpPZEpUZjZWTlN4VEhoSXAwM0ZaaW4zOHpZ?=
 =?utf-8?B?NFh2cTBKeFJYcmVOL01HdVo2UjU5UVFnbWkzZE5JYzFVQmtrdDNVTUlLdlF1?=
 =?utf-8?B?Uk8wTTRkdjlmbCtnQngxYlYycGJTTlZ5aThSU0J4S1JQYmdUMk9xN0ZZS29N?=
 =?utf-8?B?Z2RTcHJUUzNiVUE5MHZ1SmdQWk9sYW9oa2FNTkdSVGZjeFBCcmp4Zjk2am1M?=
 =?utf-8?B?MVFxV0YrUnJKTWJaUVpFNzhFVTBuSHdWMXlQRUpZdjNiWElYTk43Q3JHOHN4?=
 =?utf-8?B?bVVYcEozN1VlRHBmMUVLb2R3NFlUY0Y3cTVFVm5kaHpnUS9pbFd2ZXhWVkow?=
 =?utf-8?B?ZGUzSkpXdDQ3ZWVYNmZyMGR2am1EQW9YcThqRG56c3p1bE42b1piWmNZOE1G?=
 =?utf-8?B?cHVTTks2eDJkZHZ0YjZwUUNxNmQ4UTQvL0FXSzEvTStkZ2V5VUl6ZkhwTHgr?=
 =?utf-8?B?N2RpL2xaaVBGcWU0OUJsZzNVQkpDWTU2TXd1MkxwL0JUMnVHaVNkZGRua1N5?=
 =?utf-8?B?VG5kZGdQcG1kQm1Bd2RUaUplek1ib1EvR053MjAxZjAvcldLNjJFU3RFWnda?=
 =?utf-8?B?VzYyZzh5M2t6cktjNU5DTEtaVURrWVBsdU9PVXNKYnJSU3UzZzlJZnZUbFhp?=
 =?utf-8?B?ZWNabkIwcnRibW4vZWVwZGp0VFdGMmE4NTNJNE5ncmd1b3FTYVA3ZnBNdURz?=
 =?utf-8?B?M1h6Z3Z1a0xZU0lyak1jWGlFemxxSXkyUlV1clFFSGxsSkl4elhPb29TcjhZ?=
 =?utf-8?B?Y3BtN1NyM1NQejc4SlRjMmR6S094NUZZZENRRkVETzgxeGpDVFFtenJ0blll?=
 =?utf-8?B?NVBic1RlZXg3ejRqM3k5Y0hoVllwYUpkZVkrYi9CYzFjaE5XQ1RCVys3UWZS?=
 =?utf-8?B?RjBQVjl5aE80UUFUZ1BvRTNhOXFWdUxJN1c1NXBMVHhLUVFobFo4cTBPUDBC?=
 =?utf-8?Q?pJqU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b21vVk12V2VWV0s3MkphL3JJc1pVd1cxN3h5TzFzb2lEVCtRQVFPOVJxK2FT?=
 =?utf-8?B?bWlmYlpmUFhMOW1DZ1hTREJYNzdpZUZkaXdoN2pud1RFY3duRTZ4Tm4weG56?=
 =?utf-8?B?MVJZY1hYZ29LRHphb2tNakpxQVk4RWJMSDcxckJ1ZC9kL3h3dFQ5b1RSZGNW?=
 =?utf-8?B?SGhkcDlLUWEvMHltaXJQUlZOTXNBeGdtMms5Wm5CUHlaY0xnNkJSNXZLbVY1?=
 =?utf-8?B?NUNJMGVJa0VsT1dOWlJ3WHFVckVFZ0NaTHNyczM3c2QwSGNzWGNuM1ZwR1FC?=
 =?utf-8?B?UVk2cVF3UE11bW1nUUY0UkZHdDJ6UWo3ckRaLzB4Wm1leUFnSExUcm4xVXJ0?=
 =?utf-8?B?b3ZpSzBLUHh3djM5ZTM3UkZBOUxBQ25Ib3VKRjhsTUdUU0F0UXA2dzRPc3Ba?=
 =?utf-8?B?UUV1c1Z2V3JOLzcxTGo3UldFSjBUNnFxVitMdnEzZjNvRTc5elJFd2dZcWo1?=
 =?utf-8?B?VFR1blphblVoR0RseVhyN0wyVFZOVUN5L2xvL2lodnQxQS9nZitIRnp5ODRs?=
 =?utf-8?B?TUEyRDJsN0ZmaDN4Z1krVmNpalZHTGNVU1JXM21EbFZPZVllVnIwMlhqd0o1?=
 =?utf-8?B?bUJ1azJ5cWhuTEFFL0xLWFBpTHMwWW1NdDlNRG9nOVU5dUErZmxmbmtXMWVR?=
 =?utf-8?B?blRlRlVvMFdBYWFJTjFyU0Y2VlRVRVV0SmJTTFBrdjl4R1hocFo5L04yNCto?=
 =?utf-8?B?aWZCWlRDZHVsenNUY05hSWZZMGNCWUtjZEFKZzd2QUdpODJxWHlYS1BmU2FR?=
 =?utf-8?B?YWVYakIzK0tkYjZZZzRkTzRmQldTak02VWRUMWIyQTdEa0ZaNmsxZlVrVUUr?=
 =?utf-8?B?UEtJT25halYvb20wZm1BbWpsSUFOYnl2N252RXdJMWw4c1h6ajBoR2JHTFVm?=
 =?utf-8?B?cTE5aUxzVGlpdWJwUXV4aElpcEk0dlBSeFN1Q1hUa1RHMnFqc3dGSTJ5OWNp?=
 =?utf-8?B?M1B2MElUSnFKR253dTlFdC8vMnpiVWt6T2tkUEZTNzdmMUtLT3V1SXJKQ09o?=
 =?utf-8?B?cG9ubWFDbXZMa3U4Yzl2NnFZNTFPZUNKTkRhVlBxVHVaeWtuZVB1elpFTU92?=
 =?utf-8?B?WksyY1FNV05xRWd5Q25ONlgwdzdFMXl1Nm4rT3hNNUhGdW1BbDRUZUNDdkJy?=
 =?utf-8?B?U0pNaGhpdXpaMmxHL1piTWtZL1pXQitka1p1K0dPdTJ4aHkrSnhjdlJTLytR?=
 =?utf-8?B?YXJJeE5NTklibm1hZ1kzWHA2UTRGQVdhVWNZbEIwR2N6aFlKa3Z1b0pmUnpo?=
 =?utf-8?B?ZGhzTnNXR096RW55R1VBV0p6VEs2VUR1WUcwU2VHVU0rS1R3V0JneE94Wmh5?=
 =?utf-8?B?MHRRc0wxRnE5elJqN1lvdTFTbWFPZ2lDbTBvUjJnaGgzZTVzZWNjWUNpSmhX?=
 =?utf-8?B?Z3hwMlg0VTdwOGg1QWpMMnczbzJWUlg3SmFPeTFnQndVaTYzN1c0bkRHMHk3?=
 =?utf-8?B?VktZYjdDaWJ0WEgyUG92VHN1b0FMUHZmSXkyK2trYlJuaHFpdXJJMXNzSXpT?=
 =?utf-8?B?eEhSSmFEM1ZsQ2NOaTlQYUoxT2J6aUFTOFFSU0lxc0JHaDFBaFdYTXFLWTgz?=
 =?utf-8?B?K3VGN0dpdlRneDVLRWpqMk1kRHVvQ3FIZWI1UndtQlZyWUtSUU16WUpCS2ZH?=
 =?utf-8?B?UUd6S3R6WmQxbkh4MS92MDRlL3NEWDBVS2lMMjlMQll6MW80Mzd2andxaWxs?=
 =?utf-8?B?dlRZcitzcXZTS2UwU0hZYVU5dXFrZmQvSjJnbDZaUlBnRDZNTkpISDExbU9z?=
 =?utf-8?B?d3lPMm5PRjB3aUFmamVHN0pJRTZDTUsrcms2c0YxeEo2azdzNGlYZUY5NThl?=
 =?utf-8?B?eWlTcmErSkVSZjl6cU9qSGZKdWVjWHlVUlIxTjhkK2xGcG1rVmJsYkdLNk9N?=
 =?utf-8?B?S0d0cjAyRGljNG9KZHkxMDM3R0RnZVB2OXRYUXNZR1IxOW1FSkgwUVlUR0dk?=
 =?utf-8?B?U2Q3eHIxekdyN3U1Mzg5TmppSHA4UTZzVGtiV3pzbzU2Y3B6MFlWM295TlY5?=
 =?utf-8?B?QWx6dG04VFNzZGxKNkJQTFpBS2o0a3IzUkxnTWwvOENiRWRTdENNUW1TeWZF?=
 =?utf-8?B?dGxkT2FTUEpXcjA5YjB1QzNHMDlURHduUWcycmNPcjVucDZaZmJlajVuU2xS?=
 =?utf-8?B?YlN1VEVNYVU3Qzh6ZEtMOHFIOU1TcUs0bkRsbXpETDVIRDVQd2YyamxYRE02?=
 =?utf-8?B?NHQzNm8xWDd5QklXQktQMmV3dDRlWUhOZ0lDNFFxdENlcENXb0N3bUMrSHlm?=
 =?utf-8?B?MkVvQ2grbFgreC9ISEx3elVGeUNoZlNDTjQrNmxsVFA5WGptRmVJNGFpWHpV?=
 =?utf-8?B?b3JJQ1pQSVVueHRvZGlzQTJaaTJKSHZaeEVVVlRoeHNWdmpKazFOZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c032b048-9b93-4dc6-7961-08de57708d8e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 15:36:45.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ik7O8NKdQT1xTa7sW2k6TOzhgUOPYLbUyuWvRaMfctiYotVMA8/TDRRy5dioqkSTIUtuuU3hJuT/5HYLcw910A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7448

On Mon Jan 19, 2026 at 3:22 PM GMT, Miguel Ojeda wrote:
> On Mon, Jan 19, 2026 at 3:20=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
>>
>> I guess it's time for me to work on a `#[sealed]` macro...
>
> ...and perhaps pinging upstream for the language feature... :) I added
> https://github.com/rust-lang/rust/issues/105077 to our usual list of
> wishes at https://github.com/Rust-for-Linux/linux/issues/354.
>
> Do you think using the linked crate in the commit message would make
> sense? It seems to be a couple pages of code, using `syn` 2.0, which
> should be fine now.

Which crate are you talking about? I can't find a linked crate in the issue=
.

Best,
Gary

>
> Another option is a "good first issue" of medium difficulty if you wish.
>
>> I wonder if it makes sense to add a general `ErrorWith` type for errors =
that
>> carries error code + data.
>
> Sounds reasonable...
>
> Cheers,
> Miguel


