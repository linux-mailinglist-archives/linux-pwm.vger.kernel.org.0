Return-Path: <linux-pwm+bounces-9513-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H/zCIH9GR2rNVAAAu9opvQ
	(envelope-from <linux-pwm+bounces-9513-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 07:19:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BEE6FEA68
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 07:19:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=h+RI5KX7;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9513-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9513-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86CC13073B32
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 05:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAEB340D9D;
	Fri,  3 Jul 2026 05:04:16 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B493446BE;
	Fri,  3 Jul 2026 05:03:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055051; cv=fail; b=XrGqBtRfo/P38FWClBhTSmPMzrkee5kkJodnepSSWSRbmDr95DbZ2ppIw8i8ZtkMHea93bJmTvOwUdDrNQ4spJ9KT3Afv6Hm/33Uf/RMEnqUDhK6Uzxw27Cg2/rIq+VmEa4b21NmHpmLyBReS7GV41yj2uWLNxAOiNz/lTjyKu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055051; c=relaxed/simple;
	bh=ZgRzKf3O4tzf75PIWFJJeQqswa4ydfTNssOSDgBm5hc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=RMaKNo7+2dtwyH7ylA3kYEGbqscnUgrvA0aIcFsj+JChoRId+x+NGYWqyLG/OyGQ1sihZrt6C0MJvDsSzZrysJbe26SmoYZFnW1h3Er5xQTrW3L/T9vx7Ycksv0FsEVPlAvBydBwQYLngtqjF/ApfdEIPnPv0PnGusu1qSVaJfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h+RI5KX7; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mphVkLXVetyJXD2+NRyvrUCxS+85D6CU3D8DxLYAUpDArLtaRbUed1L5NXcLdpHZ+NKK0+LkqlTr0IDzU5TdBY/TN2nmWMIQR9+xFztt+zWpWtwhCWiML67e8b6/ALtB+3xNUGpS/lWkGM8jKfFJN1KhEY4DIoY3tboNhF0zzNfdzXehabEgdWClnBhzYNNYpgAowE9vweLv47vGUT9N0AxMKNx9wXdevLcP8poFhezT78QniS0lb9iW9uTBV7GAQSsqbvFotk7DzVnzEgy4k42OusKwLD8i3NvF596E38dYlyPlQ4Uth3xd/dCDLIyHnRWpmi0yAGJjayVnABG/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgRzKf3O4tzf75PIWFJJeQqswa4ydfTNssOSDgBm5hc=;
 b=oya2EmMoR4jyVv+l3TZMUcg9hOBv4EyVXL4qitELZEht71FEahbzpHQ+82hxOlYipXlCpit/F/RCO+funpAxM3sk8nUoYvBeqRVcDvNzW87D7vkybwSz1lWNJhyXbpCUksRVmtF8h6FN87i3qctbRwnDzPLw2ByYE3rrhwMIQ8BuSwLIWV4KYPUQxvjOIuif/6x1/iQHKjXwIv18txuxzVhIuJPyRNxL4WB1HaQ0fj5OnvJtuUlAfYmzK4WdDrWyhEBNVyDg5BBdFq/n2+U4pgJayaYvJRKgLSV0Lnm23ng4RADzhdMIjccSBNDUTzVTjnAzliqbAcgGH5sNwEKPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgRzKf3O4tzf75PIWFJJeQqswa4ydfTNssOSDgBm5hc=;
 b=h+RI5KX78jeljRSBUJHsq5Oby8nWKbekAWWfIeJc9g1GN61YTw61tSHSiKoSaicROzvFhI+9157gPGwoZvcjX/5EghbU0Pw5T1AL5flLedGhGSrVcxru1RqS4tz1NjRva7Wd2v6gMjpkRppepoEpAOSIms2ide3k3V9T4bkgSMeM1MEYv07cvfdmSf6ZIY72AV4Z7JyFcWQcR+SP1bm9wjL2MdUPPF4UzI7Bwvs9Jz5/HFo+zkKyrnPUn4/YsgPg63K4qRuqmzIjlxEyoyuILW7rjXAlXSVBQMXscvEYaLzCwGp/braV8wPPQd48UUVJxywmcdc5ttti/R+fJQ0Jvg==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 05:03:52 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 05:03:51 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 14:03:46 +0900
Message-Id: <DJOO971HSZ7F.2XSQASVN5YZEU@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 09/20] rust: io: use view types instead of addresses
 for `Io`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-9-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-9-d0961471ae50@garyguo.net>
