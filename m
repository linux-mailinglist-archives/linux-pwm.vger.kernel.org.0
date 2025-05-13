Return-Path: <linux-pwm+bounces-5974-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0089AB5FCB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 01:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCC64663D2
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 23:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38961F12EF;
	Tue, 13 May 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="UoYEtVbS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011048.outbound.protection.outlook.com [40.107.74.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB51EB19B;
	Tue, 13 May 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747177800; cv=fail; b=CqFXVUYB+tzvG4sNM+M1AOzuqXBanW/mQOMEKSvB0N0yA40/9n5TJV5wgir1Hq4/8AY84Uczz6hLehdqQLHXyaHS8fnA1X55kAsyxfgX0ORcaVyE6xx7p4ZqdnhAiFaD6yXVtxghuxM1fsd1rl/Lykr1+rNEUtLrqDUrJWjpqzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747177800; c=relaxed/simple;
	bh=FGh+wgMF/UiJm0/Ce4DJau6d7vVotkMsPPDks/KD1ek=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=RoiskuK+FUBeKLlHLCUuEbSs+UgcSBIdKXY+IqcpMU21oqfQvAjihVNes6CCNMSGTFZEJV9v8U/GkJU7LC8AsMZmiVPVwpT1OOiiMTjQmcyiBxUj1yNWLDblGQ70Uao/vT9tNcvAIqsxwJIGDAOQoO1JVuxn6uwIU3vZ+//qr1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=UoYEtVbS; arc=fail smtp.client-ip=40.107.74.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/guUj0OIV5YN98xAQH8tb2bgK0xZP0wS5veDqrX9C0x4Y42aK8XzuAhAZr0fRVdccAG71i6u9kF3HI7gCl5uRGQ+8vd0Q8gRqyDtQFk6SF7VXsK6EnFwAzG3biwldJu/dowT2UOKgvLmOPRJyXzwL4KYd7xHuKOrZN8Q1jYLdZdEJVTHu94/RIKUGdDlnWzYH5xbLbJR+9BNrcwRF2Hdt/nRY2Bw27QzS2l1G0XU4LrmrKg9Az6tpwqhya2AEN0yTVYLcDbCrP5cPEA5PU7a/O4QeB0/NzNiLWR7YK0ibnFO9xQsmdI3SYELwqLQvqkaahmHRjTCglH18sVBVl+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Deu0Rje/RK0jn1L5JD5dhyjF8pAxQbMQ3YRxO8/QM5E=;
 b=SQv+OwqNRydrr2a+YqpjsK+k8+Qkq9IHTx/kIfcJxYk/dzgPiwZcU9KbaRMTPaExJ8Vi3bPtGnHOELD0+wGQqkVLXUUC585nAoNms6Nh+an3Z6BhMmnQ2izmjJwknDLX7MzxdsxRalkfMqK+CItmCigUnKOQ1PVsgBa1YF+Ia4ER+McAMi3Vj47Q5V/dn7jgXAjAX8A1pU+Gpr5gm/BRATcvaQoHlmimfJPxQTXMYjv/k55UNKtPRfkgx5S2T92bgmL8gEUL2vM3B4zysW0zSeLRvkD7eAQMDMCwuPWha7r/e+ZO/H5VpLBuMmat+Y79emg9s+Uqb0MZiGBLnZoeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Deu0Rje/RK0jn1L5JD5dhyjF8pAxQbMQ3YRxO8/QM5E=;
 b=UoYEtVbSQEY19hI+qOr/YP8vecvJolWfP8W9XAG15N5/W3H23CDr15NPHleF1Mc8HTASBfxq6VZ4U6SpjjUKVhTvC21DeYhtZeEnkpFVsCoBUyTOOVD47EIBBmE0Fx9qZXma6yYVhxK/Kp2QfYVOvYGOaglPhmwv+jkG1Wi7GAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYYPR01MB8093.jpnprd01.prod.outlook.com
 (2603:1096:400:f9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 23:09:55 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 23:09:54 +0000
Message-ID: <87bjrwaz0d.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: =?ISO-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,
	linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
In-Reply-To: <62gkja5ysv47yos2hcurluudxwvl54uv4ih7pjnmnjrzuik6cs@a5oxhyyy6vsm>
References: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>
	<62gkja5ysv47yos2hcurluudxwvl54uv4ih7pjnmnjrzuik6cs@a5oxhyyy6vsm>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 13 May 2025 23:09:54 +0000
X-ClientProxiedBy: TYCP286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYYPR01MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: fc024dfa-5f06-4343-a560-08dd927345e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gAhlhvjTPQii1xBBwhBcdayxK+QXc2zApEqgqTXKUoSR8AdOHrNgPcI93CAS?=
 =?us-ascii?Q?8TcEsSFLq/aJKjP0wigCTCHay5LuMzPi1aGg1WVV5sCumqTrHTwyySu5vMtm?=
 =?us-ascii?Q?Sq1qasEJW9gYtzescFECMoHoHbfCGQuIXYsshVJ84sWcpA0lZaF7Dvf/7ZeF?=
 =?us-ascii?Q?k+NabVhwDev75QIhi2fAMrds3/1Zq3gF5bl6pa8omg7/0J0spQ64ObxpcynP?=
 =?us-ascii?Q?NatfL8DMNsaY0u5dWB/zuR7rQtELCZiBiFl0AxFWdAFcpkPVsO5bkLncb3fU?=
 =?us-ascii?Q?bbGRDr42IhFgyF4eCaT2eoHSP3fG4cYH3Zl0/KFVCviPLsXqZd2R/2r8+ZBO?=
 =?us-ascii?Q?d6midKPqtn1WoDF4lk+CWBuA0RewJ8cvzUzIXHXrLVtdGItJ4u28ESnY8IIF?=
 =?us-ascii?Q?UQ1dPwxDwJrSjYcj1WNC4KLONlZVmSSAXl1L+bpb2Pdv1fxa0LBQfe7QMC8R?=
 =?us-ascii?Q?VHu/aFoJ2un1A6XAO488Je12zxdF3Eqy68Kq4P5co1IZ3omMuGHJhLJiNpp6?=
 =?us-ascii?Q?i1109zfEiKaS5+xzVpaYHkQf8yHikDYAPp8Uqve7/kIUp2xUutFaW+taBkAm?=
 =?us-ascii?Q?phURog07AqXKr1MHFQFCCQpGDDHGV8T/SuTpeZYpZbNZ9/zgYhXTYBzYByqj?=
 =?us-ascii?Q?9549IIr4uXdzxiHrNSC/X5uYxU/BYUNlSK9gZH2l0dtccUKviQ/0r5CLRs5C?=
 =?us-ascii?Q?W2++/Svn+aiREaX9u4Rh/2V8PtrVPDTNbJ9sIZrZYuaUMkKCukZEH0O8nXGX?=
 =?us-ascii?Q?OhFkOgcfcaIg7yBIBEhgnRMcH47LslRjXwBpjEKm/X0DJhSl4tgIh2Jgi2/B?=
 =?us-ascii?Q?wwGdtuYzA2y18TyCAF3sYa7YHII59/h7Votc+EeKMmKRKOp0TNio542k8CrI?=
 =?us-ascii?Q?5hy5lpvIe0++oz/vQ7wV6fgUxJ9+YZzywavfuvd3wn1xeord4R69hBT82XQp?=
 =?us-ascii?Q?7OMtNPim9fPVEX8s+Zi3oYJ/grMf87Qnbw8xoOM0j829RzR7UfqIKt2KPrXI?=
 =?us-ascii?Q?6jx70IHr1b2jJQaHA1/uoJDAgjfN8qZO2veh/hEkMmq2jokfxfKM5Wh7d/UK?=
 =?us-ascii?Q?R+8VAYRLWLDWi6QyaXLDm1tITbJ0o4jX7/aL4zx7UymsOxabVch7aKYM0mdi?=
 =?us-ascii?Q?hLx00tFiXbg6wBvKUNlgmIqwcEbR5r5oR7qTf6STsWW8t/0xRDAzPNTcF1tM?=
 =?us-ascii?Q?DE/CyNeRddzeNwY+gGOF1NiMF0D+48cKRAwPtSo8nb0WokV9jUBdthXO9Z9L?=
 =?us-ascii?Q?wPeeS91UmCABgJcnYDoxFfxMbf2yr4t0/nfkGbTlckQB//Qkkuq8SjBQM96w?=
 =?us-ascii?Q?mJBxX+JF5W8OswNPsGz4G1MFx3MqZ3bbo9/nmd2kmngdz/t93TsHpYlXewu6?=
 =?us-ascii?Q?8NyFj2UYJrslBCc6V3lyO0y9FbHHOsyl0zXx1ND/rOZ/0cfbAzGztByhS9Wx?=
 =?us-ascii?Q?CThHV9Vh+fAXhrJZWrX71uGqbvc+Gjhhc8wimYBDtzQ2AqyMjCrE8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x8lD4OKiK/eW9Ue5GVZvH9iVg/Sma0RcEGovyBT2bTgMbdQzKBakRHEmbh6y?=
 =?us-ascii?Q?A6nS7g+KCu7P3zzvd/INSm3g6ceaydfSaTDIFS/jGsKYBA59oxR+3jVdatPO?=
 =?us-ascii?Q?KZ2OYcf/2PF11IWQy64quMrn0J9edVX64198gRgO4hhaHVhy+wQ+n+HMaRXI?=
 =?us-ascii?Q?v6jRwPZKf0n2gtJvWICj2XGw1KwIov4TAv0SQhYkqSrDN+25JUfxnTVq6NnG?=
 =?us-ascii?Q?3pLqCun/v5CBa1UfBK2qlJDJDCpxbfkrP2/aXL//Dg4504S+SEjj2dUp8KOg?=
 =?us-ascii?Q?SGd28hU/Rb4l/vSwYOlEvEOqGAtYrBM9gSkpSQR5upKpHIMAIhal98YwRI4d?=
 =?us-ascii?Q?IDmKH+uPSAEZ5O4uSRDEqRFqItQNmCs5guIav2A0xq1YS/dbZL/RwfHE4NdL?=
 =?us-ascii?Q?T8ordr4fRJ51CB5ZZHjjycHi+Ud1lv4ZgklaE+64NYjQ0sBgy/Je6SRC3hA7?=
 =?us-ascii?Q?7/D90Xg2iSsouhmZ56PUI2YtRNgtNbEjn3Vair2pJs3J7bAoSW176jNIjj3b?=
 =?us-ascii?Q?Tp3XbjL3zx5YhU/XKRhSDn8D3CBQFjJyyuT94J0IBv/7qtRuVjQEgzXw7vap?=
 =?us-ascii?Q?BqCqCV1GavOgiQfH6gOCbcQYsZGTSDlXhJZY4kG/v2hefa1KRjVNaYOFaocM?=
 =?us-ascii?Q?P7XJHr81eXOMhU3CKrHg1KHzauR908KI6KTQ77XvCi7Ztzv2OAJ7JXCXC84O?=
 =?us-ascii?Q?UN03JtCs6+yxsD3AHXGGRN4LHiSgxZ3fvkQcQrBf4o5NlEER6ieNvZjgUe+q?=
 =?us-ascii?Q?siFaarczfyHRM31HrGSl5T8uaf28THu8ccbwj67JEyZdEot1zv2loKPt2+jm?=
 =?us-ascii?Q?a1UcgnzGXjUWMN6cmNhY0JoTHJl5AZ+t1RfNavxFH/m3IdjyHUxoD3lKhTy7?=
 =?us-ascii?Q?mwYjK+SnHPtFpb71dMY3aCavwlrcLAsNNzxNwR2vicV6hNClI7j1prKQGZkU?=
 =?us-ascii?Q?SNKZmxDavmcqc/VZAWtLuOURoD00HM8L+FPQO40zyu3LPbcLiXORj/xRIEA4?=
 =?us-ascii?Q?2VS5Agps6VgWBXJEBmroic3HreuptNtEeKSDfVN+oHRgpP2f/NyP0tgytqGd?=
 =?us-ascii?Q?3a31n5ZGr7rtPjSxdFuxjx1sMWQpITZEgtM8wwYGcycP6km+B/SODlKPqHKo?=
 =?us-ascii?Q?l5Boh9MJRYkYhZB1EtgUC56htG+cajVjGlseDk8/buhDMCi5To0kYWTwRe/B?=
 =?us-ascii?Q?ZAvmfMimTGvABScCr810ysxfu/1uLUbuOyDNEV+0V76Z/ZDXASChzbpPEYmx?=
 =?us-ascii?Q?mS4Sp5z6djycDLJK5ANUG31Uw/PRWwLvz4LXl/587MQFn8rlOiE+yGvN+PB4?=
 =?us-ascii?Q?vGpSTjcwPjLf33jimFTNmxbAR0NnR+wOVMKKC2hmtTrt2CTJUE/JpfFlYGm8?=
 =?us-ascii?Q?qycOVQgw0TtjHuu8uZPOiG9gilhOVZAzVb417n1mUeGpbuEJru9pRzEhdY25?=
 =?us-ascii?Q?PSLXUupiSjWeLDqemQKYgCZx5g3XbmcadZrh2DbmlQDnA1SX0I7q3jX+Imk7?=
 =?us-ascii?Q?UgrQNBNMs6H0NAgA57LOCYk5HauMWwIrKS1eO734glRSzhItVX4DrRyWxMMJ?=
 =?us-ascii?Q?Rp7P+Ty9sLZp2baq5j5bYT+taGESc+6qpBVgjvRCjLkhWLx64HKPwIm8YIvX?=
 =?us-ascii?Q?dENY4D/xc/jGqmcY6REZbng=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc024dfa-5f06-4343-a560-08dd927345e4
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 23:09:54.8863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ai2IyGVCQncZhPS8fqKYEiS1bmrSYPFbiEmaYvW3/MbILb1imE2KbYEoezYY3UbKKtdDi3jWQujsCFQ4gylUtDRH0cWnRB20UAkyahBlJehRzNpB06t8UUrGZImAbTTj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8093


Hi Uwe, Geert

> > =>	[ ]   Renesas R-Car PWM support
> > =>	[ ]   Renesas TPU PWM support
> > 	[ ]   Rockchip PWM support
> > =>	[ ]   Renesas RZ/G2L General PWM Timer support
> > =>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support
> > 
> > Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas,
> > and sort it.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
(snip)
> I was about to apply this patch, but here in
> arch/arm64/configs/defconfig is an not entirely trivial merge conflict.
(snip)
>  - I delay applying the patch until after v6.16-rc1

This is not a important patch, IMO.
I can re-post the patch after next merge window, if Uwe is OK.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

