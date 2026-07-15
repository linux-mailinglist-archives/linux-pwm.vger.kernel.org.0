Return-Path: <linux-pwm+bounces-9727-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H/ShJa8RV2pSEwEAu9opvQ
	(envelope-from <linux-pwm+bounces-9727-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 06:50:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 142B875A866
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 06:50:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="gBkwz/u3";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9727-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9727-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93061304F22D
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 04:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC33B42D7;
	Wed, 15 Jul 2026 04:50:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB33B27ED;
	Wed, 15 Jul 2026 04:50:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784091043; cv=fail; b=nMOJrdGo2fOdR5zO+814c4Bc768kthgbsM1su6c/waHv5Vvn6/SH05IRYnsbqi/Ak2iVte1QChaQCw4BeiQX06JHBBgsVhCN96VPE4yDfJETmSbT0tTTTIFlSw4chhpPuFDi8baF2FW0xieEVXAGF5LUxgFwVXfUe6f5qJ9/fHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784091043; c=relaxed/simple;
	bh=DeLjAlCHss+/y+N8flVX4wKVXvdq0MfkGnpjEItxPs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HS/wPQ4LWv7Xw3T8Y5GIZA4dA7wlvsWvaPswtJ0DNpRyZZKPqa7KCsYQWg4OxGITh+e7pgBN1M0a8uFHoJVImR3ZKwWi3LRVU5NDBYaITzsFaI+RoMEnpadnoXViE6p+sgaCJN6Tt3cotpFFlih+qj9wYDCGIqgKopG+1/7eFa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gBkwz/u3; arc=fail smtp.client-ip=52.101.61.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+G8CHJ1PxMNhf3A+sOmOECgB3+Mt1eyeWSIVVkxTIiTa2cY75NgtYC5St4k/z1iqVhXsE0LTNQzGy424XzZ7x3YLiDM3/KRHsZA6LmSbnMOXmqWfzzevUEsx/wGqBsl9IYx1lcbZv0b77i9BeyFXxuSl/pjNPQSnIvZTshbrS9047SNNAXzCRVv0XmOuVRm7IeDb33xQB2PjA3udnMS65njeL5bjVTecVCMLmaHjaF27jts4Brv2fRyFP6SWNMLaQnPNRSBk/EAvTNfQ8f6UzjM0lOKz6wbH5shdABEZtXQ+gs95i0GkSOjOJ8k8L6WouJskGVsxz5nlmagBNX3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25MV+I0Qjw9eM6AoePgpgxP1he1TT/ajsOcHBn3zEKE=;
 b=CGDUOYWXR3pdvnwnztzy5pds1sXWaDZ+A9ImRKIZbcR00rAE9JBJrBa7mqYbcn4pRz1NTcKFnbAvEwOXgl6BoCl61+l/fAZgWkwXsQwQp2jchatOfFZSOkuAmHCKvNrUn+MaIw8BSK8Uk1ozkSokqcfOCIbAxdDL/ITuUGE+oaqDKt3Iy2DFYkmnvfYgQRzfHZ4bz92TinjcLL/BNAxaD9BLxeepQwotuEM3YFpKyLEJxQol3hL+QA8f16UeyD1GsWcMX+wDfMwFiAiy5oQdJu30m1iwojfBSNAWFhIHsdd2tZzjrt4v3A+MD946EZ9cuHb4nk9zS6E6CNQhWCxFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25MV+I0Qjw9eM6AoePgpgxP1he1TT/ajsOcHBn3zEKE=;
 b=gBkwz/u3ti8tLfIxHmLCxeHFK+92gcn4AYrpYzq2kbtVbs0x77Ly7RtOwrjX+92J4JHHBthzQbOeXeOmMIqYqolcVhHjTco29QB3NRTOwfR0f5NJvTAQQq2WnPor7GnrFXXVJIagzGZ878fKT9lFK9Uqb8zOj9tPrbHGzk7s0Q2tI2PItCY02WdlhSjDquxlfHz+FQnC0I+LR0gJZIjZ25BGJ1b9q4+x5yT6ikjJ05vLptDs3vJcfrXs3XiYVuPu5Qp0q8fenpWIkroAeV7ornH1Ea9nxk4jyxTu66+TtI4wCFV1eYwoaLh9y+Vq+Zy5nGBIXU/wShPH8oje/v5XuA==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 04:50:37 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.019; Wed, 15 Jul 2026
 04:50:37 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject:
 Re: [PATCH v1 4/6] pwm: tegra: Simplify using
 devm_reset_control_get_exclusive_deasserted()
Date: Wed, 15 Jul 2026 13:50:32 +0900
Message-ID: <5haHJyqESQOPJU-ofv6iCQ@nvidia.com>
In-Reply-To: <alZAzcG-2uuTsxxk@monoceros>
References:
 <cover.1784030076.git.ukleinek@kernel.org>
 <cf1bd92a11661c99802867581b599617ef69f503.camel@pengutronix.de>
 <alZAzcG-2uuTsxxk@monoceros>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b760d3-fea1-493e-b875-08dee22c9c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|1800799024|366016|22082099003|18002099003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	fKZInjTkdiw6fZTzwOLKlkO24w1VPB0CHiuo3N4zrJfFGOWxb6NfABTWGxj5XfTRuiVHrsPaoTvJG+lHKnKQQkgWpSmJq/RE0Ns6XtwedNN5O/8YCx9Q0KSQ2qruOAbVkqVV1bv8YsTE9JRWUlPVCOGb5F95zMCOiide904IbMVEDXUcm93G9e+cL9d/DWtarLSmC3jXZPfiBzzgCElamQWN7A5M3NXvLnNGr6pqkwWUkL1Xp2z/z9575l3pg0JLj9v2rJeQSjuBb2CR3XQMKAIpqPho6g2UJysWQC8LhXsEhSK3tNfMqXXtopB/LHHjqb2Bfdcr1e71tsVtf9Y+Sx7aKuFmkOO6ZHowNoh40qgG3NgnxjVkLydGtyxtCkbsZdTgGPZR0dBs6MtERaqZZcWkYKFx4iM+nuHCsQ3fF0739dz/kfB0R94oKF900XlJ7ohcdEqtVqzUGaymGcNk0J2wcMS1bP+0zGATvmlQSPHZGz4HG9EbeZ+B7dQdVLowgLo6FHBKMdCsWdOiU1M+HdaXoIbUqXj9jnh8qdlm4vhIJSNq9k8NGQPh22eHRT7v2gSJaoLEO2rwz7s7vueSp5ZZ9LOFA4of2K9WTgzyalSHOOkHyDVnan4VULpOUJg3bqFV/M99poDOZ0K5I7JiIAc/WgdNIp+oWdAjnETyPpk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXdTQU1TenBoWHRMaWpQZVRHV3EwNE5ERG1ySVJKdlJPR3Fsc1pxQzE2RmYw?=
 =?utf-8?B?enBJNVJJOThrOE9ZTTJrS3JpYVExSEtGQXNKeG1Jc2tSZ0VqZTkvaEFsYnVY?=
 =?utf-8?B?VmkweVF4R1l2V0NNK3ZvU09KMWo2RjdwWlFXSFlqV1FwSVRWSllDdUJuK2dv?=
 =?utf-8?B?bDlmSzVKSHNlMjRDT040cjJmUmFodmFDRFEyaVk3NVhnZXM3UFErZ0wybExM?=
 =?utf-8?B?bEVFR2NCWWtpanR1UCthSW0zL3Z5Y3NES0lZZ2JGL0w5M1orSmhDU2g4SWpS?=
 =?utf-8?B?cy9ZRFh5U0NVUndjeHByN2I0V3ZEaFhPWTI5cVd4YlBhMld2Z2p1eTQ4NXhB?=
 =?utf-8?B?MzU4YVNjUWoySmxVcEY0N1hmSDZGUGdaOFNGbnIvcnJrSUhueFp4T2g4d3dp?=
 =?utf-8?B?ZzZlOUtneGFVQy9zZ05FekhNWVlBdnJzTW9Gd0hCNTRrTGdGUUdUajlOSnZ0?=
 =?utf-8?B?Qll6V0lxOWJheDdlYW5ma2ZqUWJBbEN4d0REVnp5TitRZ2ZRaGJBK2xlRjlr?=
 =?utf-8?B?UlRxcysxLzl5Y09RRDIwWmtKejJZcUtaL3ZPbW94Q0V6RERkUWtTOGZnTkx3?=
 =?utf-8?B?ZmhMQ3EzVUJ0cjBITUtDZmhNVkEweGh2R1ZyUXBCMi9RU3Y1N2FqU2JDU2l5?=
 =?utf-8?B?STFOTjkxZVBmUnBoZUIyMEtLQmQrQXg4NzRXalJSRU9kREZoejE5Vm5WVzh5?=
 =?utf-8?B?aXFiMDZRUElLaTdVdGJtS3dodjdxVlkrU25xb1VHZHI4Q0JwNUJEeE9mUDFC?=
 =?utf-8?B?cTJRbGNzSTlJaUdWZHF3R01JQjROc2g1TEFCUHhXL0dqVHhMRmZMSXJkNUph?=
 =?utf-8?B?eGhIMHNDeUxLdnlBNEpvQmFWWkw2QTlJUTkxU0kwUU81ZWcrSXdQRTZENDBw?=
 =?utf-8?B?RlVaTTlwY1NGOFhqeFNmUTg1ZzNNYWdkcXVVVTBrT0xlQUJqYkticGI4NXJ6?=
 =?utf-8?B?Q0NMQml6RFBGQzk3bWVKQWJhKzZiRUpJOUpqL1B3SEpYeWVrZ08zM2pwZXBU?=
 =?utf-8?B?WUYxcGc0elAzU1k3a0RMNzVvazBwTjBUZ2IvY0FvUm5wUjQ3by8wV1BsbnJN?=
 =?utf-8?B?UVNPSkZjc3NRYVAyME00ZEVHckgrRzNFNUdLR0ZOdnVWaVBVK2ZDQ2g3WFN0?=
 =?utf-8?B?OW5OUXdqdlI0R2svVk01aG1CVHJpcXFNN0Fxd1Z1Y0h0RFpkNXkwbi9ESWww?=
 =?utf-8?B?UzBidVZoWXo3d2diOHlJUVE0emYyWEdRM3JvWkhBZFJjdVh2Z0MzSFo1dWR2?=
 =?utf-8?B?WWp1Q1VIcDgxR0ZLTXl5QmFXSlR1MWRJR0M5NnpaaG5hZW96bCtSeWxLdDVm?=
 =?utf-8?B?dDlxaVFxQzV4R2lNcnE4eEp0UzJEUWVmZk9aR3lYMkE0QTZDdjBGTzRKQ3pL?=
 =?utf-8?B?MW95YjlJOE5ZTC9odjNjUjFnNTYzRXNKcmgwTWdyQndZWDlvOTUzcW9yelVF?=
 =?utf-8?B?bXkvYnEzdy80anZPcG4wWFlqeC84K2l1aGRwQzlmb2hWdkhlU3lzSkdMc3R0?=
 =?utf-8?B?NEpMM1RnY3NPQUxQQmhpVlhod2c3N2pqOGxMODZteklVcXA4eEc1MVN5WWJs?=
 =?utf-8?B?VVM3ZzU3VXZNNEFjbStMSnlwT1ZRQnV1cFZwanhjN2xtdm5hWXA5ckVuWGFG?=
 =?utf-8?B?eXJZM3pFbG02Q3BlMUV4eXBUREtmdHUwL25MUW13S2xWNU5nTXR3bzVKa1Qw?=
 =?utf-8?B?eEZTcEdjcGtlN2NQSjIrbkczMTNmSE5mdTVqWENmdVdJZjZ1UUNwU29yVkVY?=
 =?utf-8?B?Z1dWUjZYaVRnRjBkb1l1amFHWTFRanFkWFlWeUVCRFRkZTFneHdTSktoTVZN?=
 =?utf-8?B?R3ZxZTM3Ykc5a0lzN2dXa2llRDZsd3RPZWFoaGlPMC9xY3JSMTNmNEt1SnBL?=
 =?utf-8?B?ZmwrYzBjdE1DSGRqbTNtUWRlbFZiY043UWsyclVsMERPelo3Q3cvNWU2R25t?=
 =?utf-8?B?NHBmUU1jc01jajcra3ZzUndzd3Q3MmtCbU9VaXlOUlpKZUNsZ0RxNDZRdlBP?=
 =?utf-8?B?STFnTXAwbWR1NE1aWW9jVzNucENkVWc2WDBXRWFzeit5VGxyQmwwSkRyR3RE?=
 =?utf-8?B?UDFlNUFXM0tWK2s2c2FQMGNLMzFIRXo5cUxCVzF2OHgzY3dTY2RHTTB5enRy?=
 =?utf-8?B?RzZnT2VabHhEWHppWEtvZ2g3NE5pTndsZXNoVTJoeUFNbVlrRE4rSzRiL0dE?=
 =?utf-8?B?RlkrcFMvWVYzZ2hpeHhVQ3JrRkJteThZMWpHWTA1YWhUcjRCUDZ0bXVQMlh1?=
 =?utf-8?B?S3ZhaXhmUWY2QjdEaWdXU3VXRmxoR0dWZlFFcFgrY0NsZTRJNzBkazdncldO?=
 =?utf-8?B?MDFmaW9TcWZqREN1aXNUQmN3SHdLcU5mZFphRWgvM3doYkp6bkJ0emordms3?=
 =?utf-8?Q?IgFjOP9YoPCcajMUMQAg92KoJAO2avLc1jUT79tHKy9Ao?=
X-MS-Exchange-AntiSpam-MessageData-1: Ebx2h8mQkBHFsQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b760d3-fea1-493e-b875-08dee22c9c23
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 04:50:36.1737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0OgML4FoHrmtkW+Dquvm5iTunrBgfj1y0FKppznjg9sKv0kjUAuqqJH4r63p/drOpwFmj5p2eTtTn4gSxvDEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
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
	TAGGED_FROM(0.00)[bounces-9727-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:p.zabel@pengutronix.de,m:ukleinek@kernel.org,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid,Nvidia.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 142B875A866

On Tuesday, July 14, 2026 11:07=E2=80=AFPM Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jul 14, 2026 at 02:12:38PM +0200, Philipp Zabel wrote:
> > On Di, 2026-07-14 at 14:02 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > This function ensures the reset is already deasserted at probe time a=
nd
> > > asserted at unbind. So the remove function and the error paths in the
> > > probe function can be simplified accordingly.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> > > ---
> > >  drivers/pwm/pwm-tegra.c | 14 ++++----------
> > >  1 file changed, 4 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > > index e99e1c5b18c3..d7f4baa4cd9b 100644
> > > --- a/drivers/pwm/pwm-tegra.c
> > > +++ b/drivers/pwm/pwm-tegra.c
> > > @@ -108,7 +108,6 @@ struct tegra_pwm_soc {
> > > =20
> > >  struct tegra_pwm_chip {
> > >  	struct clk *clk;
> > > -	struct reset_control*rst;
> > > =20
> > >  	unsigned long clk_rate;
> > >  	unsigned long min_period_ns;
> > > @@ -319,6 +318,7 @@ static int tegra_pwm_probe(struct platform_device=
 *pdev)
> > >  	struct device *dev =3D &pdev->dev;
> > >  	struct pwm_chip *chip;
> > >  	struct tegra_pwm_chip *pc;
> > > +	struct reset_control*rst;
> >=20
> > You could use this opportunity to add a space between reset_control and
> > *rst.
>=20
> Oh indeed. I thought I called checkpatch, but there are two more
> warnings in this series that I'm not aware of, so it seems I didn't
> check before sending :-o
>=20
> > >  	const struct tegra_pwm_soc *soc;
> > >  	int ret;
> > > =20
> > > @@ -391,20 +391,17 @@ static int tegra_pwm_probe(struct platform_devi=
ce *pdev)
> > >  	pc->min_period_ns =3D
> > >  	    (NSEC_PER_SEC / (pc->clk_rate / TEGRA_PWM_DEPTH)) + 1;
> > > =20
> > > -	pc->rst =3D devm_reset_control_get_exclusive(dev, "pwm");
> > > -	if (IS_ERR(pc->rst)) {
> > > -		ret =3D dev_err_probe(dev, PTR_ERR(pc->rst), "Failed to get reset =
control\n");
> > > +	rst =3D devm_reset_control_get_exclusive_deasserted(dev, "pwm");
> > > +	if (IS_ERR(rst)) {
> > > +		ret =3D dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset cont=
rol\n");
> > >  		goto put_pm;
> > >  	}
> > > =20
> > > -	reset_control_deassert(pc->rst);
> > > -
> > >  	chip->ops =3D &tegra_pwm_ops;
> > > =20
> > >  	ret =3D pwmchip_add(chip);
> > >  	if (ret < 0) {
> > >  		dev_err_probe(dev, ret, "Adding pwmchip failed\n");
> > > -		reset_control_assert(pc->rst);
> >=20
> > With this change, pm_runtime_put_sync_suspend() and
> > pm_runtime_force_suspend() are called before the reset control is
> > asserted again in the error case. Is this safe?
>=20
> Ah, this is true for pm_runtime_put_sync_suspend(). Too bad this isn't
> easily fixable :-\ I would expect this not to be a problem, but given
> that I don't have the hardware, I guess being conservative here is
> needed.
>=20
> Thanks for catching this.
>=20
> Uwe

I agree that it's unlikely anything bad would happen in practice
if asserting the reset after disabling the clock, but the proper
sequence indeed to my understanding is the other way around.

Mikko




