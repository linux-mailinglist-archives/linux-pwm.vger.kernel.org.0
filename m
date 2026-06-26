Return-Path: <linux-pwm+bounces-9415-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yeSyKxKRPmqYIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9415-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:47:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 881A76CE1C9
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:47:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=ozlfuxyy;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9415-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9415-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F1ED304EBB8
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7473FD96F;
	Fri, 26 Jun 2026 14:45:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022142.outbound.protection.outlook.com [52.101.101.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5C30C166;
	Fri, 26 Jun 2026 14:45:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485147; cv=fail; b=N599O0IND20tIPiwzV2Hy42MOOmpailO88soVz+Ag+YvqTqt98WwkrnkOcobDwQTKhyiKNkIZUAeYo/2bvc8ovMAon0zy9rIOFjmUA/+BX6D1r2TkaB0PiE2xUckmLtlCdbm0sR4cMl3AezPympZ5W3m0wyaOBRzpbbKTaGBQz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485147; c=relaxed/simple;
	bh=R8JQsXYTTZDp4Mx5JAz0NqTnXuBa/FxXyEVH3sOVv/Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Yq9uO3MxdkuDr2Zhte6KvnmwDcEi6v+9+/S+498LsJt1+tsrtiuuLWBcRGqRAT4uHp0VkTaUArTwhzIOgXlGEHsZLvIRGMEKcPGiBDtl5S2H2FUlyIO77KLdaTUnZoiOKyDGgeMcFTbB6ZjaPrj7dkVwEB7Zc400Bw07Z/fogM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ozlfuxyy; arc=fail smtp.client-ip=52.101.101.142
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q42QXxAwf97kiKI1Sxb3IRpybfE0veX8Kcp5N72xMmJIsuKg6WbYuMnZTFlph19FQl2WLJNBAUu2tR+JWGz6zXOOBQVcBdyvfAArb/lUEcQgE2LXJL6DwU/65P6pBNqzDXjMm/du2GudvcjREvrk6gpZ0cf8pDpFlxFSOml96l9pZDWdT/QW2mAQE+AvWeCtu6SJmf3caxFwEjrFwbdw+itJYfQTnCKxXKVt7i2I2/V6c7gB8o7dawgfX/bLDgr18Vq0P4bHsroGrA3ZGDtRdsAvKn+0KCFZYL/GI8Wu9G4Ha3tZEfFciw40utD0mvCdXa9Y72J016ryoazjbWyIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzsv31zzczh5H0gylwNfSKmbWEAhEZ2/B2D8cNdDp9E=;
 b=dljMr4G6lSluHAAVF+AfedExccr5ilqBhSoG6YOU+MUCXTpJTxZvikl0Yfyw3wWA5RqDjjum9IkCHhNSdxGEvIOtwvwGX6I4b4PIiGsGGyv3lszS/c+51EiOcPayL4doSYWJB/gp9rVMYAKs8Npvifo/MmAv38+irjHON9lPWYD3LKvx0RShnvOtbusaEhTUbUCp375TK6ehNciKm/AevNROuXruRzWpVE2J3RgGmA74tv7+/mf3rIk7tRr9ry693URRdngMLWFg2GtmfOmzUWjRC9y+xYD/ldr4RLeiGRWwXozkBbRE+MndsIdXuon6iz7a6n8HVcaewUFWxRut0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzsv31zzczh5H0gylwNfSKmbWEAhEZ2/B2D8cNdDp9E=;
 b=ozlfuxyytiZ2lckvJNE4H75gWGkC1fZr6f+YhUXlhh3RlF69PxSAJzvHAQTmyZYcOuO0brpaSSv1oTXYk/zX0P/tYBDHE6h1tZm2w4TcNHbmKbcNFfGnRAs5RBtdTEKeSilQz0bc+1nuCIAAKlJVUuU5ePX6D3dfLerGEjZE4tU=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:23 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:23 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:17 +0100
Subject: [PATCH v5 13/20] rust: io: add projection macro and methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-13-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=5593;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=R8JQsXYTTZDp4Mx5JAz0NqTnXuBa/FxXyEVH3sOVv/Q=;
 b=VBHbkrII64/+bYjzcpuec3YDuCq7NmAOn6RusoCtSaJtdmKI8JtUiWVT1d0MCwHBfgRZWU90d
 oBgK5fSWDl9B1eHD9n/lhy0xUPQ2XyvuDo8l/OdRdBmbDNLAMB+HHB4
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
X-MS-Office365-Filtering-Correlation-Id: 088544b6-9c08-4c6f-79b4-08ded3918dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|18002099003|5023799004|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	UIzR8sUdA3BKx3Bt09mKQSyL5UeeS6oUmEmn0BTQvTJWRDNr0X72P744C3nL0TPP/roa1cxeUnpwabKdFueHu+v7kCMsaEqwZLLXR7lk6UlX7LoGBIA8YGa5K89PjfVvxHCGxt1tJrM1ypDp25uj51MW3Ssy2BL3tRZbKYnvK6cHoJp+NrmRr3mgbXcde301Vq4AgemBGuoe1fL0gn37I1aT25eL8xpyXr2Ca7Jh7CJ0vjzWsmwjWJ84bp3l+ZpwY/pmckjGh06p2hNmctWDloJSFO4SdmO7U5sZ/JqnqdAlMgApl7LnfQNVduWiKCzkl5CfKIDzHi36tBisBZmksTR3Vb1ZDw22edTPsEdehsnUeAmwdyRbeAc9jLZXpEVwKikM6j2cg1stx5iP1CQz9EtrXX6Se/HOIw8Q4vQ8+Z9J2RZWubbOzJ//W6dkY4uPoeSnHWsTyaxSHXEFJQShBPhgrBhGGDyrzv9/K1OhygMz99BiKrnzjsrQGTLymrr8cYoRS8X0vHjTMS7cUXkE1OSWnpRKu5gYdR3OoFH2I35J5eP4t2guUlM6XQ21kfKIIJDGRnKeckes/ZtRpemHH5ImRxMNZcocSVa43nkAbZS8otQQuNuoxNzd3prWmqVE4znezVBFNEeV7Pc01Gz379RJ8veqGsI3jMY0dcqoHRqGpDr9Lu0q+mkbrbeqoclgZat2UUgCiSoDSSl+gi5cTQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(18002099003)(5023799004)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1BoWGhNa1Z0VlZocWl6RWdvK0VEK2pEamZULzZjMTJxa1drMVZ3a2lYTE5j?=
 =?utf-8?B?SS9ja3ZLVkk2Z05RVzdTc3Vwa2t1K3dZeEZNMDEyVnRsSTh2U1oyNlg4ZEZQ?=
 =?utf-8?B?MlNhOGVwaG1TVUNXVFdCa2EyMUxvRmh5QmFhS2hZaXpyaVlHNER2QWxJdHc0?=
 =?utf-8?B?ek1QS2xDcnVvMVNFRFZNdmdlcm5HWDFBa0p6R2hxTW1QUzFZOG1samhuMG5q?=
 =?utf-8?B?RmlOZVM5UWs2MHF2Nysra3JIY2dzZGh2RW5UNlpXODNwMm1tbXNNNXFPYUQw?=
 =?utf-8?B?a1FjTEdjTTBDa3pQNnRYQjV6MTRIQWxxVFgveCtmYXA3Q3NnUE44WnV0T3Nv?=
 =?utf-8?B?dXNqM3J5c2dGM09aUitCMllOQS9HVWJGMnpRNE1HVnN5bzR5bzMvZmdqRkVW?=
 =?utf-8?B?WFlvRVYzUGlCVFZiQUdrR0hsdHRvblNERmVnZjZtYTJ2NlRzT1RteXpTT3Va?=
 =?utf-8?B?WENYMzFVV2V5K3JlbEhoaUd3bUcrL0NQZnhCZGI4eDU2TUxlaGdKaU51Z1Uy?=
 =?utf-8?B?SGlTVkk5TjB2SCtGN0E4L0czM1YrUkV6SFhRM1NSeDN1TEt4QkNUNWpyUm16?=
 =?utf-8?B?TU50dnNKT2NOZm9KT2RSRis3L29NUUFSWW8xREJBR2FWY25za2JTa05heGxE?=
 =?utf-8?B?dXBqV0ZoUW90cnk2ck5kTFJUSGJhdkhJcm5KNXZkckVQK2d4ZGp6TUpXS09O?=
 =?utf-8?B?ekVOcXdmNDdUV1BQTXZFQWFKbXN4VytOSWJaWThFQUtEcjVDZVpuMElLQ09l?=
 =?utf-8?B?OHlweUVYcGpiZStqRW5McGo3ZFMyQkl0aVdnMzd3OUsxc0lkc29LdFdOa1Bt?=
 =?utf-8?B?blBMTlVGWFcwUlE2TVFYSlYrMVBmamFhQXNjbXJyNDRvTTk2QnpRTnBmNkpk?=
 =?utf-8?B?MktSdHE2ZmFUOEN1eEdQWUxxNnl0WU9wSi9udVdhWlpGMXZtaCt6SUhlZjA1?=
 =?utf-8?B?bTl5bjc0OU5yNXA0NisyR3BFYzl6dSsycjBSNTF2RGpIdnZzTFN2TmZLMEda?=
 =?utf-8?B?TUs4dHIxa3pkUWVjKzdYaVdHZkhHTVFBenJ5UllXdHNEdm9KMXdIbkRIT2F3?=
 =?utf-8?B?SHl6Z3RBWHR5Smg4RzRVRHZXUW5oWkNwd1ZNNDFDWTZacUxhMWhkUWdSczlK?=
 =?utf-8?B?Y0FIQzd3SzlnME1uQytFczl1T0Z0TEIwTnRxWUd5MGpYaEdxeGtjbE1VSWZI?=
 =?utf-8?B?QnIvTGNIcVZpZUYwUGx3OXNtZzJxNVM2blp2V0hZSFhBVDllNEdRVFlBMXJ3?=
 =?utf-8?B?Uno2MWN0WmRIVy90WVFtMWo0Z21DSFR0bERFWXhnSkNnNVoya3VaZTZrRjhL?=
 =?utf-8?B?SXV1VTZzNXFoMkNwMU9YWTFydkFOdXg1ZFlTRmxPeG8wSURydDR6YWlPR1Bu?=
 =?utf-8?B?VHU4YUF1NDVUd0YxYW5CWXdMWkJkS2ROOENaQUlHTWpSRWdNbmM4UjRTMTlU?=
 =?utf-8?B?TytDZ2NsODJXZmVCNk10VTBPYnJmNXdydGFwaEpHcGQvdjNLbFFCYkJ3bEU3?=
 =?utf-8?B?NS8yVjJOaDZnT29jOU5sQ2UzQ3NEcHBOUGpPRisvWHRDQ0laQ0Z5N1BRbkIr?=
 =?utf-8?B?N041NFB6enJlaXNiemMzWEZXaldTZlV1cWxnb0puSjhTK0JHM053a1QxdDNG?=
 =?utf-8?B?U01XYnpxTmlRSTNjdld6VVRVdEVvUTJTNDVDZCs0c1pMYlBqZnlNMDQxNG82?=
 =?utf-8?B?a3psYW5hTHFUWlE2WDlqSVpTMzlhRndKTTczWTlHM2wzVmVHNlhkMVNQY0w3?=
 =?utf-8?B?SVNBdnlCWVNYbkIydGRldFA1Z0M1NHNObTI2T2hieDRqQXRIL29BVXBQUTNR?=
 =?utf-8?B?YXJFbjkra1VZYTc1ZUU4VmFGUHZnOSsyUWNGS29tbFJFTHJpM3JiN0NEc3pI?=
 =?utf-8?B?SnhuRlhvN3l0S2h0N3pxL1orVlBmN0k2QTZpN1NYQlZmV2krNkEwYXp2d0hv?=
 =?utf-8?B?TDQzaXkxN1BiRTB4WnEzeDhLQ1EwQ1F3ajVqaHNvWmFXcnkvNzljMFQyb29a?=
 =?utf-8?B?cWtzdEN5aHMzY3R6MHV3eVREYmFoSE16S2xlVHY1Y0tCWmtGdXplVXVyeDFm?=
 =?utf-8?B?MldDZU43TXZBeW12UGh6M204TThNWDRETnpXWTdhUnBJd3dmN1VvdXBNY2tG?=
 =?utf-8?B?SGd4RWE2VmdtNEZraHlxSW1BeXdZMi9qU3FTUmFYYjZuYnVCWEtmMy9aclRS?=
 =?utf-8?B?TGQzaVRNYVI4dCs2Znp3RFVPS0pnR3NvbnFMV2M4c09keU5vb1BTT00zemlz?=
 =?utf-8?B?a3ZTOCtDZHBZOVhQOU5vUUEwZ1hBUmJrK3lUdHJXMng4MWlValF3azdyVzcz?=
 =?utf-8?B?cmlyK0xZeVRrZUJXWVlYZklsNGY4YnhOeVpybEZ4S1VnMlJqUDVHQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 088544b6-9c08-4c6f-79b4-08ded3918dce
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:23.6941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WSckMnJDbYy3xmLfwiqyxq6p/JtZHMJ2G3c1fzAm6lT4raU9E8evkR1DKUDWM7Bz8D1o675b4l1GibDnRHOeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2694
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9415-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 881A76CE1C9

Add an `io_project!()` macro allows projection from `Io` to a subview of
it, using the pointer projection mechanism to perform compile-time checks.

For cases where type-casting is required, the `try_cast()` function may be
used where the size and alignment checks are performed at runtime.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 0746b0d209ef..96962498af77 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -49,6 +49,7 @@
 /// - Size of the region is at least as large as the `SIZE` generic parameter.
 /// - Size of the region is multiple of 4.
 #[repr(C, align(4))]
+#[derive(FromBytes)]
 pub struct Region<const SIZE: usize = 0> {
     inner: [u8],
 }
@@ -90,6 +91,16 @@ fn size(p: *const Self) -> usize {
     }
 }
 
