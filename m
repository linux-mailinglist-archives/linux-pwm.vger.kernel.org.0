Return-Path: <linux-pwm+bounces-8984-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNUIKqjsC2prRAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8984-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 06:52:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 128B957749D
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 06:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2729E3014C0D
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 04:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3431305E32;
	Tue, 19 May 2026 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XekseiGb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53F2D94AB;
	Tue, 19 May 2026 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779166364; cv=fail; b=WpAuoXvrHwq29xJ9kCSuRrra21baMxjGEfGK0mEGrkiZ0XMrPOBSy3924DjHn6gfXPnq1qYXVj/6PQPTTa71GZaj4xxAJ5eDF6tO3qEZwkoKwYaPbXjYzheDOdyEacLMuAH11eyrs0skLKYnzT9dSah6FFHmEfbr60U0WcbZwvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779166364; c=relaxed/simple;
	bh=G+VVLerT+G5Gy4z561KGf3VfM/y2mOERHPPN8/x5yZw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=MCZzHlUbO2u5VhqDyg+bucp83nnHP3bs3wGuCfLGy1vzUSbOugD1jBkzFLvgtSjwavPAaicMXD1Wz8PVIUegJKPlbI3iWMNod36VIT0ZcQQD0HWGcjGxu1EW9TIisOetntTDIu3Odn1ot/G+YJQfWZFsZkQsL2pSTOVVmRb+8Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XekseiGb; arc=fail smtp.client-ip=52.101.56.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBs08zXrRtw7+39zahp21Pg/C/oQoK5TOfmR2X1FEGhd6egVnp62a3trdQLF+aUX/Zjqi/QzP0I8Xx0KwqSvf/sm5F/rVramhmLv1cEuxTk5ggau0ulg0fsTbMEBgGCrip2K7zuwwfekQxiUw1A6t05j43MOwoMVJF0wBZi2jD/wN6/6cvE3goOTZWBNNjG6Z5k21x1JtVL0EwC7lRbZZBzW6lOGB5VkEgIw07J7qzgkY8wpBuQsi9l34/Ku0SJbwmdmc0qwE5JhZlLpZVDCfR318EkAFARkZjIXS3Hk7aJv04m+21Y9rRehkW+0JcnJRFkeifVF9jQsagiDciCiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+VVLerT+G5Gy4z561KGf3VfM/y2mOERHPPN8/x5yZw=;
 b=fg3jmVA+1HYhnapxDfJv0UzpTL69VM82DgMR7cp5E7Dtw+tVad7oh2OQc7808IfgozsN7g7k3lHLBOoYpn7464JNbGVqwKYEjStZXJcFjPrYO2VDbX/NvCUf03L5fZRG/M23LQXqBa8td5fjUvdVI1y/YG6udSQ0Fg5LG7NEdwAD40Hmtz42ZMa0RJGO9nBXscvh60fcVcMPpv0FsnGGfCSIQ5b03Vj+p3mB1hahHumNEVxg0tu7BODHgfYkZpMpcGUVgFh6Thy5Hh4r7z2+3BSHVoaODg+9EKWZJ1baY1hceZBIhQC56/0tkfYg9sDPAHc9Z5NM3rw1MKui8uux6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+VVLerT+G5Gy4z561KGf3VfM/y2mOERHPPN8/x5yZw=;
 b=XekseiGbT2Bt9KZiAcUk6TMUUNrc/WDt5k1U8rwHFUL85PGk+zrVgX5s8r0NSpkQzwZhtwVf/9EdrgzIAP0I0dpr3SIANFeqh9g/kx0SGbXwS/CRzH2rT/Dub4LvnKs5lHDDryh/8bOuYDNc6l17tJczI3ow+dM/BQh+hSUQ3jz1sqOX8HLqD2IfjJ4WR0oVFOc/K1FGGReu1rCorEMxVS5cPVUOAuhBcQd96gXag9/P9Ig9ILztICa2rvCnP9a2nGpODK+c/nYBFoWYM/TOvAUdAXqz1KCgwtCRB+kV+kCfUws9AFjnNilx2Ea0Os6+ssS/BeubccYmJ4F2Iyzi7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 19 May
 2026 04:52:36 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 04:52:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 13:52:32 +0900
Message-Id: <DIMDU2XL6PKO.RUXA0XPFT94R@nvidia.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 10/27] rust: pci: make Driver trait
 lifetime-parameterized
