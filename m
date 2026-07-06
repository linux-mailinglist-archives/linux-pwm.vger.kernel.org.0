Return-Path: <linux-pwm+bounces-9609-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3OQuHdSlS2ofXwEAu9opvQ
	(envelope-from <linux-pwm+bounces-9609-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:55:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B49710D9A
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:55:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=yQiJB66J;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9609-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9609-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69FBF3511FE1
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC1A43F4BE;
	Mon,  6 Jul 2026 12:45:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022091.outbound.protection.outlook.com [52.101.101.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7D42F710;
	Mon,  6 Jul 2026 12:44:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341900; cv=fail; b=fmvZkOTg7DOP2e0NO89cdyv5RfYTmTwLuoCpQJEyaFGKLjVlwrepuKIg2wGMoow4hPzFp5S6B+/wvn2jvOi8PPDMy+KcevoQhLC4H/AMJYLMVQWHJyjCd/sGlW70TnFJx0NzgjUVMj8VQvn0Y1ejlcn15a+5NnYxpzyTsJzND94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341900; c=relaxed/simple;
	bh=xdkYZI57kfTpmZRHTNinwPgBzRzi0U1DbnfPFnTc5ag=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XQ5rNAgk7dhCY12IA0AzpLesVhpoGGLovfazQxRLyS6uLIakysgIxmHqUNROesaZCnqmQoE8KU55b+vBu9104SZzsoAC07VdlwAhs1ZzKw/tP//SX53BEeZOaMQWxaKk6zxpVzXJWdAALNc6RXrbvlbCgpqAKrttF/yxMgJNbh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=yQiJB66J; arc=fail smtp.client-ip=52.101.101.91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3Ja3EELb62AVIqWTp0ixv3Qur+z/jsnGHS0rVnGP77S30SIFC+yet55Q1nvVKrQLtQLjETPZlF7s01PfWfNuispfxm4BwMxYM+GSKTbTgfJIBbF0OOjXWFXpxYVSypkgP6S5QIdeORh0Ecuqump2dcsDMZMLp1DENJWtfE19GFM+EyPUQtcPJGpWVTCyAsd+IdfH2a4VoC70yH05xgVFu4ddRw2+/3PfbXzWe9sVxiiB7ec76paC/PE+mPSKePCDTrCTp1I6TWKJves5gRwigevLu/DugYwtGZ9kNwm24f3wqnOUR43T6ek4PEN6prvCbd6tGr5q5JVoPLGbOiSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HhgTkHOXukVX51TZZSbrL+hVHE8KH8dk14SX1Wc2Ho=;
 b=OtTgUAAQpTeHSSLYYQrir7M3cyXb1WZwVUQ0rBbtOa3vx7QUtZcgsOcey0Z+9BQna87/YVtiivxNmDo2OODtIreztZWvKhDLdooT/pzOAyrLQ8UkofqOfXIT9RwqBHly447Je0GZ38VjZs0TRXtGhIo6BUSeH6NmKS+XB4f3lPVGQmtTTD7HivFpIoD3Hp02P6XpTfV51nAEDScYA+/tGlDin/+Wua+3NklIuNLzWzCW4LDEw+QNx+DtSmTogXUQxF8KeOj2QyMan0Bfmr9qD/cXRG9DABvCrPaLAOwaoGhl89lphT6z8k1ZbbF7g8GAALQ5+o5a61ry3avEDB7XGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HhgTkHOXukVX51TZZSbrL+hVHE8KH8dk14SX1Wc2Ho=;
 b=yQiJB66Jk2Q2mnqzYM8eg9AmhoEfWqybFisTjF24WGWaKk8mp1AXgCBC9nJlbSvTN8HKhFBa0L7ssO3khX7SMb4r5OjKPhhtbL9w+jDLMSehpqzDa1C6tyi5/FbnwuclhfFRNqMNLzIcop5pfBAtAHeAdU9vqEqq2PdILjtEVJw=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:32 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:31 +0100
Subject: [PATCH v6 18/20] rust: dma: drop `dma_read!` and `dma_write!` API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-18-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
In-Reply-To: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=8496;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=xdkYZI57kfTpmZRHTNinwPgBzRzi0U1DbnfPFnTc5ag=;
 b=7gj5TvDga3TDEBL2Z9K4HkuMEEVzeuulr5mTr189vR6jm23Xjf13235zE8JXoisoS6+qKliLz
 LzFds2mtpeMCbgrPh1B2fSJmnDQc9AvKLIMY57+i7uaNa4EhqFTCVIz
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 758d3935-9b4f-4a90-975d-08dedb5c540d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|3023799007|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	Lk/ZmvYvfYBZUMHA2SDuIOhPpmd9gdZaem+ZZNxG6HQR6GLy7XeEaQUTP05D1ekGqKf9iTSD7jxpc4JDiMy9LgRbfxryAAdLchyYoyxmSUQ2SZXViYD+o2qFWkpYfPrVNTjb9eab+vAh1Sstl13UKn52QlOUZWBntl4xEBP8xmUGSBggX5r3ZOWUxtZlbuY35LAgsWrTwh1hWzIxtQ3B8SVtw8XEYHqSgLXNoq/D/ijWoB5iklTd5AxeNoP2yMNGGi1kJV2YY3m1nOQS+FZhWgYX6FTD5nohTOgcftJoQOsd3KTObWxzXjRzvuqygik2fuxP/wZi9ZZjEBZj00/EciXBpDbkThA7tRqKEM1qoF+v4Fi3frf8rthfD6MoF+c5rJF5cM84d5ZGSrJgFsWUqqZefaBwQ6UNdsHlh4ljDr8YrJz3bmZ1ToSVrVaitfw7w0k+roMB+amIFnpcHSsVALwye9nNtivwKYGcIU/ELqLy9hAx+t9OpRafpdzZm+JbRns1taCAHxOBFnB1/Qw734G9Q58a8+CEtKFG3FjYMU51Hh7nk0sQ8pGq0MgzBNAUChBNcrn9zPBnk5UR4jJ4CgTuDxvBPRSNWdUr6ALhk/CXm+ZQu562iluyF8nBPAHxdsEgN3LIt/M0/si13v9b+zWaqPai14O8yRgTTpfA2jVGLr8TR8mpSa6RAUIGHB1U9qUis7ElsDglatXmXkIeyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(3023799007)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2NKOE1LQ2d6dXpKYmtEaTRUR2dFSVFrU3ZiNGFGenBoMEdLOHJickJoaS9m?=
 =?utf-8?B?M1NvVVJDQitacnFSdGRveGxEbFExY3k5ZE8vL2pWNzYyODl6UThaTjhobDdN?=
 =?utf-8?B?eGN3ajl4Q0xzZ0JpYW1SeFJudnlCT3FmRjR6VTBQSFl0bEJIN1JZWFhSTHFo?=
 =?utf-8?B?OHBlbjFudE5mVjJtOUhFYW1uS0RmSXZYRTlTcVE0WkF4VlBZM1FVdmdDNnJz?=
 =?utf-8?B?VFFPTGdHT3VtYWN5dzBOQlh6dk54TE1reVJiREdUdi9DZDJyUm9SMU9saFdL?=
 =?utf-8?B?Z1c0SHlMdmxhZTAySm5kSWRJU201d0xUd3VpZVUvc1dYeHhNYnB6V1RrRGFP?=
 =?utf-8?B?VTIxbGZHb3Z1VDVhaDRTY0hWSC94QWF4L0ZuMjdBZFZNY1VGQ0MzY0ZEZjRn?=
 =?utf-8?B?NElyYkc0RXRUTWVZRVE4ejZpbG9qcHZtMUtpb0lxWW9nck9oTTMrTURrNWpV?=
 =?utf-8?B?R0R3ZVhmR0Jndm5XSVdGcnFXMURnejhmVW5MYnd6ajdHTVRacTBCaHB1Rit6?=
 =?utf-8?B?SCtWTERISGRrd1ZucHdWNEFMdXphT0lHUGJMaGdZbVVQTG9Wam5JWUlvQUVo?=
 =?utf-8?B?K0ozNGNGdTFMdXpVWCtOZVoyZkhnOGxCclFiTGxBc0JhZGdQbTBBWk1WTGRV?=
 =?utf-8?B?eHRPTk43RE1OOVNKTGdsUG45M3o4YmNycGIydEViQy9uUFV0TWNnWmt0MWRq?=
 =?utf-8?B?dGhGR2lMWHYvdnh3YWVpSHhBdXNDZVkrZEdTQ0Y1RWJ4VHAyb21KUVN5Tk9V?=
 =?utf-8?B?ZUorZGdIMHNab1p1UDVuVWYzdmtzNmJkVW5rMDEreVhNc0s1NCtCb1JaK25Y?=
 =?utf-8?B?ZDlkUFdSMXgwMmhUNjJ0Rnc0clo1VmY3UWNrV1lnMXRxZlN4dzFWSDExamh2?=
 =?utf-8?B?UWd5UFZBRm5UZ2N2NHF6M1lYVEtESjFQSGZROUR1ZjZES3ZPZzFNZm5NcjlX?=
 =?utf-8?B?ZHJiWjgwb0IzWUtyLzJqZ3lOYVlWbERZaW4rZGthQzdCVWNyNDVjYkZpTk1u?=
 =?utf-8?B?NEFNc0VWOFlRcGhZL3Jjbk93ZC9PclRnV3JlNnd1QnFkeFVUZEUxZ1VEVVdL?=
 =?utf-8?B?RUtVZlJIY3kwdXpMaVpRN2hrTFlNVzNzcWlMbVpWWUR3dUxhbG9VK3VmZXln?=
 =?utf-8?B?VXJ0eUo0allHelNjcmVua0I0SkhpQmErM0JxTzV5SkVZNit0aDIzRkRTRktm?=
 =?utf-8?B?QXkwWnVLQUkwL3llRXNCTzBPSkRhejdDanNGdkZIeGxSQ2FReFlpdTZoNlN4?=
 =?utf-8?B?Y1Y0Q3EzbHJUSGNLVWYrRU9PanYra081Sm5HVDhvZmtRWmVGZTRyYjlhMDJz?=
 =?utf-8?B?cTM2Wk85WE9COEdnUHdGYk8yUFpFR0w2S1lZUmF4WFU5UDgzMWN0SzlSbWhq?=
 =?utf-8?B?TmFPeU92MnpPNm9yMklCVXJqODVsaWpib0RLVkx5bDdTR3dDR2FoTC9FQ3d2?=
 =?utf-8?B?VjhDaEdWNXRKc0paVnBFS0V6V3ZwS0Fjd2RWaU90QUp3SEdOL1ZFM0NVdkV2?=
 =?utf-8?B?SS83Z2pmYm1vSk5ad0NxdHM1Nm91TnFmblM2MmN0V2FkVzArc0dTd1FjNkhD?=
 =?utf-8?B?MDBVZ2VOcUtDN3htelVFYXN2YzAyTUQ0U2x4RVkzRks1K3pLU0U4a3FkM244?=
 =?utf-8?B?RnB4N3h3ZW5VY1FhMkp1dHZoVnRXR3ZxRGVxSW83Y2Fuc0lRd0hsNkMrbVhl?=
 =?utf-8?B?ZnhUbC83dU1EbnE3TkVkTXhHS3FHSE5UaFY3VTFOZENuTEE0MlZTZVBGckZa?=
 =?utf-8?B?VU8yd1pCdmxQeFptMytQRlNHTCt0Nk9hcXFnYzhmVjFJSnBKRU4xbVF6NUEr?=
 =?utf-8?B?VXNqbVlUNlhNOTJmSlNwUnRHWk15dXBpVjlRWDFIMkNiZFU3cXZ3bzk3cXhS?=
 =?utf-8?B?NUwwOS9RVE8veVZUWGkrdndwVjRGQUp2WkFsN2hLWHZsaUNZMnFCaTRTWE4v?=
 =?utf-8?B?bkxCRzNkcGpTUDJsenhScEpaZzFhMFRxaHVkd2xoRllzQXhPcWZ6SVRyWGQy?=
 =?utf-8?B?cUFYTlovY2VNaEwvMGNweFRiTVRxY1YxMlRqYmNPU1JWZzg0UjFYbWsxQksr?=
 =?utf-8?B?UFBheEhwTmRvb1BTVGZFQ1F0ZlJhRmlHZVJYeUNqd3JaUm1wZUE2dU52ZXdD?=
 =?utf-8?B?L3JBazFxeEM1T0ppSEc5NXRCL1Q4bTFQOW1uNkJ1T2U0eVNqckV4YjgyZUdT?=
 =?utf-8?B?ZWM4N0lWZWJ0V2dKSm4vTlI0ZUJRd3hKZTVET3B0MHZqNkN3NkxPODVoMlE3?=
 =?utf-8?B?NzFydVdaWitKQ01tWExUZ0NIQlpiTmhjVFVmMlF0b0dMbUtKS1R0UWRTMjVH?=
 =?utf-8?B?aFZvcDd1RDMvZ1VsRmlhQ0xlTFd0dnc2S1dDeS80M1IweDFsRlRvdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 758d3935-9b4f-4a90-975d-08dedb5c540d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:32.7741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGhPU+MnMRm0DgVaNvaBwB021Emt9Rr7GR7KZwK/aN+JbIdBktPGfzuBAFor0pBbc8g1j91kiEhtWvFwQ7mhLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
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
	TAGGED_FROM(0.00)[bounces-9609-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2B49710D9A

The primitive read/write use case is covered by the `io_read!` and
`io_write!` macro. The non-primitive use case was finicky; they should
either be achieved using `CoherentBox` or `as_ref()/as_mut()` to assert the
lack of concurrent access, or should be using memcpy-like APIs to express
the non-atomic and tearable nature.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs       | 128 -----------------------------------------------
 samples/rust/rust_dma.rs |  11 ++--
 2 files changed, 8 insertions(+), 131 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 1535bc6eec64..6e7ea3b72f2f 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -661,52 +661,6 @@ pub unsafe fn as_mut(&self) -> &mut T {
         // SAFETY: per safety requirement.
         unsafe { &mut *self.as_mut_ptr() }
     }
-
-    /// Reads the value of `field` and ensures that its type is [`FromBytes`].
-    ///
-    /// # Safety
-    ///
-    /// This must be called from the [`dma_read`] macro which ensures that the `field` pointer is
-    /// validated beforehand.
-    ///
-    /// Public but hidden since it should only be used from [`dma_read`] macro.
-    #[doc(hidden)]
-    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
-        // SAFETY:
-        // - By the safety requirements field is valid.
-        // - Using read_volatile() here is not sound as per the usual rules, the usage here is
-        // a special exception with the following notes in place. When dealing with a potential
-        // race from a hardware or code outside kernel (e.g. user-space program), we need that
-        // read on a valid memory is not UB. Currently read_volatile() is used for this, and the
-        // rationale behind is that it should generate the same code as READ_ONCE() which the
-        // kernel already relies on to avoid UB on data races. Note that the usage of
-        // read_volatile() is limited to this particular case, it cannot be used to prevent
-        // the UB caused by racing between two kernel functions nor do they provide atomicity.
-        unsafe { field.read_volatile() }
-    }
-
-    /// Writes a value to `field` and ensures that its type is [`AsBytes`].
-    ///
-    /// # Safety
-    ///
-    /// This must be called from the [`dma_write`] macro which ensures that the `field` pointer is
-    /// validated beforehand.
-    ///
-    /// Public but hidden since it should only be used from [`dma_write`] macro.
-    #[doc(hidden)]
-    pub unsafe fn field_write<F: AsBytes>(&self, field: *mut F, val: F) {
-        // SAFETY:
-        // - By the safety requirements field is valid.
-        // - Using write_volatile() here is not sound as per the usual rules, the usage here is
-        // a special exception with the following notes in place. When dealing with a potential
-        // race from a hardware or code outside kernel (e.g. user-space program), we need that
-        // write on a valid memory is not UB. Currently write_volatile() is used for this, and the
-        // rationale behind is that it should generate the same code as WRITE_ONCE() which the
-        // kernel already relies on to avoid UB on data races. Note that the usage of
-        // write_volatile() is limited to this particular case, it cannot be used to prevent
-        // the UB caused by racing between two kernel functions nor do they provide atomicity.
-        unsafe { field.write_volatile(val) }
-    }
 }
 
 impl<T: AsBytes + FromBytes> Coherent<T> {
@@ -1266,85 +1220,3 @@ fn as_view(self) -> CoherentView<'a, Self::Target> {
         }
     }
 }
