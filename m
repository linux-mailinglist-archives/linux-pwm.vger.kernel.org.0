Return-Path: <linux-pwm+bounces-8946-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL2EH0GOCmq23QQAu9opvQ
	(envelope-from <linux-pwm+bounces-8946-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 05:57:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FD85658DB
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 05:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2972B30056EF
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 03:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E42380FCC;
	Mon, 18 May 2026 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G567mi2U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865F353EE5;
	Mon, 18 May 2026 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779076637; cv=fail; b=H4BRVU7v0zlORtLmUW2Iv2qKngGQjsiHxOGEdoHSvzs28iwigJb1wu/gDFXDeQCo1dl3PQxfAa9Tf1Oy52zN69jXUUGR3eGqR3W8tkNVdGz99xdZnT9Rvl7q7yiLpPndheaBK1oRNDf2cholLqcDn6ov63hKmsd6YHn8XpjLImY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779076637; c=relaxed/simple;
	bh=m088YvL7e9vEIycI/93wrDyHVXxzlV+lHfIZp5lGsy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HtwMc95LNW3smv2MkvH7AhUSh7IwM5c7UW23ZXQ0d4+M2JEQ/4UckvFWj5QqQ2wEh+Fj9JOkzl9siUzgQ6JYVBZd3ecZXhzil0Z9jXMFJkb/sDWyOflRkXgnw6AHZ8I826cy0xXZ/AKsZoAfvSZnLRLRVufa2XL/LgiRS1nEqOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G567mi2U; arc=fail smtp.client-ip=40.93.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLNPiznfx/YgrWp4zOYCttrgb5JuUbn0EyK4rETD09hxtLomHMKL+JvR1+NV5vslT6P8aN+VI3c8PA7YM21n5noui9Kc0Hw2K5We0B8ndebkf/FaflPEjtdhaVbdIcDICNkHWpvm3aJIBYfe+47C4uzlepz+e27LA2flOtDimKL+qxW37komQe8GUXjBg5mfF+l31O/OKsTJTffeYXZeBuAO90+6EBmc0BxLX7tz+A2E89X+DTZvx0zXgVF3IuHAiuGRKwI/BYrfNgrK8UzIMpKOs48pUVHu4TC6j/PhlhVPZjd5kwXHQlHBtS6URd7xpZeJjxSWNNPTfGP5BRWOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmzVb0ZV79VNjoZO4REbbG5XUdmm1M7SR7j8j+/JRIE=;
 b=hFRF4UBATB8eh7j29M7ZbA62Cd2qVnI5JtZOha9diAee8saGZu9vjMuaDxH/nkbLgud7M9MV5pItMpmvbJyB0wfSC1sYz4O9ZjFe7xfT2d9TJXLSZf2eIwKXYx6t8yjLQTWiJXDTyqN46HeFHgzuCpkwZXclk/CLvPdFiL1oGhy/zsLcyD/RB8IEk4p8rEpAv+KFSGfsFEx9seOivUKQJdxCbmHL1XJ1o7xqJ6V+7Ll33RsLkEQ+Z7U29yFbWB2IxFTXzvdZynPMaTQAHbCE8zaBnt1mKXxnNsqRPrTGeygdZjL/NbOLPfZ+ZelNeNqWXq5mTc4uViLGgf6DqqrQWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmzVb0ZV79VNjoZO4REbbG5XUdmm1M7SR7j8j+/JRIE=;
 b=G567mi2UEfp1zH3KNjVzklARS9+9Rz+/ftmAjHuvFumSZUhXxkdUqCRATOqdMA4GycmYio7C9UuASBqmBSu1Phe+STTx8JNxIX3yZn+7tzG5dWjeCo3yDjKmIWvujICQVdlCq7byodQlzXuI65VY1fp+WIzItg3GPiyz1ltFa0i9nMFtmxkxbKN2n3k76dWWMqLFNkBYXLgGf+wY79HetqIyyw8f1ZlK+ElEk96mLTRY3ypj0gpeyKF6JuJq9xxK55R1Utm9Pz6QXe22iKgyRwfLkgAYjgRk2uP2FJajeZSAcyaZiLtEiKJd9MVcNko22onrlzqNx8QnWNKy8tN1rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 03:57:12 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 03:57:12 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>
Subject:
 Re: [PATCH v4 3/7] pwm: tegra: Modify read/write accessors for multi-register
 channel
Date: Mon, 18 May 2026 11:31:51 +0900
Message-ID: <Uh8IEZgfT7ycBHL2pioiEA@nvidia.com>
In-Reply-To: <agn6i8SmO-jwYNhM@monoceros>
References:
 <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
 <20260331-t264-pwm-v4-3-c041659677cf@nvidia.com> <agn6i8SmO-jwYNhM@monoceros>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4PR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:405:379::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: a78bea17-0ea6-4644-76ad-08deb4918a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|56012099003|22082099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	AULeUjgXS7Kc3f+Tu7KGmRrIxAHPS8NwDYo60hWk0WUkP8XF5ygnqtgPeiA9sj95+dPtwR2RvKvCs490Xi446n8FHcOYHV+recJ8cvkK6ib6fM/2Hpg7OdSjjsC1YcBVlYMeNtm07jcPGH2/TKaPo2TQxrIzEvumSg5rptaZ0Cy3NMjei7XdLRJO7A5W0q4Hmv6YlVSIHdE09CwrdTq7E/OXuJpMcGnD+5jPyAESZ1xinysh9GvF5cOL2sWGnVG6Y0vQ0poHtv5fTK6BpBhydtXt0+di7lJrb0hzBg07dCoiy6xJEbznycVTPThG+Rte+ZSm2CF0GKgEhbr8erLYhPaIdMhJnuA0h/JnfUBWlegjjyW8qi6x2tJyFKmz8P/gVlcKvUpCPbJTxcEdO7RH+2gIIBoTtyoQOh9qpCp8y0k17M1FRrFokU8WoZMM7t1Wwj+rbfrm/2/9rz9FNmNUejTfWeOqMvMnM4adkTpRkIlj65AK9yWdgRKXO2xE/D9yHd/eVKCTxdRzx/JcsVitCv5l3K6Oj3D2FyhHbYJbOiWebt/6bU7qAIisVlq6KJQ/33OA7Mv60bVywYvDUTQkIme/g/XK4G6p3WgQS2AgqzF/hPSZfH2FNWl9N+g1EX3kZK+6meSZUYOnFagtDeUt4Ys7kyL3MVPLlBRpsEn2H7UzLO9cOq8tiK0wKmvOdH8N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(56012099003)(22082099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3RWUVdwZlkvSHNLTVA4VzB1RmhBb1hPeXB0WUNrTkIzZHVaY3R3Z3hJMDhW?=
 =?utf-8?B?VlNuYmtBYkp5Z1gzK0RsVUVHbW1ueFNSQWcxbUp0OFVSM3V2TFVwanVPbGUv?=
 =?utf-8?B?OE9jamI1L3B6ZldwNmd1ZjYxaHFKR1JST09VMkhvWU1zcUNSMzZHcDhwVU9Q?=
 =?utf-8?B?OElIb3FmSktmWFJsT3JseXdtQXh5N2VGbjN5QkNPTGtmUHN1UXJhK29PTy8y?=
 =?utf-8?B?SUN6QndRRm5oNHpLOWU4WUdkMVI2RDVSbHlNUjJsN1BBL29EWEVPSW5MaXB6?=
 =?utf-8?B?YTJJVjEzM2lUeUkycURmNFdkalI3QjNKbExVZ1JPRitLZElCZGxaWkVRWGxJ?=
 =?utf-8?B?MzVsaXB5Z1AzTGVRbG1YR3VpOE51SWswSVE4VFNIYXZTSjZtejA0S1oyYU9Y?=
 =?utf-8?B?R1NHTDhHZHRRd3BzckU2R3E5RDkreEQxMjc5TE4yanlwVWhBWGlOcE91R3Iy?=
 =?utf-8?B?NEJQMHhNdU9Bd0p4YjcrWGNMdklicGJGRGEzYy9RRmRqSHVnaThwUEIrSEVa?=
 =?utf-8?B?dGZtTTlxdVY5WjhRSWNDckxNdWNxbkJMUm02ckZCdTBDRDJNZERoK1g4Y2xr?=
 =?utf-8?B?U0RVQW1YVmI2RmdXMFFCYnBlaG9HWEVqSE9kVWRzWjJrRUoyRW85TXRhNUxD?=
 =?utf-8?B?MEdSMU5DUmVkaWc5RnF2NTFqeFBsN3hISGNjNFV3Z0R5UjhLKzh3SHVsaC95?=
 =?utf-8?B?bUVaTnA3b2NJQXdxY050ZGFYZm1LakFvT1p3NVN4cGE1RDdsVzliQWZxOVo2?=
 =?utf-8?B?eW1udmxOZDIrYy8zSTJMcCtSNUJLbGN4RDBuQ1M5bXhFZ25MQXZSVGd4dUxO?=
 =?utf-8?B?Y1p6ZGloREFoVnNhckVNRFJ0S3BtSThMMENhQlpYMGZRWjNCamQrb2Q4QzNq?=
 =?utf-8?B?Zml6dmczUUZ3dkZMQTN6WUY4Y0w5cjJmbnBQblpXSzlJSUlOQ2c4WE9raFRB?=
 =?utf-8?B?WFltRGJocTdkTHRkNWRkN2ZEQS92VUNydXFKb3RVc2pyOTFvclhTOFZzQUZu?=
 =?utf-8?B?MThwdkpsRE1pZ1krNGpGc0R1dklsWlVkc3RLMG5PUnd4eUhyY0hZNmlIU1Mr?=
 =?utf-8?B?Q1pnaXpTZG5TV0doS0lGOEI1QUhPeG9mWW9JUkxrclJtczlhdDNhL3o5enpm?=
 =?utf-8?B?elFhdGhRWk5hR2J2N0ltUkE4TEk0WjlvTHhCWVBNdGJiSkk0SlJzZHlXQ0dC?=
 =?utf-8?B?UzY5RjBuU0Y3WkMwamdVL2VmVi94MzBnNWZ6Qkx4Q2pkU3NGcVpaUjFCUG45?=
 =?utf-8?B?c1VNM0tIdGJVY01yam1BdUlMVWlUQWFhZ3Z4bnY3cGxoMEFSS2VkU2hRZ1dv?=
 =?utf-8?B?N1V5QWFhcXhFd01aS2tlQkpUTEpCYkhtK2dzSWpLbFFjayt5clp6UEM5S05t?=
 =?utf-8?B?WGkyRGNWNitoV1hXYUR4d21iYzAyc240UGdLQ1owT2p2Nzg0cEVLaFZjcjVG?=
 =?utf-8?B?b3lnd0piK3EyTGZIS0JKYzFpMXFscVdUTEN0MjhuMWhYODBLRXVHMlJvWkNu?=
 =?utf-8?B?OWNhejQ0K250LzFzanVQcTV5eU16enl3RFpwdHVJODZCTHU2c29IQWZVSGUv?=
 =?utf-8?B?NzJ0TFBBUTdHUS93V1prbVNyTGQyQzcrOEw1VEdvNGlQejZHdG40bEp1SWpH?=
 =?utf-8?B?S25Rdldrb3N2d2tmYXpXU082ekN2eERadWNQNG53NDRpcVRyRVNwYldHT1ZT?=
 =?utf-8?B?MGVMcndDSGZCbU1TMXgzeEdRaTQ3MTdKb2xDSGJUR2lWUjhCUUpGdWd1NGh5?=
 =?utf-8?B?cTd1dDgwUFlEQmxuZGVwN09uLzNWQVZha2Z4UkxJM2w5V0FuSkg2RmNhQml0?=
 =?utf-8?B?VG9mQlUzKzlOZWYvbHJpNTVsMWdJa1c3RzRlZXplUkpkSUNRNGgrODRlZ1Vu?=
 =?utf-8?B?bmdEZ3luMVNZamNmNHV3eElwUGpxWnU1bS9rL3RRaENGY0lOY3J6NHV6S2Nj?=
 =?utf-8?B?U3VvaWtXUjZSYlovVmNqSE15dU80cDF6NW41WGIwZzlIdnNSNG1IbFppUXZp?=
 =?utf-8?B?Qks5VFJXOW04bHZ0VXYvV3FxKzZFSGNoZ3pFY0V6dzZpcEtYMDAvUm9CeXVN?=
 =?utf-8?B?eThJQ3pLbWYwcU11OWVVMU9VOUVYdEpkM1NLVk1TMUozTVdZc01TOHdGelR1?=
 =?utf-8?B?c296ZmJBb2lFV014RzlkQkJuOTM0SklCNkdNcDRSaHZJT2FCVUlVMU5VeWhx?=
 =?utf-8?B?VXlVckVGaHhHc3lHdzE0TmNRRXBjOUFaeGh6SGUzaGJ0cXBvWmZXbTdqeUdI?=
 =?utf-8?B?ellGQU9aYXRNYXVURWY3MXM3M2VMcFJJMjBNOVNlQ2taRG9JWkhDZ212VTQ5?=
 =?utf-8?B?UDNQOUJ3bVMvZXl6MFNJeTg4alFQQTJUQ0hjcEhsRWVkdTNiZE1vbS9SMUtX?=
 =?utf-8?Q?XW6U0PrpPdwFNcls9gNBUphcph28vDVM0/A0D5ZHzpMOC?=
X-MS-Exchange-AntiSpam-MessageData-1: MKvkfycfghZ2hA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78bea17-0ea6-4644-76ad-08deb4918a6c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:57:12.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLvzCbuSvYlO4l00oJwRNMCd9SMXu7ZXCyK58WH4BOGpxLN2xwBJQVcBeuaUUVMmAAXon2SHEpTF0NiLirBAxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
X-Rspamd-Queue-Id: D6FD85658DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-8946-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Monday, May 18, 2026 2:30=E2=80=AFAM Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Mar 31, 2026 at 11:12:15AM +0900, Mikko Perttunen wrote:
> > On Tegra264, each PWM instance has two registers (per channel, of which
> > there is one). Update the pwm_readl/pwm_writel helper functions to
> > take channel (as struct pwm_device *) and offset separately.
> >=20
> > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >  drivers/pwm/pwm-tegra.c | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index 8a330169d531..358c81cea05b 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -57,6 +57,8 @@
> >  #define PWM_SCALE_WIDTH	13
> >  #define PWM_SCALE_SHIFT	0
> > =20
> > +#define PWM_CSR_0	0
>=20
> Is this a register offset (of the for now single per channel register)?

It is, yes.

>=20
> One thing that bothers me about this driver is that the defines are not
> prefixed by the driver name. `PWM_SCALE_WIDTH` looks more generic than
> it is.

I can add a patch to prefix everything with tegra_/TEGRA_ for the next
version.

>=20
> > +
> >  struct tegra_pwm_soc {
> >  	unsigned int num_channels;
> >  };
> > @@ -78,14 +80,18 @@ static inline struct tegra_pwm_chip *to_tegra_pwm_c=
hip(struct pwm_chip *chip)
> >  	return pwmchip_get_drvdata(chip);
> >  }
> > =20
> > -static inline u32 pwm_readl(struct tegra_pwm_chip *pc, unsigned int of=
fset)
> > +static inline u32 pwm_readl(struct pwm_device *dev, unsigned int offse=
t)
>=20
> s/dev/pwm/ to match the variable naming in the rest of the driver.

Will fix.

>=20
> >  {
> > -	return readl(pc->regs + (offset << 4));
> > +	struct tegra_pwm_chip *chip =3D to_tegra_pwm_chip(dev->chip);
> > +
> > +	return readl(chip->regs + (dev->hwpwm * 16) + offset);
>=20
> Best regards
> Uwe

Thanks
Mikko




