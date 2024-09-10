Return-Path: <linux-pwm+bounces-3181-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D57972718
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 04:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A83AB2371D
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 02:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06C114AD38;
	Tue, 10 Sep 2024 02:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="TCy+EER+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED82FB6;
	Tue, 10 Sep 2024 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934969; cv=fail; b=jKDpuQ1RAiziBmReGWxkJoaf6vEvFcSO197Q47anPJ6U+yUEgrIjEBZ2L+Jl3sQ4zRwH/o+6tILFXkDoV6fdSe7El66t8itGOjAjbrejS860c4/gQN8KtIsO+fhIohPh0wZmNgwRhSjJRO6vIEZzXBTNbUsUuBPxcLwSeBahNtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934969; c=relaxed/simple;
	bh=Esm9SeUoy3rq2iwA4jJqKP4eVac/KnsX4sbjB4zCGb8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R+3r9eNKy3l+BkXlEWQCxLJocmpBKEvscwA4NQTMbfGnAlDIdmnrOSqAOOe4U6At4+TKXbQtUDoHapH1ey73nzqrflLVwE2pLaLO5OmJql2wIvSxgiujPZFTzwvRXOWjV+ATyJ/f3GTRFPrW0kSlZpZqDWuggxN9p2eXJBmZ6z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=TCy+EER+; arc=fail smtp.client-ip=40.107.117.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbdn21ZxfHuJQBvpc83YEyeETp8o/XzeCAkzbbubxtnjLc65BztPqxd5sb+cUcAGQE+LN3UfABQgfRxM8BTu/uLjVVyVDQvAdyXNPegT9VC2TsqhD7P60WiqGNXxcECZMm/bSWmoLfnl5oMd/ZASMP+/Rqlf57A1foItUO5/0te1V6r+k1zsJ7TwWT2DfwsIrbQ/ay0Oe92rarHunqyf5X7XLsdwfW1ueaFtd+ocqdO2uVYgXO7EnqO8gKqWzOGWBTmQDYwYGfAw0mtJsxpyLgmpIhFOJIQoawXTn5jAWreOeMCrLlrywraZuO8MRkNbyG0B+mhCwR4MhGrsOsAikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofUAISy9bGR4TM5pCTSgjUbg8kAgrPKbnBS9O+i+E8g=;
 b=vUPjCymNp/BOTEJaFyKsbMRx321CrFUTpAErKZl8d/vk1A1D83w5K5hZ0my+Uekcs+e8x/hSmIIrZv/Z+0gNx/i69Ib9f5zmsjEmncwUVbBDz+OFCNVR1ONIzPfdFJoTDa/2VkDdC9MML5DZljyEkr80IhzQzfXjVkPo/lGyjm7gZ3CAZrHg7/b4wfK+xUeEHngE1x6m08O5tl+5LRPUvyIu5+hu5eNLKlbXI4kpYsksyISSPrjJK9ksOTshiVafQee7wdsWWnzB8wZD2yiV73vxZtMoQpfh5CwD7o4t5Ilrt5Y5NuayBKzV4ncpcTUtPdE9SV7onoiQ6QuReIsEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofUAISy9bGR4TM5pCTSgjUbg8kAgrPKbnBS9O+i+E8g=;
 b=TCy+EER+8LpU3He8x0yFj4UX8igzOPDdXV4umNaujTZTEll+RplSRmzEHzJttt8IUnStnnpsOicfrh59F/DWocuDOGtQofPmAyGSSmjJAwSX8Ly9YB3xBwPc++vK3l9rId5X115RcCT00jmI6LrRb0WAnyOTAy/51IRfF9txSQJC5rzeU0lYYvqitJ/3roPPJD6vs9XT9ABNitvyVAZ7zH8geQcpI7/vpm+SE6PVYsJwUaZ2ZVyn+4XOYc7TgS4KYGV/HTzjGN1e4g5/nkJo2dCnPerLVu2T66gLHEFSfn2VZi+bbC4mCoOQO8QFj6IEJaeZmxV/IUGaA7wKRjT1HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by TY0PR03MB6655.apcprd03.prod.outlook.com (2603:1096:400:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 02:22:41 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732%5]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 02:22:41 +0000
Message-ID: <6326decd-cb9f-4095-9aca-4d40819d2eb4@amlogic.com>
Date: Tue, 10 Sep 2024 10:22:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH 1/2] dt-bindings: pwm: amlogic:
 Document C3 PWM
To: George Stark <gnstark@salutedevices.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org,
 Jerome Brunet <jbrunet@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>
