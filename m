Return-Path: <linux-pwm+bounces-7917-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BB3D2ECF2
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jan 2026 10:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 386FF3017875
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jan 2026 09:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2533570C1;
	Fri, 16 Jan 2026 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Qv2ickAP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011011.outbound.protection.outlook.com [52.101.125.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A23570AE;
	Fri, 16 Jan 2026 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556050; cv=fail; b=F8WWyGm5jLcZsPcFb+Eim8BTQdGZ51+sqM6iFnBRJPOn3zMxRnVXVBZAfXKxN673FPQ52kfoN4hq80xE8Pj1LQzJvE0RiAPrHc1gy8AQVDwRl3DqarFPFYyb0hijmlb7qfG512wknODtJnVsIBkbfWxogrnqxHm9zFY1J3Kie5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556050; c=relaxed/simple;
	bh=aEAQ+BM6Zxqt52CS3lo9mEhdUEruM0X2Ojh50JLKH+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJHyL2ngpe3VkbdqLgadVWl0CcYUTWI5//l83depmsihM2H8INNUv8EFZVeFaKGAR9AeV9w4dX4nYWVvv2ukL1IWx9W8uBrSuc3qwv2YQpkM2WbFLBfmLtK4BWVSBkxIv3dnd5RwZ0nXZUGpS6VVqLLCv+Z7VB4Qb7/sjCcgh+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Qv2ickAP; arc=fail smtp.client-ip=52.101.125.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lutzu7uxRJKjNAbct6S95aItUBCpkqjvbkIA/tHv8+O/CmcT0Hcr2VIUyKg/QDID3VXqJt1gaScpABlMLuxhywXMknCGbmn1YKPa3OBeSBv5suElW2GM8CScLn0Bs4ydNht+tdsmZrOU7ojv6abZ8c5mnN6OJyK8/PUHzfO+MrnnDJdHMehOq0w90Z95DDOrRv2xoypwh4RCI3Z4fG/+dIOuHrN2Ru8PbzOqo/7iBA30l1zE9pYNC7H+FBSgSrkdyUeEw22ltNaXLPEc1O80SX29S4bljYyfL1Lu7C4lecFyTHPft7ZEOY1MIzbjGdQ/IgEa+abvTP4WdimUTudffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mun5J5K2gMokWIXDcZsIu89MBsznQMSWiPkt0CMHfTA=;
 b=RUQaSfqUATFg6M0Z8srQgeNXHc+BHpelvrjBJ9v+FdxCROnd3ekB/MIlGe/qIYGdSL42xKOgPM3iY7hPDYWS2XDBDM4yXsRPTmmmJ8VsJmOvbCenQUekX2dfKAMY9agRbDheCKdzn5mFaOWOzH2CN8ZaCG3DgRz5giN6FahRWKhCDTDmAQhNQ6fx+WVp97kkFzxJSSwGY9jK94/4duKVUvTt4qf/yIwmxC+AJ9jXZc/oHO1AfJgIQux8tYUkfj3XUw2Ur1otnE+p+wgQ7CgT6sRLIrRfld2yfwsQeIwr2mposyErDoJ6KdrVJqOjpHMObIBc6GZcDCHyVeScLfP/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mun5J5K2gMokWIXDcZsIu89MBsznQMSWiPkt0CMHfTA=;
 b=Qv2ickAPQfcbIa/TEa3JC0j4gkm8KFMueJ/aKxVrZNpGqTrK9rO3sYXc2iFBPohf7tC3kL5Ta1/aXU8unw06cOCUiJBm8hh5q+ix8C0hsgoALsIe7OfGNRoqnQWUVZAqQupJ7XZsriLO2I5Un8IoYaw9pOWhHRz9C40aQF9EzEE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB12516.jpnprd01.prod.outlook.com (2603:1096:604:326::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 09:34:02 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 09:34:02 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
Thread-Topic: [PATCH v4] pwm: rzg2l-gpt: Implementation of the waveform
 callbacks
Thread-Index: AQHcYFKbxtrpKfQyOUiFuoRTR/y6fLVTSLaAgAGJXfA=
Date: Fri, 16 Jan 2026 09:34:02 +0000
Message-ID:
 <TY3PR01MB11346A3DA30AF85296A927D1D868DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251128103431.161591-1-biju.das.jz@bp.renesas.com>
 <elf2i3oefpflkcxup3howpikgwko6uvm5rkimqwyzhq35nwowk@vtdbe6ad4rkw>
In-Reply-To: <elf2i3oefpflkcxup3howpikgwko6uvm5rkimqwyzhq35nwowk@vtdbe6ad4rkw>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB12516:EE_
x-ms-office365-filtering-correlation-id: 7b44c118-0784-42e6-6735-08de54e2629f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bd1caG6ZQQ8Ink8bH3iWEd604A4xINH0UNEkv3UxmZocv+lwcgcvMyGauv?=
 =?iso-8859-1?Q?JDa6u822xHm+3PNclX0uuprZa1RVnApW3Ig/nl3wsXzph1Z0aoc7gq+QoE?=
 =?iso-8859-1?Q?MuhbjudrZQQq+ULbBh8zd02Rp3UJR3KSnzRx9iatdBC0TRWK9ND549KtNB?=
 =?iso-8859-1?Q?3ObTEWqwU1GhW73P6LVpjztVcrW8iv0FlJBAuT/nWSq4InXwnmBidv4pXo?=
 =?iso-8859-1?Q?F3s/T+V6kNrlOTpRV040JUA4dkDZaShsVUfdRc0N0668rkS23MeKa6AQ7a?=
 =?iso-8859-1?Q?1BF/HaNLaEauolpdqcvGkN496TyM1TaX/wiVUNyjFn0iMeVUMsmudqOkx1?=
 =?iso-8859-1?Q?qMLPXi9pn8doItF2SHRv/cCZLYNIyTklB/NmyadNXlENdH17zP5Xnpipsq?=
 =?iso-8859-1?Q?EKK9+NUpM2QlF+GhWoVLaV90y7Dyo2ilYFH8gjx/m7CDQ/HJjg9UeiLGhT?=
 =?iso-8859-1?Q?JSi/tQkyv84fWrkGm6wlDVP+UF0zEGHRA68hjO0cQDVCHPA2Os/bms89Zp?=
 =?iso-8859-1?Q?yjJBL+O8nC3zaZzug+4+UUxkTjek0T6YddQcR+AR/ebBzyj8TW2zJFHChv?=
 =?iso-8859-1?Q?uezIDiGvV4Yw5XDEXN5NPLxi3t93wqA/Qs7Evi5J0hteMIe5Bla+l2XUmk?=
 =?iso-8859-1?Q?tiUZUl/edOnkkdSW6J4snpIOiBPOevR9u5UBnObHKtLknPjL/6RzhOl40S?=
 =?iso-8859-1?Q?gDiKZv8JN16YQ5Z3HvUFJuPGGhYTjfY8K8N9Jj3xGvmaKF8iSG3Mj+dnZb?=
 =?iso-8859-1?Q?89INnE5eyl9+m9nBkYfBhCW6Y0zwEzzfkD1Jvy+12ahCZkU2KQHzagm/lJ?=
 =?iso-8859-1?Q?/sB6YD1CsN9/6r0OboFddpFZ6hN+lKCMgGzuZmv5WE270IbSsNAVpTL7eD?=
 =?iso-8859-1?Q?A5G6r5yHr5DCuvjIJnCaVoLZ3ex12i83+UHmWECDlzzu+jvEYn6gQtTfzP?=
 =?iso-8859-1?Q?i5mnK68ebBRdnQq1eQjJML5/JchE9jR96cqjx6fkSphJBscrYNv1TM2XYr?=
 =?iso-8859-1?Q?dk8FcIH2EIZKRNOEp3Fms7z1lsW80qjNV6Z4FV2FWN/HOrPkKkbMQZY3IK?=
 =?iso-8859-1?Q?oCDmAdB8EleRnATSRosRl7l/ldv855EWnbjKDYk8ptx3b86ApvjMkLM5Ar?=
 =?iso-8859-1?Q?fu2RTUbFFong+3MnQs6iFtvtxMY4qoLQQrsWRqdK2C7O5JJQ4Vk4t37aMj?=
 =?iso-8859-1?Q?JG20WoQjthCnkE9h9yAHpgrZvxhgDste0E60uwHNf9gO7PMsLTauljW02N?=
 =?iso-8859-1?Q?wFNouBUoNa0lq8wr5OKNAweOaQO/BWCPHVt5kq93uPwLBvEUoxqaPpOPpM?=
 =?iso-8859-1?Q?y7rN3MjIm6/9zs924GxqZr7aAn1dAiUYReYdx38rpjlUonqWHFpdVE7YDN?=
 =?iso-8859-1?Q?BX73kh20KBUuP2c/NGewPhxHfFWqGxKrFNA/bMYr/gLf2WTdXlYaBBA0U1?=
 =?iso-8859-1?Q?HdWHap7XysPqBvZB2oMqVrXlZXXT4lgChsPXzOnrflXiP+mZhvta6mS6cQ?=
 =?iso-8859-1?Q?SHhuDt2amprgtss/a42RtJdmw5mGSajAImHb6gH65knVndMmtfRT5ZPj9s?=
 =?iso-8859-1?Q?vklRLvMWgVOkXXKbYYI30TgQXpDiv5gj52aTE/HNN3OPHeLzCdBtDoeAJ7?=
 =?iso-8859-1?Q?u9VTAH/LJeP/4iB4FJcq550pZfu/CMIGea+OtMd9fH4TYfFUyhcL5GI+Qv?=
 =?iso-8859-1?Q?thaVgC3CM47Y9gLP22I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?t253RpoTnJyf85rSGcT8qDjWwavcN7bXRRMQNxKOiYU8RAQiN6hIUPe65G?=
 =?iso-8859-1?Q?+nVSIUHv7slrHkqI9MUvXkM6YM72mWpxLwAc27QjeszR6PR3whPhrHcMqF?=
 =?iso-8859-1?Q?x73vylyBHv8/kBAXIgMqB8x6dafAkaoe350olBQwMGQCemFeAsfBKKby6S?=
 =?iso-8859-1?Q?hThMzwwFdgM4rjyD4O5WWI6fuwjszdjooFWiSuujTBihgoVQ6RLiLS8p6Y?=
 =?iso-8859-1?Q?PYmRdvw2pNSs77oOZsBYVeM5oEHYErDvfbZDxh3E+QOqxERr86p9dVzV97?=
 =?iso-8859-1?Q?LLDFNodiWEKr18ZVarmXeDkZrtcXUb419HjuZ6zNMNXBzEdcSCkUGNgGcf?=
 =?iso-8859-1?Q?xs/VRa32Orw2pvSrsOvh2eIHqxx7jff1m3TkBfkfY29+mGq7MXsjY9kmQe?=
 =?iso-8859-1?Q?S32waY8qFJjeImE4TzyXxTnxPf3O4k/i9sPKdx8+a+95/167Z43ZX/ryRT?=
 =?iso-8859-1?Q?viacn8yjDbzQfdJ1rBCyOoCvVFG2Xm3dRFzlDCaMFnOBN69sn2araoeVhp?=
 =?iso-8859-1?Q?NVSrmXDHMHm49J/4JHEjvO+2lLF29w4rUSzxn7r9fvPm32KeJBKI3eacdd?=
 =?iso-8859-1?Q?7Jw9txYFZggCfhkruHJR0Hu6uQ+sGuGfoBEDSGf2EU0SNInJBQxj3jTiNs?=
 =?iso-8859-1?Q?O4AUrdPcc9n1hQe1Cit0jkXXFVCRg3VsdcUSMLifWchte61rF3YftwtJRm?=
 =?iso-8859-1?Q?7ihvxOH9Wo1GOfnRmNUaWOedKaQWGlQgROzX9DPpmzlIIci5c/TnjjL4fR?=
 =?iso-8859-1?Q?Sn2Ag+5GqLCSryrm4lFZRBNrdVco7jjVBgaLiy8bWNdayiK/6C3TcwZ6eH?=
 =?iso-8859-1?Q?oyTsJSdT+tp44YxUzyOqByh0CaVSd3m2HIvZyslv949eSxVGZJXMrl4aGO?=
 =?iso-8859-1?Q?s9YUrdE4qkVKiCjFnSYBfCrYnYJT53btdkrYyjZVNSZxqFhXrYzJroCTej?=
 =?iso-8859-1?Q?6goBgtJqwRtNFsORZWYHuVbqAjeZzjBHS/dNkTZHegiE/soOR58KOhNEp9?=
 =?iso-8859-1?Q?GCPqmq0bu9exEMFz3Ucn244pxmgM4UeKlm4QKY29lacCgoZLy7Pu9blqpP?=
 =?iso-8859-1?Q?a/fWgyOFye6rMSpPPD+MU+khRrEHber34KZmvIoQFg9gKNmMaTEVhW8/12?=
 =?iso-8859-1?Q?8rc+dSYoSInCAEQUVss/Dwbqb+Rpwd4zL/9Q0PZIWFfy8Nh7fduKHj8S+I?=
 =?iso-8859-1?Q?QySQY6UlVMQQ3v5yYWVh0Kp/iWtxwmR6OCmUEmitdPHIZxDefTFvRnd7Zg?=
 =?iso-8859-1?Q?/71MorcsqvGy3IG6TfUWNxiH8/O8wiRAIBOptJl4ddXCkvup8YuFQAN7GL?=
 =?iso-8859-1?Q?kCJOdUsWdS7sVZPG9d9h0bqYptIALW9FuLciJkwU9wZHQxkuKokvQMHeRP?=
 =?iso-8859-1?Q?+VtkpHW8rwl0tacr+obpG2vLn/8EUY7Qn9aJ43wpedm5BmQadmR6X1B8Ht?=
 =?iso-8859-1?Q?/QT96/2rToY0UuEu6TxDI9GBXh0UFu/3NRaBo1mLn8hwQ9JhUwuJjeJ9AR?=
 =?iso-8859-1?Q?pLrDgs+0gsR3NRsyw5Ip9mjiDX1RTmARTdAimrPt7R8whwBBx+fpCZ1Bki?=
 =?iso-8859-1?Q?D9eovYTPSIlh+1BN+iq+ithhTbNRP22NAkP9XG1mVzkSe0o4H+leTK9i9d?=
 =?iso-8859-1?Q?FhYQVSrGZ27dRPYBSQEqCA/r+t/SpHsLDeUAiiwxeTVgmcPzcvW22DK65x?=
 =?iso-8859-1?Q?PBMLRJEOkOndqpP6Lae71ZnH81keNuUjg8nxaCmSzGs9Tq/rZh6vuwSY3e?=
 =?iso-8859-1?Q?J/aVAd37ypOn8NqCZsuajGXzNhvuLXkzF171mR+QNKXXFevmdRFG+lRXCW?=
 =?iso-8859-1?Q?LulzSX0InA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b44c118-0784-42e6-6735-08de54e2629f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 09:34:02.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPano65nz3f8wwZGH5eKws15O4JBuPThIsFHH9hmIdzNqP+h02LYYIz24dv8mKr073HlhHjncdV6+xpXLfQowii6xMzh9kUv2UOX97IOeK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12516

Hi Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 15 January 2026 09:53
> Subject: Re: [PATCH v4] pwm: rzg2l-gpt: Implementation of the waveform ca=
llbacks
>=20
> Hello Biju,
>=20
> On Fri, Nov 28, 2025 at 10:34:29AM +0000, Biju wrote:
> > -/* Caller holds the lock while calling rzg2l_gpt_config() */ -static
> > int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > -			    const struct pwm_state *state)
> > +static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
> > +					 struct pwm_device *pwm,
> > +					 const struct pwm_waveform *wf,
> > +					 void *_wfhw)
> > +
> >  {
> >  	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > -	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > +	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
> > +	bool is_small_second_period =3D false;
> >  	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> >  	u64 period_ticks, duty_ticks;
> >  	unsigned long pv, dc;
> > -	u8 prescale;
> > +
> > +	guard(mutex)(&rzg2l_gpt->lock);
> > +	if (wf->period_length_ns =3D=3D 0) {
> > +		*wfhw =3D (struct rzg2l_gpt_waveform){
> > +			.gtpr =3D 0,
> > +			.gtccr =3D 0,
> > +			.prescale =3D 0,
> > +		};
> > +
> > +		return 0;
> > +	}
> >
> >  	/* Limit period/duty cycle to max value supported by the HW */
> > -	period_ticks =3D mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_k=
hz, USEC_PER_SEC);
> > +	period_ticks =3D mul_u64_u64_div_u64(wf->period_length_ns,
> > +rzg2l_gpt->rate_khz, USEC_PER_SEC);
> >  	if (period_ticks > RZG2L_MAX_TICKS)
> >  		period_ticks =3D RZG2L_MAX_TICKS;
> >  	/*
> > @@ -278,21 +273,25 @@ static int rzg2l_gpt_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
> >  	if (rzg2l_gpt->channel_request_count[ch] > 1) {
> >  		u8 sibling_ch =3D rzg2l_gpt_sibling(pwm->hwpwm);
> >
> > -		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch)) {
> > +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, sibling_ch, NULL)) {
> >  			if (period_ticks < rzg2l_gpt->period_ticks[ch])
> > -				return -EBUSY;
> > +				is_small_second_period =3D true;
> >
> >  			period_ticks =3D rzg2l_gpt->period_ticks[ch];
> >  		}
> >  	}
> >
> > -	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
> > -	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
> > +	wfhw->prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_tic=
ks);
> > +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
> > +	wfhw->gtpr =3D pv;

wfhw->gtccr =3D 0;

> > +	if (is_small_second_period)
> > +		return 1;
>=20
> Why don't you need to set .gtccr in this case? I think it's wrong, but ev=
en if 0 is ok, please
> initialize the value explicitly.

Ok, I will initialize the value to 0 explicitly as it returns without initi=
alizing
.gtccr.

>=20
> > -	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate=
_khz, USEC_PER_SEC);
> > +	duty_ticks =3D mul_u64_u64_div_u64(wf->duty_length_ns,
> > +rzg2l_gpt->rate_khz, USEC_PER_SEC);
> >  	if (duty_ticks > period_ticks)
> >  		duty_ticks =3D period_ticks;
>=20
> Orthogonal to this patch: The if condition can only become true if
>=20
> 	if (period_ticks > RZG2L_MAX_TICKS)
> 		period_ticks =3D RZG2L_MAX_TICKS;
>=20
> triggered above, right? So maybe it's more natural to do

Yes.

>=20
> 	if (duty_ticks > RZG2L_MAX_TICKS)
> 		duty_ticks =3D RZG2L_MAX_TICKS;
>=20
> here, too?

Agreed. Will replace the check for duty_ticks from
period_ticks-> RZG2L_MAX_TICKS.

>=20
> > -	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
> > +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
> > +	wfhw->gtccr =3D dc;
> >
> >  	/*
> >  	 * GPT counter is shared by multiple channels, we cache the period
> > ticks

OK, will fix the comment. I am planning to incorporate the above comments a=
s
v5 of the series [1]. I hope it is ok for you.

[1] https://lore.kernel.org/linux-renesas-soc/20251208152133.269316-1-biju.=
das.jz@bp.renesas.com/

Cheers,
Biju

