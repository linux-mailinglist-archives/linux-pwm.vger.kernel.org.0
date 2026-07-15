Return-Path: <linux-pwm+bounces-9725-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y2H4NvsJV2oPEgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9725-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 06:18:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CADA75A6DF
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 06:18:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="sh/2JW8Q";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9725-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9725-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E7A9302BBB6
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 04:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C4C381B1F;
	Wed, 15 Jul 2026 04:17:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205B355803;
	Wed, 15 Jul 2026 04:17:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784089070; cv=fail; b=edORhjfhSkswz7bdcmploIi3oZQW1AXm/qirHeA2qqGS3fP7lCnrxvGnnU/nqd5gAzccj15PSODqMDKx4syeCZvk6369yUPsdXVlOh+p4GjhZcgMvoOYjBG4cs88VgTgDQf9WK6jd6pRr3No4JBPDgXdoVKchQC9dMA2SRzArgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784089070; c=relaxed/simple;
	bh=Fj8BszBd3S+JbRaV8hGvSeiDO/SyRVGHEOvqNu4JZmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZwWatcefjZGbuXvvsnez3N7mgv3P72vTxHgMgu/ayI9D2RwtEoOnh/BE6shWeKxrKC9NHu5KcgswU6W3h/pa1xhEuyUERmhXp35rs8a2suWUmOcMA9kNuWeYMsybxaoBrVzgI4/p1gy7igNyCJNKi8U3wsbUxdHrQyZ1cvWXko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sh/2JW8Q; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWaPNq/eRNRTnIqZDhThjcYBhR4fjAd3SllGYe8gk1/oEigtoqiw+clwp1qu5xvpDqodT0AyJZXLVImR26e3/oDZpXq3diJAHbEvkoli0PNmTEoMRc4KOZcs63iJZSoJIzdrMRBn1g2MMF5UQ0Jq6pXZm1D2h39nGvld+eSqFSj5XoDh3cHh8C0Nxho9KUE9aJ/szzitzXjud0yqq1x76J5QiH/LQeccEDQPAxeqBPK0oxpc5yRHqWMvflebR9wQu1Sx3z+43DvxawM5erTrhT9M+Ja/ilJTFHowHotOmBdIfOUPzbnSQRDwNdjiMXX7wmcpNqWGKjQHBRQ4GS5YOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x225yPaXsYSoLUj8afRhYQOaPRumjPgEeFFtV7MkLF4=;
 b=NAaXEJLlgD9DBAUZGOpLAN052h/lDeUZB1iZfUqtLyls8IlFU7uzT3o52Pz+swugzuztebga3nde+R6SekbB9UB0ET48AFuOo4xic7qBomFm4JcGreFoqd2fqqxJN/1YlYi8dxRKZXzbR0tg8otwQhssPwNJ06lYC7ELwQk9OnVF2UY+/SomDpKeosxQuJ10Tw0wgYwvP8x0xfdgU0XBcOXCYR/L/TMfwBCTwwGBhBagJRnU0rjfRos4cMV0UibFAVZepuHFVMbUsybtn4CZ7N4VInC52YDOSjpcRadFyXUH3pdccGK56t1hAQBZ7SdXdP/H2BZ6bsc9c6BdGfURxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x225yPaXsYSoLUj8afRhYQOaPRumjPgEeFFtV7MkLF4=;
 b=sh/2JW8QQk6U8/XSu6asWenbRUEYhorZkpmOq5DfPYJvI6K+ZWYruGbxlA/ZC1VAdT4/cDDu/X24Jr61l+Ct/otnxhZhkvR3es3hptyE3kHSIQ3CKgkXoYLSVn+TOYGGQIEt/rx2+eypkRNwPM/OYBi/gF0aVf6+xzhYE2szyNdQ7o9UTHHwD2u8yIH5TmjLs9bjxL9vrSjxSehN8uQlKhSdB76ODvd+ysxUTjFIfHx7zRFH8gsnC6XqM236nxKfxb7cIfHLi8fqoUt9Wqmt6C7uqCaG5c/FVhCWr0Lzae/9Oz5h8sbbt1HP3nEsrIqR73pONc+T9gLsuIlStL9dxQ==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by LV1PR12MB999327.namprd12.prod.outlook.com (2603:10b6:408:3f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 04:17:45 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.019; Wed, 15 Jul 2026
 04:17:45 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 2/6] pwm: tegra: Make use of dev_err_probe()
