Return-Path: <linux-pwm+bounces-5027-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A47AA4BCF1
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 11:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95867188BE10
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 10:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7511F3FC6;
	Mon,  3 Mar 2025 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="X7VxzFcz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2055.outbound.protection.outlook.com [40.92.89.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414F11F2BA4;
	Mon,  3 Mar 2025 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999209; cv=fail; b=pBnkcT9pmQjWmwuA4uSAD8zjUgvd9Qjfd1EnJNTzTsCsdSpeiuZun1+GyyrR8Zdmti9GdJoPOHjRhAL8/shsavPrYTGy5LBUGrUn0NE6obXrZPI/vDYKlMFPixkIy0vTnuauYTlc+NE7y/toM3scw2VU73wTY5htCrOJqxhEbFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999209; c=relaxed/simple;
	bh=U+yMRZ5FBeKps06BqGxZ595lBluzV5o1g/NO9Jmw0AA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kQrWU75rnhkWFKOVI54Yh/7ykb6/p7G7wGflzdpYsrJS8+U8TYSHA86xOo+FnfigTG7bsanNka8GunSDeLiG9O6BvFxELFWfbehNSxHA9vy7MUpZrvc4Yy+ptXuymndSm5rcuoUe4a37cMq5os8tiAXeEnD1O+7xyGeBGpzsby4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=X7VxzFcz; arc=fail smtp.client-ip=40.92.89.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boy5pTz/QsWc4QEVg0WvZtjIRBICYVoYWOxH7BLlcPbbr8MlioDLt1+QYr/cCrADi63Cs8+fVF49MGBxXj6Nkd9u3GFDQCdBbwxN2/q1jPVORL0MNpvIVgqspJhmSwdOO3SrR+P5WnI8Ix9D7dmaqt/78yxoVL27JOO8kl5y/Ds61s8xJN/e+GgG8WSMViUY+I5oi3ihOJJt9mygZtndc4uKNJthG7Jjio+6QaCTCnPjsAx50TEMDMeiiNwXxfXgqXhMk+jCB+WJIZdQaWgoFUD63DDc4D1P8J4KPDCWmx5FWKbyvZl0mUNkqM+8MszNnbMoJ/l8iItG6qhyNJ4r8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5pe0odQwLPzjUmKHk2xNk+hG82Zl1ydLqVR6DxJlqU=;
 b=Bllt0OUE9vFqC09al6eJSNOqDbY3qT7tQfTJOpFp3WokJ2ueSfmPZt+6Y9y9B65w0MkRU9oK7dM6xYrLpWfb/VZDa8x5Cbxbq8BLI7nTjLFwm0VOyNxWLLogrgA9P40HnyHjPg0LURoBTAdJrUeTpsjTsesLeJ2IwWIpOZUl7KfOriLUt2bYitXyJKzDqvoKMWpj9Ed81AEmF91SnhvGsHy/sBZUjLtgXs4cHGuCsNOc0CoeaKRm3Rhyzia5kawKPItLNezCR1dPi9Sy8wpVAn8ddzRmM4lreOPzghSNV4WfeiNbU6tV04UhIYOXIgempGZ4QrXB69O+1IHn6WGyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5pe0odQwLPzjUmKHk2xNk+hG82Zl1ydLqVR6DxJlqU=;
 b=X7VxzFcz+vbkPuZlaZ1EdcJk+HTgdfzUPhXY48x5ZUfN6eNY+xXpDFdxOuYkemUU/8s6iY6j0eO8WVwm5PReLPTQfHE4/nQAHmdLbmjrkc/oi+kIB/kmtmgBTYlcHCgmLE2Br33I7OAh1LeftvTTFz6rlrAmrrxxaNDLHLDCmaRhqV34h/8Fc4SqRrEK5HaEyCto/iofIT5lDli+H/in+idIIFM4jJjC/k+r5oPtM/R+4XxeuW90LyyilkzegUd8//VNiqGSBQFox9jQs4btGXaXLLtOgmDZ9jJ6yY091jX8BICgaZ4wava8vNngyMCKPXFDDc67rC/un/hVkFHjHQ==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by AS2P189MB2581.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:644::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 3 Mar
 2025 10:53:24 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%2]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 10:53:24 +0000
