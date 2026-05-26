Return-Path: <linux-pwm+bounces-9154-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACtCGqrrFGpkRQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9154-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 02:39:06 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EF25CF4DE
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 02:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FC663005313
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 00:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF115274B5F;
	Tue, 26 May 2026 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b1bSCySb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012009.outbound.protection.outlook.com [40.107.200.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96326FA7A;
	Tue, 26 May 2026 00:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779755933; cv=fail; b=QAH72USN1IzjdHndGw2aqCNUpFx/eJhWCkSWXskOzXkBzKbVecu2osndBmbNbEJwq8VFtkyuLtoQdIrvG2Im1ZarUvMu74KmTCRq5M2Iv1HpMjgmeMYsQdqG063v52GNm6EUTA1FlNLhz6/Uoa2L0hc0arRtWswJaxUcxfeulCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779755933; c=relaxed/simple;
	bh=Sp1Y3ixJYRdC0ofn9hvgFgNKqzRgKqElLRVOXnXDClA=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=HN/H1VL+3C5fO6G5Rt4VgdvcU+BvS8Tdj8eWK+Z6jOBX02s+qWtAesNazwtgNLIOEjPYeBY18Fcrvg2MwR1IyBnNsz0Lq9LVcML7jzcn9neJCo+GgaRF/wcUKLOzHbWncqYjSbvNe9a8LTaNqXopkY84XDeCtn1g2UwCgs78Po8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b1bSCySb; arc=fail smtp.client-ip=40.107.200.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cye1WJBeWtEJzNDsl6tE1C7GcssBLOXJjwnYWnHMy/f/6KsCuREwy2lZjV3C0rGW+iuYt1aTUVQ5TY96GdnnGVGc3nIYzDvwJL48xL2ZYamc0uZjKUw/EUMxMWsMi/IfXbDzlniB3NVfkkL9Puvl+8ENica5mwxAG+GVAMusDyg/a1C8MmYv0ddjrhDjxUGRKsgfe0ItvftabuyjlorZYJgiMYCCm8NwR7UhZ4XVDW8C/gN+OYqps8rJhixQiVxMHDJLL8oqmdttAJQ/9rP5XDeslbBjdJqbz0lD/Qdzo2Ivdvtf39rvFYNZ14S+YCJwW/z5+NQvza/B9Z5Z/btGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp1Y3ixJYRdC0ofn9hvgFgNKqzRgKqElLRVOXnXDClA=;
 b=Pusy1t3CuJRB75CHzSu7i1VvgLI91RTDUQp0ZMO9B2jnK3VfHEDI7vZfNglwas03sCGi++E3/c2SZebFw451vPNy9WKfKGpSt41LodwD2irKgiXUJkJ2YSWU5qkFuCZRC+nqhvLsgTs/44huFKvPVDXg9RV1n6CDvhbL2HDCuF5RXl6pZ1n10nPFOKH5TVYgd6Ep87Jxi7rzZrYr0FBvS6LKui8FtOZag3MMCeqihWrsPLLZK+7bRvqx5lJwX0FU08tpVcJ3dg7z3zXtcT3RJlHN2uT32vFuCqRjBHGABwyJs1DSDpSAp8EHqS0VByu/JuRWeVD0FJvr2Kmh6HzxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp1Y3ixJYRdC0ofn9hvgFgNKqzRgKqElLRVOXnXDClA=;
 b=b1bSCySb28ExETYfjj0ROdkUluyfvdHRi390LLY95He4G2eYYjbxfwyEA/JdacgyPAk/4j+rzoe2tW80/biszcSnojfB6qm/sBuBNdw6Sy7oaTpVoHiQK2Q2b3RM9LK8KR2zO7LCpJpM6EpHHkFqz0U7z53lz3WhQgDQTcsLZQdivD7sYrw/jslpWAEiohfSrH68f0TF2zQfk9VgR8FpVjZVC71nIcp+iT26BM9ZmoiWlffSQhzH95bWZpl62iJLyFFfEn4j3Jht2JBTXvoiN29TC/fUGQipWUJjrxFkSLg5R8S/zHpDxCN1RjEIAQNALtRtg90PVMuD0fbyiTimPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 00:38:47 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 00:38:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 09:38:43 +0900
Message-Id: <DIS6TK3P4Z27.1VQD8LWOP6OUW@nvidia.com>
Subject: Re: [PATCH v5 01/24] rust: pci: use 'static lifetime for PCI BAR
 resource names
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
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-2-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-2-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 566654a2-c38b-43b1-73a7-08debabf25ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|7416014|1800799024|22082099003|18002099003|56012099003|11063799006|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	EQkWScPvee7M6p9qHeyDRfYlt9VIZRw2gnaiggJ5vdHsX2uePDtNtSkVf6dh1Y1duwGB8DqRsE5oK4tc2HxwRRpGrBKvBobQFYAkHl3ZMRdLhn7SpYULNHHUcUiROmwgm8kjSxPtXYslVonIluuUSHvi2OJ8LGvZjtOe6XpRznFTxg9zPbbl84il+rmq9pMMT6KXtGLFL7fwV4NAay4D8545Bn2rG4RBZtxRJJ+NTC2YWrAwZDFGCotFHuS9nryLbCc8bVoKBMthXPq2GHzsLHV1sZXFYLnfMn8VW5wPaNI5tRauhHHk9gIMfDaZCilH95OkaHhibnRuKiBQgcUSfbtXuG9bSOkZJUj642BEox1o+/+t6xPIiR6BGFzt/bWXlKl9QFDR1IbFlgxo+xPRr9eif4Y3l4NgpthwxxaNItY9iCOnmG0qJObyTzlopKt+xB9hFxNr/74csxliBBt7K+S+Ql5+FF6FOuy3QWBegJSpWuf2gWrPJ4val/rvuKGugH4Lgv1EqEA3k0HeQ5Z52UAByiQYPT/sR9vAlEoWZSwuRYpuPluqM5hQLHNEtzB19GkToQyQusDlP0uSBU71ZP3gPtK0lfWhZWUJCTFtik7ktQFfBZZJ5yUi0n/2Bw8fjtReEu5cT4WreBJmWxfEUE5aoGUipwMXenv7daM9zFnScm2sPJylZr2ziSm4TY+SGhQD7s7JsgJ75oDMrRP1UdBxbh75MkTrdN4cPlm6DLBbljAtH7hloY0fo9AGBRXe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(7416014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3BvK2s5RGxnaHdKUTJEK21mb2JPVkJ3emxOa2o0UTY1ZW1keFpCdWlpdGc5?=
 =?utf-8?B?Z3gvcXl5WlFmVnBCN0VKeGM1YXluN0ZXV2svOFlldFJMOElqcjRJaFl3RUZs?=
 =?utf-8?B?L0NNbUJLYkdJMjRqd3NwVTlnanRpOGkvZEcySXJPQnA4WGhLSEdaQXBsbmMw?=
 =?utf-8?B?T1ZIM1JCd0Q2YW5JSEh3U3hGZVkxTDhBWTArc0RLRG1NenJRNVNGbTVXT2h4?=
 =?utf-8?B?Z0Q2WmNzUVRjK0xOeDl1d1E5UHhHbzlYMzJMNWd2V0ZiRWNybXF4T0g5Nmdr?=
 =?utf-8?B?Y09qZU1WWnFIMFY1QTB6YmhlcVZkZWUxUWVlVGFxa0FPazdMQUJtazl5TUQ2?=
 =?utf-8?B?d0JMUTN0eUtqd1FjNEFDZnlldk02K2tUZ0RydXRwNnZ4M0dmQWdTMjI5dUUx?=
 =?utf-8?B?bk8rdlhJV1lTUndFQmYxNm16V2RnTjlPcGZOVEtXbWh4QWZ3dUFwNm9qSHUx?=
 =?utf-8?B?WGZiWW1lSUx4dDBLbzE1dGhHYktISk9jdjN0Sy9YZmJtVDhnWDIzM2ZKSkRa?=
 =?utf-8?B?c3djU1d2cks5akk1WUFyM2RmQXlhWlJWb1huUVVLaGxodHpCODhCeU16R00w?=
 =?utf-8?B?Y0VCbGZvZ3JVYmdOK0dxd3Z6OFcxR1RnbkRid0JVL2tBeSsrVVU4OGNjYzdT?=
 =?utf-8?B?ci82aGhrN1d6azhQdHZxbm1jWXpCV3lyemx0WFdKTFhWNDZWOE0rZWZXM0xG?=
 =?utf-8?B?SWxPMEVhdWs1eGEyWUpJSlZ4Q0JGTEF3c2RHcGNKL1FCc1dmaFpnQ1ltUzRI?=
 =?utf-8?B?cU1SSG1LdTByVWZrVE1xRUdyVXRKRzRGTi9kU2pzckdYWGd1a01XdVdBaGRK?=
 =?utf-8?B?dTdWdnN5Tm0wQnF5dVluNmNkWjhhM2VpMVdnNnd2b3RVYTFYVHRQVTZPOHdn?=
 =?utf-8?B?cHVCNXR1aXVTMmdJWndRalgwMXpDV1U3S0ZzTlFqU3ZqQ2RENG01d3VIMWFx?=
 =?utf-8?B?eS9Gc3EzU3lPZjI2Z0pLNUNRS0RUNTZpSXl4SXZ0emZFR0dsVGVPMDlXQW11?=
 =?utf-8?B?ckdzYXIySlpTRXJBc1ljWktlS1pnWmt5L2JJWW1DWmlsalRNYmhaWkJ2Yklt?=
 =?utf-8?B?WnU2KzVYTmhBRFJLSkFDaTFuWnNLSjIrZXVKUWo3bk81dW1tWEhNNDZ2T2F5?=
 =?utf-8?B?dGR6akkzTjQ3UGNNNDBIY09RMXVkMGo5Vm03dHh6bUV5dWllTUdOS0x4SGRI?=
 =?utf-8?B?UEJxQ0tNTWhVT0t5UnpOMHR5a0NDOGVteStJalBncEZTZW5tVDAwaXNiQ3Nu?=
 =?utf-8?B?SDl6VThpU3d3L0VMM3B2a3dEc3BnMnBJdVZVUThGRDZkTWxnK1RNaXExSkNP?=
 =?utf-8?B?Qlk3NXZSNDQ1UUpQSUNYM3ZrdVhVdmNRcGRZYW5MWUhCVVFLRnBvYlkyYU1P?=
 =?utf-8?B?cC9ocmREQ1V4YzVuMGJRMkFvb3dLUU1td3dpV2x5N25VTFk5Y21qNVlMdGNl?=
 =?utf-8?B?T29pK3N0YzdSazlGTGd1ODlFRHJ4bmszSnpKbzhKazZ2TEZKSzdoVmZqaVRR?=
 =?utf-8?B?bHRMQkZiN3dGZzFXcTB6YmJaZ2VzSDFDcVQ0QlNYWWNZdHNwQjFKUk1BMHBw?=
 =?utf-8?B?dkgxVTNHUlBSb0tnRFJuajZIbHp5M2wvTzFGMjJDNTlWRUYrZTBhZ1JhdEds?=
 =?utf-8?B?T0hmTGN0dU9tcmtTcTVYbklkZkUyeVhGbUx4WFg4b2FTL1M2ZkRLbGpvWE8w?=
 =?utf-8?B?bjhFeGMvcXliMVZvMTdoeGwxTk1VYVR5VkZqVWtPNklGck9FQmk5Um8wOWZV?=
 =?utf-8?B?QzBCNU9WeWxuQi9DSEE5VXZQU0RlL3psZnFmbFE5ZC9NczdPR1FwaktUUGVZ?=
 =?utf-8?B?SU53emtjYmxMdnRtd0lGRklabXNXZU1UeUxRYVBLU1c2Y0hNN0NZYUhqaTds?=
 =?utf-8?B?UC9qaVhFTCtFdW1VVG1GVXRRWHpET1d0V1QyekdremY5T250OXl2KzkyVTZa?=
 =?utf-8?B?SjgvRHFpSnFhTTFvaUNCU0ZaV3hqczN4dE1QYWw4dFhMTUVqRGZNZkltcGVT?=
 =?utf-8?B?R09IWTRrMzF3eFdUVlNrM3F0UURrcEZlVHVqOFdrWFR0QWNyUGViUnRLbm85?=
 =?utf-8?B?ZzR1SldBU0lqN2c2OG52M3NZMVNMbHlYU2dNRkRhTUluUXhBM0lMVmVFZUVG?=
 =?utf-8?B?YW9TWXc3TTQ0S3l1NjVrc0psUVRBZDNzOVlHeDBKbVhLM2xJQk0vQUNrc2RL?=
 =?utf-8?B?bTRoRWFybkltSUNubDh5dmFzWTNoZDVtK1FhekJxK0sxb2pEeGtkV1dzSkRn?=
 =?utf-8?B?bHdiSVo2RlA0cXhlK0hsd0xhd2JQdWJlSFZTL1dhYm5OTGZUM1FaYTVTVU9H?=
 =?utf-8?B?ZllwM3BvYW05bCtGUXZGRjNVMmJ0cnlOMUQ2a3J5bmRLc3hpd1FXdzY0dTNV?=
 =?utf-8?Q?7HIXWNfsu46XhlmnDYAq7UJAPDAZ9hxqyAD2TK3kY5f2T?=
X-MS-Exchange-AntiSpam-MessageData-1: fhG8AebEfDaKYQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566654a2-c38b-43b1-73a7-08debabf25ef
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 00:38:47.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oovi5UAfzdDmlPkyJmshpVrrOWsl02JtLdpsxO1PKAa/qn05pzJI6BxaDFhBXS+JH3XfKo5EMHGJmoccfmWKiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9154-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecourtney@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 74EF25CF4DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 26, 2026 at 5:20 AM JST, Danilo Krummrich wrote:
> pci_request_region() stores the name pointer directly in struct
> resource; use &'static CStr to ensure the pointer remains valid even if
> the Bar is leaked.
>
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260522004943.CDA7C1F000E9@smtp.kern=
el.org/
> Fixes: 3c2e31d717ac ("rust: pci: move I/O infrastructure to separate file=
")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>