-
-/// Reads a field of an item from an allocated region of structs.
-///
-/// The syntax is of the form `kernel::dma_read!(dma, proj)` where `dma` is an expression evaluating
-/// to a [`Coherent`] and `proj` is a [projection specification](kernel::ptr::project!).
-///
-/// # Examples
-///
-/// ```
-/// use kernel::device::Device;
-/// use kernel::dma::{attrs::*, Coherent};
-///
-/// struct MyStruct { field: u32, }
-///
-/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
-/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
-/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
-/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
-///
-/// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
-/// let whole = kernel::dma_read!(alloc, [try: 2]);
-/// let field = kernel::dma_read!(alloc, [panic: 1].field);
-/// # Ok::<(), Error>(()) }
-/// ```
-#[macro_export]
-macro_rules! dma_read {
-    ($dma:expr, $($proj:tt)*) => {{
-        let dma = &$dma;
-        let ptr = $crate::ptr::project!(
-            $crate::dma::Coherent::as_ptr(dma), $($proj)*
-        );
-        // SAFETY: The pointer created by the projection is within the DMA region.
-        unsafe { $crate::dma::Coherent::field_read(dma, ptr) }
-    }};
-}
-
-/// Writes to a field of an item from an allocated region of structs.
-///
-/// The syntax is of the form `kernel::dma_write!(dma, proj, val)` where `dma` is an expression
-/// evaluating to a [`Coherent`], `proj` is a
-/// [projection specification](kernel::ptr::project!), and `val` is the value to be written to the
-/// projected location.
-///
-/// # Examples
-///
-/// ```
-/// use kernel::device::Device;
-/// use kernel::dma::{attrs::*, Coherent};
-///
-/// struct MyStruct { member: u32, }
-///
-/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
-/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
-/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
-/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
-///
-/// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
-/// kernel::dma_write!(alloc, [try: 2].member, 0xf);
-/// kernel::dma_write!(alloc, [panic: 1], MyStruct { member: 0xf });
-/// # Ok::<(), Error>(()) }
-/// ```
-#[macro_export]
-macro_rules! dma_write {
-    (@parse [$dma:expr] [$($proj:tt)*] [, $val:expr]) => {{
-        let dma = &$dma;
-        let ptr = $crate::ptr::project!(
-            mut $crate::dma::Coherent::as_mut_ptr(dma), $($proj)*
-        );
-        let val = $val;
-        // SAFETY: The pointer created by the projection is within the DMA region.
-        unsafe { $crate::dma::Coherent::field_write(dma, ptr, val) }
-    }};
-    (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) => {
-        $crate::dma_write!(@parse [$dma] [$($proj)* .$field] [$($rest)*])
-    };
-    (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
-        $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: $index]] [$($rest)*])
-    };
-    ($dma:expr, $($rest:tt)*) => {
-        $crate::dma_write!(@parse [$dma] [] [$($rest)*])
-    };
-}
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 5046b4628d0e..4af46e99d2dd 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -12,6 +12,10 @@
         Device,
         DmaMask, //
     },
+    io::{
+        io_project,
+        io_read, //
+    },
     page, pci,
     prelude::*,
     scatterlist::{Owned, SGTable},
@@ -77,7 +81,8 @@ fn probe<'bound>(
                 Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                kernel::dma_write!(ca, [try: i], MyStruct::new(value.0, value.1));
+                // SAFETY: `ca` is not yet shared with device or other threads.
+                unsafe { *io_project!(ca, [panic: i]).as_mut() = MyStruct::new(value.0, value.1) };
             }
 
             let size = 4 * page::PAGE_SIZE;
@@ -97,8 +102,8 @@ fn probe<'bound>(
 impl DmaSampleDriver {
     fn check_dma(&self) {
         for (i, value) in TEST_VALUES.into_iter().enumerate() {
-            let val0 = kernel::dma_read!(self.ca, [panic: i].h);
-            let val1 = kernel::dma_read!(self.ca, [panic: i].b);
+            let val0 = io_read!(self.ca, [panic: i].h);
+            let val1 = io_read!(self.ca, [panic: i].b);
 
             assert_eq!(val0, value.0);
             assert_eq!(val1, value.1);

-- 
2.54.0


