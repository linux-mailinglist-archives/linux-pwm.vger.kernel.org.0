Return-Path: <linux-pwm+bounces-8446-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC4SHj+Ay2kKIgYAu9opvQ
	(envelope-from <linux-pwm+bounces-8446-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 10:05:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD171365BD5
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 10:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CD8A30210F2
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0863C0612;
	Tue, 31 Mar 2026 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="owBf9js8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022121.outbound.protection.outlook.com [40.107.75.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A463CAE74;
	Tue, 31 Mar 2026 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943954; cv=fail; b=L99OaxiGy7/18n7gRNExqdG0WkpXl68I2KAQ49UEm/b3Tn6Q8mwtLeVaKb9sV5wdDcweUAQBiTCsdqeC6cz7Tn+6Jc7S6WSWlwtu5NrrAbLbTZfwmfv4/tlDcdWPXoET6C45LrDb06b3vQ/6So63PcMz7OSi15P/9WvwqoMR0cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943954; c=relaxed/simple;
	bh=WmMc0l234RDKOcdWmjtoF1rHsDdQUk8t3Z8pFc0cJLE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZfPdm0U5dKAhoZYP0yE/jQRrZxxPORbyMsB2xB5/ehbq/opHxKwFymTGsrPhNhFRHEI+ccOtsPIT7TKPUxig3i6YC/o0yQ5IY8OgdCCkTiC0P51eyvYVpIO0pi598Scnq2oZaCEa1J2RcbXSQ6jOdAvWcDCTOraFm0ej+06MF9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=owBf9js8; arc=fail smtp.client-ip=40.107.75.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJadvmdPc5aM1aPeW5FKQp/eSIWEQJ/9r8WYWQ6JXGEmE2riiX9bO6RennFCGelnoGTmoGUuPTV4RGnXixS4V7HpDwwkdzpf04G2jJMHF3/9NmS4KksnFOh5755/MoZSJK60Nd+aYC9bSQCleEsBn9z0W7vbrArDs03lBLO3G01ztMoDTlfg8RVVpHAOsI1i6NS0P2MWJSOQPOpLbRvsH+4k8RS+zx0Gu8PkXGQ8hzKGSfLjuDSvW/w/xYmUml1binFMXGJ3k4fP7Ul0uayfqIA1SfcwiXPjh+hk1DqMA0iFh5DGBvygrhNM+54h1i7yGQyWCa0QbObErrHjthF0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEfbSanqzMoLfIrVD8uw9CpvRO4nIqaftfstWtTRn2Y=;
 b=Z9j0Ym9flk1QtODrsdQ42/XdRdMinTqXM10hPf/m5Vz8KO2xbd7ZTglrlvqxoyBr3wCU+0C1/fW/9G08FBj1XSY6rMgY4Ds7bCZQEzEdnsTX44SMfVFrZxedntLInRWigWMUr4fulDGwHHxWMHPhZfBrg1JqQIeHDx7Ahp40t1OAPWPx09oO2wBYfClV3Q2Y4g9z7xu0UeHR8gwjBjjyZgBSnhupIfz388kv4DdlN1Ku6H4dTSE7PGxkXJaS50FIhApG1bivCpsUceJgw3zHbmziU+0VMjIq5mJYBW1oWqWHCCyp907vXAnidVUsChOGRxawqPiVz0AUYGYvM0cqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEfbSanqzMoLfIrVD8uw9CpvRO4nIqaftfstWtTRn2Y=;
 b=owBf9js8lyiiSfPr4J49yzcqA8IxgfDhbd40Vub+a+yAo+qE9FUsmCg9rQTFUEieQkYCVtJsVSMb1CEMHiSuTX7ELsFO17wip5PSzV+09vodJscfj8iJD58ROZCtz7YsJOFoe9KQzVVvf/ze7PZwsYqcRRyXpQzmAq1xcfHjM8vzmvbaESoaESlo3Js1JNGd52abobiUvFdyZWg/VDCiQbVMu+Ib5fLpCP0WAIP99ADjaPTshex4S3ogZ1V2pj7MmrXlpi9Wmfkvq3hxtwrsLFcE3Z3xb6kpkMpdX2ZZ9QxrTHpTxnL7IrdfjymDhjkqJdrggMZdDUdhbKotp8jJew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SE1PPFDD7AF816D.apcprd03.prod.outlook.com (2603:1096:108:1::86a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 07:59:08 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 07:59:08 +0000
Message-ID: <78e05060-6f25-4d78-8b0d-35b8fca0cecb@amlogic.com>
Date: Tue, 31 Mar 2026 15:59:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error]Re: [PATCH 0/2] Add PWM support Amlogic S7 S7D S6
Content-Language: en-US
To: George Stark <gnstark@salutedevices.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, Junyi Zhao <junyi.zhao@amlogic.com>
References: <20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com>
 <CAFBinCD1GPP82MEBDHg3BwCJg6JY5k2HksEt+kCB=YjnYTO7Tw@mail.gmail.com>
 <70a637b1-a76a-470c-9a97-0b4599a40a1c@amlogic.com>
 <4a9c726a-d580-4b0b-9530-228b58389c80@salutedevices.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <4a9c726a-d580-4b0b-9530-228b58389c80@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SE1PPFDD7AF816D:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d2b881-2874-445a-3d3b-08de8efb62de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	K8fzXD9D+N8doRCak6fp1iWV/PTFQC505Yu8z1hFZ9t5wu06MWzhrGl+N32E+ozTPLSSTUV/21/gPhmjvSkZ+FHElibRm7CY3DGy2SJ6Wzevw8aLqr1pWlnmNMXCKbCWA2jBdTVqCPdv7bMOQyY68rlZHQ1kQ9vmt2gJNa8zncoGTr54sp0K+InjSLrfdBbiuVD6qjvIjCqVMdaHSSY5HMWneFBJlAM/XcHjQqIHEWfEeN4geZRYq/SnY5D2jiLNwPNyzIyOljyhZ+R0CaKdRoAIh6yaU4kazfvw10f5m68pQAHwFJ+SatiP12FIss0UsstIxvPIi7+SuDZiDtiJUX4PE6A0Gip026YumBI74zHDsYmthV05dbZBwtFZefUBt/ufyDMsnxoAGxcwhQQ8SPzOZYYuLluN9pWuaiS2vIfI+dc5H0HhoHa8x4qjxZpoB1UvH4BvQ1+z0BbUj7gDV/4ENZgM4TrSzTFHV/CZASlqOQIu0tq8cx20gTVs3/tQs01HPFVgGf+Y++C4I3cBTeXwXhbkmBy6dt/Qm3hxo36dy8UDUCByCQfvPf323Ko9o8hQI4JJVOD6SIj5JC+U8P121fI9gbXiJdtnZOpUXzVlERY/jrI8QWu8Lnw2qpd0PHktr0B8z0Ucs+B+xDWPhY7VbG76sXnF9vrCpFY9fNZc9Algrzc71NkXKY+7f/TIhoYXCSGEMibAH7H7iDp5cVbd61dpAjdKQzpUQzfcZTk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDVwczQ0SkhIc2Y1VVNpVEJGRHYxNWNqaTR5c2tydEtiNmRqb2JWeXZsV1d1?=
 =?utf-8?B?alpuK2ZTeUt0ZFZRbnpXcHhTK1Y5b0JWSjZvaVExTzZaaUpXWmRPenNZdDFm?=
 =?utf-8?B?NTJVeFljb0l0aHlHbG9ZSm1NdllXcUQ5Q3FnNnlHcFQ3cklUejFyQVdjSlJG?=
 =?utf-8?B?VUZobHJjdWw3SEIrdDFlZGp3RmZmTkVTQzVPcDhPWFgxMmNzWDdsWUFnMWpZ?=
 =?utf-8?B?L0lITW90SWwxcDdpUVJCK3h1NS8rSWhhTHpwaDBtZVc4QXFPdmQ4di8zaFgw?=
 =?utf-8?B?OTJyVU12YWJaUXpHcVU3TkdjMExMNDdXVzJxanc3U1BGbGVvWFYwNXl1WTll?=
 =?utf-8?B?TjN5b29qZmFCNSttTkhiWXFiOHphRUVOdnV1Y2IvN0R0MTdMT2NLVVZ4eWlS?=
 =?utf-8?B?NkZ0YTRpU1ZMWm5ZbDJQNWFsSFA4cGp4c0FreUNDUmRhQVRYWFdGRW51VVBM?=
 =?utf-8?B?TG9OT3ZQd2hGUDFtZXI3RE5ZUFlEeEFuajFDdmpMTk1oUkE4SmJaSmlVV1pw?=
 =?utf-8?B?OFRUeXVVU2NlVnIzektVQ3V5NnZoRHpiem9mdmhEbTdhWWxIQmpEeXVSZ2dU?=
 =?utf-8?B?czA2S0crV1dabGxoZkpSVGRDV3JlVThtckV4c1lKdjZKUDFLbXhaY1NnYmcy?=
 =?utf-8?B?U2l3cURwbFp3b3NHYTBqang1VHFodEUzRXVkUWN5dW51NGc5UFhGczhIdHFV?=
 =?utf-8?B?S09EYXIwemJNcEpTTzRiZENuRjJmQ2JIWDV3TDFuVlEweW1reStlSnI3NExx?=
 =?utf-8?B?WDdOTm40NUd2U1BMMlBHMWNJVW5uVEp3eWdSTHBQR1RwU3lCMlVTT1M2Rmxq?=
 =?utf-8?B?TDNkUlBucWFzM0JYVjNCSjVCU2RpY1lTdDhHN1YzQ2NTV2l5bmN2bzRwWUFN?=
 =?utf-8?B?Ky9nWmVFanhkclFiTDU2WVZFNkwxZjNDcGpxV0xKS253aUlsOEZRVE5WSjRq?=
 =?utf-8?B?UEJjYzNnbGVodVZJc1VNd1ZVcUR1aWs4cGZHdlZhQjlXQjJyOXBPMGZJTFVv?=
 =?utf-8?B?dW5Dc2dMUHVGdUpyRUNwTXd3OE9IZTdwSTRza2Z0ZXM3dFJNVGpEUFhZL1U1?=
 =?utf-8?B?UXVBMUxUczAyOS9aUzJwSWZ2VnlrT3ErT3VsMW93c2llTmtRMk94YlNzbmE3?=
 =?utf-8?B?bkZ1TjRaZVpVdjJyeU1NazNYbTRWME5aTU13d3hDZTlESWtmMzFxMVhIQ0Fp?=
 =?utf-8?B?NERXdWE5L2FraGpNZ0c1V2ZtOUpEUFJlZkgrVk9uNmtOM21HcHJjc2hUdkhK?=
 =?utf-8?B?b3ZtbGNFN3ZqQWRJd1Q3YkIxUFM1WnZad0V6QnBjTkoySnRKck54UzlNeHBJ?=
 =?utf-8?B?U0pPUUM2ckxlcklqTlIwM3A1NVFJSHhrVmZrTzFxNlgyNGo2SjN5Vms3Z1k3?=
 =?utf-8?B?QVhobmU5VnVQZjE1VGxVVlJTRlNkUklETDhLVEdpWTZ0azFQN1UyQ0IzYWNn?=
 =?utf-8?B?bFQxYW5yUG0xajBIaE1SdktHL1FsTForWklQSjUvczZOS3NSeTBIMTM2N3dk?=
 =?utf-8?B?YkdsWlcrdGFzWXB0QzBVaDFiK2Z5cVJvWDBGSkdZZUt2dGlUSDRCc2Z4aVNr?=
 =?utf-8?B?U0kwUnU4NDJ4ZjNGYy9JL0FxNXRKbDJzQWZWR041T0MxdGZ0RnNmalFBZlBP?=
 =?utf-8?B?ZTZJYVRRVnEyN0ZnQ0FyTWZHNHpNcFQ1eXk3aWdMUFlqMG55V0IraEg1ZmRU?=
 =?utf-8?B?M1RTN1R0WjhZc20wc2dQdWJlbml4Q2JEN29zY0VHblV3QlY4U3c3ekd0ZUFM?=
 =?utf-8?B?SlBNd3JvODIwRmZyWVh6OW1ERGdOWldRZHlvbmF0WUhLaW1nYm56bDJjRm9L?=
 =?utf-8?B?ZGxSVS84VWI3R2N3dFZreVZJei9lUWgyVFRxYlFlVVRyQW4vbE9Vd2lYZGw0?=
 =?utf-8?B?dVFYUWZncUpBUXkvYXpGMERvSFdadnVFYjhydDE0L21wcEI1RmhzcmE4TjZH?=
 =?utf-8?B?dTIzT003OFJmYjJNd3pGYUc2UEpIOE15TU9YVjM0NHhuWWt2V0xzbXBXa2Fx?=
 =?utf-8?B?TzZkSEhEN2hmZ0pDaFdub3pWTGJTK3NWVFE2akNFY05HZURVVnpJMlExdXhj?=
 =?utf-8?B?bkVkbFAwSCtGNGF0aWplY3JiV2dOYVN5WThPVHp5WklrdWNLL2kvWnpYdHBC?=
 =?utf-8?B?QjZMQmJSMENSZ3R6b3VaWnpVR2VVZnAvN0NKYTVxand4R3VGUFgxSVNQU1Zk?=
 =?utf-8?B?U1ZrZk5JQTdSWUU3MVhsT3BRcGtFMFlCZTdTNjY1UEtJNWh6NHNlbkZlckJE?=
 =?utf-8?B?V25PcGJaekFnUzZXSy94OUpDeTYvMldLd0xqUGhrcXpqVm5XM2dXRHNobGJO?=
 =?utf-8?B?ZlluOGZFWlBVcVFmVTB3UGc2RVJRR2IwbGoxbk1kTkdBWDBhQnpIQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d2b881-2874-445a-3d3b-08de8efb62de
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 07:59:08.1030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MGNY5X+w6wG0ezZAyYSwb5apCHXcGVzC4S62cwfdYoOuJT1OAYf6a50qH+f06LndnFsuGNF8FoNGxq5Cf6E3R1BHcN6RpeS21+PPef+cEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFDD7AF816D
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8446-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[salutedevices.com,googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,vger.kernel.org,lists.infradead.org,amlogic.com];
	DKIM_TRACE(0.00)[amlogic.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD171365BD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi George,

On 2026/3/31 15:33, George Stark wrote:
> Hello Martin, Xianwei
> 
> 
> On 3/31/26 10:10, Xianwei Zhao wrote:
>> Hi Martin,
>>      I confirmed with Junyi Zhao that the current implementation counts
>> from zero, so this submission is correct.
>> We agree this should be fixed and will address it in a follow-up patch.
>> Thanks for pointing it out.
>>
>> On 2026/3/31 05:54, Martin Blumenstingl wrote:
>>> Hi Xianwei Zhao,
>>>
>>> thanks for your contribution!
>>>
>>> On Thu, Mar 26, 2026 at 7:35 AM Xianwei Zhao via B4 Relay
>>> <devnull+xianwei.zhao.amlogic.com@kernel.org>  wrote:
>>>> Add bindings and driver support Amlogic S7/S7D/S6 SoCs.
>>> There is an old report that got lost, stating that the current
> 
> Xianwei Zhao thanks for the confirmation.
> I am the author of the old report and the corresponding patch and it's
> not lost. So if the patch is correct I'll be glad to add relevant
> tested-by tags.
> 

I will use your patch and won't send a separate one.
Do you mean I should add a Tested-by tag to your patch?

>>> pwm-meson driver has an off-by-one error with the hi and lo fields:
>>> [0]
>>> Since you are working on bringing up a new platform: is this something
>>> you can verify in your lab?
>>> To be clear: I'm not expecting you to work on this ad-hoc or bring a
>>> patch into this series. However, it would be great if you could verify
>>> if the findings from [0] are correct and send an updated patch in
>>> future.
>>>
>>> Thank you and best regards
>>> Martin 