X-ClientProxiedBy: OS3P301CA0049.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21c::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: e871dd8a-d9ea-41a6-1522-08ded8c0789a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|18002099003|22082099003|11063799006|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Dpr3bz8JJWEP3DRe0eiDwv+tfFMvrDVUnY4u2jO8naKPkZMphu18sP6Gfb9DTXvyyUNGd4RRBwJl4JiF/YPVUwG7536m6ymRufKImZcAXpJkqh7rYf+0/XYuSIm9CajTbjGRlEtxFvth6DIpk/rO4km3aHKz97r9llGEyk6L3EyO1ivV2TLhBy+kRCaE1dT5N3B2d7Hp2gmUelv1P4W+XxlFuur4i+I14LW69hG3ruhLKpHXIGHEANNVmZPQyzwNKcA7fQE796aRCz3Q/T3OjYgMwECaCdyXSBgfBFOxLpoGdR5i26RQVGlDjaGuTI/4pNd7Yy9TFaVXMyyMFa/jdNhILB3yTTNWAnIfmUlYZjOvyXp8egIXfr8mL+hzii54LeqUElh6POkGBLK2w4cLsMuLfxTGXiuLd/HuyrLCgL18Fm+C7CMUdYhK7c0DkotNl5RbGgaTPJB+P4xcVQ2ZiKzEGYDLYa4lh34zvOJuBEI99sejVYZtxJyCO/Rx0MZeV2FaDkoy0QPBpzIVt8sQucG25vz014sfw9+BDNe7TPjz/wSb2lXNWQZtCH55ffTIaObkspJ+UL3MVWKn6iftWEsyrhAcPNX5Qi9jpRsmEVIrT7GEYsODCvesMserUInVQ7zS7uuR+JPjtZOi1cLvom6Fn3x9GP8yCOEW398O59s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEZNOG1zNDNXWStpbDIxYmcrOEFhVFQvRkVwNGNLeGNrOFI3MWlML2JkUXVT?=
 =?utf-8?B?T2d0eXNZdlhMVXpXQWxkU1BCdXpxQUlHTzZBWUVCQzd5M2FMcG53aTQzUmxJ?=
 =?utf-8?B?VVlhK2dvQlZqNGs5VXd4akJSQjlEMmtCcGlydTRSZUhqR20vRStCU29jMTRM?=
 =?utf-8?B?aTR2Y1VTRnBsRU4vdWp6Y2ZyVURIUW15ajhQeGRzOGVEUlBNdjBHcm9TbmpY?=
 =?utf-8?B?aHRVbUdqakZMa2N3ZnJicFg5aTFJeU5RcnoraEVxZnZXaHN3dkNmZVFWM2U0?=
 =?utf-8?B?NC9ENTBxNjd3bHFGWElsVWtpVEtoRW12ZWkrNUJLajZodFhoU2JVRFNQcTVE?=
 =?utf-8?B?Q0xiNFNnRWRKNVpyWUZmSXFIeEZlRkdPN3Z5aVJ3SGtVZGRWVzZnRHpwY0Zz?=
 =?utf-8?B?ODF5QUZDTC9OaHVCMnVGSmVndFQ0SjNkN1luQlNKZGhsclBDY2tNZmRsOUZZ?=
 =?utf-8?B?NEM3TDdhUDlwSGJldUx3Vm14MDh0aFduUDlIVGdNMVdITGROYWFBWlRPWTlS?=
 =?utf-8?B?a2tUUm5LMytCY2FLRy9xY3hUSnBOSDRTZkZNbDhCRi9wdERrTEhvRjhDOXBh?=
 =?utf-8?B?OE5Xa2gzKytwQzVEOElyNVluam8wazBkc0xNVmZXTjRRSnBVQjFBV0o3QVNm?=
 =?utf-8?B?RUpkQzhUbEJtSkw4OEFkdUFHMHZFdld6MTVOYjB2Umx3SW1zOThpdFpVa3B5?=
 =?utf-8?B?ekE2c1hTK0krME9kd3MyMmtDMjE4ZkpOdSt1SGNQeGN0WHR3TGk5NVpUQ2Zm?=
 =?utf-8?B?M0MzcWFGdUtyVXlxZFFobVYzRHE0STcyTncydVMvUCtDNDVBU2c3Sjd1VHRG?=
 =?utf-8?B?T3cxZTNXSzBONXdZN2s0QkgxUkRzaUlLdWQyUGU3NnVpSjRJRHdXdmpSMGth?=
 =?utf-8?B?cVVkd2FDazhIVDJSK050VHBiNTBucG9SSjEwdmpvd082Rms4NHFqRENBOUNI?=
 =?utf-8?B?VW5IVjlIa2d6RTlWeVpiTm1nVnRyQjRSTmtFSWhSZzRRdExweTBmQVh1U1R1?=
 =?utf-8?B?K0t3cnRsWDNTK2JibnpuNnpuTXpxYzhFVlh3ZmM1UXg2TVQrVlFkOEVMNXBp?=
 =?utf-8?B?eXNqaTg1d2xPRG5GSkFlY0UzTk4ycjhvVHRhUmxoWnV4VDhDdVFqRDhRU3FY?=
 =?utf-8?B?cTRCcFRFSDE5VFVYajI0UTBYZWRTa3U5dGZsWi9WaGYxbFlkRVc0K0JSZ24z?=
 =?utf-8?B?SzlYQXVGYUpmUHR5ZXFUNithNWY3cW5Ja1piMjg1NytkVGErVkZSZkhNVmlN?=
 =?utf-8?B?Ui8zK1NmODlmVUlTNXNiOHI3V1VTQjZ3MEtKZlpkcXNDV2E5amluKzNSSVBB?=
 =?utf-8?B?YVM1Q2psSHhXcyttcXoxZ1UvN2xNU1pQQ25meXpUQ2xGc0NZL1hEaS9QWWR5?=
 =?utf-8?B?eWNVdlBIdlpCOUYyNGNrTStTOVQ4dVpxUll3K3MzaHdOZjJIbThvZWpuMHBI?=
 =?utf-8?B?a2tJYlJMSm1JakhFbm1VK0c5VzhLWG5Ja3NOempoNnY2dm15QzJzK2RYU0o2?=
 =?utf-8?B?UEcxbFVWYWZYbUh5bjNkOG9BRkYzVFh6cXh4bWtpcTk3Tkdpb0U0d09UT2tT?=
 =?utf-8?B?NVNhNU9EcEJwZUZSOTlxS2FWWTJIdlMvMG5qcFBMNm04QlovbmN1WG9TOTdB?=
 =?utf-8?B?WVdGOWo2bDVBamR4U2VaL0hObkQrTVE5NC9yTjFWWDdacXZ5a0FUQkhrRnF2?=
 =?utf-8?B?TDNITzBKVkVTVlhFaDd4V09JcHlxR0ZPNnhVVWhPM1NnaXNmc093R1gwbytm?=
 =?utf-8?B?dTJOQk9ySmFLVFBQVkVlOHpSdjZoTTg0ckxOajdsUkorakNPejZpUkNONVJy?=
 =?utf-8?B?TjVMZTltYy9DVkk4eFlmajlOYVdzemg0QkJPQ2NQS3pxSXI0TEJTVWk4SHh2?=
 =?utf-8?B?ZmxjZS9MK2IzSXBHRFEvcHdKbEhobE84WlgrNUYvV1h5TVMrVEFXc3N1UWF3?=
 =?utf-8?B?VXcwZDlsdDg4bzBHbnhzOEdlOWtPeVFjRUZJMUg1dG1RZlpnZGkrM3JiaTl4?=
 =?utf-8?B?VTJONit1dGE3L1JnQ3JGTkc5WVhnalJ5TzJJUDN5MnhHalA2eDNKc1Y3V3Fo?=
 =?utf-8?B?ZXR5MWlRc3poclpKSmltcUdSaUVNd21Fc3lDb3hEWktuYUhBK1VWU2pVWDUy?=
 =?utf-8?B?aXlYNlBtZUlSUnl4ZHlNY1JsdzkyTmJaby9qUHNtWThNLzJCWURDOStTKzA1?=
 =?utf-8?B?bWdCQWptMWU3dkxERlJKRTk5K2E4VjZXSFpSM0FjZk1XTXYxeFc0OHdFZ3NF?=
 =?utf-8?B?b2l2RDlScExJQ2puYSthczVvWXpLNnp4aDVGT0JTa0orUjNpRjdIWGRWMWc2?=
 =?utf-8?B?Nm9tR1piVFRtczF1c1VPTlZYNEhvaHpnYmpxamp3NWFuRUVGOFlxNmtGQ2ls?=
 =?utf-8?Q?+Mh2hXbt2AnZ6ul4lXAn0Xu69qzCv4iCRE/yHvSOjvwcB?=
