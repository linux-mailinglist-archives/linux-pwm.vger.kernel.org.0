Return-Path: <linux-pwm+bounces-9726-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LkhrGkENV2qKEgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9726-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 06:32:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C059E75A77B
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 06:32:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gnySk8od;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9726-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9726-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6EE53019C95
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 04:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75701FECCD;
	Wed, 15 Jul 2026 04:31:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B912FF69;
	Wed, 15 Jul 2026 04:31:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784089918; cv=fail; b=D6O6MEat3ZPdUZ+ul+5zpzqoaZp4KsFXEUvL2uVB9uBkh1YEdiNsGtCP5Dh2qC2b+4pdccTeJkDcDET+2IwRuR9fAgol67CerBBlQLwYwU6CxgSOhCaCqUoskjTbYnj6WZhGay04axhJbDW7IRD+JwXDIL5y+5h4KIRw3QuLGqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784089918; c=relaxed/simple;
	bh=oA+epdRAuvuwaPqFqyly4Y/qShjJmzv0h4TTU3szTB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JQT59UiWjZdnc9Y6zd5zvt6QImVHHy9OIYTVputPOBLn1z1dHasyNjkbMKIysCE91LNtB8lJZaLEDG5L2hC9Msj2A8LSyT2nzonao47SUG8/Wn7kYYIObyIyYSe9zJZt2pYp/91g/ACsvZBdyzAcHtP434oym8f/y6mFVRPAnl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gnySk8od; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmplO29oaxB3i5lsEXV6CQzu5NhDr6XLe5Qd5bhLmQvrOitXmvZ8mt2ZnMBOG49G6ieXr1jICBy7gBCUmuuksv6H/0mVytju1w7GGMIrgQ8ksTPNmK+typfoLRcfV1KCTNPt4DGOiJe4DegqDyJIZWRYiCVlBIh7zhnCUmnzRdyURqHa/mQQXuAnixrd3YwZHN6umnq4b3otn48MjfQRv/Bve6nP+LyIX4cLhQFIQZQs85qPcukgywyUEzWugV+FxmK+aAKh8RloSXO26trGoheyf4/J+6P+zHG8kTJ7HN04Vm2NbRAwSEOtfvjm4S/f+Jt7enCjzLm1ky7bbRPCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFDVX5T2hT2S12+bMZOThpAAiIu8f15U7IzbQbUodgo=;
 b=jx+tPCXmwQFgJzZU9ByWFGbew2bfnNr4dVeyL+Tt3zPp7MV3vDt93ZTQ8qBm3N7M294fStviwiPjZ8mvg251CTl7itSW5tgmdOOw5aCIj235mDFhs9EL5mDRCayfg3GcdAD+u/Cq2+2EvMEQv+QNW79vjtYJYiG5+KyXDhNEXSQIQr0ATvbBG9auet2Wnm+KaLBxXsxl2OorSl6DTRBu4f3jiL8kT5HTBAAuL0qz2vKX8oY8rGO1EgJHkqY/UQIRllgNTzeEPW6+v0082+jfFltoR/jQkdX3/+nbUCTTPWrx9oEJ+4Tw+N3Wr9DqLQvU4k4ppYNTZLJjE1bBNkeRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFDVX5T2hT2S12+bMZOThpAAiIu8f15U7IzbQbUodgo=;
 b=gnySk8odhQ1T+zIOFCVzFCoMM+5ITXd1IYXwiRde071BsFh5nT6gjjn2BJoDn1o5k0pnTv1dtWZSYeadzDXN5fkfglwJHWSGOjgKMIvbDEuwMreYaenaZOkto6wSCvxVx8mT8CIbNUDdFExP4ViotmkLkMfW7BtnhcyoP7duu7H2pUCPfWK0jc96FbDbWplFmOhrt7rCa7aXdNNRn8CQ/ZmD+ockdpmbUYVR5rXHDJ7UQ6sQWS0zjTFBmBQfp3CUqbdQvVrkAn5OVGncTL1x2/NWZszKOhevnRrmC4McY8RTmebkgsrB2mx0bLJErXkIciMQGdcb2bYjOPSeD5X96Q==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 04:31:51 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.019; Wed, 15 Jul 2026
 04:31:51 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject:
 Re: [PATCH v1 3/6] pwm: tegra: Use devm function for pm_runtime_enable()
