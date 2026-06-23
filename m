Return-Path: <linux-pwm+bounces-9352-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0hzdJfVCOmrZ4wcAu9opvQ
	(envelope-from <linux-pwm+bounces-9352-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 10:25:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2C96B5421
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 10:25:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=axiado.com header.s=selector1 header.b=pyj5LzDQ;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9352-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9352-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A6523009F64
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53FD3CCFD8;
	Tue, 23 Jun 2026 08:25:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021124.outbound.protection.outlook.com [52.101.52.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537F34252C;
	Tue, 23 Jun 2026 08:25:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782203122; cv=fail; b=NA4lZkhKCeY2pJ4Yisej96gswQL6EL4Mp41BJ+qgUOBMj94M+l3Qklxt/DzOTkI8jzxQ98y+aD7vK5WyApRHMzUIc/zuh/mMB7Mj65lW5Fuv1BRZnsdV3hdeKYlFxaSQ441TSXx/p+2P1fkjywQ/O1lcQOmlN5qOeO1ZzuzOK2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782203122; c=relaxed/simple;
	bh=tJprX2iYCDliqCQPdA9RNcvQAOHfdxkdK/ngLLvJ2is=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UzlVVXpXliwsfbLt8hGdunO4cVZfMVfePB2xvCxzBZ61R1Aq42I4yOrksg1YD/qstPc0E8DUteinHRvnxUzn28kIfjwf3tm+ihWKi3fmndTbAv6mHV8vKtEjy504d23tNX7qT3ZGwmpHhKXE0NodmcEJsMIVxL0MOvSj0SKs97Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=pyj5LzDQ; arc=fail smtp.client-ip=52.101.52.124
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZluNfs0+PU0uWxpzRk8ZQu4TykNQMFvyEFMxb/JUWnrPUVUjy0/tCRsD4J1x5STbBjtkoQ3uedl9/QC7ZW8EwK1sXIKIESQsVWa9yfeyu9CTpgsP1YAFRUuzEa/A6vMJtYp5D0coYJiUGK6uPofvWPUiFW6w+96asdjlJJa8TV7ek3RDJIyZ+sCIsSb67Q9Ib+p2m3QUBIq3JXKckbnlq5gd16Ej/YhLFGC0mRNdCxqzU2a4scbvY4t4aiL2hlqu/vDDdRvuu6k497TnCLKuKtrhW3PchZHGnzyLe0yzxqdmqJnYO5zv0IZFIZ1Dbmni1DD7522VAaPjCJscH7M5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJprX2iYCDliqCQPdA9RNcvQAOHfdxkdK/ngLLvJ2is=;
 b=TNoFqyv0+v0N2gIx6ptU4yPXx8eDLui+AS3vPz6NOTbvLh9DianKn/qq05DdVwVk7ngIfdJuxKxksHoo2m5Diuscj63I4wekBGJXH3dItYhK9vIXUY/H7iddmYj1c40NiTrFeXl+jpvYw3oTBExRKzs7kHVBIfVjEUa2Xv/VzIOtpVf8x9CAaOKYg1lrYVcKDJeo/2rGnlIo7h9SLjW526vhxY1pf0QNZ0W4T+Twu4Wwu66CjX+F1Sv1mHs9Hkk8U7GSjQLhJN9JEAk8Cx7cdlkLnRGj9kyn8Jw0ZJYeYNlEv/33DKew1MP7vmT8wsQOaOVoVv4bLcFQYDHRR8maRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJprX2iYCDliqCQPdA9RNcvQAOHfdxkdK/ngLLvJ2is=;
 b=pyj5LzDQifKl6XCYMORcail0aDc/D7dQiAkZajgpzGsMazRvLrpEiVeWDCb4mVJVuLsUPaBjuc7rlbXtHjwvbgys9/eXmPjRdSeBr0D3P7rPITLuQGWJ1tmJO3YViRz7gpEi2GiSOhpwiGYcXwW2wQ51Y0+mWYZjdZngD9X6Yf7r2fo/uUpwaJuyZSdsOaF6lwmL45CdjV3+lCG0CZ9LQwGaWiNnw1rhOMXqaOm9zMNwh1HxYYeubNNNIIN3y4x6rJ4MJ1jWsU12qKKNwqIIc90L49kTVyLYdRQgmEAV52ArdostCTfh1R7Wsqoa+HzPzdZF+pf2SnQGrE0eH4NSFA==
Received: from DM4PR18MB4144.namprd18.prod.outlook.com (2603:10b6:5:38b::8) by
 IA0PPFDC97AC94B.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 08:25:19 +0000
Received: from DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11]) by DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11%6]) with mapi id 15.21.0113.015; Tue, 23 Jun 2026
 08:25:19 +0000
Message-ID: <b3dbe076-03ba-41d8-a5ce-e65ac739147c@axiado.com>
Date: Tue, 23 Jun 2026 10:25:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: add Axiado AX3000 PWM driver
Content-Language: en-GB
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260618-axiado-ax3000-pwm-v1-0-c9797a909414@axiado.com>
 <20260618-axiado-ax3000-pwm-v1-2-c9797a909414@axiado.com>
 <ajlf4t_tuuX-Eplc@monoceros>
