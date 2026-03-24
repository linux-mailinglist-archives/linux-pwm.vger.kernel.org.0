Return-Path: <linux-pwm+bounces-8348-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJjrKjgXwmkHZgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8348-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 05:46:48 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACD33020F2
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 05:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 990EC3038F70
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 04:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1971E20C00C;
	Tue, 24 Mar 2026 04:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sxfNSBd+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51BE573;
	Tue, 24 Mar 2026 04:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774327606; cv=fail; b=vGPIsK3D4waKo40YtC5qtvjcw/MOSRYv+XWRNrMtoZop56m6h3S6U0abp1NPUmberOe8snR/DpJhO4uiOHMrKxRVWIewecQp9jnH/RruwYgQGgBDLXWbIN68Koj6ojA4Qfg47c27Ro/yZBxDWO/CtOdKp8WgO9331QSZeXL9zMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774327606; c=relaxed/simple;
	bh=w6KDi+jrwiSnDX/jlbtbYgtfijKTjHycMZKUxJwC7is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p1+fFR8PJjZXxfR0rwjFbUNuQUhXb8FpbI1CiYxpO5NCQNZhWNsfmaqfA55m2Eng3D4EFGSBTfXJpmMDEvEkNPlM0c2bcNCUVSSicX21qo8AuRZLVIfDsbCfxJS2ftTPiOkgI8pgi743pUrSs/DghrcDpD9o9rnn92rWFsftMV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sxfNSBd+; arc=fail smtp.client-ip=40.107.208.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3Wne38O9okNcQCW8DYtb6IvThCHuLPbI6hTQ4jLd6oWVG5jZhFc9inwvPvnTLSnY07eVPwftyU5BFFBpqcaqg7kt5cCfLIdUrFss0IT4B1Wr5PH14US4HxwpZGGdsOEE6NLdalf50bPIPBwthJ5pU1w2MMlVv3ecRUq830NFveFmvwUoPlSwrs4+PE6VfIOEyTcicWWQzMntDW8Ikzn/zx10C0EJaGnj62lo+VefgU9UVUnNwSbBn8Vkw60tdJt+N3IdTC1egyFKbGq34CE3hE/ulcdS7lHNfC6g/5i9cs3s1atcPcSe6aibNy60us2B0IOcsB+hR7K38a7nH0A1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CDTMRY9guxWHUTbc9VzjJRNlLyqkQy0HxJ9eo1xK5I=;
 b=hQqNG60BLmkXTGLyrLGg9SmjDvaZl43I/dDKoZxufiwvnzzrkbWuTgVf+gk+0ThB4aAuAhABYOq9wQNWhhSBOu8fIWUPzB7quI2DVSahdB5hkzt4vwYjQa4kT3f0hvFwhwoQWy8DtGpa+UZFOLMND9aut+e5+7iGrzqiGVb2Z4Ie/Kyu93LIVayXAJV9YyKQQra/hqaKNOwyhSk/Y9+TtHHUYtbn8sJ440PlFJ4ZWqBNwi4ViOi9J7UK0+v14XtYAcpS1yJjrlnTlptHx5r0RGpmV5OTtCY08+fNHN0w8DlLSyAjF7t9IaVYfHB9LLzaNP2PC04fIlLyk81aCKF7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CDTMRY9guxWHUTbc9VzjJRNlLyqkQy0HxJ9eo1xK5I=;
 b=sxfNSBd+3vF17WZqrd6IiWQzYtkTJ+l+sGDO0x/t5DDsCzFqjFsprmqgkkhAA4Eho4Ql9BDkoKeOq4QKaUlH/ZS8wltk73CwVmt0Pjm1LxeXrYyyKYtjbyb0mi19vNbBc0YJSY6yEKjQB4Jm3Uyz/ps0pDDe0BdMe+1O5Ny0VHyF92aGajgP7kOhh1ke0PjiBpJZ07xSKeQ9uNriPWzOWKwkFZqMMmrPNC2y7Sm0HWqOpTEPcSQXl61YKvqM+ICnS1c8ugKmJBbwL4jSrOOVQbbHncDVGWhJSuZXu+7mI5QLXIg+gW/aKXWHxtn7QPZxPzliSK82yJ6C58LKH/2pcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 04:46:41 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 04:46:41 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH 0/5] Tegra264 PWM support
