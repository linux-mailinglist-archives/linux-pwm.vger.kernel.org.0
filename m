Return-Path: <linux-pwm+bounces-5890-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC99DAB30E0
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 09:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9723B799C
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 07:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DC9256C73;
	Mon, 12 May 2025 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="f+G1ghBE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010004.outbound.protection.outlook.com [52.101.228.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1F1B4F2C;
	Mon, 12 May 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036556; cv=fail; b=NCIwKhC+P9/hKhPq90JV02JQzbARfpXZ9rsfGCySnEaNtTPqyE8d0GsfSHK/LpDf+0iYFClKu5VlFfgpFpw+FYE8AVM6k2+nZhrInt/RePNsDelKQFojUXLM0EqCFnAhq+K2Sf1f/fRUktAe/uqiGIxtQr23JBD3Ue3Dv+L40Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036556; c=relaxed/simple;
	bh=ATMdggdFIfNBzYLP/9qXlVnd6t5JSqz1HwMYOoznb8Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pexE/r9Zub8BfnYTghoifWdN7YTSlA6ZFNXpNlF76gTrl+lXJTqikevVyVzKv0N9UVpZNQnuYVqsX7oE5kUIqi81c0a3+Q4ljfhD7/MrvpJAvv7SolQLo3SkgIjHwqGIcysyVqp0LIk/gx3o+gYoOcDzi7P5LBmZgMRQ/cCaW90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=f+G1ghBE; arc=fail smtp.client-ip=52.101.228.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iu6OWOIL4XyW44J8W4POc61mRSMkwwrWyX0Y6e5CzLh7C97/nei1rLc9Q4KmHMP4WwAyTSuRNkLW6Q6rw6h6dC9nydIF6c6exp/syFSxdGBJfWHfRpfk6KTD4LXn5CpYz8iinRQIM+3sirpu3Li3bJCLIH+ERpcuXa8Mk9qVxikG5wHgzn1Q/KEddPelLXT/3+qLkDFfchUdzQa/9k9qpBQf3OGH51WR5syw6cTbmKgPohFU4ZeiewdYM3saR4Hl4R7xXU17jY7gfQ7ItEcQvBk7HEO7kS01D0qIofsM0AoIIvq0wKjJR99rvydxbDvrXxwq6+h2pOfHoBlww6D4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C8o/ZJZiXic5OJ/cqhuFw4iHTfJ9nuvDEe29V8uhgs=;
 b=MhQv5+NRJrLmub9RdMQbb0+03YAVxcWouhTS4XJche6LTWGqV8rbI6JgOatIksV9s6G+NZQ229loqoXbthmfNWhNpxetrH+ecXhxZI91loLUN+YgMSxGwOsAsSW+tDLeZRuerAUN9TpWrT94Fo2wM4dv5kVXPvMxXqp2vBczfXYiRnpiAnOIvOBW+el/PiQQm65tTjOXiMdHtoIYI4XY2wPY1jpG/QDmk890z1qCwPRvu9WSIdBxrmtzRdJVf+CT4Kfbvaj3cMfjRPepnpjwq6tK29AI78x1M3MyxygkYigrXeZUxj3CYbPfFHYF1QpyYwszAt7UFDItnfSii2W+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C8o/ZJZiXic5OJ/cqhuFw4iHTfJ9nuvDEe29V8uhgs=;
 b=f+G1ghBE/DjY60p9H/NilPkWu8Dv/XM9HElyu8UAwsn3Yh6NnvToleQCSOixLuzcSU0O+zSyEhGzB8tFkdjd5uLyTHfBDYqa7ls3U7fzO932TNY/upglSC/NBRI5Zm+w65ctX3qbik4mrkIpCgu6HLxlJwMatdMPSwscSLa2Z5I=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB6367.jpnprd01.prod.outlook.com (2603:1096:400:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 07:55:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 07:55:50 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?iso-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>, Will Deacon
	<will@kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4] pwm: tidyup PWM menu for Renesas
