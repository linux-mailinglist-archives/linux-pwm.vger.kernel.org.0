Return-Path: <linux-pwm+bounces-9499-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id giRlIxWIRGrIwQoAu9opvQ
	(envelope-from <linux-pwm+bounces-9499-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:23:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E06016E9710
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:23:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Qiu5mGrW;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9499-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9499-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB8203084EE1
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 03:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F0018A6DB;
	Wed,  1 Jul 2026 03:21:16 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA533ADB2;
	Wed,  1 Jul 2026 03:21:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876076; cv=fail; b=U1YNS/UZVDAbs9v6tZpLTgw6YzIVIiy2XEybz1r4fVj2pr+M5f0TUHQqYpJ2um7DarNX6MvC2i51O/aqgjfgY81sWQdCA7UPKRydTq6IRult3xcb+nZxhD2gr98ULi+BdbXzLY/Nh8hWTxN8EeaM/Ogj/iG5SOhTIgt1pGRyEZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876076; c=relaxed/simple;
	bh=YArpcILembdeMGf+NXLsHVuAAcePE858mfYRLPDxyRE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ex9uLxHAb4F72cxCXNHEgOFri/OCmS6wTh2m6IFJVWJ9u59J75EjACd+JyUm7UZ8Eg7aYbefdVFX0oxOYtJg6fs2fX1OgqnishEn3yVf9MaN4YPf/xd5QuBz4dwIWQ9LyzFXNMTGlJqV33BCSPVxXjxYr1zaReHjOt0U4f1TD0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qiu5mGrW; arc=fail smtp.client-ip=52.101.56.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOyzM/U0+n1+lUJou0o52hxhVXwVNwd9r+AfMckSq4LvFGGZ7sE5obQvbq744WbjbrG9UTJIdJTGgqopICpVlkWoHQTghcALE8DL24eEft0/zMmS93IytkfokNo9i0mI0wDC2+0J80WBAUwWDlBpISb5qJ2zoi2WKxueV1syicxskykYJ1X4gt6Pj62LCbvX/ASA/HGq8kUS52acP2qjzEzhS7TFOBdrxo0SWAsAaJsdDQXtmZdio5VxC9kTTD4qR3qWiWDemLpLOKvB0ETICyvSC8fDmXFOmrLJA5DY9dsqUFkwin50vBT7rQDjtjc3kct8sNkr+DGFtfkdGehX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlPQprj6tazccfNvm5Cu9r4rb7uF9iJzsjYj6+YQkKw=;
 b=RQrPyC2FGVhH4e6rOM9+zhRk1C+XsylhI4CwUBsbjz0z2bOiuL+xo5eCyB3PzSChfLtmJkT8WwoiAuj+MNgaGXFVfvKV4WppZ7U/wiHsAZH2+xtoUqdyp+A4Ztux8mTmi4RBqXvSAmVu4khx62im4LvqxA18cOYswO8iK2oPE8kH5dijfkq6flZm2IBQNm3F6Pvyth2gzysCiP2N3soSI3YLWVre90glKHieO2QrOYL0i85QbClbDxt1TFQC/TleIrZB/QJp1VaT74pE4tn62PsedMIUunsGIgGfSzi9o5aTJonUbsBSE+vXzxzl2fcUj+CQCQUohmQ1qI+gVxgPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlPQprj6tazccfNvm5Cu9r4rb7uF9iJzsjYj6+YQkKw=;
 b=Qiu5mGrWc/qNGekRkMp6tIkRRJhsyHDiP+dyc68nRNQfYy+I1q8qEi4gPXit2XKLbm+w4S0cyi5VCh8UjHrkX4hsdEqUF5YSWjd9qj9400fznaAKBB8oN9fYHZQc5SnBgiaRPyx+NTcskGK+Zm6tNyZ+Kv9SmXUA6dGbZEixslTu/E5+t1HS5JFO0WQ6B6waSE7j0VootAtVCbE8i2xPVipAFr5HmYnlbvTchtL7UX9YCnDk7rntLjkj3MDc0oaHuSfboUuAhhP4B64uKKOhLOP5nbJVttClxosSTvYPBuU68hFC4R0k0PK6NP1KNr1rPh1tK5KewN89Xo/uzvP6qg==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 03:21:10 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 03:21:10 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 01 Jul 2026 12:20:32 +0900
Subject: [PATCH v6 3/7] pwm: tegra: Avoid hard-coded max clock frequency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-t264-pwm-v6-3-2718f61f411f@nvidia.com>
References: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
In-Reply-To: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY6P286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 9507608b-f5f5-4e26-82f7-08ded71fcc07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10070799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TFPJS6kjlRV94thyMuGunXCxYdjasYKBsDwPLv6JEMX8FnUJm8hHqVu87Xqt9mwf2pgXX+9BaLfww6JtghZYZ3OVTpX3EY3me3X7/9SRawCn0nj3DKCwN36xSlU5lXe7TPt3aJyx2UZ+pQwA/Nl44MQvhuuswR3NC7hoaDDO7Ct4MNWbWPmRXr8WXweRcGjaHDa1f+1V9LP52OeOScdjoygjkDwlot5ExubCVmrmhE0GFG/23XlmcqZZaAmAZDo9lwbGk43DdLqokcsd3BTKTtKuxikf/46GQd6SZqeoRCgSN0yXeCpxa7flGq5lSWf4cAaj1hkfea52HgUOPK2gixKtPWmwCUtljoeC2cPZIADBUUH97peheLaZdZ6fQ1IbgpjFfNKJ6frRRLA+IylQ8t0bO7hrlbZem0vNyw4WiHfODyqbEbGLUDKz6nTfXr+KesouOJo8zzCPluVfID1p61ryYXsrxEwZ5quTqED6EmjPMMw3Ygyzf5oyJLssfCR6FgPHpsRloujjc8FnELI5nItqVz1/E4mCQkU8rdGd6UeU21xrJW1XUNYw2nMYySA+yH1rti7w/dOnDYwxToeR8jJm35uYDbUaDgHs4wG7UoqeGjCKcHV1Tm4q6Evn/E26ERppgqnzkhLOSBDUxXHZSXoYHGOGiRbILO6zOLzmJkE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0ZqNU5kN2NRdHBxQlFRTlBzK25jRGhlVDZjNnV1ZXVRYXh6MFo0OE1ZRTMy?=
 =?utf-8?B?WWNJd2VOb2xjY1VtUHBDRjVML1Q4Zm5vZkFZN1ZGaFdxVDYvcS9ETitMSDU5?=
 =?utf-8?B?cEF1ei8yTUk1NjBwSE53Sk1LbXVKcUpnbEZxU0RzWkpBbm1kd0NrOHplMjYv?=
 =?utf-8?B?aEJmZ0xOaHQvTXdBWUpkU2NQSDU2VDl1a3BDeG4rQ2dLZDBOWHFmVjZuS0Zt?=
 =?utf-8?B?RGdGMTJRZHRqS3UreEFCZkVCbnB5L0ZjQUR2MTBDbjB0azVKRGluVlN1Zmlx?=
 =?utf-8?B?T1EyMTZDVGJXQi9hZ2dtOHdSUGtoUE1QTjFTaGJMUXJtWlA3YnFObU1EdURX?=
 =?utf-8?B?WWRpeXdxVTRiWUtLNmYySzNNclV4SmNaaTIwbnRMM0lGNmxvZlk5Mkw3Wmlh?=
 =?utf-8?B?anVKNkhLMEpvOVV1RUl5bEVKYVl6Y2RRd1hOYjBrbVRTVC9XUWtCdWt0QytG?=
 =?utf-8?B?NEtSWGdncGR1NFgzdTZKaGF5cWJ5RE93TnBGcmhuREZhWU9YM1BhUWxsOGZV?=
 =?utf-8?B?MDlKak5QTE9zTDQ5OUVrREM4c0taV2NabUZJV3A1bG14MXJZNmM3R2lQQ0Vm?=
 =?utf-8?B?RysreUdWVUdxV1paallXUEg2MnVQRGt3SU9KUGlNUVVueVcvNGQ2Z3BtZTAx?=
 =?utf-8?B?czFuU2V2VHZibm9VcVVJZkhETndRYVNDUW91bVBIMG9nSXVHeWwvN3BZWHVz?=
 =?utf-8?B?Um1BWHdzVGJjYm9DZkhoc0ZSN2NSN0psVEJLNDhsRzlCM3FzeVhyS0N2aHZo?=
 =?utf-8?B?MTdMYUowekVFZi9IVEpEc2Y0bHlMY1B5bkd1Rll1VW53NXkwZ25YNXpEeVpq?=
 =?utf-8?B?ajlpRndrRGdQMHBCQ0l2S2lKTkV5L1d2clY2a3pUVlZBZmE2ZnI5TndIVHNs?=
 =?utf-8?B?bStyUU9FRi9OdkNVdUlGYWNmQlBoVUxud1dZa0s4NGpyN0ZaRmFRQXBBS3J4?=
 =?utf-8?B?VlA5VHl3SFZTVGowSzZKMEc2clNJRHBGWXZRV3RYcUdacHJ0ajZ0Unpzckh5?=
 =?utf-8?B?TGRjaVNTb1p0WDE4SVNRbk5JNVVCNk1kZlNvWWFqNkdYZldmV3BBRVRFdzdq?=
 =?utf-8?B?MHBQa0tmckRNNTVTTm8xTzZYaDV5ZitCMkt5QUMyZjBDemYxM0tjc0NOaUI0?=
 =?utf-8?B?MmpSeWtDUTNzZkRpdFNJYkhQZWo3OXpsaFBxUlpxYWZaUDl0dGFSMllRbC9y?=
 =?utf-8?B?TklieFlPdy83NmdCM3RBd0pYUG44bUJ3RkFrakxPUmxzejN5bW9qemM5Qkxj?=
 =?utf-8?B?ZUdDRzhTVnRWOFlDcGw3WEVnZjRqaWRnWjJHU1ZjTTFZeEhGc3Fkalc3bUpr?=
 =?utf-8?B?Z1JNYnBONHhZSVpUR0JET01TOFN2a2FtZGU1VnZHaitKc3g0czBDcnBhblp2?=
 =?utf-8?B?UTZCVEtBcHd2dnFyNGpVMnVocGFmWmh3YThoVmxTOTI0NmlzWVVtTjNwMjRW?=
 =?utf-8?B?bGlvUng4aWp6TFhZRlJpM1dJV3JxNG4rNVpmTUdGQ2lYbkNDdjhleUwzMzFu?=
 =?utf-8?B?TVBSdXlGS3RWeERoTmpMeVBYQTd0emZ5dWZuaVJFN0hBM3BubWRWLy9NeWVx?=
 =?utf-8?B?ZVlKODBWZllzeDhlZHNTeFd6ZVpCQ0RFYjExWE9Yc1V5NlBoK3owa1YrWmZF?=
 =?utf-8?B?WG5yT3Bua2I5WVhJVkNpUFJ4SUcwWktZTmsvVE95Ti9KV0hiM1dtZGtLV0xm?=
 =?utf-8?B?WjhRS3dxaGRMUkphQ21nZkdZT0FRVHZzd1g0RE80WXl1eUZndys0TnBHcW50?=
 =?utf-8?B?Zlo1OTQxM1N6S3E0Ukw4WmFscUVkRjVQellESlFJNzNuaDBIZVNKTzZsWDVI?=
 =?utf-8?B?clFZTERFdXZJSzdPaVFKakdsWi9ZaDM2blBjeU9NOE1qRm9EWDNua1FHcTZS?=
 =?utf-8?B?ZHdZRERGRFZIVDVDc1VuaHRyOFdIbUlibnh4Y0dHSnZBUVkwNVhOREFMTXJs?=
 =?utf-8?B?cUpDNE5LUVlTcmdwZGZRWlJWbUJzeFdGTjd6Q3ZVbVhXd0RQdkJzNFpubjlL?=
 =?utf-8?B?ZG5tWTdjQVdKQzBDSWVnOTBxSi9JckxxOGdKcW1XbUQxaWlyWXRnaml0ZDVX?=
 =?utf-8?B?MTEyYVpaV0h6OHNwNXR0RHQ3ZW5raERiTTVzTE11M041T1ZsOXZHYmdhYTZv?=
 =?utf-8?B?d0JSaGU2eURrZlFObWhtdXIvUjN2RHFkNmhuMGM5UzNST2Myd0RGVWt4UGpT?=
 =?utf-8?B?NkxEbUEreUlwVVR5UytZcGJxZ3FmeFRtck5hM3BOdFhnYkF0YTZWNlQ2dkhB?=
 =?utf-8?B?R3RsYU1uKzdIZitHYzFRK09sL3l5RWk4S283UjdpeGhUdFVTblMrbGh5UWFW?=
 =?utf-8?B?WWY5V1ZzNEl2ck1mVkdjdjlXdTRDYzh1S3p3QVZBc213MUZoRFZYQTlqSDN4?=
 =?utf-8?Q?ICAP482a4x4/MpzJ2TXEfNVInw64xSjEU8sf0ri/MY4jY?=
X-MS-Exchange-AntiSpam-MessageData-1: KLbRDmCgSEpVvA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9507608b-f5f5-4e26-82f7-08ded71fcc07
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:21:10.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06FaoobTqpUOzPTgrd25qcxaCcaLX7jYUigWSEdwZvbbq+81v9ivM+lPxPdfi1SJKLK2MG+MSm7wfBGGcPAebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9499-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@gmail.com,m:ukleinek@kernel.org,m:jonathanh@nvidia.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:yiweiw@nvidia.com,m:treding@nvidia.com,m:mperttunen@nvidia.com,m:thierryreding@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E06016E9710

From: Yi-Wei Wang <yiweiw@nvidia.com>

The clock driving the Tegra PWM IP can be sourced from different parent
clocks. Hence, let dev_pm_opp_set_rate() set the max clock rate based
upon the current parent clock that can be specified via device-tree.

After this, the Tegra194 SoC data becomes redundant, so get rid of it.

Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Co-developed-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index f8c5495a56a6..3eef299c51f8 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -59,9 +59,6 @@
 
 struct tegra_pwm_soc {
 	unsigned int num_channels;
-
-	/* Maximum IP frequency for given SoCs */
-	unsigned long max_frequency;
 };
 
 struct tegra_pwm_chip {
@@ -303,7 +300,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Set maximum frequency of the IP */
-	ret = dev_pm_opp_set_rate(&pdev->dev, pc->soc->max_frequency);
+	ret = dev_pm_opp_set_rate(&pdev->dev, ULONG_MAX);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
 		goto put_pm;
@@ -315,10 +312,15 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	 * so that PWM period can be calculated more accurately.
 	 */
 	pc->clk_rate = clk_get_rate(pc->clk);
+	if (pc->clk_rate < (1 << TEGRA_PWM_DUTY_WIDTH)) {
+		dev_err(&pdev->dev, "clock maximum frequency out of range\n");
+		ret = -ERANGE;
+		goto put_pm;
+	}
 
 	/* Set minimum limit of PWM period for the IP */
 	pc->min_period_ns =
-	    (NSEC_PER_SEC / (pc->soc->max_frequency >> TEGRA_PWM_DUTY_WIDTH)) + 1;
+	    (NSEC_PER_SEC / (pc->clk_rate >> TEGRA_PWM_DUTY_WIDTH)) + 1;
 
 	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
 	if (IS_ERR(pc->rst)) {
@@ -397,23 +399,16 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
-	.max_frequency = 48000000UL,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
-	.max_frequency = 102000000UL,
-};
-
-static const struct tegra_pwm_soc tegra194_pwm_soc = {
-	.num_channels = 1,
-	.max_frequency = 408000000UL,
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_soc },
 	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
-	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra194_pwm_soc },
+	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra186_pwm_soc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);

-- 
2.53.0


