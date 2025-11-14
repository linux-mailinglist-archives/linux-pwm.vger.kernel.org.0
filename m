Return-Path: <linux-pwm+bounces-7622-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434DCC5BDE8
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 09:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D7E3BF2E7
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4A52F7AC9;
	Fri, 14 Nov 2025 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KyFQqq33"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199C2F6578;
	Fri, 14 Nov 2025 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107074; cv=fail; b=JDsGCFJTKAe/9JWCw3eb3Jz6pF4aa8loIolTK0+qX+SaLMgychCi4i1JmsX40kT8ft0jLWWDg3ySWCfcEU+v8kJQ7kDObXNRkMAPT8dmX6aJe9bYiBWBQL/auFEAZbPw1zQ4Ncq/fmQSsg9mwZ5Avut2RVKECAI3nYq9h2iXoY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107074; c=relaxed/simple;
	bh=6UbKu7zxi1r5nky8Uv6fzZqVwXlj89tiElmXWJJ0bmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fuE+XrC6ar2hThjwyIh7l4uZFON7BAU2yEgsaqS+VryDoLpVwEknpWEdp3y//NwSy2EDYP/a9eu9gDo6Q0yro3w/2b7m5Kvqi0tCPKQggl80lqdOVzlP9AX6AN5Ebwn0HXIftc4VZYemRfIlgM8YN7gBRPcIM77nrgPtNer5cJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KyFQqq33; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMnnU60A0PKapSUTsd8NkQRi2jAEQ0+BBcNH7DIp9dnzc6Ad+5dedXnOtmxamUtpqKMRzLpUQkBVWahc+KqBllb9oH9F07Gpy5co6X53brVsN/TxTNPB0kNls+dHuXGXJtF2cSnkzutlkgqEIOFhFkB7weQBAC+zL1JRpPDDmbUwjJRXksrbfUq3iAMXutu/DzbHKV/D9635zcLqPFPAhTwE3cpQXLQv6ptjVreKYU0SkYphVl5UTain7DYJ5jiCkHmtvOy0ro34PdGu+4stNhMdf0LrXIlyJ55SauCZucvMM9tk0yvPFSQvekUNTbq5wckw7huRxpfeq/ajCRsclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8i6gZ/m2g60q7HLDv+bFkdESd5ZkMapGnkFkutFeiw=;
 b=nKfq2K6gEqceqh7doVu/6Z7A9yZe7Rc67SsXXwYGaqEtiNsEubEFw40VXVxWQHIIcvKcP6sE+nYUkhM4whSO5gw4CbR1o7pC0l/Zx2/j9J0vFA2W3Pcoycpn2YVA1m8Z1BOgPaCwHD8Mlzic/1eptVx93mHdmr4NL6zTjsfM4+eEA8+aFs1Xc9M5n3ybqi5fkn6kIGEzk6zN7k21qDK3K6zmAFGOuRW/vtboaawdPNaT0eBLXnG+b7I/sKR58RM7nGLa3HjuQ/dKppS0OmeRBpOqYiJ0uMEHOsJ4rrKG9mgTre4xrHRfAnEgG7y4mHzpRKc0FPAdYorzo21IgNRNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8i6gZ/m2g60q7HLDv+bFkdESd5ZkMapGnkFkutFeiw=;
 b=KyFQqq33VF7Sw9glaEpWPzADPGt7hwS4M8oNjpttZyW0N2H0q5b+rCRwmqYMC9reOG81kQZ7VS0ZYqLla7D3+9WX3pQhdMW7vicYpePxbPnqzrq/EQn34Hvtk7RhiCrGZN0diuEajZVBXbihVsYxcitLA6/hpSILEwtqK8xLcyEWXOCAeemzY3Zx4OrAxGXACubGsuZHxPof6FHf6IqcNfXV1fP43OdDUuOHVgxAdHH4zA/2UZN7cD6FPbtmFoNv4wx4RVjiOVmgYiZjng9AnbaHNfgp/YryTSZipi1x/JdYVCmV8HPy9ln+u/5g6Wja1mBcDIZkvJBDrkvvXV60Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI2PR04MB11145.eurprd04.prod.outlook.com (2603:10a6:800:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:57:47 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 07:57:47 +0000
Message-ID: <6c57032e-566e-46c0-866c-545bf18fd76e@nxp.com>
Date: Fri, 14 Nov 2025 15:58:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: adp5585: correct mismatched pwm chip info
To: ziniu.wang_1@nxp.com, laurent.pinchart@ideasonboard.com,
 ukleinek@kernel.org, nuno.sa@analog.com, lee@kernel.org
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20251114065308.2074893-1-ziniu.wang_1@nxp.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20251114065308.2074893-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI2PR04MB11145:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8ae9d8-fb06-4f00-ef62-08de2353803f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RkRBMDhUY0tMSnRtQTdsQWc3TzZnNkZicStKdTJVRlNmbU5mK1c3Q3pWRXo0?=
 =?utf-8?B?dEwrc0MzSGtwTnJmZDNuM1hBRG1JZk9HMGtabWVJMElDVFl1VHhOdkNvRTY3?=
 =?utf-8?B?dmRWYjBxdmtIc2xNN21ab3gzeDBzbm9FTkRCNGlrcy9aOUVXeWI5QTVoTytC?=
 =?utf-8?B?bkw2MUxUUzFPaUZHODZVOS90dDE0WXVwdFFXK2grNUNsNWVhc1pmT09yWFE4?=
 =?utf-8?B?SUJiR3J6b3JrTExRV1BzZU9aYkcwVTJIZ0ZCMTlEeUh2Vk94a1pnNTZBQTZ3?=
 =?utf-8?B?UG1leFJIY2VNVVZOVXJUR0dDQ0ZLSmw4ckZETEs2QWRWOG01RjNTTGkrcWtK?=
 =?utf-8?B?UVZUaVI0NFdxNDBzRVMzaFlnUDRBWWxwajJld0JWYXRTditQZmw5Z0Y0MTNN?=
 =?utf-8?B?T3FyYXA3dVNPeWpyQ2hJVlVORnFwN1lEUFI4RXY0YkQ0dFdvTkFDanJjUWJs?=
 =?utf-8?B?MjhTVWJVV0V1TDArRG5KTzJIRmtVcmVtRGk1cWs5SVdBbmlZTFo5ZzRzRnFx?=
 =?utf-8?B?dFlmSWpya2VzR2loYnhzaTBwUE5lcFI2K1Y5UmM5RzRZV0JvTmtJRFFxLzlj?=
 =?utf-8?B?dGwwbkJuajZRRk1NSjBNQ1BabGJmdDhmMWtUV2ZvVDVSS0ZQTC84QWZGNWtU?=
 =?utf-8?B?c21mZEt4c3l5endqL2Jla3ZlNy9Cb01oYUFKL3F5MHlVdmlaQlVaM3l3QnpL?=
 =?utf-8?B?Zng2U1d4UjUrS0dtQ0MvNHhISGFVVXk1QVFMYStvSkdNZXRpWDBkU3FBekV6?=
 =?utf-8?B?NFFld3hNTG5WTmxoSVB6YkNUV2FIU1AvdURVemIrU3duWjg0Q24wdzZ3aDNL?=
 =?utf-8?B?SVRXSnF3SWdoVm83ZWNzRUo4Nnl2ekhkQ0syMnhYYzBWb1pqMFdCVmJhU3ha?=
 =?utf-8?B?dmVJSXlIQXh1UC9SeVNWeEx0MlBHTWNJbmJVbWNVWmY3b1JpTmdvZ3V4ZGov?=
 =?utf-8?B?d0lrZjRaMXY4cURHT0lwTGxsbFpoMWJTRDBwNmI4N3pPV29pN05GaWpVVVZS?=
 =?utf-8?B?cWpjbDh3VnVycHk2K08ybld0d3FCRVlpZlJUQTBDeHI3Y3l5aSt6d054cG1k?=
 =?utf-8?B?bWd1eVdLOE5Qd0E0ZDJlQk1wWXNuN1pRLzdhYXVNQkJtbGV5SWpLK1J4QWtz?=
 =?utf-8?B?RnpUWllQenJCTmF0YXBlSE8xd1Z6a200aVZ3WVlyZUJseXVyUWtnN0tVMEN6?=
 =?utf-8?B?NzJnOHhObkpiZDMwcjA2T1I4anVSdzhzUmdJRWgzSFAyN0g3aVhyS3FBOFFL?=
 =?utf-8?B?ZGthdHc4ckJsNC9QaW12bHlYNWxCWHhqZWhnTlJZMEY5VVUrcEk1Q0F4V0I1?=
 =?utf-8?B?ZXJvQ01YWUJZWHlXU3RrcXphdFY0S2VTbDZEcWtndFkvN3pDQVFvK1N2a3B1?=
 =?utf-8?B?TThXamY5cDZXaGsyditoMHVUNjVNUDAramtERzV6N290QVJUYUhFVVhROUxB?=
 =?utf-8?B?dnBVeG5SSk92QllEdnYwU2tSYjJGQ2E2djRTbHZUMW9MNFBPUUtZTzNBcXcr?=
 =?utf-8?B?OVZuNk5kaXNGdXIwQllySG9yaCtiVmlIS3dnbWlEdDhQcC9MZ05oRlk5RUtC?=
 =?utf-8?B?RU5JcmM0Ymd0a20rekZKYXlaOTlFNzdZVms1SU1GM1U3OWkrL01mT3E0QTZv?=
 =?utf-8?B?d3J6aHV5Y0lCWGNyeHhJZDFlcU1MZGNHVU1ENjJPNUFWRVMwS0V4bzBQRm50?=
 =?utf-8?B?aFJvbWhRaGNEdTFPVC9iTlVva0k5bTFHYVVIY0FRTWQ3WmdxVXd4eUhBVW9x?=
 =?utf-8?B?L2dxbzJUMHJiRmJ3YVRsTnJ6RzJNVk5IVnE4QU5BUVJpc3NINWdJamhoejRi?=
 =?utf-8?B?VW9UUjJFZU1GSUs5Q3lZVTV3eGJNNXhTT1JjU0Evd3ErbklxcmIxSnR4MkFF?=
 =?utf-8?B?THV3SjNBOE4wM2F5UXNheWp1YUFrbEtWTUhLbk1DWVFid0F1aTROalJuM1lX?=
 =?utf-8?Q?QevZP718+C9pk43vJ5VSUP9PTpBHvvHe?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ekNQdDluZXA1eFplQmc1Y3cyL0QyZXUxc2FGSmViUHFVRGZUMmRzZlBhSG5P?=
 =?utf-8?B?QWZOc2MxQ2Q4V2x2d3JWTjNxb1o4MHRTOWw4TVZHVE82SXhyaWtrQVRWaTA1?=
 =?utf-8?B?UVVwRmR5MkJvUnFFSnZKUXcyU20rMU12RTdMUlZ4YkJjNGxCT1M1bzNadlhW?=
 =?utf-8?B?QjdUUEMreFp6a1pXTC9qaVZTZmRqNWxMWFhBZndHMG9OUVdRcmpKZ2V2Y3pI?=
 =?utf-8?B?ejcvYUNLV0NWQU11TElVNUdLU29ZNkRXTzdsejhHUk1qTjFwK3pKN3laQytT?=
 =?utf-8?B?NkFva0ozNDJJSXNXTmhoV2NFRkV1MGpMdVIyOWNNSUcvVlRHQVJvaUxmdkVZ?=
 =?utf-8?B?NDZNVkFsenpmVjFKd0JlWUxraUxHY1pqUnpmbXMyL1ppVlVXaFpIc25VSHdv?=
 =?utf-8?B?SmNDaGwxN21GK1N2ZkFQWmJmNGkwMmxCamE2Z1U0WExBVlVRS0pwMWpiak9z?=
 =?utf-8?B?TlNXWERlWjE2UWxNeUdKcStOSnRyamp4NkxHaDJZTHlaYmh1SFVNam1SckJi?=
 =?utf-8?B?VHVJRlFldEVkemxPRm44cTl4Uzl5QVZXQVByR2wxYUJvL3orQSs3K0R0andO?=
 =?utf-8?B?UWhQUit1N2RneTZqVFhtb0JncTRkaG5taEt4Tys2TG5xOHZlK0l2QVhlWkRM?=
 =?utf-8?B?Q28xREJqbVEyR3lFQ0JEcnZxYXp3bVBSeXRERnVreUdlOXhpWHJHS1prZFdP?=
 =?utf-8?B?aVpmRGxFb1hLSTAwQ2EvR0ZKQmNPLzlYT2xIcjRWTEFqTFQ3Z3VrK29kYUVU?=
 =?utf-8?B?ZE9vWXJpTHZLdHZvcjB6V2VDOXFTUm41WFJQNDJtVlJ2Y0trKzJQTG5vVFgv?=
 =?utf-8?B?SzRadzBHL1ZRUFpVclA2U0hvY0dlYXBLVnBYU0RPOWlhaFhFWjFzb2pPazU4?=
 =?utf-8?B?ZmhlN3IycFJJYmNXSVBJQ3oxMjZGbjR2RTlDZG43SE1FOHpRWDFhWk5Hdk80?=
 =?utf-8?B?WGhveDYxamlMVzF5SWoyY0xmNktOUThTTHNjNG5zbXNaK2I5L256bFh4ek1v?=
 =?utf-8?B?NHBsK0lsOEd3bDcwaVF4czJLQ2RYcEY4STJUaWVPeldmbythT3ZHN1N0eWZP?=
 =?utf-8?B?eklyN1ZNMDluVDRTb3NwdlBhbFNlT3VMMTlrL3I1S3RFdFdoaXlBaGgrTE5m?=
 =?utf-8?B?cVpieGZibm1manphbTJOWUhuSmZJOTJBK0NRQWFmRFBZOEtnWDhXa2s4R2RU?=
 =?utf-8?B?amF3b2RXd2VHRFZsT2xaSGdFSS9CbUo2Ym0vaFlXOVhlUHBzc1hyZWVqMi9i?=
 =?utf-8?B?akU3ODBHdGR3UmZCdWJBUGZqa3puVnJWaHZaWHVJeUFYQkU0c3JqYTJ4dlpz?=
 =?utf-8?B?NU03QUszTFBXU1h0bWgrUmpvbEdHV1V1eEVSazk2a1VVeHVZL1FxalJ6WGtr?=
 =?utf-8?B?NXA3SDQ3L2JsaGU3TzZZQ2JlNExOQXg3MUc4Q204ZlZnY0Viak9JSUFOUzFZ?=
 =?utf-8?B?NnJDOVlPZDJlSEp4WHRBQzR3SnRJNEVGOHFuaWZqYlc4S0NnR1JubFVZcFpx?=
 =?utf-8?B?Zk1iUDY1TjZTWHZvQklMQzNLNXk1ZDdYZVJJRDE5a2w4RFlRQVI5N3o3NUJW?=
 =?utf-8?B?S2w4QnI4RE9XVFNtSFRyRzQ5VEN5TEZiSW95QWc2c2tZZWdWWkNaQWpGaVVQ?=
 =?utf-8?B?ZnlWeGNjUWwveEMydEFIbTNSZkhDa2xpcE0vRWZFcjVqZW5udjROcHNiUnEx?=
 =?utf-8?B?dzlIbnBreWx6Q2plWkFYeGM3b09MMy9HaHRaZU9LTTl2STh4dUJOZkdoVFRF?=
 =?utf-8?B?blpqNDZuc0lWOEt6RExYa090VlM3R2ZDZk96aUhjc0RqRjNSdE1acmN0MDZv?=
 =?utf-8?B?OWt4clR0Sm96ZXJUOEpiZWVsVGdIZ0xJRmcyblF5ZllYL05DZDRJb2xORTQ2?=
 =?utf-8?B?WHZpSFYwV0dsa0ZRdXQzNi9xRE5rV1QwM1pkM0xlZmtWY2g4eFowdFZtR21P?=
 =?utf-8?B?NEVueCtORnZlU1lRSTU2VCtZcTQ1cHFMUHR2MWphRUhXUTQ3WjFsS203R2ho?=
 =?utf-8?B?SEVvcmZOQmJFaWVVNnB0endCcEQ0eFFBdklwVjNheHN4ZWVGVXRDa1JISU9t?=
 =?utf-8?B?anpobjF6aEE0a3czZE1xdWVkMnhJVGczK3UvdklVWnlueUtheDM2dWpEYmZj?=
 =?utf-8?Q?plBD3+qmFPsMzhkk7MidqwYnP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8ae9d8-fb06-4f00-ef62-08de2353803f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:57:47.7203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pNtTDWFWjlX8w6RxUamg0+vIUH+8jLAT58jNv+pBP3HRSX4a7AURFV50SRt4rplZ/w0S9HnCb91DyolyTItgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11145

Hi Luke,

Thanks for your patch.

On 11/14/2025, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> The register addresses of ADP5585 and ADP5589 are reversed.
> 
> Fixes: 75024f97e82e ("pwm: adp5585: add support for adp5589")
> 
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/pwm/pwm-adp5585.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Liu Ying <victor.liu@nxp.com> # ADP5585 PWM

-- 
Regards,
Liu Ying

