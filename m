Return-Path: <linux-pwm+bounces-9423-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HCfDOfCSPmovIQkAu9opvQ
	(envelope-from <linux-pwm+bounces-9423-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:55:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A56686CE30C
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:55:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=ofFBbKGq;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9423-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9423-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F34CB3097B0E
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C7402432;
	Fri, 26 Jun 2026 14:46:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022142.outbound.protection.outlook.com [52.101.101.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665E23FF8A5;
	Fri, 26 Jun 2026 14:45:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485162; cv=fail; b=m+cCWBH+QgtVInPArgsa3VSuY9L2Yb0CIK6OU5c9iXTwI6LutlmYjaRSwdZ1vesv7jn1cfYVwqGcer0Bf6r8LhKi5f2mh1+HjVhGG2JejUj4KWy9AYLfXY9O5vdj6FTMKCZiPHk2VqPwozz6Czds54S4N0oVOIonkOmKcnRK8cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485162; c=relaxed/simple;
	bh=SLXPuZTc9Sviatlqi4rEX+pEW0YEAl3QUQB+PjUuFPI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LywivJFWdvBLDKSItKzB/Y+z6DvgEmnhMGxsLDJnNzkr6d60O9LgrsXKyKNL/WVCJoc2F+x7+ivJMAEqUoUWsudiTuICVFKqzKGYEWiOVFGEBPjHhOWYwNqsfUSBbrZhKhfjW9re0UGNAXNSy5G9rpG+UX6TKcFoncYK8tfa1XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ofFBbKGq; arc=fail smtp.client-ip=52.101.101.142
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/Btk90gCwcj+6tLZdLC83y06xxbmNnA6/lRf22aNg+IWmN7mzrV+o8CLVnkvwg1c8oqr+GVFKy1xhprvpWoF7pSMAr8EU3wiBs1dVcl9tAR29FsSFKCjYEdxOwhd50MpvkuBE8wQBUFXQeXa1kJiElO2Q5QzaAxADMgHk48TWjLbzm+dWjXoCyHUAM7CIOB/iEpWO20uycU/0ZwkCa0ZKWjo6FnFLZaGi9b6pFR+rkLeeFnEZ8Wy9HAiS3o+vwKOVk9rPI0xMbBcLt+qiUJB39OsXaKbS3qydiV0zW+LALmf51SoseUj/mDKYBIhUruOhfQKwxPUmroxWWurvv5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn54DowCuXc/zWl5GDp0VEIc+RenFxJG/LEoMCq3hvg=;
 b=EgSp17dJwohK9ismhCxXFOq3GLPCw5PayzI4KQHQ73h+izmPj4UUIIlbtG7wesiYAxvTUZXVTXeKcQfe2V6mhZpn7teF7fW/YDIr/o9qTTkbAuS/LEWBRfM5h9rQBUaDnO3yzm8DU+Cu8xx9aI84kAZ++0cWGSzHhZe0ndzx1e6bvhXGR4VWz7L4Id/jRWU5ChmEtJCBw7cf8op6tpKqb2zWyC41zk1Ml2dlOFljYzgmkE8uIadaNEffplbmk5LvYeXhpz4bPGTDlnSMkanbOYHddXNlNUEeCTEkAfZt/asRnIGii7iF+t91xzsuqeGRIfqXBlBjtWm5dUATc6Hotw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn54DowCuXc/zWl5GDp0VEIc+RenFxJG/LEoMCq3hvg=;
 b=ofFBbKGqBzAZHiXcsNohJircyYwe45Dxj8pO4qTwe+mRz9DbmUJ7ZiD6BpxI5hnHyAlIDrNN5FTM7OgR6h+2dNIderBVkzS2Ws9Ws5ZrEwqaNTf2u7Ku4gEcgMMZspq322uRn85+brGKWaXp4IA5JuYzVDHebb6tG/kpwcO4yXc=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:27 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:27 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:24 +0100
Subject: [PATCH v5 20/20] rust: io: implement `IoSysMap`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-20-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=5550;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=SLXPuZTc9Sviatlqi4rEX+pEW0YEAl3QUQB+PjUuFPI=;
 b=GVXkU698lNQ7QPUvh1ktJvdACuLqf3VT9dZxEJuhwInY/m90e7wQg9a3AuaJ0cl9cXPrkXeZS
 +ghGzViPLT1A1IaPrD4o3cp6LMWe1TOXs4X1m45fO18sOrtubnMSvbp
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2694:EE_
X-MS-Office365-Filtering-Correlation-Id: 995277a1-fc6a-46a4-2e2c-08ded3918fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|18002099003|5023799004|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Sb0iP5kqUlIgGA3AMKxPY+x7VNqCQyYNdwXvWijn6hyTpUvR23X5t8lhdsLHTOBUA9cIUUOEO3b3W6SaBhAYwt/vxWXUvpBb7H/lMObq7Y3ZcNnEJMGM4nHVIdWKJUsrEpudkjl7SKfRs3gChz4gxfG2sAPM2Fn8EpHhVyPBSgPTKYnQ9qIsM5ctB2vwiVbSt4NKDXF/03c+5JG9L/igTxxlOc5fGGz+ZW5UiNFr9y74i2V/KJQeMFXJ1Hi58CfuK/AIFA8AKkpxinXWZAq4SwFBr43AzdSrQbrwRB5ouS8m+DeD3a70IpdUjfXAiNc2c2hCaoU2f4wjE2mYX+DV1aNc0nB9rMIOdprThEWNRwpE8VH1ILlIGGXLXQwAW8bS1W2d8Zvv6Wb6RRs0pacOnwOSImqNtGPSS8UDuVh9q++isDVcECk/+Y8LnxaCkFA4TRHs03ihG6F/UT39EWpeC9rWPAi7Kqb9A9Va1wLs3XkpHvbAW7sDhByDL68egdYvQ5tqfYWimvlfW6qVKq8R710Czet4LsLeI67TrFXeS/0kVoVBxsiJIKNYLcEoxwrAEduaPqqrDCDCok9jhGDn3hmLq9m9uRG2+2Ucla1mp+SGv/NXdiKzQ+E3Q7gTRqGq7BgPZHaMcZaBxs+Wtjc/AR2svm/nfen2XTRsfQI8MhuJB9HuN7ClPjRnbWBEKwz3mi7MMN8wBgbdTUOXFBUhiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(18002099003)(5023799004)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE5xeVhGRHJDb0dpWGFCTzRCelJYRXdINjdFNzZQUUpmVWNmSnl1eWJHWFla?=
 =?utf-8?B?Z0Y2RlliYTJ1UzN1Ukk5TmNtdmtUWlIxOXkwYUdZUEZxYndld3RWSjk2WHh5?=
 =?utf-8?B?NERFVmwrVmJhTFcwdGJ3VWNEVDFKOGg5RzNrQnFsTC9Ub3FLbzJMbjhnSnpm?=
 =?utf-8?B?Q3UrNkhObmNLWk81dSs4RnU0ZVRyanBQcGRBeFRnWndadEdMc2R6NStGMG5r?=
 =?utf-8?B?dGlRSUhHNmtWSjF4dHBMVWJYYkJoZkhEa0M5Vmw3TTN2LzBoZWsyYTZ3eEw4?=
 =?utf-8?B?U1ZtU1o0Zm5QZjVUcktMU094ZXFjeEhDM3UzSDA0M3BjS1Q5SithbEpBd2Na?=
 =?utf-8?B?WDJidmV2U2tzS0pqQTNiRDJCTjVxOS9RamYxdHBzdEdFanYxY01rc3RyUmM2?=
 =?utf-8?B?RmJ1aVllOVZRNHQyNFc4YW9ma1JmY3ZJQzl2U3l5VGYrS2xCMG5QclRmanFx?=
 =?utf-8?B?VS9NQlFHbDJUVGlUSWVWWGJ6bXJKNXdSbm1NUVkzUThtTGlPNkZseFlKOVh5?=
 =?utf-8?B?TDAvVXZjNzZIYVl1OUNWU3FhelVqVTVaZjF2UkZkTkt2dFJZN1QyZ2wyQlRZ?=
 =?utf-8?B?SVlKWHVydVNQRlpXQ2k2NERBRTZreUlnVy9YY3hIdzBqNkxZMm0yOWpiUmla?=
 =?utf-8?B?dXVmVjIva0ZOQW1MLzAwNE0rN1VGbkZjYko0SklYdzZoNzUrNGh4b3ZxL0ZW?=
 =?utf-8?B?eGZhTnl3dFpaREp0eEYxYUpNdmZCcWY2a2Q2QXdvNjZIWkR6cXRlRG1hR21Y?=
 =?utf-8?B?anVrVzBWQjY3cEhPYS9VNzlnSGlXTW9WS00wMlZKM2RuRVlzREdZN1Rsa0gw?=
 =?utf-8?B?Z2lRbm1Cc1NxUUFnTG0yODg2OFhkdWJqa0N5NHl2S2d1ZHU4Nkl0UmdEdURh?=
 =?utf-8?B?bVUrRTk1Qmk3S3dSK3FsTkdtMjNTYVc1Rm1ocnByMXdrS25PMTBjZEFQaHk4?=
 =?utf-8?B?VzRoc0kwcVpwWWVpUnF2NlNUNzgrTFpyR3E5bGdQejBydlpBL0NlQkdMMFJN?=
 =?utf-8?B?RkVRdkJFbEFkVmp2NVR2TW1JcDZFalNDczBiQ1Rudk5hWkY4RmlyN1Z3REh6?=
 =?utf-8?B?OUhrZFBwOTBBTXFOc3ZSVkNKM3B6bFN6bmRzb3JXbXVITjhEeTZzVHBRWTg1?=
 =?utf-8?B?YyticXZZUFJ3dncxNEh0TEdLVkhsNi9NK0wvUmZiR0lWQThZZTVHeTdNTW9O?=
 =?utf-8?B?d3kxMmg1Q3FLYXJFa3FNTlhxZU1xWjI3T1Y2ZUpUZkV0K1d1Vkp0MnkxMk1T?=
 =?utf-8?B?OUZvMXBCdzVJZ0pTaWNyQjRYSWFCaDYyV0ZHSEROd1MreGI2Z1p2bmNJQ3g2?=
 =?utf-8?B?d1RRQU9qczJPbEJDRnpzekNJc3c3TjZSTm5peVpqWURtTHBDRGpXMUhQVTVU?=
 =?utf-8?B?ZWJESi95cGRpVFN3R0YyTW04K3JDN3p0MG9NMFFSb2dIQThUcnBJY0gyR3Ry?=
 =?utf-8?B?VXNCbDhoa2NuNW5oQkduWkhEMUJMZy9jZVZMRUQ4emlzcklaOVY3MmdJVUtX?=
 =?utf-8?B?cVZrcTRIYnF2WEFYUGNjeFFKblNDTllodDBiWTY1ajVlQkpoSmFQc0RsSDRr?=
 =?utf-8?B?OWdCdVpFSlZ2ZkVkT1ZlRVpyY1JvNlVrK3FyQ0Y1N0lXc2FrSGNvendOTlR0?=
 =?utf-8?B?WVFkQ1Z5RFdIQk5CZUZFMnNOalAwODMrVzJxUFNuRW4rMnVsRjNPaTV0Vm1p?=
 =?utf-8?B?cjRvUE91cjNUaWx1ZExaOXNKdHpLTHBkNTNUbStmbkRhZ092ZDY2M1hEY2Zs?=
 =?utf-8?B?bkV4UVFXTXNzTFI1Q0tWODNsblJMYUFHQndHN2p1N1VSZjY1cUhOZ2NUS3RS?=
 =?utf-8?B?MXo0MFZrR1ZTbkl5bVJvRHljYUdrazRlUGFuWFdVek0raG9tK3JFSHR5MHAx?=
 =?utf-8?B?T0tra3piR3RDQW94eDBZY0JoanlUK1JFbWlDcHluUVQzRWYwNHJYMVRGbGRi?=
 =?utf-8?B?bGRVQ2E0VzhJWmQ2anhyL3lQWEpzejN4blVrZ1FmNnp5OW1NUitzSUFZZ1lw?=
 =?utf-8?B?OEZWOTZoMklucHlIdWdUTHVNTnZjVDBwSkRjOHR2dGFYcjlQZDU1REZkM0Mw?=
 =?utf-8?B?ZjVuekhXVC9nRFBXZ3lpV1d6dFVnckR3ZU9hYTMxWHpoZlNEUnlMVDZpT2dJ?=
 =?utf-8?B?NG9MNjRJamlPSjByVnpHVW96NDRFSmtCUXhUcDA1RUNPeXFDT0ljT1JWVDYx?=
 =?utf-8?B?WFVBZVJabzNkR1d0MmhweG5UemlWQjg3NTNXOGtCd1I2RjZla285aXFJZW4v?=
 =?utf-8?B?SUdPMnFMd1JoWjVmblhGclRPMU5JaHVkbXFaQmdKcjhSVEovc3dPbG1LVWd1?=
 =?utf-8?B?aHB0N2krZTlUQ3cybFBJSEZBQTNFRFkvbzQzcDdveDB6NGs2SzV0Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 995277a1-fc6a-46a4-2e2c-08ded3918fe3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:27.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWkb7Y+orcC4lf+FD0xNqcNOG5Q18vJPFwzep2Lseu8LBk2Pz22hzcYfCOkRFNyd76utFD7PfihVXgnLLjzD5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2694
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
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9423-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A56686CE30C

Add an enum as sum type for `Mmio` and `SysMem`. This serves similar
purpose of `iosys_map`. Thanks to Rust's type system, all of projection and
struct read/write can be handled by the generic I/O projection mechanism
(i.e. `io_project!`, `io_read!, `io_write!`) for free, and there is no need
to provide things like `iosys_map_rd_field` or `iosys_map_wr_field`. An
enum type also makes it very easy to construct or destruct.

This could be made more generic by implementing on a general purpose sum
type like `Either`; however this is kept specific unless a need arises that
warrants this to be generic over other I/O backends.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index b5ac3ac86bbd..0c5f53dd0939 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1446,6 +1446,143 @@ fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target> {
     }
 }
 
+/// I/O Backend for [`IoSysMap`].
+pub struct IoSysMapBackend;
+
+/// Either [`Mmio`] or [`SysMem`].
+///
+/// This can be used when a piece of logic may wish to handle both MMIO or system memory but does
+/// not want or cannot be generic over I/O backends. This serves a similar purpose to
+/// [`include/linux/iosys-map.h`] in C.
+///
+/// This type can be used like any other types that implements [`Io`]; this also include
+/// [`io_project!`], [`io_read!`], [`io_write!`].
+///
+/// [`include/linux/iosys-map.h`](srctree/include/linux/iosys-map.h)
+pub enum IoSysMap<'a, T: ?Sized> {
+    /// The view is I/O memory.
+    Io(Mmio<'a, T>),
+    /// The view is system memory.
+    Sys(SysMem<'a, T>),
+}
+
+impl<T: ?Sized> Copy for IoSysMap<'_, T> {}
+impl<T: ?Sized> Clone for IoSysMap<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<'a, T: ?Sized> From<Mmio<'a, T>> for IoSysMap<'a, T> {
+    #[inline]
+    fn from(value: Mmio<'a, T>) -> Self {
+        IoSysMap::Io(value)
+    }
+}
+
+impl<'a, T: ?Sized> From<SysMem<'a, T>> for IoSysMap<'a, T> {
+    #[inline]
+    fn from(value: SysMem<'a, T>) -> Self {
+        IoSysMap::Sys(value)
+    }
+}
+
+impl IoBackend for IoSysMapBackend {
+    type View<'a, T: ?Sized + KnownSize> = IoSysMap<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::as_ptr(l),
+            IoSysMap::Sys(r) => SysMemBackend::as_ptr(r),
+        }
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        match view {
+            // SAFETY: Per safety requirement.
+            IoSysMap::Io(l) => IoSysMap::Io(unsafe { MmioBackend::project_view(l, ptr) }),
+            // SAFETY: Per safety requirement.
+            IoSysMap::Sys(r) => IoSysMap::Sys(unsafe { SysMemBackend::project_view(r, ptr) }),
+        }
+    }
+}
+
+impl<T> IoCapable<T> for IoSysMapBackend
+where
+    MmioBackend: IoCapable<T>,
+    SysMemBackend: IoCapable<T>,
+{
+    #[inline]
+    fn io_read(view: Self::View<'_, T>) -> T {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::io_read(l),
+            IoSysMap::Sys(r) => SysMemBackend::io_read(r),
+        }
+    }
+
+    #[inline]
+    fn io_write<'a>(view: Self::View<'a, T>, value: T) {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::io_write(l, value),
+            IoSysMap::Sys(r) => SysMemBackend::io_write(r, value),
+        }
+    }
+}
+
+impl IoCopyable for IoSysMapBackend {
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        match view {
+            // SAFETY: Per safety requirement.
+            IoSysMap::Io(l) => unsafe { MmioBackend::copy_from_io(l, buffer) },
+            // SAFETY: Per safety requirement.
+            IoSysMap::Sys(r) => unsafe { SysMemBackend::copy_from_io(r, buffer) },
+        }
+    }
+
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        match view {
+            // SAFETY: Per safety requirement.
+            IoSysMap::Io(l) => unsafe { MmioBackend::copy_to_io(l, buffer) },
+            // SAFETY: Per safety requirement.
+            IoSysMap::Sys(r) => unsafe { SysMemBackend::copy_to_io(r, buffer) },
+        }
+    }
+
+    #[inline]
+    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::copy_read(l),
+            IoSysMap::Sys(r) => SysMemBackend::copy_read(r),
+        }
+    }
+
+    #[inline]
+    fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::copy_write(l, value),
+            IoSysMap::Sys(r) => SysMemBackend::copy_write(r, value),
+        }
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for IoSysMap<'a, T> {
+    type Backend = IoSysMapBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> IoSysMap<'a, T> {
+        self
+    }
+}
+
 // This helper turns associated functions to methods so it can be invoked in macro.
 // Used by `io_project!()` only.
 #[doc(hidden)]

-- 
2.54.0