+// SAFETY: Values read from I/O are always treated as initialized.
+//
+// This cannot be derived as `derive(IntoBytes)` does not know that this type is padding free (given
+// `repr(align(4))`).
+unsafe impl<const SIZE: usize> IntoBytes for Region<SIZE> {
+    #[inline]
+    #[allow(unused)] // Rust 1.87+ stops requiring this and will emit unused warnings.
+    fn only_derive_is_allowed_to_implement_this_trait() {}
+}
+
 /// Raw representation of an MMIO region.
 ///
 /// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
@@ -339,6 +350,49 @@ fn size(self) -> usize {
         KnownSize::size(Self::Backend::as_ptr(self.as_view()))
     }
 
+    /// Try to convert into a different typed I/O view.
+    ///
+    /// The target type must be of same or smaller size to current type, and the current view must
+    /// be properly aligned for the target type.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::io::{
+    ///     io_project,
+    ///     Mmio,
+    ///     Io,
+    ///     Region,
+    /// };
+    /// #[derive(FromBytes, IntoBytes)]
+    /// struct MyStruct { field: u32, }
+    ///
+    /// # fn test(mmio: &Mmio<'_, Region>) -> Result {
+    /// // let mmio: Mmio<'_, Region>;
+    /// let whole: Mmio<'_, MyStruct> = mmio.try_cast()?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    #[inline]
+    fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a, U>>
+    where
+        Self::Target: FromBytes + IntoBytes,
+        U: FromBytes + IntoBytes,
+    {
+        let view = self.as_view();
+        let ptr = Self::Backend::as_ptr(view);
+
+        if size_of::<U>() > KnownSize::size(ptr) {
+            return Err(EINVAL);
+        }
+
+        if ptr.addr() % align_of::<U>() != 0 {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: We have checked bounds and alignment, so this is a valid projection.
+        Ok(unsafe { Self::Backend::project_view(view, ptr.cast()) })
+    }
+
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
     fn try_read8(self, offset: usize) -> Result<u8>
@@ -979,3 +1033,73 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
 // MMIO regions on 64-bit systems also support 64-bit accesses.
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_relaxed);
+
+// This helper turns associated functions to methods so it can be invoked in macro.
+// Used by `io_project!()` only.
+#[doc(hidden)]
+#[derive(Clone, Copy)]
+pub struct ProjectHelper<T>(pub T);
+
+impl<'a, T> ProjectHelper<T>
+where
+    T: Io<'a, Backend: IoBackend<View<'a, T::Target> = T>>,
+{
+    // These helper methods must not have symbols present in binary to avoid confusion.
+    #[inline(always)]
+    pub fn as_ptr(self) -> *mut T::Target {
+        T::Backend::as_ptr(self.0)
+    }
+
+    /// # Safety
+    ///
+    /// Same as `IoBackend::project_view`
+    #[inline(always)]
+    pub unsafe fn project_view<U: ?Sized + KnownSize>(
+        self,
+        ptr: *mut U,
+    ) -> <T::Backend as IoBackend>::View<'a, U> {
+        // SAFETY: Per safety requirement.
+        unsafe { T::Backend::project_view::<T::Target, _>(self.0, ptr) }
+    }
+}
+
+/// Project an I/O type to a subview of it.
+///
+/// The syntax is of form `io_project!(io, proj)` where `io` is an expression to a type that
+/// implements [`Io`] and `proj` is a [projection specification](kernel::ptr::project!).
+///
+/// In addition to projecting from [`Io`], you may also project from a [`View`] of an [`Io`].
+///
+/// # Examples
+///
+/// ```
+/// use kernel::io::{
+///     io_project,
+///     Mmio,
+/// };
+/// struct MyStruct { field: u32, }
+///
+/// # fn test(mmio: Mmio<'_, [MyStruct]>) -> Result {
+/// // let mmio: Mmio<[MyStruct]>;
+/// let field: Mmio<'_, u32> = io_project!(mmio, [try: 1].field);
+/// let whole: Mmio<'_, MyStruct> = io_project!(mmio, [try: 2]);
+/// let nested: Mmio<'_, u32> = io_project!(whole, .field);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! io_project {
+    ($io:expr, $($proj:tt)*) => {{
+        #[allow(unused)]
+        use $crate::io::IoBase as _;
+        let view = $crate::io::ProjectHelper($io.as_view());
+        let ptr = $crate::ptr::project!(
+            mut view.as_ptr(), $($proj)*
+        );
+        #[allow(unused_unsafe)]
+        // SAFETY: `ptr` is a projection.
+        unsafe { view.project_view(ptr) }
+    }};
+}
+#[doc(inline)]
+pub use crate::io_project;

-- 
2.54.0