Date: Tue, 24 Mar 2026 13:46:38 +0900
Message-ID: <3835105.aeNJFYEL58@senjougahara>
In-Reply-To: <26c43bb4-d6d3-41ff-926a-597ee1392e83@kernel.org>
References:
 <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
 <26c43bb4-d6d3-41ff-926a-597ee1392e83@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TP0P295CA0054.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: accd9743-cca3-44a0-5f78-08de896057cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	89sPv2DeG3kMlpVHhzsQU/JbarZnZFr0s2BgpzDtHXDPNhAx2sIQBqsLlJaIpziX58Rb5V1XF+uMAq4t2vtUZ4v2pkMHO3wL+jqGWG0zZxgq+dNzhKWM1oI43Jq/UpKIAmU2j21DZ6Y09LKmk9XSJ5oLSMixUV95OYNTJudGMPKAFwbH8R/DWEt5Nmjf1HOIoMnedGQBTKlOBYrTSvG/25l7J96f7ILWkWozKhCI88msm/Cwi4X7YEmnBs0Tt6lnTVDp8lPorrqpU1Kl4VtWh/mbfxxZe4P570bPtrPxnLxuoJnwhAAnMybxTopxDj+SimzCGQef5owaLchOcTSZq8fgDkLF4W326aGwT9ioWsWXMCRCC6rbqMSBERolSp7+rKPR9ATVReNn6+VKNDzbAD5lZxdjO+7vag3vlX6PYd1V2fxPO9ptbYyvVW5bYLA92Y8F0fJTssN9N4KGIyHU9Arqqr1ZXQrBKg4EVdLcP2fMzaiDAYMBLYhDvg7s5qvFoJNMRp/iuJf/fbQdYHURZvucVcNO+jL8oN/8x1zRrQyUiGExhlisstcnfkp3rxeoe9ROYH61TtF1XPSCX7nTOcyXpxU5gReMZBUKOcuDXLCeH2MWYjRDHqvcsX/HzhX1ec6ygVAF7iW/SkikJAv4kStPWTyIatSA5XG0pDnFtxghb4Bt6jHSdeT+dw1f2XQ1Iect9/BQ1hneE/pkcRh7Y4+0UXyq7kqcHiv0d5p2w3Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGF4RVZGMHY5enNZWnQza1ozckgxSS8wejhJQW5ITU1nZGZ0QTQyczU3aU4z?=
 =?utf-8?B?WnJCYTlNT0VmcmlIcS9hRzJaRElQRGxTMlZwL2ZteHFVRk5HWWptVUZ3SXRv?=
 =?utf-8?B?OUNUbldkSDhBRVF0d3hYZnFYOEdpalM1OG1nOGw4d0dGaWNxZTU5NXJ2UUpq?=
 =?utf-8?B?M1BKWjV2V250ZDZ0MFBUdlpSbFpwbE1GV3VHSU1CMFJYbDkvdldNTzhaRkF6?=
 =?utf-8?B?OEl5bEFuSTIvdTlJT1hwaEY4TFJUQkNmYjd5K0g2N2VadVJNc1gvcDV5dEJs?=
 =?utf-8?B?L0V3OW1aeWxhQy8rU1NIM0xwbkNJMFNVYVBwNDJhZkVkUzF5dWFQUWRIUmlj?=
 =?utf-8?B?a1E3VklPZThqQ0VrMVRhS29WYUZ1bENjVXlwYTBueVBiUmowNlIvbk8rUm8w?=
 =?utf-8?B?QlBmT0l3WDBtV3dVZEZadXJsQkZ2TXY2T3ptUDYrZitGbG9ZZXZKdkRvLzJs?=
 =?utf-8?B?N2pjektSWU5JcG9VT1VxL3JZRkt2WlNvMittRUpMMEpJS3JDRHZNQTBEYTA2?=
 =?utf-8?B?S2JUZWdqTWw0amZpU0RKYU45L0FuWWdWN0VHQUU4NzlUY3VPa1lCSWJta1FK?=
 =?utf-8?B?eUM4M2hxampBblczWXJwWnREQ2NEakphLzc1ZTFJdWdFZm9tb205d3g5SUY1?=
 =?utf-8?B?RmJsbW1SRGhFb1hrM1hhelcrek5jNzROenlkeG5wK0ZtZk10R0l6YnpvKzlM?=
 =?utf-8?B?TjVOdHlwNllXL2NWRjFuK3ZtNzg0amNxckdnbk1rTU9NcTVOVXJoYSs5dS9L?=
 =?utf-8?B?cURpemFHdXc2N2w3SDVqZThFV2V4OFVqVW9ocVVOWkF0SWFqU0FVNWc5ZFky?=
 =?utf-8?B?VXZEdDVYRGkvSllqSS9leHlqc0xsL0cwZUlWQ2NLUXBDOHBkWThwQ3N0cWZB?=
 =?utf-8?B?TTFzaWZWclNZR0VIS0dVdGZGVkpBc2tSbjdHbFJBRk1TN2ZRNW5vWTQ0QnlG?=
 =?utf-8?B?amJ0ZUkyMkE0dmNhN3JMdXhEWnA5ZzlRS2tWa00rRjJHTWRBMmZ0Q0Qvc2pS?=
 =?utf-8?B?Z2NNQ29SUVl0VmxDRXF5YUYrQkJ2emE1N2diT000SXlZeTQrUmJ6ZlMxUzlC?=
 =?utf-8?B?eHVYVlo4N3p4S01maFp3eDZLTFEvcFQzdTVzU1dOa2NEem1taGl4ODlqT3hU?=
 =?utf-8?B?MHZTZGdEOEVhQ1VYN1QrNTU5RHcxa1ZGY2lHMFFrQ1hpcElhdUhtSUI3SmY3?=
 =?utf-8?B?VDJWaitkb3B2VE1HdnpXTXdIQ1BnL0JyL1hsdXUvczRVRW9rN01uNi9KNEhv?=
 =?utf-8?B?ZFNpazRhVkRBVU0rMFpndjhHdk0zTlB0ZnlaMUZoZnU1bzFaNTVEU2VBZ0JO?=
 =?utf-8?B?NUQzdGEySG9wOGxvUDdQbFRkdVA5LzE4TEJVZHI3bW5OY1E4WU5PMmpWZjQ3?=
 =?utf-8?B?dERBSmduQ01tSWdTRGxDc0k1NUlBVUpKOEtXNW5USE8rdjhDWCtPc3ZsZ1gw?=
 =?utf-8?B?S002NWRRTTU4MUxOZzJsWFBTN1o3NFNiTkdCblVpTWpUR1lmcjlCWmdNb25L?=
 =?utf-8?B?S2lZWkRIM1hrT3ZhZXc3Vi9wbWZkZFAzM1laR3ZFWHFhYlFGZGUyUGtZUDVN?=
 =?utf-8?B?R0MranFqYTc4alFGQXJFZ3lmem1HdEVzK2hoZCtqTStKdW85ZFBPaHY5Rm40?=
 =?utf-8?B?VmtkWVB6ZHJrMk9OeklsWGxSVHNIOGI3MmI0QUY4QTI0R3VNWlVnS2hiaFl3?=
 =?utf-8?B?RU4zTnZFTmsrNFFxeHNSdGRoTXFuYlVaeFNxbThMS202bmE0eFFIUVMyOEh4?=
 =?utf-8?B?L3JuV1h2UisvNFpvTXJJZnR4Z3NNR2k4Rm9PU2ZMZi9SSEgxZHZIUjE3cDZl?=
 =?utf-8?B?QzVKZDNQTVpLKzZnczM5dkxGVnlURGJTTm1Sb3Q1c2NuM3M5U0FFeGJyY3dI?=
 =?utf-8?B?TlltMzdLTS9rS1ZqN1VJQkNOTGd2YkNUbFNCa1Z2WFFjU1EwL2tiYTF2bEdn?=
 =?utf-8?B?SmNGNHZSQ1lPWVhhSHBUQnJRMWtPYzV4Ulo2YnduaHFnTW9uTndGa2JPRDly?=
 =?utf-8?B?L0tqQlJ2aE83QTRDaW16SnhIOFpYQmpuczMrbVJYR1dseGR4Z3IvczhrSnNL?=
 =?utf-8?B?L0dIM3V0aXRCUGR5NlpBSGUzQ0tNaE95VkFpYjhBRzNOVklFalp2NU1IbSsx?=
 =?utf-8?B?SVNHYUdYN09Vajdub2lGQU9xUndoTEZkQkF1NXJXS1Z6R05xaHdrUFBKMnpi?=
 =?utf-8?B?MWk3L3QzcXM0NkdaOXJTV2thTWk1d1pLMm5RWS90RHdhenlYT1BuVDlaSDhl?=
 =?utf-8?B?Skk1dXlxTFNDSnhBT3BFR2RaS0dLb3VreFpHWXRHMG80bDhyaVZEcGJEV2ZX?=
 =?utf-8?B?SS9xaFpUQ1Z4aU1zWHg0aTRTSHpxVDJjZlg5UjRXMC9meEVJY3NiRmJ5UHg0?=
 =?utf-8?Q?U9aLkwn12/iucRySnaTlNfBB6te+MFi21i05HpRD6TY55?=