Date: Wed, 15 Jul 2026 13:31:47 +0900
Message-ID: <MAZ-TeVzRkyeyWYe-mCm7g@nvidia.com>
In-Reply-To:
 <a7b7386ee7705b25cc1cd345c188e14978ab2e9d.1784030076.git.ukleinek@kernel.org>
References:
 <cover.1784030076.git.ukleinek@kernel.org>
 <a7b7386ee7705b25cc1cd345c188e14978ab2e9d.1784030076.git.ukleinek@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4PR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa3c6af-9b3e-41b5-1c4c-08dee229fdb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|23010399003|376014|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eOslHbz38jl0rRljS5xt9Be3aF60x4q/FOlWvefAl22wjSSgXAi0qtT0GVt+cPJu25nPlg7aAX8omvekAh8Q5iKsIW0irGF3QGRzX1Bw4+hGokVRmQ8ijb/RWRva/ZXxEyN3MqZw67GivJcMOPDdVT00nF+diG18Y+Bn7KNNLTuFX4zn1WIme/4hqY3qozC7BfQ41cwM53EHcFGz3pAfSGjokDcj/BSJtHQB3dk1dn/lXwYD5MLN+IHpJnEsiLTXXL6BM8AyDyjnkuPKfs6NGuu2oNErO52UiJqk7nKZFDzir5N28QEh6oYW81GFP6EW0hyhx1xzFZtW5vByKzeqFEafENqhewi84m4E3q7LjayQKIOHsecVTKyK5QMkn/MxmPb6vn9twfin510LCncxVvrBMr25cbcJFwxccG9xNOJBpjoQDisArzxmHW6cLFunr05Yay9EMvMoWs1jf8FytZQ0tKoGuNOrg87gTVJc51pMcKoWCJH2xZ6dteOqvvi1uSDkyfwq/jheif1fWbOxuy7d8Y4wBkcGhstd09SvTBqQ8xFGxYaaruQNJwK8P1joDjDV4Z2uSouSB3f0pW3kbnM77CNhIz5dzMGXSWMeQzRLWMnehNFZAEca8chtnjP0xwHlRENYoP3+8aNp64dO8viPc/Plh8VFDpbtNpB9n7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE1zTElGbFcxc1JHUnFhaHdZZVJMVmJVVDdaWTlVV2FuRUo1RGR4ZzJFZVFJ?=
 =?utf-8?B?NE12L0szWEF5V3FwNXR1alRpUlZmdzB4UzZaRjY5SGN6S1hLUU1UOUY4UUNF?=
 =?utf-8?B?NlZYQnBEZG1PTjdJZ0F5T1ViVXVkZXFZZ2h5RTRHMk9LeEVaaytuemU0aVNn?=
 =?utf-8?B?RnJLTVVjYkd6Y052THFGaGp5YlFaYisrTVloU2huVW1ZREpoNmpYazg5dlBU?=
 =?utf-8?B?U3MzNWR4WW1SMVRqWEFGd01sNktpd01YYUF1VlFIcXJuYm5VVzdKUWRFZ1Ez?=
 =?utf-8?B?cm5MVHBqTGZOcXZ6b3RrQzR0WFQxRWl1a3NiVEJlcWhOeGlMaDR4bktZY2NR?=
 =?utf-8?B?M0x4bXByMjhCYVFEcWFWWXkzTHp3UStVbzdwRzViR2wyRXhrUEJsQWFyRTFH?=
 =?utf-8?B?NkNaL2l0VUlKcDZvUDFESVlpRFNDMy9oSy93ci9jdVV3Tng0aXdnMDlybTl1?=
 =?utf-8?B?WjMvOENDTnJUanBaVmh4THNrUFcrbzhsenhvY3BtZWFveldNem91KzNHbURE?=
 =?utf-8?B?dXd4YVJ1UGZ0YlRUR0hEL0x5WEFlNXE4eW93bFJlbTFDWlhkeG4yTXJGMk5T?=
 =?utf-8?B?c1lUbDBMUXZOTkNzRTJENEdzYnV4SmJkYzJjSk51end6ZkVFcXR5ZC93THRS?=
 =?utf-8?B?NmU1M01TSUQ2Njk4OHF5ekVyUDRJcU1YSWVFbDkrZ0p5bVhoTHkzWjRBVEpH?=
 =?utf-8?B?aXRBd2pleUFMNUZrWlhIdG5CeWJoaisrUmtETGZPTlk2Q0ZlSDNlNWFJOTRT?=
 =?utf-8?B?YnVZNGJYejlwL2lSQXJqRG9lMUx6VXVQRmxKaDJvei9YY2ptVUxLYTRWS0hE?=
 =?utf-8?B?ZFZKdnZXWVBQSHp4dnF6WFZmdy8zb2xpY0lNMTFWc2p6bENYS2x0UjJORjVQ?=
 =?utf-8?B?b2lTMExSdUhCSDZIT0FRUG9XMGhTQ1FGNlVwSlJObHBiL3lpQXRuZjNuaXZM?=
 =?utf-8?B?ZXZqeW1rMFM3YU0zUVIweU9GNmtsb3JzSWtDVjZHVllBVGZWSjBDVkM5K1hH?=
 =?utf-8?B?MXVjMkVFTVdkb0txNzJRak94MDJCNzFYcDZaM1Y5RUF5TzluZ2xtSjN2UEhj?=
 =?utf-8?B?emlzRGRqbkplM3lwUkY0VWp3QkJGYkxSeVNWdEpKMFpEbWRyTkRTbFZqZU03?=
 =?utf-8?B?bnVJQ0wwY3g5dDFYa0NoWEFucTZCY3EzdW16Ym41djByYTFIZng3RjlwTEVM?=
 =?utf-8?B?MUdjVDVDVWtybkJ0TWs4akJtVXhNcCt0RGljQ21rNEd6VXE4b2R5U0JVemdz?=
 =?utf-8?B?ODFZM2hIQnVXZEkrQVJxRWxNWFRlWDBza2tyUjVxbHp0eUhNM2JhTzVmbjVF?=
 =?utf-8?B?RkhIYURDNng5aG9mV3p4bnZQT01abUFtVlpQY1NVOVI4cVlJUk1qalhzZzJZ?=
 =?utf-8?B?TnN6dlM1QmNjeXpQZXVJNU0vbVB4TzBnNXRXV3dEajJnVlRtRmtRZmFSSS80?=
 =?utf-8?B?bVo2dFplNzBCaXA2U011dUp1bnI2VUlCdVdPTkM2OGw3dXlmTFZKMjUvVDU1?=
 =?utf-8?B?NndkalpUbXduNWZyRHlmQkw3M1pVbEtTTktqRk14bFcxeGdaMytUbThYd09y?=
 =?utf-8?B?a0hkK0l5bVZqaDRCYWNkMy9WdXQxRFBycis3MzBlWUdLeXoxcXppNGtpbGxN?=
 =?utf-8?B?WEpudmJMYXNPYitCRWp1dlE4dU82a0cybHdsbUlHZlh3Y3ltdllOUEE5ZkJh?=
 =?utf-8?B?c1YwbzFiclJPai9zd2Q2cGNudW5MTjBZRjFrUUNOVjMwdDZzZ2pNb3J0S1hl?=
 =?utf-8?B?WmZWSXlBanZYdXlMd1Jsa25mRDVBTzcxWVlnWHpqRmJHS2ZEL1N2cjZaQjBP?=
 =?utf-8?B?N3JiN05FRjRrYjV5WFliajh0bVIvYkkveHMrcFVBY2FPZVJJRDNsUjNscTVo?=
 =?utf-8?B?TGZNSlQrMUxxSjM3SklrNGRFWTBjUkFwdGtRMnBnWWpXbW1JK1VRVDUvU2tp?=
 =?utf-8?B?Zko4L3U5VTZpcUF5RnVPR0cvM2N1Sjh5YWdYUms4dWp6cDV0b1RzWEFNY25Z?=
 =?utf-8?B?dExhNk00ZVRoMTUzTjFNbUpLbnBSOG1nUThQK054WTI1MFZXUW4zS0x0RkdR?=
 =?utf-8?B?MEl6UTNjZFhlZG5CNDVZL2MyYnZNQmNmZmxqdXA3d0pVTnFVSUVBdFVpYWo0?=
 =?utf-8?B?d1BzVk8rdTlLTDFETjRtTmtNS2FuOVFQbnk0Q1h6Um9PeU8yS0djRlBnK1VT?=
 =?utf-8?B?SzljeDh5U2cwdjRkcGpjUm5ZQXNFWVZ1dUVFTWppcW9GdExJZklsWnRZL2l5?=
 =?utf-8?B?NmJZbDQ5Y1FnOGFmamJMR1RsZ0Jzekp1QzhtWG1abnc1cTdGRlp4b0JMSHRX?=
 =?utf-8?B?dzBtWUlNb0VkdU9XeVNrYkdsdXNNa3R2a0pjOFdtOHErSndrUk94ZjdGdnF3?=
 =?utf-8?Q?zINkl48QI4sLsv9YRj7WpXE5Z85kRvD5fci+hp5lvFIPy?=
