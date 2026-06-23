Return-Path: <linux-pwm+bounces-9351-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JqofGCpBOmp24wcAu9opvQ
	(envelope-from <linux-pwm+bounces-9351-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 10:17:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A81976B535F
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 10:17:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=axiado.com header.s=selector1 header.b=LKbiZaiE;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9351-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9351-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64FBC301A73C
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 08:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA52F389DEC;
	Tue, 23 Jun 2026 08:17:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021140.outbound.protection.outlook.com [52.101.62.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8852848BE;
	Tue, 23 Jun 2026 08:17:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202663; cv=fail; b=VzegdAeMhgvN3nN4Qqq7Y+nZCxEmyhL86f7DwCQGMubEa1tUzW2Yc8tZSv5nmXgOeJb1kL2hZdIgL9TRbc7328x3YtiZFv+LhLgVshdGMErLPXmmqUDAVQls6V0KCoKBJYmUjTrWEWzEkMD1RImmKPVHKspTHvCGO9ld1E70wQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202663; c=relaxed/simple;
	bh=m4OdpgHKjr2+U2QLNa25an3x6fCUodgLmNQd4Jvm6zg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HcnV6z9m8/a4HHkdFJYoGS1WIVXUx0S9syQ7h0/upFTgHrPf9//yLteYYX/nr9af8xjFNgl1ta0YtWYq1Wzhkbi//+ReBPhMZAebSZZlnZMOubUmAJateL1DceageseKYtebwvm4AcwAG+RO1iPr4L76Qd+lJg10qGDiSEGoR2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=LKbiZaiE; arc=fail smtp.client-ip=52.101.62.140
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcxRz1Ellbi0MeJMMH6sCqwcmiks2Jbm24Oy9g3581kO3+jhoY4wCcMOIew3685uiCqOBm6R8O/q17jLVomQyWDngLbhAZHnhbLT7slJL659grgwvHb6A2Mh5f2yXK7fsKlfA2AA8YEzPesrLeaFsWfkYCZ507JGxvNGDYfJgasBMPQ0LklCMrhQulTMh/3IzxoJlar7RuGFd7lzfqnkczECejZVyy0b5g2BE3TKE/LCwoFxYWAmf/w8t9JN1aXhm7QqCwCYs9zdsAbBL+cKtdr9FaFdRpk3UE4bt5WH/ffRQtJ69su7NQQHzd/y7aDnRreSTGaMrWNbdlhDfGyYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQG1lp306/0c9uyISHRaXk+Qq5bVAunFpW3K/fWTDbg=;
 b=MRIJTtSjQxhuvzYL4TvutYUBBqxp4IkoEm4iab50LxmAQNh2RNimuI0XP+tEfaQUSFN7b/4ZhxvFFrmCrLAWREhxZ5EBt3vU9FsV63deJFXVP3nuSzC2cAsf1PsAcnjmzF5YXhbvo2YLzRqfIF1t64RUy1S7IlKQQgYgmna7sjU7erCi3iL5AHQHOk1wrHU18qg0R/XmLSDE1+NtQfaHrjCS+qmYr72UvaimD7HJscwYEMro29Jxt83lL/BZ+2lNa4maMoOtipHyWwTSM6XiBFgPUe4EvyGm0kPs/ifANTl+Ki4+FuvGzv2HKlv9EVtBkPSa9pKq+WMHCU8wMU4fYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQG1lp306/0c9uyISHRaXk+Qq5bVAunFpW3K/fWTDbg=;
 b=LKbiZaiE0QH6Pj5yz2mJ3VZXKekT/01xN/e/HT7m+Cchx8WTyCw8KcLJPlOxQgUIeevFG8P8gMYM7QFHJ+QSRs8eA3PiMGS/XtvIgCeRa5hMnoKvvcLpSxFzh915AY4XaaVdJoxvDu3L7I3k09XovvzU3qwmEmuVxBxje1VBLVJcUN0zKcSR5T03AK7tp+yIsThaRk++5cMud3/llesM0/CTlIZuMoIGph4bfe8gbFBLwgzbloItdA6zJFoEocqUS516qG2j7OuNACYbxt+9J+VkGQsdLLU1oQmJjDIJE9e5w/korEAZQRmpbjAF7qHTuvWG53WU30wC5qEeDYmOfA==
Received: from DM4PR18MB4144.namprd18.prod.outlook.com (2603:10b6:5:38b::8) by
 IA0PPFDC97AC94B.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 08:17:39 +0000
Received: from DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11]) by DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11%6]) with mapi id 15.21.0113.015; Tue, 23 Jun 2026
 08:17:39 +0000
Message-ID: <91ee0368-1331-4d8e-90e2-f4e43139174e@axiado.com>
Date: Tue, 23 Jun 2026 10:17:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
Content-Language: en-GB
To: Krzysztof Kozlowski <krzk@kernel.org>, Akhila Kavi <akavi@axiado.com>,
 Prasad Bolisetty <pbolisetty@axiado.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260618-axiado-ax3000-pwm-v1-0-c9797a909414@axiado.com>
 <20260618-axiado-ax3000-pwm-v1-1-c9797a909414@axiado.com>
 <c4f3875c-4f39-44bf-857f-10c50a2ca6f4@kernel.org>
