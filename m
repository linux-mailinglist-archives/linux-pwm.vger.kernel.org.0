Return-Path: <linux-pwm+bounces-8944-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADktK/yBCmqv2AQAu9opvQ
	(envelope-from <linux-pwm+bounces-8944-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 05:05:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD9565477
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 05:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 992273001876
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 03:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382A34D3BE;
	Mon, 18 May 2026 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="mVzShfQl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022082.outbound.protection.outlook.com [40.107.75.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250AC13FEE;
	Mon, 18 May 2026 03:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073526; cv=fail; b=SuLbH4i/MaNOrnKTByLnUKibKuo85bBV8lpCRqKFHypCZUnSvz5Y36qMILj08dNJp+HgrDYdAwK0d66jCY2gAzx8sirQVKENNpWHIif8fLzLMl8VOp5GzFMD0UgtFrrG773nwFpfDSINffIKWVOhTtLeGbOisX5DoEFCkJ/0HM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073526; c=relaxed/simple;
	bh=2ar4ZOAw8HBCa2sDczUdbk2FXTp1aiugSEvWTZrBTZg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E+nvATNNTxIlQVKeGAE/7sPTZ9rEyXCP9yNl8hrkIhy/rWpfGFLTVyZAH5hlsPVzb/ha6SWBGu5fU6dayaSAchQ1QoOx8Iw0uDnl2WyBnzmDlzvwqnpESGS3EnMTl5uhAuE73Aelkimif8+4rItJOi8SqptgSSorpy9BnUvxgEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=mVzShfQl; arc=fail smtp.client-ip=40.107.75.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AraoCF0PCWQjP4vEvD9YWBEGhJcuJfyg7z7B0rySGXEUbgoghEt9Awe6tEaFfeXhtGNs0f6IqrB3xz3xiWQrOMJOuPGAYo0iH6HS/rlY/VawKzN4aDfhzVtkbA+eb/BR9LxGZlUfRk8PV1DlYAXeBMtQv6Xkqm9Pv89KO/il1R6PA2dc8AKKdyeIDDpWKiZGWvpceiAmpClAS5Yd1+RpCU4Tv8R+1k/8LgDF67EBnpSQlgsG701YAHYt+Q11Zygi2Daa9Mm+j0q0GGg29Fhyk7YTchmjbsJDL/UoiKMoO7EXQWq4RIrCStdhnlbTH5KzBixTf5rtRQE3fwGf0aIw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfhSXfCzdhhJ6IQTsJjqgupU85OghFebsX/Den1/pM4=;
 b=SKoJWiusBXwLfhMpaANUtqyJKyWcWZ7LPzxD1Pu91V87LMpytv5I3BMEU4MveeSrpinwtYxkqm1Ak52YwNkXuhTQdKAN7ZzX5pABaaADdGr/7yO8wMUChYWkAtBjHoq2+WAxePZSA/x1tuhM4L8b58veLdwlpoP0ECz/IBuWuIn4KOlbNWwbw4SdGUeMepqJTsgvbiJvxFju/g80iWd0ZjKDK4EyFs6zK2YPsLj1MA10QcJQTTnW8JRne4PE1Ae5rIWGhdyEXn3WUoUyuYnG6qOx3qn3/9bcHAuGtvP9myJHKhqg0BziGBIZwad2uQik8uIyivTdeUCO0HVeANPglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfhSXfCzdhhJ6IQTsJjqgupU85OghFebsX/Den1/pM4=;
 b=mVzShfQlqJaQK8EoounfyOEso++ueU7ojHZgIQlj9XCMHDhWxPPSnJ2DZmZMWFpYVf3u1HVOPwunay+aPctiCYRtR9hl7km/5RiIAEjROODRLw//cMifI8iP6o56mMkyaCGvEoKSetxPretk/ynt3rAqk0/GJUyiL13LrvMXgdspRPKHxdXdoarIaM5TrqztmBkm6jTZbSuR1v0mrA412Q1rbo2BT0tmLd7CvumAsRceoCKAZFw29RTjFEriMb2E9n7RImPmHjKBy909O5JktUyaghQoLQ3DGisQoCtntUEKgE2Viii86Ofh6ahgjt2w+Ls6gFmFU32Mr1Q6qD+Olg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB7012.apcprd03.prod.outlook.com (2603:1096:101:b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.13; Mon, 18 May
 2026 03:05:20 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%3]) with mapi id 15.21.0048.010; Mon, 18 May 2026
 03:05:20 +0000
