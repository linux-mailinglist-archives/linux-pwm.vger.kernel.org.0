Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29467255384
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Aug 2020 06:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgH1EXj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Aug 2020 00:23:39 -0400
Received: from mail-eopbgr1300109.outbound.protection.outlook.com ([40.107.130.109]:23498
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbgH1EXi (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 28 Aug 2020 00:23:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXk1jBcyal0kryuHDU2ELg6OZRWBwepDI6SycnavA6OMvK4du9NXAZzRzEUwR2za/9wSEE2Py1gokqWzZDgQbAZyh0+qai0LxAqnHhzfKegrziot8IP2Jgg4eOoVNAfwufR8Die3Hb8DA47GaWPFLUn3XU5oPQLtSKu7XKu5QjNgB5pE4nvPehy9x0wsly3UMZKN/OlEJQGdZwKcFnIuEYFEa5OKzr7M605yUizjGxufCiWD9a9UDLQDOADEukapZf4ClouXbgBlZN1KA3aHpcokxgC9WGX3Wy9WYfLN8qzn/SRi/gbubnG6yqpNNcQBa7HNkrnOGRlrzm6RTtI3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXuRTUxireoWx5kYnC7gjiklKcOOAY1qps5jYNqO7z8=;
 b=nr1F7+EcztnKvcP2EUdVpwigDf21AD6IxcOmSVLeg7ufzOlqFiFZMEFMyDQVyCjK2OsAqwAJH4kgO6M2zpwGQS5lQCgyI8DY6V45c47kzBgC9NgKC0MpzCh9ABpP9ETXKmyqTg4wFp5a+LOpUvIgOQXb1jJOyk9nShEg8bIzBPUuQBiLzfDs07/sB6jECzIt9xOcZUuyWX8DV68vThE6Ag8uHwDGdd8U+6w4RnsVnkUyhQh0wa9YA4zySpvaPB9YIaLlBItxZ7opRENQ/MR5NiEiCh4I9ZkCjKrs7kIH1O7yNz0Ek1ehy8f6P2OiV2CKFcw1tmNSixAYTWVm0SKjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXuRTUxireoWx5kYnC7gjiklKcOOAY1qps5jYNqO7z8=;
 b=n5tCaxUDwXTzKSSroNXaKV2B1i4Pfzn9Qar21V8nuSuEtUwDwnnQXqUndEEF9VABvXj/+9sDoJKvsw4Mkn5N0EhGubawJX3QGBgM2hqx7g8au1M7LSPwwODhE0N28LxOPzOc+x6VfqXfpeh3h/8L0qP0YvuMXR9jN+vLSZHFLAQ=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB2171.jpnprd01.prod.outlook.com (2603:1096:404:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Fri, 28 Aug
 2020 04:23:31 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3%6]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 04:23:31 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: RE: [PATCH 1/2] dt-bindings: pwm: renesas,pwm-rcar: Add r8a774e1
 support
Thread-Topic: [PATCH 1/2] dt-bindings: pwm: renesas,pwm-rcar: Add r8a774e1
 support
Thread-Index: AQHWeszKwElZ4pDswkCEZ1j6DXZc7qlM8BsQ
Date:   Fri, 28 Aug 2020 04:23:31 +0000
Message-ID: <TY2PR01MB3692C481DF7758471C51873FD8520@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20200825104455.18000-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200825104455.18000-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200825104455.18000-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bp.renesas.com; dkim=none (message not signed)
 header.d=none;bp.renesas.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:b16e:b7b1:d350:3c9a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77a3e04c-f674-4981-3939-08d84b0a1f0b
x-ms-traffictypediagnostic: TY2PR01MB2171:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB21710719DA3384F1BF64F8ADD8520@TY2PR01MB2171.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1s6tnT2iegZX034j0zc89q4PgsqiiKAhrVvBY586F1n7Pix2/u+I/GEaP+R3lQsTeIA5HGpWe7cqxh4cVymmGFU3Qma6uwWu50j4r5EJ9uXcr3xT+dOcmi1+NP9xABGSpzEQ3a3WgO2ZIxIKaGWeVl5t0pzoCD3AaEJ5YeMl474Ms5LPcBKCba0UxO0aVPyMppQ/V3PtwIM6skr/8gREAo6yw/qTpo5uK7furDRn/JR2ianN3jtrfnrk0H7gvUYv4aHjhDZwB6kLaWdps21Ag6785J6VD553sqUbnBlpMJ06RNed5ZBEQeR/QQdxY9wh1aDy6PwZ0aEaiuUSUNkQUNt/jaoqyperqxe7yEf92eab9uZ8P6q5nEXykr9ep9D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(7696005)(55016002)(52536014)(4326008)(186003)(9686003)(86362001)(2906002)(33656002)(71200400001)(64756008)(66556008)(66476007)(66446008)(110136005)(8936002)(76116006)(6506007)(66946007)(478600001)(316002)(5660300002)(8676002)(7416002)(54906003)(142933001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: j76olSofpy7MUFo7xrQaZGtX1PKp1KbBdoKnYlfZ0fZydLBRPzsTd6EF4S00JlGzP9VDeV0K3mWHCBsFWGCdiXJvten4z3U82z4w4M4xpiIeJwrMSUPBejD6fQwKBFxJ1rXPxRD6PkB+PV751WXOufxEPWKxH8vO+clpyRlJpg6sxz/7Njcr0zp148MrBUdUz0V+x/a+k/3LQbyR67WA69AWWsGvYmuz000ayVEBJfMMY4/nKOMCMgQ8CsyRiER2mfB16XhaKZ7e4vkvmP1tIa/ijG7nvJk0Cmu51ddxbKOMp6nymh9p4InP0oJjhasyEYLTwGCT535HAjD6RB+Pf5ibnRo8IzzXaqwijykirB/V5154OZFZa0jEZmtRnUJdtC5oL9DIPNY4xbF8gYx0ngsEq+VGSGIkPhSYHb3wE9Fdvh+2q9GYNjK9CD8IWbzXEaKDAta7teoP/9SO5FIv7pBsLB+gdPuNyZLb4O8tGWlM08cgJNQT2gJ9ui4r21I7sBaHWRKNY2DeKpaEPKq8t4w3haEkpSW8QeZrTaE8j6/DyPkmTvfeBVGfuII82SjlKZ/PlbYjQhlbt+m+UAgybONXNqmtcoUnx9RvkzGixL+1dLnEuHsGY0KO6OJBs9M4d6tYG0lY+l75fPrbcCqxHckZLPvrD7O62s57W2miaagZhCBfdFBdrV8qvPZ/srqCtrtgHXIg+jOwDWaMr/oCFQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a3e04c-f674-4981-3939-08d84b0a1f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 04:23:31.4361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nacFlbikso9qW/XGNaPRpj59WGZzVMTjOcqm2WCqeQ5ey9m+NMo2rFV/3P/RTK9rBjl63C/1Sq4bH727CFw5852ZGXZOripkfUl5vBGswxVp8HXFv12tyscc77qIsqh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2171
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Lad-san,

> From: Lad Prabhakar, Sent: Tuesday, August 25, 2020 7:45 PM
>=20
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>=20
> Document RZ/G2H (R8A774E1) SoC bindings.
>=20
> No driver change is needed due to the fallback compatible value
> "renesas,pwm-rcar".
>=20
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.ren=
esas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
> b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
> index daadde9ff9c4..5407c11e92a4 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
> @@ -20,6 +20,7 @@ properties:
>            - renesas,pwm-r8a774a1  # RZ/G2M
>            - renesas,pwm-r8a774b1  # RZ/G2N
>            - renesas,pwm-r8a774c0  # RZ/G2E
> +          - renesas,pwm-r8a774e1  # RZ/G2H
>            - renesas,pwm-r8a7778   # R-Car M1A
>            - renesas,pwm-r8a7779   # R-Car H1
>            - renesas,pwm-r8a7790   # R-Car H2
> --
> 2.17.1

