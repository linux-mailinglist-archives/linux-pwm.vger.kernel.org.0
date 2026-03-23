Return-Path: <linux-pwm+bounces-8338-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DH4BpWnwGm6JgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8338-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 03:38:13 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9136E2EBF25
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 03:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8217E30160C1
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 02:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBD1257452;
	Mon, 23 Mar 2026 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lE/D2RX1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9FD234966;
	Mon, 23 Mar 2026 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774233445; cv=fail; b=jYbMyoyCrgLmy07Dmwog1ck07rl5l8IBRlRUsbe34+NADHLn3OUwFY+jrGKj3SuPFPKl9/uZsXom2dfXgg0FwWSVE/uudvgOegCNtqo1b3R+p+565H3KPigzdGJp3R82fHoAAlkFBMJrcTgxh5Hoclr8ddqJS5p+uJ5WErwfL0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774233445; c=relaxed/simple;
	bh=Evj6yJSB0LLQL+CIC5V2U8+LZLkz/oljN2lXio4LwqQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EeNY+idOb4hN5RmojJkYjqKA8kdEzZigIIdFhkaLwF7wmkR8KSJvLhO5yO9bDNc/mTNJEc0kGB2sxUbbrflLxT37D3P7HEsztPIVPE6ElmztS13exdwIPdHam/p2M8GI+9XH0scmAdxR54cG3g1dDbi89nmcOdfntlpC3HDLKhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lE/D2RX1; arc=fail smtp.client-ip=52.101.57.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hhm+7GoUJ0E6U7dAa4BTMb6D5tn8i/r7V7sRIH0eRe80XfXGb7+uJZlm1mNWLKJqAAYLYDElHVUIk/I0RHbu1GkJcCAMUHcNZdXMqKuouWvVSOObl0bgjDobkMAHDq6XovUYCVQ+X4nBXqQBNn76CWhevOXzDwOx4AVKI2ocjQVZzHxpSNUhNsL7rbV+1yN56XEXM9qSG1eW9acrUKRuhobtf8w4GN6EVrX5It/pmJkz3fEnq+g14xbOvWNACybX2eFMF/Lb3G84QO45wAYOoXJW+Ww6DIbgLVfzVknA7FPRAsyOSdhHdp64ixfJFvaTvDbli5gddwP/SrRBWmwBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD56M22Y17aXtRpKBTowRAmFt2qj3NH7Zvb4xJmEOR0=;
 b=Of5UJneLhcJBcDOcEg8wwfEYNdBbXaQnlfmPaW+kaiL8kwLlf+QT6I1MskLJw0gBa3rrdEbxkTQbvXgS5zXKtgXNfVlEyWvCkOtlla+VrruGcePIisnHSn7Moc8IPExJEX/sw0egcmwwyCr81deUK5yWalaiLuJEDMfZILlneNpnWDLkOgPkVMTLn/8PiTecXXUwYLjh1HpmPNLKjRlIqSJesOd0pVEoG5uLdP3uehD9s6P0nbyYbStvKskB0DiF5+/suYAhqZYy8yW0+iQQ+Gbejqv4m2co7v8ypcFpMwtrOEyfUHLn5ZnYDrYnCGLUk4V4dhoQyujNxiEm7MieEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD56M22Y17aXtRpKBTowRAmFt2qj3NH7Zvb4xJmEOR0=;
 b=lE/D2RX19f/ucZ1bh3L2WiyU9A/YFGXkVAL1vn1PLmlnQz+nc1l2dXzGjaaG4N+Gg0TporwIIR1GFUuRLlaKzUlA/17tYdAikvTZJ0+z5+YeojTnLMsqGMYSGy2ShmRmq14uzFOgCqf98U2SmlrYSaB78z36qPWDsAHY8Ut3WzZ3M6lRc8mMR3PbntWRiaN6N7Sc88ZwrN2dIdh3UQVzTD6k7WwMKSfpnQsJynoK9gVpZWQKw3zNccQjZc786C2eOOvCb2MXSDVYFdFROlHdnLqUTn4+eCnI7kNN6B2MMDWw6/nC/YbbHjsao0KsZjKIvZS38oLGx7fgP4WSZkPU/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Mon, 23 Mar
 2026 02:37:19 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 02:37:19 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 23 Mar 2026 11:36:39 +0900
