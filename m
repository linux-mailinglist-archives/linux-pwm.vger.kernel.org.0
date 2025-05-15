Return-Path: <linux-pwm+bounces-5991-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E25AB7DB3
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 08:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31001681AE
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 06:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC07014D2BB;
	Thu, 15 May 2025 06:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dEBEhESz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011065.outbound.protection.outlook.com [40.107.74.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FDC1F09AD;
	Thu, 15 May 2025 06:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289945; cv=fail; b=WyuuYyf0lKTBA0sne+nTR93ongYHWYLmpLg9zTfByixm9nf12AMiajFc8pd4CpjGK1SjT3RtetD5NASE7kBW6YoYfkX27E+6mDyvFZQPSYU2Ia5mq5q6c/uWnuFbvxQgnILkWtxtwe8gRP/AUdHRgC0hr5crcI6Q0q4y9kuKzlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289945; c=relaxed/simple;
	bh=w1r6XL/L3bczjolaVJS+sjBPctV8RLrc9chhn9KXdl4=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=hFEOufda5erAQqZ730rYP3MjpSiiPPwwCEyvD9j+X7Ucp0xBGnR/mY4fvzWYZ4VZU0l4gD4byIRMEF86ZfwNVoz/VdnQtu1b5ojVJM/2M2Fg6RQR4tbxzfWh0rIAZQxsHd8hT9S7cRZd6shIIoVFnRQ4Gpx8IkPAPbPug/hMbx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dEBEhESz; arc=fail smtp.client-ip=40.107.74.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9K5UcvhvbVby2scjKipxVb6DVVCo9eGRkqxjfNRLO2qPIMrBrT+bFy7vk9fCD0LBj5R3P5g9UUHFEu7+tybVca6y/3kuBEunKrTggpBtkkyF2+raOEujPeRWgCQYJsqlzbfGBIS4r3emMgRXiP1p0orx4MVXkdAmEhLMEERXels40EJomhWV0SFvzPpL6Yyy4BsCDPblV164gUYIraZU7qawyqlGSM77FgK2zurQxuLPkLodTLGjVMldiAO29igz8XsvAtIOWNK3zp8tStyakCneKStbM1NHRqquPeKF+ndIre5M2U3FuU4hOEfKw9Wpz2ZKSbA4VCV8WiIrV6pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSKX83TNiHxe14JLazXX+y5vKImunaSjApuXINjAH6k=;
 b=Nl7b6jcU7g9A0ivZpFODNFe64oysFv6HD7tzZMNdFJIWJC6M+5TTpxBMujTCQNE9SgCGtLUOZE7wiOX1ZGI2jAjdKF2md6Jr9i47kPC4+DUykjT9bt7E73WZJQYNZ8ljPp6JxLG5JyurYGIv6HlxtewwvpFLORrroYHeeAIb1sx9cbf4tXMHOjF1CLkry3RnqCIKl0T9C05R7xD5pVZnSkIiUEwngxe38GmzB1g4WtavXe9+JwjI/LsPJC/CjQ5mYV9xV6vbUHp9YeBxIAkmC5BFI8scIgYm30V5J9sS/9J/CbwhWCJxfk80SgMKnGgaKOQNDV8/gt3OWRTzySHTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSKX83TNiHxe14JLazXX+y5vKImunaSjApuXINjAH6k=;
 b=dEBEhESzkSVP5VABC9deRmruASpP246UlL5a9mZMTpBwzTVC6Vte89CTwR0AWWHxW+G4ZpEehw6sU4K93GETj/WpgOzvRitSP4Wxw2fvLPgq3hZSeTAxqLBFS6m2xIDiqY8UT+9dP47ERTjbs87BYBfdBRx7v2FlmcYsO8We6FM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB6671.jpnprd01.prod.outlook.com
 (2603:1096:400:9c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 06:19:00 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%6]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 06:19:00 +0000
Message-ID: <87ikm2tmzw.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,	Catalin
 Marinas <catalin.marinas@arm.com>,	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,	linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
In-Reply-To: <CAMuHMdWSN70bhVOkmL9ms0S2N+N+scyPzxCPxoxttXKsUGa8Zw@mail.gmail.com>
References: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>
	<62gkja5ysv47yos2hcurluudxwvl54uv4ih7pjnmnjrzuik6cs@a5oxhyyy6vsm>
	<CAMuHMdUvR8rp2PaFLsyQ6ZWLqw7OskP-ZwVjRC=AARhK8g-iYQ@mail.gmail.com>
	<wytdfpewvcesc6racyrpa4cya7wku6dc65edz7oma7penqrqqq@2g54gyprttxt>
	<87y0uyu7i1.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWSN70bhVOkmL9ms0S2N+N+scyPzxCPxoxttXKsUGa8Zw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 15 May 2025 06:18:59 +0000
X-ClientProxiedBy: TYCP286CA0059.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::16) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: efe927d9-c8d3-48e7-bed3-08dd937861a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O8OI+7HeHMXmy5UL8lvRKVegyHnmenM4aTBs3f3NySMK7IxNXz2Kp3dX5sSJ?=
 =?us-ascii?Q?v1myzLT8cLMRY4KpC5LFgDNBhiwk/uCshEOI6Pj0C3eXXaOzi6JLNRRHK3js?=
 =?us-ascii?Q?rXWRhB+/TkISh4htWnSL8fmyZS3VNOXSpiLz8B6KAFpSAa8MdVqwITGKA1H2?=
 =?us-ascii?Q?NNG2ldWv57iv//gYCZbovTVBKdSGfVvUJNh5MP23PWE7jzvLz3IjADE7lIb7?=
 =?us-ascii?Q?LCk5b76nhTiUPL+M/JtioUlyCkQhFN2N3tP5IaYb7lGVxDBnpNLDgYOO/sVN?=
 =?us-ascii?Q?2HV/ncCqZwlTOmP0R63RQUdCtpKGPfJdMpriyxvAmEIyIdMg9loz7+eXz/SQ?=
 =?us-ascii?Q?/nojkLeCDulTyNSxUzzEiXBDyUp8+t1F7xLPNhv6f4RZDnc8oZ0vVeqLLJvE?=
 =?us-ascii?Q?swcm1Rkl72CXaQWdO1btZnls9t70h+0Wtd9a03v/vlkR+ROflNTpKFYIG/dr?=
 =?us-ascii?Q?niwH+/ttdX5XWsrvyylMzqBCzTVfrmEdOVCz25+ef63SrfQk2cJ6YQHdCumf?=
 =?us-ascii?Q?LuzS55TK/7lw/ymdivu+pQSSP1yVeLnBrg20+Qmp66prLafFAU0d7XdWYCW/?=
 =?us-ascii?Q?oZUCd+C+UZxjOYylDxqcpsB7zeXl9Zhum+xrWPucrHM0GFxAw0KXt7lr6qNJ?=
 =?us-ascii?Q?OR4Fo2YFWmvBOkmL4LvZxo028sUqKbnVB7iy7E8dnqcwHb6ASvP66Jb1QPjk?=
 =?us-ascii?Q?hzLyNoXAyGV4rn42zD4SjkYz9L8KdOjfLKFTy3xhAps5qGN1v5SB02YnoN97?=
 =?us-ascii?Q?8BuDnb9YoVOVFgblLaI8Hu0MTjIktGF+eZJydnFA9uoaJtfZ1OD+q3N2a8w4?=
 =?us-ascii?Q?MyO4UUWSGgCSh27JtRRv4XvjQSmMdMSTVE6gKzVnhVQ8Z0o+s56URQW3Y7vS?=
 =?us-ascii?Q?6PKrpGjbFfslzHuqiy4CJ63MyqAmDHTp+Ca0+g71/o/lxlhAouKpiz/ilwGW?=
 =?us-ascii?Q?/NvGfjsNZPZaEfIch2Lx0+zAQ/J7Ep9JT9EkD9z4qps3IjcCZu759ACW8pMQ?=
 =?us-ascii?Q?N5xjtUbZq7mmI6mzIsPnepm9FM0LSc9RN27LbUX1PQneq0Toc3cxBLUw3OwN?=
 =?us-ascii?Q?B+Ua8XSLk+JW/Ntv/Cb8I7ByTgZ0YOGSg70X8f2MCaVC3Jq4SsjyDXakbNBf?=
 =?us-ascii?Q?1eTigombtSttZ/qs8kvd1MQwIyMYAiye+sz7rguGACyeSY8/kpdlR7Z9W/Eq?=
 =?us-ascii?Q?xM+kMgbOIGBkNEaGWsGrGBbzls3xUrmsdp/DaZF18QI4U4o0GBKPLtwSuI3E?=
 =?us-ascii?Q?6RgFLLErgFqjpPcdSjTAkOPF6kQzNwB2F1jDANvvM4o6ioJ0fSjpvMI+sI+v?=
 =?us-ascii?Q?LoLN2xKI4Bky4DWysy69p2oRedJcMbCifm2QsE2y6C+eaDAVq5Y8qtOyeDiN?=
 =?us-ascii?Q?e3378G2aOIwU0dKNrW/QK/NUsa8kOt2sIsJ3htTDTW1cz1KQlYMq/iXyG/sI?=
 =?us-ascii?Q?Wet2zQb5LHl5bR/qdYNkHgmzecB7wIwf+vIOgZWj9m+B1Mf3rer2/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vEVykBveWjb29lRYUgA8NSYwQUEX5XCGyYKPs3DVRyBNwbd2HAMTGLoaSBMH?=
 =?us-ascii?Q?OmBHjaGLeqCMXcncaTdW7BeOn85tic1ryKsnxppMUTemK7e7PfGMnMh4+58m?=
 =?us-ascii?Q?SGVY4+4r9Egr6zfqofTpXqB9UDW6s6IRkMhwjk6c7FPhRAYGbr93Ya/Ye3sA?=
 =?us-ascii?Q?J6e6z1cMBqoMpkS8BBPvUqg+Yby0nzE1HEjhTlNjfI6V0RwsWmDUHtfRW5GU?=
 =?us-ascii?Q?pozPBElt1Gnfiezdv+GyF+APNQczPneKErsH6KvepEgKoplnOmsGiB8U1Llx?=
 =?us-ascii?Q?jBw7EEmo0gvGK6RMzBNQSg26V3ffOxl+umZ4qlN9cjF3erpEOsk3oeyi3u7X?=
 =?us-ascii?Q?2WKC/glBktn7kBr5xASTRJCxjXN6zbIkVWAzvmUywzZ3WtrO910kZgyNutC5?=
 =?us-ascii?Q?ZNmQPBsVRwrrFOmS7+wEVqA6GJ9UhV8amhs33+ljnBE6sZMlw24cx7klGLHJ?=
 =?us-ascii?Q?zawEKRomp4WIJfUS1bsC7URAiMz2E6kl4gk/gDL2vqg+5aefK9mGVo5dWmK3?=
 =?us-ascii?Q?1xgsGLtMRoVokyMPrasBnmrIXxVI2d31I9JWyXSPEzP4VvlZLdo2dU3hCgJi?=
 =?us-ascii?Q?ZqJ1920JG3pAi0es2dDCp0VtMznPdAZnYPCJfbrtLCoNxw3RDL3ky96/lnQs?=
 =?us-ascii?Q?ZF1jZKTF2QV+yXLtcKlrfIuVN5uFuDRh2bCk+1mMFqnw+zctF6C8ekOuxgAv?=
 =?us-ascii?Q?LZdjKHqOIrDKOWrhhhjns/UMqINmdkb+2aTqRT4wRAVdq9uhPDV8GtvVOs+R?=
 =?us-ascii?Q?yQm7Xj4JXF/RSfDyygNN9u9puPB6qosqCmhlgfLga7wLGcoTDL1Jx8U9ICmT?=
 =?us-ascii?Q?78Z5K85a7b3e14xt5dyZf4/iMKF91FCmSUDA4CUNcwUujhzUyfOWT2yeaWLd?=
 =?us-ascii?Q?UWOROtjUhbqfdu0KGTzHejlN7AjfrZbHh/22V7+ck8UpFbziLW4h3exqXYFY?=
 =?us-ascii?Q?cL9dBkuL6fAjvqz7gO53OvOeCTgmPouXpzATADiEW6hRMTeSLSdMLYhaQ2hA?=
 =?us-ascii?Q?yKdGpcce9BO1LTlsiB6We446GI5C0CFRlNqnzqgB27SCIgCyaEdwASz4RdL3?=
 =?us-ascii?Q?lxlzdP9iWEL4Z3mZ8B1Bc5VzWK8//zdks+JsuuFE8Gn5uL/mtPxKTfpPr/Ri?=
 =?us-ascii?Q?wI6t6Wqr0H6wTJHC6o+snLabeI97UQvfaMl+JpHkOXtloVYV/a5TQWrtqOyN?=
 =?us-ascii?Q?obQPzwMeSC3c8y/kkZ2ttOR9f7eBbZRGqzyOJkBXgSybiL78IJzvqrO1DsmB?=
 =?us-ascii?Q?ZsQgLXK/wk3/ywxj/8+08ExoIsDVoBWKgZ8rh7NtAvt2xQ/B0pwXm4DvdcLr?=
 =?us-ascii?Q?dcKnoTKM6LLyksQazICcNqtrS3O68BvU1C+a68hUuO4Y+XuQfzgdesnY7p5I?=
 =?us-ascii?Q?zm8UiOY+FikJYxjVV9r5jqO6/ScbVEHfINRw10CmJrVzhxQ0l+0l/Kb9l8WC?=
 =?us-ascii?Q?zrwvtUtXBWp+CPGFkFb4WqMB4wm6u6DP93OuR0WrczssTzJrhlu6ARSCJOI3?=
 =?us-ascii?Q?IsEmeg1vhTQUD7inht2XySwrKHwov8t+DHv2tK1P04vKjIOoFOp0NtFpFUCF?=
 =?us-ascii?Q?7sExzYzOUHjIqnmF8eqDr/36ZpZsFX6iHS8Xi7NUYc/wG2Uwa0Heh0Yul03k?=
 =?us-ascii?Q?9wnIF6L27SvnfD3aqSsWjTA=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe927d9-c8d3-48e7-bed3-08dd937861a0
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 06:19:00.1437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0IU9cnlOwkV7x69SjKWH2j2fhX9fmuVYt0eKInOe7lQUUOQQZ5n8485KjiiFU1+jmZK5g4TRivGhld9uRWhoxBWqIrj2drLIZEbmUrR75Xq6xMtYKYpd22r7c7/xBbC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6671


Hi Geert

> > If so, I have a plan to post patch for renesas_defconfig to update
> > symbols. I'm thinking I will post it after next merge window,
> > but please let me know if I can post it immediately.
> 
> You can send it now, but I cannot apply it before the Kconfig
> changes are upstream.  I do have to update renesas_defconfig in next
> renesas-drivers release anyway, as usual (cfr. the top 3 commits in
> renesas-drivers), so I can take it there.

Thank you for your help !!
Done

Best regards
---
Kuninori Morimoto

