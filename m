Return-Path: <linux-pwm+bounces-9360-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l5OMKR/sO2qpfQgAu9opvQ
	(envelope-from <linux-pwm+bounces-9360-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 16:39:27 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2222D6BF34D
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 16:39:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ifUrNCFI;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9360-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9360-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A47BC30C779E
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC123C9ED5;
	Wed, 24 Jun 2026 14:37:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC23C2BB0;
	Wed, 24 Jun 2026 14:37:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311851; cv=fail; b=QMbFrWOVwcMSUlZ4Yp48QlTfgHmAfNs3G3AScnKglk3e0uwCPvDv0GbE3kt8w2cXAeyjLmInATh6e8it7Ppwf4luruRLlNNhCVILuVVABe8rdO6PwKBYy2AMkNdCKH51rujUauF0Ghv7hiUOY7jKnqnBs+xuRyLue8s5fKXAWJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311851; c=relaxed/simple;
	bh=PaIlZsMy0ZuOBsaLQo5SBzQI/EqWWzsDmn96BcVj2MQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ghpA2xJx04/EJAvl3yoSrgaJGWxu/J1PMkpZQm5w2chpKLdGjrWXs+inKnK7z/Ckz/gxvqZmFBOrUQ5gbv5DJSv+akvgIKUobdvN7/GWr7DDuJgyLw3zMnd6gTIBGK2bIKtLUuk39UTH0vS4MhEQAXujt3N76qndsKedlLRHQLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ifUrNCFI; arc=fail smtp.client-ip=52.101.53.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPS7JdhmX8u3ndGQXMIFh2oxko3DlC4OfaRV8Ml8eFJcSJFl7BnmOiZhkr1n91lYuSBZNJKS5lLLV7Hr4BX5vt469CxltM1duCcoMW9BV8NZRWU2JPd360ozZuZpEfWqYQT6uiBA4/n/wttEDxlVRFxOGXoavzV2A/O6E5w4p0ZopzcVwKG/H5+LmoBlw22Qjo7iZp68vBb7l0j27SlEBRQ9sYVNJ9O84VsIHvEmOotWdLy2EXNFo0cWF6ZlcEwR4ClGZN+OtSEuyHzZfXE6Dcs2/PSssfVQqKCFt9drxl4tzjifBM+h2UB65VuB+kVEbblgfaJ+OB1ppExPLSkB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaIlZsMy0ZuOBsaLQo5SBzQI/EqWWzsDmn96BcVj2MQ=;
 b=HFsdSh/+g2oJ64daCYvNpylfAH6SG6TtLzHMeIIsXBchtEDfHXCW6W7diL4ej3NWNEO1zmkrmIsYlx2wSb6Q4QzP3ojaGWbWu4jju740gc4+ulylX7ey60DMOoeEMt7KIXsGi6mHUlKrfgDFLHtuSabp+uvTzkBVLAIZjVNjLff8Z103W2Av5TRzgu6G9cEOu9AIgP8sk3RRzWuwPokrBfzXgriz8g9TvH+p2lfDt00l5Uf63XOE6FwX2+gX8EWPkJX+lrBliyY88ar8jvYqs3WW6ajgF53It1LKXxhfVVhJqE+Fq6aXgbM5HFOwBWX0KtiYY1ZQgwe2/o0a+iFaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaIlZsMy0ZuOBsaLQo5SBzQI/EqWWzsDmn96BcVj2MQ=;
 b=ifUrNCFIxVNy75TCTeLyNMyuLsehBwsCJCV2QbExhlY5ibCFERbsL5Mrt0Bj0OqJkx6LzJNU4obzWuKa2apn6K5Pb+TRea0/BqM8AgkjpbIiOsV/f9kg60H3aVlCM+Mi8mBWEA2svLsQjy297ZVYAXNYKIjK0fx+YKp6tKJyBbE7awJHSfZQQUiiVBRjr472QdndQQPUkHxXplcn5zq7Xb0pWYT0idMk8Yw/4uoWyDxsVlJgWCjoncox3A+71EH+Ms7doH+/MF+LgUl72Q6h/KRckEaZ2k1IYkVQs76O32wyv2gkcer/8OneFQGSppxBOHPVPBj9zO7c4jOKW3J0gA==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 14:37:19 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 14:37:19 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 23:37:14 +0900
Message-Id: <DJHCTDBHMDTG.10NEI57YC2T34@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <ecourtney@nvidia.com>, <m.wilczynski@samsung.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] rust: auxiliary: add registration_data_with()
 for ForLt types
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-4-dakr@kernel.org>
In-Reply-To: <20260618230834.812007-4-dakr@kernel.org>
X-ClientProxiedBy: OS3P286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f7::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a53f80-9bae-4ef8-9f4e-08ded1fe17e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ZsnF1EAdnWbimyTSxVmMxSXTh/E8gFIFHwWJGXiSar6ZvdE3NsCpKIwS+r033nZyJJky0yPYTmVmdh5Wx2sanV4471x8YRG/kyYwfAmni3+2pQWaH/xd9lBwCSS3SHiS/vHMAZWx3vNSEYX9OFn03NpJQzpfUARknCW0Ae1U8D0W08DzpxspdswX17LouoAauqjt3KBZRGpRyZMLCLSJqRFSiA18TNtNTSb8MyQuhwsZxUIX+Ep6sDUnm/QKFm4TR6OTdAZtWIiD5o5A0jQU+7XkjOW6OpzowqpTmlmm9iV2LtQHweGxqkhNZtVmu27Cwcqc8ee1Ch+3yx9CbNBOx6pFaKLPkTLf6O6nBam2GtIFYXnT07fca+KhP+eoo+LzC9LagVuS2whhizL17RpM6G0SWepOP0f30/eflwzYt6WMVejIngFJgsJxtjhcf3eIRXTtPLF88+5AVWbJiB78jFRij6roe0z/1SewmSA5NkwobK7qb3U1owcg874QwmAyWl0NpMQW7CEZsPGw9H9DCuanlN3FE+AQ89q9/v6z0g4h4SX7TQKI9+SenLhcKoj/FAGH1+YlDT3k7UmdVPM7K3QEOnqHqaAHfXw28bll/f6HPmQltg3YrdQUrZchqUg5WdvSyZhVuCO5uc6qfxd3mpFUTGzTF7rEPmetW+1eV+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEF0TEZSRWVybzMrZDF4L1NZdGFBMXlzTENDK2l4M1RwaXdHc0swc2ltaU1h?=
 =?utf-8?B?emxaS3l0WUpHdzU3WkNmRFBqSzZ1dm8rUDVmWTFjeWhxNFJHdSswUks3aGEw?=
 =?utf-8?B?eUtQbEpteGxUUjV3alVpTm9ETHR0U042LzVNMTBmYXJyaks4T0dPLy9ydVhi?=
 =?utf-8?B?S1hsOEJWWjNKemxBNnFjVGVWK3FoWUxrVGI5YTBMdjJNY3NFNjFCaHBQUFlH?=
 =?utf-8?B?ck5PTjBmOXVzMWVMbS93enk3dDl0YVh2VWVrSGl5N2ZLdnNESDBOazRjTHAy?=
 =?utf-8?B?TFlyblZmQ3F3ajRDTlo5WEU1L0FHSzJQeWhpbDNCbE1VOEJjelNudnZnUExE?=
 =?utf-8?B?WGJFTUkzYXY5eWp5VzUyN2FZanY0VmhHSmhuM1ZXNDQ3UWs1UmxBMWRhZlcr?=
 =?utf-8?B?S1RCUWJWeHRtdjN5V1NQOVlaNFZtYTJZV2xhWUZYT3FJMG4xM1QvWStoRnNi?=
 =?utf-8?B?WnZvalI3Z1VIQ29sV0xHK3VLODJLQUtFRjFZM05sUFBiVUpWTndiakxiZyt1?=
 =?utf-8?B?MFJIenRMQ1BSdGxaNkxjMHhIMjIwaDd1c09XZGdGV09kVGlnY0g2YXlrblNy?=
 =?utf-8?B?a1orVitYUVFhMzFWdlNDZFd4ZU53Ymt0a3F2bEE3cm1YYjZlQnBBT01QTkpm?=
 =?utf-8?B?Tit6K3BHc2E1T1NEb2ErREVXM1QxbkpXZCtGY3JvQmE5OHpQNGVBc0YxVkpv?=
 =?utf-8?B?ZzluV1hXaWdvL1NBYVIwUG5NV3Y0ZFprVERNb1hFNHZrbzhBeVJsakw2RUdJ?=
 =?utf-8?B?M1Z3TTNqY2Urdk1wUHpkd1JlTnNxU292T29KUEVZcEUyeHgzL0dQVGRrVUNE?=
 =?utf-8?B?YkR2SzZ4K3lLQkVjaUsvZDFzRmNMQ1hRUHZVZUVsbFBPc3pJYXZiWjhKRHJV?=
 =?utf-8?B?Vkk3b0RPemZocldXUHRDWXVSb2E2U0pGN090RnRjK0pob2lwSHJUcEYvOXdU?=
 =?utf-8?B?eTc5YjRDb1NTMU1Sd2J1eEllQ1JqaTcyM1gxLzdZMktKdGZSNS82SHllbzRl?=
 =?utf-8?B?cjc2ZFoyV2owdkd2c0tVaXk0NEJFcUVwMVRFSmRXMmpaKzV2SnZrQldPRGJ6?=
 =?utf-8?B?MDJOcExIakVHeXVmQWloR1J1clNoUDc3Y3B1R0JXY1QrZWZ0SWdnL2ZtczBL?=
 =?utf-8?B?U1NISXZGekZldTZxNzBoR2RtU0o0ZStFdDE2KzJWNXJwaTJPNk5ySStLQ1pq?=
 =?utf-8?B?UXp6YnJ2NHJJZTFlcnVoNmhJcGtINE15SzJhckE4NytiZnFla29GYURQV3lR?=
 =?utf-8?B?a2E1ektEV2M0K1NBSFhucEdQTzBFOTltSjlEWjVpQjBWdk91L09CbURXRlI3?=
 =?utf-8?B?UHNlU205Mk1nQ1ZGUnp2dC9QcXJ4c290V2pGalYydlhTbDRCTWU5a0xBWUZJ?=
 =?utf-8?B?N2RVTzhJaWxtbllYRXJ0L1FMaUhkRHdGVk5XbHJjZlQxazJZTGorUC9JLzh1?=
 =?utf-8?B?dVo3cjFDU0ZOaDRzVmRIN3htbHNDcCtuY0U0VExheldQcFA3UWkwZGZFWDJY?=
 =?utf-8?B?TnMrMlc5RUxYaXlVTU9HbnV5c3ZwT0g1b2tmcmtLMlEyLy9pY09pd01RNE56?=
 =?utf-8?B?UGtyMGJQd0EyVUhFZHRyeVoyekpodWNhTjNXQkxLZUlUWEgvTHJUNTl1bWYv?=
 =?utf-8?B?c3hIaVQrR0hFdTFaTmFDSFpyZkpFNkdSWm5tZjFSZlNpU1BPQ0ZSaHFQanY4?=
 =?utf-8?B?cmo2UjRVeGtla2YxY0dmTVJWbVNSVEdJendGamRoUHcrWURmZkpVdkZCaWwv?=
 =?utf-8?B?Y1JhRnRvT2gwK2JPejlVZnROT1NhMmpGMStDZEJSdkFpaDdTS2ZycHlPY3hJ?=
 =?utf-8?B?U3dwWkFvSkRIUTZ1RHc0VDJLRk9mSTY0VGliazVGemUvNzRua0xZNVgzZ0FM?=
 =?utf-8?B?WkVQd2s2RXF3UzRMbTJ6Q0xkVmxVYkZyZVNsdHYvV1UyZyt3OTZ1L3BaN2pT?=
 =?utf-8?B?dDVSNjN0RkZLd1ZSZFo5N25UaHlwQTlPbWRVZ1JiOXRlSERKQ0x1TnlCcXJL?=
 =?utf-8?B?anNlQnVVRUhYQzJLb3lzaitLcHlrbUsxVlNFMUZQbE1DZzZFcnBUSG14NU9N?=
 =?utf-8?B?VmRuOTlDSmRMc1VuUmd5Z1BBV1NHZHdxL0RRV3YySmQvYVl2cCs2YWtwSnR5?=
 =?utf-8?B?QUZkY3F5UGppMkJTdjF3c1ZJUWptQ3FqV3VZM3R6d2t5RzRzdGdVVmpWOWxE?=
 =?utf-8?B?TWZCTW8zVFNnSlNDamlSZ2swbEpuclVDR3RCRi92RnlyNEhsd0g5MHo3Y0tQ?=
 =?utf-8?B?Ylh3cHZmN1EyQmdxV1QxVlZZWUlNVkNGbmsxdWUzSGtNdE91ZDF6TlNLVGVE?=
 =?utf-8?B?dm9xNGlFdWZLdFRqREE2U3h4NnYrQjl0M2lRM2VLQ0tWdEgvRHJ1RW1jSVBT?=
 =?utf-8?Q?fVSKaPxKo893XsgYrScSUjADWy0L66DQnbtKUZxr23hSy?=
X-MS-Exchange-AntiSpam-MessageData-1: 7rwELtla3svcow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a53f80-9bae-4ef8-9f4e-08ded1fe17e9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:37:18.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrSJbTwA32AkEaxMgvrts8272gsebCrjVrtZPi+gXzI3xpHSUzgbXJTtRG7f13495s8e33A1o7Sa5krKVlBgEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9360-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:dakr@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2222D6BF34D

On Fri Jun 19, 2026 at 8:08 AM JST, Danilo Krummrich wrote:
> Add registration_data_with() taking a for<'a> closure that receives
> Pin<&'a F::Of<'a>>, which works with any ForLt type. Taking a for<'a>
> closure rather than returning a direct reference prevents callers from
> choosing a concrete lifetime for the data, which is required for
> soundness with non-covariant ForLt types.
>
> Extract the common null-check, TypeId-check and KBox-borrow logic into a
> private registration_data_pinned() helper shared by both
> registration_data_with() and the existing registration_data().
>
> Relax Registration's bound from CovariantForLt to ForLt so that
> non-covariant types can be registered.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Sashiko's comment about missing `#[inlines]` is probably worth
consideration, but regardless:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