X-MS-Exchange-AntiSpam-MessageData-1: Zzp7RL6IKdv/5w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accd9743-cca3-44a0-5f78-08de896057cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 04:46:41.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iyk3G0WdVoSAHY/4wu6WT76fi6pzloky7f3X54hjlExipwZbe3SPPqGLCIo+HB9FpTopYo2VSKnrDjyVzlEvtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8348-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ACD33020F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Monday, March 23, 2026 4:24=E2=80=AFPM Krzysztof Kozlowski wrote:
> On 23/03/2026 03:36, Mikko Perttunen wrote:
> > Hello,
> >=20
> > this adds support for the PWM controller on Tegra264. The controller
> > is similar to previous generations, but the register fields are
> > widened, the depth is made configurable, and the enable bit moves
> > to a different spot.
> >=20
> > This series adds only basic support with fixed depth -- configurable
> > depth will come later.
> >=20
> > The series uses the nvidia,tegra264-pwm compatible string. Bindings
> > for this are added in Thierry's series
> >=20
> >   https://lore.kernel.org/linux-tegra/20260320234056.2579010-1-thierry.=
red
> >   ing@kernel.org/
> NAK, that's not how you send driver code.
>=20
> Best regards,
> Krzysztof

I will pick up Thierry's patches for subsequent revisions.

Mikko