Message-ID: <56112c57-ed8c-40c5-98ca-f08b2f0ecb94@amlogic.com>
Date: Mon, 18 May 2026 11:05:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pwm: meson: Add support for Amlogic S7
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20260402-s6-s7-pwm-v2-0-657dce040956@amlogic.com>
 <20260402-s6-s7-pwm-v2-2-657dce040956@amlogic.com>
 <agn2Yp3mzI7DcsyN@monoceros>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <agn2Yp3mzI7DcsyN@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d69409e-af62-4e73-8cba-08deb48a4bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	uWonfu7MQc2Jb1i6H6K1OpvNyT7Cje6FZVqmOHHbMneTpNPFWq3BaFdB+sFXGEG9MfCYjk79Ztv4uwuzKL+pNJr9iOJa3D7CTmaMkgDVhGUWPWtxz4m2PYfI24lmDuhz7roCC47qN5OuCo8+WsBv7DjCvfxhjCVgaCbIfXHrRxxtpikvnAMkUXTzJjDvyRubml7zmQ9MTB09Kky3P8ZhOcnL1LvCF1FgRbppSx6hQ3uBCEYRQvprV7niIcrAqd3HJoNVdRb710HCWYtG+3T986+B2m4o+YaU3ByO4J1zOFcSC3uY7/EXFgzBEfzN8PzfIy4YSgopL+w/+aRwMxUHKIUqBLqG0rcMppvULknndTqTZ3R6gyHci8hmcB+OTAJLF+yWHJqRxEgIFE0AfeKKPgZnAUbHmszzQ6ySariKKcIOCEwSYP/HdKQOyCUOB+2OEzndt7HYWg5mz7+j8Wg39SoLoUiI9bh46N1D6Wgh4SBHa5GV+cnk7MdXnGhMdK3T/SyIDuCul2LHnowt1RE7DmSDaGk9v7OpQspHYlkhpo+3JIsQyr0xKtc71IJkEJpOenbvcD1vFI0YRtj7OGxwLRnZnbtSjVvAVVeR6u6nLlyoRTEqFuMuOsBdAYlET6jgetW9DuxBKbqE46vB/5cAJSZ2FLjWXmDZnFcy0wqIykiS8MXnNAQ+nHbooTytViv0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(11063799003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEx3NHFVd3hKSmltQWtNV292TUFXanpkd1haaFFld0tndzVrU2IvczBrMFkz?=
 =?utf-8?B?bmtyS04wYjJRZXBsclV6dngvRXZoVjFkdmg2REhEUXhReEJtcXFsMTFWdkJO?=
 =?utf-8?B?VDNmcGFiT1ZxYnBDQkczM090S2l0KzcrR2Mva0o4eEs2ZjRlNWxqWFpWRm5B?=
 =?utf-8?B?RVFId2Rwek1nUE5MTEVTV0RNbzF6NGxjdXhBN3VaeVk1U0o3ZUlhejYzb3Yy?=
 =?utf-8?B?ME9nQmlVeEdsUmNrMnJVUzlNeERIbHdpemxwRDR3ZUs2WUlOcCtnTE53ZCsr?=
 =?utf-8?B?elBEd1NLcmFvdFhsRDZlWlY4YmVBYmdwQ2NiQ3cvWDc2czRvUk9TV2tPYmp4?=
 =?utf-8?B?TjZndTcwRG9WN3prTEhnLzUwMncyZHNmZk9pVUFOby9qRWwzOU93RWRvNEwr?=
 =?utf-8?B?b2V4dHdwaUZJWWsxcXQzTlVUVEVGTnlSS3NvaEs0dFZSYUEySitlajVEUVlH?=
 =?utf-8?B?UUlhbkFzQ0lFcThGczF2M1RldUJYUHpZVUpqWGlDN1ltd2N6RzZEUW9xR2tG?=
 =?utf-8?B?aVFxWmplWno5M2RhOUFUMGVLYXhObTQra3hBcDdveUxmOGNVNk95dnp6UnM3?=
 =?utf-8?B?aitCMjdkSlV3VVZvRnk1Skg1MkNSTi9DSVE0SHVUYXBVcmt2bDFIOVFGTlo3?=
 =?utf-8?B?WkZsamMwajlGa0VuRzVaeGVpVGN1YkpWaHg2WktQNWVKZTdYVWIxM2RaQ2hO?=
 =?utf-8?B?dTdpTlcvU3FaRGIrQU9oRXhNUCs1WHNDSFJaTUZqTkE4d2I1YmtjOXpvNVEy?=
 =?utf-8?B?aE5tS2ZjUmpwWE1HSnBFZWJaK2lWWUR5Uk5scTcwZ0ptY1d0VGRYbDRQM25S?=
 =?utf-8?B?eGpJVVJrNlhMd3BTWXExRHdFZXBOVnN5eUt5N2I3UVpTS3dKM2Vzai8rU1d4?=
 =?utf-8?B?bVQ5MHVpY1U3S3ZnU05qSkRxYjNJc2F6SyszS0ZVREVvRHVybmZXeG5TR04r?=
 =?utf-8?B?RHg0NGtYRTlBVkprUTY5WldCeHdQL3RJZUlhUEJvTGwyQWN2b29wOXZuUldk?=
 =?utf-8?B?TUlzeXZMUUIwQ2dOUnBNRTU1dzZFZWUxbmd3b0U4bFVwcEMrb3BmOHB1Q2Fa?=
 =?utf-8?B?eFVyN1pKL1ZNbmhhUVE2SVRqcjN3bHNGUXZHb0pSYzFvanlZUGxHMkZyTmd5?=
 =?utf-8?B?TDRWdjc1S1lQd3lVV3NOMFhhYlB5KzlKQVhEL05WVzY4Yk1UU0dGTkEyaHZ0?=
 =?utf-8?B?UGZJazlMMXlmVWszRjF2UFlBTjRyb09vUHhLQjlVQmZTSjFFcENGY2VIRWFG?=
 =?utf-8?B?U2dONlJmaGRERDZFOUZtRSswZ2NpWUlMd05MSDFReTlJNnlOSmV3UU52SnBw?=
 =?utf-8?B?bTRKR05ZaDZ4dnlOMGVrTmhRKytmYzNwVHdsRldFU3hVbkVIcWZUS2xySlNC?=
 =?utf-8?B?cU8xVnUrR2M3WWdGbzFEbWhzOUlsbUdRNDNJMjhYbmNmR0pVTTg3SWRhWXp4?=
 =?utf-8?B?Q1ZOQWliejN1eEo5ZzA4TkNreGJzaVBIUjgvdGExRkp4OE9UVVNPL0MzY0d4?=
 =?utf-8?B?djhkNGRWOFBaUXdWeGYzWGI3K29yajF6R2ZDbC93dmNGYytBQk1kL3BrRjJx?=
 =?utf-8?B?R00weU9LeFdhbEszNytqQkRPZzcvSUFPUkNWTzA3T1B3Y21pQndvS255a2Fw?=
 =?utf-8?B?UkRJTm41c1plQWpwR1lzNEZCWjNnaVNZUVlhaWlSbGZYd0tNeDlZbGJ2SEVQ?=
 =?utf-8?B?U1hwRVpUeU4wVWZpRHNHZ3MrNVV1TmFqMldKWFlQelhoZkRhcFJYWGxJLzNi?=
 =?utf-8?B?aU9JdXRvQ21WRllSbGwzR3NGY1pSTHRmcUV5MkpEWTZTKzR3aVFoNDFMUERW?=
 =?utf-8?B?K2t3aWl6U3dYRkRHc1Y4RUFINWZCWGlJODN5RlpTVzJDeFI4QXBYTXRxVXNY?=
 =?utf-8?B?aDdnV0hjaWFxdHprc3BWWm5RMlRyUVVOQndJSm5tMXVIV3BweStaUEVmNnNw?=
 =?utf-8?B?dDRJRFRud2plM0tScFlQUGVrMzArRWd5RXVlaVZmTEZiUEtlU2phSDNxZDF5?=
 =?utf-8?B?bGdQdnlkcFQ0dTZEMm1QOVhoZ0U4Q1ZSUktJbkoyZ2xNYXlDbW8vYU1RaTVC?=
 =?utf-8?B?YnRlcEd5WlhOMG9pSkhiUHlSMkR4N2xQQ05TWWhhQ0JCbC9peFlrNXBsUFFl?=
 =?utf-8?B?ODNTTlV3MGRJS2tvOCtZc1g1bVJYYzB4V0RRTWo0SkszSEI1aDR4YzF3cDlR?=
 =?utf-8?B?R1Q1ay9RVUoxcGt4ZUVnNnZ5NC8zM2FOa0dnc3BJYktacnp6WW0xNlQ1WE9j?=
 =?utf-8?B?Tk9Iay82TUZXcW8zaDFJaGtsUml6YXk0MFF2T3ljRjdPRUVEVi9WV0FFbzJz?=
 =?utf-8?B?ZEJBYjgzZ3doL0YwZS91b3FHSndJM0srQzVsM2Jsd3VUc0xKSklPQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d69409e-af62-4e73-8cba-08deb48a4bfe
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 03:05:20.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orBSPULWck+hcawOuloTS7u59LQX2w9Tkf6PhNX2KWVtUfFZY2/5AbrcbYMp+J70E6nCZ4TsheRx98uZjCbX40XGiWYxCFa9eWSZvHZriBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7012
X-Rspamd-Queue-Id: A4DD9565477
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8944-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,googlemail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[amlogic.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email,baylibre.com:email,infradead.org:email]
X-Rspamd-Action: no action

Hi Uwe,
    Thanks for your review.

On 2026/5/18 01:12, Uwe Kleine-König wrote:
> Subject:
> Re: [PATCH v2 2/2] pwm: meson: Add support for Amlogic S7
> From:
> Uwe Kleine-König <ukleinek@kernel.org>
> Date:
> 2026/5/18 01:12
> 
> To:
> xianwei.zhao@amlogic.com
> CC:
> Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
> Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit 
> <hkallweit1@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
> Kevin Hilman <khilman@baylibre.com>, Jerome Brunet 
> <jbrunet@baylibre.com>, Martin Blumenstingl 
> <martin.blumenstingl@googlemail.com>, linux-pwm@vger.kernel.org, 
> devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
> linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
> 
> 
> 
> Hello,
> 
> On Thu, Apr 02, 2026 at 02:40:16AM +0000, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>
>> Add support for Amlogic S7 PWM. Amlogic S7 different from the
>> previous SoCs, a controller includes one pwm, at the same time,
>> the controller has only one input clock source.
>>
>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> ---
>>   drivers/pwm/pwm-meson.c | 32 +++++++++++++++++++++++++++++---
>>   1 file changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 8c6bf3d49753..7a43c42ef3d6 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -113,6 +113,7 @@ struct meson_pwm_data {
>>   	int (*channels_init)(struct pwm_chip *chip);
>>   	bool has_constant;
>>   	bool has_polarity;
>> +	bool single_pwm;
> Conceptually I'd prefer a `npwm` field here. That doesn't take more
> space in memory and simplifies the logic a bit. (At the cost of having
> to adapt all already existing meson_pwm_data instances, but that's fine
> in my book.)
> 
I will use npwm(u8 type) instead of single_pwm.

>>   };
>>   
>>   struct meson_pwm {
>> @@ -503,6 +504,18 @@ static void meson_pwm_s4_put_clk(void *data)
>>   	clk_put(clk);
>>   }
>>   
>> +static int meson_pwm_init_channels_s7(struct pwm_chip *chip)
>> +{
>> +	struct device *dev = pwmchip_parent(chip);
>> +	struct meson_pwm *meson = to_meson_pwm(chip);
>> +
>> +	meson->channels[0].clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(meson->channels[0].clk))
>> +		return dev_err_probe(dev, PTR_ERR(meson->channels[0].clk),
>> +				     "Failed to get clk\n");
>> +	return 0;
>> +}
>> +
>>   static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
>>   {
>>   	struct device *dev = pwmchip_parent(chip);
>> @@ -592,6 +605,13 @@ static const struct meson_pwm_data pwm_s4_data = {
>>   	.has_polarity = true,
>>   };
>>   
>> +static const struct meson_pwm_data pwm_s7_data = {
>> +	.channels_init = meson_pwm_init_channels_s7,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>> +	.single_pwm = true,
>> +};
>> +
>>   static const struct of_device_id meson_pwm_matches[] = {
>>   	{
>>   		.compatible = "amlogic,meson8-pwm-v2",
>> @@ -642,6 +662,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>>   		.compatible = "amlogic,meson-s4-pwm",
>>   		.data = &pwm_s4_data
>>   	},
>> +	{
>> +		.compatible = "amlogic,s7-pwm",
>> +		.data = &pwm_s7_data
>> +	},
>>   	{},
> If you touch that array in the next revision, please make this line:
> 
> 	{ }
> 
> (I.e. add a space and drop the comma.)
> 
Will do.

> Best regards
> Uwe

