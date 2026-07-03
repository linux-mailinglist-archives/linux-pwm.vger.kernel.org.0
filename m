Return-Path: <linux-pwm+bounces-9511-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wEM3NKApR2p+TwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9511-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 05:16:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D06FE255
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 05:16:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=E1p4jGE6;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9511-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9511-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C68E730267B2
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 03:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4861D288C0E;
	Fri,  3 Jul 2026 03:16:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951DF28469B;
	Fri,  3 Jul 2026 03:16:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783048606; cv=fail; b=O7T9PH+aq/bknhos3zlSMlu6cJSnb7dqI6iVYBn0bBJhbk2px/3AQ9QyC2654pvp0AwXuvBOJh56YQHc8M3HO76CBx+m+w3eq15CfeuDoAXmBV/p7I59IkNVX6uRnK+vadus7JKBH7VyaWnHX1lloPCgSkUP6TQjQwHsUTKN5dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783048606; c=relaxed/simple;
	bh=N2uOEvMsi6ftliWYWPNHw8QSPSahfF0kMMQvGk7g9/4=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=T0e+NoZYy7534SwiXwWA0P/lCjF12nC7A+83VPmW9VZUOcpUgdaRTBD0KDAGlwLUuwdQ+pSXf/yVKyIRrGwHYC0r8/UDi2HbrpCVWhpxoSqyuQ1gpc+GZB+25tT9bYrOhBli076oqHC2HIY6mcmGPcWtE1A2kuXlF+iW3vUyAwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E1p4jGE6; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uA3erKTrRJsU+qNmJxruM7mVYOfwjaVp7iVOm9CawNOlMFUYuKI4flptf/JIQBkdRqpur2Rlu/iSwfBdx3omGYPNFCA7Ld4SxxhaQj2agbJpeDIdLNGtgoTM7Hrx5u9+gcW/lDJPL8EBKYbrbzADTbrHNi/yOM2qU8HJ+7fhWGMMvqMErNaFveuGZXEwM515rUpKcLMOEydazfkkA67LAuCNQ107V1PLg8qlBnXAwo3pok8/1be/yl4w0ehygYE9Q/tuOdt+aaiHVQki9fCpjFSq7WRmq7jgkW+TaFuZRbq72wxdOXFMt67rX8gYqrQI7uYNglX1lF7S07i2qTs/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NNU0vc4NPZUwr/CfAEylOFrLxTX/VKspuHB7hf9KMw=;
 b=W6irKq8akwAeMbgaB6pkLPl5gd45Gm2b4oMDcsiHv6SsXO1p4r+BVA2u2c3dGQ0gvyd68nhRu4Gi9+7lpuluJXjeRylvOIwb8Kacp2vLItyoMs9DPaIIhT/en+bGRw9PDA3lexwwV+fTy2USwR8geUfBVmwbETsFylSMAkA332qpU18ZfignR7wW3MfZFutqyt/G5buzehFfPNizlv8pMerkdnc8XkHRZUlrsLcGkFX/aSE2wiHNLR5Kjrxukmq3zgAx24mpLGH8GwC3Td23KMarJchIij83uyuhmMDUtu9uwJhQmRZhJmHnBvmVYi2etlPB7p5HUsM+pVUA0IxT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NNU0vc4NPZUwr/CfAEylOFrLxTX/VKspuHB7hf9KMw=;
 b=E1p4jGE6djOVOcEstivxEZ0UyG7Y11qR4huUnwPdIfH92nVmUkBAwts8HW6rH4vAvZ/drEhsDY56uORZkiSrT2YJvW5yZHGKYBSQWO2eh2uRz+1iHtT5+B/2CiJ2eNPJIKQ3RW+VqHX7EQXsm7TR+U0FjFx7jg9ZXDboMFtrD+Gpy6IyXz1X7vvde3+lXY+hMm8dooqkp20uhoD90RGqmaAhgbJ0J3DmgwseWKF+ug8QgP0byOva2DSQvVbgDM7RQA5BJrHtOsxF8M25pRvoKEHPLdfAvUG9EJH0PcZ8GSKvDBdrp8B9peQhFGZeRZKPUrzYN+aUN44iU3xHcGmUHw==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 03:16:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 03:16:40 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 12:16:36 +0900