Message-ID:
 <AM7P189MB100990908D24EEB89CB0EAD2E3C92@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Mon, 3 Mar 2025 11:53:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] dt-bindings: motion: Add motion-simple-pwm
 bindings
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 David Jander <david@protonic.nl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, linux-pwm@vger.kernel.org
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-8-david@protonic.nl>
 <20250228-wonderful-python-of-resistance-d5b662@krzk-bin>
 <20250228102201.590b4be6@erd003.prtnl>
 <9a1d75a2-66c0-46b6-91a1-4922b892dfb1@kernel.org>
 <20250228110931.7bdae7fd@erd003.prtnl>
 <tm57fsmijq4t4y4dpmtss63ekzpm5oefir5tz4aioxq5dx4or6@lgoqjpxc3axh>
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <tm57fsmijq4t4y4dpmtss63ekzpm5oefir5tz4aioxq5dx4or6@lgoqjpxc3axh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::12) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <434b5118-1e2f-47e1-a5c0-f848d1f1ea24@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|AS2P189MB2581:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f99e7c0-af3b-4f42-e9a1-08dd5a419e11
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|6090799003|461199028|8060799006|5072599009|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djViTzRhZkwvamhFWmNFRWkvMFY1Zlo5MGsvVDRvaWIveTVRZU9pazc3ZnY3?=
 =?utf-8?B?TXR5K0FVTkhybHdvaVpyQW0zcEVPL3VvM0N5aVovQXJSUW95QzFCSGpVZ1ph?=
 =?utf-8?B?VE4rV2lXaC9oczZ1aWpsalBqOVJuNkphbGFOY2dsQWUzZ056SEM2VW5XTXlr?=
 =?utf-8?B?TkZZNXZia2sxSXd5Q1ZRM1JOb1NmY2VGRTFrOVRHYXc5S0p1ejBITkRvRlhw?=
 =?utf-8?B?LzlkZVE5K0dKRi9icjhFenJOeUtBdUd2NHU2aFUxUG1ZQ2UxbWtwc2JEVmQ0?=
 =?utf-8?B?dmhkVkZpR1czVHBmVFQ5WWVDb0Rta3JVamJ1Zi9nNzhxYklvNlo0eGFUUkY0?=
 =?utf-8?B?MVI2R2xqc3BpNi9id3FOSWZYTUdNNXBDam50L1FrS3lhMVF1MnpVUGJvQmdJ?=
 =?utf-8?B?a0kyVnlHZzh2VjljRE15bHRWUGJnOWpsOUJ3U1J1djZxR3I1VFFtd244dHV1?=
 =?utf-8?B?N1hsVjJjU2tYY1pmbWNCblJvdVAzZ3hFU1ZnL1gwbmJKSnJld1g3SWFCWXlP?=
 =?utf-8?B?RUVqdWRnOHlWTGFTdUhUV0VCTnM1NWJqVG1hRFBqQTNuZTJ2TlljVUVPVEZD?=
 =?utf-8?B?SklDell1VnFDTStkdjhVOVhVSENUS1BtY21jSjlZWFFsQnc1UXZJa0lMWm1X?=
 =?utf-8?B?cERrNUc5TENyT0JiS1RQOGhvd1hjUnhjb21SZUtRZlJ6d00rY1RhZWZ0Q1A2?=
 =?utf-8?B?OUU5MUVWd3RKSk9TM3pxdU1PYk1XWGNkMGJNNUxhT053WENZbk9saTlnalB5?=
 =?utf-8?B?bVJacUcrcVdOMnNXVFpTeUg4M0Q5RXZIdHdkWUF2MmRGYVl5alA3dVNGRTNR?=
 =?utf-8?B?TmFWZmZXUFRWaGw5YVEweTh5WUlNbU9pcGdWNmE0MlpUUXN1aUMyTGlyQkpz?=
 =?utf-8?B?cUlIRGdha0NQWkFaWEdSalZYaEVSVFJYN0NuWW5FUDB2cVNJZ3g2K3NOdVpH?=
 =?utf-8?B?d29ESEFleC9YYWpFUHc2UHJGelpLcTR4cjFodmE5RisvQ2NCQWs1WVVrUExG?=
 =?utf-8?B?QTh6b2U3Yy8velBEZFFFTFBVU3YxbmV1eElPY0Y2VHFiL2hPa2dPYUY5V3dq?=
 =?utf-8?B?Qkd2dmpRMXNoOXNGY1dYaFpoSjkwYy9BcVZmS2Q3T2hiaDdvVjZrSlBXeXNJ?=
 =?utf-8?B?Mnc4R1o4OVFuYWRjVWZYMlB5VHV2cW9YanM1emxvOGgyUXdJUkJJb1hiOEpz?=
 =?utf-8?B?Z3hWS2lCZWFHSXZ0YmgzODZYRm1mQmV1ZTAvYnBVRGZLZDZzYkk0eUVOOFA5?=
 =?utf-8?B?VTNxSkEzWTZ4ZmpBa0t1RW5GZ1RQN3FZTkIwc01MckxjYWk0N2FZcnhTRmRV?=
 =?utf-8?B?ekltdmJlQjNFUmNlakQvbjh1eWhMSXh2TXJ0M21EUTJ1NXIzMUpxMnY4V2NW?=
 =?utf-8?B?R3dEWFNvNjMvdk1lRmhCaGU1bmFnZjE4ODcwZXNzaHYzeG43SVBtcUplMjV4?=
 =?utf-8?B?NXIxeS9vUVBEa3lpQUl5Zm9SYmVBcStyZXVyZUJQaDBCaFZEbnZJZk9KWmlI?=
 =?utf-8?B?V2l6SnAyOWc3NjRsWkN5MnZOc1lNaEhIdVFXdTNXV0IxNGhQbUNyUUxrS2NH?=
 =?utf-8?B?bUVDVDVUTzNiWHRnYlNYdGlBSVdsYURIY3Q2MHNaaERadUVnbU1BOEc5WlRp?=
 =?utf-8?B?ZXl0ejNlL2NZWjJnbkFQalRRODdlU0pLMWhBVE4yZGpzYThxWVMvaGRMR3Rn?=
 =?utf-8?Q?fN35ZkiD/Gi4LGIBFIay?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVpXcHFzdG1ueXNiM0haQXlSQUpPWHNTRHlOZUhJeHF2eG5oR3RIclNWaGw5?=
 =?utf-8?B?d2llQzJqQUN1RnFaQksxdEpISW1lSTBtbzF6NFhhN2FhSzcwL2R5bktvclpx?=
 =?utf-8?B?bldNOVhjcW4zL2lMWmVCemJ3T3V5cEJ5UUtaOTA5QmhaK21vRWovZWxjS3Np?=
 =?utf-8?B?VHZnc3Y1eUM0elI1cVBPYmJXRThGbFFBQzZrUVJIYUFqbFpWNlIzRjR1UkdE?=
 =?utf-8?B?UE4ybEZrck81UW1Qd2YzeXRLaExKekx1S1NtV3NtMDR0T01sSm9QckNHVFpC?=
 =?utf-8?B?ZG91dWNKMmg5bmkyS1Q5TDBIbUhTbG9DbnhjVHZUby9LZ1FuRU5JcFZGWGgx?=
 =?utf-8?B?S2x1SzRZVmlyRUwrVmpmUHh6bVE2a1VxVm9xbmRJdVpQdE9jZ2k4eCtPMjlv?=
 =?utf-8?B?QnRiRElYTDZ4RDJEdTNPVUdIcER1elFwRXpNVTZOM1FtNnhJNk1QSlU5NVV6?=
 =?utf-8?B?K2NUZHk5aXo0WHZWMDUwbm55dGpGbW4zZWRwY2NjMW12WGRrRVl1VjlVWU1D?=
 =?utf-8?B?UnE2dG5DQk5Fd0JDdzdNWVdIVktiZGZxNzFiblJnZWZoQm1RVXVnQ05LdU54?=
 =?utf-8?B?S0ZvaHY3Nnd1QURHcDROTmdNSkxyTlE1RnprUGs1UCs1aHBvdy9FK2d0UDlx?=
 =?utf-8?B?Um1FdElwQjEycnJoWEFUR3RyU3VOYnlzajA3aDFOU1k3dGRRUmtIdHVpU2N0?=
 =?utf-8?B?Mkk2eitlbG1PaFJ5SXBKYlJXaU5SOGtRUjdiM1lmeURmdGlmNjN0Mm0vbC9i?=
 =?utf-8?B?SXVqdmlOOVg2RHhzYnB3azhNekZERFNJY0hqLzlRU0VydGQyL1Q0bmN2bHA3?=
 =?utf-8?B?SlY5VlVZMXd0OEw3N0dZTWpRRzNpSllkUmFhZU9oYUZUQTZ1VUtVc2ZhTURn?=
 =?utf-8?B?WnRpVk81b1kvVGZ6dS91MkQ3WDZWcGE3ZlhKUzNrNk5pTVlVT1l6OU9Qc0d4?=
 =?utf-8?B?WEJlQVd1UUFoZ05IeEYxL1NXSUE4VzJESTJVN1hNL29wQzBDWVc4QXRXZmEv?=
 =?utf-8?B?bDM4OFRnUE9Bdm9SNTlxelF2NGRQZDltNUdOMGdqbW0xQnpxU3lwM3BsUDFU?=
 =?utf-8?B?cGUySTg3NlhPUXVYVUF3Z05yazFZT0tOQkhodGxIQXFTMHpzeWVTTmFTSi9i?=
 =?utf-8?B?V0x3eldVVldNeURrdVNGMUZNSndCVCtXNTBnNVVRWXNyUUJ2SGpnY2M4TG8y?=
 =?utf-8?B?bzBTT053cDRKWmVMalkyZFVOY3l4TFM2V3VIU3RSK3JSQUJPVmdwQjRaVnlN?=
 =?utf-8?B?eVYwVkZadjIyR0J3M1p1RGlXblRvWWRaMFUvaU9xSEJQLzJZbFBjbG1HcDBR?=
 =?utf-8?B?S1R2SVFVRXhXZXU5S1R5ZzZtcVZJbXAyQVo0Z2NXVjdHVFJ1MzQ5WElWTGJR?=
 =?utf-8?B?emdDZldXVGg1QTNlZldCYTU4bWtJR3dIcU16LzRRTU43Mi91bWpjRlduWERn?=
 =?utf-8?B?MFQxaWc1QnFPdHMyNjdSc09wMHRQMEFlYWRIWjdCck9Pb2hVaTk0aWhsM0hS?=
 =?utf-8?B?bnYwL3FYUHoyazQ1VlZoZlJ0VkZ0MEgrd1o1d2V1MVFCeG1oeStta3pXU3ZS?=
 =?utf-8?B?aFlLYXc4YzRQNTU5RUpqOXZpYWtHSURkZ0pTZlJ2WWs1S1RudFBrVUZ4bEsx?=
 =?utf-8?B?U1VOamkwNHYzN1BwWHZhb3plNlZOUGxKeUtWeFdBN2ZyWDBwZnVwaDluOWJl?=
 =?utf-8?B?cHBWVmpZYURwdnErQ0o1Wmgzc1NUcHF5V2FKemJTbW04NzdHazAyVDZtaGZ0?=
 =?utf-8?Q?ptUNKc2i4BpYdDOpCc7nvXHPK6/LaVHSX57KmBu?=
