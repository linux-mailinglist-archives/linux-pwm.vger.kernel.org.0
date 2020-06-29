Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEC320CB2C
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2020 02:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgF2A33 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 28 Jun 2020 20:29:29 -0400
Received: from mail-vi1eur05on2053.outbound.protection.outlook.com ([40.107.21.53]:64703
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbgF2A32 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 28 Jun 2020 20:29:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzjKM0kqJ6gSObphKK6Rq19m6pnwU42CFkrRR0MNP/CkoMyfmEmi7rUpuiP4NKyHQpoM5+w4gFr5nrcFnnRmZOwfLxzq6oRGSrnCCpyGs/nSdvAAQADQ/e98c9xM08wZ94TUJYWaTcO4Z9v6s+OqZei7rWnmer8tJwlI6rcwmixgFwwc2BhxJjL6QgM4ieigOMOSzqlAUAbE/ksl6wr7LB67bCAM07jA3aSNdQnqZtMxgxbuQQsSLzM9taiPZnm7b5P96Ukay8i/b1jqQ8k97EZdkA2h9hDN9iizAyhic/N+dMHFFBCvALXynvs6kTXmpyPjBlINK7zdx6W4dbX+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN0vR1oSSYIdNgzDbY+8GkQYgBVGYiavz98DhgwaHFA=;
 b=n8i3w/RHkfcLiKG1dJEqZeTQ9G2fK15KG+O9553kuYuQ0shYhn84HWOus2epOa7bEIJzYv6uA6nDo+NP3Oac0fL8DBjzsxnZZMAs9sob7N11f2LJeQd7/U8fHfPCjEbWB3QmeUjQSnbHTRA6dymhx65fpqnis2AUElclAR+/neK6klz2wLOMu6XS1MMMedxhlLF9Lvz89k1OLVo7CkJ497MojwDQqzlEEky4GCSU02DeWr/cbKFeqSEw8oP+FEMzNcr/Oj/Z5GdvypbcO1UCCO7A4/fT7TI7DG0WuAxeN7afKweRGvPDG/6kmzXIhnTu6gl5j87BUCvGrqt2nSQTKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN0vR1oSSYIdNgzDbY+8GkQYgBVGYiavz98DhgwaHFA=;
 b=Jvnqd6NGM/qSRiDypPhhveLg8sk8/kDiRHySu0l+0fs43q5oyq9eRSeIY3xYZ83Biv2dJYEBv29vXZoU5D2N/KS2u7m5u+g1qbybwHGAGYecPaH90ET+CyGf1my817FUeiOlskZhWCK/YmMi2Sc5gTw6RGqAYTnWkSbXH37V7FM=
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11c::13)
 by DB8PR10MB3418.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 00:29:22 +0000
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56]) by DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56%8]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 00:29:21 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Roy Im <roy.im.opensource@diasemi.com>
CC:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v14 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH v14 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWSttjHK/j6/E1ykmZ1XiOSN6cvKjqbZ2AgAB09ICAACxPAIADrkvg
Date:   Mon, 29 Jun 2020 00:29:21 +0000
Message-ID: <DB8PR10MB33566ABB47A00C8A5F281BE1856E0@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1593017969.git.Roy.Im@diasemi.com>
 <8b05f5bd46eac415c628e965f59b2b57aff86bbe.1593017969.git.Roy.Im@diasemi.com>
 <20200626061853.hyb7dwta6ths2qo2@taurus.defre.kleine-koenig.org>
 <DB8PR10MB33563278561DFC2E50420F1C85930@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
 <20200626155604.poqryunm7fyqmgek@pengutronix.de>
