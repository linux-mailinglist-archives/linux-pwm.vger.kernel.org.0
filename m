Return-Path: <linux-pwm+bounces-7645-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF65EC6FF65
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Nov 2025 17:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CA2EE301FE
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Nov 2025 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4CD327C18;
	Wed, 19 Nov 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bIXqg8v5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011047.outbound.protection.outlook.com [40.107.74.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8462E03E3;
	Wed, 19 Nov 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568446; cv=fail; b=cvy46fNDgmJ2tBbIsmhau4JFK22xjJK668sDVtRNDhnol2sp0DJzM93meu5XsYVT2qgi9LbSEinYVpo+4h6/aNE2mam2c+SdHj3vkA+CHhACTtYrIr46FsIblJnkj/8M9vca3Li41rSS/toC7NYluxVp1NkRFvl4TYFPhQLWOdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568446; c=relaxed/simple;
	bh=zMBszLecVbvAgLjKT7BoRxQ4NpsqjwADFp5MfdSJFHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LK6+h4AlY/7WL5aez/POLMKdq4ixCFq/6g7B2PJrDdVpo9cX5rML3Jm7kcKLFeqChJY5ZzNFy4YkxiUAUE/Jtxv8/gmBSSPES08kWI+HGkFtTdJDO+xPw56qPmvgv7i3hRQUrBwX2sm5wcrZDRQSy9Ob2MNoivbYabHk93JkgVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=bIXqg8v5; arc=fail smtp.client-ip=40.107.74.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnKSpeEzM1nJPiAFa9xMV6JhOKWKpBAsdoCM853CEAK5ouZEi92BJ0gmZqGKD4GuVFX6bgEP6xOy6jKGGU2DzVM1ucPocrJT40OX1/z3KLPcuqKAUam1RVgnSL2p6PHgR0dpjmRyyr+1XoRCPl1Tc4uPTyWeOfoDmdKgKLyHs6Htm+5nqW4oOZ3WVzJ08Nc9zSK1PNvRp9b2Yxu/NXvsVwcRVsh02qlmm0cBDQocmSn2l8khN1kjU+xf35UGMAQyzGQ7HrfdSkElmlHOBwZxL5M2WtoaLRUkpiAZ9G5pkYneTXCmJII5xJFXuO/+EKWrdiFKQnaGvHhjx+m7KsGJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMBszLecVbvAgLjKT7BoRxQ4NpsqjwADFp5MfdSJFHY=;
 b=jYTRAYj4UE40ZN3Lvr6VbhmGn0U21bciGAwXJLXjeZqdqyOoWBJ4hFa80GH2IJk8WV/xzelDFT/hA9lO2xFv8ynyYvhDjXFJzjj9AFCPhrAvt75fkLbcFPr3uR5wPLfkFCL43JImAjkifyEIzrsygsxmrWH5kpvNypQvwgd6qTxL0nIRJ3JsV2/2+M/w+gIq73It/VdQt06HYw+NzlkpPvlxuvhu/QtnkDtCn8LRTq6qWAnXlwg3Q0ajDp7xoZkAC+iLREu3/8JH4f/5mFHymAOG8iVzu2TNG9ZO9ztvHhUuybx/SItjglIlc/wWdhwxz7blmbjcuL2Ice74HLDEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMBszLecVbvAgLjKT7BoRxQ4NpsqjwADFp5MfdSJFHY=;
 b=bIXqg8v5rvy03uuJ19PWM8wtqWb3crRhIR87ye0iBjMyryFIsAryvrdnLibA5x2hzieqByQoGa/uWUUKNy68VykKKj/jb7X//4U1DRAzIJe1ITUIg4RQKn3W1pe/QNg5zA6NzF9cZldHokAfFIXd4OYpnXdI2EBcVQshPKVu5kA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB17402.jpnprd01.prod.outlook.com (2603:1096:604:438::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:07:17 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:07:17 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>
CC: biju.das.au <biju.das.au@gmail.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH v4] pwm: rzg2l-gpt: Reinitialize the cache value in
 rzg2l_gpt_disable()