Subject: [PATCH 3/5] pwm: tegra: Parametrize enable register offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-t264-pwm-v1-3-4c4ff743050f@nvidia.com>
References: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
In-Reply-To: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TP0P295CA0027.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 294fc68c-63bb-4c12-ff46-08de88851ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qauFsl/Bg3c5xjzNWD47XP+sZtUdX5MbxwlHYtvK4qDc9w9slttTP+LMCVpmHGwytrk9fJRUZ3dg8QHNmk18OZDmWH2H2fkZtlS1z+o0OQC0gMHkWdB6kH/+t8AShTKq5NhAxycTH+i2ul/i76gvT49DupmhUx7apub/8aagkdxgxJxxaxQ0f20uXh3Un7qtWGG0ksuEjXKZWiGbXtl5X60/EHiwjFKggxVWqZ0LNdIkqNE9aeugkKq0YmmOdzzfs/e5cC4noemV1hyqRLwfgOV80xV+u/DpZ0xGTO5fiTgdUwERooNBb/qlfE5A1NKQqhvZHZZ/2o+Db2cLdsSLFvW9tCcdcmUOD/Ji7HyvT+AkN5ySZvhX8RXmO13y0IEo0gNaIHpY/xWRGti90SaKN+ZHuy5xchrojNJcIZSHMZDO8gHVs4tMEMrantN9TGCd2vzzJkWUK9yBBftDuzfoeqYYcut7ZTgiAzaRvRJJ1MQwhG26AQPZ4fTL1M0gq+Toh85iYMG3go1KWiynCnaFdJjyAAb/lE7kQbzP6EFdDNyhyQqPLsWpgjI5WHfyNMPNzyJ7FfLUdRt6Eg10iKon9tGbmuZ7K85S8ha7hpg9ux/rVVkFa93j/2zsDB/EvivMd8EcbxJorysDnhz8wCCeeKHuYtwxGPv/8fWWdHCHosg/9RpArsIHpaHqwZYNsovMA48TXnbB+zgve4sMAoZs/gXCuS5fX+Y8wHkZqD0du+E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2hwbUQvN3lkdlo4RmtpcW90d2MrTm56d09hK0dwQmtIeUo2YmNhZ3hhWUhU?=
 =?utf-8?B?Uld3cXFHNTVKL2NSL1JxcjA2UjVxNWVJYnYxMHhPMUtteGQ3YW9zNHg5Yml4?=
 =?utf-8?B?cHdXTXNnSDE0Y3ZKa0ZjeFZ2UUR5VTBidDFiQ2Q2ZHRVTytYcXluNVFydlpk?=
 =?utf-8?B?ZDJ5WHlmN01MSWtCU09Dd25PdXZuUXhIRG9DWkx6aW5EQlFTY2lRdURZSEFW?=
 =?utf-8?B?QkhBWUY4M3EwR08vY1gwNXJuNEsydGhyd0pWZGFlM3daWVlUMytGZVNCSGh5?=
 =?utf-8?B?dHhKanJxN2NtYVJ2d004ZVZ5TGZaOTVxNzdMRElnczBOT0VOM09Jbmw5clln?=
 =?utf-8?B?OFZBUGdtWFJNV1RSaGJ1MkowZGFXYTJNQVV6WDNxWGhKWnl1aXlDYmp1RCtS?=
 =?utf-8?B?TU9kYXNMRmZTZUtHTWxWcVFrNkdsNUgzYjYzdyt3ZXN4VDAxZS9hUzBsNjNX?=
 =?utf-8?B?L1V2YzJZalJ0NzdHTlRHZ1V5U09mQjFONityVkZabEdUR1B1N1drNU5LSUFY?=
 =?utf-8?B?R2c2cmxQN3J6cjR2Z0FEcU5qRHRIbEIyMHZzbkw3OElic09obVJicVNKSDMv?=
 =?utf-8?B?Z0ZvZFNBaTlUa3QxUW0ybmlmaXdEUkdKbnUzajAyWHJrZkRVRm5uU2d3cmJV?=
 =?utf-8?B?OVFVZGI3OEJLR0lGbmpUeElwdDIyTGdvS25vdFVTMDVxcUtzNXBsM0x6OXdO?=
 =?utf-8?B?cFNSVzBtVzYyeTVhRk1xK0pzWjFQeG1uQkRPOHZsS2N1L0ZBR3hYRnpMbTdy?=
 =?utf-8?B?K0RCMEJDaEgzbVY4NkhuVEVDTGRUcUY5UEQ5Z1huWkYrbnB3THJNSUY2R0NI?=
 =?utf-8?B?Rjg1RjNRTWZqZnFGUHNVMGNySEJlSXhEaU1YUmdkWGo3UHZIUE1COTZ2R2xC?=
 =?utf-8?B?bjA2MWhJZkd4SDZicWd0U3UxR2ZvODVSZXR2MEJNUUtTVGVOZloyWEFtV1Vl?=
 =?utf-8?B?VFZOV2t5ai9OSXE1RlBZeGVXbmY2c1FBbXg3VHJYZmdzblNaUTJhclA2bGxH?=
 =?utf-8?B?SW9FQ0htM2ZtYjNLSTlCWWlFT0xJUEdQRDJnUDEraXAvd1ZtOUs1cUMvWkdl?=
 =?utf-8?B?T3V4R0lTSjJlZ1FSZ2F4UEhjbkJ3ME13bkRwTkNZK1hBVkJLajF5Rm9wOTFX?=
 =?utf-8?B?SXIweVhaOGtkMGNWcDFEM3hrUWptVHBrN0lDeit1dXl0RUpkV3M3U2FZYnd1?=
 =?utf-8?B?M2oyNnVtMWlYdC9OVW1GL1orc2YvS1FlbjBqQWM5bjJTNjRkRnV1SHZNZUN1?=
 =?utf-8?B?SmVlN3M0YitvU1VwY3FIYldYWlNUOUdYL3NkbGlqTTJWcGNIRzZBcVpCQ1FK?=
 =?utf-8?B?eDJtemZxTmZrZFp2SlVyRnNHY0s1c3gyRDRyY014VWIwTFcrRGVVUlE5bUQy?=
 =?utf-8?B?M1NNY2J3VDJ5STNidTBURWtBT1hubDF5WDZ0Y3MvTjMrMW1DdGoxUXk2dklL?=
 =?utf-8?B?VDRsaG5IbGFMbkVwYzlGc3J1d09TMDB5T2RTTzdvQmFtZnFGcm02Rkk0aW5Z?=
 =?utf-8?B?YkxnRWhNRTVJQ1lua0dtVU1ZYW1zRmVmSmFUb2FhTzFmbEhENDg1aWQ3QlVm?=
 =?utf-8?B?bXlPZlVSR1NWeFdxcHk4eG5LYUJPS3k4WEdOSXVwWjA1TWtSR3hyM2hKM1U1?=
 =?utf-8?B?U2F4NXdhR05IN0d6OFNJaithSEtEbkhNSU81Qm8vSGZoMmRWZG05SllKYzk0?=
 =?utf-8?B?eE0rTk1JeDZ4VW9QRG1NakYvR1dkSHRmVlZwZkJBQWtycGtjUmZqSFBOenFw?=
 =?utf-8?B?WTBqYlhQMXN6V3pCODZOb0RlekUzY1hsbVNuTldiYTlyWmVJOTBrQlNLUGZw?=
 =?utf-8?B?Q0JnYjJlUUJCZHpacEhoSmVwaW1rSVhKQjNhWGZjQ0FYa0s1RmIydDl0QWlD?=
 =?utf-8?B?ZjZBdFcreUdaSEl1ZXl0K2g3azkrSHVJWU10MDVlTEVuN1NaUTdWbHNDZmV6?=
 =?utf-8?B?d2ZJWkg5TWxSUmxOZEZpd29seW13b2xBUXFPeDBLazlwempWSHRMOFVWbmpq?=
 =?utf-8?B?MFdvclBFdWZRVDlxa3NUR0orQ1JPcHduTzhEdGI4UFBUaWxzaTZicHpLR2hD?=
 =?utf-8?B?djU0RnEyOTNSeG9Bb2MyOVVacGIySjVIN2RiU2JpUmsrdDgzNlZCeHU0TDhB?=
 =?utf-8?B?ZVJyTFV5b1RkWDlIN2hwUExTdGUwOEhGNk80bURBbjhTdWpacnJqaitwMVpI?=
 =?utf-8?B?SFQyaDV5U1dFQUh1SFVFNE1PSmEyMTZkWWNYQmR1dFBCU1JSaC84SjZhQW1s?=
 =?utf-8?B?bmtOY1dlSC91dXVaRENpVmtjaXhVNVlxZ2lLNFFMUDl5ZlJjeFRuSjQxdmFv?=
 =?utf-8?B?ZnViS0c2Rk1HanY0RlFmN3NiaFhIUFB6VjY4bmlId09UK1ZpT3k3YzRqV0pz?=
 =?utf-8?Q?9E0zlva5/PzmLfXfmWemiwsZIjSkkp/B2bDQ45usoCuUn?=
X-MS-Exchange-AntiSpam-MessageData-1: E3HsCRdL9lzvaw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294fc68c-63bb-4c12-ff46-08de88851ab4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:37:19.3971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8M3kCAXNwR0a53a+D0yZHy59EnRGRBLfQS0MTZEcKiviQSvXszjYa09EbnmjusEMMQXTwZizcp0iDhCi1csZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8338-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 9136E2EBF25
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