Thread-Topic: [PATCH v4] pwm: tidyup PWM menu for Renesas
Thread-Index: AQHbwwe+/s6UGWdBX0O6Ch3mXh7KE7POoBnA
Date: Mon, 12 May 2025 07:55:50 +0000
Message-ID:
 <TY3PR01MB11346D6626BC7B87D6D82351A8697A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB6367:EE_
x-ms-office365-filtering-correlation-id: 21682f27-9be4-4bbe-f1f9-08dd912a6999
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?74vnxNGeuIXrjeOSWXKywHAjHdxtS+bdwHgiFLqpFRyBRRL+el7OFqMUrf?=
 =?iso-8859-1?Q?ZEjl62q6t/mglqZvvSkUbg84S0EudS3E2o3a/MUCRJekW2bizzPnPoj1nY?=
 =?iso-8859-1?Q?YKA7arrqLWCS+fs8hBIGMsIN/vD/uvGWoR1d7RSdkKJ4jt3aL1rX0cDQAW?=
 =?iso-8859-1?Q?q4RmdMahBw7xNt+xsGYPJQB6rEP6ygSaTMYOBwOtFw986J7K9CGSaAEoI4?=
 =?iso-8859-1?Q?aOqHp29q8FnP/h4+nzT4PCoQFY/++EZVvK+B2kuZrxgEnL7kZSn3jXkF35?=
 =?iso-8859-1?Q?lAzzbHNc79IQzHMqDwRgP/GhtisvUoZjTMG/avdAcucmezsnsc8uu6ICnH?=
 =?iso-8859-1?Q?jm4uUdLsVo1IqwdHubLjDya//GuOkzaG4EUxFrOFnkVab7HB4QewcNDBk6?=
 =?iso-8859-1?Q?ASA9hZaewKTONr5bt9k7rWSquIHF3xwy4C/strzSD+KZ5SVFoCpnBTfAhp?=
 =?iso-8859-1?Q?XZ/faeqd8WWQIpe3aqY0iORESVribnOtVcGsln+rlEQNBwrz8EIl0Z0s+i?=
 =?iso-8859-1?Q?Bqhehu+bXlEDTsH/WCrN17aN+KRBisYywlNvHZ9oCE1DIh5TLyTFwQBQPd?=
 =?iso-8859-1?Q?lwq/10ulGgYxQl48UHgnM9oj05vzNKTZLRSnKl4lQJLyYOyP+k/wGuGd+g?=
 =?iso-8859-1?Q?KZHCh4aJN9hc3RZZBXOBqq4lHlrYv1BclBFOr+M9jzbKlGem2R0JAKMwCb?=
 =?iso-8859-1?Q?ljKU1WU0cYoSiHrrKuYFaliTpBFQLVBlQladpkm2jyTSx/eLNSo+JKKZ4M?=
 =?iso-8859-1?Q?pLSzdSjIXONuHyiczzG4/gXJi/f702EGfgyXiftUO1eYSxzP4ZUVIh26fE?=
 =?iso-8859-1?Q?B4U24icMZTcldrFYLvTpdJdQ0IwlmlntSf6zjKsllqvFM0xH7P+1BgZPkf?=
 =?iso-8859-1?Q?tc8AeZHZX1zIeAUh9j9oeFL6Uy10bNT2mQPCudIYaEgbipLnLNnhIpdCg2?=
 =?iso-8859-1?Q?WhJrsJyyjJESHvgQ1HQ/eBT/CrVAoADvuiEqTmCMjD8sVLgL4fkv8CavEa?=
 =?iso-8859-1?Q?/RqAiNd9jMLncOtNYOiFVqzQPDN72LvVHhlTG9+jNXk7EUKz32FSVnQAeg?=
 =?iso-8859-1?Q?1ump5VwK4Px9gRT3ZwHRos4LhrwdPRGMEWpbBzEVkkU58DgmggpGHxge/m?=
 =?iso-8859-1?Q?Y1M14OYaSi9x0AlRshcL9p5tvvNIejVprKuP2CQw5C5KD4CctVO/fA3XBS?=
 =?iso-8859-1?Q?WPt2Yv9/28XxMTWhNTJw4mpvNV5aaFjqDOzGEF5BlXYmfFI07NHolel5H2?=
 =?iso-8859-1?Q?9ndzu9a9ewwkmGBO3bfJvteACpafuRDPsH7T1zGZLQ7fIJ19AWOrlwMaAm?=
 =?iso-8859-1?Q?exfdcKfs2pPUtjjlkWNNN1cwiPbaNVh0HV6bgmjTmyJ68agu1W/1oM+glE?=
 =?iso-8859-1?Q?CGUnUTw/v5p5qoJFWgNDh+b/ffA2qFFd8Gkow9g6tKeEruHrkdF0AB/yaZ?=
 =?iso-8859-1?Q?/V2YyylUEB66RkaDSah+rmtKo+T6GwcEp92Ns9RN+u3diBHU7yy1NbKQxg?=
 =?iso-8859-1?Q?tqcKCEY1ok6O9J6d5oIhcgXiBETgfhf+S1lRPMtl7i0A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?g68+K3/t/lnWS0vKIsbK3JzFguCtXMBkCDJMADb6Ad7J+DAoO7HOxWLhG8?=
 =?iso-8859-1?Q?7HWP/rqA2RbmA1cOGwwG6PiVnwV9DMtRcJR4ul+T2Ssf10M5S7Z9aWFq6I?=
 =?iso-8859-1?Q?SXfoFaRTbGTR1vJFdnuo0Mt8r+wjzw6lPnHKQorIwZpwdFDPGYDwMdxq7y?=
 =?iso-8859-1?Q?3GPX5VCFlzp9dk9kRtFJLyMTFdWfX7q0HpdG9ZP909LN1I3l9SnhsNjSOB?=
 =?iso-8859-1?Q?Vhz/AKPG3xCDLFzr7C2dPCV0ORVgnRMlm0pc7mI8WLNDbi72xvwMqOqyMh?=
 =?iso-8859-1?Q?YMiEuba1VBnASQGgnZ7jaPZ2VWnTwWOUs/CPAf7HIbX2nLbMlopUD3VdsX?=
 =?iso-8859-1?Q?On+lO7bMt4UQGJydPxX/sEujMHem7+NZ5bCNashrAs5OJwGKvtku9rarPY?=
 =?iso-8859-1?Q?Ei4yGZyBgDxmUG0vUVOCc6Qxw843RbXacLDIuYoNl9pzfjLmLcxB4hYFiA?=
 =?iso-8859-1?Q?ZeoAKtu8er6/uGOZDuONL7wpr2BTk2td6x5QpqxzyleWUph++GZo/sy3xB?=
 =?iso-8859-1?Q?tALtKXVhKGYx41YBjBVDc2xXine+WTXgG91LEwbFxmsX+ITQTXTIGFvltg?=
 =?iso-8859-1?Q?xhbZN7J8F34YkBL7Vu3tP0KrwELaoeLhDOo3c8hkn+0aWzBHaYjLGlBfNR?=
 =?iso-8859-1?Q?mEol9VfMpAkwCBxe+MldcMXOjZ+aF+YyIJopH9VOk6HbfKNe+WIkM4FK41?=
 =?iso-8859-1?Q?/ye/MBww4NtSO59x/nBuaD1/ifY82tmPg5+UBvygBdoFyA6t7cHfA3Yo/y?=
 =?iso-8859-1?Q?UUq42vD6dPAQ6WY5/I2DBPPDo2CqvHQtZKjsq2g1QRmqrIXzYCjaP74Kpc?=
 =?iso-8859-1?Q?WKA9/IFaen61UOjXDlD+ornVfG8ZvZEVzAXhA/CpSTB6dkBmr3J8+arXxe?=
 =?iso-8859-1?Q?/L5H//GuzoX1tok5RnKLEYyWQsQ58kYsqKEevXnNngFtmLQzSdkd9w9Zeq?=
 =?iso-8859-1?Q?u8UHlvjXEtwTR8KA710nL3CFeQhlECeMzWKV/9U9Sn7VhBUEZdZL+3xXA2?=
 =?iso-8859-1?Q?F14TZfldl4QsbBLok/mper6XkWXXrDzRp7nx0zuK4JfhlftKC4681OlQYg?=
 =?iso-8859-1?Q?KQMuCvYCD2d/NB3cDf/ImWJBTjTOVTK0Hp3HrJbET4KBnspUqSUaxypJwP?=
 =?iso-8859-1?Q?HUAPqppMnFauQbzba8j1etpJCpsVKD8LcyQBizmgUuWqyflheeNUt0EmFn?=
 =?iso-8859-1?Q?JGM58xc3lRAugGSoQyw6NrCFHzrd5mRcL+NSANv93/Imbd0/QfGkfsthi3?=
 =?iso-8859-1?Q?p6U41ibQspaH7y4b0onFK8yBWYKckaopoVLyWDbsFIEresQK3z8jBi3HBn?=
 =?iso-8859-1?Q?GYHHWm/Q9yAKRqNInPZswsFK8cv56XzIxOYpPZMBhDseAfNFIp5SWWgQ3o?=
 =?iso-8859-1?Q?NlBWS69ElJE/lBWnCu3ex67Bmcf3RpO/HUjoOURz47WTC1N1jPLK+pBORC?=
 =?iso-8859-1?Q?CkJBNL1+dpdCqvtDIpH1IkOJ7VaxZ7CYjvQF6K8FpCjk9dNVl6tNerXJIb?=
 =?iso-8859-1?Q?que8vOMsscFp70mahJGxFhqFP+ePwCO8GFjsuqkIdw/XIixDjUAs1V2fyL?=
 =?iso-8859-1?Q?NyBs7vKVod8ZrybE7Ke52z3SWmAqFSYB8JID5paAS1iIbTB9qCcXvp5Ras?=
 =?iso-8859-1?Q?LvOqIZyNW+/OKwfh7395hmlbQXeu50ZOdtOHaNLQICZIG1g1Jmsymgjg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21682f27-9be4-4bbe-f1f9-08dd912a6999
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 07:55:50.2438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3nOu2uch3zZsv7XhuxAEwOQs+C1t0Sx7ZWIZWZvTIcSwnh3+r6QfZxNvEdFSbFHph/cnistdjK+TFz/VeC2vmGamJhfi8ulmgWdYNcvec8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6367

