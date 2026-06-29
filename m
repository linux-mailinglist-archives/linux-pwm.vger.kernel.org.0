Return-Path: <linux-pwm+bounces-9470-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P1XdKZ5uQmor7AkAu9opvQ
	(envelope-from <linux-pwm+bounces-9470-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:09:50 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A676DAD2D
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:09:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=zPcfERWv;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9470-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9470-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEB0A333355B
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7A340963F;
	Mon, 29 Jun 2026 12:39:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91318409119;
	Mon, 29 Jun 2026 12:39:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736797; cv=fail; b=TpLXu6fcHYGJ1bJLVpupOUGUnI99g4feOP7KrWujUap7ZLJR/hmkjDRPvZrH8TmOARsCcz6YhHGrqI/i1YmTjP1fZPwHu0Pcr+A+T4jIscLAF5aQCFPm9cdsNNN7zsCdvw2VVkWuuGB1Yq4pLVgMFMXJ5Mqj5FoeT4YL6hyJ9N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736797; c=relaxed/simple;
	bh=wVcj78N9wVvh2sAT33+asBscMJBGdyu7LkINQ6VSVmk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nuTqGiIEru+c00X25iQAJL2wcyBtxULJANeaNwI/9vMm0jLby4KnBzKLdzSiupoF+177PN0sn9fqzE+YXxNxwB9EcEOTkeJulyQWKBJ4/5knRe+tViIS2zlxU2dn2cc4tTYtZisodgv8qHG6prLsmInVu0cz36c98vzUWQqZcSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zPcfERWv; arc=fail smtp.client-ip=52.101.196.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTfFx4onjKlKyr4aXOYsT5Ax6DhbIrtSA/i8SdXU5zVSHYOhT1/Jg/oeSUWpRk6388rWqckIbUrhSvqdMAU1T0xJugcFP4RwqIFDl69KniUIQ2nRbTC5y9QYYKA00pTV3H4TPmb2LN/FsPHSvK1qmvg2qJ+/wbcgyuJ9HuhYBdq2KuFcA+LM5D88r/PLdp3FXUQ78L91HWRAfLjmQqQVxhK2BxQwFNTOdHf6ryCiE4W3ZU0aS3WZVsMWSBxAiPr8DLkQs64aWsX9nNThQAEwBtefe9RHcIvEbBSzFAE3yYlyxRJR3oKFwXgZVV10fBcMG+xRJUqJFLEO6ub1yXSmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Cgm7hIhtauEadGKhNLmDZ9v9FxV/0cq6XN9RPhQdRU=;
 b=e8hA8PAX2hpHIP1a6ruzLdMyZmQOuOzJZuUxOs++3OwnGuAJysnXFnHEiq+z10PyXYFyiWdgDctyeJ9N1IV+7JBrfzZqtwcnzPnJv6mPR4Dw2WNQmbjcYiBlxKtaiWy7/H/c9U8rFCZtrBfgH8sdcBGrgfMW/SuYGIR60qldEwIKmw0xfXbYdjcJCgsglZ9llRNTAH5wck0xkUkExk+uNs6cvFvsVvI0P10zt/W6lEtRCO6iZuCYZJpK6pIHCMut0B7KzPOsStkQgEM2wfEUK5o3OlgAwzFruEvvvrXTcEklMq8kpq+rb6dIGkL5DGxrEA53onhR+dO0JwMqTCyy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Cgm7hIhtauEadGKhNLmDZ9v9FxV/0cq6XN9RPhQdRU=;
 b=zPcfERWvkru3GGo3FkaJoAhw/jXvwtBth4VJo3wsxMB6bhQo/sWzWe5ePkmrNSoT/iY7CAllmOsojWKK/lNOqT4E5nF4em16WpJENRIC/JXCDfhTxnvKb/B4y40X3zCobEPr2pQORyn6zOkFfxclLT0sAqeIfVKz7PgPUV74Y8M=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2670.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Mon, 29 Jun
 2026 12:39:46 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:46 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 29 Jun 2026 13:39:43 +0100
Subject: [PATCH v2 09/11] rust: driver: remove open-coded matching logic
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-id_info-v2-9-56fccbe9c5ef@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736778; l=12522;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=wVcj78N9wVvh2sAT33+asBscMJBGdyu7LkINQ6VSVmk=;
 b=H67NaSI767NV6NnEFPQhYIteQuDFFo35LNnYNeScyQsBaVeAPIbhPKlteVe8z3s88T5nh825Z
 GQpOkmqapb5ADZMdK+Spyja9dCaUyGoTPTAt/MCgF6n14tM5+xSWYK+
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2670:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca2ee85-5144-4ae0-dafb-08ded5db808b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10070799003|22082099003|18002099003|921020|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ykp/w1b8yf9PjbAKievie5xIRPeq5F9kOFVbBmyczaQ/XrmmvjHef+k5TgO05uxGnk4em5aLZMnJLzTejayXr0th5HuMENB9gLpmNcEqgl6aRj0OFq6a7Ax82o60DE8dPKPV45mMqeZ2GcvF4CuOUJmEA3gRSBqDWG7WoKRlh++VaHBmiNHJVjtUvfwe7CCj3Ro1ZNMvwTO6DGcEfy2ViLzfzFBOnLtqTZYUEd/f81QRjlBHyDAOBAcG8NThiHW/JEUBnK4coxIS2JaXYT2w2AFzI90+cBwauCBQEc9RoPzWPA9rhuM4Q8MKgQwMF5TEG3DnuGYs4rvogNouOeg6CMBEmcDOZT5n+LSUh+ZJw1FlZRhycdD3baOxg3t4X/MNTzjsXMnURwL74N3NbT32OFszykuvnSNqfvj/oOZcw6tqB3xTAZjiGilHLDV3D0y2Rri8eumN2p47TZwAvx7y7uG+UeUCQY9cu3gY0Im3ot22XJcIGn/5YyYRrUipJUoVo22m8YBwZhL8sXsfyDUlbJt87237RHqHy2w10isdsmBmFHd+iw95PaFKbfUrbQ4sDNpYoOdOKnXBI9/gcGhr9KHSS9zZbA/ZdiUyDJ5nwRxqtVmFuDaZ3nq0riI0F9yACe9oZNQRWGUFVHcsWk3bxa8OLLGg5fINjkpDG0QUtKFE71dfyD+/QXWc6NTD1Yg60YuZrD6yoQngS8JCdNMhBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10070799003)(22082099003)(18002099003)(921020)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFh3ZUlGd2lDRE9mY0JPSDNidGlKRStCSEZkeTFFYTVEWXBnL2ZLWEVYeUVh?=
 =?utf-8?B?SHE4VisrUThnKytEbURTT256MnhXdjFOWjhOUUN2ZTVMSW5TdE1uMmZSLzEy?=
 =?utf-8?B?dm5jc2l1akZsTTlSdkdVQmVmY3MzK0JTdUdEcmliRVJxaFNoVDBlOThRK3I2?=
 =?utf-8?B?d3h5RGRMTnpVaWVtdTVHMk9RYUg2bjVIR3g4QlVyUFhQQVFYeXZaL0ZTWkRL?=
 =?utf-8?B?MVdBQkpRbHI3aVNZa2tZaTUwVTh3SzY5TXFVYXhSbEhmb1VWNmdwNFk2bHla?=
 =?utf-8?B?ek56aXIrOWFoMll1TmZJSi9jY0RiMjlrdmdLN3N1SGxTSTFoYzR1QlEydGpC?=
 =?utf-8?B?THkwN2VveWJSVnhNbFIwYlU2QStHbGlUWExrM0VRQ1pJNTNBd2RTRUVoMmFq?=
 =?utf-8?B?R3p2aUFza2hEanVMWUhnVzVvbG9oazVyUjJSRE85Z0o4OXB2VmRHQ0Vid0Ro?=
 =?utf-8?B?SVFwYUJaaUM4UVI3MWJGSVZGZEthb1h2ZGM5UlZtRGJTQ2ZiRE5BWkF2TDd3?=
 =?utf-8?B?bStnSDArMVdyelR0Vzh4dlFUVmVvSjF6ZVVVeG52bW5kU05vQ1ZUYVFlTGph?=
 =?utf-8?B?N0lUTER0MGNwVjJaR1VIMWlraE9kWEY1c2N0ZndiZk5GeTIyRWRXK1YrWWw3?=
 =?utf-8?B?UjhiTEdITEF3UTROMkVkY0VPb0RKWFVBcG5lejB5dWtybXdXMTlzZkZnS1R5?=
 =?utf-8?B?OTVVeko4SVowSGJHcVFlRnVoWjBXcENjSEtTWUV1RG8rRUZqamoxUVIxcXli?=
 =?utf-8?B?SWpCU21DdytiWmRMUlovZkxFc05yYmtOeDV1eWxROWRGYmRrZHZYUTkyeUxB?=
 =?utf-8?B?ZzByc2hUVG11M1Z3dk5qQ1kyYWVWamQ2NkpNbDZnT0RHWjJmS3RZV0U4bGpk?=
 =?utf-8?B?Sk9kcFdlNFgvbWx0Q0lYS0cxYVlSRjhTNFNSQlo4WXdQOFRLSkF1U1pDdHZV?=
 =?utf-8?B?cTdZOFhOSnVNb3N6STQzKzVEMWpSdDA2L0ZwZFlCWm4xQng5dS9mZHFDNUF0?=
 =?utf-8?B?ckVkdUFMdEM4TnQwMWtVdEt2TVY3MVgyTkxpYXBZd3ZQOWc5K3hQd1JjRDM1?=
 =?utf-8?B?Slp6QzdraTl4U3dKN1BpZXZmMzNoRjVWZ1hhb2JvcEdNemJVYmtCOEZxOERy?=
 =?utf-8?B?ekxyUkc5MkV1RnhHQ0FxY0IxbUowb3YwUDY5a2tWaS9jNGU4Slc3N2FLYUc0?=
 =?utf-8?B?Y2dMQXlWazhOdm9ScDFyUEhPL2drditORUtDSHhYTzZEMjI1Ym9LN3l1TGIx?=
 =?utf-8?B?M1pkOTQ5VFZuOFVweVBtZ0pGRzNBQ0JyRkpieGdySjQwbmMzMkIrOEsxWVQw?=
 =?utf-8?B?Zm9wam82aHNTTXcxSmpRWVhiZHVWR29YZzlhdmFRK1VXcEZvRTd2NHIwQlgw?=
 =?utf-8?B?MkorbGFCcFZVMDUzNWduY0RFTmVSY1J5c0JkcHI2OXNzQ3ZaL2NmVG1udkhq?=
 =?utf-8?B?SHBhSDNwTHpDTURzOFc2QUROQkpYenk1YTM2NFNwOUYxOTdzY2VFdEF4OFJI?=
 =?utf-8?B?VlZlTm5HWHdnRXhzNXpnZnI5dG5KcjE2TWlIUkZ2N1B2VWxaQTAreHJkZERx?=
 =?utf-8?B?VVQ1NExqNU9vZzFhclVGNFFrMnZJY3RJQm5ocUlnWGtpL2NXeERMdXIrRlp3?=
 =?utf-8?B?V1A2bStSZW1SYnJIczVCQkJyRHlVb0ZhK3kxNnBUU1JZbWpBMTI4OGVac0Vn?=
 =?utf-8?B?c3o3cEhXekx6ejVJZzkvVUFSM2QxZ2svdjFpVWFyRFQ0cXJabWZ6N2gwNVEz?=
 =?utf-8?B?ZDU3VXpVaWE3WlFETWFnSVFPYU5LMFVZOFlBcDhJakl6VkI3TnB1TjRCTXNK?=
 =?utf-8?B?cXdoZER6TFBpclNOMHl6V1RrWnBPU1RxZlM4T1U2OEpXZXUyZXBnaDFQSXBM?=
 =?utf-8?B?ZWs5RXdDWDBpUUYwcWRFUWxIUlNLbXVkSjNHcG1wM25SaTFjWVZNRmY5NGpp?=
 =?utf-8?B?Nit1S3B6dWpZSzFtMHdLSzM4dWlCekFhaWtuZlZOeHNzQW5SRElPNm5PbGhX?=
 =?utf-8?B?NFZxM3hiT2d5MlNadGtuL3dxY2RKbmpMMHRray9nM3FuMGFMWnNaNWhzUlkv?=
 =?utf-8?B?SlVLZWlSRDNwUmlUcVVZQmpaSnhNL1lpd0l5Ri9oSFVTUGRDbGhtYVVRaE96?=
 =?utf-8?B?aWFDTXhxaG9xNUxmMzE1MnlVdys2S3JiQzFScVNBa2ZWTVNUcWJNMlpYcWds?=
 =?utf-8?B?MGNVUmVCNUxnUkFpdGNsM0xlb0lveGh5TEhVeHRka0tGL0VDcDhscTJNWEll?=
 =?utf-8?B?c2h1Wm5PeVliVC9LNEhXcUp6WVlkUko2VnhsaE9ZWTc5R3NWQnNUUGhMNHBF?=
 =?utf-8?B?UnEzVWU1MUx5Q2tGOGxZUC92L1dYT0gzS0RQRmxWNkpTSitPRWtKQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca2ee85-5144-4ae0-dafb-08ded5db808b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:39:46.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ig5gwvE5M6asozpRW5+IpHs9r71oOFHNNnPsV9fMi8elAi7jAmtRWlcuaiNoV2cH33bOCtT0WhZnJTAWfr+eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2670
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
	TAGGED_FROM(0.00)[bounces-9470-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26A676DAD2D

With device ID info now including pointers instead of indices, the
open-coded ACPI/OF matching is no longer needed and can be replaced with
`device_get_match_data`.

With the removal of open-coded matching, the exposed functions and helpers
are also removed; this effectively reverts most of commit 2690d071584e
("rust: ACPI: fix missing match data for PRP0001").

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 MAINTAINERS             |   1 -
 drivers/acpi/bus.c      |   6 +--
 include/acpi/acpi_bus.h |  11 ----
 rust/helpers/acpi.c     |  16 ------
 rust/helpers/helpers.c  |   1 -
 rust/kernel/driver.rs   | 137 ++++--------------------------------------------
 rust/kernel/i2c.rs      |   6 ++-
 rust/kernel/platform.rs |   3 +-
 8 files changed, 20 insertions(+), 161 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..07240e0b7451 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -297,7 +297,6 @@ F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
 F:	include/linux/fw_table.h
 F:	lib/fw_table.c
-F:	rust/helpers/acpi.c
 F:	rust/kernel/acpi.rs
 F:	tools/power/acpi/
 
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a30a904f6535..1fb0b10bf924 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -898,9 +898,9 @@ const struct acpi_device *acpi_companion_match(const struct device *dev)
  * identifiers and a _DSD object with the "compatible" property, use that
  * property to match against the given list of identifiers.
  */
-bool acpi_of_match_device(const struct acpi_device *adev,
-			  const struct of_device_id *of_match_table,
-			  const struct of_device_id **of_id)
+static bool acpi_of_match_device(const struct acpi_device *adev,
+				 const struct of_device_id *of_match_table,
+				 const struct of_device_id **of_id)
 {
 	const union acpi_object *of_compatible, *obj;
 	int i, nval;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 714d111d8053..7e57f9698f7c 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -189,10 +189,6 @@ struct acpi_driver {
  * -----------
  */
 
-bool acpi_of_match_device(const struct acpi_device *adev,
-			  const struct of_device_id *of_match_table,
-			  const struct of_device_id **of_id);
-
 /* Status (_STA) */
 
 struct acpi_device_status {
@@ -1000,13 +996,6 @@ int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
 u32 arch_acpi_add_auto_dep(acpi_handle handle);
 #else	/* CONFIG_ACPI */
 
-static inline bool acpi_of_match_device(const struct acpi_device *adev,
-					const struct of_device_id *of_match_table,
-					const struct of_device_id **of_id)
-{
-	return false;
-}
-
 static inline int register_acpi_bus_type(void *bus) { return 0; }
 static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
diff --git a/rust/helpers/acpi.c b/rust/helpers/acpi.c
deleted file mode 100644
index e75c9807bbad..000000000000
--- a/rust/helpers/acpi.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/acpi.h>
-#include <acpi/acpi_bus.h>
-
-__rust_helper bool rust_helper_acpi_of_match_device(const struct acpi_device *adev,
-						    const struct of_device_id *of_match_table,
-						    const struct of_device_id **of_id)
-{
-	return acpi_of_match_device(adev, of_match_table, of_id);
-}
-
-__rust_helper struct acpi_device *rust_helper_to_acpi_device_node(struct fwnode_handle *fwnode)
-{
-	return to_acpi_device_node(fwnode);
-}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 998e31052e66..fadd7acdd81c 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -38,7 +38,6 @@
 #define __rust_helper __always_inline
 #endif
 
-#include "acpi.c"
 #include "atomic.c"
 #include "atomic_ext.c"
 #include "auxiliary.c"
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 824899d76fed..c9c74c4dde8f 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -107,7 +107,6 @@
 use crate::{
     acpi,
     device,
-    device_id::RawDeviceIdIndex,
     of,
     prelude::*,
     types::Opaque,
@@ -292,26 +291,6 @@ fn init(
     }
 }
 
-// Calling the FFI function directly from the `Adapter` impl may result in it being called
-// directly from driver modules. This happens since the Rust compiler will use monomorphisation, so
-// it might happen that functions are instantiated within the calling driver module. For now, work
-// around this with `#[inline(never)]` helpers.
-//
-// TODO: Remove once a more generic solution has been implemented. For instance, we may be able to
-// leverage `bindgen` to take care of this depending on whether a symbol is (already) exported.
-#[inline(never)]
-#[allow(clippy::missing_safety_doc)]
-#[allow(dead_code)]
-#[must_use]
-unsafe fn acpi_of_match_device(
-    adev: *const bindings::acpi_device,
-    of_match_table: *const bindings::of_device_id,
-    of_id: *mut *const bindings::of_device_id,
-) -> bool {
-    // SAFETY: Safety requirements are the same as `bindings::acpi_of_match_device`.
-    unsafe { bindings::acpi_of_match_device(adev, of_match_table, of_id) }
-}
-
 /// The bus independent adapter to match a drivers and a devices.
 ///
 /// This trait should be implemented by the bus specific adapter, which represents the connection
@@ -325,117 +304,23 @@ pub trait Adapter {
     /// The [`acpi::IdTable`] of the corresponding driver
     fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>>;
 
-    /// Returns the driver's private data from the matching entry in the [`acpi::IdTable`], if any.
-    ///
-    /// If this returns `None`, it means there is no match with an entry in the [`acpi::IdTable`].
-    fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        #[cfg(not(CONFIG_ACPI))]
-        {
-            let _ = dev;
-            None
-        }
-
-        #[cfg(CONFIG_ACPI)]
-        {
-            let table = Self::acpi_id_table()?;
-
-            // SAFETY:
-            // - `table` has static lifetime, hence it's valid for read,
-            // - `dev` is guaranteed to be valid while it's alive, and so is `dev.as_raw()`.
-            let raw_id = unsafe { bindings::acpi_match_device(table.as_ptr(), dev.as_raw()) };
-
-            if raw_id.is_null() {
-                None
-            } else {
-                // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct acpi_device_id`
-                // and does not add additional invariants, so it's safe to transmute.
-                let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
-
-                // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
-                Some(unsafe { id.info_unchecked::<Self::IdInfo>() })
-            }
-        }
-    }
-
     /// The [`of::IdTable`] of the corresponding driver.
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>>;
 
-    /// Returns the driver's private data from the matching entry in the [`of::IdTable`], if any.
-    ///
-    /// If this returns `None`, it means there is no match with an entry in the [`of::IdTable`].
-    fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        let table = Self::of_id_table()?;
-
-        #[cfg(not(any(CONFIG_OF, CONFIG_ACPI)))]
-        {
-            let _ = (dev, table);
-        }
-
-        #[cfg(CONFIG_OF)]
-        {
-            // SAFETY:
-            // - `table` has static lifetime, hence it's valid for read,
-            // - `dev` is guaranteed to be valid while it's alive, and so is `dev.as_raw()`.
-            let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), dev.as_raw()) };
-
-            if !raw_id.is_null() {
-                // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct of_device_id`
-                // and does not add additional invariants, so it's safe to transmute.
-                let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
-
-                // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
-                return Some(unsafe { id.info_unchecked::<Self::IdInfo>() });
-            }
-        }
-
-        #[cfg(CONFIG_ACPI)]
-        {
-            use core::ptr;
-            use device::property::FwNode;
-
-            let mut raw_id = ptr::null();
-
-            let fwnode = dev.fwnode().map_or(ptr::null_mut(), FwNode::as_raw);
-
-            // SAFETY: `fwnode` is a pointer to a valid `fwnode_handle`. A null pointer will be
-            // passed through the function.
-            let adev = unsafe { bindings::to_acpi_device_node(fwnode) };
-
-            // SAFETY:
-            // - `adev` is a valid pointer to `acpi_device` or is null. It is guaranteed to be
-            //   valid as long as `dev` is alive.
-            // - `table` has static lifetime, hence it's valid for read.
-            if unsafe { acpi_of_match_device(adev, table.as_ptr(), &raw mut raw_id) } {
-                // SAFETY:
-                // - the function returns true, therefore `raw_id` has been set to a pointer to a
-                //   valid `of_device_id`.
-                // - `DeviceId` is a `#[repr(transparent)]` wrapper of `struct of_device_id`
-                //   and does not add additional invariants, so it's safe to transmute.
-                let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
-
-                // SAFETY: `id` comes from `table` which is of type `IdArray<_, Self::IdInfo>`.
-                return Some(unsafe { id.info_unchecked::<Self::IdInfo>() });
-            }
-        }
-
-        None
-    }
-
     /// Returns the driver's private data from the matching entry of any of the ID tables, if any.
     ///
     /// If this returns `None`, it means that there is no match in any of the ID tables directly
     /// associated with a [`device::Device`].
