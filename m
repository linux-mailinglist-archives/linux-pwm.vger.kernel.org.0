Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592A15F84CF
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Oct 2022 12:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJHKvt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Oct 2022 06:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJHKvr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Oct 2022 06:51:47 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1197B50F82;
        Sat,  8 Oct 2022 03:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTQmlYv+rClwtjoapEp6CONpzQ0UpRPgwpXJd//F2clD1BWWSyH+7oJWj8YI6sXtcHsWGBS0LhqPCClt+tu7/mocuv+m5vltKCtmmPNoQQhyP0UKdk73tuKvXURZDdWXzi25ds5hQgPzRaekWkCvFgYZRhYws4aZNs3ZLPv7eSCDmwmh/FmzfTe8zRkyIm4ZGRPOIaO0CR2pokekqfm6raByQBdJcOi1hH0W2aPztxDaKOT04XqqyYJ4ewC0NQwipJZ8UeWD37hJMUyoszXUWGrKxt5zyx9bxGg8ZAnQYtdMB3YbE+NFfnfPWx35JMPCTRxCQA1jGdPShBCpFw1R3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muJuLFzsRT49cT7m879gxiqntCKRNOaWUliivI2ZKAg=;
 b=k8lC30lmeUtZSO8KyKnxZlCuzgh7Jmx25SDRLdBWvGIgviUUOYmuJZPnEyZWtHq8x3wkTYy7uuaCwDcTC35mxxYNGZ/Q53BMAas0o/jy/5YfPdmwlfpipPLVD9yoD/Lu2wZ/DFT8MDbTNqtpBjXXenRjdJciZYXm3QbN/UyM03uXWiSNNA5CvkGNJhJrQFeB51nPc5qVHtIikyvIl+Bmmf4Z8THSTB5nnrAqBACufbv31KZzwJ2xDB4tyaY7QPUrXolWBvhB2jGsS0g3micHrQwnHtk+/s3E3IWsIP4BDu+1oN6xmM2Ik7X0huZrPy/HQhKLZZWV6izOpVh3FElulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muJuLFzsRT49cT7m879gxiqntCKRNOaWUliivI2ZKAg=;
 b=GJo1DIQlVCf3WxfpTWm1EMTjEFpDfY4+xuOaMaGXemBEqQ2/naB5ZEbRxDLWprgS8Q+u/RY+PvlUTT8JTvLywBGjvuLlHYNyl2P6u9FWphilauCYLSty7TSc7Ot6Q+ZcGIRJQsrUjo65jgji0jKbuyHlLdMWHW9V3HEpFifxDUQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6094.jpnprd01.prod.outlook.com (2603:1096:400:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 8 Oct
 2022 10:51:42 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 10:51:41 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Topic: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Index: AQHY2YuXPmW6g+v5akyG0CoeRXz0kq4Bzk0AgAEPNNCAAT9J8IAAN7og
Date:   Sat, 8 Oct 2022 10:51:41 +0000
Message-ID: <OS0PR01MB5922CCB6986C6C3A110F3395865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-2-biju.das.jz@bp.renesas.com>
 <20221006201746.GA93297-robh@kernel.org>
 <OS0PR01MB5922F8058FC8FD1E35C17755865F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59221BDEB7E6B39AEFD31C44865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59221BDEB7E6B39AEFD31C44865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6094:EE_
x-ms-office365-filtering-correlation-id: 212d8494-1eea-4357-9850-08daa91b15b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LmsSmSkXzWKhJMg/Um9tFWi1cVRVnnSPJmVQio9xi4alyMhR7aNSmm7ZadTg8BnL1Xgl7thNRRYjAkETcWPrXowPlLqCS8oJylhNf1gy6ybL6NNMqwtybgmJeBslxfz0f4D57Lqk24/JWsmK5R9wTgnVT3J2mgE2LWcxpFFx81Sf/HPyDk5ug4ncPQNvuaNLoDQzs7UMBz4nduF9VNrZGMgPTGaxG1EGzm9XtjM4dm4LWgGoc3aV5MJdpBxAFT0koJ/8iRFUXQD6UT1ERxphP9aag64qdA0FGewia2Axj1VSJYxC6OSQPO3vi6r6A4MhmE+h1bFA9VlhDI30eArdjnnzdln1Czvi1ReihsWKkh+8hyaFrj/23cWbIIt0OTbgSlznb0Hd11mD2azXS9Dh8gnHwwQpXZ4BMXXZCMrwzaObS5YzT38/Fyy0DQusWWswWTbLKK7E1Gfg8MqEd51YPNNThRdj6MTL/45BAqT+ug9dJZbGmsli8oTV7Avcp/dEakFL40KLUVfsWIMcdGRVgiO31Em1KgVE1MyNuI0KrugdtG72/noxphBy3rYm72V72IxrILZ9pTzbmI2eS8gmBjuWoZHlCH+zUH4TG2uEH55lDXowh1n0r7s2sCBnh7bELkqrlaWiKj44OTKYq8k2U2QPvp+CeZlJ5aegNH6sleHaSwA2PxvHmAybgHMvaJvFgIpq6UYCf4LVGrtDcbnx7tHtxjmJDMDs7fsZ8cmYHrwf0VgMHCS6lExG1hOteQytBRHlT4twy9UfZ+GxGge2WkM/JPIEUVe/6ASSRSRoBZMyWaYn9BdfQ1aug2Pm77FTuiF1E9koKImjicgNzofexbOtjQGZhgGVY2IqWxtz22E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(2940100002)(316002)(186003)(83380400001)(26005)(66574015)(38100700002)(66476007)(9686003)(122000001)(30864003)(2906002)(55016003)(7416002)(8936002)(52536014)(5660300002)(41300700001)(53546011)(478600001)(66556008)(71200400001)(966005)(6506007)(7696005)(66946007)(64756008)(66446008)(4326008)(76116006)(110136005)(54906003)(8676002)(38070700005)(33656002)(86362001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i22Z8gfPwqUqnNWnpSvL8tcuz6F/6xXbyuqqClqQ6IFYJ21X+ysBxXchA3?=
 =?iso-8859-1?Q?KiqzYoShi6aBW2Iore8tJlI7lH2PpammVe8CYTxtxVgYGznIeXxfvdY8Qo?=
 =?iso-8859-1?Q?2ulqSsbITz1uFcm/QZAeKugCnLBykE4+NCU9zMEFFf9YjNIQZKnvXVa5Gj?=
 =?iso-8859-1?Q?P/ciyv/pXqIZSuUEgJdACAInNr7cNxla2ioCPZhqXBAhQyErh/xhLkdlj+?=
 =?iso-8859-1?Q?qSutMOU44on12CGSLymRgFS7jb30lloD/ybrOgqi7PvUqamDG5KqYks0ho?=
 =?iso-8859-1?Q?U4VLqQxhcSVbU5T6/PwdAd06LEwkBE41Bo9W5P+pLUNu18ZJjjN/Q/9X2D?=
 =?iso-8859-1?Q?S2WFImEyJWKHCdBNItPkoOARI6Dr4Tc2QxF2BQsLc2FRTFjNejfIGbpHg3?=
 =?iso-8859-1?Q?XCv9rlmiISKKpgshRfXHYmadmvPwVER3GhKYEJpi7x6LyS5QIknnXO1Urb?=
 =?iso-8859-1?Q?6VxnVtukD87BR0MEdK5xvHOT0RhGvE28tDaVAMuUOEee8CoAoD3ykxqtY3?=
 =?iso-8859-1?Q?08OzPOhuHB9C/rIr2yxvFbgpncs2BzG9OgHJVuQgaHsRG5RCDeilaE7QzJ?=
 =?iso-8859-1?Q?VwiVLrxm2aIJWZNlvX+3eTbPsOKY+9Vxt638jReVh8R/Ho/v6cnxlTOOBJ?=
 =?iso-8859-1?Q?R8obtTYciGLggTFlujyZruhV1Q1MPXPY7uHr+bXbkHD5OWmwMd9/xM1TZe?=
 =?iso-8859-1?Q?CLvs7habDBI9mkhgYrjhAFDkRbyJpv7Nc7Fg6ikIvpDjQwvAweQ6o3Vku4?=
 =?iso-8859-1?Q?+LeiX0WdlEeRWpyS9iTg7vbozvdllssmXEtsVP6qGUARxTatxQE348bFqV?=
 =?iso-8859-1?Q?LbXEc6fwPMsQp0G/otPPbfVtofx4K77vUIki3Yd1Kk8wwvp7XpRR48ijz+?=
 =?iso-8859-1?Q?uMilWoIqcov6jOcN70twV9BJc/duKxNNsIt/E1e/eYheF7Ih5a+fyFFIkI?=
 =?iso-8859-1?Q?+pr9qGZev/aHdyPHDR1Fr7tIZQ7pbo5e5IRYGswnygJLdbDYRSOihWxO4l?=
 =?iso-8859-1?Q?b2d8I4+sNRBBJPaHqcWOVXg98RFbqgC+N8MOCiQYXgmjw9apW+Lb8Ua/yq?=
 =?iso-8859-1?Q?5/1/ai8dpUFn/fFX/qf4EkoR16Okk/8rg4MjOXXplqFeHzM+fKMJ6r279z?=
 =?iso-8859-1?Q?jW3NrcT3noDCGKqmCN1MqOEVtvbBMlLnSF8+Xip62qZdSGapyX0YDdmpRU?=
 =?iso-8859-1?Q?Mv1MPQDIvIHgYJ63e61Klsj/39FX0mtQjEOlfE2EJKRiEciKJLHxyI9zNf?=
 =?iso-8859-1?Q?PeN29kdNyV1v4ansGK92Tr5ecQP9B13VE33v0LuuuLDam2yHi+GGsM1Izt?=
 =?iso-8859-1?Q?+uZusm43vUIRl+TVK+84BvBYmIpUMF2GBlGczYXNKCqd0lViGSt2DIRxzr?=
 =?iso-8859-1?Q?DYmWmI40RP9+mMDdBYRWPcfJIB0+HV4Jz8SOvJqL6gcsJ+UZofjlgpoKVD?=
 =?iso-8859-1?Q?9lSxQiENWIw6w/R0hLHiVsUxT8qHDCn38q1jLIcpmsHDzBQrcy8R+4nwHL?=
 =?iso-8859-1?Q?pb4whvY1Aqbf4GRbNo1Ly9TPCe896xDegxLlp2zVEQyumIziTQoXIfbvzC?=
 =?iso-8859-1?Q?k3f2NetZigQxrM8jJGHgnTkC9Vsc2kIHYDUNAB0Q2PmEccxmntGXCiX65a?=
 =?iso-8859-1?Q?/ot7Y6IKRA6adneMJGfCoCDdFlxI9dvMClvtQMO5CtacZwKmLDOp/iGw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212d8494-1eea-4357-9850-08daa91b15b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 10:51:41.8984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3kACb171CiwKLmiDrZzgEz+eIwsMo0I6i1Bs1dIEU2IB+xBT5XJup7JGFTS2d5HZI3tL30g3yiIThTGsj9Tt1SLi74u09qdI6DbMgoXuYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



> -----Original Message-----
> From: Biju Das
> Sent: 08 October 2022 08:43
> To: Rob Herring <robh@kernel.org>; William Breathitt Gray
> <william.gray@linaro.org>; Thierry Reding <thierry.reding@gmail.com>;
> Lee Jones <lee@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Uwe
> Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>;
> devicetree@vger.kernel.org; linux-pwm@vger.kernel.org; Geert
> Uytterhoeven <geert+renesas@glider.be>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> linux-renesas-soc@vger.kernel.org
> Subject: RE: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
> bindings
>=20
> Hi Rob and all,
>=20
> > Subject: RE: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
> > bindings
> >
> > Hi Rob,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L
> MTU3a
> > > bindings
> > >
> > > On Thu, Oct 06, 2022 at 02:57:14PM +0100, Biju Das wrote:
> > > > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded
> > in
> > > > the Renesas RZ/G2L family SoC's. It consists of eight 16-bit
> timer
> > > > channels and one 32-bit timer channel. It supports the following
> > > > functions
> > > >  - Counter
> > > >  - Timer
> > > >  - PWM
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > ---
> > > > v2->v3:
> > > >  * Dropped counter bindings and integrated with mfd as it has
> only
> > > one property.
> > > >  * Removed "#address-cells" and "#size-cells" as it do not have
> > > children with
> > > >    unit addresses.
> > > >  * Removed quotes from counter and pwm.
> > > >  * Provided full path for pwm bindings.
> > > >  * Updated the example.
> > > > v1->v2:
> > > >  * Modelled counter and pwm as a single device that handles
> > > >    multiple channels.
> > > >  * Moved counter and pwm bindings to respective subsystems
> > > >  * Dropped 'bindings' from MFD binding title.
> > > >  * Updated the example
> > > >  * Changed the compatible names.
> > > > ---
> > > >  .../bindings/mfd/renesas,rz-mtu3.yaml         | 304
> > > ++++++++++++++++++
> > > >  .../bindings/pwm/renesas,rz-mtu3-pwm.yaml     |  50 +++
> > > >  2 files changed, 354 insertions(+)  create mode 100644
> > > > Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/pwm/renesas,rz-mtu3-pwm.yaml
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > > b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > > new file mode 100644
> > > > index 000000000000..44c952ad8d35
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > > @@ -0,0 +1,304 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > 1.2
> > > > +---
> > > > +$id:
> > > >
> > > > +
> > > > +title: Renesas RZ/G2L Multi-Function Timer Pulse Unit 3 (MTU3a)
> > > > +
> > > > +maintainers:
> > > > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > > > +
> > > > +description: |
> > > > +  This hardware block pconsisting of eight 16-bit timer
> channels
> > > and
> > > > +one
> > > > +  32- bit timer channel. It supports the following
> > specifications:
> > > > +    - Pulse input/output: 28 lines max.
> > > > +    - Pulse input 3 lines
> > > > +    - Count clock 11 clocks for each channel (14 clocks for
> MTU0,
> > > 12 clocks
> > > > +      for MTU2, and 10 clocks for MTU5, four clocks for MTU1-
> MTU2
> > > combination
> > > > +      (when LWA =3D 1))
> > > > +    - Operating frequency Up to 100 MHz
> > > > +    - Available operations [MTU0 to MTU4, MTU6, MTU7, and MTU8]
> > > > +        - Waveform output on compare match
> > > > +        - Input capture function (noise filter setting
> available)
> > > > +        - Counter-clearing operation
> > > > +        - Simultaneous writing to multiple timer counters
> (TCNT)
> > > > +          (excluding MTU8).
> > > > +        - Simultaneous clearing on compare match or input
> capture
> > > > +          (excluding MTU8).
> > > > +        - Simultaneous input and output to registers in
> > > synchronization with
> > > > +          counter operations           (excluding MTU8).
> > > > +        - Up to 12-phase PWM output in combination with
> > synchronous
> > > operation
> > > > +          (excluding MTU8)
> > > > +    - [MTU0 MTU3, MTU4, MTU6, MTU7, and MTU8]
> > > > +        - Buffer operation specifiable
> > > > +    - [MTU1, MTU2]
> > > > +        - Phase counting mode can be specified independently
> > > > +        - 32-bit phase counting mode can be specified for
> > > interlocked operation
> > > > +          of MTU1 and MTU2 (when TMDR3.LWA =3D 1)
> > > > +        - Cascade connection operation available
> > > > +    - [MTU3, MTU4, MTU6, and MTU7]
> > > > +        - Through interlocked operation of MTU3/4 and MTU6/7,
> the
> > > positive and
> > > > +          negative signals in six phases (12 phases in total)
> can
> > > be output in
> > > > +          complementary PWM and reset-synchronized PWM
> operation.
> > > > +        - In complementary PWM mode, values can be transferred
> > from
> > > buffer
> > > > +          registers to temporary registers at crests and
> troughs
> > of
> > > the timer-
> > > > +          counter values or when the buffer registers (TGRD
> > > registers in MTU4
> > > > +          and MTU7) are written to.
> > > > +        - Double-buffering selectable in complementary PWM
> mode.
> > > > +    - [MTU3 and MTU4]
> > > > +        - Through interlocking with MTU0, a mode for driving AC
> > > synchronous
> > > > +          motors (brushless DC motors) by using complementary
> PWM
> > > output and
> > > > +          reset-synchronized PWM output is settable and allows
> > the
> > > selection
> > > > +          of two types of waveform output (chopping or level).
> > > > +    - [MTU5]
> > > > +        - Capable of operation as a dead-time compensation
> > counter.
> > > > +    - [MTU0/MTU5, MTU1, MTU2, and MTU8]
> > > > +        - 32-bit phase counting mode specifiable by combining
> > MTU1
> > > and MTU2 and
> > > > +          through interlocked operation with MTU0/MTU5 and
> MTU8.
> > > > +    - Interrupt-skipping function
> > > > +        - In complementary PWM mode, interrupts on crests and
> > > troughs of counter
> > > > +          values and triggers to start conversion by the A/D
> > > converter can be
> > > > +          skipped.
> > > > +    - Interrupt sources: 43 sources.
> > > > +    - Buffer operation:
> > > > +        - Automatic transfer of register data (transfer from
> the
> > > buffer
> > > > +          register to the timer register).
> > > > +    - Trigger generation
> > > > +        - A/D converter start triggers can be generated
> > > > +        - A/D converter start request delaying function enables
> > A/D
> > > converter
> > > > +          to be started with any desired timing and to be
> > > synchronized with
> > > > +          PWM output.
> > > > +    - Low power consumption function
> > > > +        - The MTU3a can be placed in the module-stop state.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - enum:
> > > > +          - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
> > > > +          - renesas,r9a07g054-mtu3  # RZ/V2L
> > > > +      - const: renesas,rz-mtu3
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    items:
> > > > +      - description: MTU0.TGRA input capture/compare match
> > > > +      - description: MTU0.TGRB input capture/compare match
> > > > +      - description: MTU0.TGRC input capture/compare match
> > > > +      - description: MTU0.TGRD input capture/compare match
> > > > +      - description: MTU0.TCNT overflow
> > > > +      - description: MTU0.TGRE compare match
> > > > +      - description: MTU0.TGRF compare match
> > > > +      - description: MTU1.TGRA input capture/compare match
> > > > +      - description: MTU1.TGRB input capture/compare match
> > > > +      - description: MTU1.TCNT overflow
> > > > +      - description: MTU1.TCNT underflow
> > > > +      - description: MTU2.TGRA input capture/compare match
> > > > +      - description: MTU2.TGRB input capture/compare match
> > > > +      - description: MTU2.TCNT overflow
> > > > +      - description: MTU2.TCNT underflow
> > > > +      - description: MTU3.TGRA input capture/compare match
> > > > +      - description: MTU3.TGRB input capture/compare match
> > > > +      - description: MTU3.TGRC input capture/compare match
> > > > +      - description: MTU3.TGRD input capture/compare match
> > > > +      - description: MTU3.TCNT overflow
> > > > +      - description: MTU4.TGRA input capture/compare match
> > > > +      - description: MTU4.TGRB input capture/compare match
> > > > +      - description: MTU4.TGRC input capture/compare match
> > > > +      - description: MTU4.TGRD input capture/compare match
> > > > +      - description: MTU4.TCNT overflow/underflow
> > > > +      - description: MTU5.TGRU input capture/compare match
> > > > +      - description: MTU5.TGRV input capture/compare match
> > > > +      - description: MTU5.TGRW input capture/compare match
> > > > +      - description: MTU6.TGRA input capture/compare match
> > > > +      - description: MTU6.TGRB input capture/compare match
> > > > +      - description: MTU6.TGRC input capture/compare match
> > > > +      - description: MTU6.TGRD input capture/compare match
> > > > +      - description: MTU6.TCNT overflow
> > > > +      - description: MTU7.TGRA input capture/compare match
> > > > +      - description: MTU7.TGRB input capture/compare match
> > > > +      - description: MTU7.TGRC input capture/compare match
> > > > +      - description: MTU7.TGRD input capture/compare match
> > > > +      - description: MTU7.TCNT overflow/underflow
> > > > +      - description: MTU8.TGRA input capture/compare match
> > > > +      - description: MTU8.TGRB input capture/compare match
> > > > +      - description: MTU8.TGRC input capture/compare match
> > > > +      - description: MTU8.TGRD input capture/compare match
> > > > +      - description: MTU8.TCNT overflow
> > > > +      - description: MTU8.TCNT underflow
> > > > +
> > > > +  interrupt-names:
> > > > +    items:
> > > > +      - const: tgia0
> > > > +      - const: tgib0
> > > > +      - const: tgic0
> > > > +      - const: tgid0
> > > > +      - const: tgiv0
> > > > +      - const: tgie0
> > > > +      - const: tgif0
> > > > +      - const: tgia1
> > > > +      - const: tgib1
> > > > +      - const: tgiv1
> > > > +      - const: tgiu1
> > > > +      - const: tgia2
> > > > +      - const: tgib2
> > > > +      - const: tgiv2
> > > > +      - const: tgiu2
> > > > +      - const: tgia3
> > > > +      - const: tgib3
> > > > +      - const: tgic3
> > > > +      - const: tgid3
> > > > +      - const: tgiv3
> > > > +      - const: tgia4
> > > > +      - const: tgib4
> > > > +      - const: tgic4
> > > > +      - const: tgid4
> > > > +      - const: tgiv4
> > > > +      - const: tgiu5
> > > > +      - const: tgiv5
> > > > +      - const: tgiw5
> > > > +      - const: tgia6
> > > > +      - const: tgib6
> > > > +      - const: tgic6
> > > > +      - const: tgid6
> > > > +      - const: tgiv6
> > > > +      - const: tgia7
> > > > +      - const: tgib7
> > > > +      - const: tgic7
> > > > +      - const: tgid7
> > > > +      - const: tgiv7
> > > > +      - const: tgia8
> > > > +      - const: tgib8
> > > > +      - const: tgic8
> > > > +      - const: tgid8
> > > > +      - const: tgiv8
> > > > +      - const: tgiu8
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +
> > > > +  power-domains:
> > > > +    maxItems: 1
> > > > +
> > > > +  resets:
> > > > +    maxItems: 1
> > > > +
> > > > +  counter:
> > > > +    description:
> > > > +      There are two phase counting modes. 16-bit phase counting
> > > mode in which
> > > > +      MTU1 and MTU2 operate independently, and cascade
> connection
> > > 32-bit phase
> > > > +      counting mode in which MTU1 and MTU2 are cascaded.
> > > > +
> > > > +      In phase counting mode, the phase difference between two
> > > external input
> > > > +      clocks is detected and the corresponding TCNT is
> > incremented
> > > or
> > > > +      decremented.
> > > > +      The below counters are supported
> > > > +        count0 - MTU1 16-bit phase counting
> > > > +        count1 - MTU2 16-bit phase counting
> > > > +        count2 - MTU1+ MTU2 32-bit phase counting
> > > > +
> > > > +    type: object
> > > > +
> > > > +    properties:
> > > > +      compatible:
> > > > +        const: renesas,rz-mtu3-counter
> > > > +
> > > > +    required:
> > > > +      - compatible
> > > > +
> > > > +    additionalProperties: false
> > > > +
> > > > +  pwm:
> > > > +    $ref: /schemas/pwm/renesas,rz-mtu3-pwm.yaml
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - interrupts
> > > > +  - interrupt-names
> > > > +  - clocks
> > > > +  - power-domains
> > > > +  - resets
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > +
> > > > +    mtu3: timer@10001200 {
> > > > +      compatible =3D "renesas,r9a07g044-mtu3", "renesas,rz-mtu3";
> > > > +      reg =3D <0x10001200 0xb00>;
> > > > +      interrupts =3D <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 173 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 174 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 175 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 176 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 180 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 181 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 182 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 183 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 185 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 186 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 190 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 191 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 192 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 198 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 200 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 201 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 202 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 204 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 206 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 207 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 211 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
> > > > +                   <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
> > > > +      interrupt-names =3D "tgia0", "tgib0", "tgic0", "tgid0",
> > > "tgiv0", "tgie0",
> > > > +                        "tgif0",
> > > > +                        "tgia1", "tgib1", "tgiv1", "tgiu1",
> > > > +                        "tgia2", "tgib2", "tgiv2", "tgiu2",
> > > > +                        "tgia3", "tgib3", "tgic3", "tgid3",
> > > "tgiv3",
> > > > +                        "tgia4", "tgib4", "tgic4", "tgid4",
> > > "tgiv4",
> > > > +                        "tgiu5", "tgiv5", "tgiw5",
> > > > +                        "tgia6", "tgib6", "tgic6", "tgid6",
> > > "tgiv6",
> > > > +                        "tgia7", "tgib7", "tgic7", "tgid7",
> > > "tgiv7",
> > > > +                        "tgia8", "tgib8", "tgic8", "tgid8",
> > > "tgiv8", "tgiu8";
> > > > +      clocks =3D <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
> > > > +      power-domains =3D <&cpg>;
> > > > +      resets =3D <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
> > > > +
> > > > +      counter {
> > > > +        compatible =3D "renesas,rz-mtu3-counter";
> > >
> > > You don't have any resources for the counter in DT, so you don't
> > even
> > > need a node here. Just have the parent driver instaniate the
> counter
> > > driver.
> >
>=20
> If I remove "renesas,rz-mtu3-counter" and "renesas,rz-mtu3-pwm" then
> instantiating the counter and pwm driver from parent driver by
> directly calling probe function is giving cyclic dependency error[1].
>=20
> So looks like either we need to use compatible "renesas,rz-mtu3-
> counter" and "renesas,rz-mtu3-pwm" if these functionalities to be in
> respective subsystem tree
>=20
> or
>=20
> squash counter and pwm functionalities to MFD subsystem.
>=20
> Please share your views on this. Is there any better way to handle
> this?
>=20
> [1]
> depmod: ../tools/depmod.c:1792: depmod_report_cycles_from_root:
> Assertion `is < stack_size' failed.
> depmod: ERROR: Cycle detected: rz_mtu3 -> rz_mtu3_cnt -> rz_mtu3
> depmod: ERROR: Cycle detected: rz_mtu3 -> rz_mtu3_pwm -> rz_mtu3
> depmod: ERROR: Found 3 modules in dependency cycles!
> make: *** [Makefile:1781: modules_install] Error 1


Just to add the below drivers have compatibles that does not have any resou=
rces. Am I missing anything here?

[1] https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree/b=
indings/mfd/google,cros-ec.yaml#L209
[2] https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree/b=
indings/mfd/st,stm32-timers.yaml#L105
[3] https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree/b=
indings/mfd/st,stm32-lptimer.yaml#L71

Cheers,
Biju
