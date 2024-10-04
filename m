Return-Path: <linux-pwm+bounces-3455-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3069904C9
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 15:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8161F22D45
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F6F149DF4;
	Fri,  4 Oct 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="qVTiIpTV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010021.outbound.protection.outlook.com [52.101.228.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3CF20FAA6;
	Fri,  4 Oct 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049683; cv=fail; b=ZK+yIMCWn9pocOBhmQNcVBHCcGiBYd+a/VbM3kuCz23s3Tgu448Rl3m/HfjmYUILsBBL4dY1QePxnnFPfB5IrtQ8G3NWqGDd2b3wmewyKtFfB99ZshwXtnxnc4iewa40DFB/g0ny26gtBxVmEoIlrHG2ciI89ndeJnZk7h9ITpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049683; c=relaxed/simple;
	bh=CGF1p6fykPo0o4yx6U8qxe9LjAuiXjssKv9TKqjRMGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L0TCNlL+hVK+yAlEcQCoBiDxuo9S8/h3tomzvqOUG3SbPLgaymQrAlxCoirhtYDnWHN2TMa5PhnM4J5Jtk9zCJDLBcdznv89bhuM4w45rJZnfm9w+YEqUifFIc0Q1gYE+/kLQdOPEsvzsXTwVH6tmJ46BPGLb0hG5NUZCM8T/Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=qVTiIpTV; arc=fail smtp.client-ip=52.101.228.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TM4tG8qm1mruk2yQkeHWQDMGiVqm6uOvhgiF7ySaJMalPItoZzur4Qc7VjM83rytyP6OP6+4eK97cF836SDKdbun/95h0iR8hnt70ouTRgXWDGP/MFyYqjML/yQ4QnminLQpQRc7fqSBOSqo5wUw0bVZ/B9glMup1g4tw6BsGQ8IayKcnWag+mSAmi0/59/7d5ekDwllzvPlQrQArxBjXKp2S92+Q6S6+roUQ4zplOdUxS3YckGiHL7xQh2hopv81eMgFqLfVAWfaKms7NWDyBvNytzIgOjbyUdYN6x2VKWgmKtFMZLy+7oY2+NEQv6H8aby4/7Kg1HtzTuaDdvz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esDWJWr1er4b/WnRukKeh6IbLYnukADKVeHgIjdvxHA=;
 b=N58Nd3c9BP0a3HwD26mnsHVw3JF97YbSIeJPdOj+zoo2f7/+M5Shr6mZv0RRIH+9z8xZ3G5LaVUKOGQIoRTufyCO4r83wkzh9yoOrshrpUx7cGHwlliXSL/uHldQp9OlPNrv+NFspICmJFkP7T10MUGmTQL+nxGFiF8HP00lYi6aPJ2soDLUzO3lEU/I+W0ymeyL/U4n80yp6PM+OqhiRQVoKJntUrWy0hxIJRchZeJ4fZ2k+JO7Xxxiry6prt5H6thHeuUBetNdBdO/saAMfZJaC2cgdrgca0v3A9ePZ8pIzm7ElJPEgxTILAnsg28JdfC5K69R6VaKAZCABfav8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esDWJWr1er4b/WnRukKeh6IbLYnukADKVeHgIjdvxHA=;
 b=qVTiIpTVecL9TFBYFWTu8ruIOJMbSfGO1X62kbfoofyUgM+qUtQZmeP9j0Rju084xqvsNXcttKhcBs3bHMZ7lDN3PxDHpAHYMmjI7hPh/mCEATdeCJJqQf5ohJX+26Yh+5WwyOnkkcNCp0GTjgzNO49PVSwYkZJYtM22zJT/mIQ=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OSCPR01MB13009.jpnprd01.prod.outlook.com (2603:1096:604:332::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 13:47:56 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::7497:30af:3081:1479%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 13:47:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHa6ZU4yCrTG4vERkWCKtT81J70kbJo7ssAgA3CQuCAADLRAIAAAuRw
Date: Fri, 4 Oct 2024 13:47:55 +0000
Message-ID:
 <TYCPR01MB11332D536A0F4F2CA375924F086722@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20240808131626.87748-1-biju.das.jz@bp.renesas.com>
 <20240808131626.87748-4-biju.das.jz@bp.renesas.com>
 <slpywmbmamr4kw4jg2vyydheop44ioladvvm52aocnojgjkcsy@3eoztwsej5mn>
 <TYCPR01MB113320CDF49DB0564A958241A86722@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <thfymed6o42wcascazgpvgq6zcqrjxloz3nt5h2pwypqgs4fra@zeyh36lcphia>
In-Reply-To: <thfymed6o42wcascazgpvgq6zcqrjxloz3nt5h2pwypqgs4fra@zeyh36lcphia>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OSCPR01MB13009:EE_
x-ms-office365-filtering-correlation-id: 12f54a4b-4dac-4698-6c0a-08dce47b269b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?lvQnA1SDcm2ZuU2/HUOlRSDo3K4fugKht+5TiWx1sS8C2fyu62nIDHO+jy?=
 =?iso-8859-1?Q?R7H23IeXvqqGY/IOnDtIj0xKSPtQBmdM3b18mYL5lAWkt0HwwsjILQoBJZ?=
 =?iso-8859-1?Q?Xl3Q7Mzz3sM6L17wxySOdtZyDpmTWAcDSPIb3gRJjQohc8McBiJ4Xk3Qjk?=
 =?iso-8859-1?Q?THnTByen7SLHN5lRporT2z5bqC3FKRxlzNcI0i/D2fTl8IJjKO1I2oPMf9?=
 =?iso-8859-1?Q?M0rWw6axa/koZYkV/8LKFx4IA2yJWJ4iEJIyhFJmYcfcVFiTwJvlvfhfF0?=
 =?iso-8859-1?Q?uRXsQhDSKQRz9CfUMj6xSwOMWtd+F/ZklOD9/DgLu4KtvDLf50adVqZuRf?=
 =?iso-8859-1?Q?UFOOnqp7tSwSCNQlX6fzg22uN1/7CpVs2P5kqaJ56JNa0AiTAEEWIF0lDF?=
 =?iso-8859-1?Q?Iy1CX/jTa2aRrFlKZVwWcBcopOqNKJcNxeWby6jDEho2iyB4mnOaPpy3ZQ?=
 =?iso-8859-1?Q?6W8Nv4DZuDAQ8MrtY6S4bmhhXHQPYVF224Tim2HhR34P3e9+MNvyz6mRM+?=
 =?iso-8859-1?Q?oKLJslp064izvRsWT+GqMYXq9IVVn2j4iASZlYd1Ua/hq+LvavjH3yizW9?=
 =?iso-8859-1?Q?5o5lW30Mpx8lavpXvjPzlwk0cHp6HF27Q0FLgdpBtlA/dDHP9M/+BL/sM5?=
 =?iso-8859-1?Q?c66OVxg8YXkvHe/e7wcA8NqagA+WHovQSJlTF56xuvtiOSMMc3aHwf0OvJ?=
 =?iso-8859-1?Q?DTIP7AOgRVFOJqUoR2aDN11EVb4D38l6oIgAJUbiKJEao6esEOetH6pW4j?=
 =?iso-8859-1?Q?FDF8ypWL/Gky6F9FLuXKiexh0RxrDPlsPc9fak+MW6bMm06XxX/xZF4A3g?=
 =?iso-8859-1?Q?SJfF7cNaK2grh2nDY7KS5RyzCs1N+R7xiaqsGyvwJQI1Stg2zZNVtyr14N?=
 =?iso-8859-1?Q?CSt+vYts+6r2QKBw0cRxPM4dXXv3fNVYdpaMIWqxF0Dm+tzPMd+iC6fM4B?=
 =?iso-8859-1?Q?tyGacSTRhq32OvWIXP5uD7/WKH+yo+HOXRRMmIQAH81VFLmJlBEGF8XaJv?=
 =?iso-8859-1?Q?lo9i6QPiXdjpiS4bR/oh9v3jYdCn8yidY7m/ZvScO7ZWAk8DZH0+PKj2kr?=
 =?iso-8859-1?Q?UUp6/C2qKjOXuwYcB7kTBONlfq0RF8Z/zBZvK9U5IWJcsQ5Ayr6ON/7A4h?=
 =?iso-8859-1?Q?1vyRdNMCaPThitTELLe6AtOoNINOaoe9gwW5Ey0zdNZ+kuY16v73UpeKs6?=
 =?iso-8859-1?Q?+BxI62Y3GzIvujnXt2Qu7i+/+NYRTh7K1hIbLbG1sTdNVFF0ie8Yt6kOND?=
 =?iso-8859-1?Q?AbAM+UBq7TaQOAxNxQNxDPdqEaWCTUI4o4Om5y2uMtwNNbEbg+cIvie3qz?=
 =?iso-8859-1?Q?eUTHfEeRRCiXP+cFdqj2AmHldCH4LPQm+38IMFEq12dEr/GwwgSEFoCLiG?=
 =?iso-8859-1?Q?RSOA46RiNVPBmGAiYyMGmgrtMb0vQ/hQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zL+usfJImENPcBasrkqh9LlulMY8ca5xMSB0okz3U0jmmJ0gOSuznNRNl/?=
 =?iso-8859-1?Q?fxGAObFqPVsxS9GpMjluwxYdflmwKLYh0qOhRNNGzviFLzAAReIOzCEAZZ?=
 =?iso-8859-1?Q?3oMyOXqnpwqD749+PmtvWIrHTikA4Oz02/foiMB1cKk3EV4miJvgWVIxf6?=
 =?iso-8859-1?Q?P45SX5MXzNGBfuiVDkR/7BkogXTIQdMu1ctcFrHOb9DCFuLBvkvSq8qRNA?=
 =?iso-8859-1?Q?H2HpnvTF8JBGPfmBfeqdfs7nzYBnflsjxIP3reOJS47Q0Npj8X4DHI9mow?=
 =?iso-8859-1?Q?gqZrcO6jl03hfvohH5IU5pwYvPR+wbxblAXFpE41hG4xC3ff8/imCP2o7u?=
 =?iso-8859-1?Q?YLbuRTymK/KZdEXMGzD4aeOLgTEfDa/P1AD0OJ5ElaeAb16Jgic316eDlc?=
 =?iso-8859-1?Q?qdSD2ju8pFpbqiH2/OfnUXm/fROlxrp+4YgSzZz695UPqxQJauifsWQAEc?=
 =?iso-8859-1?Q?26VTlstk4Mhq9RgLY4afuW0llYFZ3w+wRAGlxx2zipnVOlbc7l+w6b5HeN?=
 =?iso-8859-1?Q?WcWmUe0hj/H/mpZtdbLgXkN9qoxG4S+EpeIZk39eJ6hApRaIUEU4fwpoeX?=
 =?iso-8859-1?Q?49AIOsBZc1DXUvg2s2WVo336Y4BZ4f0/MaitdIE6AHsIqn3vRKI+ICiOwx?=
 =?iso-8859-1?Q?O4j3EKnmhKVnwcU24oohafQU45U8/+AB/3xa60xsN+3E2e1z1oZALRgQ62?=
 =?iso-8859-1?Q?+gycYuztE1Wnig6KNushwRmM6GwfZjU9z7dmG8Voyu2VAKOv+p8MiIfWKM?=
 =?iso-8859-1?Q?vZRDZm1lID/bxaWG9kOFjNuxpYq/OFnXZUpDuVBLQQsMgj0pG1f+IVc3ZH?=
 =?iso-8859-1?Q?eVaDN1/pQbjydT2Zd8uEgPCLM1xbM7NgW0W58gDbZk8KrvcDav8iT2n4ob?=
 =?iso-8859-1?Q?ePlpPoqkJGwpiVtsz8oZ0pT34JcKP7h1m3Ft0kY+vxF4XFJUb/vdegrgqZ?=
 =?iso-8859-1?Q?fVrJWXcmxHM2Gy4wsolNGANUBDsybzCw86LTIzj4Q9b0N1H3+HvICpOsPe?=
 =?iso-8859-1?Q?8KyICvSOOLSW06BDBOslXPdwoYlKsUipHfAL4P80hTzXWN1FCb2PLfF9JZ?=
 =?iso-8859-1?Q?lGySdJ2M3DNTljhFtRcV9nP9olhwnaQYiL2Zb7fe1C5RQcACvYt50jteV4?=
 =?iso-8859-1?Q?yjIKYn3kTMClZbeQaa5NVaTUYl8W5OWm3aqVVn1QgLK340jcspMdYqBKvK?=
 =?iso-8859-1?Q?Pv4J/WfrtoMkQsnMAr0rBZPR/1r+9bRlK2r+nDmY991tnB9FRpggHm8kqM?=
 =?iso-8859-1?Q?ticI3Qoy/YTpfRXEhS0xvDjWvnTLnBXa14P9iI7ajijcXMTUziSZWKeOqj?=
 =?iso-8859-1?Q?Hgdsp92BP+pTV8SoRCY4sXvpTV3XFd25xcFANcmW2ohrZFCXw9vm2T9Ua2?=
 =?iso-8859-1?Q?3z1u4nwBwodmiaYdjAm/5VEAkCm3XLK+43xv6/q3sB4i09+OtRR9i04DNO?=
 =?iso-8859-1?Q?FMcnSVyAZAn+LuaUGnWLv4YmiQUlnkRmdIbTpFky5njPRwFjxhl+pgcZ/H?=
 =?iso-8859-1?Q?hKk3V5CuS3ZcJ9seoAP+fAbv132X9x9h5VwiS3AJYEWM1vzLRuPGg0i5h5?=
 =?iso-8859-1?Q?xjUSlGPnOIIvMtz9/za+7ry4Lv3L15m6SQ37RKTDZ3T/x2HDC2RX2MBizW?=
 =?iso-8859-1?Q?bXf7DauGbYChec58DtvZ7UjvVxnjBQvdb/YJyh7DiniQhgi1v4yENpBQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f54a4b-4dac-4698-6c0a-08dce47b269b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 13:47:55.9506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrdQJe81K0ufQdpjzogVBr7kvt6EE96R1UnWi4NBO54AtvsxuCMTzJ3qVnCR3Y8FbiN08KS8M1RqBUeHksyV/79+P4ILm5DxOxINfwNsnlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13009

Hi Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Sent: Friday, October 4, 2024 1:47 PM
> Subject: Re: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello Biju,
>=20
> On Fri, Oct 04, 2024 at 09:53:08AM +0000, Biju Das wrote:
> > On Wed, Sep 25, Uwe Kleine-K=F6nig wrote:
> > > On Thu, Aug 08, 2024 at 02:16:19PM +0100, Biju Das wrote:
> > > > +static int rzg2l_gpt_request(struct pwm_chip *chip, struct
> > > > +pwm_device
> > > > +*pwm) {
> > > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > > +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > > > +
> > > > +	mutex_lock(&rzg2l_gpt->lock);
> > > > +	rzg2l_gpt->user_count[ch]++;
> > > > +	mutex_unlock(&rzg2l_gpt->lock);
> > >
> > > Please consider using guard(mutex)(&rzg2l_gpt->lock);
> >
> > Agreed. expect rzg2l_gpt_apply() as it will cause deadlock as
> > rzg2l_gpt_enable acquires same lock.
>=20
> Note there is scoped_guard() if you don't want to hold the lock for the w=
hole function but only for a
> block. Regarding rzg2l_gpt_apply() calling
> rzg2l_gpt_enable(): It might make sense to shift the semantic of
> rzg2l_gpt_enable() to expect the caller to hold the lock already. This wa=
y you won't release the lock
> just to allow a called function to retake it. This is usually also safer,=
 consider someone manages to
> grab the lock in between.

OK, will remove the lock from rzg2l_gpt_enable().

>=20
> > > > +	 * clearing the flag will avoid errors during unbind.
> > > > +	 */
> > > > +	if (enabled && rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm]=
)
> > > > +		rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D false;
> > >
> > > Hmm, not 100% sure, but I think if rzg2l_gpt_config() below fails, cl=
eaning this flag is wrong.
> > >
> > > Does rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D=3D true
> > > imply enabled =3D=3D true? If so, the if condition can be simplified =
to
> > > just the right hand side of the &&. Then even an unconditional
> > > assignment works, because
> > >
> > > 	rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D false;
> > >
> > > is a nop if the flag is already false.
> >
> > I am planning to drop "bootloader_enabled_channels" based on your
> > comment in probe() which simplifies the driver.
>=20
> If by saying "drop" you mean that you remove bootloader_enabled_channels =
completely from the driver,
> that is the wrong conclusion.

"bootloader_enabled_channels" is added mainly for avoiding PM unbalance for=
 bind() followed by
Unbind(). By adding devm_clock_enabled() to make clk_get_rate() well-define=
d,
the clock will be always on and there is no need for PM run time calls.

Am I miss anything here??

Cheers,
Biju




