Return-Path: <linux-pwm+bounces-5887-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77903AB2F6D
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 08:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E909D7A988C
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 06:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B0F2550C4;
	Mon, 12 May 2025 06:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="AuZ7MenA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010043.outbound.protection.outlook.com [52.101.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FD254AEE;
	Mon, 12 May 2025 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030662; cv=fail; b=VTrLlT+oBphbzbBPsYo9LCOFFCvHn/3lyMYHfx192hPvlWLtC6Q6p6kWPUV4HAMhf08OuwkRksSf02TNw3kn6Ofh+z5hgqHgubGnqVjm9SK2zv3WvVbLF0ERbXWZuGfgb50H/dHrl1VWb2vpF8Zp/WbVvTkONngOLgQu/UtoF0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030662; c=relaxed/simple;
	bh=Pk80y8oWQiCmRYqOYxvMlV1NhGe6PgtQ4kUbUtp+Ey8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cen6pOhEI/rNn2z/zRfN2bH/FdlJpHPkAXqJxFwuJD9pJwXR7cAAGdrjcs63F9BisebwOw4tOLSlCjDlz/r4fJq+NZ0WWroZhVIjbCM53jZzWuwuOPxNAJQ8oluiOeeurDeEYHhZxC37lC9jKLPfOph0E4zxlImI0undJMC3+3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=AuZ7MenA; arc=fail smtp.client-ip=52.101.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCoAAiWsMgsTfO8iS9/y7ovdNOgMPo6eKb8EYxyKHbeLONpig8wwcVw+3UDTp1tV/IJsb6oRv1FhT/Z6tUeaZ4pM1/s+mh1Yo4aNN2h3UpT7f3SSyLiOY5dvm1dPkBA+D7XEZnbl3FNmXoZUEjZSqlozyUTXnZagR1cKUTMPYJsSEGcfTBpJ7W9HBjVRx0DfD91ufh7oRloNTHhico8cDAVzxfew+Arqp+YezaOK5HnDw8gUMCYf7TtGa4fHFmkNQl4hHdZ70Mr3J/Tn8soM5eHiz6W/e+f0EvLllL7x+fWTjex/DqftDb1YExJ+HFN3eu9ZJqGba6W38sFFw6w9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZML8s/2O5D9qXBFceAIn5OLvJiCoIwpbjjYAdbIyZX8=;
 b=R/j16EnhLTzq8xaghH+oB/tP/a8dFBgG+LpiGryj6U2I4fDDredLGivqBqns9H49Bjn6PeL0qsSnCjOEMAf26F30W9yYz/sXCu2AiIVYiPh44udF99qxnu6waEIkN4uTr1WeFQ3NFNDvyQ7tNl+AcLZST0hHB+N/yCztoqLpogQQ43hEDeFsEmp2wsDdsgHkQVHWUGPpo0YyApG35i1l2yK5/g5JbnEI0L14D8RtAG0gcNo3+WqsX442Mf9/G9Vs3nopvDEKKWH+Hn8TlwPrTvUzaR1SuxC+YuGP5ZbkIfhIkEbfQBIojIkkRqP78fonr0z3nxjNmIf43KulBcwPIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZML8s/2O5D9qXBFceAIn5OLvJiCoIwpbjjYAdbIyZX8=;
 b=AuZ7MenAj5L9UssUv0L6nKLYiM65TrHx9JYChP7FmVcy4eQ+mrsqdeA5cVXUYcPSQ/Ajrn05q0/E8EliVU+Glf6uH7my88KkXgxaSVUQ7sFSm/yU8Z5EgIUKD181+e+9efYi0GfI89lYnaDp8HkF0dZAuhaXM1vne5Gzl7DCABE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB13134.jpnprd01.prod.outlook.com (2603:1096:405:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 06:17:36 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:17:36 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC: =?iso-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>, Will Deacon
	<will@kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3] pwm: tidyup PWM menu for Renesas