Message-Id: <DJOLZ5AP1SDG.3CYRKS9S8KYEV@nvidia.com>
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
Subject: Re: [PATCH v5 01/20] rust: io: add dynamically-sized `Region` type
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-1-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-1-d0961471ae50@garyguo.net>
X-ClientProxiedBy: OS7PR01CA0146.jpnprd01.prod.outlook.com
 (2603:1096:604:25c::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: f0725a73-dbe8-440c-7c1d-08ded8b18011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|23010399003|7416014|1800799024|366016|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3BJU8GqOW3+BCzCi3mZil8ZjZ5fl3ih/EYnG1PnvuYW5jwnGRwRV4Fd3uAPbef1IHzyI+4pIEwvm6dWvYILACSzJDryl3zQum6tf+KYydl/O4sqTfWSf9kkRlr50B7nkyk06kDTIwaHgFisbIDWOvgWBSQ5U96/XY0W0zf5FKDz8fvaoDiQVZryOSuFa/1z+s5XgYSQHhCMp/XnxrYkYaYmyWKN+G8aWU7cVZWEj+XcmKt4JOnB0WDE/mI/xkxCU60yXDd00QLEDSyyo7cJ5V5WapLOt9iaxst2XOOnxXfz35BmDKclmQaf0wYO1gS3WosHVMtv8nzsIKdhcMXA3/UoI2FUO8MbfBS6saIAlTzbnxMId85r9ykHfyI1SMtIY5eT0uF3t74ZUuLYTnLtwRLW8q/A+G/EFc84Oyj6Ld0RJVs1oSb6a4GVjN3Gxwu87mJ7iQD5/ANDoEt4YyzHXr1hmJOtmWJJo+Mx4nc0o7tXUWnvrFEmA/LqlyR6B1Gb9kiTbFM8W0jYn/1D4NqZ5KWgYQwsp3ZLQpO1oQvup2Rm1lyS2HZkhEXpmN71EE8iLTfy+1MiJtiQqhHp4dJPSElHU2FNQK/iCLqneZlQk4xVyN1M9j75Jif9HUMd+pMNJlektimMGBVzEBPdl5QQ1hOQkAa2hXuFIB9vTpOZvSFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(23010399003)(7416014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjU5RUNsQnhTUGFTN2o5eFYwT3UyU2lpY3VpVzZNaE9yU3dzcHdUMlpvaTZO?=
 =?utf-8?B?dmtoZlVvcURqQkIxT3B4dGtIUFk4b3ZZaXhSbE0zS25qOGtKZGxkMFB6NndQ?=
 =?utf-8?B?dHV2dlRCKy94OTVyeHFXbU5KRC9US01STUlhdnFPMU8vaGVyM1dBdG9MYWgy?=
 =?utf-8?B?cXlQUDl2S24vajAzRjgrMmRXbXVPMnA2dlpqcTVubUplMFdKOWlCMittRHlU?=
 =?utf-8?B?MmFLKzZkUkJKZ2luU0hKMW51V0ZqWHFUWXhUaExvQ0pwcWI3MXNnSmdMZ3VH?=
 =?utf-8?B?cStpRjNvV2p0ekVQemhQZk9FNHZKSndqRm54ZldBNUtHc3BnSDhKQ0NuUlcw?=
 =?utf-8?B?Vks3NFpWYlZQUEZiSkpiMDFCbVRnbitqNUV3QkJ1MFF0MDJhK3hwd05Ua21m?=
 =?utf-8?B?NVJUcitSdDIzUHE3emsySHJIT0lhWEl0TmQ4SnRsL1RVVmg1bzlTeUwvZVFX?=
 =?utf-8?B?ZER1K1ltYWE5bGN3SGZqcXNRVUZFbVFiYm5CQ09udU5Bb2JjMU5HK1doQjZB?=
 =?utf-8?B?T1dvSGVDSWFaUGVxUkZHU0lLdUt2MHpOVTNCOUFHUnBMbk5mR2tzN1UzMUlH?=
 =?utf-8?B?aUdlWWV6RXp2NGk1Rmp6VjNBS0R2VmpmaGxQQndvTGFsK3hDdHk2SjNJS3Yr?=
 =?utf-8?B?OVg1KzJobWIxd1E1by9KUkRFczUreXpzSlcranJ4ajl6UEpXVkdBbThybHFX?=
 =?utf-8?B?bjV4TGpNSWZLOUNPWng3ZUpXMFBXdGs1d3BLY0xpMWdVMGpTR05ES0lCb2JU?=
 =?utf-8?B?anZVaUxodnExeW9kc3pxMlFFVVZ0TlNNS0tOTDU4NFlReVZUaUlWTS9PMjNv?=
 =?utf-8?B?YXVLakdJM0N5Qkh0TnkxZ2RZNmg0T3YzWXpKaUdmcXdTVEhjZWhrYWpnMkc2?=
 =?utf-8?B?bm5LWSs2NFFPdVBVdDdPNTh6aU1uVkZsUTZkOXZySXlJRm5LWGo5RHQxY2hy?=
 =?utf-8?B?UkszNmhnSVdTSkRNQ0k2RDJjS2dGVFpQMFZZa0dxM01GSlBYZUtsYXdLeWZS?=
 =?utf-8?B?RTJNRlg4OVhTTG5hWHJYTkw0cS84L1JlYzdxZENjSDlmbnVvUjdxcEJsR2hs?=
 =?utf-8?B?U2JYdDgwQ0NkYWxYWjh4UlpTOWhheVBVQ3BHU21XSjkzQStvTFM2bndyazJL?=
 =?utf-8?B?cEg3ZXhlcGMvOHJsTm1qc3BLd0tBbEZ4d3FIeE5qdGRTeklhc2tGQ1VkL1pp?=
 =?utf-8?B?T2Q4MXpRQ2J0NEhTU0JmRGdadEJsM0tETVBRcEQrMHFsTzFkYUZDWlkzaHdl?=
 =?utf-8?B?c0xrZGZJc3RaQXBSL0FvMjJqNDl0SzN5OFk1b1VrVVVvUXNRd3ZId1QzUHhk?=
 =?utf-8?B?NkUyNDhqNEl4SVphaEMvZUI0RkdlRzhEbmFwWmZJa3FjWUhLT2xlRjZialNZ?=
 =?utf-8?B?TVg5aTczL2hucVQzaWlEYUxoUWxjeUduNVJzcjNmYmtnVSsyUFdhWTVSaGF6?=
 =?utf-8?B?bFRoVGJhbUNSbm5acUl5eVpDTWl0NGJtcTVNNGNxMTJ1amxPaGFoc1g3WXJH?=
 =?utf-8?B?enBseDdNMStZM3VPc2U4SXhBN2s5Vk5yVUtRMG4rVDljeHlOWjdSNUdwMEFl?=
 =?utf-8?B?bGVEZU4rUFlMRHZiWFpMUmk2anp6L1hKUVF5cjBiK2V0a0NGZ3FYM2FuVEI0?=
 =?utf-8?B?bnFiamZNUDNsSU9Xd1FhWHRXdnpseEhjc0tyL0t4YnIwN0lFYVp4ZVgyeTl4?=
 =?utf-8?B?Vk4vQzlKZUVrN3dFekpjYkppTERhVXdldGROZFpnZFVMWjg2dUpEY2hHT01N?=
 =?utf-8?B?dlJZRGw4YThpTVl5TW12VERSZDNZY3pyRFVnanR5Y3FlQ2d6bFNFa1VZUXJL?=
 =?utf-8?B?OC96OXBzL3ZZQlNEN2VNQkRxWjVkeWszTHcvak1aU29EZmlaM2ZKM0w1aTlZ?=
 =?utf-8?B?YnQ3a0lEZUh0SStOWGNobkxDVENwaWhjM1c3KytlUGtWdEc5YXJ5eHcyRmFG?=
 =?utf-8?B?eE8rdjloZ3hZMnYwMis3VWpaekxqaUd0czFnQnVrK0hRRzlKd2ZXZlp6eWY5?=
 =?utf-8?B?a1VWTzRMcCt4T09xMzhjVlJ1a293T1gvdmhURXpTQm9QL0EwRFlkUU5xUUlU?=
 =?utf-8?B?MHAzcWFKYXlXV3hOd0tsQkhxWkpaenhEcWs4NmluOStzNzF4RUVFODNsdmgx?=
 =?utf-8?B?Zi9OSjBXZnJCRFNyczU3cnlOK2tSODk0c0toNXpBUEF4S0VCRzVjZ1hwYlF1?=
 =?utf-8?B?K05XODhsY2prTitNbjkxUWNNQnhVbEVzYk90cU0xRUNyVkR3RHd5ZXB1Ym0y?=
 =?utf-8?B?SlhpRzBwbTAxd2RMUDhmR25TWEExY2cxUFVsVjk3NHpGdURRNW1nbmNWbEF3?=
 =?utf-8?B?U3VUQURudTl2N1VPZVFQU3ZDd3AyMnZNcEp2OVBOK2trOVhBN1ROQW81MVhY?=
 =?utf-8?Q?s1LFBFIU8oflxkgnK1OyjposLx2TY87eRZC4q9/N0666i?=
X-MS-Exchange-AntiSpam-MessageData-1: boVzM5j7UFw9Ug==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0725a73-dbe8-440c-7c1d-08ded8b18011
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 03:16:40.4571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIcUQ0a3Xb4n949cgUmlczmipEFSCWmhiTOP8h/cQ2/QYhERN+7fSOMOrWT5AC+ruRThOm9BJcNLgcZ99ncvxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9511-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C4D06FE255

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
<...>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index fcc7678fd9e3..d1c5f0121994 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -6,7 +6,11 @@
> =20
>  use crate::{
>      bindings,
> -    prelude::*, //
> +    prelude::*,
> +    ptr::{
> +        Alignment,
> +        KnownSize, //
> +    }, //
>  };
> =20
>  pub mod mem;
> @@ -31,6 +35,57 @@
>  /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit archi=
tectures.
>  pub type ResourceSize =3D bindings::resource_size_t;
> =20
> +/// Untyped I/O region.
> +///
> +/// This type can be used when an I/O region without known type informat=
ion has a compile-time known
> +/// minimum size (and a runtime known actual size).
> +///
> +/// # Invariants
> +///
> +/// - Size of the region is at least as large as the `SIZE` generic para=
meter.
> +/// - Size of the region is multiple of 4.
> +#[repr(C, align(4))]
> +pub struct Region<const SIZE: usize =3D 0> {
> +    inner: [u8],
> +}
> +
> +impl<const SIZE: usize> Region<SIZE> {
> +    /// Create a raw mutable pointer from given base address and size.
> +    ///
> +    /// `size` should be at least as large as the minimum size `SIZE`, a=
nd `base` and `size` should
> +    /// be 4-byte aligned to uphold the type invariant.

The second part of my comment on v4 was not relevant [1], but how about the
"should -> must" proposal?

Regardless:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

[1] https://lore.kernel.org/all/DJ9JE3I9MCG2.2G88FWQPWRBH3@garyguo.net/

