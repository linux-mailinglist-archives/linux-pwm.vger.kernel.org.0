Return-Path: <linux-pwm+bounces-8986-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJF0HzkGDGojTwUAu9opvQ
	(envelope-from <linux-pwm+bounces-8986-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 08:42:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D785783EC
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 08:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5EC430B55CA
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 06:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982533ADBF;
	Tue, 19 May 2026 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e/RsLKj9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9B390239;
	Tue, 19 May 2026 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172618; cv=fail; b=e5VikTUqQB40xIC5mjcvP3SGOfjFrXeskPuPpTYWfYYRBDPky/MMwUZBsOe00BKRRzd9fb6ilVpqPjZHKEOZWll3Q++/scUcpO4shE2uFFNG4Keyb/KOxA2r5Aaiy3IAvB2X86yYNAhfHLP2/bSfwO89qweQhLnwlNq+fRnO/DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172618; c=relaxed/simple;
	bh=BXBpVJ0Ed7o62TDejvrXGDISjWQN5q6al/1JLtsRQSQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Sz/PlTTrd3eZpBE+MjvWGMnsBMhniIIXt5eEGOx8hSt8v/2C1RPTiAdtHpF4c+U8lf6aq+MfMXyoxcu8C7axCTNqSA081R6P3aYQlO7qscu3lqfDa6F+GCfiYsoULla+CHY2Ji2akw7TZG9GVVvXTDGnoCKgBpSsGS2Qw+mpSvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e/RsLKj9; arc=fail smtp.client-ip=40.93.198.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3/QwAlEil6+9cZsxJkHTFhOoCfvtm8GkZKOGVZ31XBwtRH2iCJr90Dhj/eMWBw1J2WxZTEQz27+LvmEkw6OW4T/ci+cVGQYwvJpxFXWCBu6rSo7Spye8t2z9YGq30wv1Omsy30QZpM+JlKfDf3BrZunLFwVycdSGCQak6NdoafAyH+gBUtq5HGvQfc9pLysw1xiCG5jrcq390QP820HqX69FsquvcFM3h4i/XkSF0iGFpN4VCZF6rIxRFGxOtUjvgPqtqFdO5lhNgdJ5cj6KRKcAgIrS0WFrIYm3TisikMyw0+BUIBaxN+3CzCUJwF3+T4NdWq+l9HconN7xtCPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXBpVJ0Ed7o62TDejvrXGDISjWQN5q6al/1JLtsRQSQ=;
 b=SglCLRIPjstQ/mmFSjLHvMd1jHmAXWuqkwtbUYcr/cnRfU+e/5RAAMYZthd9xrpvemRZs+OSFJ4lTKi1APlWBQme2aLeKZ09KyBheXmt1YMwQDfS5Qc/0aQUG8Wgjnz8TWP4mhAdPTQ/xeKRt98VvImwgqFFCZjW+iwBkp8PYr0G06gKNdWctT5cbRv/v9SbzvsU/2cC25WoOy9/dd7O74BiKDEPNx+NECsUzomSY3H7MN+9OpTglI2UrMC4MGV3N7l+OVe55faKdGlDblSO32J0bCx0qNDLCpaXlr/MU0uEZPJgztM/dirZs9u4p7nr+Q1/i9PDdqFiTANuPOUang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXBpVJ0Ed7o62TDejvrXGDISjWQN5q6al/1JLtsRQSQ=;
 b=e/RsLKj9Oo3hrg3mhhwvOf9OrcImOQbQaP88v+0ZJwGEnMSl3iT7ySbrBl8wOvyxGg/jzhNPr7vGl5rLAJJhmchCRp/5riEkTBCWJcZofGFH3W2S3wM+5sBTxjCdhpI9IltrVevh8udcDGCEuN9AoLU8lij3HVjPkaypSC5GHhu64pRzqbZnvDW0YzbXt4Bhy843IQ8wuaVcQjAIa1Ga+TmW5LuD5+SRrNnPPG39TEOmvF7FIrJgg51sCtp24tCfL6p7fRS4bx0O1IA7aRLpiLRw+dtakI2cQX4SfTeCl1PjlxaXaODdAzlxoaIW/6sqDsaFpaZwOhnJ7Mezh7/BcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 06:36:53 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:36:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 15:36:48 +0900
Message-Id: <DIMG1WVC767Y.W8D3FP956I8M@nvidia.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 19/27] rust: pci: make Bar lifetime-parameterized
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-20-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-20-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0163.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::10) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b07a92a-a721-462e-8086-08deb571030c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|921020|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	pWNYOJFvy3/wNaFGD2p+QZ4uHLqgKWCMSh6MZNalb13hvLv9YUtEzPXQRIqdDVhEdFmYuqMgb4jYJNPLr+H5+Ku3wH5G5fcPDVpHjnB/hELtG8wGZDtMl/U04JB5fjDqUdssbHCfeoGABBw3YOVJaIv99dZPMxb2+khopMi5+CeHxPCgmwf+QBKDW1cwDeOH4F7IC8EkHLQlhI23/8NHt6tFrpjljxeBGR7wZLtR4j8F9VXOfivWw72PXMSSea+aBgSmzgGyQmXYH7fVfgDzuOpquUnQnO5Oh9MXj29jJoM2MlgS/2LhahIRdfH1B98TpyQsJpChWyZA7KtNLm6a/g7Rnwm7CY9hj0X7SRA+0lySXII3h1vqpgvRTXmLYh8ZzawmoHn4/PGl3+wC/4VRXRHkyCWBc24nf5XnIiygbwFRA2JWa5z7DJ9Xa3ZRqTg+VMlUr7q7j1dQUph+uox+aWgjcbdJ9cTJorVWnOU5Ydk9mNdMwvbhbXZP+eFSqYi3U4z0pIM+lFVwrHLPeb+uW/77QLNg448ycci0ziZmridn7TERVTkTu9uqVIUA1caM4r3qCN/OQrxKXflNgoZM/zw95ETugezYv7ZKmKNbKd1WJWNUiMez5g4MskeOdX1XAM96x6BvYYpwMJfRbrCHdd6Ly/iqpxCT/2Xjomai3LUoJUKner0fJa1EdmPksmPOgdmSXteMQZ72U1lQvJWvRX17DbpjRcm2z47FSZFFwZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(921020)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmV5b0lqNW82N3UybVV0Qk9MRmtvQklvM2RQeEtVY3JSRWNnRHhEZmllVE1K?=
 =?utf-8?B?dm1JTWxzWS9zRmp2b1JjYlVGRGx4bDBObnBXZDFUVGNQU0I4VUdIc2t2ZHdI?=
 =?utf-8?B?ZVg5Zi9SSTNaNEJHalRLakZuZktQNVVwNHgvL0huS1psME8wUXZxN1gvZnVL?=
 =?utf-8?B?NENOWDM5aGEwZzJJc09FemJKNXcrWWxSenl5UFpkNGl6eTEwUmQxTloxSTEw?=
 =?utf-8?B?aDE0dTAreEdOOWsxY3lTYTZDZkNjSjZONWlJUmNTRkgxUDVQL0c0a1dMS2hT?=
 =?utf-8?B?bitrY3hSbVZQak9sb005d0hEdjlXVkQ5UXNGT2d6NS9sR2grMkxscGtjblRn?=
 =?utf-8?B?QjFTd0QzZVpwNytkUHdZOWZCZnpYdTBUQ0FvZkFQRFZNN3d0LzJFdktqNzU3?=
 =?utf-8?B?ZHlNQ1ZIWHh5TDU4UTJXZ0w1V24vQ3VLWGk4SDh5WGJoL0Z4ZVluRXQvRHd3?=
 =?utf-8?B?ckxqMG51dm1FZmNuN2E0MkNzUm0zNFlpTlg1ZmtJSGtqL0VwWTIrbGNIMGtV?=
 =?utf-8?B?ay9hKzJIeU5XOEl0bjNLWGRLenZqS1Y5Q2FMQVZ6QWUzekVhclMzVU9sRDFP?=
 =?utf-8?B?TUJ2NlA0STV1K2hNSkJvTm90QVc2QnhQVlJybWNRcjRpQ1pwdlk2d2Y2ZGdI?=
 =?utf-8?B?L0ZSTllXaTVqRFVWMnlia0tTZk56Q1ZVMW9DTlZLRktZMnVrVkZXVkFIY1FW?=
 =?utf-8?B?R0JsWWF0QkNZWjgyeElkQUF1bzVFT2VhU3FJNVNlbXJFdFErNENTWG1wZU1J?=
 =?utf-8?B?dXBTeHh6MUpMNUZnVk9hRjdzWXRIeDRhakxhelA4ajRYTHlTd3dwMjJyWGN6?=
 =?utf-8?B?RS9lWE91S1h3U0I3SSs1WVRqbkMzL3ZMbzcrNEJyd2U2QTljOWNNU2ZrRk9P?=
 =?utf-8?B?Sm1vc0hqSkJMVUYzYk5Ld1FNUWZ1SE9ONlFvT1Rtd1lEdTk2OTFkbVJhRUxS?=
 =?utf-8?B?M1hRcjAzRmk2U3NmUTh4aUQ4RUxtT0VYN3FPUzAzSXF6R0c0RXVndDB1N3dp?=
 =?utf-8?B?Y0hEOEd5STNMcjJJUjZrQ0hLYlI3d1I2YW1jTTloQkdjdnc5Z0xUMUE5ekJm?=
 =?utf-8?B?WVdqVXRWNmdaNCtvTVRHUk5oL3d5UEpVTnVWYkRXK3BWT0dISDcxQlJTT3pq?=
 =?utf-8?B?SkoxNHJDUU9PakpCK2VSYXgrUGNRY1dWWjJZSlBCVVNrelpLbnFRcG5QOXNa?=
 =?utf-8?B?cUdsenBJM2R2aFZJM09JWFpSdzZDL2YrcDdWN3Y0RzFFYmdiMVNiV203Q2VB?=
 =?utf-8?B?WE1oSVcvK3B6bjNUenBpeDU1disrYWlQWmc1M0lGN0g3b0taTzB5WWZJdnF4?=
 =?utf-8?B?SU1ha3o4YWcxUlFxd2p1aXNhdXhoU0ZQcmN1WWZMWTdjZDZpUndtTmMwMDJG?=
 =?utf-8?B?UkNhbXRzbGhoaDRLbWpiZDhYY3Btc2h4WEFFanhMenNZb1I2NU9MSS9wbXF0?=
 =?utf-8?B?TERTUDNLMTR5bUlsdU8yUUc3YUN3WStUN01heUJHeEpRVzFTR3pJMmYrY2tz?=
 =?utf-8?B?N3JUNkpiQnZSS3hGZ1crWTdmc2t4MHFwSXp5Zk1yTjdJbWUxSXpuK3o3bTJC?=
 =?utf-8?B?TGRuOCtMdjdkZW5EZXhmNStBcG03eFBNOTUyYmtJZFRJb0Z5UnA5SXJxRmFY?=
 =?utf-8?B?TGFyNEpONDBQaTVZZ1cxUlNiMXR0ay9GSWV4K0pCZVVLRDd5Z043a2tqaEth?=
 =?utf-8?B?KzlFOVlIUms5U0pDTi8rcW5VODRmYkd5a2RmRVpHZFZlaUsyS0lMdXYyN0Zy?=
 =?utf-8?B?dWR0bzVHYXdVb3hVbGxmam1mVlQyTUZPU2ZnL3hzWlVwcjhoVURtOWlZUm4w?=
 =?utf-8?B?eFRPb1BCUGtlRnpjMlJLb1FkelMwWUVubmV2Q0hubGp4OTQzYzRpV1dndEli?=
 =?utf-8?B?cVFlbEVSbEp6ZFZlOUFmS25INjlPMTlWaDF6QzM2TFdkMEtlWHBQRmlxVjYv?=
 =?utf-8?B?K1RIa2h0NGx4eDJEbDFhMThPWGMydjVXbzBGeTVtVjVqZmhZOWZBb0lVVVNK?=
 =?utf-8?B?YWYvYmxyV3NYcnc5dkNjNkVuRjFSaTlXeVNROWtvKzkwWFJZSDJWSzBtUmpW?=
 =?utf-8?B?Z3NhQzVxcWJLMi8xWXExVzVoK3M0N2JPcEI5dDd6Z3N2RnF3RFowWDMrVkZL?=
 =?utf-8?B?TU95QXdnWUpSY3dSM2NBVi9KZWFtdFVsWjJDSFNxMzFCcXNHV2NodHpPK2VD?=
 =?utf-8?B?R0pnWWlnVUtpUkxSU1llQURKN0gzNjRoeHpHMmF5V3RPMThPK01hU1dFZjZW?=
 =?utf-8?B?UGZxMkhCSjVWdlhvQ3JIL3poZ1ZTWjVlZEpUOWtMT2pnOFA3Q2pxQjIvKzEy?=
 =?utf-8?B?SUNqQ1NPVWVBcmZTRkN4Z1ZBNFBBMnhWVjRmMXY5dHE2b1dCYmJWRUlWQm5x?=
 =?utf-8?Q?5LPDLFPjdxaUw3xLi7yhN+DZhgfIv47JRRCbQE0x023qS?=
X-MS-Exchange-AntiSpam-MessageData-1: QkQZUAhhpGtY+g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b07a92a-a721-462e-8086-08deb571030c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:36:53.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7coqtPsvZYPQzc3QIdNhShmhs2We+6NWztW8IFQIhuM2x8WsHQYKIFgOQf5Fb6lXHamVGZZmJ+XjVzzj1pNKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8986-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecourtney@nvidia.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 15D785783EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
> Convert pci::Bar<SIZE> to pci::Bar<'bound, SIZE>, storing &'bound
> Device<Bound> to tie the BAR mapping lifetime to the device.
>
> iomap_region_sized() now returns Result<Bar<'bound, SIZE>> directly inste=
ad
> of impl PinInit<Devres<Bar<SIZE>>, Error>.
>
> Add Bar::into_devres() to consume the bar and register it as a
> device-managed resource, returning Devres<Bar<'static, SIZE>>. The
> lifetime is erased to 'static because Devres guarantees the bar does not
> actually outlive the device -- access is revoked on unbind.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

