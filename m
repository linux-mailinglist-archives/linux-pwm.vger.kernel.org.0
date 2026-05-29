Return-Path: <linux-pwm+bounces-9195-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id y+0HK37/GGpApggAu9opvQ
	(envelope-from <linux-pwm+bounces-9195-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:52:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A25FC841
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE95F31811F2
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 02:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9815C369D4A;
	Fri, 29 May 2026 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jeAEeuLm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55A369D55;
	Fri, 29 May 2026 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022884; cv=fail; b=CMkAS7ZL9mUunW4H/anPsxwhMbpKks3SrE1a2My9e4/onllnOA29LOM5K6jcg6ivudZybItUnK8yicNU2c0KB51riXaTL3QxRfnUVZKpHrVxYP/SdNcZjbti8VnTbNjsurHCpApq1wxDeJPCOxo7sgVaUkzu2igoq7E7qPIB5ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022884; c=relaxed/simple;
	bh=JiJDRqQrkJhb2emgWX/qFUFJvl4VVotcgLyJkuuiPwE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ezv4MZ0Tbdv/jabJGYUf61QYcgvPb+/CCkBVZZKW+bVm8esqDjYoet2IDBJSwsl4LfOcGlCiURvdvWmSWuiVkgPu43Bl+h2WuQjKDyW0hsB7F1FIDdgOO9zYFqcFWU+WMQvWYYc03eypur3bs/kzEe2dok8tH9wn45FTPEVv5ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jeAEeuLm; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InOAdx1sKOgPhCf3DIZkhQVyCfIGjy6+/F4QhCpxbJLVU91nyJ7huSOg2CrJRZflMsB7gkumTjIS0fz8nJ7Z7jgwJqt/hrHE91V4VUBtgqF5wFDzd6szVFWMTdh23ch/ovExkukCxtSisz62FikA37nLUPQ6SbPXB86c+z5CoUXOQNAfkuvJFvZC0ZrSxOMYFbTC94m37NkN8YkHxNDOMCtCK/dSP+IC+VAtgN4D6dP2WbkrCUMOVy6QThsppzxhi+QwjrXZIxQRXusWld2GohhIzI0zbToyffOBiCJp2LIO6mudEqUQnppw0zX0cW1QYrHo865xcdQXUQ39GkawDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZwXjpWmd2/O/kZLVgRRXDuL9tADiQ1Sc9GC6GKwQ7M=;
 b=rspsU3ZmU8CCPfjIEa980M/8PJhoAiVQ3s09uapnlHeAwnFzt3CrtegeRz5elAolJbWdHu05icUfxyE9/R2Mb4zjj0XEJt0JMU5ITsq2Z/eAUOOe+zCs/NVoMmlrA139rM+Snv/V7n5ezLZakzQJnfhLQyQmDC09QzAvzu608ousAW94Av3+Bw/VyZ/6SB7qD8VlH7BPUeGUxAWi+Z7nfu7nglTUBVv9fR3B1V/xDSXW7Yg9TMy7Dekvz54bPk7xEc1bxB3yrkDj+wwIuld6fYrpJdq5o7JtQfAmDhOSfztc5nZlIQSALZoOC/WM+30GseI08arBM/kh87irTqQuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZwXjpWmd2/O/kZLVgRRXDuL9tADiQ1Sc9GC6GKwQ7M=;
 b=jeAEeuLmypSCPSudjfTHDoCrxiuGlBlFqV3eJBe8KM9NEPL0cThfYLkqp/F0d2PpCLH5gCbNap2HJy7SrY8IDs1E/VmYTIdrIiOG3nzynnLtqEe+m4Xr/LHACZQQltER+XAjfcZdSHfipaYzwUEOmtIwODRvZwt4uQKOto7HrVSh/I0LpKwg30lT8Mt3sJtJb9yO8OgYuWL8baXn1LtbkJbos6ONYiirHQV7bdtG9ZjyIn/LO7pgJcW9NGKdhN6a3Jnn9DJFLMlRiIZRVbE6oS/JFQcqMIk9e+TsKSiayno/mqjBmuDee3h9g8RRg2QbKJGuX+M3GAW6XJ2uhLssPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 02:47:58 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 02:47:58 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 29 May 2026 11:47:25 +0900
Subject: [PATCH v5 4/7] pwm: tegra: Modify read/write accessors for
 multi-register channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-t264-pwm-v5-4-7bf9e405a96a@nvidia.com>
References: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
In-Reply-To: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4P286CA0085.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8feae5-5214-4434-bf45-08debd2cb0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|11063799006|56012099006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DQhysETezL8YLo7dWHoXu7x9tuZm3CqiKEX/Wu6TsSBjTtU7tZzgUkF/+lUogD+5/Ks4jFeO8anmb0ZPOqaKNEYP0rcoYaulVTZquKoOCs1EGMsw4kgwLouoZixgN+E57mGtDxnMmk0xIHHZEuKIPjlmey0t10cinvO4mUEbnWLNIO5L2SAC9epQRXTLyp5uIf/eJMmxdq0b9ihiHEM7kSONaQ7TIpd3zF7q45EYg5MBZ1zUhRpdjDfXOSoH5RzJ6YFXdhdiBZm1zEu01Ql1zdefLNb6T6zCkUgZjbpDluupJoA+wnBaPa/4AJ+0NOAOcSQeNcKtj1yTDx3xPKs3aC9c7CERAm25VJ9kl9vOzFm9QJCml1jRRoDcDv1XpW93aY+YJ+WClDUxb7zka9U1cYwP9dl34Ct2DFYsEsh95jd2uR3I1Lqt9ScCPz3z5GJD2/FqDoZbVizhhnfDzW5iGTtdDno9b0KpWPz3nRwyE+8ifpB+71ucATo/bg6kyXTo7weqwHb/T2roC1SJ+dR6GIaRYzDP0QMFKkIFTTYUIrybgMR1fbTnNlCeLMj5tJg6SJNgK/CTpRR4v7ik7CXfz+id4ZFKT+L5SqhjEh9FXd0fR76piGU1lXEqo4+7rP8hS7st7ptt5yY815VExyz5EnBy7EOZbNHTHmK4P786FQXAD2Ylwv7uchpA8hWsTHXt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEE4MnNkWndlemtONzVDaHhPN0lpeVpISy9qUmpKUEJjeGQzbnU2R0EyeUtw?=
 =?utf-8?B?V0hIbW5HL29MRjV4RHdlbGM1Nlo0TmZYWEFuNVhiM1ZTa3JnVGMyRmswK25S?=
 =?utf-8?B?aW5ma29KM3hCdU5KY2Z0ZXRKMnVJaFZBL1J3bHg3WGtaendrYmMzeTJsbmFh?=
 =?utf-8?B?ViswUUtDSllpQThXdmFPNEx1V3NwN1NsbTdKdGlnSENWaHFxQ1B2OHRoTGJ0?=
 =?utf-8?B?dVg0aHl0d2R6T01VM1VjK1YxZ3lidUVxZ0FpZDZxazk3T0VnYkQ5Z05pM0hz?=
 =?utf-8?B?R1cxQzJnNmY2bFo4U2hiY3pkUkVlcnNmcWUzK0lyVzFlVjFuZXZERlRHK3hx?=
 =?utf-8?B?dDRzMVRoYVNpVUN6U1JkWE9pT1EvZENKSHRaMmU3N1RsYnFPeEFMS3NQckZ3?=
 =?utf-8?B?VHVhaldxYmlHYzBudy9RUHFrdm9zMnRDNmRWeFBaeFNQQU5NTERnaU1jSGVz?=
 =?utf-8?B?T2NBTWMwNFB5YTdWajZ2TDZuOHc2RU9kMWZ5ckdyUlpGQmRkV0R2anRVcHVn?=
 =?utf-8?B?ZTYzYlRnVFZQWE5PbHhxN2VaZnh1RG9lUG9Ld3oyR29uVE13bzFPK2ZLRGRp?=
 =?utf-8?B?TUM1dVlEaFlXeEl6NU1uSUsvTkFqWCtmNDVkcnY2MXZvdFk0aVZuWWRqQmd3?=
 =?utf-8?B?OU5HcTd5cm52L2tIT3hQV3VPMFpBQUdkcWhFNnJNYzFBdVNUNXc4dzR6N1Yy?=
 =?utf-8?B?TEUrYWYxQTJtdkNDRGlnaC9NdXZtOHREMzRjbU5wWnI3TkF3ZHgyWFcyT0lX?=
 =?utf-8?B?dnJRQ0lJTVJGaEh5SkkzaVc5NUZ2blFxTHVqT2EyUHBEVzRPakVGcUNhZzAz?=
 =?utf-8?B?UXU5MDNDRTFpSFFXdEtSZGZTalQ1b0VHSmU5QytCOTd3VHpUeWp1M1FINUNH?=
 =?utf-8?B?c08zRUVJa2YzWlM5YUF6aVJZT3hpWHFqOUgrRUlZU0YrYUYxanVOODBpVDMy?=
 =?utf-8?B?eVhNcTI4L2NmWVlWUktqRlNUVjdDUFVMQWdVV0UvYVIzTmhhRGhUUWljSmF3?=
 =?utf-8?B?ckk2ZXN6WCtZQnpKTkg1SWhEeXlBRFFoZDNCeTA0NENkNWtVRmk3QU1FaUZt?=
 =?utf-8?B?ZGd3blhQcFFRNVZKV2l4MWpVTUxmRk9PeXp2QVk2bS9xK0E4L05qK08xWU54?=
 =?utf-8?B?WUZvNlJSbi9pRlRjWnFoS1gvd0szUGk0WVhIcTRBYUVLYnhsRHFJTkUyWmdU?=
 =?utf-8?B?S2FPZXFrY0JQTCtqQ3FWZGJQdUNOMFdKVHlLL081OHp4Vk9qNFIyTGFNZFlz?=
 =?utf-8?B?eDUxV1NLLzNyaXJxS3R2ZmJtOEhpTjlYYXhkM0l6V1VXNHEyZTlkdjNYUEZ1?=
 =?utf-8?B?cEVvbU1USjB5eGJ3REJETE9yTTdjU1lQL2Ixdlc0dDJMU2YwSElnK2lZcjdT?=
 =?utf-8?B?R2YzNVlOYkRScm4xWXd4YWtSMVpYM1ZvczMvL1o4S3hPZEJiVkpTeG8wZUtp?=
 =?utf-8?B?MXROeG5MTHd5cmNja1E3UUVnNTAySmtqMWVRa1NyWDFWVk92aDVHajJ5WEkz?=
 =?utf-8?B?WUpBZlNWdDBicjAwSFlpM0FIYWlDTENsNmN6aW82QTcvMFpaTVJSTG5hR2hH?=
 =?utf-8?B?ZC9Rb1FCRnNGbTlWcnRaVXQ0NXZ3MXR6NWZ3UlhidTFMek9lUlNWM0dHb0hV?=
 =?utf-8?B?NzF1alArc1RMWUQ3NDFSeDVmWTd0bjVHeElsV0FvUXhscFBTNElMQ2tLc0dp?=
 =?utf-8?B?amMyWVFYN3pZdDNnaUFoU0pyUExUcjNZVEFqYkJSQmdkQ1NOU3FpRW5GWm5a?=
 =?utf-8?B?cVU1cmEvbkhoU1d0ajM5cTR0TDc4cU82RUYwelA1Qmh4d1BXTEpOTlJUb3Rv?=
 =?utf-8?B?cXhWQm9DUzZtVVgycVA3bGVHMlFEUWdrbDIyNU9JREFmSDExS2QwcWRyd3lX?=
 =?utf-8?B?c3BzbzBtWFF0T1Z4OTRKa1NLNjBNTjdFelpjUkVnNVpkeHg2RVFKdjJ2WlYx?=
 =?utf-8?B?cnBuQ0F5N0Q3MWlURm8xcDIwRnNWd3FacHoxb3JkZ00xUGdyNHZlQWdKMmpW?=
 =?utf-8?B?cklnK05JeDZWM3BjUWlRTG5ja05PeWdITnZFRlRndXhnN3VORkZTdmtqYmZQ?=
 =?utf-8?B?ZGtYS1E2WFhSeW1ZUjQ5b2xjUExFV1RPSEZtaVd2bGNsVCtwRzZGcERKRWRa?=
 =?utf-8?B?Q05OZE1ybXByS1lDQWtTQjE5ZzFqM2o4emlPV2labExHL2doeWRXelQ3VkF5?=
 =?utf-8?B?dWdQdkozVEx6cGFQTEtwM3JqUHYrNWJTY1VRaUxUZmFMSE8weEZ2dmNTRS9s?=
 =?utf-8?B?blJ3UjE4RHdZQzRJZ1VzMEh2eTdxNmx2ZzJrSjFLa1UyNzF2OE05ajY0anI3?=
 =?utf-8?B?NzE3eTIvdStIamUvcGJYOVphZG5VMERVWnMvUWM3aDBLQytTMkh6L09ucmNM?=
 =?utf-8?Q?s1QOtc0ekdJwyRd874J8TJTxW+mc72Y52nazmIi6Oty7P?=
X-MS-Exchange-AntiSpam-MessageData-1: tg+k8rTPqVf8dQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8feae5-5214-4434-bf45-08debd2cb0ff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:47:58.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u40KW9B3mtPlOSToIvgcoWvZQ0nbXV6IyR9BDt+h+EKo2+M1M/FSyGpcW+/96Cooy58fXGCH7OtvLGCW1rxYeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9195-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 055A25FC841
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, each PWM instance has two registers (per channel, of which
there is one). Update the tegra_pwm_readl/tegra_pwm_writel helper
functions to take channel (as struct pwm_device *) and offset
separately.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 303e2720034d..c82d537436a0 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -57,6 +57,8 @@
 #define TEGRA_PWM_SCALE_WIDTH	13
 #define TEGRA_PWM_SCALE_SHIFT	0
 
+#define TEGRA_PWM_CSR_0	0
+
 struct tegra_pwm_soc {
 	unsigned int num_channels;
 };
@@ -78,14 +80,18 @@ static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static inline u32 tegra_pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
+static inline u32 tegra_pwm_readl(struct pwm_device *pwm, unsigned int offset)
 {
-	return readl(pc->regs + (offset << 4));
+	struct tegra_pwm_chip *chip = to_tegra_pwm_chip(pwm->chip);
+
+	return readl(chip->regs + (pwm->hwpwm * 16) + offset);
 }
 
-static inline void tegra_pwm_writel(struct tegra_pwm_chip *pc, unsigned int offset, u32 value)
+static inline void tegra_pwm_writel(struct pwm_device *pwm, unsigned int offset, u32 value)
 {
-	writel(value, pc->regs + (offset << 4));
+	struct tegra_pwm_chip *chip = to_tegra_pwm_chip(pwm->chip);
+
+	writel(value, chip->regs + (pwm->hwpwm * 16) + offset);
 }
 
 static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -194,7 +200,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	} else
 		val |= TEGRA_PWM_ENABLE;
 
-	tegra_pwm_writel(pc, pwm->hwpwm, val);
+	tegra_pwm_writel(pwm, TEGRA_PWM_CSR_0, val);
 
 	/*
 	 * If the PWM is not enabled, turn the clock off again to save power.
@@ -207,7 +213,6 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int rc = 0;
 	u32 val;
 
@@ -215,21 +220,20 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = tegra_pwm_readl(pc, pwm->hwpwm);
+	val = tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
 	val |= TEGRA_PWM_ENABLE;
-	tegra_pwm_writel(pc, pwm->hwpwm, val);
+	tegra_pwm_writel(pwm, TEGRA_PWM_CSR_0, val);
 
 	return 0;
 }
 
 static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = tegra_pwm_readl(pc, pwm->hwpwm);
+	val = tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
 	val &= ~TEGRA_PWM_ENABLE;
-	tegra_pwm_writel(pc, pwm->hwpwm, val);
+	tegra_pwm_writel(pwm, TEGRA_PWM_CSR_0, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }

-- 
2.53.0


