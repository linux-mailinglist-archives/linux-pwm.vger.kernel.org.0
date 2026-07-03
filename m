Return-Path: <linux-pwm+bounces-9527-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jlZONHe4R2qDeAAAu9opvQ
	(envelope-from <linux-pwm+bounces-9527-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 15:26:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56875702D61
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 15:26:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=sYEzGI5d;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9527-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9527-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C472302A057
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DD23D5C1E;
	Fri,  3 Jul 2026 13:15:07 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C62F3D1A98;
	Fri,  3 Jul 2026 13:15:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084506; cv=fail; b=DzEYIOSkW7A15P+lVIbCinpyomQyQMCaqrD9NwopFmZC8jaKdaZRZ6ybjnjwnrPVG6dCtedWbd/RlqQD40eoPhd4CsB93zyOh1cdCOqGZSKMDjf0d0kCqeINS8j90MeYeZOFxSCIvyoji93FxygOWLkCdVrqWiN38Z5I977RMYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084506; c=relaxed/simple;
	bh=wx7hhAu9MQg6pp40EDHeqkITwLOONLVgvzv4OPkWYpg=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=dY9D8TswPhDiZlJBExQDGFRLqoVTPmry+46KKauwJcA9BMxqzaM1IK46gU37ajdnXMpYhdG95V4Oxre3u9jrb3+xeBeJZz0m2EvkHnSPLLUWMFs6QWdcwzbJYVg27AtUilgJ39+yPdl3NW7CN9Gm3FusF16ZGzEDqZC2zMemXME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sYEzGI5d; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1M9CalcRFsemrMZ7O1kejryhDlkWbSbZyZAkjWWuBeVCm9ZL9RQ/qFDJ1XXkHUnXapHMUtpYiWExkKVtHSEYLdqlY6IhcaNGcDWRSTdSguuaAbZQEurYLBVmytSES6WM586Qu7r1Js9tvhzRIsEMyXevd2qu313yiy11gYvFT8rU3VzseDywvw2RwQ7QHkOnpWRobxiFAJUcDQMAuHv1d/23FXR3FgDqZfUV2QirhbeRIDMmavz3WKauJA17YuunV59yxVFeIVyTqfkQDbJDXyPwRvMyzvSAulRMOG/KOXaLRX7p/4vzbgg7JFOgvRUtsZB08Z4MK0IzDedqekPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkIDeNE9ULtxn0LmB0IREQmWxfquJkcp3PWwel/ogts=;
 b=N8yBgGrt5Aoh06uT962wiGfUWAddUA1ZeIYqPOf/H9mdYDAnI56jrK8BCDoJmDQ7WEw49DokC0jyeBDJIjVCiqoHdbuOb3M89Bk55w44r4wVkr5hV1BGIf3KWoZPJtKVMqh7OIBpiRRuA3jxBs1bJHT313b6xOJayMgyCJDmw0wj7YauxqeoU0z5vyeDcNGrh0a8W3T5mHcvIxWSD9+rAi1OBQ1CJVVPJOnFWXrxNq9L2WV5FaN4AM8Gr0tJjut9bZefHna0NF4xNCs6fP7JVCZC9eAIf+BVI2FJMFoTP9PLxZNNNeG30L8ftYh3KZTgFXkOdQczBeJ/f4wNfgdiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkIDeNE9ULtxn0LmB0IREQmWxfquJkcp3PWwel/ogts=;
 b=sYEzGI5dSOYf0WHDPOE4+OzEIzqk0511/hAzEOaZwo0oFHi/Y35XjiDkFqCAyG/mFNOHjV2yhj98ldrCqHFfPJBl//ObeQOlypeoMKcNGFyxVHAuG0iTnbni7pRfrblj4gpt/0aBwZyagMKSeEogOKhh6QHkeya00pu5ULnMDjsaxkzS06JXN76IGUsLfoVNVRsYT5GRlBYALV714u93lokeEfzYcfjkfwHp9QRu4oS0SzWcVzaWlSjk7omLItXRX8jzpu3VtNu4F8q04KSULQgKjs+8B15U6+yswCTcKvT0QQfQI1MX1FP80pfcqtsXbcWBSB1RELd++KJh1OXgdw==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 13:14:57 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 13:14:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 22:14:53 +0900
Message-Id: <DJOYP821KAZF.IZZ0ZOF10AG1@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
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
Subject: Re: [PATCH v5 15/20] rust: io: implement a view type for `Coherent`
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-15-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-15-d0961471ae50@garyguo.net>
X-ClientProxiedBy: TY4P286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 1712444d-380f-47b5-2f01-08ded905145c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	TxnkJ9WkoUgWCgvuIxS7l7zI7r0Ug3BnSh3UmTN9/cFsusZbhWUQDnq6u49jRXeFqkjVZW22/K0eDF/oPNBPvTzSvJ7ca9ng8ZkmiVqhU+C+c+XPFKhPLAkbtzRVqzPUCdTV0z8pyVHqSLAq0kCOVernGAlldgAUDcDkkPCLkfKGUuMaVVUS4uct0S+EN3/4icqjHJJiMpyUoZTAlWVcG5gxHOOO1NRAd/yOMj60E8xeX0fXsH1TgKOHcMrxUb7alVzoQRcsMSPtjxFoajTSIdzdwD3VWezaRktnN0pIdYcY4qVUp1D/kfWyvSIASpCmo+rguC7vXSA4hPDaiEbTqFOSxSq1p10y5vxOGt4Ux424+CdphFRGwZRacb+d68I5RnnM64WQ6Uzp0UW3Z2BtrUPIyZEg7JSgUUDrSgJrTfWu0syoAg3dCaqtjFP/E4Tj/mtJKZwdNioOxC8cTJ1okl86h8Iu21INB/LGXNi2qE9ccs292OsQ3rs4xzpLop3nM5EXkrniMA09U7isP98WuEqURPRxa3URXI48cFXJLt8cZBmo8Xn247w8xxZ9QouG/ZEtg0ITlAqELuYS5lm2bgvY3Wgufw6uW/WXTepfF6fP8eon1gMOn7Fz//wjHB5Wn4Rm+4IS7tKgnaw0eX94cNudUlLAVeoNuou66XeiYOc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0szT3dXSGtyRU1NRkxzcGpwWVZBZWZHRDFKR01NU1BxOU5rWFdqUldyc0h3?=
 =?utf-8?B?VVNPMTNTTE1JQUlrb0ovWVVCT2tyV2x0VVpxWGRvNm5GM2hsTkMyV0hlM2hy?=
 =?utf-8?B?bzhETkRySGRYNEdhbUFLWUJqbFczRmZkNVh2Y2M5OE1uWU9YNXIwTFgvWjlp?=
 =?utf-8?B?OVh0VVdNSmJwTTluYWVGM0pVZWYwaWZqSkphYXMwZ1pid1NxWFJUUDRBamVk?=
 =?utf-8?B?WlllM21ONGxHaUpBemdDYVBkWFdRS09oWVZabnNxRVYvb2VlMW9lYndNYlVC?=
 =?utf-8?B?enova1JFYUtHTnBiU2R3VzdQcHA4WjVobVFCMXVXek5XYTJhOWhocGZXN0p0?=
 =?utf-8?B?bVdjVWFVK2dDOGFSVDR4WFlJWXc1T00yKzZ1OHk4M01YMWtmTDlsQzVoV1dh?=
 =?utf-8?B?TWZRYjRWdVlPaHh5REJ6UGhqS1M4MmI2akFFbDlrMTgvVVpoekdmTnRQSjFn?=
 =?utf-8?B?WDZ1UHdBKzh1RGFDc2tuRlowSEdlSHJneGlJMkh6bldyMnZkZzBzbVEwT2or?=
 =?utf-8?B?YVRKNlRUcTBLMi8vMGtzUUcvcWxJYnBEMWpGNmUwN0FJQzF0ZisyK0l5akpN?=
 =?utf-8?B?dmJSR2dZWmllUkEyQmExblJ0Uy95QnduQzZidXB6cU5pZ2NweTFNTFVwaE9k?=
 =?utf-8?B?OUgxMVAycCtvRndBc2U1T3FZK3dhajBNdHhEQmNPOHY5bDczU2NnZ2liRTlJ?=
 =?utf-8?B?QThVV1ZNdDI5dTRkeGpkUUMvdFBkOFg5YTYzdXh2K2hxRC9VRktLcmx6TVVI?=
 =?utf-8?B?ZVQwcm5VbzB1aXdVNm0yZnh3djZESENjMC9JSXdwOU0yTEYwTE9LRlVMOGQx?=
 =?utf-8?B?djg1R2ZCS1dPWEVCZVlVR2ZDTWdGeWp4Wnc0VE1vL2pBVWdHY250N1lKbjZm?=
 =?utf-8?B?YXpnZEtVYnNGeXEzYUxxU1BsQkJsclhxaE1ueFVoajl5VjJMSStEdWhYKy92?=
 =?utf-8?B?RzJDakVyUHZyK001NlZ4Nm16OFBWOGFPeEt5Q05lb2NrZ3BsKzRkV0lOc2Qy?=
 =?utf-8?B?T1NyTlpRTkVDTytPbVFtYjNqeXI3ZXRqalZNTUQ5MUp4STlENVZuK29lV1Nq?=
 =?utf-8?B?dk5iamZYQ1BDcVdNU0d3aW4vRWw3TEZ1ckhDcThJTVdTdWI5Q2ltZmJERWZa?=
 =?utf-8?B?ejZJQk11bTlHQ0srZTRGWXdxS3doT3ZVMnhuZWt5NXJ0MkhXY1hUS1p0L3VW?=
 =?utf-8?B?N04rYXJQUmdkK1NBU3hVamxySUxXOFBxZlRQeE5MUExjcjdnUDlWOUFGckR6?=
 =?utf-8?B?NWZNdjdoQUpOMVY2RXlGSlVBamRmUGc0UzFHOHhYT05MbU03SlVrN0lWa0wy?=
 =?utf-8?B?OVUwNkNCWldxandNdmNtelg4ZldlbThTaS9ZR1ZrQy8xRDdZSDBkL1FNMHNQ?=
 =?utf-8?B?UXU5K0szWG0ycjI3bDJsU2FjZitJZzVpSlF2YjR0VnFwV0Y4dXhQOWtHc0E1?=
 =?utf-8?B?MzNqRXNXeVZ4bmJnQkFaYVFTUUw3SERMdDdNakozbUlzbHVUQk5RWE5wWU1a?=
 =?utf-8?B?eHJCRXU5VkpiWDZHQnZoL0ticG9xZXQzV1Z6WTQ4MmRtNCsyTWlyekpaTDNz?=
 =?utf-8?B?SndBaWhBTitvczFsMlZ3QURkWWQzWk43OVV6TWdSVHppSC9FM2wwYVliOUF1?=
 =?utf-8?B?Q2laNHNSTFQwZjd0YkYwT1ZGU1BWLzM5d3ZsbkoybGY0azVSM0pxRVBFRENW?=
 =?utf-8?B?cW5CODg4K0NhM1pMZkRpUzF5N3VoK3pnUmNEelJxQ3VnT2FKTlhGbTVNMHZi?=
 =?utf-8?B?eENaOWt4OFhLbUo1RjlXczlXRUFiSkphd2xmSlVCNVlCcDJGTXo2bHNjSlVj?=
 =?utf-8?B?cFlvaHZDZ2Nmdk9yQXBkWFMrdmxOMXpvYnp3WFhxcG9xaU5LYjRIdVNuRVR2?=
 =?utf-8?B?WC94Lzh0MUFKSDVLNWVsMXd1MkYrd2tnRTNLN2VuTndrS3JUakxvV3d0WHJP?=
 =?utf-8?B?VlpJRXhoRW9GZ2YzcDF1TGY5c2tPdmFPNlVYdnF4am1ocUZTUU0wUzg0bGV4?=
 =?utf-8?B?SkRwRXhaWXN0OWVwTDdDOVZTaHFJQ000cy84cWtFMkNrc3lEbkg1MlAybW1z?=
 =?utf-8?B?WEV0dzdiY2dFQ1Y1WXcrZURFaXE1SkxuODBmZUpzKzVIWUE5Uko0U1lKTjA0?=
 =?utf-8?B?STR2cFV5b2l6d0Fpclo4aktFMytqSHBvbFRYd0RWNGcyNWZFSlZJeFRra3Fs?=
 =?utf-8?B?LzlxOFZFeDdJSlBVRHVuUmdRNmw5ZFJzeElaME1zaHhjbytZUUVJUUl1cTh4?=
 =?utf-8?B?d0VrT0pxemRsd2lHdTFUVXp5NlJwaUxXNjFPWDRwS1R6WERLV0VGYU9KYytN?=
 =?utf-8?B?eDBJbTFZR3NVL3hvQ0h3bisvS3Jwbi9MciswWnptdFB4TW9paXUyemNLc0d6?=
 =?utf-8?Q?psqpOrzn/Xxuk5j/Jy6RdRWippe9DKEzUzORC7D5pX79J?=
X-MS-Exchange-AntiSpam-MessageData-1: x78GeTtYoxPWkQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1712444d-380f-47b5-2f01-08ded905145c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:14:57.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0P29lyyb8PkPDTOJVB8mqYWOS+EICCPhNMud0nwyrzUH5RUbOIIrLbqjCadzc85C+3ulK9UEwxSUyPspBGcAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9527-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56875702D61

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> Implement a `CoherentView` type which is a view of `Coherent`. To be able
> to give out DMA handles, the view type contains both CPU and DMA pointers=
,
> and the projection method projects both at once.
>
> Delegate most of the `Io` implementation to `SysMemBackend`. Provide a
> method to erase the DMA handle and give out a `SysMem` view, if the user
> does not need the `dma_handle`.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Of the Sashiko comments, the second one (adding exclusivity requirement
to the safety comment) looks actionable; with that:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

(one nit below)

> ---
>  rust/kernel/dma.rs | 137 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 135 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 200def84fb69..ab6504910e4f 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -14,14 +14,21 @@
>      },
>      error::to_result,
>      fs::file,
> +    io::{
> +        IoBackend,
> +        IoBase,
> +        IoCapable,
> +        SysMem,
> +        SysMemBackend, //
> +    },
>      prelude::*,
>      ptr::KnownSize,
>      sync::aref::ARef,
>      transmute::{
>          AsBytes,
>          FromBytes, //
> -    }, //
> -    uaccess::UserSliceWriter,
> +    },
> +    uaccess::UserSliceWriter, //
>  };
>  use core::{
>      ops::{
> @@ -1133,6 +1140,132 @@ unsafe impl Send for CoherentHandle {}
>  // plain `Copy` values.
>  unsafe impl Sync for CoherentHandle {}
> =20
> +/// View type for `Coherent`.
> +///
> +/// This is same as [`SysMem`] but with additional information that allo=
ws handing out a DMA handle.
> +pub struct CoherentView<'a, T: ?Sized> {
> +    cpu_addr: SysMem<'a, T>,
> +    dma_handle: DmaAddress,
> +}
> +
> +impl<T: ?Sized> Copy for CoherentView<'_, T> {}
> +impl<T: ?Sized> Clone for CoherentView<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<'a, T: ?Sized> CoherentView<'a, T> {
> +    /// Erase the DMA handle information and obtain a [`SysMem`] view of=
 the same memory region.
> +    #[inline]
> +    pub fn as_sys_mem(self) -> SysMem<'a, T> {
> +        self.cpu_addr
> +    }
> +
> +    /// Returns a DMA handle which may be given to the device as the DMA=
 address base of the region.
> +    #[inline]
> +    pub fn dma_handle(self) -> DmaAddress {
> +        self.dma_handle
> +    }

This is really cool - we are doing DMA handle arithmetic in Nova's
falcon DMA load methods, looking forward to replacing these with this.

> +
> +    /// Returns a reference to the data in the region.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   reference is live.
> +    /// * Callers must ensure that this call does not race with a write =
to the same region while
> +    ///   the returned reference is live.
> +    #[inline]
> +    pub unsafe fn as_ref(self) -> &'a T {
> +        // SAFETY: pointer is aligned and valid per type invariant. Alia=
sing rule is satisfied per
> +        // safety requirement.
> +        unsafe { &*self.cpu_addr.as_ptr() }
> +    }
> +
> +    /// Returns a mutable reference to the data in the region.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   reference is live.
> +    /// * Callers must ensure that this call does not race with a read o=
r write to the same region
> +    ///   while the returned reference is live.
> +    #[inline]
> +    pub unsafe fn as_mut(self) -> &'a mut T {
> +        // SAFETY: pointer is aligned and valid per type invariant. Alia=
sing rule is satisfied per
> +        // safety requirement.
> +        unsafe { &mut *self.cpu_addr.as_ptr() }
> +    }
> +}
> +
> +/// `IoBackend` implementation for `Coherent`.
> +pub struct CoherentBackend;

nit: somehow I feel this should be named `CoherentIoBackend` for clarity.

