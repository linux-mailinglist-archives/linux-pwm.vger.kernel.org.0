Return-Path: <linux-pwm+bounces-9019-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNvGA+tgDGpXggUAu9opvQ
	(envelope-from <linux-pwm+bounces-9019-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:08:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C2857F502
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90134304EFF4
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753FA4EA388;
	Tue, 19 May 2026 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="i+vRCyGQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021134.outbound.protection.outlook.com [52.101.100.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15564F798D;
	Tue, 19 May 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195735; cv=fail; b=Vuvwu1ijTsOUdWMaVaeN2fIxAEyd16EhwSJseFy7RnrmLp2r+k6EbNN7yXbOyep+Ui9XcIGTmZrpdwyf9hwUr13cjXjwiEzvnla+GuSnwOOdE2+Cg7+/X2V7Yr2GihpT8JDmyLKPJZAlM0leQAczhvoB16rWrJQF2MS4IhKgeu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195735; c=relaxed/simple;
	bh=TaUheocgVj7msXBafEl4cfoDV7asz33g+brhsHjy/Cg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=LgYYly/+LSJyrGOF/+j38JqZs65R7vfAqmwCGm3t6PtyOMGlXxEqXCa+gdCMj2PFkNyIQqHHdAeriLBuPNnWPY/OGenJDqXSHJllvIxe0LHnaMmzsgxQbd2KqddmOTCRAbH+4r1pGi/vEWjzVYmj9kZROrySzQSZG1UYxPaYti4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=i+vRCyGQ; arc=fail smtp.client-ip=52.101.100.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7Ehgu3A1PJORHmXJrI0qIRsCsD8kQS3zJ+Tj3Vr81BBy1PV7BTdA+/Caitf8JvMFgazMTb5DRfdFiN8Zxhb52yf+qHfn2TccjCSesGfyF/YEPq5yJN8oMiPFQmX0alixa4r9uhCTjNCgL6qoXYExyD8QrpjVZnV4mTS5H4Qwpopc+qibFXMFECa3NgQxE7w0gbNyMl5BO8M8T+nX+x9DiqS/Tno10Uruc2gjuX7dtoT2HUUe+I+EATQaG4OFQVolMA773ck+a2aZhPNNPxp4CB3I1CdiUa6fRs6yrVEO8wwLLvlliCBgyOTrGYIitRaFogo94n1GHNYpCf089uhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYxdpkRZRdAkaRTtiIg5Q12+m8h4vCEIchB60r3KX68=;
 b=P5UkZ8kpxz86Lj2w2iVEPJfL0pJTuqlEOi2S50MbFdWv6/+6bPqLbDT6R6RE98NTBIWzoomC6FILEPY3kDFtS900rPVVJuBX7mmvLbppHgY5oAyu1HmxakRiyQNHsYRdEG75DR+BoOlugA6QUUqDiEpD/SKJp07pgUz+b+MFW9Bp8KetZRo9swHp3dDusj43/4iOwW70B3ifWYtE+n4TfvIaUg4JEocDoKFJhRv5Q3TnY1705qiEdoe2NcjrH3L1PkFKOwwbMbajRhyRjY770wba9uViF5bAX4JD9SHOpgnoaFnF9yumAurQKkjAgqpUjaIqPfw66M75ir+j8p5jnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYxdpkRZRdAkaRTtiIg5Q12+m8h4vCEIchB60r3KX68=;
 b=i+vRCyGQXLF9pENqD06ZotC1e1laVHnwuDjq2rnosqIdv3z+EVELQp5z/ysXdgf11e4/M6mp+is4LP4UY+RLJjPWJ3vSRALvaUPxaX8ZgYEpzHo/SYCO34ffpAuxWz03lkOYjIIGNxpM2AOkdsc+rdqGXOujARk+mxsqNMCrBO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2231.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:75::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 13:02:09 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 13:02:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 14:02:08 +0100
Message-Id: <DIMO8XXPUA5J.2UT54IY6GNS9R@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 08/27] rust: usb: implement Sync for Device<Bound>
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
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-9-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-9-dakr@kernel.org>
X-ClientProxiedBy: LO6P123CA0054.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2231:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c862641-b97e-4d9f-bcf6-08deb5a6d5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|18002099003|22082099003|56012099003|921020|4143699003;
X-Microsoft-Antispam-Message-Info:
	JN7egpaXqlUAHHz9as+4Y8Qxf5To1sqQuA2rM7eijgXKdxEwhuqCUXGHIbwVayo/bRQY1B4TfPybKMgz/cUdl1sAeV9wctUbCxq8f6NXZPFLx/iWMntRQgLjOnpbxW6rkotQCBRNi9o9Ve2Vq/eOiWQOf9GPigU4t7KEMQ4MGZbvjVJUfOmnziOoeJoQfmjymlvlAqaUeKZK36Cefpd+rTGy4889AxvKfEZiRU6sSIdJpTfTPtOJJBAtGJ74unKxTqC+zTs/k+VIxnii2F799lmx3RPhsyeX/JUU/KxoLBJ6f2R4eiOFXEw8TS71RH+PJ7F0qMUZQztEarcbVA0GqhXL6iYLnNu4Uc7B0jKLCRmoujElwwdBEukTkqcrgS8W5Zqfws5nyDbEQMGH4VBakpPgKwcL+ksbNF9Bna8BLmcWLUWuW7xc/ycYWzrDHdatf8wR8qxveflNBYvNX4paS44kjJA2ULhpZJWRx/O4PG2bDi1Tuf2l3gTTm7iONVnGMUJdMjBxooLg4dVyohfV69R3a71GzwykcQzVLHR5guybvRue5BSOUzHNWTdyN5GY+lfLGL2LnARruzlRLqTSLNRQg6zN/QuQtMKrhQWriQ2CY+tuX7qMzV6AIoqv3J85jZuCG/dTW1KambaVyKGa3ZLO/UfSicYxFSOFGq5GkJVtF9485p6XXwYI1kzGM8WwKF566WZmnUC2OxrnEw7SPTefyp0TUTS7xhSOhj2MRco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(921020)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cURHdWNaYUpUNUNRc2JLSi9vNmxsVXIwYzlPeWdQNFJ4SVJZWFc0SHVyNlV1?=
 =?utf-8?B?MWZxN1dIUU55cEJPajZZb1VjSlVxbmIrSFFmVGY4WlpsSm5NMzBXSUdmWWxK?=
 =?utf-8?B?TmZ6VkJWbS9pbVBiYU9DNE1Bc1k3TVZaQmFncUY4cGhETDB4L25JZ2puY1pr?=
 =?utf-8?B?cXpzTVExSml2bnFyYi9hV1VBYnN4WEx2QmJLY1J1MFNuaWxUUHduamkzbUFh?=
 =?utf-8?B?cS9KeEdaUnZlYVgwMFdSR3k3Tm1BTEtBNklzSFdSZ1NIWmRnNGxQSmx6Sm9s?=
 =?utf-8?B?L1JhZVZmSS96bjdlZWJORU5uc0JVUVQ0R0t6dGlkelMvQnBYelpGS3VyVktW?=
 =?utf-8?B?ZjdGM3dvNFMvSi9lYnoxNnJtU0IxblB6bytNdW5JN1FiSmNYNVhDMmR4U1Rs?=
 =?utf-8?B?UkdSeTVrT0xPWVQ5NS8xc3pMcU1rdVhGVWZmNUFEZmR5eko1SHBFeFM5MGJ6?=
 =?utf-8?B?WFU1b2R0NlZ4VTZnTDRpUElwVFBVWmN2eENocGhYVmlNYnZWb2Q4akt2THZI?=
 =?utf-8?B?QlBTUEQzSHlWZG1tRzdnU0JiVEhVaHdpVEpQOFNaN2JEM1UrK3AvQ1dHbTRC?=
 =?utf-8?B?SnJQMkhuQmtzVTNCL2tiMU1yanQrZnBQRlowUXVYd1lVMGJ1T1VwcUtsYitW?=
 =?utf-8?B?cStTYURBUm9iVXp1THdMSktTUzFzeWlFNll5dDlPUklIc0huY2UrVTN2eGx2?=
 =?utf-8?B?TmNiTDRYdkpZN0N3N0I3RFgvbEdkYzRNbE8vYmNCZTdZb2hteWxFNE5PQnNo?=
 =?utf-8?B?ZjA5WFllTkpVL3NXN1hrdkZ5RzE2SFRkUU9PeWROeHV1bFVnSURYMEN6YnlQ?=
 =?utf-8?B?c2pabEE3QTU2L0theFZaY0h2bGpCM3VHS3Q5L1RwUU43Yk5uSXkzR05GWnBh?=
 =?utf-8?B?VUNiSEltbnVlV2hoQktqR0RISnZlYUtpV25tNmh4S05OSlBwOEp0aWJHbDRN?=
 =?utf-8?B?Sit5UTFkVmFweVRKZVlTTEFCS0xFQk81N1V2RmZaNjJJYjBlaGpUSHUvcDJp?=
 =?utf-8?B?bW5aVy84NURnd2h0K240WCt5elRCdWtremMzUDRYNmRuVk5ITVY4Zk12N010?=
 =?utf-8?B?emlZOUpUWXBZNmdNeFBFaWphRjZELzRYMllLdUxmQUtUUWIyYzhBUHpyRkhk?=
 =?utf-8?B?Q3NXRGgrYzF2bklicUlTMUpaY1lMb0MzTjJySkJEU0I2YndocUVaN2swYkRC?=
 =?utf-8?B?OUsybGZGb0Rpc3VOM3R4Tk1lWHQ3eHA4bmVwYUVaZEVGNFNLTDdaSm1yOWpD?=
 =?utf-8?B?VEpRS2NrcXEzeWhhSHQxSEZzMEdZdVFYaURySThVQUtlN3NnM0V5NEVLMzlY?=
 =?utf-8?B?aDJoT2lRVDFKMVgxc1V3YzBCV1BaNytRR2IwcWpGWUx2czBLaXI0bTE0WHRT?=
 =?utf-8?B?dlFrb3h3c0o5eDlxOVlEU2c0MytKWmc5WlRuSUwvaUM1Zm50QzA3aGlnWGRO?=
 =?utf-8?B?OFp4VlZCRGFRREtDK0pnU2gxWEFETkJOamVaMW1LRUhhdkJHSi9uRDRSVHNG?=
 =?utf-8?B?b2xNc0gxM01QS2ZwWDJ4Ti9IT0V4U1JkVlNFWWlCajNEd0dUSitra3pzc056?=
 =?utf-8?B?bjhGVkh0Njd0UjdsY20xcW5oYjIzeDFaVWxYbXpjUFo2K2pEbXZ1TlNUZWVP?=
 =?utf-8?B?MWRDU3RkbWw3NFJqcklZU0YvaVgwSng3anFiR2EwWDJPNENqeU5hV2U1d04y?=
 =?utf-8?B?QW9OVnBwWXBsc2VwNHY4SVlhdEVNeE1YTkZyQVBJQzlqVytQdG1KMkRVVmhW?=
 =?utf-8?B?SXZXbFh3Z3V1eUVWNUIwY3pmd3ZSM0NPTDNjU3NQYmpJSTdDcGY5K0x1UWZj?=
 =?utf-8?B?eXhUNVErMHV0b3Y5Z0xqNk9nelFOcnU3VVh3K1RFdnJ0QjMxa25Nc0QwTHFm?=
 =?utf-8?B?Y0tWMGM0T2RhSU00N0c3enhXcGFjZmsrMm9zM2FTbzhmUjN5WVA1WGZRT25i?=
 =?utf-8?B?dEcyN1VDNTVpZGdyajZxbXQ0MXdUd3RXSE03a1k1VDJZT0xuN3UyNFJrTDFs?=
 =?utf-8?B?cTRPOGJtVUlObjY5Q29zRUk0bkk4dGdDaFljRlJmb3prbGU0MTAxZGZWZWlX?=
 =?utf-8?B?R1JRNnEyL2phQ3J1dFNZRXFGTjZWenJnVzJHSVY5MmNKTTd2cG8rZWU4TW9i?=
 =?utf-8?B?cXJlcVdDN2xUZXh3UU5DZ1pHNXE5WkFMVDkvWFgxMGFBVjYzc0llajJ0aTVK?=
 =?utf-8?B?UUVUTDFoUGU4WkVCQkRCVzhNc1FwQk5ZMDhWSVh5UU11YVB3LzlzWDFMV1lj?=
 =?utf-8?B?NDVhazdaYWNIcVV0c0tzRldqbEpiTmhEU1NCeFZlbzkxbm1SVVRyZ3FrUFhx?=
 =?utf-8?B?UTdIZ1lhcmU5bGExYU0yd0ZzOEtRSjQ2dHBWc2Z4bzBRdWFhVUFadz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c862641-b97e-4d9f-bcf6-08deb5a6d5c9
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:02:08.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvgIgNsm0A8HQOJe8yhktDPeyqFPFUGzaf9GrVGzXOytCkiHwyJkgWdM6V+/cIuRxbZ9Ys6VwjAH8HBO0tbrzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2231
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9019-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: 17C2857F502
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 1:00 AM BST, Danilo Krummrich wrote:
> Implement Sync for Device<Bound> in addition to Device<Normal>.
>=20
> Device<Bound> uses the same underlying struct usb_device as
> Device<Normal>; Bound is a zero-sized type-state marker that does not
> affect thread safety.
>=20
> This is needed for drivers to store &'bound usb::Device<Bound> in their
> private data while remaining Send.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/usb.rs | 4 ++++
>  1 file changed, 4 insertions(+)