X-MS-Exchange-AntiSpam-MessageData-1: 7vO4yDnuLHs0Hg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e871dd8a-d9ea-41a6-1522-08ded8c0789a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:03:51.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/Y8fAsAGVcmaCU354sB1b+Ot5eNyiWPuIXgawlz+tgWEe8RbaORGsXgQKknJVAQu5V7Nx71y/g1p0zuMP6T5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9513-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,io.rs:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94BEE6FEA68

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> Currently, `io_read` and `io_write` methods require the exact type of `Io=
`
> plus an address. This means that they need to be monomorphized for each
> different `Io` instance. This also means that multiple I/O implementors f=
or
> the same I/O kind needs to duplicate implementation (e.g. `Mmio` and
> `MmioOwned`).
>
> Create a new `IoBackend` trait and define these operations on it instead.
> The operations are just going to receive a view type and operate on them.
> This has the additional advantage that the invariants can be moved from t=
he
> trait (and guaranteed via `unsafe`) to type invariants on the canonical
> view types of the backends, so `io_read` and `io_write` can be safe.
>
> Note that view type is needed; addresses are insufficient in this
> design, as they do not carry sufficient information. For example,
> `ConfigSpace` needs `&pci::Device` in addition to the address.
>
> `io_addr_assert` and `io_addr` are renamed to `io_view*` to reflect
> that they operate on views now, and make them standalone functions so
> they cannot be used by users to cast types outside io.rs.

The extraction as standalone functions could have been its own patch so
as to not distract from the meat of this one (and make the diff of the
functional changes introduced by this patch to these functions easier to
review), but regardless:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