X-OriginatorOrg: sct-15-20-7719-19-msonline-outlook-3b3e0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f99e7c0-af3b-4f42-e9a1-08dd5a419e11
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 10:53:24.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P189MB2581


On 2/28/25 4:18 PM, Uwe Kleine-König wrote:
> Hey David,
>
> On Fri, Feb 28, 2025 at 11:09:31AM +0100, David Jander wrote:
>> On Fri, 28 Feb 2025 10:37:48 +0100
>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>>> On 28/02/2025 10:22, David Jander wrote:
>>>>    
>>>>>> +
>>>>>> +  motion,pwm-inverted:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>>> And PWM flag does not work?
>>>> I have seen PWM controllers that don't seem to support the
>>>> PWM_POLARITY_INVERTED flag and those where it just doesn't work. Should all
>>>
>>> Shouldn't the controllers be fixed? Or let's rephrase the question: why
>>> only this PWM consumer needs this property and none of others need it?
>> CCing Uwe Kleine-Koenig and linux-pwm mailing list.
>>
>> I know that at least in kernel 6.11 the pwm-stm32.c PWM driver doesn't
>> properly invert the PWM signal when specifying PWM_POLARITY_INVERTED. I agree
>> this is a probably bug that needs fixing if still present in 6.14-rc. Besides
>> that, if linux-pwm agrees that every single PWM driver _must_ properly support
>> this flag, I will drop this consumer flag an start fixing broken PWM drivers
>> that I encounter. I agree that it makes more sense this way, but I wanted to
>> be sure.
> Some hardwares cannot support PWM_POLARITY_INVERTED. Affected drivers
> include:
>
> 	pwm-adp5585
> 	pwm-ntxec
> 	pwm-raspberrypi-poe
> 	pwm-rz-mtu3 (software limitation only)
> 	pwm-sunplus
> 	pwm-twl-led (not completely sure, that one is strange)
>
> . ISTR that there is a driver that does only support inverted polarity,
> but I don't find it. For an overview I recommend reading through the
> output of:


The only one that I know of is the opencores pwm driver that the 
starfive jh71xx uses, I remember talking with you there. That one does 
still need a proper review I believe:
https://lore.kernel.org/all/20250106103540.10079-1-william.qiu@starfivetech.com/

It is kind of in a limbo right now


>
> 	for f in drivers/pwm/pwm-*; do
> 		echo $f;
> 		sed -rn '/Limitations:/,/\*\/?$/p' $f;
> 		echo;
> 	done | less
>
> . (Note not all drivers have commentary in the right format to unveil
> their limitations.)
>
> For most use-cases you can just do
>
> 	.duty_cycle = .period - .duty_cycle
>
> instead of inverting polarity, but there is no abstraction in the PWM
> bindings for that and also no helpers in the PWM framework. The problem
> is more or less ignored, so if you have a device with
>
> 	pwms = <&pwm0 0 PWM_POLARITY_INVERTED>;
>
> and the PWM chip in question doesn't support that, the pwm API functions
> will fail. So the system designer better makes sure that the PWM
> hardware can cope with the needed polarity.
>
> Best regards
> Uwe

