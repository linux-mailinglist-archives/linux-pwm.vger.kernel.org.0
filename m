Return-Path: <linux-pwm+bounces-9321-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KGPYJjolNGoTPwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9321-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:04:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BAB6A1C0A
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 19:04:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=YqIzKrKD;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9321-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9321-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 768BE302EDD9
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C12347500;
	Thu, 18 Jun 2026 17:04:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021095.outbound.protection.outlook.com [52.101.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E14345CD3;
	Thu, 18 Jun 2026 17:04:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802291; cv=fail; b=cqbK3h6HsEtpmIi1GMJLNgmeQcK4wQMjVfPzmDMGDBWSClixI2Xjlzk68NtL+8YRJtT3nX7ha/UEU1v76Jdh93DxW8OQwokOXWbornZMXDTmx/i1bvILzydnVhJf2BnTYNQ3qlJVYCg5LHplb7fvPdPplkE7RQf5sc3zM4G+Wmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802291; c=relaxed/simple;
	bh=Gk/s1QmKWOyRkFbSOYyHTIq83dai7AhdGM7SfFaBuPI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qn+UULBpJwdHToFCl5YYhuSjYaT9IwN4DPJlNH0p6HvlZ5lX8+g+rgYg6Ypk5MdN06bxdpcBzQlDmJSSsrIYqqcErOYOp1DoiJrG7dlEQETZnVQNSm8ivIHA9MDjtiprLA/9z7yEkxCOGXJ+Ng6j7/lagQqAkoXvtPmHnhz/Z6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=YqIzKrKD; arc=fail smtp.client-ip=52.101.100.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaN9PmVajSb8I0oxedYtppUZynJvJmQ3bKogf45jvtaUAmeWJNp+nRk6n0/k1Y70mG+WTnWJD6ZgLGh0eew9HOblLQJHUHO49OxpmHYHuTkqZtDx3x+NXwNN2j9Gz1y5NcvQr8E7hujI8/zIOtbYyaMmSLKryKEGCsYy01iVJDrR+JBpK7IDTrIl3sqK4gxl1P/iGuGWeGLT/enIDBR7BdHWuFNYMfUvcA0WI+QeqkqS4Okw0aL3clVK7zGHjMePtp26X1ZLie0liI/WVzLEW4GX3zCTOni/X6nPnV1Q0sqoc8SHmjq2hYwzhMv6gZ+IpYtFXnUeO0ocKvB1WfnATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kh1aAM79nSSG3iJeQxH9mLkI+xzZ7w6p/3GFSVVcQo=;
 b=EGXzDVXD9QTTpUbp0JSD/YhMgMfdecf1tk9Nao5vCwLUBWSaYBuvZ+RCcRYAsUOcEjGLIOLxuRfZzRQX4glJ18BmunDT5xfomPIt8Mqp1vM2Gfiz8pyv02MqwIrjBrWlkur9lEwVUOuUVkZ6RgveMsY7R6KZs5WjBlVluQLxcWTUWvTof1l5fQqxcEKqCcqivqCfcJ2MEzFmE1v2LjLegu653capaOPV/xGsvc4C6mN4Q1OlNs9xPil3HKf6/eSrMJR25V60XP8E3oFwzD/WgfIOy/420ZCmKZNhehc7YurGEXgNMyYnN8zRGblHVZtywigq4eOlLD1CvbEKOf8Tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kh1aAM79nSSG3iJeQxH9mLkI+xzZ7w6p/3GFSVVcQo=;
 b=YqIzKrKD2JEXkavoLvI/3nde6LeWypQogZZ0GJvcJr3p1YuOdnQ7xporjE9J2kzXt/i8VkkY5TFEPCeiOyKFMthhloH7S1cNZlj+ufincdNfxyLRLDgwzdAxOrRTIv01M4DFUqqfisKP9nEIFzgjBetcSjIpWScHWKztgr7k+Vk=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6966.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:04:45 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 17:04:45 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 18 Jun 2026 18:03:39 +0100
Subject: [PATCH 02/10] rust: driver: simplify `IdArray::new_without_index`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-id_info-v1-2-96af1e559ef9@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781802282; l=5841;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=Gk/s1QmKWOyRkFbSOYyHTIq83dai7AhdGM7SfFaBuPI=;
 b=HkAKGQSjxaLathzltTEQRKg3qlF1AWk9a5m4y+/Jbuen38KI3zuneGBu7dc9g1RCpFSH7qhSz
 MIhFEeTvgX9AeFnbJJBw2tGRwu0KPvypyieL0kn/b6K9uiNxd8nkjVT
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
X-MS-Office365-Filtering-Correlation-Id: 8b94e8ed-874e-4734-de1d-08decd5bb228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|376014|366016|7416014|921020|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EwCMskArYRIoAioMbfSPazGeHPMOdmee+S7txVKEXmYrmGUlXmbg6J0r8gFw6groR/YjcSsoWmkBH05JlbEzfhQARwuDvwbb7ityU9pewm+Zk3qDXLpDXy5kArsDNxObLhk6IUB/htcdlEC8Zz6afc4iVetDUyLCVpZIY+3hp85hThvB0afbrBaFZyJ3v+sS84xDBeQwk+/5J8dF9nlYw8DhSFhJnpxrjnBMVFEGm1WORd+0FbAs1cvsFKa0hKuSQvNfuyfy1kp4MFJMbkKip2nPBECWEJeo6YR02tSXrTnRPLtQcJxjLEGzVhRqzPuvWoC/PIjX2NFyyq4Q0Jb0V4ho3y8IsFQTnGYvm27nV9n3yJJtAQzNnVjvZKTKcARA9YbXt1Js/4bOr9SmcUbLM1rrnK/CxIxsg3Xk99mvodEA1Ytu3kCDYdXRr0UfzKvPSLTtaeWEhdx7v62fs7u+Wahwe1W+tp8lBvykLQvx2fQuUCIEYxj5S1jhnJq1U8cfbUWu82FJ/Oy6qyPdWxsPHhOJf5oCL91HKSznGoNenQdBfIvcAzp3mpHFXeFeNYDCfMBbB9774jcFY+V56QLyEzOaSzS6SCjQFRGBQuivltJtPbIe39Njt3grDjOGUEc4bGQiWJBDFJxxx2+XzzkSp10pSe/veYSKIQ+ZaFSt4wO4rA4fGR8aQpYP+c3e4oKku7Xljf5Qw2toro4Rt/lOmiD0HIkMtB2h/JsVtvIEWq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(7416014)(921020)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS9hd1c0ODY5UVJxZFVjVHVSa3YvRDU4QVQvMzBQVmhja3pNRzVwVDJvVCtS?=
 =?utf-8?B?bkZiNG9LZmdhbG5Fdm0xTDRkSWtKSml3ajVmV3NreHNjT2tvT0VNUkNod0RV?=
 =?utf-8?B?STZ0N0pMNUpjK1FQUTF6YWNZSE1pMlhnb0htcEppdm5tNXRDZWtKYjhRQzBw?=
 =?utf-8?B?QTYwakd4YUpIWlVlNjZneDhwVnNnN21BODBncTYrSEM5MGpoRHRXSjNDNi9j?=
 =?utf-8?B?bHJzQWR0TXVRSDBBbmlvVzVQOWtvUkV0MzJCZSs0bFJlbW53OHdBTytrR29x?=
 =?utf-8?B?VUdnU0VFKzdkMEtBcTAvK0tXdmljK1JOamdVbzVTOS9aTjllWDVhNlFoZVJz?=
 =?utf-8?B?cGZnTnpxWTlrQXk0OGJHZHZXS2dVTXh0VENpSEllaDlqVjRHN280M0k2Zkdt?=
 =?utf-8?B?bzZER2tTeitMcHRoTGVvekd4RUVVcTZINW5iZGdWSU9jM1d3TGYwUjgrVmtY?=
 =?utf-8?B?ME1YNWRUKzU4L0hzc0lZMWNjOWNMMkZJZnJoVkJNbG5wVGRwZER3eWo2Um1u?=
 =?utf-8?B?UjgxeHd2MUVLYSs5M2h5QWwrRm1aeVplVHJLRzZXN09mNE00bkp6WTZBME11?=
 =?utf-8?B?WC8vcFBYTk50MVVLNjhLMkphNHRlQ3JMY3RhVzZEc3paSU9ZYVgyT1VxZlhv?=
 =?utf-8?B?VHk1NkJyZnVRT3U5d0d6MStnTVFDRGgvWG1lZVE3NHFXOEdEaExQMjRFVDVz?=
 =?utf-8?B?S2tWZW9Vd2J6elBNNE4xcnR0UmgvZ2kxY2NRK01KSTkvT3FuZjk3eUl3L3J5?=
 =?utf-8?B?VG5CQU1kUkc5ajBzRFNiZGN6eXcvRjZlV1U4aTlJM0s0WnlNQ3kvTzgrM2xO?=
 =?utf-8?B?bmJJT3pDd3V4TndLLy9FeVNjS1I3a0ZVZXg4WTVBb0xOK05mVlJNU0tkMjJ2?=
 =?utf-8?B?ZHBsbkUrcDdqN09Zd1VDZUF2SXZ3VzdPR1d3bXpsUUl4U1pCdEJyMVhsRXkz?=
 =?utf-8?B?WTZUSklUQUFPN1Z5U25aUUx6bkpCUjVybWR1QllxOTQwRStDTy9uS0RnallG?=
 =?utf-8?B?M3E0S1BkUU44bHViMHZaZjdYNy9zOTlRQkx4OUdTQ2VMMmFiVHhFYjNSQk9x?=
 =?utf-8?B?Z2JmaGpaNzBFZGM1RkNiRFlOd2lpTHRMSHJicVFLM29qL2RhdTJRMzNYN2Vt?=
 =?utf-8?B?RjdhMklQTUN3bmNmU1RaZmMvQTEyYmQwcVBGUElKUExFbU92N1lZREpOVWJB?=
 =?utf-8?B?NTltMk5xdEFCNHlHVTJYeUl6b21laWs3MC9ZcEFGY0NhRk1jNFpyRjJXeDN0?=
 =?utf-8?B?N0hKUkdCTmVudE02d0ZKVm9kTjdQLzR2SlcwSDYwQms2Z0VKeE9ZaWpLbWlq?=
 =?utf-8?B?ejNDL3lJMFJhSHhJQ1QvaXV2ZkErZ2VUVzBFR1F0MWJhTzhKbWxpSHB2VXQ0?=
 =?utf-8?B?N3N2dEIwVTVBTURkQWZlNUhpRDRScGZJeEdBT0Q2Rlc0Z3lhUmxJNjZOWURi?=
 =?utf-8?B?d2U3aWpEYnYzS0F2cG9KQnAxa2ZLS013bllUTUpZTHNkTHBKSzJGN0hQc3Ur?=
 =?utf-8?B?YlVVbm5Obk5UdncyQ09QRWVza20rN3FpWFB5K3NjSGZ4c3NlUWtjclFueG5G?=
 =?utf-8?B?M1J2TEorTnlwemhvNks1U1l5UE16SUl1cW01WGFvWU9PcTBVampkcDh3WDRN?=
 =?utf-8?B?WTJ2REc3SEV1ckh3U0xUK041L21QWmh2dEhTeXROU3NBTlRjeEdJMHhiZVBp?=
 =?utf-8?B?MWc2SGhiQkd4eExaak82SUZ4cmtpUmVhb2tmR2hsNDFEZXl5MlFiYnpWR09k?=
 =?utf-8?B?YVl3UFk2c0d0N1EvbHR3bXdCdDRFaGROeU1Xc2wwd2lFdlFMRkZpa3YyZjZt?=
 =?utf-8?B?ZW9VOWx6a1BwQnhYNWxNZVpFaXgxMXRYRSt3VTJNZVloVVRBMUlMekIxSXo3?=
 =?utf-8?B?ekNMN1I2TktSMmVTcy9UQklrK2F3N2Z4ZHJnYVVGVjBTLzVpTWFwQkxsMVhS?=
 =?utf-8?B?WWl2M3ZIV2Ntb0FqT2JhZy9iOE9wL1JqeS9nMDIwdDQ0YUg3MGk4YldIamlk?=
 =?utf-8?B?MnZtclpIVHRORzFOZHhoQWp1b0s2M1ZqZzdSNjJSYUo5QXE4MWRTU2JxTEpT?=
 =?utf-8?B?WWtmMFhTOGtMeTExSlVEZmdSaGVaRHN6UVFkQ2dWNC80Nm5IU3lnVkloOUxt?=
 =?utf-8?B?NnFmRURRMjBwQkk3Uy9XWXVGQVRMcXVNSHdoRXArc29zb2Q0V0NMdkI3Zjdh?=
 =?utf-8?B?MmVTNVpDbkwvOW82NE9lK2VmczB6NUN4cHF6SFI3aGJmYzgvZGdCODRCVU9V?=
 =?utf-8?B?UlRLY1BqUFZSNjlIVEVvc3UwL1JkcTNCcVY4NE11TlJEYldVTWpFVnlBQU1V?=
 =?utf-8?B?TFY0M05pbDJZZEZjeXpBeUNRZTJ2TmZQNTRxN2ZIYUlIRzk0SXRQQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b94e8ed-874e-4734-de1d-08decd5bb228
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:04:44.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ec/uq+JgKF6Zc5CJtIVGtztKBdLohcNER6yQIvRNej2mQLFUJSvZrsjMFXfkKoiIBZno00x+iO7zArT4xPsVrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6966
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9321-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75BAB6A1C0A

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