-    fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        let id = Self::acpi_id_info(dev);
-        if id.is_some() {
-            return id;
-        }
-
-        let id = Self::of_id_info(dev);
-        if id.is_some() {
-            return id;
-        }
-
-        None
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the `dev` matched data is of type `Self::IdInfo`.
+    #[inline]
+    unsafe fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
+        // SAFETY: `dev` is guaranteed to be valid while it's alive, and so is `dev.as_raw()`.
+        let data = unsafe { bindings::device_get_match_data(dev.as_raw()) };
+
+        // SAFETY: Per safety requirement, `data` is of type `Self::IdInfo`.
+        unsafe { data.cast::<Self::IdInfo>().as_ref() }
     }
 }
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 31f2cfe6be31..2d2191164e25 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -149,8 +149,10 @@ extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_
         // INVARIANT: `idev` is valid for the duration of `probe_callback()`.
         let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal<'_>>>() };
 
-        let info =
-            Self::i2c_id_info(idev).or_else(|| <Self as driver::Adapter>::id_info(idev.as_ref()));
+        let info = Self::i2c_id_info(idev).or_else(|| {
+            // SAFETY: `idev` matched data is of type `Self::IdInfo`.
+            unsafe { <Self as driver::Adapter>::id_info(idev.as_ref()) }
+        });
 
         from_result(|| {
             let data = T::probe(idev, info);
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 210a815925ce..e12e88113ca5 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -100,7 +100,8 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
         //
         // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
         let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
-        let info = <Self as driver::Adapter>::id_info(pdev.as_ref());
+        // SAFETY: `pdev` matched data is of type `Self::IdInfo`.
+        let info = unsafe { <Self as driver::Adapter>::id_info(pdev.as_ref()) };
 
         from_result(|| {
             let data = T::probe(pdev, info);

-- 
2.54.0