Thread-Topic: [PATCH v3] pwm: tidyup PWM menu for Renesas
Thread-Index: AQHbwtHrGtp3GZNpjESWAqPHbiLULbPOfvrggAAF64CAAABjUA==
Date: Mon, 12 May 2025 06:17:36 +0000
Message-ID:
 <TY3PR01MB11346547773DD66C0F2DEDC688697A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <87v7q6y9m4.wl-kuninori.morimoto.gx@renesas.com>
	<TY3PR01MB11346BF34853871CF14B7BF028697A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <878qn2xsl7.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878qn2xsl7.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB13134:EE_
x-ms-office365-filtering-correlation-id: 8ded6536-b830-4d56-ffa6-08dd911cb0b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?N7BTe3+A3g/BnUXlf8rXR58cskMBkdo+YZoIRjdNuhQxMTNaF2WJo8+CBc?=
 =?iso-8859-1?Q?rZl7LWH/JWwa0F3qpyv7qCSXlISQ8+ujfqSrIl5F7FQIW+7MK6lv1Ppum0?=
 =?iso-8859-1?Q?gjnfBIh8yPQFxR0uUlWQuPOLDvVXbMKLAG+J2UfNumO1tnGPfEZD5B49TT?=
 =?iso-8859-1?Q?yn3DKCD8utkyUDf8Un1Eya8y/CcLse2yhCQECf34PJ7zFJHo/VQ2L37MDD?=
 =?iso-8859-1?Q?0IMKCHTUS6OuUNUp6D+hE+g5Hbf+QQdojvbdUlFzteEdHwZcOpTkmowHwg?=
 =?iso-8859-1?Q?38Pn4sqYB32UDOhd/oiHufvqhD6AB+3avTa4OLEqwRSDoxAoY4KhqddOCs?=
 =?iso-8859-1?Q?3eM5mM3EXHeqxoe2CqSjr2I/OZSj3XNqGJ8JYCjaoqiNAb8cJjB+v0UupY?=
 =?iso-8859-1?Q?1GNOfq4NnoPznTiQ1XmhzW0lUOG2gijhx0qCof+q28YpOF+ID9ozjQ4QES?=
 =?iso-8859-1?Q?u8LwWGup+M2zwZ7a+kQmo3BXOIOn5gQIbfMWQvZYc/EahTLtwrZfg32K3u?=
 =?iso-8859-1?Q?JohcyZWFrTlqB5SwVeQMe1MHl9ByjwC8PPhHsxKYWJfVW7gCipARR5xT91?=
 =?iso-8859-1?Q?80qWJbuu9HQD84I+XhFqlCt/9s/4io+6FkzN8nd3EzD74758DvV5fjaIIz?=
 =?iso-8859-1?Q?8dmsndd949w+EgqM1TbFYCIH5tCYX6zotTI0W9iXyApUymP6IVzQSzJfK/?=
 =?iso-8859-1?Q?iq+05kMXfRLSQFKQbq8Xuyd5rjVaI9QPyu3VkI8xD7jkyGsUYexjlOwQvU?=
 =?iso-8859-1?Q?KyMgGN+XDIREe3v28qPy+IRVcBlGdv/hgyHDLVWJTM8RtLdhGwURVofvbT?=
 =?iso-8859-1?Q?IXJ9LwFMqBgVQO7Om6woU4jAVV7EsCPVSfCTDidEmZd29PPXyCw2+o+rH5?=
 =?iso-8859-1?Q?aeXpD34qsD+YZ3nv756CWqsO1hwiZpVoXjguhX7sDcWHVPbf42a8kTwztc?=
 =?iso-8859-1?Q?6J6wrIrJ5GNj9160XfverhO2Eje0dqaPq/wc7vefGms8eNBUn2+warRMZe?=
 =?iso-8859-1?Q?QHq1Wix6Wco+nFwxd/yVJSryJk2VM+x/++/egmXBQMPSDjhWVxG5A+x2iq?=
 =?iso-8859-1?Q?77433Ij4FXQFmTebje6PuD+35mljPF7FkSZTpVPEFAVXLm6ggOjLuJCR4d?=
 =?iso-8859-1?Q?+G0e1NrU8X5QHkkhX3fyzXH2OGqP7X3I3SUqENfLhIID1P+qcaew3XD0E8?=
 =?iso-8859-1?Q?XSeaRWo6oBbGu+SMttWmjdlfi669Ibpl+lyBWUjMLbTcMGy7fIAcAsqAuB?=
 =?iso-8859-1?Q?SHux9umGLZbH5JQ2a+8z9BmCnINIQGFKnhxzBY4FaA/LpA5JADEQ+wQVrs?=
 =?iso-8859-1?Q?7d/9GjE3Gdd8AgtAZjsfVffr8R0urhx4BTAUf6JdjeLIF+L5+pAA9kPnZv?=
 =?iso-8859-1?Q?HvHPJkS7zlf69YkM3mR2N4ZhJPwxc96VnwUIS5Ozf7nbL0grwnIFVGccjI?=
 =?iso-8859-1?Q?A3XVtiNKYJfwALwwg/byMMAU3xmea7oTPgQCXrtHJbRCdAY9D0bpmo44jw?=
 =?iso-8859-1?Q?mZxwhwxhHu/YOJHIFXylSP+WKZiiPD0PDRxVUXszHF47FwqpG4IkYyEOqI?=
 =?iso-8859-1?Q?E3RwDXU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?40nMVocTc3yBOFpwRt8SEsSLdjaqWblxNupQXLShjJ0uJ0OudTgxMvui+6?=
 =?iso-8859-1?Q?chuCe4jfZWvULs7PDX/uzx74Er0+xM8wrZ11SEAZdxXQzz3HWd+em7Evh8?=
 =?iso-8859-1?Q?r3uw7taP9m0X1Qx8VqyRC3/PGBPDrhpkJivB1apMLb2ntDbkZiOK/x0ypz?=
 =?iso-8859-1?Q?D9/iFpYFZUQq62rclAzaujGX4cjs5kxhlH9YjhZXjdvkJm0CEOnl+Hp8a8?=
 =?iso-8859-1?Q?vUn0w3ClqDYU0J/ZFi+Wv4ZplHlpaaEvXlMImPb+jyvzwOdWLs+jLPDgmJ?=
 =?iso-8859-1?Q?s4xsriObtJSYKBGhMC2+FCEc7nnXP1MqElMxKF3A/hoy3MBEUx29abXuNs?=
 =?iso-8859-1?Q?qp5W5y5KpbPNmhbLpyFSZ6WJi06OantYgQjKhul/9EeFZhEChUd5W2Szv4?=
 =?iso-8859-1?Q?eeevzPQobLe2EAcy8g8uJ2Q0i1e0nGWIh4QlyXeC+aP7aWHi5+IXRrTeMH?=
 =?iso-8859-1?Q?n2Q4Wsxx4XRmgGrrij7TkWRjK+Lgx/J2UnXxuLl0Q77J2NtbbI2Qj2dbzZ?=
 =?iso-8859-1?Q?J1WCYLl1B0NMnegdlegErDTN4y5c14jXq40+ZpATol7ZqbqAhBoaMEhWN/?=
 =?iso-8859-1?Q?CMVAC6Itn2SlDVaf/pYb00GivTzxBLZhNkdCvXABXcIiy6igzsgzblW7hL?=
 =?iso-8859-1?Q?W2sQvgtklaQEbeRC76fjTbQSbqHKJ6Dj0uOn+uWF+dP05pzYlIScUwY+0Y?=
 =?iso-8859-1?Q?ehYdAovxQ0XHe9nvmJ8wpjivnkBqHDTt53CufcoV4Ub8wUxxEJw9MtcehG?=
 =?iso-8859-1?Q?lr5yCw/WfVwN5a+FzZGNXTZnqXeQZ/6RU5DgX9WtgI7s/TFr9m+G+N3TZm?=
 =?iso-8859-1?Q?AgRR9FLpsZJhhhme7/5WiVz6r++/5I1cJp8zmOvaUwtfU6dmYOuTeLahx9?=
 =?iso-8859-1?Q?miqI+VCoxTz+2wmCEfskSaeEOobdCwZ0SKm4amMFjJL58WmlqtYC87fbXR?=
 =?iso-8859-1?Q?0ypmb+9K4MfPJ2LZ+PduTEMmaYnKvPCzXnLqZrZXqkTYZ0b75GZuPj0A8L?=
 =?iso-8859-1?Q?9Kw1KlHZdlZ2hODCxAjn0wzweKqgX0Xgt+VzCwGzqzvt4L/YiFnanAQ+XC?=
 =?iso-8859-1?Q?5NtJGNvnEjuA2lrL/XC0Sw5r8Xy/hyV3pD0W17vqqPK831vHGg3CjkCkoH?=
 =?iso-8859-1?Q?7OyPS3oL2Ej8WIsfjdD6BWP4DK3kNGQ0vyc1bw3qVhjBAp2OVDk+a1G1mx?=
 =?iso-8859-1?Q?FE+snvLKLSp+xxLaZ+KpAXogKpEEYPle8S6QWf/EQ9k4TkMPI4uwrNZe5h?=
 =?iso-8859-1?Q?gr/Onle/poslqcPbDimWLpXPWzstWrH2paIGdNiIacjAsbqjzpnQvKWWEZ?=
 =?iso-8859-1?Q?kgRScYPKtlfHtqyrBwX5f1hj1nzYfChxLsWTMJPR7OsTGGQGSqDXmFDJI7?=
 =?iso-8859-1?Q?eNUkvD+SHh1lKBkwq2RbDdTn/FpDEbnAAaeJFt2g5RvZ87jT6hsmFWZZ/r?=
 =?iso-8859-1?Q?HCoVJT9Gx/4h3jnGjnEU6YQgkbuWYk74OdTeGUUbMQcrI9sTWaN2VqZfrv?=
 =?iso-8859-1?Q?2hLFP6s6wk8e38/qYhrkZbKqoYsAPlpy58Ki98/jJWsyTGBRbEja0F6dyj?=
 =?iso-8859-1?Q?nARw56tYRyt89d800bZSTkSjsIJ2GsMrypOIhpGXLGLCKUq8LNeIN7PFpb?=
 =?iso-8859-1?Q?kRcmwh4eNxAFqQFf85Mb2VayqqPeZAsCO0Ig8QA7RLcJ9uW/E7W+brQA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ded6536-b830-4d56-ffa6-08dd911cb0b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 06:17:36.5768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvjfb/3tjlYZ2Ff72H0hyE2DwbQYeS5WY50JKqVZxV+LvDk1ZyI7n3FD6KyQ/zh8PHVKGg404ajDYUAUWJC6A/rK+7oEiqW2Y8D1TeLCeWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13134

Hi Morimoto-San,

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Subject: Re: [PATCH v3] pwm: tidyup PWM menu for Renesas
>=20
>=20
> Hi Biju
>=20
> Thank you for the comment
>=20
> > > -----Original Message-----
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > Subject: [PATCH v3] pwm: tidyup PWM menu for Renesas
> > >
> > > Because current PWM Kconfig is sorting by symbol name, it looks stran=
ge ordering in menuconfig.
> > >
> > > =3D>	[ ]   Renesas R-Car PWM support
> > > =3D>	[ ]   Renesas TPU PWM support
> > > 	[ ]   Rockchip PWM support
> > > =3D>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support
> > >
> > > Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas, and =
sort it.
> > >
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> (snip)
> > Do we need to tidy up this as well [1]?
> >
> > CONFIG_PWM_RZG2L_GPT-> CONFIG_PWM_RENESAS_RZG2L_GPT
>=20
> Ah, I didn't know this, but could find on linux-next/master.
> OK, Let's care it too.
> Will post v4

Thank you.

Cheers,
Biju