From: Petar Stepanovic <pstepanovic@axiado.com>
In-Reply-To: <ajlf4t_tuuX-Eplc@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0007.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::11) To DM4PR18MB4144.namprd18.prod.outlook.com
 (2603:10b6:5:38b::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR18MB4144:EE_|IA0PPFDC97AC94B:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd1d3d9-bd01-49ca-d15b-08ded100f60c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	pO7tHU1axgLHyXITLauSRUKTqCvctXs9t8H6PVivJQ+d3AOhqdRNpc8Rigz15vBpercHZx9oS1t1WpvBANpRx7B3PVb6WsuA8VMgeEqTfzDluwKZISExO+RHj3KcuSL2a7rYjMLV1Uc+JOJOHsGxJ/EmConCTg+xt6NFDUovhikFw+y7b0ft19al+PtWuoT+xmDlyMGWpzbxhHq1hrV3rUOrAIyzRn3J2MK0JOrzntOsooi870GvWXFIYwFOxwScu9+jJF9ix5ige31ildSSAZvLKGaH01KRLB3YR3Lh6NeNv7MZOk2etC0+FeNC3tO/3gzigVMec+C26552dOxDPnDpf+hc42Rw2MBD2htc3XKck3tBSPjeNIIgEsdF0jOfJizBX0Yq0Xcf0EwOJPAIUPlBB8qnV63VDb4uAlee1I1NuYmo37O6uGMfiT4iiiv3y7ieBjnYxnoJ1odzK9DHvcSunYX0qcNogtA6hZQ6fqwblnZ2FolsovDI0aE2L9xk4o1XSuTTPNnUhZtpMA7pwa37uoN5wS9rdedd7xsp/nGVBUaevSEeNpqBI708Vr3mfWSpAbrRgpo3zIW3QMqC8ELj0Ib9G1H8D6KIyvAZqyAJHKqcLjYVa0wwMcq1taYg0VOiQkvbprS2NQKmMQEIe0Vb6Caz2gvXz1EyQakmPSw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4144.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlFoc1U4RFdieVAzWXA0K0ppbytRN05vV2pRYnp5YUhwRk1PMG5yWXlNMDBO?=
 =?utf-8?B?YmdTeDVPd09sYzUxY21RRWs3a0xkbFpMbTRCckRDQnlnaldna2lySDZrRkdP?=
 =?utf-8?B?V2p5TlN1bXRFTHB2cGYvV1ZaL0pwM2llc0JDVld6MWNLWDhxbWQ5ZE8yWE1o?=
 =?utf-8?B?d1A3V3A5cDRxU2o1c2p5ZlM2WHB4ZHhiMW11V2pZeE1SMVhqTk16aTZ5VGtW?=
 =?utf-8?B?SHg3MTVTbXduMTg1ZUV5ZnlobFVJSWNTWEcyZ1ZiY3BSY2hjaWZERVY0bW1P?=
 =?utf-8?B?anlCcW81YnhPOFp4WlVFRjVtN0FmelhORTNFWWdyazFYNFF1ZTJoaGRHOHNj?=
 =?utf-8?B?RmNMSXkxdFJmMVA2SHpqUjZvNmxDc2loZi9JR2daUHBlL1pmSkFJY05XRE0z?=
 =?utf-8?B?YUlrazd2VFdnRGRseWdjUThDRThoT3pHend1U1ZmWDNxdCt5bDg2aTZSenJH?=
 =?utf-8?B?NjlWUWx5NzlNc3JHa2dtbVJpdEtJektuZUlxdmJMK2Fmd1o4MkxIa2xLVG9p?=
 =?utf-8?B?eWQ2bFdVYXkyNWZiWG1UaUtpSnAwTjFpOVZING5jVmVaTTVlV2h0SVBQQ29y?=
 =?utf-8?B?OW45clhzTWxOWkhqT21KNktSamhaNjJPWVV0OC9QNVcwNllJNUY1M1JoV21D?=
 =?utf-8?B?NndYQS8rQ1pBOC9nMXRiTWdJVG9VOUR5b3NkM3pNZDZ5eS9yaDg2VExRVi9G?=
 =?utf-8?B?cCtiTkNVa3lpb05lZzBhb1N5ckhuUGVpeGNGL2hXVEdKZ1BSdkFyWnpyOUVF?=
 =?utf-8?B?ZStYY1g4Snd6VUtUNHowaFh5M0V4TDJrY20xOWRXUlBEWURJajAzZWVHRmQ1?=
 =?utf-8?B?b2tla0RpSE9FWkxORGlONkdadmJaaHFMcUZWUlJ6UjdjRGVsK3BEU2NDMHJD?=
 =?utf-8?B?T0JjSWNUYXVqWWxGbHFwMnNRMmZReUpjdFRNYWtmbFk4Vm5mVDZOOUR3bXdl?=
 =?utf-8?B?c3VGaEFuTFIzSGxzTndhYTBnVXlkTGxCSnV0OHIwV1E1NlgzWXorYUpwaU05?=
 =?utf-8?B?ZTU1L05iNlFWd2xpNHp0NVNGaWpoa0txVGt1bHRNMStIK2NmVFJ2UGNoTHNl?=
 =?utf-8?B?aytRdU1hWllLaGVlY1VtWWZkZVJWeFMvU0RPTzBQTkhjMnlFWHNtdEdFNkdI?=
 =?utf-8?B?QW5sWVlYMnYvVitWNk0rTjRLQ1F3ck8zSXZTdmwyczNzazJPaEtDVmYzSzFB?=
 =?utf-8?B?Um1MZ1Iwdy9GSjAzUFcrTWVuOFRlYTluMWlLZTRVL1VtSCtVa0NQRStFR0N6?=
 =?utf-8?B?ZHhtMWVRNHdSUzlxeTFqVVk0U2ppSlo3UWFlenN0TFdyK1FBWHJKclFRd0Er?=
 =?utf-8?B?WHI2cUx2cHJPWTg4YlVObUlCSjFjUXRLZ3R1aXh1R3cyZEZqT3oreHluNDBK?=
 =?utf-8?B?RlJsZG4zNk5vT0V5Q1dZQjYvci9VUEZiQll5QTgzT3l2bDNPdm9WcEhvMXRN?=
 =?utf-8?B?UmdCMXVYdythbmY5aFJLdjlLT3RCUGVsUUxTdnhWSHZ5Ynh1eVA2UWRKR0ph?=
 =?utf-8?B?RWJjVDdwQWNPN3hYZHNlOXZCck5ZM3YwU2lLRDViUEJRNy9PMGhpbE9mcWpV?=
 =?utf-8?B?cWR4SThpb2MxakNhL2R6VlpqbUc5QW82Z2NsWGJsdjJNUEJucVExaXlCa3FH?=
 =?utf-8?B?T0NDM0FxUldUbEh5cE9OYlBZSGhzTXlJZHZwNlllOEVMWDBHa2hiM0RtVFI5?=
 =?utf-8?B?ZTUvZVlUaU9ZYXlGVGIwckp4SFRQWDF3UWc2T2xJSm5LeEp2Nkl0VXUySndt?=
 =?utf-8?B?Vk1laFhNangyOVlQcysrQVFSbXZ4dDZZRlkwOE0wUGNhSEZGS0E1akx3UGx0?=
 =?utf-8?B?RU1aOUpQWThJZDFLdVFaM0ZWaWZNSmRUT1MzaUJxUVlwMGdhVWxDZXRxQWtq?=
 =?utf-8?B?enlySkhJay9WdE1tYlJaWGdJTGZualRNWWN6U1JrcWRuS3BxbjZmQXRkL0Uy?=
 =?utf-8?B?RXhIV3hLTWY0c0VoNjE1RHpkVnVCa1Bkd3lNWC9Ba1pVa21nL21sa3g5QlE4?=
 =?utf-8?B?ZUZjM3VEMEd6MEwzcmFNbW5kTXFieDQ5Y3VLandBRWVuVUdSNU9RTi9FUHdr?=
 =?utf-8?B?YXNQT1V2WlNaUHU1RnBUSkFkL3BWOHBDYmFrZFRhTkZwVThUbDMwTllTeEdV?=
 =?utf-8?B?ZWtLSmJCQ0Q0NE92QUEweDJZcGtHdVFsQUNCcWZhdmJFMWxlRCtxR2JkMlR4?=
 =?utf-8?B?L3pHZEsxVzFPQzY2UWxiOUwvc0dIM2xITGVhY3dYREdLZXBRZWE4Qzhvd3ls?=
 =?utf-8?B?YVNBTkRoZHdlVGJ0dE44SGtra1lmOVNRY1J1azN3eUxZRkhRak1ya2hGalBS?=
 =?utf-8?B?RDhqQ09KckJPYk5mWkhDOWhod2d6cXBBQlJQRUdRV1BDZE1HQzcyQT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd1d3d9-bd01-49ca-d15b-08ded100f60c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4144.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:25:19.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZCIXOQzYisA8iB6Sy8UXQhg9iWBzdA5FcMm80ke1WL7ZCm1S0bvlJyGkz3LYeNKXyZDrlvx1RdYm4OGr4BF8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDC97AC94B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[axiado.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9352-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:akavi@axiado.com,m:pbolisetty@axiado.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:hshah@axiado.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[axiado.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pstepanovic@axiado.com,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[axiado.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pstepanovic@axiado.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C2C96B5421


On 6/22/2026 6:29 PM, Uwe Kleine-König wrote:
> Hello Petar,
>
> Just a very high-level review:

Thank you for the review.
I will address all your comments in the next version.

Regards,
Petar