References: <20240906-c3-pwm-v1-0-acaf17fad247@amlogic.com>
 <20240906-c3-pwm-v1-1-acaf17fad247@amlogic.com>
 <fcd005d2-dba4-4980-8d0d-f55632c7a6d9@salutedevices.com>
From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Content-Language: en-US
In-Reply-To: <fcd005d2-dba4-4980-8d0d-f55632c7a6d9@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To JH0PR03MB7384.apcprd03.prod.outlook.com
 (2603:1096:990:11::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|TY0PR03MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 8708e577-e9bd-4687-2891-08dcd13f7271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2dpUHZkWHVuYzhQZ0FKTVVmZW5qZ2JxZGZQdUpqT3RFdFhCM3ljVDhjcUdC?=
 =?utf-8?B?M3VTRm5iY2s4eklhbEZ4eUNVWi9nK2NmUlVCZGRBZXNWQlE5dVZzS0RlVGRD?=
 =?utf-8?B?eG5wckVJRHpTZmdOMkwzVGFSTUZTa0UrZncweGdkVWxYZHJBV3dXaExOUkRK?=
 =?utf-8?B?NUlLNFVCbFB4ZDFKTWRLVUk2RzNBRVk2cUZ3L1Y5aHUvK2M5d1lKeXkzSE1X?=
 =?utf-8?B?V2NNZUxMMmhTZGlTZHpPcVRTbDFNcE9UZnd0am1Xcm1TdGRuUnZkQ2ZSOGJJ?=
 =?utf-8?B?Y1dBemZIem5iN0pSMURxOGwwNGJ6KzdIOU43TUdZL0xTczNHVWRNYThOMTRv?=
 =?utf-8?B?M1lwRmJQMzVYWUtoa3ZOb0FLRFVPM2lMVjFnVy9TUHFqR1R5M01JTm1RcXh0?=
 =?utf-8?B?ektqeUQ2NlVJbjYzcStSaTFUTzByWVB6N1g3TUQzbjM1elk2eXZoWGFyTjNa?=
 =?utf-8?B?OWVYOFdSZ2Q1SVlPYnZVK0hkU1JvdHFsWmpjRDdSekllOHFhM2E0WHQyWEY5?=
 =?utf-8?B?Qzd6cHV5dWdEZ3BENUlidWhtTnh5ODV6cGtYWlMwUXJKOENYTDhNdndXalB3?=
 =?utf-8?B?TzJzU1lRRU9kMEt3SHdyWWxwbVY5ZjRBN1I2NkNWbVowZUd6R1V5Qlc0Uk9W?=
 =?utf-8?B?R096MVRxRjFJRnBDSXl1Q2czbk9lQ21teHVuaEFUL1BqUUxST3JaRlVnTk8y?=
 =?utf-8?B?L3pMZXFXTURZVnB4M3hjZXN1aDd4MEszaDlrV3phbVJKQVZwSVVmeUFKV0tn?=
 =?utf-8?B?cFVYWW5EUHZ0RVJVTnhCcE5YS3AwWEFHaEUwbVRsZGhDd0pwUjBCRkYxMThG?=
 =?utf-8?B?RnpEaURNNXBPQUhyejY1YlF6U2pFQlpBQ3N0SHhiR3VJRFJLQ3Z1SExuSzVY?=
 =?utf-8?B?TEJVaVJtZmM3YVlzOWQ4K0lDeDhQQ0hndU83aFNqUEhCNnhZb1BIcEhOTGVp?=
 =?utf-8?B?bEFYeFhyZHRsQ3lBN3A5T00yNXY0VXQ5MHFDRk1COW1HcTRQTFU1YkdnYkpq?=
 =?utf-8?B?R1pDaVVoNko0M09oQThZdjlweWN4ZFBELzg2OXpjdU1qenpoQ05LN2V0ZFNj?=
 =?utf-8?B?dllUL0J0M0tIVXV3cWRyaUZnQkhMdE4wbXVMOXZKam1XbWh4U05vYitVb3l4?=
 =?utf-8?B?MUxPMElZRUI2RFhJQ21JaHpJMGZYR3RrOHVlM0QvQmg2b0hRVnlKY25LRWNo?=
 =?utf-8?B?ZDBHVmd1Q2VtajJweFowTlcyREFUQkg3ekRBZGJld2V1a1RScE9tR3NTa0g2?=
 =?utf-8?B?eFphS3BsSFFmSDc5MXNQTHhla1hlc1dOQ1hydDlSQmFCdWVDbXRvUkg3dVJJ?=
 =?utf-8?B?K3FCQ0x2cWlLeEdVeFJ5SHhvbHBzQjg0bkJGdG9tejB1M3d2VEozcGUyT1cv?=
 =?utf-8?B?bEJ0SVlTK1lzWUZrMnBJU29NNkFkK2xuMEtZVFN2WTE0eXBvME9ML1QyR2Zj?=
 =?utf-8?B?MnkveThCR2JONFRhSmhtWGFtL0RzU0NFbkJ1QThVZzhDeVhZd1hldDU2bEZU?=
 =?utf-8?B?OFQ0c00vbEFKQ3Q3Z0NsbVAwcW5xV0VTL2ZvNTRRYko0anI5NHpSVzI2am5n?=
 =?utf-8?B?K3ZIT0ZhQnIyd2J2RjV6NnppS2d5MSsxbDF6OXA5NEY5NFJZakNkZDVIdm5l?=
 =?utf-8?B?MHJNSkE0Q0p3UzdRUmcxeURlYUhSanJnL0kxT0twU2RLakhxekg2dm93ZWhO?=
 =?utf-8?B?R2d5WGJwQU9XdUpuVEx1S0ZoQ1JoNW9sODdHYzdSeEt1OWMwNWVCSnNpMzcy?=
 =?utf-8?Q?Wv2WT6VbArLSlhdnmQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm9TNExvM0l5ODRkcXNOSVNHYW0zclFWWll3S0NiN3kvL0RHNDkyUEljNkI3?=
 =?utf-8?B?Q09mM1U2QURWMStWdnVaNjU4L3ZGYzIreTJwUTZFelVCUDRvN3hkLzVtNEpw?=
 =?utf-8?B?dkNwQVhLbjVxNjNqOGZOQjVTVmJrcXNLVEVKYm55R3hOenFNVGVlS1FKS3RJ?=
 =?utf-8?B?ZWFlUWVFT2VXQWFBZXpwSDZVVG1YSkg4Y2lOSmdOUlB1aEVXZVByZlNXWmNm?=
 =?utf-8?B?clZSNlE2Tjg1V3JoSnNLM0lXN0tseGN3U3FvSWJybHJobHdzWmpyWVZaYmdx?=
 =?utf-8?B?MkJKTUMyNE9lT21ZdndqMmlrTFJhNGNTak5NaWJMK1p4QTMvenc1SzlTRXI3?=
 =?utf-8?B?dC9FYVFBK1JrR2M5QWkxOGlsK0tiOVR0aTRsb2xDSWxiWE5IRTE4UHhkbnhm?=
 =?utf-8?B?QW5WcXAxZjNPZTVJZUZFSTJtSlJxdEpMUUFWcmMyV2ZSR0xTUXdGSXhiVEds?=
 =?utf-8?B?ajVLR25WMXNRSTRoWWUyVXJZL2pnTlNMMk40akliT1FxcVlKWEIxQ2J4a0ls?=
 =?utf-8?B?bGJPd3NUbkpnemZrOGU3NUF3a3llRGNCbXREZUtGOHY0T0J5d2dLdVJmZXY2?=
 =?utf-8?B?S0xVNzAySFNuSzMxcEdQUG9pRWJTOUpERGtwanNZN2VrcmhZK24xQjdzWkZh?=
 =?utf-8?B?V0duWHl0WkhuR055WFRTanJmYiszMUE4b2hhbHYxVi9uejl5dTY2LzRPUHJY?=
 =?utf-8?B?d2hsZDMxY29MVW5BS2J2RldPMVVPOHJBLzBjYlNWZDdqUWtvMUlXQ0lHbm9I?=
 =?utf-8?B?VnhLbE9hOWV0Mm1Ldm1FNXZKT2VzcVdKSW5vQWFaK1dIVEtydnErSlU5Z3pu?=
 =?utf-8?B?SVRYa3FiQW90RWcvWEhWVVF1MGNGVnlZRC95cnBYcXlJbWZ2RXdRdzVHWG1P?=
 =?utf-8?B?TmtjUGdrOWhEOW90Q0RibXlxYjlCZWM4U2c4akZraW1nWTE3M2lCWlNYQiti?=
 =?utf-8?B?VTgxWUlqUXBwYlpuRmUwSGpmN2VTU1E0RFF3VWo2Ym1tOVZmSDMxVUtackdF?=
 =?utf-8?B?RGJXa0ZyUlkyYUJmbWRacHpKalFaMWp2QnlXYThmQW9aZ3dnOWw1Qk9jV3F6?=
 =?utf-8?B?SWxvOElrMWQ4bERvZWU5emhLdUNlT0UrLzNyK0FEOVF0elZ5WlFWMnQyVEhx?=
 =?utf-8?B?Z1U1MnMrc1ZxKzJmQUdoMXVOTUU5Si83U1FJSTBpVERSY3h6RzZkUldPSWt6?=
 =?utf-8?B?VENqRlpBVEtnMDZ1OFRsdG85bnZIM3BGYjkyQlVjMSsxNzNNMERlcGhnVU5m?=
 =?utf-8?B?ZkRINjRwcHBvOHZ1dmdsUGhQR1BJMU1kYjJmUVlJN1c0SElaYlZzd01kTjRx?=
 =?utf-8?B?L2R6UkF2Y3JRelM2TkJEdmdXSndjWWJMQS9WR1BoREszN0FRT2VTdkdOYnFU?=
 =?utf-8?B?cXgyVDJEYlB3cnV6M1I2L2FtYURTYmNjT21LMlZyZ1I2WDNRdHJCTEhDdzl1?=
 =?utf-8?B?T1RybmlRS0ZYMnE0S05YaU9meVdBQmVGTDdMVE9COHpZTFp4K0NYUFJNL1Ra?=
 =?utf-8?B?UUg3YnM3Q293aXBQbUZPZllzeXVpZGxPbGZZdjVpVEJXM0Z6aVUrZFQ3T2ZY?=
 =?utf-8?B?eXBKT09BVjRFOU54SkE2VUdDbDU0dXNNOUM3UmpNaU5USS80T1gzbXQ1MVpT?=
 =?utf-8?B?RmR1VDBEcmtKMlFIM0lVblByMEJqd1JnaU1haEY1bDU4bTBJUzNJQXVCOG1s?=
 =?utf-8?B?R2FjZWo5c1pjaG9wUDVJSHR1TUhlcStkT21ObHoxNXhQTFRGRjMwbHIxaHR6?=
 =?utf-8?B?SzdxTGptM2N0QWg5aWVTSkUycXM0Zk1Ic3AxWHNoaG5EbTlvbVd6RXRhTGlC?=
 =?utf-8?B?Vmg4R2Y4b2tOdUdxVWdNNXBHQkMwSnhWOEpPbUQybGVsKzlZMDN3dzJ3Wkli?=
 =?utf-8?B?RDNMTEhqZ1ZSVFdOYWhuVGJjYkhuRFVJRFB2am9PM3U4dmNRZzV2S2dVVVhz?=
 =?utf-8?B?S2pHRDkzYk5ubFNHUTdCM2VZZmE0enNPZWt6cUVGWEtxcWR4RmtVbVEyeGl0?=
 =?utf-8?B?Sm5mRGpxL1BzKzlVY01LaVp2M0NpY1JZL2NxN1p5cnRBS2pWWUhjaFZPODF5?=
 =?utf-8?B?eFo1S3hlc09SQlhiVldDMEhWek1lY3dNclpadTlyWTAzbXdvdUdBZHZpZ09M?=
 =?utf-8?B?akoycmc0SWd6SEZKSFlsVmU2cXB4NEppWkozVU9ZclR2eEFFbkJYckJvMHZh?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8708e577-e9bd-4687-2891-08dcd13f7271
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 02:22:41.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KM5Ts7N3sCmSpJrBNDKxuvFY/jupjOx1dTzro5Zrc/9aCQiYbPS1KiGpfY6THt7jxNWw8NBud/7Fj3XeXyoq8iIHDONn1D1DmiQmtXjpAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6655



On 2024/9/9 20:49, George Stark wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello Kelvin, Krzysztof
> 
> There's acked yet not merged patch [1] adding amlogic,meson-a1-pwm with
> s4 as back-compatible. Should amlogic,c3-pwm be added in the enum along
> with a1?
> 
> [1]
> https://lore.kernel.org/linux-arm-kernel/dbb4be50-4793-40ab- 
> b362-6c9a6dd87324@salutedevices.com/T/
> 
Hello George,
I've noticed your patch.
Once it is merged, I will rebase my submission.
Thanks!

> On 9/6/24 15:46, Kelvin Zhang via B4 Relay wrote:
>> From: Kelvin Zhang <kelvin.zhang@amlogic.com>
>>
>> Document amlogic,c3-pwm compatible, which falls back to the meson-s4-pwm
>> group.
>>
>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/ 
>> Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> index 1d71d4f8f328..356371164acd 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> @@ -44,6 +44,10 @@ properties:
>>                 - amlogic,meson-axg-pwm-v2
>>                 - amlogic,meson-g12-pwm-v2
>>             - const: amlogic,meson8-pwm-v2
>> +      - items:
>> +          - enum:
>> +              - amlogic,c3-pwm
>> +          - const: amlogic,meson-s4-pwm
>>
>>     reg:
>>       maxItems: 1
>>
> 
> -- 
> Best regards
> George


