Return-Path: <linux-pwm+bounces-9461-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CahBCddtQmrV6wkAu9opvQ
	(envelope-from <linux-pwm+bounces-9461-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:06:31 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DD26DABF2
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:06:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b="ECA/6Via";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9461-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9461-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 305DC31581E2
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957753FF882;
	Mon, 29 Jun 2026 12:39:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020104.outbound.protection.outlook.com [52.101.196.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDBE308F39;
	Mon, 29 Jun 2026 12:39:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736785; cv=fail; b=uK/R5iFIwwd4HFk5LF3oh8zKMD3O4C5Q2pWU93LBoBw86SC844g54a6BupgL/o7hqyacUFXyNLfyNXLtPPRyTH9Z5j4N0Azz/clj8llh7aZyq9gKX0KYY1ExwmkJwjxa9fdzt/h3Ru6puT17aiPhS03XQWicyr5W1eESCnbMUmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736785; c=relaxed/simple;
	bh=HhdpyPupZL4/FjKYfaoCdFtZHkH8NnJ1vLSVhYlNxgw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TrafbaPJttweR4PYzs8k7Ku/AYCWIZn4XHuUcyvmkTdCO3IbqfaL41guTMMeusnBdOY/sRqcu7oAUtMHZtFkWwOkG7TVdVBoGorB+e0PFgXsLkmsEWLVojziNSORmR+38A9AnXLoUUXHaQMdtwoiS2j3D5Mn45QVzv912BmxbXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ECA/6Via; arc=fail smtp.client-ip=52.101.196.104
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K25Kl82kQ9vp24Z5ZCcgPGz8ssbpYLSC4x04x0ZNeFLBkomq5y28EZp5F6Hf/+HV7TPxMcVOwy+MmYccgs0qyTrPgl9LD7Y2zKJITH55YZlQ/SG3tBHKLMYSVMdX4HGrawQofrpA25hGw/s5PtCyd2RaHg3GYLjepX6OFuOarWovxtMF+xmKuV330Y0UJKg5AGw3aJjfUVAllJ0GNFiimQ8AVU6vAvmFEJx5u3W+MPQvZH1qFjGkmNjXbZnLZegw4g/Gs1toPyn3UG2vIzUEkL+SwRyT5x7DxhwGg5UzRB7+oyvNBTg3H7gs/gep5/I+8JkQ4vFh4rKT4u3qcObNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrhhCsAMRIAcU27Y2Tt9C0sSU03E1gIx/ccCWojECQ8=;
 b=LB9QsGdSYQxmH3W3QELWYtSNeEi1D0jWHQ5rfrpPZ2zw+IVn5AmFj0iHl5WkKrQAWmB7LdCLeyRzRosrvujFKIbLJujZgsVl81GlPHe89K0+yVbyzrIk/pGvAaAZN0Xe8rC6ox5eaUBNxcGS/0fYpCDq5V6ucTD1lHjepLQFA+owLvA/bmjWtxnHf5UMTWwH2VGXfpne/p3tMrD5+LjBKhVodJl00G3VoHKpSLEQ3f1AtANN8+Zib0QtcZgrZ2GqrHt5sceqPFrvrqONIMupyrknTY/RzeyMnHkWKvBHwX6r/MC7Y46GEua+714Ucvk4E782frzpEm+fY/5YUAMWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrhhCsAMRIAcU27Y2Tt9C0sSU03E1gIx/ccCWojECQ8=;
 b=ECA/6VialcHv4ns+TL5Q1qPmOesqbtY5wY6m3bvwDX8r/6kiRqIqKJ4RC3cClpj4X/MDC31tfKDWyblnKrb6dO5HaxQu7k3NVhxC2th39yORt6GuFE/k/gHHe5itwtabDq3jTyhG9rjwX6QRX4nkwSI3T2FjhMpLgg0UP5JvzPI=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3081.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:174::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:39:40 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:39:40 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 29 Jun 2026 13:39:35 +0100
Subject: [PATCH v2 01/11] rust: driver: remove `IdTable::id`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-id_info-v2-1-56fccbe9c5ef@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782736778; l=1028;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=HhdpyPupZL4/FjKYfaoCdFtZHkH8NnJ1vLSVhYlNxgw=;
 b=bKykAjfofJa5s1dXcatJBRYk+LqcvNznLXDDkzf6xW+x9pKjpaeVATJcM45b/6JuMP2T9cEcq
 g1h6BPBQb2TCEmNKowmv4UP3N1eWuLk3ST7XPb+iq8jEFoDa0JM/2NB
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
X-MS-Office365-Filtering-Correlation-Id: 89d595a3-f986-48a6-9f9a-08ded5db7cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	TYBMsGgsoUg5XrU84oB7WrTDLe+mGr1qVJWSGoEDJdHwrIa5wrQFpdA8+xJueqFYL/V2CHrNPXU+V1/tiAJ9A1OWFQnYViYupyNAJ99NvQAhrqScQloer01foLO+zRlMCtBrqJkpMzT9eFzsD7WVNOvDwjam+4iotQXCVum7UW8rnw0D1sDrfN8xbwlNWoZ+Trr1lyOeIPE0bRXL47FYnH4LpK+lmaYw5hOABWASx5QjlvpUHsapJdvhFkxioSo30e2A/WcudccM2/COyWKfWDWWrmPEUAMKsaTrVSF7VUyCNzBDUZiatkP3HpTLrvF7BKzowBSnl0nS8cLhQ7RjWzrCQ86b1oFZ2hKVtJRSF/h8eDKV034MnYVf2O1xQXV8WNYN0DvIK8s1+R9xswW9qX52xQkhdAXMichiVhp6lcr0qdGJXGYxCrvfuXC8pyJ8UiQsGM+rnpRZdM7F4ci7aGWN6wYUS9FNn4+tbk5Oz1M3z5sHlp+5PbEfDZKmPywq3DL2LUu8jHde3D8ko6vxgEdSkxDRl1Va7gO25uDlywq6PoHwldgRNkLWtPx4pRaebQ3FKxONtrJLIo3/WsPUHSXk1E71OdtFhLs9TthuMlo88I6HNFgaY7gGSNKQZ44wAeleikzwqGH60FJwuv3rs7XACkLdOvw6/NpNu5jqsNmqquFRxGb+4SVSd/InBT94dTMP//OXGT9XCIiFRwZLlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2xkN2pnVmEyN1VwdjZhYit5endUYm5oejNadVFDSUg2YTFuWUt5WmVLVnpu?=
 =?utf-8?B?MjZKbkc1ZE1JRGQvZDBOdkJ6bThGQ2ZwUzRGWnhQbVFtbTFSTWQvMm9reEM0?=
 =?utf-8?B?M1MrTlpXVEhXWDJ4aWM5Q2ErOXdJNGhpcndUQ3V5aU9qL0VESUJkK1Y2NEpN?=
 =?utf-8?B?VEhvSHhjRlJnR2JjclJwMDBSek4zUnpRM0tOTWRJQnB1TVNHUjhDc1k4WDFM?=
 =?utf-8?B?M21kWVFlMGxnYnpUTVVwZThnKzh4UXpZWkhvUXFUQjZlYlpVNlYxZk5mMWZF?=
 =?utf-8?B?cWRzYWRtTXk4UC9QajhZY25NTzNSWXVXZTJ2OUplcW5QVzBpN3FCNnRUL3Fi?=
 =?utf-8?B?emFmdzJRNHUwbjdBYy82S1pVVldmRldhWWxpZWZmUXJJbGRLRGN2OE9FUk5U?=
 =?utf-8?B?c01QRmI3N3l0VnFpclRtZjlJbUEwMVVEWUZ2TGdaKzZlTHVXOTlXWFZ2M05R?=
 =?utf-8?B?ZTRTOEF1eXpoT0c1TWE3cmlPVXFYOEtTc1VnbFAwWlNPbmNqM05HdkVnZjFU?=
 =?utf-8?B?cjFEREJmMW5yTnVKNzltTzc1Q1JXWG4rSk00aGNPSWk3VTI2TjgwVFducnNI?=
 =?utf-8?B?MHpWT3EyZWRtODlsZWw3L0NaN05TSTB0cE1wcTJjMkN1ak9tb2wzNGsxYnMz?=
 =?utf-8?B?U1lsNVZnL2lSdmlYT2ZaQ1ZuK1kxLy82MWthbDQ0QWdwL3VLUC9hbFVtRTcw?=
 =?utf-8?B?SklZY2w5WUZnS092MDJZSXRXRndRWWQwRVJ1SWF4Y0xLNGI4SWlhV0dFb1FO?=
 =?utf-8?B?K0hpUTZGS2o0Z0J2K2h4M0M4S0FtMDFUNXFHbHFxY2xoQ0R1S016dGQ2R1gz?=
 =?utf-8?B?RXJEWlF0YXMwUzZDWW1BV0loYlFhblVCbGUwTm1GRkVBUTB1cGpGdGhZTnky?=
 =?utf-8?B?Ny9CT2ErYVpyQjlHWk1wdkJxcWo4dFFoS1FxNG1QdzJFVTUyRG9ZUmc5MFZw?=
 =?utf-8?B?MkdqUVFROGZVUnlueGxEdUhQNi9zNjFwREduSytIcVZBQVROZ3p1aHovUVQw?=
 =?utf-8?B?RHJoaXpIdDVkL25IUlJVY2tVd0EzaC84TGUwRHNIWnI1aVIrdkZMc0JMbHNI?=
 =?utf-8?B?S2llVmw2V1lQOGRQNHRWT2lObE9KTCtaTzZmOExsNGd2N2MxMnZNdEM2NzNj?=
 =?utf-8?B?MlVtdnRIakZYTDhORmFlWWlFdHh2UC9NZmJkd2Jpejd5OU40bmloeFBoMVln?=
 =?utf-8?B?OGdhemJ4enFLODJMd2ZNaFJPY1JtdnNsT293VUFmWDJsREhxRUttQ0dzYWNh?=
 =?utf-8?B?NXNIOVBqQWY3VE04R3lXcVhmUmF2VmpRbDNDNUtkUjE4L0NkcWt2dzNLWFJY?=
 =?utf-8?B?bXAvdVZ6bGlYeTFEV085d2FiUkM1NDArZ0JaSWZLckRIZU44WjdoMVZLRG5l?=
 =?utf-8?B?L2E5eGNDWHY0T1QvOFZRWWZOY2NGOExmMUNCcmcwek9jdjBUb0xQSVFFc1di?=
 =?utf-8?B?cG5XM3Q4K0gva0ZUaUtLRmpFT1phYXZNT3l2WkY2QVhXQmgxN2V5Wmgzc05o?=
 =?utf-8?B?ckEyT1l4T2VGQjFqN1M2ZWJKM3Y0UEp3MmdNaFFzS0NEMy9zSGcxUnZzMGk2?=
 =?utf-8?B?Z3FJZzM5dmFUN3BZclJKaW1GM25WSmFMMC80aEhMSm9RQUpFWGhiY0ZSK3JU?=
 =?utf-8?B?L2NTUkJVcUVrQVVnNXhLOUc1azdIeTlSQStVaHJiNHZNdGlPZG5kaitBeFph?=
 =?utf-8?B?a3d5SmhNdDErcytwdjd3bkpkb3ppcEp0dFl2K3d6ZWtFNDBZd3Y5d0M1Mk9V?=
 =?utf-8?B?WkdkVWFiOHd3S0dtYzhIV1d0dVZVcXVXb2JZNWoyemdKYUoxdXFEK1RSNEFP?=
 =?utf-8?B?T05PUFJ3aEdPeFZvVHc1clJCdXo3cUJtSXhQSWlXV0ZycmJKY0tLQWJmUXhF?=
 =?utf-8?B?WHdPbHpaS0JxVE9ENGd5Qkt2alVXQVlkM000ejVLcEVEQmhMRFk3NXpsS1d1?=
 =?utf-8?B?aWtoc1JNb2lxSnJzTzRSd05ZZEYyQURaNk1uZWpTR1pZbGF0Q1NXOUJWK1Ax?=
 =?utf-8?B?T1pjYkhiN1Fxd0JZbzI0cHlJUnE1eGZldWZPR1o0L1c4N3EvL3daaHVtQVNC?=
 =?utf-8?B?YzhvRmxDNGhaZjVLcVozU0FzcWt4MHExUjVvWEpPOUY3ck90QkVPbWJBYkdB?=
 =?utf-8?B?SDlzeFhUMys5UEtUKzNhZjEzWXA0M3RlWXdmYnZPYWhsOFZKSk53d3pLM2xw?=
 =?utf-8?B?UXhhdkZHdDgzaWFjc0lHTXJucXVSK3dOODE4UDdDdWpBVXNkQzRyTFEzSVg1?=
 =?utf-8?B?RUkwRHhzVXYzdk5qUTg0NWN0NTZ1Zy8wbVRUZVY1c1d1R3YwU0VrUzRkczR6?=
 =?utf-8?B?QlhPRm85bVFGY050WEZtQjN3QUlzaUw1OFpFd0lLb255dlhSS3Zvdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d595a3-f986-48a6-9f9a-08ded5db7cc7
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:39:40.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDa/2HEjDnIGOAIBz4028lS3C20r3f5O3BHlLZPlFL5+UbuK+Q+MBvJih42iDuvzmTaGUBT9kiiYNLd6DNCgSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3081
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
	TAGGED_FROM(0.00)[bounces-9461-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75DD26DABF2

This is unused.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/device_id.rs | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
index 8e9721446014..fbf6d8e6afb9 100644
--- a/rust/kernel/device_id.rs
+++ b/rust/kernel/device_id.rs
@@ -166,9 +166,6 @@ pub trait IdTable<T: RawDeviceId, U> {
     /// Obtain the pointer to the ID table.
     fn as_ptr(&self) -> *const T::RawType;
 
-    /// Obtain the pointer to the bus specific device ID from an index.
-    fn id(&self, index: usize) -> &T::RawType;
-
     /// Obtain the pointer to the driver-specific information from an index.
     fn info(&self, index: usize) -> &U;
 }
@@ -180,10 +177,6 @@ fn as_ptr(&self) -> *const T::RawType {
         core::ptr::from_ref(self).cast()
     }
 
-    fn id(&self, index: usize) -> &T::RawType {
-        &self.raw_ids.ids[index]
-    }
-
     fn info(&self, index: usize) -> &U {
         &self.id_infos[index]
     }

-- 
2.54.0


