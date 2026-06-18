Return-Path: <linux-pwm+bounces-9330-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v1zdNaEnNGptQAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9330-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:15:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF86A1DCC
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:15:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=b0xRUOtK;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9330-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9330-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CBC8313EB44
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C60B3F8EC2;
	Thu, 18 Jun 2026 17:05:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022084.outbound.protection.outlook.com [52.101.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26953E5A0B;
	Thu, 18 Jun 2026 17:05:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802304; cv=fail; b=uqWeKi0FmCiXrslcnIis8oK8kYk58R+5F7QrZvkQ+Gajo1xgFTAwEu/6vGUgsPE6QEXsCGfDj5HM4xVmu0ocjBKYYa0kfz0gUSUu4qNJa1m8tSbGmYIqFL500OfPrfLgm7l+Lx6TlXzD8M7CvhR6j+w0gXeRydbgsFJI7OCBUds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802304; c=relaxed/simple;
	bh=A0ywXdGf02/pqWfOcql1b083Co7opyezNY57GOUfVeM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pPRocZYR0WpkdA+/PvLwFIq1zYO3L4sI7H4oNYSoqam9iqPI7pQ3sjDSwpsCxZ/wmCymGrUtZ+dcHf+CZD/FnZKKnLXhm6KUBpI7H5L1DfCy57sZhJH2kKgtCewncM05hey2K9WmnJSfvmmZQzDxY/M10dUsphIgWmp29VlDQ+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=b0xRUOtK; arc=fail smtp.client-ip=52.101.101.84
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZAaaFMYU3nIlOZpNHmvOsSK8NNKLTQfLg2NjV1xVJybAxfl8xbF558q4sy0JqWI8vLVGQqVfiWCNlJNVav181E16BIJEoalIo7nRvdWtX8vHVP9otwohNlItssoFVoS7dDIdUtDYqf4I3RtDbKAblZmVBmNSbRVFjJqceKo5w8bhcztahcaSZ3vzmstrIa6exeXcSp6KjxsjSjK1VQRM44zeTGBDVQIuWwLO3V8RjI9ziwnDuGZHGANnhtxN1SwG+b0xTMimgvTLjvJQtdcmmX1jcxsjrGRVcwi9YmyJxZHeSKExU+n1auxF7HKwV8D/Hxs0BT6Bv6JlkqSZEr8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1sc6qMCXeEMau8ZRnfo41X1a57ZKivnNqCpzABICd8=;
 b=Nl+x5eL7wg0FspeOIYlUa+jOQBE76AoZgpWFwt7EbODWaUBtKImOZ4Y6dAQ9/54kkopUtq2CNCtAKFHFLTNgxOk+kehfE9KLxhCh6BUJ0XBEp0E/tari1Fn3GAKD5Ks7H4zzQeb0/cAINhfDwhEkTIF445hDd7KIYwjt0aCA0m7RXzRD8l27QJEe6dLHVfJOSwcQFYPmfKD/gMT6Kpsawso4MYyJZ2yZqwGY/Ptyxysdo0HgZxzTkWkJCBY5Npt3842+mbp0hZuTdhX/zcYt/KmWGkBy4ELqJWQZHaMTVGwi/LxkZ59CkD+r93A94x0mOBrXL8Dd7XH6bIJxrfh/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1sc6qMCXeEMau8ZRnfo41X1a57ZKivnNqCpzABICd8=;
 b=b0xRUOtKp6JBHFSir6fXCcRkcB20Zr8bI5bvVeFUQGjkkFkgK31Woz6aHb+9JsMi4qHCrBw51PGRgiiqpIFppUAtZ0b4YlsNWOvERRT+iM9wNNh6Wa3Yg/njXofT5WAO4PKtzqKDXKU5ns7vnef+Sihu5EymwkHRGKxz7SDqISM=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6966.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:04:49 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:04:49 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 18 Jun 2026 18:03:47 +0100
Subject: [PATCH 10/10] RFC: rust: driver: support map-like syntax for ID
 table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-id_info-v1-10-96af1e559ef9@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781802282; l=1753;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=A0ywXdGf02/pqWfOcql1b083Co7opyezNY57GOUfVeM=;
 b=xj5GhBjIYVuoC0phxbQlVjreyyGtDNgJPrJPqTGL7Nr7TwKpc+9p1wDMt1NR9cDa/pM/lNlFG
 U8loSS9DoPdCo1m33rcwrc5RnyZnPCDLdP/IrcK3/TS2N/Ql+97hqaK
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
X-MS-Office365-Filtering-Correlation-Id: fbbbe4c8-d618-4554-48e1-08decd5bb4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|7416014|921020|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ehw/ZqUdUcvXQOIPbOVZQ6VmDsrYbcb2TEhcdYlFr5g38vpuDBKF6TViT0WiWqDKAw4Y82pA05ZgZsQa4xcmSDLjYBRyKd7J9a5XkY5Q22kGJ6Rx8VcmGZm9BjEbrnAzCUkBTie8ozhlrENCrS8rLLmx1mRylYQPl3nP8aVUTwf9MTIrRu8yuehdOgbghzXVQvIyq5bM2XZS3olQdbWSH14U9NUwHXNgtZFsZk7KY4wLon+fX4hvjEkT7gXGdTJiYgUCA9x7nhVuczItzxZZO1gW+IBAvIRDjifDtlBWA9wMDGj5OCdx1a6YPnAJMBqqjW6LGHJn/UM6IODeCODfiBOCLfEXQWPGXLRbqFf5eoIVkjwAWZzDBzZd8aKOCUW/G6KksXNP8mmF3DVleVmmxHdbUPouk8wlbXtxdiF9nBEjbBQaU3sSwnABYp0/onEP9y5CAWJ53tCtg87XVYlX1ba3+m/B5XeDOlc4C15bZMD0GZ20iaAGVwPbHbm9Bje4KS9/V6Q2MiKVJhwtPlZcTkrndmbFVk+adie9eEiDPaWx3WCBA3PD/SBAafsChNDxsj4RnkZCM+Mqa+deTxoUFmivM47BCtBFmPFiTDZgqJihUvdbaGSea46HgvKa/2NXdZ172+WNrCmJwVNr/t2DpR0qsp1ROU43GE94xdMUI7M7jlFf+J4lNmFPE/WOaM4Et55eCP3GWTEwxyi6Hm9WMzSBEmKKbzxilKa3PvQQW5g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(7416014)(921020)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUtaSWcwSG0vZThhL2hVS3RNaTh0eEJEY2ZXODd4WlJ4MlZlUkRTaXRjNVZ4?=
 =?utf-8?B?NE5DaUpqd2hmWENKOVM3bXpIRmh3aDE3Skx4U25Lc3dGWnVLb2xJcEhaZURX?=
 =?utf-8?B?bllwOHJIQ0NrTXdiRENEUmlmR3hIYVAyQzdIQkE3OStEK01RN1ZDV3lIdG5h?=
 =?utf-8?B?QkdRYkdKcWZVOHRrVndJdFJMRFY4ekYrMzJ1dWQ0ek00cVVSbkR0VWF0QWNO?=
 =?utf-8?B?eEQ1bVpFMmRJdy9jMWNPTEZVVzc2WGNwa2J6Y2Z2WXFFRFpjV08vMmI0a3FN?=
 =?utf-8?B?MXdoRXZrZlp4Ri8zWTkxZy9PYTlxZUVaYUtoUmNCVW1PMjF3YmdYd0RaMzQz?=
 =?utf-8?B?cXJOUHpKS3NmTSs2SEdZNldNQzRQNXYrMEQyb25ibE13SjRvSkFkWUtleW1P?=
 =?utf-8?B?VEltVDNwcldyNnF6MDBwOGp3SjRZclV5SWJvci9zVFRRWUVvMzZFdGVuc2h4?=
 =?utf-8?B?TVJDTi9XMlhjOUgrZ2p1TkY5R3BNMTlId2dTZXNWZW1qZktlZXhLcGZKTVpL?=
 =?utf-8?B?R2Uza0FqZnVhYXdVUjlHaVhEZHdQR0xvaGNYUnlNZEtRL2s0M01GNExJQ3Z3?=
 =?utf-8?B?c1ZjR29lbEVhNnRFWEVGMVZEMklJb1lOM2hhb253YWdsVDdXeGZ0U3JtWFMv?=
 =?utf-8?B?Y3grb0M4ZFhZQkYrNDVIM090UHQ1YXcrUlNLRk9CNmtNdDloVGV4dHFGMko0?=
 =?utf-8?B?YWRIeTdwN25lZndlUFdUeTc4OVVVaGMyM0xZZ1hraG80ZklUcUQ1d3ZTc1dp?=
 =?utf-8?B?YzNIUmRNa3E4UFUwTVQ5YW4rK2ViZExXQ21kLzNMaHRkQ24rdldzbktBbU5n?=
 =?utf-8?B?Ry8zL3lMK1pRQ1lUZWZZdEpOTk5ISnNMcHN0dW1CRUZ6cHpXb1BBeUF4NG1U?=
 =?utf-8?B?R01TNHRWVmpERU4xNUZTZ1RPRFVJKzh6MTBHWFlHd3A4TktQcUN5TWlPdmUx?=
 =?utf-8?B?eVE0MjlVVjBKcEp3WC90dE1lWE41WnZaRXpjSk1waWhnL05kdldGOTlZeXNj?=
 =?utf-8?B?bXNqTUtpaXV4ekx5d3JUT3hPN1dVdGdsQko1RjZteWh3V1dpTXIrUU5nVERW?=
 =?utf-8?B?SzZ2YnFFUmFvdDhuUzNKeU04QmdMMjdtMm1aVEFrU0drNmxpTWpYQVN0ZElj?=
 =?utf-8?B?VVlrMGZreVlKV3VPTjZYdHJmUDdPV2s1bGtRaWRPaDNMeVNoMlNyVXRHTDZ5?=
 =?utf-8?B?aHoxYUhkeVZBa1pDSlFReExpQjlJd0ZQQUlqZlFYeHErUDEzY3lsa1psZGs4?=
 =?utf-8?B?UVRFTDFsN1hseXg2OWRWRC9naFVJMUx6cURMMGpKd2hjNVF6Lzk5RlQ1cDZa?=
 =?utf-8?B?Q2pHUFlNejkzb0FGRlpBbTRKSHNjajNVUlhSSmxYL2ViYURONDdNQks4UU5W?=
 =?utf-8?B?UjhDT1IvYmF6TXRUZThsSFYwT1VEL2R4TXplMHE3OVIrREdVOTlTdHdNRkRG?=
 =?utf-8?B?Y2tZZHBlZGlYUy9SaU92c1BocCs4UnpLbmh1TTM4ZlNadmVwbTlsK3RWK0VO?=
 =?utf-8?B?c3hvZnQ2MXJ6dXcxd2lFVm41aTFMTFppdXY5NElWc0lORlpOMzdTMi9hZUs2?=
 =?utf-8?B?Y3R5emh4QS9JZ3ZDUU00SUhNaWIxbVY2eU1mcDZ1cllGdWdGak1Ga2pYTnFI?=
 =?utf-8?B?b29GRUVUSXc0MHRnT0psdUI2cEZwOXAyWS9tSUtVek1xODQ1RHRKRzdxaDQ5?=
 =?utf-8?B?RVdBNENRZTRLaWszV2txdkFYS3BpRUN0WXNQSjNpUWtCQ1lhV0Q5Z3ZZRTM2?=
 =?utf-8?B?dXFmOWNnMGVweUowWDFybUViYzhhN1lISWlCN0d3SkFHcU9pTVJiQW8xNzBh?=
 =?utf-8?B?YUFCT1hhOTZsL1hLQkNkZ3E0S0dxdi9Fbmw2S0ZGME1HSHZZYmdQSVVvZ0Jy?=
 =?utf-8?B?QUx3Q0d1MDhNdzhabDFWazU0VEdVNDlseXNIdTRDenY1emhvbWxydVdnVll2?=
 =?utf-8?B?YkJpeGdyYTFEaUpMTlowQVBodEp4Z3pnUEJNcHNvcVlDSzBCVmRUdDJObUtY?=
 =?utf-8?B?UkhUeEN2NmlvYUdXN3QzUm9YLzVCdUw2MHBTM0QxRENPM3hBbyswWEsvcEdr?=
 =?utf-8?B?Z0ZicFBmc01raUVOUUJGRjhYa1psVi9XSFJCK09Ldy9NOEdQY2diZStsalRI?=
 =?utf-8?B?eDJodFI0YTFkNzFieERtMThKbzJqZ1dkRlhIL3FydDI2SkRYdGFaNUxnUERL?=
 =?utf-8?B?RWdZdmFlS2M5VnJSQVU5VHQ1Skw0R0NSYXdPTSttMWppaXpyMFZSamRUdUQ1?=
 =?utf-8?B?Szc4OForYlJSSFJUeHpRbU5GWWdCV05uZXhVTFRXcEovTU5GR0lQZFdkdklV?=
 =?utf-8?B?eU5EVDhKdHFvdlNrRTA1YU5aWnJuNWtrNnRpVDRHZmIrdEdaT1V0Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbbe4c8-d618-4554-48e1-08decd5bb4fe
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:04:49.6298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjgpGG3fjnJ60VsWSKnltPjHnIGmV0RvNRmDQGgC10DJPu5bf9dRSZkoM/Zag6to58RbNFglJvWq13riTiVcaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6966
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9330-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CCF86A1DCC

The device ID table and its associated info is really just a map. Add a
syntax to `module_device_table` macro that reflects that.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/device_id.rs        | 11 +++++++++++
 samples/rust/rust_driver_pci.rs |  7 +++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 26618bcda276..7c61cdcc9427 100644
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
             concat!("__mod_device_table__", line!(),
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