In-Reply-To: <20200626155604.poqryunm7fyqmgek@pengutronix.de>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5486bb98-7cd1-49f4-e07a-08d81bc37800
x-ms-traffictypediagnostic: DB8PR10MB3418:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB3418540EC439C1FA55095117A26E0@DB8PR10MB3418.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2DV0RDYfNnclPwGH8aBouSDFVqt3VgkS4kR31qdHI8mGFyOnMu9wfGEv9SNpvjJs/ohg6cFKxfS5Bw0vo598BSTiAHDNOLFpuCvGxlX1nkPr/gWgulOlYlpo7AFT+/ouEDFQeVa/Ns9XU8lUJpw/ygLUDm8ak/CA2otw8u3p3Kvx9bgnG7yjsnXViSqfF/olHo04p0iPYrQAopb1zkVqMT/7o74NOdQYDt6S8rP5RyVxABMCKjjPJzxajXVHXR8DJs7DyCqPpPYdd/ZC6gGFCP3lSxmuo63sBgvI3nayYeZu3T9XlWoZpH6TMtOBkLwbRNV08DcTR5dL73VUuLGpdBTDBBIY0XQ37bS/CzwrewRZnxY3qgVhflS/VaE9Fa0brYZ3WHM6TFaISBmB/LlyFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39850400004)(55016002)(7696005)(33656002)(5660300002)(6506007)(66946007)(76116006)(66556008)(71200400001)(66446008)(64756008)(110136005)(66476007)(53546011)(9686003)(2906002)(86362001)(966005)(186003)(52536014)(8676002)(83380400001)(4326008)(66574015)(54906003)(7416002)(8936002)(26005)(316002)(478600001)(83080400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wDKF4vZHlusa4+6uE5WQWnUDGx/Qo4+c+YtmXsGfjz/Gu0CxDjgmBfqbQrkJmWZ7P27am8VG5If3wgXb+MGmsn9TJuAlYpP+jRjwfp2GdkChbSNtxGNCc0LaG+wDQ53smfzcHWLhp2QFdYqhDagzykpZb3jPp3MfeoBwOrv8BShyfnWa4UwuA9tnQAKKbRotVf+tmBRFpg2o4iT6Mnxv9xWSKGiLXS5eG+3Gqcu4SerwJvtgyls6bkRpv80Kx0zkuF+C6Ricmc4jERqrlIU2MN+Kd3qO1kYv6G7XHp/B3tCWs8P6V3nCf9CFqQPylBsbXIcQUgPXwSU+KTUGNSZyAF7e9/RNEzjMc1SLUbzMY837kI8M7FLsPFyEkNzBvK+3NcTASMZMFuE3xsx9Q0g36kyu9LnCeCM+jBIUH+A5yXhac3I/1jcoMZNHIt5f3H3neudC7gKnEuVCdSOMw5S4lEuhiPrmadpMI5nzBv8oCkg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5486bb98-7cd1-49f4-e07a-08d81bc37800
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 00:29:21.6750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezceQSXo0amf4ZoUeHZ/Y7i6Qlt5rFvPHpI8C0DGp5cPAAMN9Tg8xvnSJsInAMlQaV66w8zYEscj9F66DgJJwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3418
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, June 27, 2020 12:56 AM, Uwe Kleine-K=F6nig wrote:
> On Fri, Jun 26, 2020 at 01:17:29PM +0000, Roy Im wrote:
> > > On Fri, June 26, 2020 3:19 PM, Uwe Kleine-K=F6nig wrote:
> > > Hello,
> > > from the PWM POV I'm happy now. Just a few minor comments that I noti=
ced while checking the PWM details.
> >
> > Many thanks for your comments.
> >
> > >
> > > On Thu, Jun 25, 2020 at 01:59:29AM +0900, Roy Im wrote:
> > > > +		val =3D haptics->ps_seq_id << DA7280_PS_SEQ_ID_SHIFT |
> > > > +			haptics->ps_seq_loop << DA7280_PS_SEQ_LOOP_SHIFT;
> > >
> > > If you write this as:
> > >
> > > 	val =3D FIELD_PREP(DA7280_PS_SEQ_ID_MASK, haptics->ps_seq_id) |
> > > 		FIELD_PREP(DA7280_PS_SEQ_LOOP_MASK, haptics->ps_seq_loop);
> > >
> > > you get some additional checks for free and can drop all defines for =
..._SHIFT .
> >
> > It is not difficult to update that as you advise, but I think having
> > the shift there explicitly makes it more readable, so most of the
> > drivers from my team have the defines(shift) up to now. I guess this
> > is a kind of subjective thing.
> > Do you think it is still necessary? Then I will update as you said.
>=20
> No, from my side it's not a hard requirement (and after all I'm not the o=
ne who will take your commit). I personally like it better
> with FIELD_PREP, but I can still sleep if you don't agree :-)
>=20
> What I don't like about having both ..._SHIFT and ..._MASK is that there =
is some duplication as ..._SHIFT can be calculated
> from ..._MASK:
>=20
> 	#define LALA_SHIFT (ffs(LALA_MASK) - 1)

OK, I got it and I will update.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
