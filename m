Return-Path: <linux-pwm+bounces-2638-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C701D91C7E7
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2024 23:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D4EB2114E
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2024 21:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3273EA86;
	Fri, 28 Jun 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="og8twFE/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="XrcvA/rM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2119.outbound.protection.outlook.com [40.107.105.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1417346A
	for <linux-pwm@vger.kernel.org>; Fri, 28 Jun 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.119
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608703; cv=fail; b=UFAuQGJN2SnK60qSoLJsvDxAgbMGEPQKGXpv78i3pbV7pKcnuLOa15RhB5s04qxIGGCvgGMVHA2h+qFKbYsvFO3smKCDTPoyN3rKCirDUi3ZKDX+BU7OgvSAaKwdp++AC5UU4xPIJP2z9bi/bG8MX6IonwS0Ju3HL+eX9qKG8O4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608703; c=relaxed/simple;
	bh=VZ/YYe1Wq1KdE896MvoKiCRNSwJgmfdJ9dlCn9tPWwM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uwh58dj+ehCSVW0QSrvSrbwQ/jW5Jb56wVF42fwW53pva4It4yC2dzAIKPrG/8A0KGdFrJpvrPxuC0B02Zy6X7RInAZ1dFruJn/7TryIyi9N8Iwr2tUD1I2q09hhqJqmrGp+H1rcABaFwh4swsuAVyNA745sarPr8G0qnKVSUKU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=og8twFE/; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=XrcvA/rM reason="signature verification failed"; arc=fail smtp.client-ip=40.107.105.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Awq21ZiM36NoD7Q6kFwHMCrNabteSURqbDg8xtpcidZDxv+c62Wm/vwXuf3KWYREMmbu73EdEKm5yv1BAsvU8TBWeNfC9InqMPQzHZv6aPEeM2JuUkMQa6UNU79qiJ4EPaznqeVOkMmFGG3jDQFqcg4nUjmLaJzsdz62W9wfwQyKheGJMEAZwWA1ZSFPBiNoXvyVnsyJMnKEQgVhuXHhaT/do1myUxkPBR0FSmWo+YR1Q1yf9LZzNeU/bKUTF4087PkLHeTN3HdpFPR56Rev3g0w3r8+NQSpKbtDRuUT3kI1Eb1+iJk5hJsAQGZX6CXc5QlCMquFZgJeAveuGFyR1Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atiUkONmLKeA0OUZjichqOs4EbxP0M0DSbXyJ2gdgFw=;
 b=Zn/nUAGaXuEVakeNWzHbe/5Hk17OEU3p3mgRaeCKAtAtx+vLmSqlHAquiOmBwSaQvwPwZBaffzz4anEwfepu+GuVQz5ttPr3YJhaCT8OBoE8hpdUr6ea/95IAruL5pVwISQwIekJ4CmMaQJ7DXre46QSiqebOBnwWijL9vusYqjDVnJeoU7WN0jDQTY/HEmuuoB2mPZPisZOF7p4in3ckBY79lk1F6gAyRYDPc32k926l9Jv6FSalebFlbQsFVR4aZAIMoq2qYYDYk8k/b4iURhV7sVA/08/n7iuvVqIvLY9o1z5RcdW+nBmWJPtV5w8Gqtn3rjxQ/K1IvJ/BFWNXg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atiUkONmLKeA0OUZjichqOs4EbxP0M0DSbXyJ2gdgFw=;
 b=og8twFE/1r3HeW/Uomb9YQbTEgbddh2cdBFT7V22FhMa1O0milkadjR+80bW4hfwdDR5jY0DAtr2tG+wxnSrEd+6aKMbon7k6uYXv+wtzy0TEynjRSXGP01hoHJ0hRtEMHKEtA7n8ITPAaUJCOM2dPUMGkHxcHtNcM859BBrKhqX/UAexmFVkGcyo7BnT4t8d3hqJV5hjvP9r0CEJ28LLE55tBBFdvHXh2fjerEqekRPKXyqutLz1srWBrfqL8N7D7wQCNNZfZvtQL3xaLRixSmYRJetp4MaJAswrei+MZDMnP7TVaLPwy3fBdYlKPG7kYPJAg4viCOucPIB5ZOrCQ==
Received: from AS9PR06CA0081.eurprd06.prod.outlook.com (2603:10a6:20b:464::19)
 by AS2PR03MB10060.eurprd03.prod.outlook.com (2603:10a6:20b:64f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Fri, 28 Jun
 2024 21:04:55 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:20b:464:cafe::b2) by AS9PR06CA0081.outlook.office365.com
 (2603:10a6:20b:464::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Fri, 28 Jun 2024 21:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.81) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7741.0 via
 Frontend Transport; Fri, 28 Jun 2024 21:04:54 +0000
Received: from outmta (unknown [192.168.82.132])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id AFBF320080F8A;
	Fri, 28 Jun 2024 21:04:54 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.168])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id E09622008006E;
	Fri, 28 Jun 2024 21:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0comVA21Ojg/ENRGTGBBNMGMpvCUnsEzUje7pyp0WEkXoREKggiP2yo8nVe0emZXw4dnzqYPxQgs1Qp6HEhkIwCRcCgi4wWcPr2JH0Q7oE2oDM6jIk/D/8DhXC4fDjCF2q1rAprhd9sWBMdFxn2vvvWvd4oRKnsrgpHX49rF8mizK+aEyT4qc5U13Ji0NK6Y0bgM1pYyHEssFoB7XIKHZFipAYKEMEtdVEcQFOIx7QcUlgq/e2R2k21giyNa1FqxjgL2iyspVUrVUsfxDZd+VtlgwRKK8ZrZILPdQWoIFkENdM1yLWLwvdiLE3spFsTfIDcfhLCDT2CGd8oMmeOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNz2u/CnL7KD1j8I7rim4AJVRjfIyhjDDnB/IRU5Xrk=;
 b=LbomLf8Vjz/3BdMUSa+psItgZ3X5MOmiJAGId1ckpB7iP+MRodimswSrcpz/Kr76Mp8uhnIpToE5oCGp60Hou3Zg4XIfnlFFhL7YpWsbmyiNxQc3qKhLhO4Ox2jaw2FzT2+0hwtlmZ1pAaioNcT1mj6vM6N8qxSZCJqfPw2AkHDvbrMxGmt2yGJVTzuLchk3IE4HuW48dWpaHrjkCwykrfXVNaJ0N2cP3Y7cQhAGOqLM6Au9FOLlvh70KQm8n/iu1Yz1Huz6qOcjSBn/8WfFev5nZC0R0OXXnDA9RKMmYoB9kpltExAU67VYjIRtP1RrCKGe116ajWUNMvjBBskckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNz2u/CnL7KD1j8I7rim4AJVRjfIyhjDDnB/IRU5Xrk=;
 b=XrcvA/rM1mbEyXKiXDo7lSdsb2qJQE/pSoVuitkA7Xd3QrOFKxveEICcR9NB1ogx7PGmwWp13yPPjAexUMN4LiIJq5QQUQepvTqIudfK+/WGqYy6to8VrfLbvmvMdyXsO+d6Rw9mrm3vKoNyhP2k03lRlTFAvL/hbbOW6O03yOXLZ/53l0xzuLYT5F80aHZdc7slR1XarGNXL3fAWVKKXx/r8miRqVoPnepxiLi4nqb04gQEO88sRCZkdTcWT5IvgeP7FIyzb/qjciOt8mJua7a9jg2MF4ijtZQQp8CmglOG5F3O4Xy4A293Wsk8x8HsTNVU4ySQ4wE1h2K3ONhfyA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AM9PR03MB7379.eurprd03.prod.outlook.com (2603:10a6:20b:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 21:04:50 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%7]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 21:04:50 +0000
