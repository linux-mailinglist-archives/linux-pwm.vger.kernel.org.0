Return-Path: <linux-pwm+bounces-6961-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B661DB1B64F
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Aug 2025 16:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F519188C9E4
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Aug 2025 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B8274FDB;
	Tue,  5 Aug 2025 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ajjHN4Yp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011010.outbound.protection.outlook.com [52.101.125.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD9E2264A0;
	Tue,  5 Aug 2025 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403879; cv=fail; b=asvC0PLstPtGq771j1EgCmmT3mtGzsVyrrXhw57YN8YyYj8tvBDdK3rVVKU8XPyF3OFf519Kgi3m3uEXsq5K44oFn/9NOM5NcHldMi9HE+rOjChEEMnWIIPcfSqB3f7BLsheQTGxIC8oYKXY/Zah1V7axubu8IpOBNGZUipQS04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403879; c=relaxed/simple;
	bh=gokSUDDFpx9Nuop/DTS09EU5UpB2VtWkwOhTRsd2gKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a3tEUrCrBsg+Fl7xoh3a+kDZAmS4ECbsdiDKj4Bs56tWrEmRtRyA5F6CWqsJOpgcKwSqEn7Spv+fHAkGm20nm4VUvqlfn8qygCFbWvuMDbmv4X9unzic2akkTXBbYtgniePg0+pciGA650HSqyiTvocuQw/Vx9bpnVcM7HUdzNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ajjHN4Yp; arc=fail smtp.client-ip=52.101.125.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYYmB7lEn9d38uYuTSrX8Stmlro5rQHLlBr5aqqo1EfN70Iaib6A82q8dC286jOV9W5wny/7QDZtViZ8gqnO2ZbCRS5fUsvORh+YlVCMBnScy5vfv5w56kUoVUI4ypcACtcgMDgQdU9MGzAhAl42MtiU9ZOH98QelF3jbmkZ9usva5cVIkTDOe2ItPfoArtmHxlZX0dt2CpC5lGGJ62PCdAbcfJ4OxdfY0mT5hWnktFiBHuFWb/W9hCB7oGzfZho2AUy9RoMPUJTWsJ5MlnbZoc/BCMcwSoykRTcCBR/S7evMoGhi30EuARe8WaPFWv+pGExzCaXa/d2R43ifAhxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiSOExNiwvx3+YdOjp2HfxVjswtTKaQcHTg2fXNEyLM=;
 b=Eq+hLG+HzCD7WNNfCM5r22oddVawMcaKH42s5HmD2C1xc1WeeX/HWDyRUGHvbA7BBh773ysIHocra4lMNdcLFGkH/uG/hanRl0A/iUEI8fFmQ7gP7sEH926d5xTvL13mtlP1YSjQA0yutav4PHuSTl3fXFh5vdj4Cw3KfJEDJAr+ZhFiTAA1o3mDX5j7i0lA8lJhAIy2qibQD+L/JgLAXLsSkZ1ckz7el14ioTppeUzJrKKDM+5GKpls6kDlFrDEYbr8hvtkIh5MRbiyY+5gOTyt3oFbLtqrWvfjjIMtah8S19aOaUgBsajJg6HwGjZ4rC5aeczU4I/IsK1VtBXGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiSOExNiwvx3+YdOjp2HfxVjswtTKaQcHTg2fXNEyLM=;
 b=ajjHN4YpvJH2QUm8LJUoc6crNoL9v/BqKdyzrswvWgq9BhDfaNfvpM2foYwCZ6CahbtGglCLvxVxd1zSaagNZiPNMBIf65d3kAxCl65gly58r2S0bkZDTYorxVSd/yhmWO/5XAtanmV1FZ0QLZ7pCQHJSZLkHHj0CBc1h+E3D9k=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB13795.jpnprd01.prod.outlook.com (2603:1096:604:36b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 14:24:30 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 14:24:30 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] pwm: rzg2l-gpt: Implementation of the waveform callbacks
Thread-Topic: [PATCH] pwm: rzg2l-gpt: Implementation of the waveform callbacks
Thread-Index: AQHcBdVEPg25KHxhx0iz4r3b3MOcILRUDcgAgAAOpCA=
Date: Tue, 5 Aug 2025 14:24:30 +0000
Message-ID:
 <TY3PR01MB11346BFFE8362B9B5619AC0658622A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250805065032.193766-1-biju.das.jz@bp.renesas.com>
 <2knipwg44si6rajfcg7e2wxfcjxo625yswkh5v4tsbc4eyvp7r@lhfqj2ngb4rd>
In-Reply-To: <2knipwg44si6rajfcg7e2wxfcjxo625yswkh5v4tsbc4eyvp7r@lhfqj2ngb4rd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB13795:EE_
x-ms-office365-filtering-correlation-id: 5dfff12d-d1a4-4470-a928-08ddd42bca73
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?By4MbdE2I+LPRf8IJg3mXW2phYc4SqBRLcQ3GfIi2QyHUP+Litu/GzU8TW?=
 =?iso-8859-1?Q?8QjS7PmD/q8xQNuIjqgjL/hlB1X+ktGdegFYEP9Y7CDUUQQh/4NI/e2+w8?=
 =?iso-8859-1?Q?j2GrrMxVwxPwrh9B5NihDX508LSAg7oIOge9EAdVmBCKpscV3jTL63vcvx?=
 =?iso-8859-1?Q?5Gzcv7twNT2bZ3UA9ZHFqW8wrQu6DpBfczP8rqPRoC3z0J+bueUwAODi0n?=
 =?iso-8859-1?Q?LzeV4mbU3F8h8xQU+ZEGtD3pb9UEAi0EO58cufMer07XDY+qpn6LKuviAc?=
 =?iso-8859-1?Q?25xlYDvIEQLuuiPr4EeHYO35ZP0BxGNy6NmiURO96rNqfKQ0lupnuCDWUb?=
 =?iso-8859-1?Q?Jf63tRVNEnI1lX5xCYAlNoWTdBs37eOdytXdGdV+IQKFCI9W9rjFdsC8E1?=
 =?iso-8859-1?Q?qbMTlOZ2ahZ3fUaV66QIcgSuDyCWFWRxBm1qC32GZiCmYJsHI8FRPzwjs9?=
 =?iso-8859-1?Q?HAe+qmgKKyY0GSlmvot1/3MohqkbLW/wKCCJ5kBFB2lFcJgB/BBw6zwmwv?=
 =?iso-8859-1?Q?7xhvv+rlyaEFQ+UxaZ+Nq94vKMQWVOCSKo62j9bbbT66l3wpUskNkujGKo?=
 =?iso-8859-1?Q?TmXL0yOfzzaa0Z/zP9fQm2a1QeHY2rMaLBAjUMtZ5giPKyjC1+6WNds/hd?=
 =?iso-8859-1?Q?NdFX3QcHiofsmk5G/pFe6h2k5bexquk6sA4sHUXZEt/bcqH4D/roC74Ow3?=
 =?iso-8859-1?Q?Nk/oaPJL2F/tjL/Ao/aIDI86J7hiIIcK59UCHtQVceYEiDz48QNrplJxQW?=
 =?iso-8859-1?Q?85YBEXmjbpw3SXR+3KYwr2mw0UjtyJsspFb473Uc4BZ2K/VBzciTVX99J3?=
 =?iso-8859-1?Q?cHt4tsc57LxnCPzQdQuqwAboeVWPVK1PufnJwI96qEWPscK7Wn8+F9bXrG?=
 =?iso-8859-1?Q?gAVPhTIqbfBna2vq3c58z5oI0Jx7+np1XiqtHSdZzZCGg0WmR7IFCq0Qx3?=
 =?iso-8859-1?Q?bf89HMauKopkpYgxIUoKraSE/VRB0/8ZdGFIUAFJhPKJQJy6Ot6iWbWxkk?=
 =?iso-8859-1?Q?bsevsbHCMaigtUi1XAcO0DBJsfinhujC9YHUMM6fuGsawykgmPQVQ8E0hD?=
 =?iso-8859-1?Q?2k4+RlNL/PgthnhCzgxx2cb4YER9x1uc1rVPHofRaJY0VlwsUPW1hSWZ3m?=
 =?iso-8859-1?Q?L7wQ104hztNldQr1PkZ2V1FznO1RDGgeNE976AtbDp2NgiW3YZc7Qgimtk?=
 =?iso-8859-1?Q?71BQxqSU3dU2bGwpCZPtJe19ce1R5lBWQSqDBitk0ixmOGIDrRppUW5JHg?=
 =?iso-8859-1?Q?A9oRCL4S9PWZ3UINqWIG8Kr346QG50j975UK6EBPEuqB8d3iJY/HCT3WFZ?=
 =?iso-8859-1?Q?rJXp2YbPDU85ZDJ4sS9L0Q6F93PVbUYLu2q9w01kRzzSRaHp7tWTo5Lgcs?=
 =?iso-8859-1?Q?VcalXgVwvs29W4rDn8wJFAxLZ2H8ItqP30l3pNjKgDpQEAnqrt3K6UJrA5?=
 =?iso-8859-1?Q?+4Co/4wRvFvOM1eWHR+Ol1FnyOxpEQSn08K30SqNktbVs3w9xfUmDW5SgT?=
 =?iso-8859-1?Q?fYECsWZmEfXYKKEv2bYY96J7nbUgVmcUiH0XNQmaEC3cjrpHlG/Bx49ag8?=
 =?iso-8859-1?Q?X8d+h7M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DdAUDBP6NlIQN2Rnr2+5uJ/Aoz4KcvOBTzOgBQdzYdNfKVWCvAgZ/M/d4Z?=
 =?iso-8859-1?Q?7COgSPc31WbeC0/bGzo26xRxFjq4t/0EJdv8tH1XR2MMpdaS/30NG0j7DR?=
 =?iso-8859-1?Q?LNtJaRGqCokrYZznMr4PE/3FBDS0R2n7EjXDToJGTOh7hoSsnIu1+qe3JB?=
 =?iso-8859-1?Q?O89qkk8xulY+HV1K/qZRjz2CbladdaK6j2RrzNrTkNLk8ohQTjeiiCfkx3?=
 =?iso-8859-1?Q?sNnpFc3KQyse8sMWBGEhvaE9wMzChzwMjl6MonNZBls19lRvtIn8VQW+vH?=
 =?iso-8859-1?Q?JKjtjZAM+HQnVCxzRkJqd2SfuEVmttB/ZvSjxcrDRyTrGVbzgzEGRHiEvZ?=
 =?iso-8859-1?Q?Bm+49+J/WTwEaSs6/9ntNeltQL7ejfXd2XnI8XZYWLVIBeQrB4CTt5V3qs?=
 =?iso-8859-1?Q?RuoDjlIJOrzhi11Op6LIfUQH7PYTyRrmRDqzWo42VHy0bCyqnqEVFkqxYs?=
 =?iso-8859-1?Q?o1QMG62cnm0d5/PVTXgyGFeGKLDTm2xUSx3BZ966ce/5H9dn0BRxvO61lT?=
 =?iso-8859-1?Q?ky1/Ipc3TywrDoAkGIfsrB/X5kcaC75qOgfHk9xYurP/0VtZaNHbqEtq/w?=
 =?iso-8859-1?Q?TBgq2cVOH8k7AGbqBV1+/9S//56IekeRlVI5hmfpfF+gKvJ8ZFBhSv7nxc?=
 =?iso-8859-1?Q?PrmWkgdNAYZXY6lthIVTx5TJZy6sB63fkXjAWI6WGiaLrt6WvjOZ8FHjGq?=
 =?iso-8859-1?Q?xjXD6kajECk9oUIO6P/1yC0RfVxn8NpVGTa2pnGQa6nZrlXkAY8O0HE8Aj?=
 =?iso-8859-1?Q?qDaEkCVtEIgQPjCwwpjiLPwST5tSCzVdSEQNp+5LWZNvWvOb1uNrpl63Cr?=
 =?iso-8859-1?Q?ad1cd7f4G/5zmUVSpDqoi8LYvkc6BeQtCzldYJyT4F5v5E8LOPVy/spty6?=
 =?iso-8859-1?Q?714Pp6knthJA0IG7FAZh7b6B+WCW82g3b5FBERw+e9whEoEV2Q8m80rwMt?=
 =?iso-8859-1?Q?Guf8CDGCGX5VxMdzh9Rl+id7u69BaTqmK+N0tIv/OtLyBaDqB9MX8DB3QM?=
 =?iso-8859-1?Q?5AGhwqwx5Vm1ikXpGMhQARdHRqbKtm22ofzWlFBi0uQELrIYoOL8O6HkZC?=
 =?iso-8859-1?Q?CUi9xgSNp2g5/5DyeIOXuXVUW3+1qfCBXBxN3r9b/IgJq9DcIxOAcN143U?=
 =?iso-8859-1?Q?0tpNAgeslJrrel7Xqm5eFhrwbGsJIgsVeUmWY0cJgo6wFFzJY/AMakQ1lb?=
 =?iso-8859-1?Q?J6sGollNGEQuUWxHYBRzJXl6c7f9cO3II1YrA2WW0H1y585J35aIe8dGQ4?=
 =?iso-8859-1?Q?+YZBV0OqTBJEYV3Syf5U2LX3lxU1/luQfNbjBVPiI316qCTApoyuykfNub?=
 =?iso-8859-1?Q?1ewuQTpJ3lTholJwInAwcOPayHYSfY0zaXrqLKGG6Lz0QoAFrjmBr7/Dpx?=
 =?iso-8859-1?Q?i60gWTRmLaJSj5QtmzdAFRxV4bhQ+2fCD8wcxEEAxKbmVgbuBzqcTYAF6I?=
 =?iso-8859-1?Q?qI83O5JtTCvbhJPAMdUcr7s4cbT1lPklgaDXUIw/gsj3OANTkvLSUe8vb0?=
 =?iso-8859-1?Q?mIeNb65wBwKitbEsfBaLbAWoJZh8tazYylDqXkJCxMdcLH+uo1TxJEeuaD?=
 =?iso-8859-1?Q?t436UXPUKYsj2KSv625Cc5UzgsKkNlxSES9HEVoNo4FsbiyAH3XJZg0bdx?=
 =?iso-8859-1?Q?JdTxUKLPEGGiO8Nw+dXm6TF0pjMYYqi2w9TAxrqt10WdIkyLdd5gcWpg?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfff12d-d1a4-4470-a928-08ddd42bca73
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 14:24:30.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +54bLPIbeBxZuxnB4Yy6b8CA3H4Oss+tV51yoPHmusrIfQ5XD9/Ygl1BzOHcN/BMED/JgaUAgcIC+r1mU5+Y1yrvF/8N9FRqSZp86URhOBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13795

Hello Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 05 August 2025 14:28
> Subject: Re: [PATCH] pwm: rzg2l-gpt: Implementation of the waveform callb=
acks
>=20
> Hello Biju,
>=20
> On Tue, Aug 05, 2025 at 07:50:23AM +0100, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Convert the rzg2l-gpt driver to use the new callbacks for hardware
> > programming.
>=20
> You picked a great project!

I started working on adding PWM support for new SoC RZ/G3E.
Plan is to add new SoC with wf callback support.

>=20
> > +static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
> > +					 struct pwm_device *pwm,
> > +					 const struct pwm_waveform *wf,
> > +					 void *_wfhw)
> > +
> >  {
> >  	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > -	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> > +	struct rzg2l_gpt_waveform *wfhw =3D _wfhw;
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
> > +		};
> > +
> > +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm))
> > +			rzg2l_gpt_disable(rzg2l_gpt, pwm);
>=20
> This is wrong. the .round_waveform_tohw() callback isn't supposed to modi=
fy hardware. It's only
> supposed to tell the caller about the current possibilities of the corres=
ponding device.

OK, will move it to write_waveform().

>=20
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
>=20
> Otherwise it looks good from a quick glance.

Thanks for the quick feedback.

Cheers,
Biju