Hi Morimoto-San,

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Subject: [PATCH v4] pwm: tidyup PWM menu for Renesas
>=20
> Because current PWM Kconfig is sorting by symbol name, it looks strange o=
rdering in menuconfig.
>=20
> =3D>	[ ]   Renesas R-Car PWM support
> =3D>	[ ]   Renesas TPU PWM support
> 	[ ]   Rockchip PWM support
> =3D>	[ ]   Renesas RZ/G2L General PWM Timer support
> =3D>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support
>=20
> Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas, and sort=
 it.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
> v3 -> v4
> 	- Based on linux-next/master
>=20
>  arch/arm/configs/multi_v7_defconfig |  2 +-  arch/arm/configs/shmobile_d=
efconfig |  2 +-
>  arch/arm64/configs/defconfig        |  6 ++--
>  drivers/pwm/Kconfig                 | 44 ++++++++++++++---------------
>  drivers/pwm/Makefile                |  6 ++--
>  5 files changed, 30 insertions(+), 30 deletions(-)
>=20
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi=
_v7_defconfig
> index dc4b722ad4b5..50c170b4619f 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1184,7 +1184,7 @@ CONFIG_PWM_BCM2835=3Dy  CONFIG_PWM_BRCMSTB=3Dm  CON=
FIG_PWM_FSL_FTM=3Dm
> CONFIG_PWM_MESON=3Dm -CONFIG_PWM_RCAR=3Dm
> +CONFIG_PWM_RENESAS_RCAR=3Dm
>  CONFIG_PWM_RENESAS_TPU=3Dy
>  CONFIG_PWM_ROCKCHIP=3Dm
>  CONFIG_PWM_SAMSUNG=3Dm
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmob=
ile_defconfig
> index 0ea34d5d797c..7c3d6a8f0038 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -203,7 +203,7 @@ CONFIG_RZ_DMAC=3Dy
>  CONFIG_IIO=3Dy
>  CONFIG_AK8975=3Dy
>  CONFIG_PWM=3Dy
> -CONFIG_PWM_RCAR=3Dy
> +CONFIG_PWM_RENESAS_RCAR=3Dy
>  CONFIG_PWM_RENESAS_TPU=3Dy
>  CONFIG_PHY_RCAR_GEN2=3Dy
>  CONFIG_PHY_RCAR_GEN3_USB2=3Dy
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig =
index
> d0768584647c..fe021cbb6393 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1536,11 +1536,11 @@ CONFIG_PWM_IMX27=3Dm  CONFIG_PWM_MESON=3Dm  CONFI=
G_PWM_MTK_DISP=3Dm
> CONFIG_PWM_MEDIATEK=3Dm -CONFIG_PWM_RCAR=3Dm
> +CONFIG_PWM_RENESAS_RCAR=3Dm
> +CONFIG_PWM_RENESAS_RZG2L_GPT=3Dm
> +CONFIG_PWM_RENESAS_RZ_MTU3=3Dm
>  CONFIG_PWM_RENESAS_TPU=3Dm
>  CONFIG_PWM_ROCKCHIP=3Dy
> -CONFIG_PWM_RZG2L_GPT=3Dm
> -CONFIG_PWM_RZ_MTU3=3Dm
>  CONFIG_PWM_SAMSUNG=3Dy
>  CONFIG_PWM_SL28CPLD=3Dm
>  CONFIG_PWM_SUN4I=3Dm
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index c866ed388da9=
..d9bcd1e8413e 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -534,7 +534,7 @@ config PWM_RASPBERRYPI_POE
>  	  Enable Raspberry Pi firmware controller PWM bus used to control the
>  	  official RPI PoE hat
>=20
> -config PWM_RCAR
> +config PWM_RENESAS_RCAR
>  	tristate "Renesas R-Car PWM support"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on HAS_IOMEM
> @@ -545,26 +545,7 @@ config PWM_RCAR
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-rcar.
>=20
> -config PWM_RENESAS_TPU
> -	tristate "Renesas TPU PWM support"
> -	depends on ARCH_RENESAS || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  This driver exposes the Timer Pulse Unit (TPU) PWM controller found
> -	  in Renesas chips through the PWM API.
> -
> -	  To compile this driver as a module, choose M here: the module
> -	  will be called pwm-renesas-tpu.
> -
> -config PWM_ROCKCHIP
> -	tristate "Rockchip PWM support"
> -	depends on ARCH_ROCKCHIP || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  Generic PWM framework driver for the PWM controller found on
> -	  Rockchip SoCs.
> -
> -config PWM_RZG2L_GPT
> +config PWM_RENESAS_RZG2L_GPT
>  	tristate "Renesas RZ/G2L General PWM Timer support"
>  	depends on ARCH_RZG2L || COMPILE_TEST
>  	depends on HAS_IOMEM
> @@ -575,7 +556,7 @@ config PWM_RZG2L_GPT
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-rzg2l-gpt.
>=20
> -config PWM_RZ_MTU3
> +config PWM_RENESAS_RZ_MTU3
>  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
>  	depends on RZ_MTU3
>  	depends on HAS_IOMEM
> @@ -586,6 +567,25 @@ config PWM_RZ_MTU3
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-rz-mtu3.
>=20
> +config PWM_RENESAS_TPU
> +	tristate "Renesas TPU PWM support"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the Timer Pulse Unit (TPU) PWM controller found
> +	  in Renesas chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-renesas-tpu.
> +
> +config PWM_ROCKCHIP
> +	tristate "Rockchip PWM support"
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Generic PWM framework driver for the PWM controller found on
> +	  Rockchip SoCs.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST =
diff --git
> a/drivers/pwm/Makefile b/drivers/pwm/Makefile index 5c782af8f49b..96160f4=
257fc 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -48,11 +48,11 @@ obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.=
o
>  obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
>  obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-poe.o
> -obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> +obj-$(CONFIG_PWM_RENESAS_RCAR)	+=3D pwm-rcar.o
> +obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
> +obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> -obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
> -obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> --
> 2.43.0


