Return-Path: <linux-pwm+bounces-8414-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL7ANYI8ymnD6gUAu9opvQ
	(envelope-from <linux-pwm+bounces-8414-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:04:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C55E0357BA1
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C248130525F2
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486933B3BFA;
	Mon, 30 Mar 2026 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HChM+7M2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83E3B3886;
	Mon, 30 Mar 2026 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860855; cv=fail; b=Nhqyi0waj3rWQS7Z8LIc0QlmI8UJ4ZvKAUkWbZKWG06Ap/rOj8/TYJwsiTp7mV0d9RVl9tOkqXrrRSh/nyQ+6dJj85wBdDe8rbe7yDiy1r9/Dm6dswJTqJ77+tvy/asZBF0xxfkiZcw1yU4CjcE382iuGpv2QBbOisyFgR2PSnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860855; c=relaxed/simple;
	bh=Evj6yJSB0LLQL+CIC5V2U8+LZLkz/oljN2lXio4LwqQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZBRpgbuSGcfxVsTB1sNotMjhO0TlM5eJNnWTHk2x+qUygsZdRdwTCqAKZjXC5c3Jt0mU9nbFtxXwrXhA2GXZ11EEem8VrmHwfqejkWXnj0hFfPrE4/+8PDTSpVJeXmN8PjCPiJ4+d9VFM+uMN8LqIaanKljkvTmPZchOw0sR/DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HChM+7M2; arc=fail smtp.client-ip=52.101.43.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMwaZgQuJlVFkJS5SOVYTTRBe4lwRIINi/sckSR8thaw8QSEMQhq0z3SRlM5smyPZnRLIZpclKmVVmzrwmkYh/IeWzkTvr62NwEn1DMIPDBf7jnYI9n3dYdM/eh9BFB7V3v0q2GlOwo6HcRzQLLqvC3j/QzgZYA/LWxYmyyzWTqvrwA/D5Kdl4uibizNonFwKrnKw1JlTqA/VJN6rUjrMlBMQsFI/pGXa4S+B2xZjSWbw7fROwddBv3P3UMCXqw7Y5tjnEsPxAtvK9UL3UtJPc2YpKCHSIgOU6MWFTOdri1r07isp1XbdqBCuu5PxPhsRsPkp2Ee0RhwEvL0aLBDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD56M22Y17aXtRpKBTowRAmFt2qj3NH7Zvb4xJmEOR0=;
 b=PQ3wBZtTBx2Nu8D4r/z4Z+qebNsyPP7O2KcCeDHPrwCC4YxfJrGotPgbgvg3KnbLhfr9+VWiGfS2UqRE/KWhltWwPU13nHjE12poU4Rt2FXZrkV32cqqbKnZeCXk72vfMr+s+FEIPtn/ttA9IRcyiEjmYU9lOPNl5misSKeNqnB07EGoGMDwXzpCptLrUQ5lvKvx35Wf5tVasFqK61LWMwbRapmDVtkuxYgQl/1worHZu2k10LK/lQuuySKTu6B9nmKv87sKTfbxW/W5ntQyGz1UCk9y5ASyV/AHM50/NXg+0hUxRK13MPJflaiYk4C7AylB5Q/gh0vCFu/hFuK2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD56M22Y17aXtRpKBTowRAmFt2qj3NH7Zvb4xJmEOR0=;
 b=HChM+7M2QuAEmlqIUZZ6u9VN3+CB5djqfUvBKJSIaoLFDQcydrR66qF7nNFnUjwHZlWfkPaotA3Ifx97+2gyAzCD4J2668Vyp0KAtvyVvcBAauk4bCslqbui+o82W0RnPM/scb/wbm9Tw/cxCw1p3zgKiINt4+X4b8CycSJWSvenzSi/M9Mkdge8iA5Ac8VeA2ybSmb5I8QYeuHdIr6Ru3s/sgxbyROH63P2dorb4cbTjqQDeuvnJzOA3vVuaOQqsYffTVWaCgEqB59C3mIVqlLQDg0PkZbaMcAutfc8Z8/4Dkd9RFwxK0twW+I8wEUP4wiYnpYKVr+hsmvEXPgcTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Mon, 30 Mar
 2026 08:54:07 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 08:54:07 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 30 Mar 2026 17:53:53 +0900
Subject: [PATCH v3 4/7] pwm: tegra: Parametrize enable register offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-t264-pwm-v3-4-5714427d5976@nvidia.com>
References: <20260330-t264-pwm-v3-0-5714427d5976@nvidia.com>
In-Reply-To: <20260330-t264-pwm-v3-0-5714427d5976@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MW4PR04CA0292.namprd04.prod.outlook.com
 (2603:10b6:303:89::27) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b36800-bce5-4961-4e4e-08de8e39e6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DC8UoLnFz3wkul/yCpCnJ+FQafFMvPg3/qrs/TTQnFpG5cypZzwhc4P9sPwxAUHq0xea3FsbeCWtRtMGUcCQfYeMzMNpZJ/5vo9afHq1ZdV1SNOHo/Ka4C8rrk/jJ7j5RvvszhOHbWGFAp0nEpL5t1/kttWFcI0HsVUz9q++rCw5VwehER8PI7gXlt8ccOIy7M03CeNHLNhV5yeIEmiG19bdusNndXUy167dqSjf4PZ7XJGXqZtg756FWkRUGy9WFSyt+8MTfb5XrNfh9I45rXBzCjas8nYcm0BerVimmNXvNUXVb08AWdtyZ6QnyiUQxgzM2nHemo1/E4QT7Q7GaE0Bo2l4ZeHnjMlEeoMYvqPsi7Bxwrjq5bqpNKIRLoGSyc9+4zEpDH0hf6iDF6tEO5g7nPwOylAM+kv++QIyF8L7sAK2py5guZAS3E5ctpoMHykhGRj0UgWGfoHsJaRsIPNBxaPOuTZS5pH8B+JjnDa6aUQ3V1g/WcrGXdkVyV1NF4SaU3Tb4IP5+RE8cdMjcgQVuDQPczB9hQMs806zfQZXNAjmKKRNH208QfK5hMo0SHNWFlTshOd7JOJQ/mpLYBCrPPZ6PHOQ2yz9C7Gl4dVaGm1iVdGSlYgYBcl3t04CRvlphzPyHSLGzDLCoyFAqNQCC1HGzSAhCltD/yB0BmYnhX/WJuTcn5eFyrnivlL16m+gq5HX53YHBdDSzl8jD/YXrWC5oRGFp6gwumyaBdw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFBtOFBpcFlNdFpjeVl6R2pUT0djY0NXRFZ4TjIxdnhHcC9pWGRuamtQWGFo?=
 =?utf-8?B?am9IcWJ2WStiNmZVeG40T1ZDY1c4bkl6djNzVjBaUVpkYXRuOHNVelZVS29R?=
 =?utf-8?B?K1ZIQzdyWm1OM0dONmFVS29DQmo0YXRnUnk1OFBtM2NScFlRRUNXTGY1QlRt?=
 =?utf-8?B?Ti85cGl0aC8rUGY1dS96cjdJdlBPQ2xVOEgycHlhMU1MNjV3RjVGcUo4RFNw?=
 =?utf-8?B?di9SRi83MytDczNjSHQwdjk5dnpoKytvUkJ0ZkJtRUIvRW1aTzQwNTBjM0c2?=
 =?utf-8?B?WWI1NlNyWkMva1A3a3VjWVpYZEoyVUdPcS9zN25XN1c1dllZSmFTZk95OXFm?=
 =?utf-8?B?NHZvdzE4V21SZU1IdTdaVkZTek9Ld1B5Y0JER0dMQldVaW8zdU1US0RETGRh?=
 =?utf-8?B?RG85SVROM2VFUDFucUtyM3pxaktOTHJucS93ZitkY3hlMmR1a3Q4ZC95K1Bx?=
 =?utf-8?B?S0tmcXN3QjRMek9QVjMyRHdFRWdCUTZlYmg4RmljUDJnaFZ3cTc0WjNYTFFx?=
 =?utf-8?B?S0lxamxKcnJSR0JYNmxQN2hGMmVKRytYVFcwRFh6eXhsU3VvY0xaUWtaZU4x?=
 =?utf-8?B?VndjQnI5ZDZUWXFtMHZRVFdlR2hOUzJVajB5VHk4SjlhMlFYTzBnci9ieG45?=
 =?utf-8?B?TnZQdUZlQzNJcVB2T0FUeXJOT0huN3ZwbDBpRE9pcTNqLzd5UlNIK3lJQzB1?=
 =?utf-8?B?bjJoOUJ4elRwOStSNHFiTFVyNmM0YytUNGlWV0FISG9jVGZKYjJTbFFoQkk0?=
 =?utf-8?B?cGJIOGF0TTVFRHNKNGdCR3dnQTFZZ2c0SE1Ya05xM3Rva3M1ZWRVekVnNC9z?=
 =?utf-8?B?NU03U1pBMWxLN2NTWHdoRTlGNHdIaVE0eGlnM3dPd3hHaTZJOXdwNGdDd2hQ?=
 =?utf-8?B?MUplN3JGTWt5VHZESVpnRnRQQ04rY3VwMVdpWkFBQkVuUjA0YVNoaGg0VDJh?=
 =?utf-8?B?MGs3UHFYVnJMWFNpVVRCOWFUOGh3cGVzdFphSXA2M1FYNFhwbFlSTTQ0aVE5?=
 =?utf-8?B?NU1tMVYwRUpWRTBuYkQvUGw5TXZGcWtoL0xFNEFRUVNLVmJORHFIandsUlVK?=
 =?utf-8?B?Z2FqeUFlR1M3dHdIWi8yOFRrUDBOQVhhSXlEcHN1c2N1VDRiT0dHUVlnK3R5?=
 =?utf-8?B?K0NYTFMrQzQrVzBudFczUHpmNUdPdkVhc1l3bUI1SkFyRG53U3FyaWdmWTV5?=
 =?utf-8?B?MjVTUW9HeHo3THROTzUyS2RDZUloSWtBUjl4Q05PK1ZLd0U0WHl6aHdmUUF2?=
 =?utf-8?B?QllxeVhsRVA2YXpScFpabjQwWUVwTzNhVWJmaGNCL3lkWGpxekpaYlNxdGJJ?=
 =?utf-8?B?L1pQdVBkc2dzeDhpKzErcmQrbDJyV1dOUURta2pUWUlzaW9OM3Y2QjdVM0lE?=
 =?utf-8?B?WlFEU3VxYmtJaElMei9vYW1tNGdaYkQ5c1RRbUdTQlY3ZWs5YnpxQWU5U01B?=
 =?utf-8?B?VUE1UHMwZDlVN2EyUmtQaTlPTjAwYUo4L0ZRRDFmb2xpd1dEZmI1NG5QSEZ0?=
 =?utf-8?B?U1J4L3JSc1grei9rTWNkK0ZDYlF4WnptTk1nSWVhV0RtcE9RNko2cUY4Y09Q?=
 =?utf-8?B?S0VqVmdsUXUwSnFRaktRMGtMZnVLNUI3eUVtK2lTVCtFTFFoTWFYZE5CMlJW?=
 =?utf-8?B?Yk9yMUw5c2J5QlpPTkI2TE13TEkzUDdjSVlGYmZlbU1waVJRV2hpaFVobVRN?=
 =?utf-8?B?VHVLMytGaFUxZmVJazA4blBWYlIyRXIzaHZqL2ViUWMxaG11SSs1UHoySGM1?=
 =?utf-8?B?bndJc210VWlEbnRVekRNL2M5Lzd0cmE1QVJWS1NGaC9BcC9XWjRhbDNnc0tK?=
 =?utf-8?B?OEkzaldLcTNYWFJsSHViaW1Ta1l3a2lTcXROdURmNENpS210Mk1FaTVycW5o?=
 =?utf-8?B?RFZFaEsrODA0SnBxYzZKL0JTN0lYK1BoYlN1MUlLRHJXeDQvNzJSWmVLVEkw?=
 =?utf-8?B?UlV4aGNJUURWN1dQS3dINGJYVnJ5K2RkT3k0U0dYam5pa1VZVENiS3dsUVdm?=
 =?utf-8?B?REQzNVFxendWQkIrV1gzQmNXclQxUFlUZEJ3MHlZNlJHa1pzN1RkOXVKREIw?=
 =?utf-8?B?V25rZkhzSFFzajVlQ0p5S1FGUlFxRlhXajQzd2tCeEJpbTQ5bm8zZDltZTg0?=
 =?utf-8?B?M1lMVDZ6UXBxWE9TbDZocHpubnUxa3B3YStobloyeTZGRXcwN3p5bklNTlNB?=
 =?utf-8?B?YWJxNU9qbGpMZVUyTjFvTHlvaUtuNkV4U3Z2TTNtMFhGczJCQ1cvUTV0bUlE?=
 =?utf-8?B?ZjVlYUxWVEN1Q0lHVERjU2c0SzF4Tzl6cHZkTENWc2RNZ0lPK1NnanBmMm55?=
 =?utf-8?B?dmtkcytvdkwyUkVhWEsrWTg3WVloNm0rRzU2NDl4YnlxUXcweDFYZ2RtQXJ3?=
 =?utf-8?Q?z8tc74aj9JMm/cN5EDpCZGulr6c6g16wrTDIGFCLCEs74?=
X-MS-Exchange-AntiSpam-MessageData-1: PZxxsy41c5YmPQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b36800-bce5-4961-4e4e-08de8e39e6ea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:54:07.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJNEh2qfYeQgJjq5hetQmmzjJukNeC/Z524LMVMOeQ8VzP5fIIZR3bY/C11RO+Ahk87uTugCuTM+Mbw7Aou4Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8414-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C55E0357BA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, the PWM enablement bit is not located at the base address
of the PWM controller. Hence, introduce an enablement offset field in
the tegra_pwm_soc structure to describe the offset of the register.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index cf54f75d92a5..22d709986e8c 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -61,6 +61,7 @@
 
 struct tegra_pwm_soc {
 	unsigned int num_channels;
+	unsigned int enable_reg;
 };
 
 struct tegra_pwm_chip {
@@ -197,8 +198,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		err = pm_runtime_resume_and_get(pwmchip_parent(chip));
 		if (err)
 			return err;
-	} else
+	} else if (pc->soc->enable_reg == PWM_CSR_0) {
 		val |= PWM_ENABLE;
+	}
 
 	pwm_writel(pwm, PWM_CSR_0, val);
 
@@ -213,6 +215,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int rc = 0;
 	u32 val;
 
@@ -220,20 +223,22 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = pwm_readl(pwm, PWM_CSR_0);
+
+	val = pwm_readl(pwm, pc->soc->enable_reg);
 	val |= PWM_ENABLE;
-	pwm_writel(pwm, PWM_CSR_0, val);
+	pwm_writel(pwm, pc->soc->enable_reg, val);
 
 	return 0;
 }
 
 static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = pwm_readl(pwm, PWM_CSR_0);
+	val = pwm_readl(pwm, pc->soc->enable_reg);
 	val &= ~PWM_ENABLE;
-	pwm_writel(pwm, PWM_CSR_0, val);
+	pwm_writel(pwm, pc->soc->enable_reg, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }
@@ -398,10 +403,12 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
+	.enable_reg = PWM_CSR_0,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
+	.enable_reg = PWM_CSR_0,
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {

-- 
2.53.0


