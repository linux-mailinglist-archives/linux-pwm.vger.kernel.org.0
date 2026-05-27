Return-Path: <linux-pwm+bounces-9179-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOFBFVH2FmrUywcAu9opvQ
	(envelope-from <linux-pwm+bounces-9179-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:49:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AABB95E5527
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF563008A6E
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF53F8EC6;
	Wed, 27 May 2026 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="upC4Av2C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022084.outbound.protection.outlook.com [52.101.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE173E92BF;
	Wed, 27 May 2026 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889301; cv=fail; b=pTqCjv4UUd2CZbWryQ/Dgm506o54G5sI1JvT1memduoY4UJDMH1k96qzX8ne/WMj3+3+oFnjOVcuKkC3T47aHq+jrQ2NQCoeRBU5z23N5ZDzonxXBA/aSR5/v/cQRJIbSMefOCAIUZbpw9HmdqwKi+SoQiL/E/F4+61NMGTjM2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889301; c=relaxed/simple;
	bh=fRs+zn5r9KxH2teEw1OPkeHxbJCtGHCKfGlyqjsR3Vk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Ct2DYKb5TziEMsZTjHP8eWLhJ2M5AzoJznhv90SqPWgwKrHuNsP5EW76uxfch3LY39Ve7Ek7m5eWkTbX3eEmYkw71blk91+dqVSLpjj/9pCovL2WZvf1fy1pp7Sv6lo0G8NgZiODAml1UNKdyNwYXmjPcsortAEEkp8Zr2vkR9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=upC4Av2C; arc=fail smtp.client-ip=52.101.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysMeQKdpbw1+Syj3XmUpYGr6yeu76ualltormG3wSmYRE6AJwz7ViwU9anIPE3IlC8t94L534dpjHw9DUc2qoiwlj8o+ocsVT7LchSiaW2LYfvjacGLKcznyOs5BLcis8TFf/HsQNiTTNGr8nADKT9TyLur+DOYDccHoYOMIYT+pnezpF0/UiPxH6WEj2Fywn+OkyJi942EOVzmp3pRElGrxR+SZ2jPgLQfFryNqFBsfL7StwVb66YFRVxd9h2McPPD4A/2xWBlnNqh7Rz9+QX4+DiDP56D8NyH52cH+ux4sZ4UYWqy3bpaZDIBtNW9fRir4ZgvuZCy57O1huXAgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqAinA3aRgngkWEVVhKNGrAQ36reSKp+0Ob8OuDqulg=;
 b=tAwMMLmIMASv5t3cNHDzMsoAObw8LMqhRH4TbHxKh0JbQsGD4hv/jn8rqFJwfB39Io0vNf9FucKPuVa76K9ZScZPclCrQeZ6VBHC56l+aUu5AbQnKJ7aXth5PHpmQdwgXuuZo3zxVUix1bs1r0Gdtj7awh+T9tOD1zHErNKhLboGpN5RSUaLJZsys4+P/wxjyQyYsfXl1kJrqviWcBn1srW0bfnVu1MWzgp7nWE1uHIKDQrnFrQKklHglOHKAIq9ZNVliXmulQNcDSjrZl+P6/sprZrHTYRAp9zLK/HNuauowj67MQzYWMjQiOn1yabi9hkMf7Gyz9hj2zExVFhllw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqAinA3aRgngkWEVVhKNGrAQ36reSKp+0Ob8OuDqulg=;
 b=upC4Av2CU5copVgjkDgMT4RWAwq9xQYDkHJzElXijR8uM3yarzwRjDRr38fX+E2s3TC2dToI+N7Rrdl2C1BEUrvQPJ3nYrl8b4e1EwyVJINEs3HredJF5DKHRe3Gaq9TKc+dQ3lH9mYHhxxN8g7Ue+KqM04H0Mk+u9hmuav+7v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6528.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 13:41:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:41:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 14:41:28 +0100
Message-Id: <DITI3F11JL6Y.3VAA9L56F6M95@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v5 20/24] samples: rust: rust_driver_pci: use HRT
 lifetime for Bar
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-21-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-21-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0516.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 267022fb-efae-4f37-877c-08debbf5a7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zxlVBPCFtNbTAFVyxZEp7S1+j+cd1O13wn5H25h9212TC5BTJ8xe24GWGHrKSVh7252NiuYEXD1gb0u10uUSsBTLg/b+vGu1cF3hCcA4tC+WIH7+VcaET3n4mbNe5dIKVjFpiNlKUQ67AuohiTCf43M98XD2Z9dH2oLfRd/FmbAv8P+ew6vIFFSvSrct5LQbnFTW/L09Mk7hdTmDBS9pSU/0D5gt4Oxbm3VV0n2jf9DtWM2EK4znJgSnm4kxxZxesfJaXfteUp0ZzPjU/G5NK+l0uGDHDALL73OXRMo2QEb0TmCCUUPgK4gM9r7eoSu+2eNPl3/2ZeUohJcUVzbwwSCBjOreu/7zcKodGlUsnm4s0Jzb16CERYvgN4RGMT72QrBQ297cg/9Nzx6X84YnX+8sK9TgsFUhF+H/PjQ5wsjmAGJsoX2wHDTGo70GNsM70cmKywGBEEVqPs4r8UdgtLx9npHjLpBGCXS8y+PbGS/LbgJVUo5XVPPnU2RVIdgSqVofdv+uywC14xGI1moplr7rUGO9nC6u2M7D/LjV4T3wWu4jzcBV1GlgUsHMr+kLfiLA+x4TmCyW06agBePU1cgXZEKjC2Mgr4uc5123B0fgOYvmRRydE3mLL5FKvc7Db1n8tcmyUxiQdFO4xbMj7+2O+tKwF5vBX1Yuqa/rj7MlGjyXzbLfA/MZHyDFD/sZH7TrNE4c1wgfNxpfuj+akIo931uTRedEpXQwHtCMsxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHhPUnNIbk1yWjlOdE82YzRveHh4T21FT1ptVWpiOTY4NzNZa3dWSVJQYVZr?=
 =?utf-8?B?cmhRMHIyVkhUVkJQT0RxRURaeXRpR00zcmcrOVdvejBIcEtNWk4xSHVNZ2Ni?=
 =?utf-8?B?L3ZVSmlmM2Z4Q2V6WUova0ZWaDRySkoxN2hwaE9wUzlyUFB3NVh6a0gyVXd2?=
 =?utf-8?B?ZHpORkNxUmtrVVB3QkNpWGRHZVNQVzl1OVVkRFg4QTAzSWdteGVQbllHUnpr?=
 =?utf-8?B?OWZmNWZBYXVQbkFZdGkwNFhCNXVWYTdFdWJjWFMyWDhKSnRxdVI5NTNWOVhR?=
 =?utf-8?B?VERZK1hlSkdkOGpFaW5kOEg4UkE3di9nVllpT3pCQ3NSNXEyc0hOS1BxVzY0?=
 =?utf-8?B?NDlIRlppcUlDMXd5N0JRa0ZEZngwc2F5QXFwMjhzbTZxYW5pNldiTXdCZTRN?=
 =?utf-8?B?OTcyYk5jWlZJSTVxMXVpajZkWjdoQ3JCZnl1WHc5ZWxCOHFQUkthaFl2WHY0?=
 =?utf-8?B?amhpVGNKNHFma0ZGc0NORGNvVmg1Smc3U2t5K0p3N3ZoaVZuZmVtZkxzTHkr?=
 =?utf-8?B?d043alRUbS82ZmI3Qndna1ZHZWNLcHg4YnhmSHRkck4zdEpSOXJHTWI4cjdl?=
 =?utf-8?B?REJJNnJLcW1VVTlFS1pQZVhLaUhyS2tPbmwxc3p4dEFvbllJSGhPbVlsazlx?=
 =?utf-8?B?eXcyYlRKYXhFTlk1WFcxMUpBcmcyd1FQdjJWa1lGNWt3cDluTlJHSVJvbFNs?=
 =?utf-8?B?VEIyZHRTcURpb09LeTRKMXNyLzhlckprcm1PRjBYSzd2MGdTSkYvL1ltZTJH?=
 =?utf-8?B?K2JoQ2ZidUZjZktVS2VnL01wbWZVSE0zUXVaOGdYdFFOWEdVbkEwbmhkdk5N?=
 =?utf-8?B?NXRicEFkV3pGRXQ5UVZpdXhWMDJSdExvK3BheEY0KzlsVXJzMERKcHRLL01t?=
 =?utf-8?B?cVduWERucFJDd083UXE1TTBJcWlnTUpDeDI1RnlyakNmWldHa1FCQk9RTmJQ?=
 =?utf-8?B?aWdsVHlDZTRETUduRDdFT0lyaG9JZ1JMRmJHWGdqQWM4YTF6d2w1ZTZuM3lS?=
 =?utf-8?B?NnZtODlTOXAyOVJWOUh3amh3dHpUU2tjK1QxbHhLN293a3BDUWhTdmFQOXRk?=
 =?utf-8?B?NHl3ZFkwNmU2d3duOUZNcW5aTm1lZThvRmhuakRVcFdTRUtXMzlRcFMyMS9n?=
 =?utf-8?B?Vk1VcGI0TE9zKzhhWXpYNmVLVnhoQlNKVFI0OW5JQ1hGVmluOFVMbmNuZmVZ?=
 =?utf-8?B?TjJJSGhpQnByWmwyR3Y4Q0J2eDZlYnZLcGRibmJnVm5CUG9ydUFGa24zT29y?=
 =?utf-8?B?aUVuTklma0VWYzRXRVdjTFh2WHgyT3FOeC85cXpsd0RYVFZjK21JRVg1YVZ5?=
 =?utf-8?B?Q1J4NVJsa3JuUVpvTFJjaHE4VmF1SHU4U2NtdUN3ajM3bDJsb1hUdy90NjRm?=
 =?utf-8?B?Uml6Q3dYOW1maHVHa0I4bHYrV2xuRHNhLzhLZG9GT2h4anBFTnNpMVBuNENL?=
 =?utf-8?B?YS9HcUMyTDlxWXlDTkhCeTdsdGlGQ1c0VFQrWFRxL0RkZXZka2ZlejdXZWph?=
 =?utf-8?B?Y0NmcHhjNzhMTE5LQjhoT0ZTR251M213RUxOUWp6YWR1d0kzRlJ2WnJzNXlh?=
 =?utf-8?B?UFBMTTBmdGlmUy9xbEY2alJUMkhsRVV3b0xFdDkrb1ZJK01qMG9ZTlNGUVFK?=
 =?utf-8?B?NGJTbmxSTTd6bi91UmRUbnROZ3FTMUJIQ1ZmTkl4Z2lETGZoalVrajBiWC92?=
 =?utf-8?B?QktZekJnWVlMYnZUWnF0MHRYY3p4WVVFRndvcTNUUC9JbUczeWxLcmhxb1ho?=
 =?utf-8?B?a0QzcDdYR2NwZVFXZTZKekxsL3hFaGJhUjBiaWdPUmJMZFh4cEN3OHVZSTRm?=
 =?utf-8?B?d0JvQjhITTlGVnQ0N2pCenFMb05HdUVYMjhyV3Myelk2RkU4TlliV2tIc1FI?=
 =?utf-8?B?ejd1a05IWTFUTERKc1VpQndDQ2lhNmFCV0MxZWMvUlRmL0IyRHNYVm04VFY4?=
 =?utf-8?B?d3UwNEwxQ2l4K3gzR3pia1l2elp6TysvZjMza2QzUnJCRWt6R1ZGNGhUcEdx?=
 =?utf-8?B?RXNGOG9mcDZtOWpkdWRvNmplUyswakdVODcxWXBabDY4VzM0YlV5c1BTTmpR?=
 =?utf-8?B?KzA3b1JsZ25YWlFYdUZPOU5kcVlhY1ZLQjk2bUowcDdHRGdUTXpZM0phcnhH?=
 =?utf-8?B?czJOKzlOM3JTSkRtdm1ORzI0TjJkZWdhM0R0alluZ0dHdExBSkxTWGt0RmZl?=
 =?utf-8?B?VXhqRFp4NEJsdVJjUDlVbXcvaGFLRkdOa0lTWU9wWVBmdWJZNkVyU3B1ZFRz?=
 =?utf-8?B?SHFZcnhmZjk2ck84TDVjR2Q4ZXNzaVRSVDIzaHl3TGFMVTh0aXVuR1UyNUtX?=
 =?utf-8?B?SUdkVGRYQkRFQ1JXS1FWQjAxNlM5YWRPTHlZSjI5RlNLWVRVUW1FUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 267022fb-efae-4f37-877c-08debbf5a7dc
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:41:29.1589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3+IjqqfS8pJzZtU7JLCvvxuN6WHvmSk4HjzpjwJPeyvZ0y0Ty9QBz1gcCnsNrT/JIiju3b0rTebsFrXtw2ZqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6528
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9179-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: AABB95E5527
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 9:21 PM BST, Danilo Krummrich wrote:
> Convert the sample driver to SampleDriver<'bound>, taking advantage of
> the lifetime-parameterized Driver trait.
>=20
> The driver struct holds &'bound pci::Device directly instead of
> ARef<pci::Device>, and pci::Bar<'bound> directly instead of
> Devres<pci::Bar>. This removes PinnedDrop, pin_init_scope, and runtime
> revocation checks on BAR access.

It looks like the original code doesn't need pin_init to begin with, so it'=
s not
like the lifetime actually helps here, but it's still a good cleanup.

Reviewed-by: Gary Guo <gary@garyguo.net>

>=20
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  samples/rust/rust_driver_pci.rs | 89 +++++++++++++++------------------
>  1 file changed, 40 insertions(+), 49 deletions(-)