Message-ID: <4a8452c9-9991-4bed-9210-e369bf11818d@seco.com>
Date: Fri, 28 Jun 2024 17:04:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: xilinx: Simplify using devm_ functions
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Michal Simek <michal.simek@amd.com>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240628063524.92907-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240628063524.92907-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR16CA0055.namprd16.prod.outlook.com
 (2603:10b6:208:234::24) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|AM9PR03MB7379:EE_|AM4PEPF00025F9A:EE_|AS2PR03MB10060:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9172f0-ff06-40a6-c9d9-08dc97b5f5e1
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Q2NGQzJmSWFRWS9IYVZ1VmZpdGNBbTZXK2d5UFdyWGtjbzNlcTEycFRPaG15?=
 =?utf-8?B?cU5hMnBxL3FKZG4ybGszcGpjd2lJcWZRbVhVdDBDL2YwSUh2ckNXcTZWOSto?=
 =?utf-8?B?bnFzNlVyZ2xSK2NnQkdudFdUdW41L25nQmVVMUQ1SmFlYkFqVVpFYWxIWkla?=
 =?utf-8?B?MGhrRk1hTGovYjVZYkxjbVd3ZUF6d2pWakRIRUlGdnVVT2ZoRWpTcXEyenNB?=
 =?utf-8?B?a1BDS2ZUam5WbWxsaG14NGVhU3J3alZvUVdGalNFU05uZlpyRGtDekdwRGlw?=
 =?utf-8?B?bjJQOXJNcjBzdVM5ZkRRenZYQUVOYlFhK3JYbHo4NTRwZ3JQR1Vic2tqQm1o?=
 =?utf-8?B?aDc4TzBNbGxubnA2TjU5N1pwZ3FzYnhpK2d2T2xEOXhuMndoajFnUHhrS1dZ?=
 =?utf-8?B?LzNIRjlKNHlaK2cvU2s3ek55dXhRdCtxVXVKK0RHOEpkQjltY0RPRUhTaTN1?=
 =?utf-8?B?M0h2b2Q3WFpNYWxsNnRnaG5rZHNwN2xKNmF4c3c0VUVCcndBZTNodzZHZXR5?=
 =?utf-8?B?NVBaMzNDZEI3c2tLWXRuY3FqTjRFYU1NcytnZDdGOSsrM2wxc0ZJY25KTnk4?=
 =?utf-8?B?KzBUejI1M1dKbm9kamxSMWpZQmF0VnVWdmZuMXNxRmd2UUZ2SUtYSGNFV2tI?=
 =?utf-8?B?WHE3Z2ZVSWk4OHh1ZWl0a0NreHRRbC9kTDArNkRlcklSQUcxVXdRTzg4R2g4?=
 =?utf-8?B?bXdVTVdTZHE2Rnl5U0xqN2NKNnViK3REcW1UanU2ZEZvNkNSc2ZHdlV3dDNQ?=
 =?utf-8?B?cUZPc3lnb09OZHRXZUVrTXZTaHE3TFB1K1dUd2dXUFphRVIvck5ZN2I5Nkly?=
 =?utf-8?B?VWRqQjdiUGhGL2grT0ZjMnVzeUhYT3o2aGRURk1kREZpUWNTYVYxTHhKL250?=
 =?utf-8?B?YVpIeG41cEZ4TWhodlBDdGZwSXA5K2dqTzBrME0rZzlla2ZyNVh1V1o0cXlG?=
 =?utf-8?B?VS9rSTZRWmdoWTc4L0pTdHYyVVpyb3hIRnpqdTdNcEdrMHN4RGJTV3lGZzJC?=
 =?utf-8?B?N1V1V1dzSmJYRXNSamN5OC8ybHY3VGJFYXNIcWt0c282c3Z6RHF6NWgwSTR2?=
 =?utf-8?B?bXpEcUh1YVBxaG03UGpBeWRNcDJqbWpadUczaWw5OFZRbUkwZlBYeHBuc2lX?=
 =?utf-8?B?M0VOWVo2QUswV29jWjhNU0RTSGYrT0l4WE1aYVZybnh6UTBUVXVwRVBOTXFn?=
 =?utf-8?B?cmprOTNBUm9oRUkwZ1pyeExwTll1V2NoWEdZdHhmd2lQZ3huVGk3MUNNSDlC?=
 =?utf-8?B?RWV4azlRVEsyb2NENGg0Q0pOY0lvTjh3eEQ0T1VQQ3hoWDdPMm9XRENJZXR1?=
 =?utf-8?B?UjBVM2RtaXZvUHZmSFJscjBBdWU4Rk1tS0NBdkVtQUZmWVE3V2l6NWU1cTVW?=
 =?utf-8?B?QWtPUGJsanZ1TnBaMGgwSE91eUZPbFA0ZFppUWkybTZnckk0ZitmRGJhU01o?=
 =?utf-8?B?MEdpQjZCaFFTZXlsM2JlYnc2aXBMR1ozYkQ4TWUzajFyeWljTjl5Y3hITzJh?=
 =?utf-8?B?d3Z5SzVFWExFdlUyNk9FNEY2OG1uS2cvV2hWVWtrZytKM3RxUnRsaVh4ZHcx?=
 =?utf-8?B?eDNqcVpaeW53Y0ptWnEzUUp1RDg5K3RtU0VDTTFpaVV4N1dtWXdWUkZUd3pS?=
 =?utf-8?B?eXVJZFhCbzV2b09NMnlxeDNJNUNzTHA2OTVPVk9WVU5jMFYvYnd4VEhZUnFY?=
 =?utf-8?B?OHFyWWkwaHZBT1lPL1psQnhLU1RzRG91Ym1Dc3plUXpJWWJxTGRQd2x4UEY0?=
 =?utf-8?B?SXVzK0NRVVJybUFlRk5DeDdwSkNOcFlSZUxTQTNMckswK09BMUxDeWI5ejFF?=
 =?utf-8?B?c0NWTlJHR3E3WlNTYm85Z0JVSVJyMFdiTEhzZ2R0cFhIRGk4aDNLWkc0OWJE?=
 =?utf-8?B?MDZhOUIzZkZpSjlPVkVtTFNMSFpFak9pUk8rUXltR3dSSHc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7379
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d5bd3c45-4411-429f-8cb1-08dc97b5f322
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|35042699022|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXQyaXFaQ1E1NXR0eHZOY29GNHRJU1dxL2dweTkxUmNUazhtWGZSSFpqZWY2?=
 =?utf-8?B?enZ1SU9HL1VjUHQ5Y1pBbmFrdHgvdHJiYWVCbjNEL1Z6OWVIRlpwT21mR2ZW?=
 =?utf-8?B?WkZKcGRMc1BuNjNTWGdBdCtac25zelVJKzhiYmFLT29jMklpL0kzamZJc1U5?=
 =?utf-8?B?TjlOVHMxSWVQNnFwZGFobDZYbDUrZnYrSEQreU5QZ2dNS1h6VFE3bEFad0FW?=
 =?utf-8?B?L3kyZ1lzazc0SVIrTVZYV3hUOXljM0oxamNIRTJqTFVJNzhNMG1DNG9PZUJo?=
 =?utf-8?B?SFpHSFN4NTA1QjJoMHRCTnNreFZsYUhrR2x4Q2lacW10Q2QrQmZVYkU5Z1hM?=
 =?utf-8?B?eVZPek9ta3ByQ0VnbVRaOTZNTWhYK0dITXkzcDFiVE9lWFl0K25NYVVtcVNU?=
 =?utf-8?B?MG1vZjA4S3JVUXlUYnBFUmNDNnZsNTI5SUtMYmlxcFRYL0JiQWhqY1dJSW9v?=
 =?utf-8?B?a3hzY09rV2xKcDcyelFxVVRaR3IwUGRxdEdkcytaVS9SckwvS1VIb0xxcHFJ?=
 =?utf-8?B?RlJWLzNGQ3FwNTdyaWt5NzZIcFJCbEhEdmFCL1BOUmNyRVF0VmxNaVZXcjRr?=
 =?utf-8?B?aHp6SDdZRmFWN2V0aE5Nc2RZUzNIV0JrdW1UZngreTMwN3pxNEF0RDZYQ2NH?=
 =?utf-8?B?R3lSNWJsK0pJV2ExZEE2SjV0LzgyM2F2cmtlUlgxQkhrZXpsd3JUYjBsd3g0?=
 =?utf-8?B?N0pXOFhWaVlVRHVaTDdDQmgwYjdHa3ViSFlXOFFQRHJ3b0lnd3gwUFlrMndy?=
 =?utf-8?B?NGNvNVpLL1llcHQvcDhhNGR4Y0FneWtIWHFqaFd2MkNJMXhQOWhYanIvWnFs?=
 =?utf-8?B?MnNSWWxmYnk2UytFRDMvSytlR3N2UG9TajlwdlJXZ1NVRU9sV2FqU2wxMFlG?=
 =?utf-8?B?L1oveXdqT2ZpYmtyMjRhbVJsWkljbUN4aHpKZzh6emd0cUhqSzhnK2NTeFhh?=
 =?utf-8?B?MlNBQWZpUmwzY1ZFZUYwZEUzemRSRUoweXJCU0lablh5dlRiNVR4SXdYSHRy?=
 =?utf-8?B?SHZSTjJpYjdrYUw4aHlQZWtyZ0xaSk5yT1VtZys4Y1p1TXJTUjJ5WWpVaWhE?=
 =?utf-8?B?RHZzWDM3UHhrK01GM29qYUlxUkVVUDMxS3NkZGpWRGlqckcxcWRZejV0TlZT?=
 =?utf-8?B?cGFyRXVzYk1GMW9aTHZSUzQ5M2FicGd0eXU5TDlTTVNqNmlxcU5mSUNCNFpM?=
 =?utf-8?B?ZVovYlByRW5sa3JveHdUUGcxY1ZzMDBoQTlqQ1NtVFdUOFhlOUpVWmRsV0RW?=
 =?utf-8?B?Vk1Yc2hzdXdPWkNMWEx0dmRGaU1mcHNMcHF1VkwzdUlJVXJScGpiTFR1QU5C?=
 =?utf-8?B?OFd1ekhtYU1LcEJ5QzV0OGg5OUhsMEtjUVpLcmRxV2NCeVBLQ21TZmw2S0hi?=
 =?utf-8?B?MjIxRE1PR0VnVHZKOHk1VzR3MDdOUXVlelBYWkRBd1ZrNTJjRlZiUm55TjZ2?=
 =?utf-8?B?N0MxUE9vUzhCWThtVGRucHp0bTNVZG9sbmlwSVB2NVpVbmpmNFIxNkgvb0to?=
 =?utf-8?B?OWlBNVRsRFdxZk5vQ0FxMllYOUQ4TlVBOEs3T3ZFdTRHZzdObXBaS2lySGZN?=
 =?utf-8?B?cjZvOUpoVWJIUHVjMFd0TXVIZm84NGtFNkxqR0NmdER1SXhITjBaV2NHK1Zr?=
 =?utf-8?B?aSszdU1iQ0xnblp2Z1lyeFg5dmE2OEw0NW8za2tMR05BSy9YTjJuNzUyWW8w?=
 =?utf-8?B?Qi9BRzRLOXpWUTg2d3JVUzArUkxJUzRiZ2FiTEMweXZQWUZWTnNadm1QRXFj?=
 =?utf-8?B?bk5rOFQwbFpVSytaQXdSa1VGRkR4QzQydHZaVUQ4M1M4MTd3WXZBM1Njcnhp?=
 =?utf-8?B?RWhnYWpjUGxsTGQ0YjlHMWt0L2prNExrb0lmZ0dsWkRlNXIzdDV5dWVzTmZO?=
 =?utf-8?B?NS9Ya1lycWpPNkdqYXY0S2xWN1kvS24vZEhiZGZncnJJSE1MdlkxYkVJenNK?=
 =?utf-8?Q?oaVHDNT2GqBNOTviR3i8mccMtBC1K4Bp?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.81;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(35042699022)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 21:04:54.9388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9172f0-ff06-40a6-c9d9-08dc97b5f5e1
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.81];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB10060