Date: Wed, 15 Jul 2026 13:17:41 +0900
Message-ID: <pvR2hytaSrSgvheXwlJ_XQ@nvidia.com>
In-Reply-To:
 <0080b5bc2e7268740216bd911fd2c2358f219dc5.1784030076.git.ukleinek@kernel.org>
References:
 <cover.1784030076.git.ukleinek@kernel.org>
 <0080b5bc2e7268740216bd911fd2c2358f219dc5.1784030076.git.ukleinek@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYWP286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|LV1PR12MB999327:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b0173e-461a-4c1e-4af9-08dee2280554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|366016|1800799024|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	mF7PyBxxUdhKHIykDmTGsgWCIsS7M0wpYI7f214Gxpa7QHErXqCu6WCravfNAyqzs6tp1e494GzJAPZ9oidCsFwgRN/b+xt5nZYd17qOUgtM3oe3uGuCF1NLeAhhDyPrFVXl9BfyAkYmnhzaOhCyEXjTUorF3rS9jS48woZqNyeSWDSdcVS2+xugrcfllGqxhX3OipRY/ozzFzHk4ZRUCmT0jKJLMXFnTrLayzUCgyK/oEXO47mIJsK3XkmuYy7VJ/5p1+pfTulunzaPjCLk8cq+RKWodVWKjI880b91j6ExKncsMChiwNvX4w/Y6rD1TtlpdV0hMHVhKurqHyymujTBZKrxisH4OI+ZxsLyiCRaQyEOoakAc9cLgJUJSM1D3Bq/SEygwFEe142XTWL9fHyZeqp6LG2ehNjVgK/aMZyquCPEf9gkUKhXJHernHUqsNOqCbmVexc6ci0wu0mUD1mQQqS+2xt3ZmSf++X6QiziyyoGIEIsl4TJzpZ3kL5Oz7y+KF1ktJh0Omvrg4fgLHE7hnM2q2sipwN9TDhW/o5/LZURxBOpuNkuVS4rV7rt1RouKyn3SVZTJma4jyysnVOk9krH9mJohlYD8IkBozUG2OBoZSwYZr7T3eG4zTVWUCo7+rSbgkIsHS14vFpWwbVFS51qP/7sxxmS182UlOU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2wyc0dod1hQL1QrS0tpQXgzbjExSytySmw3a29SWVA1T2Y1UDdsNU14RFEw?=
 =?utf-8?B?L29HNXJHZllUVVkwenFqQTFkRk14b2lhc1Z6OC9UanZxckhqWE4rQ0Jwb0Ni?=
 =?utf-8?B?U205VUI0TTYrOC9IV3hOSnMxQUlUMGlTVDVNc2NFRVhyK0FuZnFEWUhlaGls?=
 =?utf-8?B?c0U5aW14WkdsazhXTmFjcnFNcVNpSnkwNkRSTFJKY1pRblRyQUxnL3BaUHd5?=
 =?utf-8?B?NnlqMzVmUndWZVpsTEhPYllwN1BibkJoME44ajdTUC82NDd1L09ESWljbTZ2?=
 =?utf-8?B?M2Qvcy9QdEZIc05wc2JiOUx6S0plWmZ5VEwrSFE4aGxXdzdaMGE2MGg1cjRZ?=
 =?utf-8?B?VythdjNYVmdHVFhWNGQ5V3BraWdOeTZ6YXlhakdwWXBiYkh6UTNkRGJZeXBN?=
 =?utf-8?B?Wk8vdkl0bXAwWEhGVGcrck16dUFZTEQ3MUV6amI1dG5BeS9pUUtSUU5NeVZF?=
 =?utf-8?B?bTVTM2NLTTZNL2NhOE9iRjlWYzVjbi9VQ2kzQXZHWEdIK1BlSlgvOHVxbGVz?=
 =?utf-8?B?VExwTWpUOEowZjRKb0x0UGttOE9PRjYvaTVlTkl3UDlja2FOYWtCOURyMVdm?=
 =?utf-8?B?MzRhRDNzM0o4U3JaKzIwK1pYa0x2WmJVVGZieVQzOEI1ZWpqZWUzWEMwMDN5?=
 =?utf-8?B?Y0ZNUjkyYS9TUkQ3cFJOcmNpcThOcW4zM090QnlRaWhDeW5lYStzanZsMDFT?=
 =?utf-8?B?cVR5NEJKbE9OOVFTSG9JQ0Y2dHd3Z1lhUjYxYUhBTUlRSm00NUJvS3ZMblc5?=
 =?utf-8?B?QWF1dmU5WHdSTisxMnNNYjV2MjVjdFVIbzhGb1k1RDgwM1lyd3p6Y1hTNDdX?=
 =?utf-8?B?dGZ5c0JKNE02Vm8yekE0WmVSdDM4eTkxWGx3cFFZWmNnbXByQVBtNldTQXJV?=
 =?utf-8?B?Rjg0QWJTcSszeU03SkJoNGJqNmhKamlXVVJsU1BpdUhDbngrWTBKOTlPNXc1?=
 =?utf-8?B?R2NycEtMSUZkeDdZVnVueTM0VFJrWDFnZHZqSWZlUVJSQUZPRUJwLzJ6ZTVC?=
 =?utf-8?B?Zk9LUWY1aDJtYllMcHh0WEtXaGpFUDZ4OVFmbENqZHVmbFFwYU9ROWI2WHh5?=
 =?utf-8?B?SEd2S3hjZVpveWl1WmpMQ3dWdSs1amsyZmwzL1hpcTF5MnJTcDhOYWNDRDhD?=
 =?utf-8?B?YkEzKy9QejA3dkZ5YlpFSEhJWmR2UTlNamRlMERmSklhM1ErUkwrQm9aN1RP?=
 =?utf-8?B?eXQ4YnUza0tNRFY2ZVppVzZpQXRmK3JRRThPckN2TCtRYkpiRW51akdHd0tn?=
 =?utf-8?B?SFA1NEc5djNrUXhJOUNOUmZ5eXRiTnNKbDVweXQ1VUpWUWNxTXJzY252aTNL?=
 =?utf-8?B?QVNsNHRjeFlGSThMRWZibzhSUmY2V3B0ZmppYmFOcEJHRk9WejRBK2lSb2pp?=
 =?utf-8?B?bmI5dmdNNTRzdmRUbXNCRjJVdjFHYmd1MjEwMlBPWE1od2JWWkpxYXdjN2Yy?=
 =?utf-8?B?TGl0YmpNUlpaSi9sbXpCdGFBM05TbWhDYUhPbWtZOVNrZTdxZHY0N3p0R0pq?=
 =?utf-8?B?aXdLU0F5MHk5bjRzNUxScnhnOXNKVG1SYUkwT0pNeVYwaUJ6T3JaTHh1bkdV?=
 =?utf-8?B?NXR2cFcyTklGOFdJbDBHZFlPWmNjWUZsMXkwN1g2RUtrcEtJbkt6amdpSTFp?=
 =?utf-8?B?b1k3c3VxUWM1c0VVdkVxWkRMS2VwZlhjdFg1eFVpekFzR28raTNMbkFYaC9l?=
 =?utf-8?B?NFN0dTBoTXNMM0pvaHphWW5YNVN5SUpMNThpOHBtUExjQzNMODl6cEQvUFAz?=
 =?utf-8?B?QVF0TDdnQjcrTFBkTFU5bkFuZXl5TlNFbVFSL2dCTnJWbDgrTnlwU2V1UzJT?=
 =?utf-8?B?U0trWTlsVnBDTWhvaEZ2R0dYN3VwalFob3dnSmpUQ1ZQOHVyZDJjWm9tVFNB?=
 =?utf-8?B?VUFFV1NYQlcrV3Q1cUlBS0F3b2dZMi9hL0pFSEhCSTZMZVJOS3BaZ2NDVW14?=
 =?utf-8?B?TUhNSU82bFNyL04rbkRkbVB3N25JR3dKV29HdG1GYlJvTEx4b08wQ25WaCtD?=
 =?utf-8?B?YkFVV011V1lJSEthaGZDbFhvUmlpaWpYSUNLbUkvSi9pR3pFUmpIM3ROWGpo?=
 =?utf-8?B?eVhOSC9YT2NSQlBDdFI5cnlXcjZlU1Voc25XUlJiVlFiZUpISlJTT1JTV2Zn?=
 =?utf-8?B?NlJwVTVFRVluajZRT2k2NkhJdGdMWHhnOElnQlhsbmJaK0swdy9OQWlKSDA3?=
 =?utf-8?B?YVlqbmlkY0xBTW80WDFVK3QzSy9hbVVUdVp3TERwaHpxZkxXZWd3eVFmL21K?=
 =?utf-8?B?QnRjMzdaRGg3UW1xTTlleTV3S0l5VTNFWG1SSlJHOTF4OXlLYUtHeUVqMUNI?=
 =?utf-8?B?ZnpEdEtSMzFQQWR0eUZvaFZaTXZ4eXJIUkx6cDRsUVErSGh6MnhubW51a2M3?=
 =?utf-8?Q?nVZh1V1F+KjX4aQ40abPeyQTNsWn6J943uLpgG1wE3ddZ?=
