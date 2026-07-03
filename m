Return-Path: <linux-pwm+bounces-9515-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9nsjHy1RR2pJWAAAu9opvQ
	(envelope-from <linux-pwm+bounces-9515-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 08:05:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E05E46FEEFA
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 08:05:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Lu38gbqc;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9515-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9515-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A6D630989BC
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 05:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED1E364925;
	Fri,  3 Jul 2026 05:58:23 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C1C360ED2;
	Fri,  3 Jul 2026 05:58:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058303; cv=fail; b=rx+dZbJsGd9sLSqK9ga1/bB8PDooS5VjXngilIahCpKPDwBjqBbQOrZqf6NnLjRlqNnClest5VUwEjmPhHdqjSbE7s6tchiqQFS+wHIkYKtmCzCjq1ABJEOUpf6DLTx01JQG389WN46Qg9jSoaGW7AnpPCyOGuxLcrcqe4D5nik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058303; c=relaxed/simple;
	bh=XfVYlBkQ3VIIt7tEHkupg1xLjhooSfEn+I3J9Np9fjU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=PlcwGpKBPq20HVUq+3XzvQWpxRY0JCF9Z7iwHj7x1/M2Be5xF/AiRHEgJpifXxpfwRXjY4vm9CJPgDZnAVR788ujSDNE7cy6MsvCdJjcsTr8rWZ9ddqq6c2PJAcz8WCMz6S9utTwYvFivbEQDRR+L133W5bEdP9FZin7lTcRxTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lu38gbqc; arc=fail smtp.client-ip=52.101.193.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sI4mCxu6xyoOWfgu5hETD2650/Oyn8CzyAsvSfLxGclrp1k9CpVMpKItXBzAddwcs4JiO2hnmewfPISIFw+N3VajjVhLlAjFLsCJHrjl2aSV8oMliFpawreLRB84wgHACc/p57no33ucEXJwNXkdw5XfSBcB6R17L2/r10MnnFMMVRt5Ch3vaPc5v1QDDAO97LhIhiNBm7mTFxYSoChb1hwRqVCxjMk6tL9DvlmUfm/O7XjBxTFZg5Z1HONdXPgflPgyDNx2zq1mJvhNE/edXbW+ZUQlzZwgmx7Wn+hIK1dwwOnZfYehKd/rg4wsy7gfahG8MzvodyLiQXCKhDasug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfVYlBkQ3VIIt7tEHkupg1xLjhooSfEn+I3J9Np9fjU=;
 b=fTBYFsFiZUfuc+YEzY6cyQ/oRyhw6RhuWf1OuU42p0GZTqr4SDg7pXY7lzSGNE/mL9DBKVsAlmAL+OokXv2VC2jW5riPLa81Sc6eH/zLeuYZqvTvXKkKzeJC4ygH/ks0X4r033jegwpHU0Y4m+ufXIeBntWFX/kcEldwF+kyXQyIqGsXIPcXRbDpEFE93E4O8rBiqiYY/VlQwfogMkG/VqD7+BTkKvbQ6Fj2Qvprmj79cw6W/Uh/xvOcPi3mW4WgJliRtMJOA3YZHcHnmNGvgPTg+9VMJ6UTshWa9L6STfXj2CNYLxPsyUTyp4OWdfqBqltHS458CnVPDjm7D04NZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfVYlBkQ3VIIt7tEHkupg1xLjhooSfEn+I3J9Np9fjU=;
 b=Lu38gbqcJy9jJ819qjQLflZVE0Ui4wp+9rGkU3ibHdHETBG2dTGYLdoKY9wf6VMolX5l4XG3p+DnvnJ3Efd6GO4rXnESRr0K9nPq1qpkrV0JO53AGvojtoJAvKiFkIBfKFBStxfjZyAwRebir0m4nKkANQzFlU17N4SKNt5ealw0vEDJRhX4ZuiEGnSt0chpW+z0Et9wRtyNRbUhalzHzcKBHDeP2Qh8tA2fp4qhCK4gkfnT1zia1fyrw9V4NAudoVE9+iHkOONB8x4ErjQB5IAjL/G0CDi8TQvWWHAn7HUZMhKD/Cm4v73lf1j3qkGLAf3elomlAD+TjQNpi8lq1g==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 05:58:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 05:58:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 14:58:11 +0900
Message-Id: <DJOPEUV2F6Y5.18ZVVR83782TE@nvidia.com>
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
Subject: Re: [PATCH v5 11/20] rust: io: remove `MmioOwned`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-11-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-11-d0961471ae50@garyguo.net>
X-ClientProxiedBy: TY6P301CA0014.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: fa30d9ab-9812-4c0d-a3b0-08ded8c81244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|23010399003|366016|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2NQh9T1XXqGZaiEPCBoKAqG6GkTQsha1HN7MEjcaBd1F1xo7CUJG7UVmGbE91TpgWUWMGvnFt5IwBpNlXAy/UzbNp6PYzbliXkbAdLSMlsd0Fv/VyfEVDRo4If9upwBYzdiYkGITS76OFIGDNM1c7iZnnw4EjiHA6MWVdgWoPkdTTHe+Lmwkqfj2lhyAcHZ/Mqc1pNx9HideNsTVNtbRUMEm28PHBdepxJGgKiSck61N/uiGJizYU38w3CzXqPlm2Mpif5e+Q3dinOWQ4VY4auBDPiheclc03LJcz+SIyxzsJ+NWo4wFMuwScg31/vPGDm6oc8bfL94FZb/UgXeeuHrHQpOA+BV+cgR58bRt6V3iXp5OdRwy2VW5vn7c+qyIk1YkeVF6O4DGbJVZ4ctoQ4z3fCUIz/uSsGueXAJJ/PaZ3bjuKcyWzRPGQvYU7yJBu2g01k9rOlK/M1oPdoGQNDoOknCswrraUh9krCZ9Ya2VBx5ZROFApZ2cA6cqdlYO+5pVHjKm11cvMcHt8JxcmDb8GqO2RPwey7jNyiU0OcxQFY08t7I2ZC0udZRvx8VBfkdwVyhbixUOrJHYAgO5A6j2cbRrr0qtCsJJPbuiDZS/yCubSrk55XI4rnpvM4gZtEtOky4L8cKAFdXzJRSbZuNOlrLxJsIQJy3T2kIVE+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(23010399003)(366016)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnV4SCs4eVIzNnpVTE9pV0NaQnpOb1VGVDcxdHQ4MmFLM3BndlBCMFBFb1BF?=
 =?utf-8?B?UjFNSm15WHBhMnVDd2JPbXhMQU9ES01iQTk1M1M2RHJhYXlKcUJZcXJ1STlE?=
 =?utf-8?B?NGJEaExvWXdNUFRBaGxwd3hiSDZ6QkxBbFpLVm1odkg0cnp3Uk15WXBqaHRj?=
 =?utf-8?B?U1hnY1NwUHArL0wrck5ZSGlyTit5eVY0S2pURWtaWE41WnhIN0NCRmpuR0pu?=
 =?utf-8?B?ZjRwQS9hc2l5aFdZTnhGSjR5WThsYzdxb2NEa2ppV3grcFhmSWg4aUFIZ1RM?=
 =?utf-8?B?Qi9sMU5VeXRyblJPbHR5RDh0bDJQYWFmV01CZGhvSE03R1pQQnl1cDJsMnMv?=
 =?utf-8?B?V2pvcDhtc0dHbmczRU1LQldGVTFYUE9GZkhKNUE0dFdsbWU4TVVKUjdnc0ll?=
 =?utf-8?B?SFB2a1VTTmtDRW0rcmplL3JNYm0xS3hUbU5sQnh6c0kwSHRCa2xObFdVVVM0?=
 =?utf-8?B?NHBSMFJTRzkvU1VwTnNFL2YwWkZQUExzSk9RS3RlcVQvK2t3OURPMmFTbHgx?=
 =?utf-8?B?d3RKL3liVDJDRENRTHU3NkE1d2V6YTExS1hOYXVaZGs2US9wS28veXhhUlJY?=
 =?utf-8?B?VzZzRWVKZUVKcTViUWZ4SFI2QkV4RXltWEhNazZrTytFSmErc2FqZWVTUG5S?=
 =?utf-8?B?OE5URllEY3R3OFZFVDNKZXgzTkhNMGlBRUcxRU4veDdNUjFPS1JKc25XM0RJ?=
 =?utf-8?B?R1ZSQ0VkUGdPemNnaGZsc1AvcUdya1Z2MnVMSnIydEx3b0czM3JsVXRxNFQ4?=
 =?utf-8?B?U2hrbkZXY21ud3MrV0poc3FzdFlsU2Q1NlpYRUdGWHMrTFBiUWZiR0hXczQx?=
 =?utf-8?B?ZmprcmtSRzZMTnJCY1JkTkJzWXdMb0tYbHU5UWluSGwzOVdkeHN1c3pmQmhi?=
 =?utf-8?B?MkZTazhpUXk2Z2ZaTjBTbjNKZUtKcEl0R2lpcFlhS3hFb2lsaDkvRFJ4eUpF?=
 =?utf-8?B?TmRaUk51WHA0WFIzTkJHK1p0bUJ5WkNpUDZPS3pkQ0htQUhOdXZ6Y1BvdEd4?=
 =?utf-8?B?c0M4MnBrcHNTV1piVElxbjdkSXBVU1c1T0p2M2hFdlJoRHBLMUlTY1U4OHpD?=
 =?utf-8?B?Y0dyV29mb3BUUnNhcVBCaitMYnBjRzEyeFBySzZza0ZaVnJBWmtDRU4zNGxl?=
 =?utf-8?B?TlBxTmpGa3JpWEp4a2pYeU10ay9ScGJJYXBMaU1COGIzQ2ZmcVFXSDZNUHBY?=
 =?utf-8?B?aWlKNFB4NkxzMTkraWVTWU8yRFZUcktDdE4vVHRIZXlOS3ZsSkdxV09EamJK?=
 =?utf-8?B?eXh4dXl1dzdoQTMvSVZpQTFtRkFwYzJmZXllUkNtRmRaZkV1SHJPakJZNWo4?=
 =?utf-8?B?REpWVDBjL0ozN0g3OHEzZ2NEbEF4WEhJYUxGOGFjYWxTSkxjZU52bmtZcTZk?=
 =?utf-8?B?VUVJVlEvMTB3RGU4YXVPODNtOEpreHNzbldZOWgzRkorS2QwRFlwY0F1N01Q?=
 =?utf-8?B?ZnpkcEs5KytEdHRZdi9CYkUxSWN3Qm04ejdNaWJ3WnNXMld2dXlibzVSQXJR?=
 =?utf-8?B?dXBDeWJQU0prVTBYTW9WbytKNHJLdXlneTNZVGhTVzJBbXVPZW1sYldNYmY5?=
 =?utf-8?B?YTNzajVtRE5QeFIvS1Q1RXQ2a0tkRVJBSUs2Kyt5dkRlWmtpTlR5OTk5cG1s?=
 =?utf-8?B?c3hZTFR5aXBpOE5jTXd1WGVCVmFkRTZCYUtkNUc0ckJocEdwSFRJRjVhU3Jk?=
 =?utf-8?B?ZVBCaXBvOWNzRFhONUhBb1dGM1pqWDRPenpubWtPRExyemMrR2JSVWxWeExD?=
 =?utf-8?B?bTdxSGhVd0ltbllJeHZmWVVGdUUvUWxCd2kxUnFkUm8zTExPYmk3RzVyQWRN?=
 =?utf-8?B?REExY2M3R0VZS094MFE3eENqYlBkL1dFNFMxTkw3WG1LSW4xUmRBSUgyTjhZ?=
 =?utf-8?B?K2pSb2NLZ0JXZU45dnJoYkV2azhheXZqQ3dQYVRZVFFBbVpqS01yK24xc0Rs?=
 =?utf-8?B?WHFtWmJWbEZIZ0FhazJqa25oODNnSFpDV2w4ckx5czRVaGcvTmxSaXVPQnRp?=
 =?utf-8?B?RE9WSUt5a3o3SzZKa09ISzlHa25wcUdhZWJjQUxscngrNFRvbitIQzF2Z1hX?=
 =?utf-8?B?akFpaGxPcmxlUTd0QUdVYS9EaEVza044S1VDYloyWXhycjhaK1RpTG93d3FR?=
 =?utf-8?B?R1BwWC9sUjAzM0ZNYlRiRnV1TGtOVEFwVEJGWVpBOFArcnBvNWRHT05Yc3FI?=
 =?utf-8?B?dkVqT3MrcGUrV2luRXptOFpRUkhvRkhnc25wTTRyQStyWmdDbmJLTWkwWFNK?=
 =?utf-8?B?T25ReWpOYk95eExRU3hsYWNOQmxSNWRnY0V5YndzL0QyeitaUFRLbWZvUmhY?=
 =?utf-8?B?Vnh2MlVEOUpQYVBHc1hXbXBkSjZLN2UzNUVoeDVjZzN2SGxTM0JTbGdNV2Nh?=
 =?utf-8?Q?xdHveox5yxDrBUjr+WNmvJs/VLfloBPNYwmUtUhhxHJCz?=
X-MS-Exchange-AntiSpam-MessageData-1: qYXqwTTQ6eTWpA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa30d9ab-9812-4c0d-a3b0-08ded8c81244
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:58:14.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDYhVjbThy9MrkG5pvYeBhNjqUA0vK7ZPjuFPmhKaG6qd27/NxvTlf01n7mNxXnTMNo3HOo4RSO2/TnqEHSMag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9515-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,vger.kernel.org:from_smtp,garyguo.net:email,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E05E46FEEFA

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> `Io` trait is now very easy to implement. Thus, implement it on `Bar` and
> `IoMem` directly and remove the `MmioOwned` struct.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