On 6/28/24 02:35, Uwe Kleine-K=C3=B6nig wrote:
> There are devm variants for clk_prepare_enable() and pwmchip_add(); and
> clk_prepare_enable() can be done together with devm_clk_get(). This
> allows to simplify the error paths in .probe() and drop .remove()
> completely.
>
> With the remove callback gone, the last user of platform_get_drvdata()
> is gone and so the call to platform_set_drvdata() can be dropped, too.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pwm/pwm-xilinx.c | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
> index 3a7deebb0d0c..52c241982807 100644
> --- a/drivers/pwm/pwm-xilinx.c
> +++ b/drivers/pwm/pwm-xilinx.c
> @@ -224,7 +224,6 @@ static int xilinx_pwm_probe(struct platform_device *p=
dev)
>       if (IS_ERR(chip))
>               return PTR_ERR(chip);
>       priv =3D xilinx_pwm_chip_to_priv(chip);
> -     platform_set_drvdata(pdev, chip);
>
>       regs =3D devm_platform_ioremap_resource(pdev, 0);
>       if (IS_ERR(regs))
> @@ -263,37 +262,24 @@ static int xilinx_pwm_probe(struct platform_device =
*pdev)
>        * alas, such properties are not allowed to be used.
>        */
>
> -     priv->clk =3D devm_clk_get(dev, "s_axi_aclk");
> +     priv->clk =3D devm_clk_get_enabled(dev, "s_axi_aclk");
>       if (IS_ERR(priv->clk))
>               return dev_err_probe(dev, PTR_ERR(priv->clk),
>                                    "Could not get clock\n");
>
> -     ret =3D clk_prepare_enable(priv->clk);
> +     ret =3D devm_clk_rate_exclusive_get(dev, priv->clk);
>       if (ret)
> -             return dev_err_probe(dev, ret, "Clock enable failed\n");
> -     clk_rate_exclusive_get(priv->clk);
> +             return dev_err_probe(dev, ret,
> +                                  "Failed to lock clock rate\n");