X-MS-Exchange-AntiSpam-MessageData-1: zrAa6vqvrDZsPQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b0173e-461a-4c1e-4af9-08dee2280554
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 04:17:45.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqOiqkUcuCccwvAWo+k45YWsNjFtPZbUJi24hpVHGdjgxwvZpUebPd3M5V7bJvYXZoN8eYhLlASyirIgiUbvSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999327
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9725-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:p.zabel@pengutronix.de,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CADA75A6DF

On Tuesday, July 14, 2026 9:02=E2=80=AFPM Uwe Kleine-K=C3=B6nig wrote:
> Usage of dev_err_probe() is more compact than dev_err()'s, emits the
> error code and handles -ENOMEM and -EPROBE_DEFER properly. Benefit from
> these improvements.
>=20
> Also add a few messages in error paths that lacked an output before.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> ---
>  drivers/pwm/pwm-tegra.c | 44 ++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 53743f83869a..dba9a05675e3 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -316,6 +316,7 @@ static const struct pwm_ops tegra_pwm_ops =3D {
> =20
>  static int tegra_pwm_probe(struct platform_device *pdev)
>  {
> +	struct device *dev =3D &pdev->dev;
>  	struct pwm_chip *chip;
>  	struct tegra_pwm_chip *pc;
>  	const struct tegra_pwm_soc *soc;
> @@ -330,7 +331,7 @@ static int tegra_pwm_probe(struct platform_device *pd=
ev)
>  		 */
>  		return dev_err_probe(dev, -ENODEV, "Unsupported device\n");
> =20
> -	chip =3D devm_pwmchip_alloc(&pdev->dev, soc->num_channels, sizeof(*pc))=
;
> +	chip =3D devm_pwmchip_alloc(dev, soc->num_channels, sizeof(*pc));
>  	if (IS_ERR(chip))
>  		return PTR_ERR(chip);
>  	pc =3D to_tegra_pwm_chip(chip);
> @@ -339,27 +340,36 @@ static int tegra_pwm_probe(struct platform_device *=
pdev)
> =20
>  	pc->regs =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pc->regs))
> +		/*
> +		 * devm_platform_ioremap_resource() already emits an error
> +		 * message with CONFIG_HAS_IOMEM, so don't emit another message
> +		 * here.
> +		 */
>  		return PTR_ERR(pc->regs);

