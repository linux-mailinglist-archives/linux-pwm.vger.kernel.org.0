Return-Path: <linux-pwm+bounces-9408-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4gofG9iQPmp7IAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9408-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:46:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D0A6CE167
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:46:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=aCMWZkwD;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9408-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9408-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E713D3028CA4
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD63FB7D8;
	Fri, 26 Jun 2026 14:45:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021075.outbound.protection.outlook.com [52.101.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D230BF6B;
	Fri, 26 Jun 2026 14:45:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485140; cv=fail; b=Q+eTrrb45FGvs2Jgefz1iemfU+0Vw+WnqehzJI43ywXjhWpV8BFevenJIles5nTuWv86b9LUeRRaN13rkgXOLgh+8BZPmBxfdy/InALbqpCJQWEzj8Kn1CnRyZSsdMlsYMhEHm1qHg2nZHm4pDuhRb09iSv/T11ZnoEEU/v2Ttc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485140; c=relaxed/simple;
	bh=wWNX1+AS4TrOAPyqnUKK6gVkpIb66UYG0esSluSdPWc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nVQibyDAVfHrNf4gDHSr+Qwlt+uByvXKdXWpGqObnzZD55gqiJnFbnxYoGQuQ1xgMqhJBt4f8uaRqfblN5ly4IPzlE2M40QfVn24WOVgmiYOtR9i4FkD7E4vORMfE3H2sVkSr8xD/ktRikE1R543HQxERrhhI5Ub/TqG/rRf5oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=aCMWZkwD; arc=fail smtp.client-ip=52.101.100.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bV9YcOc2QDlLTeEwHmYFoDg5mWeNPU66q4FQYx+cyhPtvNUKW7uejymdyGEvU63woHDd8lSOt8CXSQpDLa5PshbBHLzeWL8CwHfi7y+CHRbNtW/lWSFBMUJg7ou4qfPVnBh+eIMoUl5/ByTbf5AUM1zq//V3y27n4YsobiOcexvJp98bR5hFDl5BAwmDvd5OgmcpX+o9zp1PLYhoXzmPTmfg/AMe6G/WiXmLu49O7hl6FFX81lI3D6Bt3DOFcsLLBqpMdWkq9TWGto4DlDd/kar5S7njH0aAXCoSFfUDLpqmH7R4E5+9JFkqVPiHW3NROPakTgKb1Wvz9VYQLAqnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IZeWG5svKM7EYcUrPPnuRy+BBwKyut6+yyBUMq93xQ=;
 b=girjlz3TTbLXr2BuQyQZ6BDt9XPy+PGcwyC4DS1vpUSPaNGG2Y07dw8TulhmSVJaxMTArNbio0H6FDbApDy5w7Zzx/LJd1fuq1hXJavRcQv3TwKwGI7uEZQbZBHf01eoNZQScMoGcLgQsj2hd26J9l0SJGVb6b7Z8TPitt6MCWP3bT/vzFm2oVWF7N2dcOVOZlleCqYKpK/2+ipJzhAhMAtllPXY/RGDpSHKDAApJUwozRrdBjCgwQxdZ3hb3aPrCBshmyvFD8KErSnnFyMmjqLkme2BrF2w59ZjEG9yQf5oV7P4HtqygyqcvjnGcVuZKALjGmeovNw34Ye9xOU2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IZeWG5svKM7EYcUrPPnuRy+BBwKyut6+yyBUMq93xQ=;
 b=aCMWZkwDYf3ZFEWG9vbozevDE2gFp++CHkrMmncXYN9/izjkQNilbcB+q5csiE0QPPvs4ePm4qflQSgEwnUtajYu9GQVEsN2Nb4eU7el4D+XBmS0tGrO55CDX471IZUnAZd6CQN7lLnGP/9ZeXzWA/PNdVcGP+zMwAhIfyiRilY=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7248.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:18 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:18 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:07 +0100
Subject: [PATCH v5 03/20] rust: io: restrict untyped IO access and
 `register!` to `Region`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-3-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=13409;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=wWNX1+AS4TrOAPyqnUKK6gVkpIb66UYG0esSluSdPWc=;
 b=hIdcdPvBnWa58taH7YzKINHvrWH7H7OSyv82sHnT//XG+JKOPjhnpanD7f0eVRiW/6rOe35YN
 5RjVVaHcf0WCsq/30O7y3ebV7IiLe4vaX6cDvuVhI7EZ0S6NpFQaj6J
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 68def25b-63f4-421e-3a24-08ded3918ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|7416014|18002099003|22082099003|921020|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	O9+RWFSVY4L2oqfSd8Mm5c0Bc37Ipz7Ib0Eqb0q/zJshoGkyS9b4PS3RLNDNHC8h+BdU842W7cyEvFgGWsawNoL0cizKUmQSMHGtJHho+DI0B0xwzDsZHVycYTkAJ7RJBzNRkc3BaQ93VEnnF5ZCD68NZUoNR1XmcADI/evPFZEmuf44fyZcxN+utkF+E1NWhLw+bgPWwxB5YCsgwCQItRTI144uyJ66STx/5qgs/NkavqV33d18XsA250oJTRrBy3mqPqvZGp1f6n+u0YYNx/cq6vxy/4WmtMWig/ZTPUfvtNb+40b5v86y/ATXNYdges0RoIYV2uYeHqBtiD/gVYsizTNSd3Kj2dLhynhnK8RvaH6JMXHwbgysR8z8nQsaAeu6gTPWfn2SRE0RxoVmsqLUkUXYP8lpzskWp/FgrlOjrRTivcK2LBNShuV4TDzoCuUjY5Vh7es/u29o0TssQj4qFmVb7w0rw8rsI+2SdnLeWhVQZ+DOIS+eWDyMoKXOgdlPFiYE4riIdBMEdoqIRWgHqxxm/cXr20U2fNrKieTfKWDblBdZvHrKHS5BBH/6tKzIdbadAZnOAMevipPK7ysf1/8nxmFkRRem1yXGBiWe9Q32hozyiiTuon9poIvh5d4mN6yAlRMIyo6q9g5njtgUxVVaeRKyC43ifO/ibGauv54LbPL3GcUdUNX8SHz47F5WkMEcyjZXJtBZ8r2EUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(7416014)(18002099003)(22082099003)(921020)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDE0QnY5dlBBUmkzcDV4SmxyRXFpbHV1N2QwbE1Tb0MxblhUblZzOHlMbGFp?=
 =?utf-8?B?YkJZdGxzcUpTdmVRN2cwWTd6MnVMMER6TVZlZktDUUZrSWdhNVM4VERxTWhP?=
 =?utf-8?B?ZkNaR1BXQ3oyc3lvM0I5K0ZCdlZGVFNjVVByOC9zaWpMQ2MrbjJRYjltcnVm?=
 =?utf-8?B?aFdiSHJYV2p3b3lFeXhPMEllbU5rck9iWElPY2NsK0QrbG8xdjg2THZjSjZo?=
 =?utf-8?B?WTU2bTBFTnBXdHN1QkVIaU9nOHlxZnB6SmNXVDlsL2xzcHhpUVh1VnNDMFBJ?=
 =?utf-8?B?MEp5MCtpZFJEazczaEJZalhqMlE5b1ZkaCttMG9zbUdWMDQzd3ZqSktXdEZy?=
 =?utf-8?B?RGplNnFuYS9tWFR2UnlYVDd3L0pIc1UrOXNkWlczaG8rWHFrajdJaENJbmtI?=
 =?utf-8?B?Yi9XVGx1TnAzY2wwL01IbGJOMSsxSU9IMVZ0b0hLSzRGT2paRmZoZ1paOEtV?=
 =?utf-8?B?Z1VlUlQ4OWFFZUg1VmJCNm9nNjZBT05XQ3d5U1RKKzhGVGNXVE53b1VMZHRE?=
 =?utf-8?B?YWFiR2hxdVZuRGNRM1NVQk80ZzFFVmcxRVc2RE1PNXl1UHZoRlRIODgvZ2Vm?=
 =?utf-8?B?WGdNUXVlcUYraFhpcmFoWXJSaGVlNlk4K1gwcW0xSDJIUmIzbmJuTEFxQTB6?=
 =?utf-8?B?RVBIVHh5S1NQMWlTSkozSExxUmEranhZckNuczRXZHkrVlIyZzhXcjhtakQ5?=
 =?utf-8?B?UGltYU1KV09yWG9jYUNUN09VanpYNnJWeHAvZjdMN3VTVS9CTUl6WjRlb0wv?=
 =?utf-8?B?LzVpVXBYMkdTMU9EYzRKb1FTRDg5TitCMnNHcm1rOGVkYTRnT0JKUzJpZzBr?=
 =?utf-8?B?QTJiWHdEYkIyc09GdGNWOSs0QlBPcEdVWXRRTWg2OUhrKzBFLyt0THEwQ3Jw?=
 =?utf-8?B?L2w3Lzh6QU84U0RpUFVoZ2RvYm80RUJ2QWNVcERiOWRkQTBoeW9HV1ZOUlB3?=
 =?utf-8?B?UmU4RE9JaHZvcW1rQlVFV1dtUWNuaDRHTU5SMjJudnMxbkdodDZrVGRadjgy?=
 =?utf-8?B?UTNGeXVwMXJrWERpU0xPVU5nbk13cXhGOS8xV0lsZWtvUVNaa1hFRlIwWTVl?=
 =?utf-8?B?cnBiZmpLMkE4ek1xMXFJYkZRZjgyNXpIa1VIK1oxS3pTQ3BHeW8rM0F1azAv?=
 =?utf-8?B?aTB2Y24xaTBMajVicDd3WklnbzVtcEhRTVpDTjA3UTM5aDZ0VHlzVnJFYSsy?=
 =?utf-8?B?djBKWWJCdU1pNFU0T3VpdVgxK0RXcFhzc0Q1emhWZG1kM0xCUW9waW1IRW5K?=
 =?utf-8?B?ME5UeGZiUTNWZGFja2EvRkc2Uk4wWHdzdHNVdElNU1d4cFdPcU5nRldxZGoz?=
 =?utf-8?B?Z082U2gzSGdPVlI5cXd1SkJValpCUkpFZ1NqSXJBUGcxQkdMTmlaczd3WkNo?=
 =?utf-8?B?TE53cjAzYTYvNEhVaVFaSVFKcDZ5WTNoeGYzL0trY1NhNTh2MXpocWFxNFl4?=
 =?utf-8?B?ZEYwTFdjV1VKUzhDYWNRY2FyTlJpZEU1N0ZQS3BVV1NPN2I0dGovRlBRMzN5?=
 =?utf-8?B?YUhTNGY1aVBGMm9yZXlCSk9xcHRUc0NITWEvalZtamgrcGZkdTNkdDhuYk1u?=
 =?utf-8?B?Y2ZnU3VaV3hWRklEOEtLTGJMYmJLVjh3eG5oUFZ2RFlVL0RndDFad3BDaEZE?=
 =?utf-8?B?Skx5M1doSS9FRTlEeTJtTFBjdmQzM3dZTEVscFViWDZPUzVMZ1RGdlBuZlR3?=
 =?utf-8?B?REc2aGF6cVNLNXU3ck9GSFg1UzcvOVVmQ2pwNlRmdXVGYTFtUHVFZnhENGRv?=
 =?utf-8?B?YkpUMTBGZy9xbFlUQk5mWHZNUTlzVU5zcENTb2FhdHQxcHN5VDgzZStEZVds?=
 =?utf-8?B?bS9mNWlMTVljb2lYL0ZwTktUdVNiWVJ5WWh6WWR2MUY0OW9lRlRNSU5zTm5y?=
 =?utf-8?B?V2pmakFzQ2hlQnJhbTdIc2xudk1jVlMzOG1zeUtsQzNLZTh2bzNXY0lzTGx3?=
 =?utf-8?B?WG9scFhheEgyMis1Wk1vY3hlTURKeC8rbnY5NjRlb0pTbFRYSm9lbldXOVd5?=
 =?utf-8?B?UWtCeGJxeTh5UU5DM3NDQlBwdDExTjEvVk5QeDhUc1YyWlYySS8xaW9aMGpl?=
 =?utf-8?B?THA0b2xtcWprT1ZHODRwbEsvVFRRYzZEUXN1YUlMNDJzd3NSUCtGdi9KYVlZ?=
 =?utf-8?B?STYyQ2krWVNRNWx2aVY3MHhuSDJvL3dxSENWd2VDR1prSHNtMndyazlGT3Zv?=
 =?utf-8?B?RlB6UUJjWmhqL1dhMGpPUklzS2ZlRVBwRUJJOVlDdnp4aVpDRDRiRjRXQWI3?=
 =?utf-8?B?VGFBcHdyUGxDS0lvcFZTbGtKRVBmK0lRS2xDY3NPTWRQUm1uU1FmUXN4U2F4?=
 =?utf-8?B?c1I1NzZkc09jY1M2L0hzaEhhZW5MWU00d0g2ellMK1EvWTl2R0IwZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 68def25b-63f4-421e-3a24-08ded3918ad3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:18.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiqhiTs2LwgX37uLB1x8zY1Dl9VJUbNHHS7CKmpIkfn3t2Lx7cjDJdQkpA5fkSEAq00HTNVd7VASBTuQqJBMvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7248
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9408-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05D0A6CE167

Currently the `Io` trait exposes a bunch of untyped IO accesses, but if the
`Io` region itself is typed, then it might be weird to have

    let io: Mmio<u32> = /* ... */;
    io.read8(1);

while not unsound, it is surely strange. Thus, restrict the untyped methods
and also the register macro to `Region` type only.

Implement it by adding a generic type to `IoLoc` indicating allowed base
types. This also paves the way to add typed register blocks in the future;
for example, we could use this mechanism to block driver A's `register!()`
generated macro from being used on driver B's MMIO. The same mechanism
could be used for relative IO registers. These are future opportunities,
and for now restrict everything to require `IoLoc<Region<SIZE>, _>`.

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Link: https://lore.kernel.org/rust-for-linux/DHLB3RO3OSF5.2R7F27U99BKLN@nvidia.com/
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          | 49 +++++++++++++++++++++++++++++++---------------
 rust/kernel/io/register.rs | 20 ++++++++++---------
 2 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d821ee48ed31..87141eb07056 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -243,15 +243,16 @@ pub trait IoCapable<T> {
 /// (for primitive types like [`u32`]) and typed ones (like those generated by the [`register!`]
 /// macro).
 ///
-/// An `IoLoc<T>` carries three pieces of information:
+/// An `IoLoc<Base, T>` carries the following pieces of information:
 ///
+/// - The valid `Base` to operate on. For most registers, this should be [`Region`].
 /// - The offset to access (returned by [`IoLoc::offset`]),
 /// - The width of the access (determined by [`IoLoc::IoType`]),
 /// - The type `T` in which the raw data is returned or provided.
 ///
 /// `T` and `IoLoc::IoType` may differ: for instance, a typed register has `T` = the register type
 /// with its bitfields, and `IoType` = its backing primitive (e.g. `u32`).
-pub trait IoLoc<T> {
+pub trait IoLoc<Base: ?Sized, T> {
     /// Size ([`u8`], [`u16`], etc) of the I/O performed on the returned [`offset`](IoLoc::offset).
     type IoType: Into<T> + From<T>;
 
@@ -259,12 +260,12 @@ pub trait IoLoc<T> {
     fn offset(self) -> usize;
 }
 
-/// Implements [`IoLoc<$ty>`] for [`usize`], allowing [`usize`] to be used as a parameter of
-/// [`Io::read`] and [`Io::write`].
+/// Implements [`IoLoc<Region<SIZE>, $ty>`] for [`usize`], allowing [`usize`] to be used as a
+/// parameter of [`Io::read`] and [`Io::write`].
 macro_rules! impl_usize_ioloc {
     ($($ty:ty),*) => {
         $(
-            impl IoLoc<$ty> for usize {
+            impl<const SIZE: usize> IoLoc<Region<SIZE>, $ty> for usize {
                 type IoType = $ty;
 
                 #[inline(always)]
@@ -338,6 +339,7 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
     #[inline(always)]
     fn try_read8(&self, offset: usize) -> Result<u8>
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.try_read(offset)
@@ -347,6 +349,7 @@ fn try_read8(&self, offset: usize) -> Result<u8>
     #[inline(always)]
     fn try_read16(&self, offset: usize) -> Result<u16>
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.try_read(offset)
@@ -356,6 +359,7 @@ fn try_read16(&self, offset: usize) -> Result<u16>
     #[inline(always)]
     fn try_read32(&self, offset: usize) -> Result<u32>
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.try_read(offset)
@@ -365,6 +369,7 @@ fn try_read32(&self, offset: usize) -> Result<u32>
     #[inline(always)]
     fn try_read64(&self, offset: usize) -> Result<u64>
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.try_read(offset)
@@ -374,6 +379,7 @@ fn try_read64(&self, offset: usize) -> Result<u64>
     #[inline(always)]
     fn try_write8(&self, value: u8, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.try_write(offset, value)
@@ -383,6 +389,7 @@ fn try_write8(&self, value: u8, offset: usize) -> Result
     #[inline(always)]
     fn try_write16(&self, value: u16, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.try_write(offset, value)
@@ -392,6 +399,7 @@ fn try_write16(&self, value: u16, offset: usize) -> Result
     #[inline(always)]
     fn try_write32(&self, value: u32, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.try_write(offset, value)
@@ -401,6 +409,7 @@ fn try_write32(&self, value: u32, offset: usize) -> Result
     #[inline(always)]
     fn try_write64(&self, value: u64, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.try_write(offset, value)
@@ -410,6 +419,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(&self, offset: usize) -> u8
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.read(offset)
@@ -419,6 +429,7 @@ fn read8(&self, offset: usize) -> u8
     #[inline(always)]
     fn read16(&self, offset: usize) -> u16
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.read(offset)
@@ -428,6 +439,7 @@ fn read16(&self, offset: usize) -> u16
     #[inline(always)]
     fn read32(&self, offset: usize) -> u32
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.read(offset)
@@ -437,6 +449,7 @@ fn read32(&self, offset: usize) -> u32
     #[inline(always)]
     fn read64(&self, offset: usize) -> u64
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.read(offset)
@@ -446,6 +459,7 @@ fn read64(&self, offset: usize) -> u64
     #[inline(always)]
     fn write8(&self, value: u8, offset: usize)
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.write(offset, value)
@@ -455,6 +469,7 @@ fn write8(&self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(&self, value: u16, offset: usize)
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.write(offset, value)
@@ -464,6 +479,7 @@ fn write16(&self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(&self, value: u32, offset: usize)
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.write(offset, value)
@@ -473,6 +489,7 @@ fn write32(&self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(&self, value: u64, offset: usize)
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.write(offset, value)
@@ -503,7 +520,7 @@ fn write64(&self, value: u64, offset: usize)
     #[inline(always)]
     fn try_read<T, L>(&self, location: L) -> Result<T>
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr::<L::IoType>(location.offset())?;
@@ -537,7 +554,7 @@ fn try_read<T, L>(&self, location: L) -> Result<T>
     #[inline(always)]
     fn try_write<T, L>(&self, location: L, value: T) -> Result
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr::<L::IoType>(location.offset())?;
@@ -583,8 +600,8 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     #[inline(always)]
     fn try_write_reg<T, L, V>(&self, value: V) -> Result
     where
-        L: IoLoc<T>,
-        V: LocatedRegister<Location = L, Value = T>,
+        L: IoLoc<Self::Target, T>,
+        V: LocatedRegister<Self::Target, Location = L, Value = T>,
         Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
@@ -616,7 +633,7 @@ fn try_write_reg<T, L, V>(&self, value: V) -> Result
     #[inline(always)]
     fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
@@ -655,7 +672,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     #[inline(always)]
     fn read<T, L>(&self, location: L) -> T
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -687,7 +704,7 @@ fn read<T, L>(&self, location: L) -> T
     #[inline(always)]
     fn write<T, L>(&self, location: L, value: T)
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -730,8 +747,8 @@ fn write<T, L>(&self, location: L, value: T)
     #[inline(always)]
     fn write_reg<T, L, V>(&self, value: V)
     where
-        L: IoLoc<T>,
-        V: LocatedRegister<Location = L, Value = T>,
+        L: IoLoc<Self::Target, T>,
+        V: LocatedRegister<Self::Target, Location = L, Value = T>,
         Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
@@ -763,8 +780,8 @@ fn write_reg<T, L, V>(&self, value: V)
     #[inline(always)]
     fn update<T, L, F>(&self, location: L, f: F)
     where
-        L: IoLoc<T>,
-        Self: IoCapable<L::IoType> + Sized,
+        L: IoLoc<Self::Target, T>,
+        Self: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index f924c7c7c1db..3122b17098ee 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -113,6 +113,8 @@
     io::IoLoc, //
 };
 
+use super::Region;
+
 /// Trait implemented by all registers.
 pub trait Register: Sized {
     /// Backing primitive type of the register.
@@ -129,7 +131,7 @@ pub trait FixedRegister: Register {}
 
 /// Allows `()` to be used as the `location` parameter of [`Io::write`](super::Io::write) when
 /// passing a [`FixedRegister`] value.
-impl<T> IoLoc<T> for ()
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for ()
 where
     T: FixedRegister,
 {
@@ -143,7 +145,7 @@ fn offset(self) -> usize {
 
 /// A [`FixedRegister`] carries its location in its type. Thus `FixedRegister` values can be used
 /// as an [`IoLoc`].
-impl<T> IoLoc<T> for T
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for T
 where
     T: FixedRegister,
 {
@@ -168,7 +170,7 @@ pub const fn new() -> Self {
     }
 }
 
-impl<T> IoLoc<T> for FixedRegisterLoc<T>
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for FixedRegisterLoc<T>
 where
     T: FixedRegister,
 {
@@ -239,7 +241,7 @@ const fn offset(self) -> usize {
     }
 }
 
-impl<T, B> IoLoc<T> for RelativeRegisterLoc<T, B>
+impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterLoc<T, B>
 where
     T: RelativeRegister,
     B: RegisterBase<T::BaseFamily> + ?Sized,
@@ -283,7 +285,7 @@ pub fn try_new(idx: usize) -> Option<Self> {
     }
 }
 
-impl<T> IoLoc<T> for RegisterArrayLoc<T>
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for RegisterArrayLoc<T>
 where
     T: RegisterArray,
 {
@@ -370,7 +372,7 @@ pub fn try_at(self, idx: usize) -> Option<RelativeRegisterArrayLoc<T, B>> {
     }
 }
 
-impl<T, B> IoLoc<T> for RelativeRegisterArrayLoc<T, B>
+impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterArrayLoc<T, B>
 where
     T: RelativeRegisterArray,
     B: RegisterBase<T::BaseFamily> + ?Sized,
@@ -387,18 +389,18 @@ fn offset(self) -> usize {
 /// which to write it.
 ///
 /// Implementors can be used with [`Io::write_reg`](super::Io::write_reg).
-pub trait LocatedRegister {
+pub trait LocatedRegister<Base: ?Sized> {
     /// Register value to write.
     type Value: Register;
     /// Full location information at which to write the value.
-    type Location: IoLoc<Self::Value>;
+    type Location: IoLoc<Base, Self::Value>;
 
     /// Consumes `self` and returns a `(location, value)` tuple describing a valid I/O write
     /// operation.
     fn into_io_op(self) -> (Self::Location, Self::Value);
 }
 
-impl<T> LocatedRegister for T
+impl<const SIZE: usize, T> LocatedRegister<Region<SIZE>> for T
 where
     T: FixedRegister,
 {

-- 
2.54.0