From: "Eliot Courtney" <ecourtney@nvidia.com>
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-11-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-11-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6b8dac-9f77-427a-7056-08deb5627272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|11063799003|4143699003|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	VkNDKxjDMQXNYT5cCHtM7JEpdAlXJdA9gQTddaPx68r3xR01EWdxcMIuiCnsGjFui/xka7EFAaovdGD83UawLYDzgrBkZSz4Z0QC0qdHUNE9XBAS36FhDM6oEc31Um3Eu2qfFw6qtBfq4vgU0CNx9u9/RhONFXuOkfKTEiZ4fLFq8XRbghoGYaDp07N9hVdtzyVQbQNAhyqR+7/QJtOspxDsn1nJTC5rl9UWXgMtHzxC/lW2JyRiQdx5yT5pwmGEx2n1YNOAxuO/iMpqA99nxnFVeT7F8k6Q3rtZykIQR7g2AdOLUq7YX7VQtu+537Y7/yRJzQJEsBJoW/ixjuK285BLgCMOIQe2GLXbn8eNmQKibmQghDAugcq4X+z+4lpKImT3vHB6eoCL1vv+qh9MxjPr1Gb6ruB4qwKXB8OfSfKhxtVhZ3jPJH0hSCNW8C6o3cvCB/ZX0HwNz/9tjCePWTU8sA7ga2bUShNFXy1c1UNEG2ZAuvbY7wTHRhHWPfUxnzZj2EGI0GpRrLXd3kcA3GzsXmSbdlwCrfski/32LZx+hAGBsleBQdS0oAdKUy3dbouzforYYJLUsdyH3ks866ig0PJR4+Ru3KbPgod9KOTziGxDhpEwff7a1Tb1MsIxrFiRK4ZFzamZEPti+z3Zas/vmVC1G4tv0/ir8BDcWTQQZMTzfOBMcllFB2ndxkI+wmotHh15AiAAfUVaJ+trqU7O/RwtkETXwbEy/+QCrL4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(11063799003)(4143699003)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDN0dGxaTFdkb1NQVmlvK1R0aThHYTNhbVlxNnQxemdiNW5pS3h6OFZXWUNa?=
 =?utf-8?B?aFJKa2dMRFB4N1phc3RNMWdmbWlCVGtxL2RxVEl2Zkd3RW03LzM3QWxVMllM?=
 =?utf-8?B?SmtpR1ZqWXZIcWorM2JPRitZVE16Ry9HdnRrNG5GeDNIeFdYeUtXN0RlOGtU?=
 =?utf-8?B?L1FPSmszeTcyVndhc3FIWFQ1R1ZSL1ByUHVHaE5kV25hMWlLMWk2SmpEc1Mw?=
 =?utf-8?B?WWxzMi84dUY1eVZaakRwNGlVSVV5cjM5NitGd2VQTGpIS2tUYlNxNkVUbXNo?=
 =?utf-8?B?YVRlOXdYK2VqcDNXdUFVSUVZSmJFY3B3MUEwY3l1T1N4dUdCbnFQK0pLQVp2?=
 =?utf-8?B?NlFFU0p0RFNqT0h0T0d0WWI5YUc5Z3JDUVF0dVdzV04wODZZVnpNMW5aWEdz?=
 =?utf-8?B?ZjJYV0FLdXphbXVQQ0pleDhKZktlZjBRSDhZKzh4VVpKRHA5Rm5yS0tTS0lL?=
 =?utf-8?B?NWs3S2NIYzdHUitNSzN1YVFPT1g1a0lhWFhxeHJOaW41QjBOcGVhV1pqRlZL?=
 =?utf-8?B?V2M1WTFqMkVrQ1NyZC9lWHM2VHJwb3JpeSsxcTY4WE5UaW52MnNZbkMwTGho?=
 =?utf-8?B?OWxuQW5QV1pRWXBVb2xwRWhPbmZqZG1xOVRyd2hldTFvd2lHZFhTQkdzV2RR?=
 =?utf-8?B?b3VPRDlOWmZKVTY0YnlKcTlBVVhDNWpwUURHMnhsZUwyUXFNRkV2cDA2VlRS?=
 =?utf-8?B?Nk1tclBCcnRQelhKcGU2Y1I1RkpoUDVFenRhVXdPcXpkaW5wSVlYY2Q4Rjls?=
 =?utf-8?B?NnUyV0svU3NQcitnWXpLaG5ZeW9CQlRxNDczN2VlMmtBdDE3c21qVG0rK1dy?=
 =?utf-8?B?MUk4TUY3VFN4VW5QRXd6ZjdmNkZpSkxZYlRuVkFLMndrUGNMY1JucjRBWStV?=
 =?utf-8?B?bmRQdmRaUFRTbjEyY2p1VnBsR2hmWXJCUWpzUFA1NEtPak5aZ2VhZ1JFSzhP?=
 =?utf-8?B?WUdMVlQ5bU5hbXhhdk00YmVlSlc4U25uYWR4aHM1VktrM2hVUkp6YjRuMk9r?=
 =?utf-8?B?UmdQY2NPQTQzRVpibmwxU1ZmcGNrVU1kaHlIRnc3NE5pYkRXUENwYm02a0Jh?=
 =?utf-8?B?Ukd2Sk5aZ2NpZXVFdjdQak03NmFmSzdmdWxJYkFhUW5qSTh4NmRZTGd2akJN?=
 =?utf-8?B?TUJRT1o3RDUwLzNKT1FCYzBvYWFhSlIvRUI1ZXBta2o2NHhhV2tqc1lrcFBP?=
 =?utf-8?B?MGdnMkRKWFAxU0hpSitwTVRHcHVycjFaVFJ3VUNSWUJKNU5pb3piaTlacHJt?=
 =?utf-8?B?QjI4TFFXWXl1UFBxekJWNjRhQzNoUC96THJoVkZYKzg4RTBrT3dSR1BmRTJI?=
 =?utf-8?B?YUw1aGF4Ni9XOUxJTDZNVXJOL25UK3JnanUwQWo4TDJoY3daR2JQSzRBcnkx?=
 =?utf-8?B?UVhIVGdDeG41YU1VUlZLQzdJNHBXTVI2dEFlNUNXVERRYS9ldFFYNWtCQ0JK?=
 =?utf-8?B?cVRjWFowMWhyOUk2YW1URHVCb0ZhVjYwMU9zTUZLY09EY2RpUHdKVldTVnNV?=
 =?utf-8?B?RkFTc2NqL1ZWYkJrZnlPcnloWVI3cmxCcXNvaUNsb3hQb1llYUdUcXJYT3Az?=
 =?utf-8?B?TVBZZXZXUWRzaXB4N2FXOHZhSWpkTmhUVmp0c09qSzhtN25JRnNLZzZ4aTZU?=
 =?utf-8?B?L1FXREF4WnNTVTN2cUQ0aWc0c2creW9SQy85d01LaDlDR0RTbnA1eGF3MVQ0?=
 =?utf-8?B?am5EK3pHS2ZHRkV2QzlTb3FYcFkwZXYvakNDTk9RT05PVXJaOXdmM1hYTWty?=
 =?utf-8?B?bUZXa1Y2MHVNaTRBV0JpK05mSFpuMVM2ajlUWm03cW5OWUpOcjV0bzk3UUNp?=
 =?utf-8?B?cE0vOGFxZUxCUCtYS2xUSWFPQXRBcnNadUhkNDVVdXU2dnp5bXp0N2JDQjM0?=
 =?utf-8?B?ejR4QWVCbmRYMkV4ZTJyTllGcTY5enpJOGY3aTRsN09jK2tDcC83WVNPMW0x?=
 =?utf-8?B?aGtLdHdkRTBUSzFYUFVHbk15dDZnR3o3K2d6SzFCRm1Hc3V3bTd1alNFemFI?=
 =?utf-8?B?MGNPaVV4T1d5SGU4d1I5c2dWTjFyN3RlbXVkd1pEcmM3bENibXZaRm9oOUtP?=
 =?utf-8?B?MzVwOEJnZDhLbDl6dVM3dk5GVTRGVERNVVluQWZ1a3VaQmJlVjZEa0IxSDJn?=
 =?utf-8?B?d3I3bmMvZHpQalhTUi9aRnRyaEdOWE53S20vU3NmNWtRSk1RcjFBNHMranFn?=
 =?utf-8?B?N1lUN1VKcFdzNGhjNDYvQ1pHZ3d4aVRtRHRhb3ZZT3cwR3lFZGwraWNvVzdX?=
 =?utf-8?B?d3FaVEZlaCtPbFVCbEtHeHFCWitxV2NUamZGbEhQNHA1VmgzbnJ2Um9EYkpS?=
 =?utf-8?B?TzlvVStLTUx5RG5STktQaWZVeWlyMDIzbm1ONUJ3RjhrOXdNYy9lRDVya3Fr?=
 =?utf-8?Q?j2vCxj1Tz/J08YUmoIBO0LWELPyZqUdZCptwzgReUc/yJ?=
X-MS-Exchange-AntiSpam-MessageData-1: +cEQDwiI+F6xyQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6b8dac-9f77-427a-7056-08deb5627272
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 04:52:36.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhwAbl8FwbRGo/PnRF3WDI9aKM0SBw7VAlFz+zhTXIlmSHeOKCdUInkh+DpsNQhFrmakqThMMIJQmb+sX5xarA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8984-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecourtney@nvidia.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 128B957749D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> Add a 'bound lifetime to the associated Data, changing type Data to type
> Data<'bound>.
>
> This allows the driver's bus device private data to capture the device /
> driver bound lifetime; device resources can be stored directly by
> reference rather than requiring Devres.
>
> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.
>
> Existing drivers set type Data<'bound> =3D Self, preserving the current
> behavior.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Is this really sound without a covariance proof? For example, with this
version you could stash a Cell<Option<&'bound pci::Device<Bound>> (even
with Gary's suggested Core<'_> change) and then observe that reference
on Drop of Data, which seems unsound to me.