Same as 1/6, my preference is for curlies with multiline blocks.

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

> =20
>  	platform_set_drvdata(pdev, chip);
> =20
> -	pc->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	pc->clk =3D devm_clk_get(dev, NULL);
>  	if (IS_ERR(pc->clk))
> -		return PTR_ERR(pc->clk);
> +		return dev_err_probe(dev, PTR_ERR(pc->clk), "Failed to get clock\n");
> =20
> -	ret =3D devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
> +	ret =3D devm_tegra_core_dev_init_opp_table_common(dev);
>  	if (ret)
> +		/*
> +		 * devm_tegra_core_dev_init_opp_table_common() emits an error
> +		 * message most of the time, so don't add another.
> +		 */
>  		return ret;
> =20
> -	pm_runtime_enable(&pdev->dev);
> -	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> +	pm_runtime_enable(dev);
> +	ret =3D pm_runtime_resume_and_get(dev);
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, ret, "Failed to runtime resume device\n");
> =20
>  	/* Set maximum frequency of the IP */
> -	ret =3D dev_pm_opp_set_rate(&pdev->dev, ULONG_MAX);
> +	ret =3D dev_pm_opp_set_rate(dev, ULONG_MAX);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
> +		dev_err_probe(dev, ret, "Failed to set max frequency\n");
>  		goto put_pm;
>  	}
> =20
> @@ -370,8 +380,7 @@ static int tegra_pwm_probe(struct platform_device *pd=
ev)
>  	 */
>  	pc->clk_rate =3D clk_get_rate(pc->clk);
>  	if (pc->clk_rate < TEGRA_PWM_DEPTH) {
> -		dev_err(&pdev->dev, "clock maximum frequency out of range\n");
> -		ret =3D -ERANGE;
> +		ret =3D dev_err_probe(dev, -ERANGE, "Clock maximum frequency out of ra=
nge\n");
>  		goto put_pm;
>  	}
> =20
> @@ -379,10 +388,9 @@ static int tegra_pwm_probe(struct platform_device *p=
dev)
>  	pc->min_period_ns =3D
>  	    (NSEC_PER_SEC / (pc->clk_rate / TEGRA_PWM_DEPTH)) + 1;
> =20
> -	pc->rst =3D devm_reset_control_get_exclusive(&pdev->dev, "pwm");
> +	pc->rst =3D devm_reset_control_get_exclusive(dev, "pwm");
>  	if (IS_ERR(pc->rst)) {
> -		ret =3D PTR_ERR(pc->rst);
> -		dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
> +		ret =3D dev_err_probe(dev, PTR_ERR(pc->rst), "Failed to get reset cont=
rol\n");
>  		goto put_pm;
>  	}
> =20
> @@ -392,17 +400,17 @@ static int tegra_pwm_probe(struct platform_device *=
pdev)
> =20
>  	ret =3D pwmchip_add(chip);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> +		dev_err_probe(dev, ret, "Adding pwmchip failed\n");
>  		reset_control_assert(pc->rst);
>  		goto put_pm;
>  	}
> =20
> -	pm_runtime_put(&pdev->dev);
> +	pm_runtime_put(dev);
> =20
>  	return 0;
>  put_pm:
> -	pm_runtime_put_sync_suspend(&pdev->dev);
> -	pm_runtime_force_suspend(&pdev->dev);
> +	pm_runtime_put_sync_suspend(dev);
> +	pm_runtime_force_suspend(dev);
>  	return ret;
>  }
> =20
> --=20
> 2.55.0.11.g153666a7d9bb
>=20
>=20





