Return-Path: <linux-pwm+bounces-9403-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FNc/DJGQPmpXIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9403-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:45:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30FD6CE0F0
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:45:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=wNM+PhPQ;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9403-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9403-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DF403008D67
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583DA3F54B4;
	Fri, 26 Jun 2026 14:45:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021075.outbound.protection.outlook.com [52.101.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B9C223DCE;
	Fri, 26 Jun 2026 14:45:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485125; cv=fail; b=uZCaJf5ZC+gtbCbKK6F7Wzwb+uiWrGdytM3p/JcxSWU/oSzEzNPpszv3dEyT0Bw7sbqvAcPPhQQFVIpayEBLJOIxW8HemBEX6DlD9c2T6cmc5Wz9UYdIfNChDeu0txcvUfFvl1z3/1uwSYkgzTCGeNW4uRQ0QA9pNtVN7NxcZyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485125; c=relaxed/simple;
	bh=qN4Rp5rSJO9iZNzBa1LHWlwtyCVDcc4D/NvE7r0zlno=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=JMVakWghuR8SARU4sm/vNMEaA3Bqw9TUN/NCwbDMTZTUsYXimN/Glj13Xk7ZdzgcavSvuds1bHjz4kx009E3Vwjd9ar32KYaznCSNV0lSF2huu28CCOyWn6VHcrHyGCYDVmvTWPb0ueLE+07SpAvKzZz7Nb4mUuj7n2PRStzeu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=wNM+PhPQ; arc=fail smtp.client-ip=52.101.100.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+Y3hmoYB6egyCsn6a7NLqmFmLL2G64l4pe1sqJ7jSZcNCSX1RXj27OysDYos8+kOQYd/WEftc85MOlFsXRSMWPJu165cqbEF4oELb5PR2owXKOPY6tKrCPbBtYEf9TyQamAAkFo09LX+sM+0nNUA3MVA1De/PdG2Ch0m90rvipneKBdtLoeEBGE4AMNgGe00PteHhlLc2GUmeV3gAVXEBn2PoVP0JCwuAe3lepd6TNd3l/8JjNPkPMZ9n1Qy46sq0ZPiCXe+iNmBKb4B4mlxxeXmq8TGtRA73F0baHcayvxBwNoh5f5IsqiP4xCNdUQf5tUonI5JkS/2d+TJmXiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9TyOqJQzk8mjCBO2NwDdC56bw++GUQY2SSkgFqzlpc=;
 b=q7sKaFc3j6kh8eqOnP0MASvcPjVF/EzMIPEYokt5+DO2L4OdgMpTYL3HcoBw+CawDyWcl5LvS6n1o7WT/7srf48tfkvXBZqE6kJIHf5x3fJFhxpxWkxPN1ncmzt50zMFW6nuCRAMxks21w3fndEaSzFxv+jKonR58M2a4fR4M1Log2BSlyHJVVO67xdM0S3LpOv8i4QWF3Bsmtqd8cZxO3bPxxjEzdKZZDqO1db2tbHayAQDKvs5D2iUc1krxtau9yIB73uaU7ioEsHgzzSvcG6kpvUgYV6vpfBqtwJTxwMmpdxIm8tVmoXYYC9PHMEZsbu+UTBvmx1GI4nIGDDPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9TyOqJQzk8mjCBO2NwDdC56bw++GUQY2SSkgFqzlpc=;
 b=wNM+PhPQ5HWcZlZfk/4iRXz0gxxciaI8Oak5K2Tvi9NzgfBQ6tY3KNfkeYWJRtdeedtoGsTOK3lrxihW9KncXUk//tdSM1knExSq6u3W4hO8q990oJc2ANmssNZQw+7mc8ZPuZl0QcYbCSaLMOUfMe1IEexNxl7mgjBxN3DSou8=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7248.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:17 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:17 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v5 00/20] rust: I/O type generalization and projection
Date: Fri, 26 Jun 2026 15:45:04 +0100
Message-Id: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHGQPmoC/3WOyw6CMBBFf8V0bU07tKCu/A9jDAwD1AXVFoiG8
 O8WNMHn8k7OuXd65skZ8my76Jmjznhj6xD0csGwSuuSuMlDZiAgFgokN/Z4dvZE2ASSy5iSHHW
 WJqRYcM6OCnOd+vaHR/ZtNtJjyZNwdGnDUDNjlfGNdbfpiw7G67/BDrjgCkFLjDdAhdqVqbuVr
 V3V1LCxq4tmPxbrTz8KPmrMSUapJvzhqxdffu2r4MsiAVCZgByzd38YhjvXvfnqUwEAAA==
X-Change-ID: 20260421-io_projection-16e7dc5ba7e4
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
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
 Laura Nao <laura.nao@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=8182;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=qN4Rp5rSJO9iZNzBa1LHWlwtyCVDcc4D/NvE7r0zlno=;
 b=5P1b+WmmSsFDW5eVEo1XahuF6Q+rI5zPBm1R+nmycF5fub+RJ6VwDXIktyMzFTBPiLgpi+jXH
 H9OBtHY3q51AIm0DzWD9bEoc/7yMB5InuvHq+xQ8Ttex2K6wLj+Cx3f
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
X-MS-Office365-Filtering-Correlation-Id: 8f93a760-6fec-4821-4db5-08ded39189e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|7416014|18002099003|921020|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	4Z1MiGqhtz3coS20BQ1dpU9rvzSQmS4tpqjBktUWDnV0ockpl3HbjoDua4yE6H/R5+OMA3SbWDhU8p/T3b+pBp+m8xoQTED7NrzSNmr9vIedBleqjWgEM6FMIlb4SfKYSDl97ndLNudeYJaDg7S+R2dZQbxF9tRvaLFxYAqp3eqDWKEuBWtRpfhufpUnguMKMQo8dCsJhVYm/etIDebnxFaPHpd9ykNNdnLOmwrp6XGjXPk2RPl/NafUocx0hYCcOudbOYv+7t1U2EMJF97ZH/aQ0/4BDghrqmjAEpCXkd1+/AzPaKoSIeQ3Aw2CX+dCEGlJXkFn1FxYhTzpozZ+nQot7M28m4Vx8kpftfeEoDo/pKxPkuigSEOqlDHXnkbZLiXHgBWs7ABCqXa/nulJntVLRBA4qBo7LGzUlZaX/JikpHlyhLQtxCMAinRRMaO4WNR9Zt55vfSZ92uYwQK0hNUOzGTsE7Hi7t8vACDcON/TkAec4jGEEVSegAdNcsUAEufIeJnpDnbSlnvexlE2cD19T0KdgosyqneI1n1BaxY6UH73EXLQAejiymd1VXMjENovrJmisXnWMA2plvoobJNFKfOOnqPY7SPuIYGbhIolMV6f0FVEMWgd3bq4jTkdxNF+yeENtK2xaTUBKchKFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(7416014)(18002099003)(921020)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmNjODkvL0xFT1c1MGQraDY0bmxRRnhReFNaRDFadlpmaE8rNnJoMllUTG9s?=
 =?utf-8?B?OU5jK2xZblFOMkoxR0VEVVM4UGUyMzI0V3YzTFVKcEc5Sm5LdFBkWWlIbnVz?=
 =?utf-8?B?SEUwN2hlb1NiRUQ4VU91OHVzT3dkL0daYWloMG56ajBIOUQ4VGFKU04vOGdM?=
 =?utf-8?B?N1NSVkplVmlXdWp4UHJaUGV1UjJNMHVMMkVRSDQrM3RNb1lnQkVDM1hXejlh?=
 =?utf-8?B?dHBkdWxFZEZBbkh6eDdrci9nc1dTZ085Mkd2Wk1LMG5iRzdrMEE3cU1RSU5p?=
 =?utf-8?B?Y0ErdXFYY1QyV08yWFYrUWo4eTV5OWRxcW1tbnBKVmdsMHhlS3MzdGF2YXdt?=
 =?utf-8?B?a3p4NlBOODVBV056NWI4UU9CVmZuMjVJcm5VanNlaS9UY0ZaZ0xkQWNCUGYr?=
 =?utf-8?B?cVIvOFFzcithdU5SM2NTSTE4QS9lQjVGYTR4TjE0Nmd5ckpHaHBwMEI3NjU0?=
 =?utf-8?B?U2dRRzlnTktTaXVLWHpvQnNXbkVCT0FORFRBN01JaWNNWkJoZjJheTZHNWJN?=
 =?utf-8?B?YnB4M0VUWEtRdE9hNGRDdXJnWmZGLzArRDdWYXZ3YzU1NDZaSGZ2eHJMWitO?=
 =?utf-8?B?MXV6UHUxTjhoVFJVd0pwWStFL1pHSzhLZHJORTViMUd0WUxkNmdTTkVjckdr?=
 =?utf-8?B?STVJTzNqRFVuZVBiWmttd2hNVlRiUDV4WFRWRURuN0dwSEd2ZnpzY0JzRVlp?=
 =?utf-8?B?M0t4cWh0U094WmhSQkZWeEhBYnpxSWxaeVJzN1ZzSytBM3MvdDNRUUozQkJp?=
 =?utf-8?B?c0V3QnRLWmR6Z0lqRW8xZnJNbG5DYzE5RUV5Sit3OElIVUNmWXpnUWlwQ0dV?=
 =?utf-8?B?SlhMODFoTEtBNlpzM1owbUp0blExZnIwSWVzNi96RW5DL0xWckNFUkJKZUxP?=
 =?utf-8?B?MDE4eXNDVDdWTFBONzBmbS8wTkVzU29KcGNpZUpmeXlMWUdacDJCOXptdUJ4?=
 =?utf-8?B?TmFJUkgwWi9UUEtpdS9MV0RNNndTbHhITms4aWVCOERlMTNmcVR5c25Sa2Jh?=
 =?utf-8?B?NSs5c05qWlRINzBqR2hhQklJRFVXL3dZM091OEFybVhZdFZMV0NzSVNZK3JY?=
 =?utf-8?B?VXA4bWRxSjlDOUtOREwyV3Y0WnpnZHpHcm45ZHZjY0hxVWY4VGMycVp1NXZS?=
 =?utf-8?B?ZUZDQmtEdGpFeStKclVXQ1RvWm9kL2Z2UVNwNmFHa21zWUFkN1dYWmErQ0ty?=
 =?utf-8?B?aVVST0E5QlVMa0RweDc3T0lBaG5WNVZ4SE1Zem10SEIrTzJpVTdhdHpaVWRV?=
 =?utf-8?B?aE9QUDdnQzFqK1hIaHhBcHNBSjJPbTdkQ210dWNBRG54Tm5qQVZoUkNuSUtj?=
 =?utf-8?B?OFBLNzFQOFdlVmVIWWx4L1ozN1pJSlhjZTA2bnZFVGI5d2pSSkVXY2VqUjRG?=
 =?utf-8?B?ZDdaVU5YWE1LSDMyN0Z6VEVMMENBcHBUR21mRlYwbnZOL0dxc01iNDBYajZm?=
 =?utf-8?B?UDUyV29LMU1XbkthQVlFNGdZT3Y2dDZER1IrcmowUEpUUDFmNy9WZ3NWS3dB?=
 =?utf-8?B?UVZKeUpKK09FUmdhNGd6ckVZMjZhbjVFUkRMZGRRajZnbmQyZm5ndDNtY1Bp?=
 =?utf-8?B?SUxhendVdnlqZU9ydVZKb0lFeWhaekFvQlpKM2tydnd1eEtVbm11RlZFZW5r?=
 =?utf-8?B?WTBobDhGNXdwUUMza1lrWk1Zc0xXSXdGOXhxbENnZTVQRTNCbFlpNkVxZXRB?=
 =?utf-8?B?dVg5aGxRbDIwTVM5dVJXeitkcmZ4L0d1WVJsaVA3T1I4L3NZOCtGNFg0eW43?=
 =?utf-8?B?WS9WdGRsMXhXRExEcVcvR084R2ROSS9UTFgrMmozQ1JIbUhzL2xPcisrdkZ1?=
 =?utf-8?B?WHBaL2dLNkJSakQwQXlRaE1vMDNaTzVaWjZxbTFpekd4bWkxbU9kY1EyVitW?=
 =?utf-8?B?djhwb1AwdjhoQndwc2Q5L3l3TFBwMmZpeUdodHd4QzQ5NzMvSkdId1VybThY?=
 =?utf-8?B?cHd5Tk1qelgxTExnSTQ3RFc5NXBsTjlKekgxVE9Ka3IycFMydE9EdGM5b01T?=
 =?utf-8?B?U0djdWZUbVFwUkZHN1lvamJjUGxKb1RKUDRhdkp1T3lTaXhJUVg0bytYb3oz?=
 =?utf-8?B?WTVId0hvWFlGVk9NNHBsRWJKZ0JnZUZzb21kV2FFcWNGdHA5VlJncE9NNGI5?=
 =?utf-8?B?VVFVTElrVVV6OElzS1lwY3FHZ0pLT29pc2M5ZGhtMzc1UzlONSsrKzE2MUhm?=
 =?utf-8?B?MWZrUlNKTkZKbGR3ckpTT0wzVEdPNE90eWd3RkxuMk5ZUmQwVVNEb0pTRXRO?=
 =?utf-8?B?RGhzYkl2UjJ4SXVaOUlzc2EvYnBZWlcyWFhGemw2Q0w4Z2s4dy9jL3NoVGxs?=
 =?utf-8?B?bXlDSFYrUy9Vc0o2VS9nVlBKWGJHOTB4YmVuTGRtcVdjL3BzUlhzUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f93a760-6fec-4821-4db5-08ded39189e9
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:17.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxgM1OmffTb43BqYYhok7ogu9039Ls4r803TZYovo6J6M2E1rQ0lW+tO9LNy9lyHi9QrDwaB/1DyQHboYnERmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7248
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9403-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:laura.nao@collabora.com,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C30FD6CE0F0

This series presents a major rework of I/O types, as a summary:

- Make I/O regions typed. The existing untyped region still exists
  with a dynamically sized `Region` type.

- Create I/O view types to represent subregion of a full I/O region mapped.
  A projection macro is added to allow safely create such subviews.

- Split I/O traits, make I/O views play a central role, avoid
  duplicate monomorphization and less `unsafe` code.

- Add a `SysMem` backend, and make `Coherent` implement `Io`.

- Add copying methods (memcpy_{from,to}io and friends).

This series generalize `Mmio` type from just an untyped region to typed
representations (so `MmioRaw<T>` is `__iomem *T`). This allows us to remove
the `IoKnownSize` trait; the information is sourced from just the pointer
from the `KnownSize` trait instead.

Building on top of that, `Mmio` and `ConfigSpace` have been converted to
typed views of I/O regions rather than just a big chunk of untyped I/O
memory. These changes made it possible to implement `Io` trait for
`Coherent<T>`.

Shared system memory, `SysMem` is also added to the series, given it
similarity in implementation compared to `Coherent`. In fact, the series
use `SysMem` to implement `Coherent`'s I/O methods.

Built on these generalization, this series add `io_project!()`.
`io_project!()` performs a safe way to project a bigger view to a small
subviews, and some Nova code has been converted in this series to
demonstrate cleanups possible with this addition.

New `io_read!()`, `io_write!()` has been added that supersedes
`dma_read!()`, `dma_write!()` macro. Although, they work for primitives
only (to be exact, types that the backend is `IoCapable` of).
One feature that was lost from the old `dma_read!()` and `dma_write!()`
series was the ability to read/write a large structs. However, the
semantics was unclear to begin with, as there was no guarantee about their
atomicity even for structs that were small enough to fit in u32.

For completeness, I've also included the support for copying methods,
although this does not need to be taken together and can become a follow
up.

The last commit in the series is a reference on how you'd implement
`iosys_map` using an enum type. It automatically gains all the methods via
`Io` trait and can be projected with the macros.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Generic.20I.2FO.20backends/near/571198078
---
Changes in v5:
- Fix bad squashing of `Region` safety invariants. (Alex)
- Fix compiler warning in Rust 1.87+ on `only_derive_is_allowed_to_implement_this_trait`.
- Many typo fixes. (Alex)
- Rename `io_addr[_assert]` and make them standalone functions. (Alex)
- Fix safety comment for `copy_read`.
- Add note to `copy_read` and `copy_write` that they can be different from
  `read_val` and `write_val`. (Sashiko)
- Link to v4: https://patch.msgid.link/20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net

Changes in v4:
- Added `Send` and `Sync` for types that internally uses raw pointers. (Sashiko)
- Make `Region` always 4-byte aligned. (Sashiko)
- Removed `copy_from_io_slice` method due to unsoundness when regions
  overlap. (Sashiko) This means that `is_mapped` hack is not needed anymore
  so I've also cleaned up.
- Switch `FromBytes`/`IntoBytes` to zerocopy from kernel::transmute.
- Changed `Either` to specific-purpose `IoSysMap` enum (Miguel).
- Link to v3: https://patch.msgid.link/20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net

Changes in v3:
- This version presents a major rework from the last version, mostly inspired
  by discussions that happen during RustWeek. Notably, the new individual
  view types are now the central piece of `Io` traits rather than an ad-hoc
  addon using the `View` type. They also benefit from type-erasure; the
  original type of `Mmio` or `Coherent` doesn't matter anymore for subviews.
  This removes the need of specifying generics on types that take
  `CoherentView` on Nova code, which is something that I'm not fully happy
  with in the last version.
- Add `SysMem` backend and use it for `Coherent` (Laura Nao).
- Add examples to copying methods and read_val/write_val (Andreas).
- Add a reference patch on `Either` implementation.
- Link to v2: https://patch.msgid.link/20260421-io_projection-v2-0-4c251c692ef4@garyguo.net

Changes in v2:
- Rebased on projection syntax rework
- Added a new patch to forbid use of untyped I/O accessors and register
  macros on typed I/O structs (Alex).
- Fixed a few safety comments (Andreas).
- Added a new patch that implements copying methods (see above).
- Link to v1: https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@kernel.org/

To: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Trevor Gross <tmgross@umich.edu>
To: Tamir Duberstein <tamird@kernel.org>
To: Onur Özkan <work@onurozkan.dev>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
To: Alexandre Courbot <acourbot@nvidia.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Michal Wilczynski <m.wilczynski@samsung.com>
To: Uwe Kleine-König <ukleinek@kernel.org>
Cc: driver-core@lists.linux.dev
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: nova-gpu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Cc: linux-pwm@vger.kernel.org

---
Gary Guo (19):
      rust: io: add dynamically-sized `Region` type
      rust: io: add missing safety requirement in `IoCapable` methods
      rust: io: restrict untyped IO access and `register!` to `Region`
      rust: io: implement `Io` on reference types instead
      rust: io: generalize `MmioRaw` to pointer to arbitrary type
      rust: io: rename `Mmio` to `MmioOwned`
      rust: io: implement `Mmio` as view type
      rust: pci: io: make `ConfigSpace` a view
      rust: io: use view types instead of addresses for `Io`
      pwm: th1520: remove unnecessary `deref`
      rust: io: remove `MmioOwned`
      rust: io: move `Io` methods to extension trait
      rust: io: add projection macro and methods
      rust: io: implement a view type for `Coherent`
      rust: io: add `read_val` and `write_val` functions on `Io`
      gpu: nova-core: use I/O projection for cleaner encapsulation
      rust: dma: drop `dma_read!` and `dma_write!` API
      rust: io: add copying methods
      rust: io: implement `IoSysMap`

Laura Nao (1):
      rust: io: add I/O backend for system memory with volatile access

 drivers/gpu/nova-core/gsp.rs      |   53 +-
 drivers/gpu/nova-core/gsp/cmdq.rs |   66 +-
 drivers/gpu/nova-core/gsp/fw.rs   |   82 +-
 drivers/pwm/pwm_th1520.rs         |    7 +-
 rust/helpers/io.c                 |   13 +
 rust/kernel/devres.rs             |   24 +-
 rust/kernel/dma.rs                |  280 +++----
 rust/kernel/io.rs                 | 1479 +++++++++++++++++++++++++++++--------
 rust/kernel/io/mem.rs             |   29 +-
 rust/kernel/io/poll.rs            |    6 +-
 rust/kernel/io/register.rs        |   44 +-
 rust/kernel/lib.rs                |    3 +
 rust/kernel/pci.rs                |    1 -
 rust/kernel/pci/io.rs             |  168 +++--
 rust/kernel/ptr.rs                |   12 +
 samples/rust/rust_dma.rs          |   12 +-
 16 files changed, 1603 insertions(+), 676 deletions(-)
---
base-commit: 6c94b38b83a04c43ea49004275f0391404051093
change-id: 20260421-io_projection-16e7dc5ba7e4

Best regards,
--  
Gary Guo <gary@garyguo.net>