Thread-Topic: [PATCH v4] pwm: rzg2l-gpt: Reinitialize the cache value in
 rzg2l_gpt_disable()
Thread-Index: AQHcVXbT1K+z1LyjQk+ztnXMbmIpvrT2hVOAgAIJYkCAAHqRAIABKF/w
Date: Wed, 19 Nov 2025 16:07:17 +0000
Message-ID:
 <TY3PR01MB113462E5CA7107FBC2EA962B386D7A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251114145606.200948-1-biju.das.jz@bp.renesas.com>
 <ppqewbxcvsqcpp7met6vupmvxaftfjwiefej2c25jw4hoe3c23@lyh7saabrhkd>
 <TY3PR01MB1134679D611D611AC2CED72F886D6A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <4xwhsp76tb6dn64n7nvyok5j4x5a3jbuovyqdrfvky5iz7rrih@ll4gpo67vn2i>
In-Reply-To: <4xwhsp76tb6dn64n7nvyok5j4x5a3jbuovyqdrfvky5iz7rrih@ll4gpo67vn2i>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB17402:EE_
x-ms-office365-filtering-correlation-id: 6f2c34f1-bc8f-49b1-b2de-08de2785b623
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0ZIcXY2UEJLUUhWVVA1anNFZjlUWDN5aVhMUXovZEI3Vk1RanZZYk5hcm1t?=
 =?utf-8?B?WmpjNSt3ZzJLNDZwQk11OHI0MHE3UEZTckx0SEpOZ2trdFJkNHA5d0N5RnFN?=
 =?utf-8?B?WFJiWTk4eWZ5UXFEUFpSZUttWE9nZ0NvOFYyaEthZDJwUEluemQ2ZVFDb0ho?=
 =?utf-8?B?Wi9aU0NGbVpDWUdIbUt3VWNnblhlS1FmcTBxeklzUUVIU21VUmsydXpGR0xW?=
 =?utf-8?B?MDB3K3plTDB5TkE2TDZhWjBYQTNnSUVUOFFlWFdDbFFSRHlIQytRbmZINEZk?=
 =?utf-8?B?TUtDWmU3N216TmNPMitCT0NRb3pkbTlpamoxNXlkN2xnalp1ZzVkdVlGYVdN?=
 =?utf-8?B?b1JGSmZWNkJtZndOWmx5cFJYTVFYYnFqN0ZFSjJKaWpqNUVRMjVWUXVxMWps?=
 =?utf-8?B?WEVwM2M1ejhZVDRKZWdtRTIvSHc0bzlKTHlPSEJtUEVTRzdScURWRHNKVzE3?=
 =?utf-8?B?RzM0d3BCTEhRWTFzVUhuc2dLcE1LVmxQODBvb1JJSlBWa0M3M0JkREZKVVNC?=
 =?utf-8?B?VEtCZDlFblViSy80Um95T1FPcGE4YmhDR2tiMk0wWGs4L0tkeDBEak8vRkJt?=
 =?utf-8?B?dWlFcTAwT0tmNFozeVdTT24xSC9paERDOEkzRHVYSTFaWkFhbUVNLzh6OUsw?=
 =?utf-8?B?aGxYSDZaL3lPR29IM05HYU1UMGROQVJFNVJLYVYyT09NU09NVnpobTBTMmF3?=
 =?utf-8?B?UkViTVgzbXhad0xiQjIwNklDOEZrdWNxUDJsZExoOXBhR1Q0azhPdzNUcnRC?=
 =?utf-8?B?ZkZsU25sL29WSGJhZDJFdTkrb0hZR0QzQlgza004dS9TS3pVZFZua1dUSm10?=
 =?utf-8?B?QlNqelhZWHdFckhBSVJ4Ky9wVEJpemhac3BEbGJKdlNnbVZaOUJEeFF0SjZu?=
 =?utf-8?B?bFpiTXpmR3duQUZ1SkN3ejBRNkRNcldIZW95d0JvZHRoTVYyZDgrblo5MXNS?=
 =?utf-8?B?SE1iQmZzV0s3N3RRVjR3cTBwV3RUSnJBVldKUWZURUVzWVlIdHd4akwvRXRS?=
 =?utf-8?B?S2RZTWpVejAwZDdiQVFVenI3dFc3YVZIR3Bsc05yT0dCbFhlaXh1WUJEK3NC?=
 =?utf-8?B?N3ZobTdSbElNR1A4ODlXWTF2RVVEaEdZNmpkZURoUUhNOWRHRlF0OUVOTVpW?=
 =?utf-8?B?WlhlOFR1YStJeG11Rk9yQjgzanBjQTJwN3FhcmxDTU1OcjZkdUtyNVBUbjc4?=
 =?utf-8?B?OXRMcVZGRDE5Wlp0UmFsVmRJZlR2bVMvRFY2OXAwNVM1ZVpFVmdiYjhUYlRu?=
 =?utf-8?B?eEJVdTJGd0RCSlJ3bXRjMjlzcStTa1lERXU4elZOOXIzWVdvR1c5Q2JJMTFM?=
 =?utf-8?B?dzU2THlGaUN2R1NxUHlrMUNpdkw5T2dNUW41ZDVpcXAwZDBZWkhybStNeG1r?=
 =?utf-8?B?ZldHek5GNkdyNFZyTmJwa21QSEx5MzNvU2x4REpjVHFIUXFZMEVGUjFCbUdz?=
 =?utf-8?B?RHVCSWZOMmxScEZRcnF1NlRROXRGNERCUWMvMURueVROcmJFcXg2WkhVRW5a?=
 =?utf-8?B?djluMVFsL2xSaEpYRzI3TEZvVFByaFRCdUhtQXg4M3c0cnAyQ3VuRHIxTXBP?=
 =?utf-8?B?bjZTNmNzcjh4VWdKNERrNUlTNytRYjJXbEx0TUQzQ3JJYnMzNVlvck9RUXor?=
 =?utf-8?B?SUVDTmVob2xLcDJsUFArTGtnZjh5WmtTZnVnSHpBajBOUUZzZGZsbFVZNmVR?=
 =?utf-8?B?QkJyazdzZ04xTjZ1VlphSFFva1dmazdlT0pYbjFxMGd5cU9tYjZGQ1Jzc0pS?=
 =?utf-8?B?N2Y2aTI4bWVJTXBEZXdKSXIwYjZRcUZxTTZOQ0p5VnJSdCsxekQ4cWg4QXBi?=
 =?utf-8?B?bUJuZWJnNTREVEsxUllGMTYyNzhBOG1nOWptNkVZeGErMzVVTTMwWnVIcXlt?=
 =?utf-8?B?ZVRXWldpSmxtNTh3YVFNbnZLd1dreEZEMGQybko0L2kxZWM1aW5NZTg1Rldq?=
 =?utf-8?B?VG01QWt3dXlmRTQ0eEEyS0FqdHhuRGdQWHFSK1ozN0wrZzc1VDlIK3JrYzky?=
 =?utf-8?B?azg2b0N3SDFwRlVITlRTelViV080cnk4bzNJOUU4TWJJZ2tsTnVxa0RpVjgw?=
 =?utf-8?Q?CFuBVV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bG5tVUt4Ymw3NGFickswY2JQanJmVWZxM0ZzbHY5MGs3RFZGcnFDUFJ1WVNZ?=
 =?utf-8?B?akVEdzdpOEtLRHRrYmpsT2JJZC90T0F3OENCbWRsMk03UkJ6YkZXd09QWlhz?=
 =?utf-8?B?bHg0azhBY3VDUVpySWJvVmlyOWlNNjJhYXk3UHc5Z2FMSkF5N3kxSFhEZWJF?=
 =?utf-8?B?OUpvSGVuR1FsQ2crbWVFY1RNOTBzZDVabmg4RG43aS9YWUxVN1RyK1FIZDZB?=
 =?utf-8?B?dE1vQmRacWYwSmZNVGhaMitsNkk4cDRYVUUvTE92UjNidjlSWDRNb1ZWdnlF?=
 =?utf-8?B?cC9jWHE1RWlMQlZQWjBaWnFsRWkzbjg2NUJtTERtcExZbGYvYXFTNnprYWlx?=
 =?utf-8?B?UUI0ajI1TDdnTitHeld1cm1TVWRxWEtQdHlUZWxGY1N4YWViS25RaVFwRG1P?=
 =?utf-8?B?cndyMThxUkdlQThyWmQxQUNRcHFDUnlrQTVGY3p6bWMyNTIyTDZjbCtiWkpo?=
 =?utf-8?B?azZxMWlnSk83ZmYyVmNDUTc0NDc4YWVDTUw4UVptZS9IV1NndzFRR2dNRnZa?=
 =?utf-8?B?Y0Q2Q2RjMXoraTBQSFdHbGc2aEhyZ0hiZE1mY2ZQZnhmbG0wVGM3cUVGVXhO?=
 =?utf-8?B?aU52c3BVWVFESE5UZDkzZ2ZyT01sRXFwcEpKSEFWbm9YWDZwbmZIWFBkNlhQ?=
 =?utf-8?B?M0MzZndtY1NjYzBYa0x5Z3l2ajhaOEx1dW4wZ3E0S2k1YTBGTlRPNlZycDZa?=
 =?utf-8?B?am9wMHhYQVRKZXlha3VXUWJYRjdNVnBIcm5yR09Wekh1SjVuYzBmaHd4NDhz?=
 =?utf-8?B?QldkWnNCZ2pvVndWZVZnZXd4ZVV4dzl4RVpjODgwMmRQdjE2RFlQQURkVHFQ?=
 =?utf-8?B?WFF3RDBDcGtlSklIQ1U4M1JUVExwMHBsd2p6ZHFjTW5Cd3pJZFJ0RUlOZ2xG?=
 =?utf-8?B?Q1FWUkRHeXhUbGRMajhnVXcyNXkrS0RRdlNpRFA5K0pUOEZJTkYxa3JZdFA1?=
 =?utf-8?B?OGxTNkJxTk1DSUE4YWs0NGVjV3RQYldLNHdBYlJFV3ZWNUhXazBmbmxGdFgz?=
 =?utf-8?B?bnJuclY1TWZ4QUxMN2l1eHA1Q1RwQUhKZFNxRXRmdFFPNGhZNkxHVENsdjNk?=
 =?utf-8?B?MkxTU1ZsVWNYNWZMSVAzdVUrbWNOZnFpVXFyS00wclE1eWRZZnFUaGhwRkd3?=
 =?utf-8?B?MEVUcFNFSFVHeExMbWFyWC9vSWlEbDF6NGVoUTZRelo3RTJ6SitHZnJvcjJi?=
 =?utf-8?B?cmJobjNGcHBHWjZ2V3YwZmRBaGQ4K1dTV29iRXR5VjZxM3ZYUU9pOFZnMjZN?=
 =?utf-8?B?N0p6aGp0R1czbFBZYk4zT0ZlVWszRUk1MlhLbDh3SkVlR3lXRVNkYnZab3Rk?=
 =?utf-8?B?L2R6Rkw2WGMvc3dKNnVySWRkZWsxcmFHcndYendOR25PVGpvVE9QK3JlNTQ1?=
 =?utf-8?B?UmR1MWtqNHJ4d2toeDR0eHBrZ3dkM1RTTHdSNmpmM2Irb2F4cldMNnRBMDRK?=
 =?utf-8?B?c1FNVHpUMGZwaWJMZW1RYUk2VXFMRnlWWEJUb2I2MVVEeHMyM3RvUmMzQXgr?=
 =?utf-8?B?blZKQ3J3Vm84SndiakZ0a1hIUjBXYWg0ZGpBOEVsYm1LRTZweFhRVGtYWVVw?=
 =?utf-8?B?RGxhc2J0eHFKQVJNUlN0TWJEY20yWEtkVTdXL3hyWjdjbGNiYUtvOExBaXhj?=
 =?utf-8?B?NEF1VjB0KzBHWmMzR1RkcnAwR3VRd01MSTIyWldYeDM1TmZZVDdMZWNVNmEx?=
 =?utf-8?B?U3hIK2FLbFdrUE1QeUlVY3B5VE5PM0lVcTRNc3hKNENCTkNMMjN5NXV6MDE0?=
 =?utf-8?B?eVp2UW9EbUNnMHlsSzIvckVnRmNnYU1BcmV4dzZJZzV2TjBnTnU5K2pPOVMz?=
 =?utf-8?B?REVRSzcvY25SVTc5R1UwUkRna0pIUU8wNWFydFZBZkowTlZXSGhBNkpyTXhx?=
 =?utf-8?B?REsxUVRacU5QZ0xuc3RJb1UwRDhIYlFkbUlla0JXMTdZSlJQenBlWjNJQUdG?=
 =?utf-8?B?cXJKbWc5ZGlPcmQvd2k0L1VNWGM5Z2l5b2Y5RHkrRjk2OFpQc2hJMWtxSk1Y?=
 =?utf-8?B?VDBsV2ZYRTArUXFLM2lxdmpXVU5NM2RJWWJBNUpmcTg0ejduWWZscEFBZFNl?=
 =?utf-8?B?M1pNcVRwMFFQZmtOVXBtMmhHY2lCYUpVQWhCY25rQTdYcFdQS0FRVDdkSFZF?=
 =?utf-8?B?QWhISDNUV3E0U2Zrd0tFZ1AvMHVUM2dwRm9EaVBNZy8rekczVDZhclN4U09I?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2c34f1-bc8f-49b1-b2de-08de2785b623
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 16:07:17.3005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Fv4ZhYooyTRd4f8wkMhq9+ogUQjgwOuNiplHB1msoOM+wyM7p9+NZnDtmIXktaina6a5IKxAs79XHRvglGzqkYaYlNOwxb0axM8W8W5oZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17402

SGkgVXdlLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8dWtsZWluZWtAa2VybmVsLm9y
Zz4NCj4gU2VudDogMTggTm92ZW1iZXIgMjAyNSAyMjoyNA0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY0XSBwd206IHJ6ZzJsLWdwdDogUmVpbml0aWFsaXplIHRoZSBjYWNoZSB2YWx1ZSBpbiByemcy
bF9ncHRfZGlzYWJsZSgpDQo+IA0KPiBIZWxsbyBCaWp1LA0KPiANCj4gT24gVHVlLCBOb3YgMTgs
IDIwMjUgYXQgMDU6MDM6MzRQTSArMDAwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gPiBPbiBGcmks
IE5vdiAxNCwgMjAyNSBhdCAwMjo1NjowMVBNICswMDAwLCBCaWp1IHdyb3RlOg0KPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLXJ6ZzJsLWdwdC5jDQo+ID4gPiA+IGIvZHJpdmVy
cy9wd20vcHdtLXJ6ZzJsLWdwdC5jIGluZGV4IDM2MGM4YmYzYjE5MC4uYWI5MWJmZDdkYTQ4DQo+
ID4gPiA+IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3B3bS9wd20tcnpnMmwtZ3B0LmMN
Cj4gPiA+ID4gKysrIGIvZHJpdmVycy9wd20vcHdtLXJ6ZzJsLWdwdC5jDQo+ID4gPiA+IEBAIC0x
OTAsOCArMTkwLDE3IEBAIHN0YXRpYyB2b2lkIHJ6ZzJsX2dwdF9kaXNhYmxlKHN0cnVjdCByemcy
bF9ncHRfY2hpcCAqcnpnMmxfZ3B0LA0KPiA+ID4gPiAgCS8qIFN0b3AgY291bnQsIE91dHB1dCBs
b3cgb24gR1RJT0N4IHBpbiB3aGVuIGNvdW50aW5nIHN0b3BzICovDQo+ID4gPiA+ICAJcnpnMmxf
Z3B0LT5jaGFubmVsX2VuYWJsZV9jb3VudFtjaF0tLTsNCj4gPiA+ID4NCj4gPiA+ID4gLQlpZiAo
IXJ6ZzJsX2dwdC0+Y2hhbm5lbF9lbmFibGVfY291bnRbY2hdKQ0KPiA+ID4gPiArCWlmICghcnpn
MmxfZ3B0LT5jaGFubmVsX2VuYWJsZV9jb3VudFtjaF0pIHsNCj4gPiA+ID4gIAkJcnpnMmxfZ3B0
X21vZGlmeShyemcybF9ncHQsIFJaRzJMX0dUQ1IoY2gpLCBSWkcyTF9HVENSX0NTVCwgMCk7DQo+
ID4gPiA+ICsJCS8qDQo+ID4gPiA+ICsJCSAqIFRoZSByemcybF9ncHRfY29uZmlnKCkgdGVzdCB0
aGUgcnpnMmxfZ3B0LT5wZXJpb2RfdGljaw0KPiA+ID4gPiArCQkgKiB2YXJpYWJsZS4gVGhpcyBj
aGVjayBpcyBub3QgdmFsaWQsIGlmIGVuYWJsaW5nIG9mIGEgY2hhbm5lbA0KPiA+ID4gPiArCQkg
KiBoYXBwZW5zIGFmdGVyIGRpc2FibGluZyBhbGwgdGhlIGNoYW5uZWxzIGFzIGl0IHRlc3QgYWdh
aW5zdA0KPiA+ID4gPiArCQkgKiB0aGUgY2FjaGVkIHZhbHVlLiBUaGVyZWZvcmUsIHJlaW5pdGlh
bGl6ZSB0aGUgdmFyaWFibGUNCj4gPiA+ID4gKwkJICogcnpnMmxfZ3B0LT5wZXJpb2RfdGljayB0
byAwLg0KPiA+ID4gPiArCQkgKi8NCj4gPiA+ID4gKwkJcnpnMmxfZ3B0LT5wZXJpb2RfdGlja3Nb
Y2hdID0gMDsNCj4gPiA+ID4gKwl9DQo+ID4gPg0KPiA+ID4gSSB0aGluayB0aGlzIGlzIHdyb25n
LiByemcybF9ncHRfY29uZmlnKCkgaGFzOg0KPiA+ID4NCj4gPiA+ICAgICAgICAgaWYgKHJ6ZzJs
X2dwdC0+Y2hhbm5lbF9yZXF1ZXN0X2NvdW50W2NoXSA+IDEpIHsNCj4gPiA+ICAgICAgICAgICAg
ICAgICBpZiAocGVyaW9kX3RpY2tzIDwgcnpnMmxfZ3B0LT5wZXJpb2RfdGlja3NbY2hdKQ0KPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCj4gPiA+ICAgICAgICAg
ICAgICAgICBlbHNlDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBwZXJpb2RfdGlja3Mg
PSByemcybF9ncHQtPnBlcmlvZF90aWNrc1tjaF07DQo+ID4gPiAgICAgICAgIH0NCj4gPiA+DQo+
ID4gPiBTbyBpZiBib3RoIFBXTXMgb2YgY2hhbm5lbCBgY2hgIGFyZSByZXF1ZXN0ZWQgYnV0IGRp
c2FibGVkLA0KPiA+ID4gcnpnMmxfZ3B0LT5wZXJpb2RfdGlja3NbY2hdIGlzIDAgc28geW91IGFz
c2lnbg0KPiA+ID4NCj4gPiA+IAlwZXJpb2RfdGlja3MgPSByemcybF9ncHQtPnBlcmlvZF90aWNr
c1tjaF07DQo+ID4gPg0KPiA+ID4gLiBJbiB0aGF0IGNhc2UgaG93ZXZlciB5b3UgZG9uJ3Qgd2Fu
dCB0byBjaGFuZ2UgcGVyaW9kX3RpY2tzLCByaWdodD8NCj4gPg0KPiA+DQo+ID4gWWVzLCB3aGF0
IGFib3V0IGFkZGluZyB0aGUgY2hlY2sgdGhhdCB3b24ndCBhbGxvdyB0byBzZXQgMCBwZXJpb2Qg
aW4gdGhpcyBjYXNlLg0KPiA+DQo+ID4gaWYgKChyemcybF9ncHQtPmNoYW5uZWxfcmVxdWVzdF9j
b3VudFtjaF0gPiAxKSAmJg0KPiA+IHJ6ZzJsX2dwdC0+cGVyaW9kX3RpY2tzW2NoXSkNCj4gDQo+
IEkgdGhpbmsgdGhlIGVhc3kgdG8gdW5kZXJzdGFuZCBhbmQgb2J2aW91c2x5IGNvcnJlY3TihKIg
Y2hlY2sgd291bGQgYmU6DQo+IA0KPiAJaWYgKHJ6ZzJsX2dwdC0+ZW5hYmxlZFtjaF1bb3RoZXJz
dWJjaGFubmVsXSkgew0KPiAJCWlmIChwZXJpb2RfdGlja3MgPCByemcybF9ncHQtPnBlcmlvZF90
aWNrc1tjaF0pDQo+IAkJCXJldHVybiAtRUJVU1k7DQo+IAkJZWxzZQ0KPiAJCQlwZXJpb2RfdGlj
a3MgPSByemcybF9ncHQtPnBlcmlvZF90aWNrc1tjaF07DQo+IAl9DQo+IA0KPiAoSW5zdGVhZCBv
ZiB0cmFja2luZyBlbmFibGVkW2NoXVtzdWJjaGFubmVsXSwgcmVhZGluZyB0aGUgcmVzcGVjdGl2
ZSByZWdpc3RlciBpcyBhbm90aGVyIG9wdGlvbi4pDQoNCk9LLCB3aWxsIGFkZCB0aGUgY29kZSBs
aWtlIGJlbG93Lg0KDQorICAgICAgICAgICAgICAgdTggb3RoZXJfc3ViX2NoID0gc3ViX2NoID8g
KHB3bS0+aHdwd20gLSAxKSA6IChwd20tPmh3cHdtICsgMSk7DQorDQorICAgICAgICAgICAgICAg
aWYgKHJ6ZzJsX2dwdF9pc19jaF9lbmFibGVkKHJ6ZzJsX2dwdCwgb3RoZXJfc3ViX2NoKSkgew0K
KyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHBlcmlvZF90aWNrcyA8IHJ6ZzJsX2dwdC0+cGVy
aW9kX3RpY2tzW2NoXSkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
QlVTWTsNCisgICAgICAgICAgICAgICAgICAgICAgIGVsc2UNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcGVyaW9kX3RpY2tzID0gcnpnMmxfZ3B0LT5wZXJpb2RfdGlja3NbY2hdOw0K
KyAgICAgICAgICAgICAgIH0NCiAgICAgICAgfQ0KDQpDaGVlcnMsDQpCaWp1DQo=

