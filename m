Return-Path: <linux-pwm+bounces-9405-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tyk7DfqQPmqGIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9405-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:47:22 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AF46CE18C
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:47:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=oYnRv3+C;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9405-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9405-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B616C307407D
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522C3FA5CB;
	Fri, 26 Jun 2026 14:45:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021075.outbound.protection.outlook.com [52.101.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A83F99E5;
	Fri, 26 Jun 2026 14:45:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485132; cv=fail; b=i0EinBJqmLc5zaan6w9D+n2l7iqNLKc3ifiy7KnKZCRmwUPeDoVG4U3LffHnA22AXhEqxf3x2dgCYZcYKY82QcM/UA+k9nIxiiFWQ9TGFUFlIu3k8C+GUPdpSNC/PPglXI9IML50apRcGQBfM+djXr6gxNtDgAEL2BWDZP1D3y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485132; c=relaxed/simple;
	bh=szxwJDnA7rTSEfocggCKebMj0aqWh3b0eoiakCjY6p8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X66LxCcEeY3fM0Uig2hCx6cunxZGxrD8Z5PKzFAg+BcjpMZ04rua+x7rFsc3aCaVHr1iYMzKfKi6zaAjK2eU+QvZC21+kU7UewJHqGB0lZQ/h/Tk4NiMA86Wf3CVF3xCwuHF2Zo8VIMRXPJb02d4AjseLSOE1J0VV85lAWyaZNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oYnRv3+C; arc=fail smtp.client-ip=52.101.100.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBAumCZIM/aneMn57yx5yL/7WBzmr3oZXB0AsKBu4y+PCNyljOslW1AdMOUqW339Iqgb0qFWf8/O9mFXNqw0mBD0EcrU1YFkvOiC9ZPdqv/0+ECBlPwHHGSTeuTrVABN+yDP3ZVXSas6RNFK6zdYDEVxY/4unFbYszAd/e3h6iRLYHPQ2G8QqB1IFdA4ZM1VMd/QZXrRD9aUZORnkt6hqpWvk9Ft8rvLIGNxZW98NUWrRAnkd2FuGvTKORTQ22ToCnc0FoFS1ja5dYfDxu4jMI8Y5KofBF9ZQdGETWXmwftrSToHS8+o2yNSX5K18hMywijIUQiGi2+tP+2g41xOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nI/K6E5mJz+mqRbUC/6lTTT3GMPn2WcTdx3VFlB9BdM=;
 b=dbMIM15EHEaDqVfgkuxhHwwYlSUnPHaoB+jgsnpKS2464C8YtSnsFvdaMLiD0J2QCdLR9RAyNK7MmTGxlhJ1uep3M9wE5WBsi+zCatbfyazRHt+cjqPGTBm7RRh2QP32tr47oeu5jSR2GcY3rG7rjh/iUwqyf4fvZ14Xn1zCWxmppqZylojsSEKi62/MjdwMCRKDVX08OLvvKZcK06unMN/RCMYLSp15ouHwGzBap+myad75TrxvSRsRKLHm5d6wYJKoM/4V5pkgWcKg6FMfA/a4709pR/LgqyI0gJYEDJg4D5ZQnh5RSjqwCgVMNMRGdWkRVUW0cCwSUoMURII99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI/K6E5mJz+mqRbUC/6lTTT3GMPn2WcTdx3VFlB9BdM=;
 b=oYnRv3+CG5f6TM9Q0Yz22yy3CXQCqBl/dKN8juCBnQdJK3rwVBuUncwZwqykG8hmOmElup/CPnql2Rviy3pLd9TSXl+pbiksODOj+fz4SR88pEt3+cxqsMuHuZ64pNU+Jl/i82NFiw88Hr7jHpKcZ1k3ZbzyZTI3Iz+vKuFpVi8=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7248.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:18 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:18 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:06 +0100
Subject: [PATCH v5 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-2-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=3734;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=szxwJDnA7rTSEfocggCKebMj0aqWh3b0eoiakCjY6p8=;
 b=sas9nNtzzp9KUl5DIVPa7ENDFuITr1zhTvOAHFxcdl2ly/LAUu/tCIPvMPWyVM3r5MfdLyk5B
 qDpWr+OHQkLDRC146oa4WQGjApi7I8oOTav0VFP64Sc3j8Bq3E9061y
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 519eb827-4f32-4f3a-282f-08ded3918a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|7416014|18002099003|22082099003|921020|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ra9eQ56xbTa+3uttFT+Ja5sSJpPJrTu3xHxAO3WuhRBpui4EDOLKB/J8PVm0B6mqld2hvGipK9BTGtgStUqYwH5XVRuCKz3w3QHa+2MjJwXDetv7hbvWLp7srzigc4NxI1mudnEkYicr7l66T1DIaUNE8vcp6RYkI3XalqBp397bIL/DSKeJdTdNb/kyWbhhfa/mEaijZ79AaGe83ASFxrZy3lcqwX+mK3HuRaXlH9xzxfE3+oLH/f7sSuBYKlbSb3R/w/AaKxgErxpes1MhqnfmHn3kw0ALk79AFfEG9ZSgrK0KodXGob+9Maf4jFcyvAXOgvdYvR48/Vagvg936VLyq/STQw0X1bfwbR3rHTRd7QUJ+fwfp/VtCzHm0iSyDmj/SEKAKpnUF9gyApehBbv+v2WuIUpp7Ti6HCpzdJxPEq0JeKbKjoYmdwa/xje51/MVYHagVNkepwgss54/q0jTZanw1k8vqUWTMEYTOZC3ZCy6i7oHuAYPbVjHZfyWD/rSqW2OosOtyJoDsYDg9VsHS/EkdhmjxU91nTIa4/Iab8qGVowVKeiV4Bk42n2ndrTzlXT36Gmdh54ObOGSOHdeBYEB045hj3UTfLLKw8t+06xgRbsBO3/Mj3BWWNYFEtUjmbDMR3FoIJ6VcPqcx5n+Pb3Oak25Ud1oK9DWMwVePI9dxafDT0ZrCUk1/X4eCF98CSE8MSKmJRXGxvn5Gg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(7416014)(18002099003)(22082099003)(921020)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3owUW1BeEs0amI3S01DenErWUdRRkVQaVRvQWtGRi9NeUREMW9DQmRqakFD?=
 =?utf-8?B?cTFnd3lTS0FLNXdweVJXUE1Id2JvWFNmWFNUbm9Sd0NCR3kzQ2NoTXhpZ1Bl?=
 =?utf-8?B?eHoxRkZWZTlwM0VvanRpK0o0L3hGVHBzRW5NbFlHQ2RDZzhhZlFnMmlVYUlq?=
 =?utf-8?B?V29zSko1czVHaSt4RlRwWHBsVnpnTk8yWkZ0V0lvK3RZL0x5U0llbEJhZVFB?=
 =?utf-8?B?eE9YdUdiWHhheWhIRFdZY1FkRnF3UmNmZXlQVDhhUDRlRDFHY3kwTm9RWi9S?=
 =?utf-8?B?UE5BREpTR3Y3bHl0eHBqV09pV25qa1F4a2h3R2JYUnlOWStaQlhST2JYM2lr?=
 =?utf-8?B?bU5DZHllSCtYUnpNYm1zdVFzOW1iR3oxOVNya1M1aDdXZVVLaGhlQW5mK0pn?=
 =?utf-8?B?VEx0Nk01S1pPMExZSUdVOUJ6T2hRNW93bHdQbmt3dkRRMktlY0FxdUF0VU9L?=
 =?utf-8?B?dy9CdGJ0TWlodWRNZnNHNVAzVHVYNWZ6c29aTWJxRTl5VnZNUWZibTZuWmtL?=
 =?utf-8?B?bXh5RXlYWkZpTGUxd2pkdjNxWHJ1VFJEOXY5SGdURGlvL3dlVDhvYlRHa0xT?=
 =?utf-8?B?bkdSQlRuY25qMEY4cHVIMHhZenUrSTVBSi9nM3R1NnN0WFQ0NVBoK1VKeUM1?=
 =?utf-8?B?VlRhakdwSU1yeDQ0L3lCaGRiN0xRaDBEbWRtQWljSDFOQnNCZW1zR3F3ajRj?=
 =?utf-8?B?YmhPRU5DNVM5WWJqU1RmblhIdWNPZ1d3Qm9EQ1diNGJkOWhKRVNUYTQ5QXFD?=
 =?utf-8?B?MFcrbHNiajFpL1VzQ2dWQ0dDYUdDNFJJSGhzOWxKeWs0dFhGaVRNb0pDVUx1?=
 =?utf-8?B?cGFkLzlJb2VIMWZvVUQ2bVR5YlZ5S21QWWJQSHNwY04zVEIvdU5aSC9sSnVj?=
 =?utf-8?B?cXlDaEt5Y3FXTXJZYnRUcjk2Vlp6VC9yM3kyVG9UTFJZOVZGYXVNVktQaVFO?=
 =?utf-8?B?QlcwUFRENzdkYjJORnRaODI2TXRkVlFONVlTYnlpK0xvRm1YeUpVeTdsaXdn?=
 =?utf-8?B?VzdEWGxQUk9TUG1MV2N1RVVJOFFPZGROS2FacGNDNm9ucGxBKytSY0V1RkIw?=
 =?utf-8?B?M3ZVN1dhWCtKU0YrS0EyZmt4RkdBMm5GNVVET3RIemNGS1dKQlE4UDRrWnVi?=
 =?utf-8?B?cU9iUE1MSVRmK3doNjJ5WHdnZ3UxRkZNYVM3T0FUdzF6bEVjN0UycGVPdFYw?=
 =?utf-8?B?YlRuVVFmRzJMY1A4dGlPc21pZ3dua3BoeG45QWVzZmovcGhPZW9qeHpKakN5?=
 =?utf-8?B?dUZHOHJ3TVgvSXZBUWExenVNelVQMmhzNUFnbGRyRENBNisrRTNSK0dQdjZw?=
 =?utf-8?B?dE9WSDIrUUlkOXBEZE10WTZuR3RoQWN5YkQwSkZPMXFnc05Sd0hhZ0Z2Tmgr?=
 =?utf-8?B?Y3Z3Zjd1WW55eWk3cTNobHlHdWpDbFAvZ2RRemkyUitzc0k1dnY1U0IwaVlG?=
 =?utf-8?B?TlQxTzNraEZtZFZCeWZyV0dkTzI4TE1QMWVBOGZ4TXM2eTNNdml5ay8ydHhZ?=
 =?utf-8?B?dWdvcnlEZDFPUzdQV3RiUjlsQ0NnaDhldWtQQXBRZy9iU3BNVFdBSXZLTXdO?=
 =?utf-8?B?TERTMytlN2Zra04vaGU1ZVM4U0c5UVNsMHJad3RMbnlMTzNCMG8vMUN3N0pj?=
 =?utf-8?B?Q1NTTHkxNkV6a2VuenNSTUVZV2dBNzNWekJRZ2JiMTVFNEs0YVZLYkZiUkRI?=
 =?utf-8?B?YmJEVUcyL3Rzbkx4SU9RMHBxMkt2MXBKWTRERllqcHBGOExKdTlTaWVxM1h4?=
 =?utf-8?B?SzFiNG9ZUmhDVEd0SDhlTTQrMjZkZkpHZDM5dEJrU01IT09DU1J6eEtZSXJ0?=
 =?utf-8?B?cjFVd2ZSdmFka09vaHVVZCtCb0RFaEM1ME4ybnMvQ01PQjE4cWYzaGh2UjJJ?=
 =?utf-8?B?ekVzNEpISW1YanM3aTBIOE5LUzVNVWMzQ0svQWhUa2RJeFFhaU5JWGlFRHRr?=
 =?utf-8?B?VzV5ZTJpSzJmbkVmNldIdllQdVBTMTVjMGt3VWtxd29kaVZrUjhoSzZMWmJv?=
 =?utf-8?B?Sks0RStmU1RWeThkK1ZlajJ4c0VLQ0JndEhzOHM2K2o4SFFUdTlmNExmV2VU?=
 =?utf-8?B?VHNleDIrM01NNXdPdXVFNWhrNUkrdUlKcjdlMFVoY1M2eFB5RkxnV1Q4SFd5?=
 =?utf-8?B?WDBxZlNoZWdjSlRINm1LYkc1N3ZNaE5SbXJSZUNVQk5MemRTL05WRmRiN2dV?=
 =?utf-8?B?QmRTVFFueUJlRUk0MUUyL3FPYTljTnlNbmNLSWRMaXdJYmc0UTYwa00yTHZr?=
 =?utf-8?B?cU5URmtidk41WE5uNXlHQzZhWW9JcnBMQXNCL2NzVlkvYzRJMW55VXVVK2xK?=
 =?utf-8?B?TFFnN3BPMktoS0ZuaU91azRrK2FXMXJLeW0yRmk1NUY0ckYxL2RQZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 519eb827-4f32-4f3a-282f-08ded3918a86
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:18.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXT21qoXbNPPGBLUEBZ8sVuxG4dck4NEp3FtJrV4LwpIyjCRj60saXbgfrth8kt1IHTo5bLtfiwUi0DqBIDBmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7248
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9405-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7AF46CE18C

The current safety comment on `io_read`/`io_write` does not cover the topic
about alignment. Add it so it can be relied on by implementor of
`IoCapable`.

Expand the check performed by `Io` by taking `self.addr()` into
consideration when checking if `offset` is aligned. For the compile-time
`io_addr_assert` check, check using the known minimum alignment of
`Io::Target` and the accessed type.

While at it, fix the alignment check to use `align_of` instead of
`size_of`. The values match for all primitives (including u64, given that
we do not provide u64 accessor on 32-bit platforms), but are not
necessarily true for custom types.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d1c5f0121994..d821ee48ed31 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -195,13 +195,14 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
-/// Checks whether an access of type `U` at the given `offset`
+/// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
+///
+/// The `base` is used for alignment checking only. This can be set to 0 to skip the check.
 #[inline]
-const fn offset_valid<U>(offset: usize, size: usize) -> bool {
-    let type_size = core::mem::size_of::<U>();
-    if let Some(end) = offset.checked_add(type_size) {
-        end <= size && offset % type_size == 0
+const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> bool {
+    if let Some(end) = offset.checked_add(size_of::<U>()) {
+        end <= size && (base.wrapping_add(offset) % align_of::<U>() == 0)
     } else {
         false
     }
@@ -220,14 +221,16 @@ pub trait IoCapable<T> {
     ///
     /// # Safety
     ///
-    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - `address` must be aligned.
     unsafe fn io_read(&self, address: usize) -> T;
 
     /// Performs an I/O write of `value` at `address`.
     ///
     /// # Safety
     ///
-    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
+    /// - `address` must be aligned.
     unsafe fn io_write(&self, value: T, address: usize);
 }
 
@@ -309,7 +312,11 @@ pub trait Io {
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
     fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE));
+        // We cannot check alignment with `offset_valid` using `self.addr()`. So set 0 for it and
+        // ensure alignment by checking that the alignment of `U` is smaller or equal to the
+        // alignment of `Self::Target`.
+        const_assert!(Alignment::of::<U>().as_usize() <= Self::Target::MIN_ALIGN.as_usize());
+        build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_SIZE));
 
         self.addr() + offset
     }
@@ -318,7 +325,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
     /// performing runtime bound checks.
     #[inline]
     fn io_addr<U>(&self, offset: usize) -> Result<usize> {
-        if !offset_valid::<U>(offset, self.maxsize()) {
+        if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
             return Err(EINVAL);
         }
 

-- 
2.54.0


