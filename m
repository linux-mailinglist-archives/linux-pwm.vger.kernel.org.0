Return-Path: <linux-pwm+bounces-9325-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R+OIAecmNGoNQAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9325-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:12:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 532526A1D82
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:12:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=N5zWYl5u;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9325-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9325-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92A523039838
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96E7372EC0;
	Thu, 18 Jun 2026 17:04:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022084.outbound.protection.outlook.com [52.101.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235435E1C9;
	Thu, 18 Jun 2026 17:04:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802298; cv=fail; b=bVpP+K7xcAXZ4HcnQNxVHAKZOP/Wd14yOQF/YCBElf0ZJDPe/j6Kh8MTcL90fuCwhl0WdzngFvpdu6iCt1RPFZWudImKFiqClTQAWIs8kaRuSQ+nyo6w6y01lkdvfb/PjCIGv3aG9OjzGxZt3tQB/6fNZ0i0SstF8vvSGOGJ4SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802298; c=relaxed/simple;
	bh=19D8zkw/7Jzd3PcOqF0M0UfH+xDRZR0zkltVMaRe0mw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JygyhRVo+2Sa3u3ICnkJeRbpWzerZhVMPN/pjF3Dpmwm3tQD0JAWzk1ZpE1jAuy26yxkTa9Mtt5LV5wWKtroA/+13LYEGwTMM5WbwDgg1SF/6J2LycDzFo/AAArj9HoCKHSk/9i/muUbJU/tzO/Ib9L94Ijiy0pXY9ls8+37mhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=N5zWYl5u; arc=fail smtp.client-ip=52.101.101.84
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWJ4GDCWFxnId9dcerSMGfmT4TZ8SX4l+pOgptaNC8ArQs9RjSYfvA+T5VGVc2xC1ahnIK6oGFL0/a19R3ZwiEtM/WkGNu2WbprMkjma+kFQRYmW2jIr/S4OH4278YpU5udgShGYqwEQy3wU6o8OuICQQulRRI7ujxvd6rS+bl4/J/PqmzuNbMyyTyzf1yRvYNGyE5PjOBhJYKHrmNecNyCisLIuQpC22KE8toJIuDJ0xJDO3PA79nwJdohb1Nehl6ws7Jh6kntXKkNZ8RFeGZ9jM27O3CqHBCuVoGqKtLoEbaNzELLiRT9lB1tFegV9ZOawjLdC0hQP6BU+wnYKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM8MRK4d2kyYryyiKkuTBy3s8zDG1r+l4VkRXiV5WKc=;
 b=Ouxf/lWGjN1+PLZQLH1haR0zyHdhYQgMB0QWrSbsL2cpFJgAZBR5WQCevg0J8jYcEqtq5uwi3F4KQfEDlaG5F5KOBQiDIMyEwKZ5qa0pctid7MxpHpV7NIxhCPWjtmknvVS+AU/iBuM1pK2837fzIR0bmekdHw4rcsaN16BUMdvCCuPLbElpNsdGCSm4S9OlInbOGZ5H0FeFmJHLeRNIziJb3757C05qvA5y9Y7IQdRda7x7EPRnJRU7jBuvl26cvK8y5mdhxjvdBnM6DR2YwiuJeFkJ1mzKtadcXOgeCfWL31smCQ8OWwcMzuXqaOzZypRSxfXs0pfd9YKCugGXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM8MRK4d2kyYryyiKkuTBy3s8zDG1r+l4VkRXiV5WKc=;
 b=N5zWYl5u2PWeF8nh1i439eYO1svlGe5riyHF+Lo+qNb0AEwQKn7ob0yIAOpt5ZgRyQ2NBDyW/7GhQJzVTCcWgLsQhlP4J55qR7T/uhZ7FepAf3l6V6H63TkOMO66yD9up30v1HOfey+kf4cViAhZ1KdtcVh0ex1BRBMplCbiN0M=
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
Date: Thu, 18 Jun 2026 18:03:42 +0100
Subject: [PATCH 05/10] rust: driver: centralize device ID handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-id_info-v1-5-96af1e559ef9@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781802282; l=8135;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=19D8zkw/7Jzd3PcOqF0M0UfH+xDRZR0zkltVMaRe0mw=;
 b=7hx6PdkWrwFo9SNzH6IM84dctv0/rKoMrdoQlSfhQIUYNsOp5fwNlAX1CUOrFXaQeWWvjiCYT
 3ibA8gEPHrsCq15AmmZd63PlhNwGXWjyJrT964W1l2PRWx0BiOyV7yd
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
X-MS-Office365-Filtering-Correlation-Id: 527fee0a-be3b-4e39-d221-08decd5bb33a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|7416014|921020|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H9DWmqHsHuYwD2GbynSrhkLOl/phP/8j1jKIkbkwCMf7Iy/KnX70yC5IshwY7bjEhRZCRQ6NDavKW/HhEJ7BVjebb9BzydGUsbDFEIwnEt29S++wgkJR0h+PfvyjhRDTdyeyZylMpGOK3GVvnLrbrtyiISyxcq5gFZlT0+9+f6VdsBk4DqRAi28+bQVJfEzvyVPuQPwFeFmUw1w6hopOtrPoZppLfqw6udERoD20c9kDfIbv3J5lkHa0eIC2ZNSfEsFTCyfrdPBQuhC84aJ++yeMWp7vCyiWDdn1lc2lTYgv9Tu57sTGaWIhYWPheFHJ92/yq6EjLqDwguKBkHQ5Z28jTMkE7PpeXKzEhkJqA7zZXXzkfel4WKxqbOUqmeZ82kbI/K5ThRp5IQ6FbdHc4skpqNl7xUfNy7i4KAYXnMChBRi2IYnHPbczs42qnoKRJNVhhHff1CMMTgIVOJIOVQufpQI4dZcU52usd5aq3eSOuxOVCEHtcWlnUdS3YXCSXdWmQBMSrKdaK0GMSaExW28QRmz578hl2tvgPicAne4kGeF9ARSmSvuv8BMfNUWsIVKSX9V+xmkxmUmKDJeEgjkV5n483mKvkSm7U0MTqD10lsDutnYlvpwqKBVSAJ7KqTbouocn2Ukgk9xoiPqqnTmRzbDTSqjlPCtDzWq7xCdxht/bKL2dWRznwgEr9EzgrmuCClboXahMg3KYfiunwm+7DqUyrytPKDKzleSSaW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(7416014)(921020)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUhCejdBZjJDaUtycXBPc3lPOHk4Y1NsbFdMMmJFcE9lQ0RFNWQ3aldPM0tR?=
 =?utf-8?B?VXpsUEdIeWhzSkhpc2tSb21idEdFcUFCWk1pTUZHL1c3UHNIWE4vcCt0RHlM?=
 =?utf-8?B?aVRBNGY0TVlLbGRrbjdwNkNISm5FTkJFQ3IvRGdybnhTNzJhK1RnYXFUQjNR?=
 =?utf-8?B?N05mY3YrMVBsK1JjMkM5Slk0R3gvMk5LMVFKT3pzUGRPQXFEWnhZWU5yQ2NB?=
 =?utf-8?B?NDV3ekZrV0s3azJwRWRBRmgybXlMSUI1TVlyY1I1VzM2bzczNmRaUXZOYmY5?=
 =?utf-8?B?Z1VGTmdRMC9SbytFUFZUa0w2aGtmdnVUKzhZaWNENHBJd01McmtvamxPeTBX?=
 =?utf-8?B?d2h6T1ZEMkN0NUJSTld6SDNYR0hkbHd3d0U2K2hqK3l5azhzTFRJbUZ3Sm1K?=
 =?utf-8?B?V2hnSWFNTXQ1Q3RvTzRoWjdZUmwyQzdRT3JvQ3V1YXRza1pLbnlGNk9YclF0?=
 =?utf-8?B?WVJTRFZHa05Kd3Jjd01xQlJ2R2Jab2c3U3hMREVmdC9qZ1NIQWtIYlhEMkIr?=
 =?utf-8?B?TFU2cFhaQXFDb0NVY04wTjBHNHdZcHRXL0NCR0t1OWdJZllHWlNqY3JzQi9q?=
 =?utf-8?B?WktHZHE1emJxNEJpcHdBNjlDdGVUT3ZFRVMrUXNVeXVIaUNqdXduaDRJQjM4?=
 =?utf-8?B?M0QwVG4vRU02SnpKQ0NyNDNyelhYK0ZaVTVtSTI4dEVRVDdaQ21kY0VVaVpS?=
 =?utf-8?B?NHIxeVBCWWRlK3h1VWYyTCthY2dXNzI1QXkzbDdMd1g0VWNpTWZmMVFZeW1h?=
 =?utf-8?B?Mk96djFYNG02WTlZYU5XQ2tucmtuOXF4RjgxR1pLYTBKUDhWbnFjSHlSRGR5?=
 =?utf-8?B?dWtqVzc4NXorYTdJYk1JWER5aUhEc0E0R041Wm1JbHZobVYwbVdYVUFZMFlU?=
 =?utf-8?B?bVdEWG5UZndiK0tRRWs5WGZSd2FXZkd5THhhdlhzaXVOM25XcE13RG1QMSsx?=
 =?utf-8?B?eGZYWmlqZkFIa3MwdklDNXVITG9lYUR2TzllNmlVOS9td21WeFRucDRab2lh?=
 =?utf-8?B?ejZibzJPUG9haEdBQzg0K0MxTkQ0VzdSTHlxUU5TTDYxUHk2Q1pTRERVR2x2?=
 =?utf-8?B?V0hzT3ZzVVZqT05aQXJzU0dwS01VZGcwcVE0aGVGdkRVb2xnaEJZclBGTE1w?=
 =?utf-8?B?VnhtbmVNRXE5aWxhZ3hPT0g0Vnp1SVMyaERiQ3A2TjRCVkxsR1gvRDhab29H?=
 =?utf-8?B?d3gvQWt3azE0RTVob3ppaWJ4bFFzd2YyMk1IZnJMRlpyS2VuL0I1S2VzRUFw?=
 =?utf-8?B?RlkwY0picUtuSVdvL3ZlTEN1Uit1WkdJbFJLbmpmc3V1dkV4U0l4Z2tRSW41?=
 =?utf-8?B?Y0pqZEtxMmZ6U3V0S1FvN3hnSDZIVXBGbXFodUFHV2prNjRRTjl3aHIyVGxF?=
 =?utf-8?B?MXFjVjB5UE5MK1VSMzNnaHlSaHprNUEzbjZ0d3BzcXRsZCtXNE9PMDJINzND?=
 =?utf-8?B?NURNRjNpdjB4NXhSZFJHS0lVNFF0SW13RFVPZ1VCZ1I0bzZDblBqMUYwZmNZ?=
 =?utf-8?B?UkJTSW16UnZXYU94Kyt4cDFjYW5GKzRqRE9DQkM5YmFOY2Ewb3Q2TC90Q3Q5?=
 =?utf-8?B?dEdwbys5a0dvaVlHNVUrNTB2M3N2dGltTUFEUFNxTFNieVo4OGdEVEFhYUhp?=
 =?utf-8?B?aFd4RjVReWhTK3Qrd1d1QXZPU3duVm5TWjVZWVVSSlJlaVVpYnZWcHozalZ2?=
 =?utf-8?B?bVlnQ3gvUzB6RnljQkV1RmxINFgrRlZBTHdXak5JeWZWZ0t0YlY1emFybzBU?=
 =?utf-8?B?bHVBZVJTT2F5a1RaUjFBV1NuWi82RUxMT0hFOUgwMlAraHpzay9PbVRtTFk2?=
 =?utf-8?B?RHh1SHJ5OWRSMG91OHYzaHRwSG1maklkbVR5NzRiMjEvZHVOWGJRUEgwRVZT?=
 =?utf-8?B?NE5yejBRVWp4b2RCRFlKbnJ6WWhiTmJXclkrb2swTzFuZnIrdlRLMllGR2gr?=
 =?utf-8?B?MDQ2T0w5bjlXZC9DYUZxWXRKY25KNEVuOUFGbUc0MXZTM1VkTkpyYWdtbUUv?=
 =?utf-8?B?eVNTbGFTaDk4YVY2T3hzMnhnK05sZ3ZNeXdFODIrUkxRRHo0MU8yS1QzYS9v?=
 =?utf-8?B?WWgxVFF6OHpRakdJaWNYdTFEaEFLWUUrVmMzTTZoL3BWQXNhaVA4RFJEOHMy?=
 =?utf-8?B?cUNOYzRHSWJEUFNEajRpOHdKd1l0c1hwaEZVTjdjcy9GTzVUUTlZamNPR1BK?=
 =?utf-8?B?K3ladC9jR2RuVnI3OHFqRWJpeElOMnBhYURua2srczc5MElRYzczemRTMzJX?=
 =?utf-8?B?QURJRkVidnQ3RXIxd1luY3dka3VNUHFxSE03SUQ1YkVBWFhlTmQzY25ubmxQ?=
 =?utf-8?B?SHJzRFkra1V5WDBkL09RM2wxSjZPTXhNdlR1eDdFRXJCSnJJQy9adz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 527fee0a-be3b-4e39-d221-08decd5bb33a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:04:46.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBysEP504qyBkuEbnQjsxycWrPEMub7euCs9Jlaq+l8sMIpjotU652IP9Dny0eal8CcB9JrMiG1ox3Me1efLdA==
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
	TAGGED_FROM(0.00)[bounces-9325-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 532526A1D82

Move the `IdArray` creation from individual buses to be handled by shared
code in `device_id.rs`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/acpi.rs      | 10 ++--------
 rust/kernel/auxiliary.rs | 10 ++--------
 rust/kernel/device_id.rs | 31 ++++++++++++++++++++++++++++++-
 rust/kernel/i2c.rs       | 10 ++--------
 rust/kernel/net/phy.rs   | 10 ++++------
 rust/kernel/of.rs        | 10 ++--------
 rust/kernel/pci.rs       | 10 ++--------
 rust/kernel/usb.rs       | 10 ++--------
 8 files changed, 46 insertions(+), 55 deletions(-)

diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
index 9b8efa623130..315f2f2af446 100644
--- a/rust/kernel/acpi.rs
+++ b/rust/kernel/acpi.rs
@@ -53,13 +53,7 @@ pub const fn new(id: &'static CStr) -> Self {
 /// Create an ACPI `IdTable` with an "alias" for modpost.
 #[macro_export]
 macro_rules! acpi_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
-        const $table_name: $crate::device_id::IdArray<
-            $crate::acpi::DeviceId,
-            $id_info_type,
-            { $table_data.len() },
-        > = $crate::device_id::IdArray::new($table_data);
-
-        $crate::module_device_table!("acpi", $module_table_name, $table_name);
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("acpi", $crate::acpi::DeviceId, $($tt)*);
     };
 }
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index c42928d5a239..59787c9bff26 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -181,14 +181,8 @@ fn index(&self) -> usize {
 /// Create a auxiliary `IdTable` with its alias for modpost.
 #[macro_export]
 macro_rules! auxiliary_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
-        const $table_name: $crate::device_id::IdArray<
-            $crate::auxiliary::DeviceId,
-            $id_info_type,
-            { $table_data.len() },
-        > = $crate::device_id::IdArray::new($table_data);
-
-        $crate::module_device_table!("auxiliary", $module_table_name, $table_name);
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("auxiliary", $crate::auxiliary::DeviceId, $($tt)*);
     };
 }
 
diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index eeef3f5e7b63..0239f89d5f69 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -175,7 +175,36 @@ fn info(&self, index: usize) -> &U {
 /// Create device table alias for modpost.
 #[macro_export]
 macro_rules! module_device_table {
-    ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
+    (
+        $table_type: literal, $device_id_ty: ty,
+        $table_name: ident, $module_table_name: ident, $id_info_type: ty,
+        [$(($id: expr, $info:expr $(,)?)),* $(,)?]
+    ) => {
+        const $table_name: $crate::device_id::IdArray<
+            $device_id_ty,
+            $id_info_type,
+            { <[$device_id_ty]>::len(&[$($id,)*]) },
+        > = $crate::device_id::IdArray::new([$(($id, $info),)*]);
+
+        $crate::module_device_table!($table_type, $module_table_name, $table_name);
+    };
+
+    // Case for no ID info.
+    (
+        $table_type: literal, $device_id_ty: ty,
+        $table_name: ident, $module_table_name: ident, @none,
+        [$($id: expr),* $(,)?]
+    ) => {
+        const $table_name: $crate::device_id::IdArray<
+            $device_id_ty,
+            (),
+            { <[$device_id_ty]>::len(&[$($id,)*]) },
+        > = $crate::device_id::IdArray::new_without_index([$($id),*]);
+
+        $crate::module_device_table!($table_type, $module_table_name, $table_name);
+    };
+
+    ($table_type: literal, $module_table_name: ident, $table_name:ident) => {
         #[rustfmt::skip]
         #[export_name =
             concat!("__mod_device_table__", line!(),
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 7655d61daac8..a7d9b88ae616 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -77,14 +77,8 @@ fn index(&self) -> usize {
 /// Create a I2C `IdTable` with its alias for modpost.
 #[macro_export]
 macro_rules! i2c_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
-        const $table_name: $crate::device_id::IdArray<
-            $crate::i2c::DeviceId,
-            $id_info_type,
-            { $table_data.len() },
-        > = $crate::device_id::IdArray::new($table_data);
-
-        $crate::module_device_table!("i2c", $module_table_name, $table_name);
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("i2c", $crate::i2c::DeviceId, $($tt)*);
     };
 }
 
diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 965ecca7d55f..166572861e61 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -809,12 +809,10 @@ macro_rules! module_phy_driver {
     };
 
     (@device_table [$($dev:expr),+]) => {
-        const N: usize = $crate::module_phy_driver!(@count_devices $($dev),+);
-
-        const TABLE: $crate::device_id::IdArray<$crate::net::phy::DeviceId, (), N> =
-            $crate::device_id::IdArray::new_without_index([ $($dev),+, ]);
-
-        $crate::module_device_table!("mdio", phydev, TABLE);
+        $crate::module_device_table!(
+            "mdio", $crate::net::phy::DeviceId,
+            phydev, TABLE, @none, [$($dev),+]
+        );
     };
 
     (drivers: [$($driver:ident),+ $(,)?], device_table: [$($dev:expr),+ $(,)?], $($f:tt)*) => {
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 58b20c367f99..35aa6d36d309 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -53,13 +53,7 @@ pub const fn new(compatible: &'static CStr) -> Self {
 /// Create an OF `IdTable` with an "alias" for modpost.
 #[macro_export]
 macro_rules! of_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
-        const $table_name: $crate::device_id::IdArray<
-            $crate::of::DeviceId,
-            $id_info_type,
-            { $table_data.len() },
-        > = $crate::device_id::IdArray::new($table_data);
-
-        $crate::module_device_table!("of", $module_table_name, $table_name);
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("of", $crate::of::DeviceId, $($tt)*);
     };
 }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 0e055e4df99e..34e07a53244d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -245,14 +245,8 @@ fn index(&self) -> usize {
 /// Create a PCI `IdTable` with its alias for modpost.
 #[macro_export]
 macro_rules! pci_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
-        const $table_name: $crate::device_id::IdArray<
-            $crate::pci::DeviceId,
-            $id_info_type,
-            { $table_data.len() },
-        > = $crate::device_id::IdArray::new($table_data);
-
-        $crate::module_device_table!("pci", $module_table_name, $table_name);
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("pci", $crate::pci::DeviceId, $($tt)*);
     };
 }
 
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 7aff0c82d0af..154919ee1e19 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -254,14 +254,8 @@ fn index(&self) -> usize {
 /// Create a USB `IdTable` with its alias for modpost.
 #[macro_export]
 macro_rules! usb_device_table {
-    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
-        const $table_name: $crate::device_id::IdArray<
-            $crate::usb::DeviceId,
-            $id_info_type,
-            { $table_data.len() },
-        > = $crate::device_id::IdArray::new($table_data);
-
-        $crate::module_device_table!("usb", $module_table_name, $table_name);
+    ($($tt:tt)*) => {
+        $crate::module_device_table!("usb", $crate::usb::DeviceId, $($tt)*);
     };
 }
 

-- 
2.54.0


