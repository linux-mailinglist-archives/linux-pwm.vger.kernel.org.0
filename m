Return-Path: <linux-pwm+bounces-9026-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IlEHX2WDGp1jAUAu9opvQ
	(envelope-from <linux-pwm+bounces-9026-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 18:57:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED792582B86
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A43EB3024A24
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 16:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2B2409111;
	Tue, 19 May 2026 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="v/PAQziT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022113.outbound.protection.outlook.com [52.101.96.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4B0409103;
	Tue, 19 May 2026 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209799; cv=fail; b=dks5782sLQkUo87F9fU/az7dOuUdrgFAVBJEbDs7twIvkmj6Dh57aVx5sggGqtR5kT/R6NDkAZJGUwk1Oxbb+Dq2Lnt4gr+DaykXJvT32Fr2yAC0Sfg6dHaBjZ3epApaAyy7zzhKLvBIZTp74V4MBy/uo66OLm4NvgFiccsHje4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209799; c=relaxed/simple;
	bh=EiJmuRb6PPbS5sbUlcYvcRTa8ACpXoMvdzV6hPawfPc=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=AUL5Ld8OOZD/ma0TEu1PIWz1hvoVHaBZqvCLNiJdbMLIkDgFidmqZRDJBOn+Y/LA7nmKA2ofBR/yxtpEON4Jr4svqIrYU8vXSWdyR+4Cq6UQC1jpb+AxvZRG6OUHRpgjOpyOeQS892oPQjusLCInJxRmwNOr49A69oc4GFGXEhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=v/PAQziT; arc=fail smtp.client-ip=52.101.96.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gof0SkuWkiB7+o9nulDAzAvxpkfYcvgZ0LftobUyYAQ5cXCNNDuMGx7aXUPLwBt/FsEShmcrE4jfx9T8QgmWp0HAlivQgm3vmrOUK7memrLjXEGIpI/c1quEePs2EBrZ5gM14WKypIJyA1p7jj7OWgFTl5E/wtz/MKZY/lQ+QAiI24mc72iVH6gv0vlEx4WvjnpaBEg+BhvicOCLvUEZcLB1MhKj/6fNgS9zRm+INZ8X3/hy2U2VP3KvXikGt7viqlBVD9Z9v3Wgljfc60FbdG+J/KAVSrADic6Pj0786cAWKs22rKqFeSQi5wI679/mevnpVpfoi4vTKLe0e7f8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3GIBYZraT1A3I0D6BJIFhY76lFsLNAOGOwnEsnkNQ8=;
 b=bvvjUA8vsky9w7dfs+MacqM/9gRm5UhI51AaadZN88zLgwWx+oOJL9uobS0uC9zYXZgivBXMZemLvKdjStzH/HHbxKN0TniUmeg6oS96yCwdJRIRZ6DHQV2grMmuAywrPE26vfhcp3zUmtQKCytK8mG+zGb+IqYfQ3sLgPyFKXb+QlZc72t2x1JaBO5OHimJSiyjNzRDRPOCW1EimBixw72h6v6VGJum0RbO6Q4Hbu2Gvp4kuHyhr6c1lIJPXQ2bkMKZZYEARzeZ9rUAfJFxAfhtoE/1qqV6umNsc/kSIoBU5vP+GLaGiIzU3aU85amfUGjvaegWQrkrzcbZRTKqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3GIBYZraT1A3I0D6BJIFhY76lFsLNAOGOwnEsnkNQ8=;
 b=v/PAQziTuqqEmasbB+wmrS2/lRo7XCUIYifez2SbaC2H2QNhKVhb9FxfIuC8hPnGIlhgq4JCipefsJKYMhl+grZ90gnV+bO1Jsw9wMad2ATgvxPpJyvmIfVGikiBzGqt+FP0iWDt3v5+M2o82k9IsdQAmcUrSdz/DiLeUx1ublk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2055.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 16:56:34 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 16:56:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 17:56:33 +0100
Message-Id: <DIMT8FK3A307.11FI5MGH9K1OX@garyguo.net>
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
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 22/27] rust: driver-core: rename 'a lifetime to
 'bound
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-23-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-23-dakr@kernel.org>
X-ClientProxiedBy: LO6P123CA0046.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2055:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2f3608-8929-4766-96ab-08deb5c79578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|56012099003|22082099003|18002099003|921020|3023799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	/4fiYBBWJeR/CpNGo98jvcOB5v0Xk1V9YeGFZvUBhGjhH3gKFHbMw1BEZK8O1qhhK+BY901lmpnA0KXZg3ecHJatROgANlAAXXb89a53ZofPA25fkI+XHXc/C9ru27+oc5OymxR4IVTUNJqlTIVmbHTNEwwA2TkuiTfXfIgBvGAH3M0fTH5gxiKLaHaO5rYC75vFPB+6w0paXMfVhtt+LfKPIie9UOx9gS6MeEGFrWzZm+3IPZENW5Tp/nY2Dv64H22T09lF6G+bZ0+rNJWJSy/R4evjgRnhnNmyIL4kyDIbgaiXa5e0JR9horPyqtfadWtg7EET8Eui5in/2hmzEf0tES8B/fFpdZ96/TvWk63oyic76Tu77ja1/4cgdPCqtFnC0vdD74MBkzHtEeB+TLHJnM7qG4ReLku562KVCEQJcElUgLay9GxzRQeJbsNyY15erLgyD4zK4xhvtYDGyqYWlXBx1/r9W+m2436YzLdKS9NicI3JViuxJ+ySeesPzkPPLXib+UZGusRKkiZuk4cfdKjfkMOAoNHrrJtoG9Cxwi5NFWBStJ1u91lOfYLkaao34TpKbt9OM8u80dBb2jFemigQtyjN55sGWeMp+7bplsfsI03od7TnGF2x/VUETdIvJNjS4SplLxj2hDPRKWL/g3hqAgCbpBSHCe9rrGunHI/B+lt2VYucTBKMOZMbytJrJsK4H1X085BiPv9IyvU43ZRi14dUuy5Va53fiok=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003)(921020)(3023799003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzUyS2x5aXBhUGZocnJJS1ZMODZxcXBDVmdzSFFrVUFoK1Z2c0ZPeE1ONGw5?=
 =?utf-8?B?bVhSZ3JIdVI0ZlU3KzYrV3cvdzVRK2M2SmdFOVdNRVZPUitqT0tGbDNmaW10?=
 =?utf-8?B?WktlTGhNc3dINE5ob2lrak85a2tnVS9HYjd4SHFQSmhGYy93Y0RJV3lXTXEr?=
 =?utf-8?B?eTYzK0RzdTArOEV0aHRhNEFqZWFnVFpCRHVHd2tBd1BwM0lmLzBxeUVxalov?=
 =?utf-8?B?UkFFanhnVGl2UzQ0QThMV1lrcDh0YmlqR3JpVjhZUTBYcmtMelppd1QrMUpt?=
 =?utf-8?B?eDhxaDlHQS9vV05aZ0gvd3Z2WGxZdUhLRHY2dC9OUDlGNVcrVkVvaDhtSExy?=
 =?utf-8?B?TnNyZ0J2V0loK3BNMVZqdllWNjcvcW14RHdvcFppMEs2cFlJQzNDa0xwSGdz?=
 =?utf-8?B?c1JVR09teHV0b0lvWUozUlZzM1FFQ1pzUTVsMVVYandPNm5VZHVvYk9BOTdJ?=
 =?utf-8?B?eUpRUXV5OWtabDNqM0kyM2RFY0VHU2FKaittTitoLyttcDJDeHNsa2d2ZXRF?=
 =?utf-8?B?RjZSQllwd0M4VHJ2amlSK1JNYStxdGVBNFkxa09taktpQ0lFc3RURktrWjFF?=
 =?utf-8?B?OFBaOGgzL3FXSkN3RjdVcDFneEgyWkpVQkhhTEJNY1N6RDFiR2tTZmYvbC8z?=
 =?utf-8?B?bzluN1p4dDNXcVRFSW5zeEtwK3p5Sjl0S0o3ZnhwQ0t5eW14V0o5cXBRVVM3?=
 =?utf-8?B?Ky8zWjV4NjI4QXoyeFJ0czZXYWRLSUNRa2loTUNDSlQxZ0lPV1lVQUtGRkJN?=
 =?utf-8?B?RExOc1F5a1dsaStkbVdFMi9RT3dlQzc0RWxkc3FhRXM4RzdhTGNpSFlCTkxI?=
 =?utf-8?B?SXQ2Vkx5bTF3YXY1ejZkTjM4SDc3YTRPTks5VVJ3RTNHeU9jUmNRUS9wc2xZ?=
 =?utf-8?B?aXM2TW5BVks0VEVCU0JOQmV6eXREbnFRdFlWMmU3bmJRbkZ2SUp6R0NOSldx?=
 =?utf-8?B?NmZ4N1lPRUNMc1hSa2s1NHQxVHZwc2llQktuWU9TT2U1R0ltZHlLOFhBWW94?=
 =?utf-8?B?bEdBKzIzYk9VUURJZkdJMlBrWlpXZmg0U2hwOXRzbHdFTkdZOVBZQXZBT3ow?=
 =?utf-8?B?Zk9taXoxUTNOYlhLN1duYXhCbmRQcDhZU0JhTVRudmhETkphaHVqNm80WWxG?=
 =?utf-8?B?SlhLQ1hnWFdoSFdTdGlhVUNzbWhJcWFZTzFLVGtRZFQrNTNwRXNVOW1vK1Nj?=
 =?utf-8?B?VnZ4VXFobCtTbnF6MHFmNHBUcFR3ai9wd0VGUFhwejZVNk1ROXdxL3d3STVw?=
 =?utf-8?B?Skk3bUpNRWxNU2gybkhVb21QM0pURElYYzNmZGNXRlB5dDJ5RjNtZU5qdm94?=
 =?utf-8?B?VVdXYVVHT2pQWHAxQ0owVnB6YytsTnlpL1hsem1FaFNMK2ZWME45WWVYTWdF?=
 =?utf-8?B?VEY3WngzcTBSMVhPTUxKSTZFY0wvU010SE0yajY2cjFpTnBnM0xTYmpWdExy?=
 =?utf-8?B?YkZwUkNZVjdhVkI3dUR2dlZCVkNrZXVTU00wUDZDZnN0VC94MExDcTJ5dVZa?=
 =?utf-8?B?NlB5YW85a1B1UzdhTWFhMzBKd3ZXUVZWRjlJMjl2Z29jMDE1TE1vM3gzN3lm?=
 =?utf-8?B?R0ZnL2pkQjNQbjY2eTdBbmNLRjMrci9oaHRkb01hRGU2MzI5SkFEMk5hdjV1?=
 =?utf-8?B?dXk3U0VsakMvOXdmVUMyOHRmY1h0NjZiSk5Eb1crWFE4UUg1QzhHcW93enVJ?=
 =?utf-8?B?d2xjaDlQNWhjVk9pYmFuRGNlQUFjaSs1bkJEdVRibzNGcEdMTFZnSHJsZ2NN?=
 =?utf-8?B?MS9LdGtETmdFRUYwdDlCR2V4WEZad3VES3QxVkdRc3BBNUV4SEJGM2RCUGRr?=
 =?utf-8?B?c1J1UVZ4bkYwNVUrQ3dHWHZaTTlnQUFXMTFlMHFoNXFNQVVMdzVVOHBJeU1D?=
 =?utf-8?B?eXFCUS9VR1NJM1dzM0FyMUxlcDlKUk9DS1ZtSTJtL1o2TmJIMGhvMXFHOWF2?=
 =?utf-8?B?aUpPT2xWc0ZMN3BxZ0Q5NDcrWkNKTk1JdWM3cGh4V05Pc1pFemR1RGJSOWZP?=
 =?utf-8?B?bFBuRTFKa2ROQVZzODA1WGl3RE1lanZyS2c1c2NpVXRPT1YvK1dTVFc3RGoz?=
 =?utf-8?B?MkFmK2pidTZPR1pxNlQxd0Flemt4Z3ZJUkZGdjBCU2g2RUZIaUs3QUM5L2Zz?=
 =?utf-8?B?aXZMV1JHcFk3K1k2MXdRZ2ZmekJhVEpMY1dZUHYwdEt1cVZnaGdtR1o2VGh6?=
 =?utf-8?B?dG5MS2JleVA3a1BUaGZxZS9EOHVIS09zN3p5dW1Wa0pDU1QwUy96akRsYURR?=
 =?utf-8?B?UlJTU0czWlZNQjFOWlhRUWZtRDh4dmxtNlRVcmI3bGZ1b3BTeUszcHhLcmtn?=
 =?utf-8?B?bHVjZWhUMG1CRVJBUnhIMmtZb3RQY0hLNi9RY1hxOGZJVUR5SE9vQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2f3608-8929-4766-96ab-08deb5c79578
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:56:34.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2lEcocG5Wrz9cB6WYyARVLxL74oKdf5s78c7Z+dQHWjyO93b87AgJ7ZfoGBFp5cPyUXH+Fic1n05+gIkTJaUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2055
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9026-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: ED792582B86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 1:01 AM BST, Danilo Krummrich wrote:
> Rename the generic lifetime parameter from 'a to 'bound in pci,
> platform, i2c and devres. This makes it explicit that the lifetime
> represents the device binding scope, consistent with the convention
> established by the HRT series.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/devres.rs   | 14 +++++++++-----
>  rust/kernel/i2c.rs      |  6 +++---
>  rust/kernel/pci/irq.rs  | 38 +++++++++++++++++++-------------------
>  rust/kernel/platform.rs | 18 +++++++++---------
>  4 files changed, 40 insertions(+), 36 deletions(-)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index ec63317665f4..58efe80474bd 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -280,10 +280,11 @@ pub fn device(&self) -> &Device {
>          &self.dev
>      }
> =20
> -    /// Obtain `&'a T`, bypassing the [`Revocable`].
> +    /// Obtain `&'bound T`, bypassing the [`Revocable`].
>      ///
> -    /// This method allows to directly obtain a `&'a T`, bypassing the [=
`Revocable`], by presenting
> -    /// a `&'a Device<Bound>` of the same [`Device`] this [`Devres`] ins=
tance has been created with.
> +    /// This method allows to directly obtain a `&'bound T`, bypassing t=
he
> +    /// [`Revocable`], by presenting a `&'bound Device<Bound>` of the sa=
me
> +    /// [`Device`] this [`Devres`] instance has been created with.
>      ///
>      /// # Errors
>      ///
> @@ -316,7 +317,7 @@ pub fn device(&self) -> &Device {
>      ///     Ok(())
>      /// }
>      /// ```
> -    pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T>=
 {
> +    pub fn access<'bound>(&'bound self, dev: &'bound Device<Bound>) -> R=
esult<&'bound T> {
>          if self.dev.as_raw() !=3D dev.as_raw() {
>              return Err(EINVAL);
>          }

For the same reason that I outlined in the other email, I think this should=
 keep
the generic `'a` name as this is not the actual lifetime of `'bound`, just =
a
shortened one.

> @@ -338,7 +339,10 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self,=
 f: F) -> Option<R> {
>      }
> =20
>      /// [`Devres`] accessor for [`Revocable::try_access_with_guard`].
> -    pub fn try_access_with_guard<'a>(&'a self, guard: &'a rcu::Guard) ->=
 Option<&'a T> {
> +    pub fn try_access_with_guard<'bound>(
> +        &'bound self,
> +        guard: &'bound rcu::Guard,
> +    ) -> Option<&'bound T> {
>          self.data().try_access_with_guard(guard)
>      }
>  }
> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 7b92d42a2b98..2bb7e54922e5 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
> @@ -566,11 +566,11 @@ unsafe impl Sync for I2cClient {}
> =20
>  impl Registration {
>      /// The C `i2c_new_client_device` function wrapper for manual I2C cl=
ient creation.
> -    pub fn new<'a>(
> +    pub fn new<'bound>(
>          i2c_adapter: &I2cAdapter,
>          i2c_board_info: &I2cBoardInfo,
> -        parent_dev: &'a device::Device<device::Bound>,
> -    ) -> impl PinInit<Devres<Self>, Error> + 'a {
> +        parent_dev: &'bound device::Device<device::Bound>,
> +    ) -> impl PinInit<Devres<Self>, Error> + 'bound {

This really shouldn't be `'bound`. The lifetime here is just a technical on=
e,
due to the reason `impl Trait` is used.

This whole function is conceptually

    pub init fn new(i2c_adapter: &I2cAdapter, i2c_board: &I2cboardInfo, par=
ent_dev: &Device<Bound>) -> Result<DevRes<Self>, Error>;

and note that the lifetime does not appear anywhere.

If we follow the desugaring used by async, the desugared version is

    pub fn new<'init>(
        i2c_adapter: &'init I2cAdapter,
        i2c_board_info: &'init I2cBoardInfo,
        parent_dev: &'init device::Device<device::Bound>,
    ) -> impl PinInit<Devres<Self>, Error> + 'init {

Notably, the returned `PinInit` can (and should) capture all lifetime param=
eters
to the function so they can be used in the init process.

BTW, if you do need explicit bound lifetime, then it looks like

    pub fn new<'init, 'bound>(
        i2c_adapter: &'init I2cAdapter,
        i2c_board_info: &'init I2cBoardInfo,
        parent_dev: &'bound device::Device<device::Bound>,
    ) -> impl PinInit<Devres<Self>, Error> + 'init
    where
        'bound: 'init

Best,
Gary

