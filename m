Return-Path: <linux-pwm+bounces-9210-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMqEJ8FtGmpa4QgAu9opvQ
	(envelope-from <linux-pwm+bounces-9210-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 06:55:29 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F246360B466
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 06:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73025303E4C1
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 04:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E97B34750D;
	Sat, 30 May 2026 04:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VgpniMs4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3833F8D9;
	Sat, 30 May 2026 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780116926; cv=fail; b=KkgNwFRvFSp+9+ufeewXygydTuhuhRKYWBeXRST1GUaDucPKgHzo3MYY6VFicZoCNHcY2DbfuR6E1/zo8iiGexI6qLpVcvINaGCPH4GVHZQ7evvWSC3cnsjxOqMsBVAO81fzp9xRpDZ1mZp0oTu7oW3oJ4tHQQ5KJdmLIF3Pf5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780116926; c=relaxed/simple;
	bh=wjTIFVBYkk2yC6bIRLBysCczgnNig5OvybuRf5VGv34=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=QGDnm4aq8AmHzQPtJ0s5KSPBkFYa8u6XaU4kYKYST2XtH/CVOtdKbEQjLTK5Zlpf2xDxMzGjEHcE1lfrGc1CWn+QW3ZCJjcWdzIx8OXyVUhVoA4PcMmHrgQUu0vAtO/R7SZwJpq7Pm7r3AMilanzWCDGQp4MCCj/8tIMYSVmI00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VgpniMs4; arc=fail smtp.client-ip=52.101.46.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuMykGa/W0zxUjtziiUDxiddx/zN8GYnrpdMj2gZ1N+69Io5HHHFj3YUCDzEZK6PAgjNPEWSeS+blhbgUfgxs4VkB6JE3fQKYkV+03YnqaTzV83oLh1I65/2fxGdVqO7zSjZqG+/tshEeBS/slIHlEGJO03DAzsDGJmHcxQ0M+nxo9TJIoJIyrnZtisERLHT2H3brNfruvwZKMvHWuh6oUaS0bp09xo4zJddLXcbzPuRQZpRLv5O+53Ss1JxG2hqTEKcRVfRhQlWb8RiUuAsXEdK4DoAgHx0l1W8te9mfJqaS2WAyzzf+oXStsiyAuo7ncB0R6s7ppRCNXkNNKkJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjTIFVBYkk2yC6bIRLBysCczgnNig5OvybuRf5VGv34=;
 b=uGZBOmYv7O1wY7/qUKqrHZUs1891UrZg+ewPIwDk2+KnZ5tCWKv5XDWK0K0ICUE62hYKtzmexc6x0gJeN3Pnm+04DyaDfUUpoRI6jmuPI/XNyA1zZTo4GYztfa5M60VeVHh15eIXyECsxtk3BloCgbpwMG+WRFFVyBs3Y+FaWJO6RYsc4vKpbLhO+bfmQGkpNIC9ZvXYGeN4l9dG48LW5HEtB4PcJ4dUdJWdtVgrELd3AY9fKHUeqX35FMz/ce6jepPfObMMYEup0BadGnNw6fcofVXqVa2wvt7ZIc09h/NE7rV52U4Clc2gpDmbszwv19iV1SpyG5S3v2GIG8wFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjTIFVBYkk2yC6bIRLBysCczgnNig5OvybuRf5VGv34=;
 b=VgpniMs4ql9qyFw+36QygVf9sZFuj6aABwnbTMCcvBu5I6K/AAGjEZxDyepbsPLVwwfhjPckBpDIWq50m+MTuqwnCHCA/aF0zx+psUCdfh2eOadr+0vyXW0g7Qu1aeMlQjBlT2IpPxaqAZW4bw1S/16Wwvcn8B5TqisXMGVUJKiVFhEzJsDq3Y1oze07fOUlt+bbXO/IUaPeoDvs8yN0WvkEkW2lJMRnmy3s4gLrYWxq0J1VHVNmwN7a2H7rLE8PFlW01LQY53fe2VN9OCgergulm7iKQnqqdBZkbO22dqYkEa+KcJ6MaS/l/wlR4/2Ps+LRLLVEKb8o/346AH7uYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Sat, 30 May
 2026 04:55:22 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.011; Sat, 30 May 2026
 04:55:22 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 13:55:18 +0900
Message-Id: <DIVQS6VVK2C7.1LU92D1Q0C3PR@nvidia.com>
Cc: "Michal Wilczynski" <m.wilczynski@samsung.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] rust: pwm: use pin_init::zeroed() to initialize
 pwm_ops
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Francis Laniel" <laniel_francis@privacyrequired.com>
Content-Transfer-Encoding: quoted-printable
References: <20260529153821.126823-1-laniel_francis@privacyrequired.com>
In-Reply-To: <20260529153821.126823-1-laniel_francis@privacyrequired.com>
X-ClientProxiedBy: TYCPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e67882f-0630-46f8-1fca-08debe07a799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	midSA0m3h7VkDwFYWwXv3C4/NYo4ViX/HTztOsaiVNo78dTbvXFXrYTXB8dQD6s1mVYe2URf5w0WHn/H0fYxmpsJZIC/x06QggeUUySXZSzGT2559jaxAYlLp8TUX1tgVgNP8qfhataDFd+KqKbm6d+yAvVqwLmwWtfkRLvaMfNNxaoUi6Ig6PaHfketuWRvi8PXkka1TyCFrevWoKanpCt5EFUqB/Fjv7uLWGpWUzz5oSgq7BMuyoNm8axNG0MW+CqVURX37CcwD1zw/YShY/eLH4m9a0wZbo6GU3evEoPCAqsPYP8Fq8SRNOe5vHAPYRuvMBLBSLiydylln3N2HS5JewJotltaIbQ0w/3lPfNbp7MEIpI8tXj535XmFKnJR0eOx4Kx5Tby6U9G1rxrD8t0YPjg9V6z5kVwIii/5efe6H8Nr55hkLoo95tQ41aKjplJkmX9RWDpJXDWaFsfFi8VhkDO2X0vrau853p6EBrH0GOsUYSkQi2qF7vJs8XKmTP05CxxKas4gErVz7MOS3TCzN6dOhxkUYLnuY7YCQpwMYfNwQZGXqBw8rzWhFmkRTbFr7MlaygQa0fsSE02wtSLmpBigK7PiQ7UZrV7kB2dNMUyQ79UzvPECDZsRO8tM7wUgoNgkK+p+wGzcvly5cEr6PaYa/9e+lv3JxbGN0rSozLgozFXdlYc5VPjWvBhJVhGkvCS+aJsJSztci9/VA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTlkb0JiNE0zdGFXMnVvaGRxSVJMUUp4ZXJFeFJSL3lTRUtBWU04bXBPZC9T?=
 =?utf-8?B?ZGxEVDFxMVlZdE54SnRySDlGbnNXR2JaWkxweThNbU1ENG94dFowNDgwVTZQ?=
 =?utf-8?B?TThwbm9aWW95OFIrcHZoV3JReDlvL2RtaE96WWdsQVBSTFJ6MkR3Vkdubk4y?=
 =?utf-8?B?c1VycGxuOHNScXh2OFZCSHU5UmdiRlBTbW51K2NlYXhHMmJicEtqSHE0a1ht?=
 =?utf-8?B?M3ZtQjN2VERmak1ubDRCZmVUaUNaUU9ScnNwN0pSYnh6T1FPTnRsaElSZkVX?=
 =?utf-8?B?ZmFmRUVWOEM5N1ZUcEc4QW5VQUIvTmVUQXlVcDlYaGgwRk1Bc2ptMTY3NG5p?=
 =?utf-8?B?T1haUzQ5NncyMmxNNHJ1dTloSFk0bjBHc01mYi9Ma3ZQKzJqdlJOWU8yK3g0?=
 =?utf-8?B?MjNVdzN4N05VdGY5M3k5M1haTUNJUjFidVJESWVRNHg1SWpDQlFJeTFsV1ZO?=
 =?utf-8?B?eVEzblRZRUpFalpWK0U2enNhMm1tSi9tZ3dhSjhDZnptMG5Sd1hhQ2xsU3JH?=
 =?utf-8?B?TnJPYzlxdEVwTkdpWDF4d1JkSmZGSW9WbGdvenNDWTVIK0VEN2c3K2ZUamtK?=
 =?utf-8?B?bDkrd09mSzdHVVo4RVk1Q1JyUzY0YzRRRyt3WGZlZFZLNThaVVRHazZYa0Vl?=
 =?utf-8?B?ZnRMNmJXcjFITVYwMkZKcWE0MWNrMmNXUWU3Q0xLSHVPcUR5Y3ROYWRaSHZu?=
 =?utf-8?B?c0RLNVhMWDNiUmYvZXdIYUM0STAvNlpJK2k5TkVqaWV1QnVRMEFtNzRNaDlw?=
 =?utf-8?B?SkVlSHVkaVU5YWN4SlZPb2sxRjZUMTc3MXJ2UXFHK05kbVVlU0FhRGVSbnVB?=
 =?utf-8?B?ZHBUQVNRSExrYVhKb3hRSTJRMmt4cHNDUUQzeXBGc3ZqckJ0RWZHMnZBUDlW?=
 =?utf-8?B?VWE2WS8rSzUyWGZjWUNFMFQ1TWdCY3Q4ZDY2bExlYmdlUE9BNFNVcWIrdW5O?=
 =?utf-8?B?Rlo2cS9qWE1jVCtLTjViVEV4ZlZqeU1QcG1kdHFqb3gwTUZ6eEJqWHZHb1ky?=
 =?utf-8?B?eTh3WUwyMk11MnRvY2Z6QytlR3l3N2JJTnd3SERYazFnQVlSWEtOemtNb3o1?=
 =?utf-8?B?bU44aGR4dnE4ZTdkVkZ4b2NwWmt5YURsY1pIZUxDenBKZHZicjkxa29UR3Fm?=
 =?utf-8?B?c1FaZHh3RXdEcUZ2K0dqWkc3N3NQY3NuRkU5c3BOSXlIZWxDWmhKblFndHEw?=
 =?utf-8?B?bjAzdnJrQko3SEVqQ2hqYitJN3ZBMWRtZDlDY3NkZ2RhdmpzNkVCbC9VMzNj?=
 =?utf-8?B?WkR6VTJzY1BIQkI2Uy93eEwvR2x5UTFsL3kzMDZrVCtLQTZZZ1lRdUF5Vk9q?=
 =?utf-8?B?THgrRVdDM0p0R0dBS2xUV3praDlYbS9aNWU2Z3J1T3hFTXhQc1ZkZC9IK09S?=
 =?utf-8?B?WERpdmdLQ2tZZTExSGlPR2lRQVNVaHpKdGhSS0FIaEYrUnA5b3Bib2xwaW5U?=
 =?utf-8?B?akhMcnBZNTRWcU9QM1Fob2ZXR2VtOFloc21mbzJzeGlwTWlsUWMwWHNHS29J?=
 =?utf-8?B?UmgxbzJJRmVpOXErUFhreU9TczBMNGJBb3JyRDFEdjErTVBXUG45U1grd0VO?=
 =?utf-8?B?MytLelVuSmVUNFBiWWhzYUxGT204WGJOU0hXbjJ3ekZyMHYyTnhSNnRKSUZv?=
 =?utf-8?B?NE5CaG1nbnMyRUhCalIrVEpLRkR2RjBLdjNmaTBWV2o3Y0RsTUxCNTdaNHRV?=
 =?utf-8?B?R05wVThramhIdytHUTBnTGJRVWdsamk0ejVWSExDUit1RjU0bi9QL2xaN0JS?=
 =?utf-8?B?dnZNWktvN1E4c0J2bzhMbFFGTFdqYWVuNEQ1bVJDMjRZNGRleENYcnRYeFA5?=
 =?utf-8?B?MnNBbTZlSUJLaUlvR1E2TG1kWXNyaTEveDB1OWZHNVV5TUxSQUZRMUZTL3NB?=
 =?utf-8?B?QkhtUDhtdzAyUmZxTkJ3WXlEVWVxdFF0eUs0N1psSUc4ZkV0akpMQnJJcmpn?=
 =?utf-8?B?WFJRdmdxek5LdXpLRVY3WWYwb3A1OHBEZGhDUHgvNWJyV0Q4ekRFWkQzU05z?=
 =?utf-8?B?bHZKRVQ5Y1hUTWNVNWUwenUwVVJYVG8zUEN0bVJ3bnVxK3hqL29DL3J5Vmhq?=
 =?utf-8?B?VlVQSGRMVEtsZXRsalBjdjk3UWpjOWwrd0xQT0JLM2haYjlQdHFGWDJvOXY1?=
 =?utf-8?B?OVNURElSYVd4dzZLVGlHOTJNbWVOTUQ3R0ZvV2hOVGxucHJzRWM0U21mbTVL?=
 =?utf-8?B?T212VjRZRkdSanVYaHdNWFRseDY4MVVhNDYwa1FoVnBXeWd6cStRakRoMUdG?=
 =?utf-8?B?ak8rWHZ0VGJ5RVRIVUZqY1VGaUl6MHNRTll2QVB6eXY2cCtZS1M3d3MxZ2Qx?=
 =?utf-8?B?aWFiS0hoR203RjU4aDNzNituazdzcHY2bjhHbE8vbnpyQ1NHbWdvL1B3RmRJ?=
 =?utf-8?Q?P8Z9JoXPLCMvDVaRdhBxMZSpG9+4XmJkqCnFCCLwP/+rt?=
X-MS-Exchange-AntiSpam-MessageData-1: IuFKpxQ9fsqaVw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e67882f-0630-46f8-1fca-08debe07a799
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2026 04:55:22.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWZn88vZZtZtqnLiZ0CFpVKZ31hsrbFGg6+aJs7M8ZeXdRn0YkNys3UFCsFUf411HI+/5xWEabsccHQ6jKvCmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[samsung.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9210-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,privacyrequired.com:email]
X-Rspamd-Queue-Id: F246360B466
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat May 30, 2026 at 12:38 AM JST, Francis Laniel wrote:
> Replace unsafe block containing core::mem::zeroed by calling
> pin_init::zeroed().
> This is safer, as this function is guarded by trait contrary to
> core::mem:zeroed().

Typo: core::mem::zeroed() (probably moot if you reuse Benno's commit
message as suggested by Miguel though).

> Also, we can call this because all fields in pwm_ops, i.e. function
> pointers in Option<> and usize, are Zeroable.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