Isn't this actually "failed to allocate memory"? clk_rate_exclusive_get can=
't fail.

>
>       chip->ops =3D &xilinx_pwm_ops;
> -     ret =3D pwmchip_add(chip);
> -     if (ret) {
> -             clk_rate_exclusive_put(priv->clk);
> -             clk_disable_unprepare(priv->clk);
> +     ret =3D devm_pwmchip_add(dev, chip);
> +     if (ret)
>               return dev_err_probe(dev, ret, "Could not register PWM chip=
\n");
> -     }
>
>       return 0;
>  }
>
> -static void xilinx_pwm_remove(struct platform_device *pdev)
> -{
> -     struct pwm_chip *chip =3D platform_get_drvdata(pdev);
> -     struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> -
> -     pwmchip_remove(chip);
> -     clk_rate_exclusive_put(priv->clk);
> -     clk_disable_unprepare(priv->clk);
> -}
> -
>  static const struct of_device_id xilinx_pwm_of_match[] =3D {
>       { .compatible =3D "xlnx,xps-timer-1.00.a", },
>       {},
> @@ -302,7 +288,6 @@ MODULE_DEVICE_TABLE(of, xilinx_pwm_of_match);
>
>  static struct platform_driver xilinx_pwm_driver =3D {
>       .probe =3D xilinx_pwm_probe,
> -     .remove_new =3D xilinx_pwm_remove,
>       .driver =3D {
>               .name =3D "xilinx-pwm",
>               .of_match_table =3D of_match_ptr(xilinx_pwm_of_match),
>
> base-commit: 642a16ca7994a50d7de85715996a8ce171a5bdfb

Anyway,

Reviewed-by: Sean Anderson <sean.anderson@seco.com>

[StudioX, SECO SpA]<https://www.seco.com/applications/studiox>

