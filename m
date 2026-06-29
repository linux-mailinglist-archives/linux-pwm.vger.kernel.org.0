Return-Path: <linux-pwm+bounces-9463-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yffjOcxpQmqM6gkAu9opvQ
	(envelope-from <linux-pwm+bounces-9463-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:49:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B0A6DA853
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:49:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=LjcnPC7Y;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9463-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9463-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C083308244C
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A63403135;
	Mon, 29 Jun 2026 12:39:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020104.outbound.protection.outlook.com [52.101.196.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60F3FFACC;
	Mon, 29 Jun 2026 12:39:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736787; cv=fail; b=jwfBOrrbLBDArbyMy99o355z6/+sLcJIWpiaMx+wJPVjZhntq84phv4zs/AQaf1UPrp6cfkCI3UABNq9uPFCuEw4Bu3RoVFRWd/UKbW8P/s+SsqEbG72rslKr8k9tNuy9FE9w9vTpeQ8iJLwMUx1xzVT9rKbTI/CMeeDvUl7/QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736787; c=relaxed/simple;
	bh=csqRjzu0fisUcez4bMhkdTyUrxkyBl0ASwwL+pKs1V8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=AOijHo5BWONubUObye4sQuloATt6o+Xqpa61yfDgYpZdWgqRUoYovdyQDtcld0LoCxDrPydyFRaS4nR6ZG4Z75iQDnx8rZJjtgGvr4177VlpwZdGxTDoWotsSki4+cAOICh9fWCxnb99EWojp+G+Jj3WkMyiHPT4IxXhZuHteRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LjcnPC7Y; arc=fail smtp.client-ip=52.101.196.104
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBUZwaKSzH/h6ArY9BxH96tSVl2VvEI97tqFbLxhfI3YZJ8dNOIe9AC74ds8v21WRLoZU8HXJfBosWOwnxscd9n8f+Ou64z5JXrvUX9Ip+TbqdMbH5hlM644Z2zjeSvHdgYrtCCj1sd6S/omRBdFi+W+ri2jDgLGMUv1dwAL6gNdGc6G8LV2yF4OMNFPG61/3X2d6PkEP0t7WJlf7nGBTp2Vht5NmPbU0l07/YyZcVbwHan4VbzbBy6xJM//3MetwMX36vt7Hzu5ocDW0Ss4FrOmiQ7qxDvGmRQJmaMOCSGLzs1pBZi8q8Q/iug8/A1vhy6LKiaX/gyTOEwjYfPm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZJPR0X8Oh7afedG+FegOPcTYy8bz73oRSsBJQv01kM=;
 b=ohqE0ukbV7wDkOppM21OtrYvamZtDfFuGk2OvCoKf0ORbVa2x7dgpieVKoTlD0TFlTi9GgESkwVaGmS4BzvW/v+vkLqkQyhjS8KemgqqJuiULXzWK1mqOgqM4s4vZjaM20Fqez0h4csPSI1WGBpO9vqvPU8hjq+RBr2x+SqJ+olawUXbnwDLUPtNN1qUU4ZgTK+ir0S0/VAGVPVA5bBNYAp7dwlTR5aGvlVpkjcHeXqzwUu9BoTfzSt1lERwAcvDTwh6A6FxArVex+/FmSCoEk+w/ax2bBTggWfZSJOd6TuIev3V22TKiCqvuXNdbz76VpECSNsdbKmVxi5bTgmz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZJPR0X8Oh7afedG+FegOPcTYy8bz73oRSsBJQv01kM=;
 b=LjcnPC7YnLlt29yOGdjTQXxsbWrGEm6zj49UvEZTt5QaBL5mE3GFAvGbl/ycJJrTq7o+/9Qp5Yaxj/F0BdIbz/Cvd5ImKEgsL6JkcIloyzj9GiMCpb/MQdDTkTk+E0WqBDct1/HdGb0iFQoPd1gnP2+KqVJiEwnWJtgw7zv5z6Y=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3081.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:174::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:39:39 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:39 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v2 00/11] rust: driver: use pointers instead of indices for
 ID info
Date: Mon, 29 Jun 2026 13:39:34 +0100
Message-Id: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIZnQmoC/z2NwQ6CMBAFf4Xs2RpapYIn/8MQU8sW1kNL2kIkp
 P9uwehxknnzVgjoCQNcixU8zhTI2QziUIAelO2RUZcZRClkKbnI+CBrHBMn1Op8EVp3NWR79Gj
 ovZfu7ZfD9Hyhjtt8MwYK0fllv5r55v2q9b86c1ayRirDsaoaNM2tV37pJ3e0GKFNKX0ANymuF
 bIAAAA=
X-Change-ID: 20260612-id_info-23eca472ccd8
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736778; l=3088;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=csqRjzu0fisUcez4bMhkdTyUrxkyBl0ASwwL+pKs1V8=;
 b=lH0wOrN97+o6ohcQmrsaLmMOvA/2OyKDg8KV/Ps7VAgSv49Q87BeIJwJS98NPp0BJi9IWx0xR
 FaJ3WR684abA6wVnrWjvEUMqTnC+WsOLl0l5/F12GCzSDdQ1pNEkDWX
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
X-MS-Office365-Filtering-Correlation-Id: 76e7d9fb-abec-4e8b-c0f9-08ded5db7c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|3023799007|6133799003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	OnfIC3tGtuh8Jn1QBacHMGanmaKXzOZ2xVH7bQxzgawB1teSZuMF9xBs+yWs6eG41v2/pj0v9lJl6uvfUIBSUrlJl3o8Y+wSwB/zmz0X4wQO1f7vEeIGKez/HHlamSkadl8xTViywaONqwCGAKU6RylIuSy1Qf8DJcO1aAtCV+v489dR3q0mWZBftrUNK0wLFMYX8pliFTG0tPt9M+OxsDKSsdTV1qsQnKwWG4WKDXSV4+0a3levD41HFDbsxAxFhKgU6R9TQZQDbCgHHFACSGAwPU7Vq5/OKAlmaYjvEenoY6165sYXGAzjzDZMJpgprIqI9HqmHQZGbfKK+PVB8nK1Ci7tBGzmQJDP6PO4HEUxE+EkdrDGksHPOdhcSXhZcivhbGuK0eBn2wGt4XXC8jfo4BebAZaG1DSWZGyGgQON7cwGcyrp85MHrPxJy7lsKM9Mvysv1rq7gQLi1R0nksUqtv8VMbZ4K584GrRCEPdJXeABkXheYoL8mESHWZPdSRJVWD0Vfprd5y0JMGP9rrz7o1UyQ8POjWZn16Kin8gBhHccg0ikqWom32KFBBJuARJOLAwhJZua+bdEXhM7uoBxa902/eljZPqvFTdNtvpMmW8JwCMU7kiooDeDa1Czk/i5OAQFH0zqDpA8/SUfCx/pgC3L0wgbBqfiRVaPPHA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDFwMkk2akJQdjRrQmtyUGFUSzJ6TnR0Y045b2JCTVg5RSs3bzF5SVZPVlpS?=
 =?utf-8?B?YSszU21ZeTB0bEhnZE1MV2t4M0hITVJMN0R5aHRFTDAzL204RkRrY3hzd3kv?=
 =?utf-8?B?Zk5IUGp3RnRoQm05VGZPVjdMU1VWd2lMdm5NenVCbmVGRE5KbGp0Z2ZHV1hO?=
 =?utf-8?B?elZwUG0rdlNvZVJVbk5GdUo5VHlxaUllbTZ6NUs3cTl4SUh2VXV0MkxGYW9K?=
 =?utf-8?B?Y1FabW9lUTFBL1NybDJmTVhib0txenprNWMwTE1YM3paa2tmM1o5NHFVYWFz?=
 =?utf-8?B?bVRGWkFKWkF5c2pRckhMS3o5cGtCdUljVm9jMXpXOW1TTk5vZHJqNlVMS0tU?=
 =?utf-8?B?Q1NYdUk5SVNrQno5K2ZCSDk2U0RYUGVzMTAwdlFIRzlCa0x3cWRyV00wNDA5?=
 =?utf-8?B?d0lMRHYyM2NKRnNBY1lxQW9OMktkQjRNVDJIZlhLMTJyb212ZS9xd2x1aW5W?=
 =?utf-8?B?U1dNTFRuSElrUWU4dW5CQjVVenhJMkNVK3VqSVMxOWMya0U2ZVV6TEZ5amxa?=
 =?utf-8?B?QldEU0F6ZGJqM0hyMVh5M1JzOXhWbWNaOU5qK3N6N2lnQjl4ZXZ1bUptMXVm?=
 =?utf-8?B?bjVlQUZLbXhmQldDVTZONzR0N1pEZllPYXhiV2xGZmNyTXgxQVIzajRhNHJU?=
 =?utf-8?B?RCtEVlptd1RtWUJlaG0zY3VBWitFeW8yQ2tzVGQ2TzMzcWpCK3RyRGZMczNn?=
 =?utf-8?B?a1hMZzJVcFBJN2t0RGVvL3dKMVZGMFBnaUpJNFdiNTlLckhhZFNOYVpGZ05s?=
 =?utf-8?B?c3o1UDcwL09Cbk1kaGZOVTh5eEZsWVIxeFhwTlZlRzM2RFFjdXFDZkQ3L0hC?=
 =?utf-8?B?aE1sNHA5cGZ2OWlETTFWWXdJRXMrQy9xYXZaUHJxZzUwcmptNnlwaG9jQ2hQ?=
 =?utf-8?B?MWdraHcxRGtSOEVSbjVsRDlZbnBHOTdOZWpzNW1ES0prVTg5elNHb0xRQUs1?=
 =?utf-8?B?bTVyYWZlVGEyTEhMSzdrOXpWOHNYblJydWtpZVc5RHhZdFhoZTd5L21pY0M0?=
 =?utf-8?B?OXZDcC9tNzRvRU1McUFrN2wzckZPTS9iU2taMFlzekZrTTA0a2prWUxhYUg2?=
 =?utf-8?B?Vk5mdW5pWDRPbFhPTVFsQXBpdDV1K0xqNUhLNGRaVVFNMnNjZzAwNXQ2ME4w?=
 =?utf-8?B?NXpwZytzNjZhY2toR0RSdU9FQy9YckIwWlh5ZTlhZEMreEUySFBqeVNIdkx3?=
 =?utf-8?B?S1E5cDRvaHZGOHB3bDlCSVVEbHJoWEpaeFZ2MlZBTTdRMDBvTVRpeFdJbzRC?=
 =?utf-8?B?dG04bXl5Y0o1Ynphb2ErRnFjc2xFUTUxNmFleHVqNSt3RVdvdkJhcyswRXQ5?=
 =?utf-8?B?T0xYWDk4UUdTOFoxeUdJT0RpOFowa0g4SVg3UWJ2bzM3ZVRuMjBVSFVUai85?=
 =?utf-8?B?ZWdvVWI0Z2xZcndIV3oxcC9HRlFQNUhiZEFJcmNnWE5jdTh6UGd4emVyTU1w?=
 =?utf-8?B?WXNOaTlWdTRYODhBQnFacG03YmRRZHRRZklNZUFiOExkd1ZiWUdHRE4xZ3N5?=
 =?utf-8?B?U0IrNEszdERRR3BIUllrbHY2ZEk0ZUxHVklCclVnZWVKOSt3WEF5RnBleGx3?=
 =?utf-8?B?ZEQyT0xzOFhqNWZPalhsQWlFK1pRWUJzUC9KYmJQWFErbjZFWGY5UndjZTg5?=
 =?utf-8?B?T1VySHpLZ29XK1d3Mm10bzNlYXBSNTNOTHBtYm9pZGlxanI5dGtaTnJaejVl?=
 =?utf-8?B?cWtqSkZMVE01dk43WkExZjh6clNmSUUvZEVoUFY4T2JwMEdJbUJoblhmY3dk?=
 =?utf-8?B?azRMeG05aENncGpvNkZYcThPbXFPRG9CR0dPdWVzTVFOcEdlRGpidmR2NEFw?=
 =?utf-8?B?UzhTSWRUdVJFeXVCeTZmRVdKakQwc3lyU3F2c1hFLzNKY05RdC85U2xEdEQv?=
 =?utf-8?B?UEo5ZUh0TnhTdU1sckVIbEZmd0doZDU5d3pkWmlRTU1jNDh3K1JHZGprUU5T?=
 =?utf-8?B?ZlN4VHpUSWg1UkNNZDlDRWEvTGFpeGh0Mm41akp5T0Vrc3R6VHN2SDRySWpm?=
 =?utf-8?B?Q1JhcFdjcE9BMVVUeHU1Q0trVWc1ZUx3WmRoNFE2WE0rNXZhbXNmREJ2UW80?=
 =?utf-8?B?ZWJOMENac2JzZDRtQ0RGdWpBTUQzdWVaM2V4TTVnelV2MmhDK1M4RUszOFFK?=
 =?utf-8?B?dThUUGFVZHlFMCtwWmVTQ0F0M2g5L1p0dkdUb2t3ZU9XUW5WdlhMYnFpaUdv?=
 =?utf-8?B?eFNEREx6NmlMOHZBbmJBaXRLbmhnSkc1eFplUUZaYm42Y3pWR0hJenZrR3N6?=
 =?utf-8?B?M3gzUUlKS0JobDlTa1lTdDd2MVFyWk83UjNRbVpXbUFXVXlpSkJueXcrNlUy?=
 =?utf-8?B?dnZCbFN4TER6a3dCWS9KeFI5ZHVUeGgyT3BwUm5jSEVLUWoxNUFpdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e7d9fb-abec-4e8b-c0f9-08ded5db7c57
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:39:39.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lG5bqFnOzZl0IkHgRrYamyOiuLK6mRtEU09FM1e4JOUqJsVJiUELpnSD4LH4nriovxkcRxAxn91M7g/Cfj2AzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3081
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
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9463-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55B0A6DA853

Most C drivers use a pointer (and cast to kernel_ulong_t) for driver_data
fields in device_id. Rust code currently does not do this, but rather use
indices. These indices then needs to be translated to `&IdInfo` separately
and this is by a side table.

This leads to open-coded ACPI/OF handling in driver.rs, which is not
desirable. Convert the code to use pointers (or rather, static references)
instead.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
Changes in v2:
- Change USB to take `Option<&IdInfo>` in addition to PCI due to ability to
  dynamically add IDs.
- Mention dyn IDs and driver_override in safety comments and justify why
  they're correct.
- Link to v1: https://patch.msgid.link/20260618-id_info-v1-0-96af1e559ef9@garyguo.net

---
Gary Guo (11):
      rust: driver: remove `IdTable::id`
      rust: driver: simplify `IdArray::new_without_index`
      rust: pci: use `Option<&IdInfo>` for device ID info
      rust: usb: use `Option<&IdInfo>` for device ID info
      rust: net/phy: remove expansion from doc
      rust: driver: centralize device ID handling
      rust: driver: remove `$module_table_name` from `module_device_table`
      rust: driver: store pointers in `DeviceId`
      rust: driver: remove open-coded matching logic
      rust: driver: remove duplicate ID table
      RFC: rust: driver: support map-like syntax for ID table

 MAINTAINERS                           |   1 -
 drivers/acpi/bus.c                    |   6 +-
 drivers/cpufreq/rcpufreq_dt.rs        |   1 -
 drivers/gpu/drm/nova/driver.rs        |   1 -
 drivers/gpu/drm/tyr/driver.rs         |   1 -
 drivers/gpu/nova-core/driver.rs       |   3 +-
 drivers/pwm/pwm_th1520.rs             |   1 -
 include/acpi/acpi_bus.h               |  11 --
 rust/helpers/acpi.c                   |  16 ---
 rust/helpers/helpers.c                |   1 -
 rust/kernel/acpi.rs                   |  14 +--
 rust/kernel/auxiliary.rs              |  18 +--
 rust/kernel/device_id.rs              | 207 +++++++++++++++++++---------------
 rust/kernel/driver.rs                 | 137 ++--------------------
 rust/kernel/i2c.rs                    |  26 ++---
 rust/kernel/net/phy.rs                |  66 +----------
 rust/kernel/of.rs                     |  14 +--
 rust/kernel/pci.rs                    |  25 ++--
 rust/kernel/platform.rs               |   5 +-
 rust/kernel/usb.rs                    |  24 ++--
 samples/rust/rust_debugfs.rs          |   1 -
 samples/rust/rust_dma.rs              |   3 +-
 samples/rust/rust_driver_auxiliary.rs |   4 +-
 samples/rust/rust_driver_i2c.rs       |   3 -
 samples/rust/rust_driver_pci.rs       |  11 +-
 samples/rust/rust_driver_platform.rs  |   2 -
 samples/rust/rust_driver_usb.rs       |   3 +-
 samples/rust/rust_i2c_client.rs       |   2 -
 samples/rust/rust_soc.rs              |   2 -
 29 files changed, 178 insertions(+), 431 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260612-id_info-23eca472ccd8

Best regards,
--  
Gary Guo <gary@garyguo.net>