From: Petar Stepanovic <pstepanovic@axiado.com>
In-Reply-To: <c4f3875c-4f39-44bf-857f-10c50a2ca6f4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0010.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::7) To DM4PR18MB4144.namprd18.prod.outlook.com
 (2603:10b6:5:38b::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR18MB4144:EE_|IA0PPFDC97AC94B:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa16df7-830b-4cef-a9b4-08ded0ffe39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UMBfnvZHxS7E3Fxo+W5+OtXqAQhOxD/ONrw5XlkSEp7xSXOl7/uA4Nu3jRepl71AmTki20fsWKTuybKnrjXlt+GNNOl9fVEThDjggWEZpGsAZAs91L/LG0so+4WIOZltagHHmhYmNkoDS8Ud42neP7Crp7T3+nJZVxjj8Xx56VZcAxnd2VrJT7VelPEXGK+L3/dMhGrm9/wAGYlWrRcTAhuKT2guAqg+tEm5EswxHhGNV+eTFUSp5kg4a9lIUDvLKeFXcZrn5TRKAVVcwxGr3R/SlXniqbywZlpEmXJ3CbVox3lPP8DjS97CwmTUxUVZi1GUavEfBH6PbgkOXohGfIQrAqUFK96zQZyJteHE9Ehsh8AsIYlADWM7WGO+sS1dOFxzZxrYcQdG/6hfpwI65zCryCgLQI1RwpHkUAxX3+/hpGhPyp4GBSRG8enl+qmW2IvFrVMw0NahPVmvHpNhCe1aAoPz+/dYWMYJgYZ/UshRBOilj6cxZkJ+vyBYxPbl4I3fkRra6a2nuMuB6XxdmV33xGAdx0Cbp6EwDg1eematLAMGGiTw3+S8UJmvyDGxNefMjL+dlnj8Ere2uHuu1QDGf6RCQUOgWEYUKvdxgtY95aj8l2PKbJozvg+eLu7UkU7TQoeIhbH7m7N8mlRfQJ+bEiPd8G0FKP/CDJU7Uvc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4144.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWZ3TEl1bTEvL1gxamx6RHRIRjN5T1EzblBrOFBZREZkQjlEeEdNUjFxVFhH?=
 =?utf-8?B?OVR3T0ljK2ZvRk1ybnFNc0V2TWhKa2NvaytOMXdlQmxwUEVuZThaaGNmaGpZ?=
 =?utf-8?B?TnBnNVpOTVVUNC95YzVUemZaMzM1cUhXS1RjQWZocmdha095WkpCVXI3ejZo?=
 =?utf-8?B?a0ZlbEhDV3FVMVNwUyt2ZkxnVkFCNFBxdUxmMVl1Tm1ObUFmcFpxMzQ1MUZQ?=
 =?utf-8?B?VVFVUHhqUW00Sk5MUEs3WEhjN1RmRVZFTFZIUThzZzNpbEd2THNQN1JseXda?=
 =?utf-8?B?NkxiazBYL0RNODkrWi9HMHk0d1ErdnpHNXZaRm9sWEtLZkFzUkpiUDM3L0NH?=
 =?utf-8?B?L3F6eklKMkhqVWMwZHVLTFlvN1A0SkZ2R0FoZWtCZGFRZ24xcGlPb0J5UzIr?=
 =?utf-8?B?R2MzejJzYXZTQkpCTm1wRXdSck92MlIyWXBZY29zYk9MM1FEdHU1Z28vZTRl?=
 =?utf-8?B?ZEhuM2dFNkFHbXNwWmpXQ2UvaFQ5eHZZOHpPaDVKeEJnWTdJNnZqVFFnSU1U?=
 =?utf-8?B?VWE1enB1OStLODgyLzRMRHZ5bEgrRVgxNTRIQWJPZXVxOUNvZFp6TnhBZDM2?=
 =?utf-8?B?ZitIditVSzZFNWN4bzhic0s2UEVMOWpaOXhkZkRxQktsOWprWjFRYUgzWFNE?=
 =?utf-8?B?TVNGUnFCc25VL0VEVWY3UXR1NU9TOWNuR2VDZy9LZVYyc21PZGFNUEdpNGwz?=
 =?utf-8?B?QTZsZ3BOQkdmMmFYcFR0eGJOVVVyZGtFSE9TRGpDZFRPNG10djgrN3pOUHVX?=
 =?utf-8?B?RTFwa0U5Q083OHpIQi9TR2dYdGJ3dGNQdER5MlFnVlRFTjBFdXN5cG81eVNt?=
 =?utf-8?B?VU50K1FvK21jK3M0dFEvbEJXZkVxZldBQjgzalRsdEtSQ0h2aWxVZmlVWml0?=
 =?utf-8?B?OVJJVFpZZ0lLcEQ4SE1SSXhpNGVsbXVKaHl3V09HTHhqY0M5UXY0aU42UzBm?=
 =?utf-8?B?MEJBZzJGT0h5VVhEaGhzSGIvR2dGTzJVZ1VJZjhUUWFmR09Rb1NTcTRPdzdD?=
 =?utf-8?B?d3djWWp2ZFhJdmxjYVlCRHlDL3ZBdllyOCtBNU1rRFo0ZG01T0V0QU9Wais5?=
 =?utf-8?B?bFR1ejhBYlgvTENZbW9oME4rMFcyL29ZR3VTai96dkhoMnAwTW9UMEl2NzNS?=
 =?utf-8?B?MXh1RDB3TGVETEJQU3RIc3lBUDdaMWJ6MGJ0Y3B1SkFsNGpXczR0cWpIenNY?=
 =?utf-8?B?Y1U2TldobUZnRHo2NlpReC9MUno0NXhleEhxMGo4dDh0bDk5Q2x5MVhvTVpQ?=
 =?utf-8?B?SXovVWd2UU5YbTNZbTFQNUpQZWtDUTdPQ2hJamFaY0R0SWZjWUNYNmdBMnda?=
 =?utf-8?B?ejlKc2lYTStLejFXZndVd3crZ1gyTk12TEhWUW52ekg4MFMvaURKREo2WnlK?=
 =?utf-8?B?ZzNJYkFQaVJ1YmFQeXliZFdQVGE3VEtZQ0t5ckI5eUFpTFIwRWUzbWtHWmF6?=
 =?utf-8?B?MlRHam11RFBHSDdsOUVhaXF6ek9kUm15MzF5Q3UwVUNGNktlbTcxdHdTbkpu?=
 =?utf-8?B?bFUwZ2JyQUIxTnp0dTdWTVpYNTBNTlFkUjdmZnJNUDMybzNENmxvTXRlK0tG?=
 =?utf-8?B?bmpKbUVqc3QzWU83NDIrR09FbThhQmRqMjZSVU8ybUQwTWtPV1JnUXVoUDF1?=
 =?utf-8?B?Y0NpVG5iZmR1NTd0UEo1M21RZ2lYSGNsVjZVSHV5VkNVajZYN0pxbjYrdnFp?=
 =?utf-8?B?c3kxTmxuRHRIVEx4ZFlhVnRrK3pnTVpVeURPQ3FCTFpNSGlwclVXUTY2ekRL?=
 =?utf-8?B?YnNOWFR0WnAyT3cyRVZuNW1WdkJ2dFFLNDFHWGNwSWFlVXRQYnF5WGl2YitL?=
 =?utf-8?B?cnlocWtUMktybUNpcnF0bmNMUWxLU2k2VFo5SDE4NmREQVRuSWhVQ01Menpj?=
 =?utf-8?B?QTlZQloraDdRZzFHVFNtRzBvMzlOQkh5d2ZWV0xSMlVyVENwZk5UaHlOeGlv?=
 =?utf-8?B?V1JNV0ltL3BSOHk0SU5aT1l1SDZPeUxEc1pBZUlRem0vcWVEb3Bqam55WUhn?=
 =?utf-8?B?Y1RXY0ZEQTQ0Ri9mM0RGSlRXWjFzOVpjYmUzWWpRS3FQZXRob3IycFVsTW5E?=
 =?utf-8?B?TlkxQ2VwTGx3T01qaGEweG5SdGR1U0xsd3lHbVpDU3FKS0tScGxJRHFWblpE?=
 =?utf-8?B?VmcxM3M5K3pldjU5VWQ2eTVFalNHSUgxTnRjS0ZDZGUrWTZSci9LeVZrNjA1?=
 =?utf-8?B?YzdFQjFPWlNXNjNTeGZKVUxTalBaSkpoMmRNdlcxY0tkbVJLay90UXoxNmR5?=
 =?utf-8?B?OWRjUGo4WDgwM0s1aVcyWE1iYU1xR29XckZaOEFKbmoyTlRpWm1MWStzRFJj?=
 =?utf-8?B?VWNqbWQvK2lSSE5JK2U2R3VBMGhpUW03QUNDSTVwN1lWVlZCSmRmZz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa16df7-830b-4cef-a9b4-08ded0ffe39a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4144.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:17:38.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BQQfui7dNy+sj6SaTRKgWvbkaSvM/evWLQA/l+GfEMqUlkO/SmF7axlas2qng3YCySxrc+cosdqUasJdo6ybQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDC97AC94B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[axiado.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:akavi@axiado.com,m:pbolisetty@axiado.com,m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:hshah@axiado.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[axiado.com];
	FORGED_SENDER(0.00)[pstepanovic@axiado.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-9351-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pstepanovic@axiado.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[axiado.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A81976B535F


On 6/22/2026 2:50 PM, Krzysztof Kozlowski wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On 18/06/2026 14:26, Petar Stepanovic wrote:
>> +
>> +description:
>> +  The Axiado PWM controller found on AX3000 and AX3005 SoCs.
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: axiado,ax3000-pwm
> Description mentions AX3005, but there is no ax3005 compatible here.
> This is confusing.

Thank you for the review.
I will address all your comments in the next version.

Regards,
Petar