X-MS-Exchange-AntiSpam-MessageData-1: JxFRZfq2KIHg6A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa3c6af-9b3e-41b5-1c4c-08dee229fdb9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 04:31:51.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyBPJDuUCSuh7vUo8YD9PRSwjA/Ubs5sm8sW4R0bxdWvOkhXe1pz5dOu5KGCZY6c5u5kfLtrH/zp9dy0R/XXUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9726-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C059E75A77B

On Tuesday, July 14, 2026 9:02=E2=80=AFPM Uwe Kleine-K=C3=B6nig wrote:
> This simplifies the error paths as pwm_runtime_disable() is called
> automatatically by the driver core.

Typo, s/ta//

>=20
> Note that pwm_runtime_disable() is the right function to undo
> pm_runtime_enable(); pm_runtime_force_suspend() "should only be used
> during system-wide PM transitions to sleep states".
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> ---
>  drivers/pwm/pwm-tegra.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index dba9a05675e3..e99e1c5b18c3 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -361,7 +361,10 @@ static int tegra_pwm_probe(struct platform_device *p=
dev)
>  		 */
>  		return ret;
> =20
> -	pm_runtime_enable(dev);
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +
>  	ret =3D pm_runtime_resume_and_get(dev);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to runtime resume device\n");
> @@ -410,7 +413,6 @@ static int tegra_pwm_probe(struct platform_device *pd=
ev)
>  	return 0;
>  put_pm:
>  	pm_runtime_put_sync_suspend(dev);
> -	pm_runtime_force_suspend(dev);
>  	return ret;
>  }
> =20
> @@ -422,8 +424,6 @@ static void tegra_pwm_remove(struct platform_device *=
pdev)
>  	pwmchip_remove(chip);
> =20
>  	reset_control_assert(pc->rst);
> -
> -	pm_runtime_force_suspend(&pdev->dev);

I'm guessing the pm_runtime_force_suspend was there to runtime_suspend
the device if it was on. I agree that pm_runtime_force_suspend is not
the right way to do that, but some replacement would be needed.

Thank you
Mikko

>  }
> =20
>  static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
> --=20
> 2.55.0.11.g153666a7d9bb
>=20
>=20





