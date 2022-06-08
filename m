Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4582254387E
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jun 2022 18:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbiFHQLs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jun 2022 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244978AbiFHQLs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jun 2022 12:11:48 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C445B27CF9;
        Wed,  8 Jun 2022 09:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ/7DsvIxWIootAaKaAwW5qmtSgSoaMCmEdeGGsezaZdk03fJ3aoI+OMLnznPG+wAl/vED39UPlTNuuienphewQlH66P/oYon7YL+4bNxsPMjZ8oGUSlGl8Nyb9bvyNo/0rb8v6zIYN9OjDeDWbg6aSyE7/X+BD1U/mFiDcILO9c3YjFooOw95gSors+iK/G5z9h+JXEwFleHR+wMpWqMM5k82rZIRtL5qw5u+nUbZOAM2ePD7w4+buUO92Exuvxb0ZbwT0INpVwr4lwaqdJvi2C6oF9lHoP4+td5tdvQGUfFyHHb3ejHDZCPC3C+h7oVeBLqRbu5khjBhPq0+DGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjEIIOZ/iRUov1ICrbBnuyS9PdOIBtruLuHWo0O1YvM=;
 b=it1IlY4tq0NF6vYSyPQUtJ7blkVNglcFc1+3v9ckL+gs3N9VaAauHDyAoySYqhiYPomp7PuyZyhYcRXappEv4WoXSvFfjZ/Ifu08VyUjYfR1ybxipvW+hDyKVU4K3KzHU1VNeyetgH0DJJ6l9ww7m2cmf6ZRnH0K/XkFMFWP4pJUSl4NyCHQqFuHqGkcBa3PbI/JWHuVWc2CYJOCKsqtMAjiFnbCVIk20TKuI9UfKIsnH7M6wW1jLWULP7Vx6gg09ZDDhpxEPAUXgavsIHoz/jbivjgPpRz+0PbchrbprotTHN6/O+0jYFem5+VGn5u4HfOJkJNKbr2mzuQdgPTLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjEIIOZ/iRUov1ICrbBnuyS9PdOIBtruLuHWo0O1YvM=;
 b=dbRzXNtATwQ905FlL5pf7gJ2PT25A8WmYfZCt3SyEwm/2zpCEKiXNFTLNc97KVxZn+azDQ/+5KNBKSb7Nfa77kW2+ahK2pjpGGRN9gmVDvTsHwC6Fur/n9JYRtfBbdD2iOyBV90imgfKKSMcwaxJ1KpHEC0OICRLwa93c+JMYOY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB2197.jpnprd01.prod.outlook.com (2603:1096:603:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.16; Wed, 8 Jun
 2022 16:11:43 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5332.011; Wed, 8 Jun 2022
 16:11:43 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: RE: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
Thread-Topic: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG binding
Thread-Index: AQHYZIA3TRVrx9T/skGzEuiCwjtE0q0jmkqAgACR+bCAANHPAIAAA1bggAD1JACAAADlIIAAtu4AgB8tLqA=
Date:   Wed, 8 Jun 2022 16:11:43 +0000
Message-ID: <OS0PR01MB59221B3310BADB5D458A194586A49@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
 <20220510151112.16249-2-biju.das.jz@bp.renesas.com>
 <20220517210407.GA1635524-robh@kernel.org>
 <OS0PR01MB5922FC66FD4EF05F31B17D3386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220518181730.GH3302100-robh@kernel.org>
 <OS0PR01MB5922BC7AAC6154DEF7B98F0386D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWPy4HmPrfnL8kZmFBBcHY-EoNm7Z6CoJyudhKornTS=g@mail.gmail.com>
 <OS0PR01MB5922D0FFFA82AC5428F8C8D886D09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220519200446.GB2071376-robh@kernel.org>
In-Reply-To: <20220519200446.GB2071376-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceaf7abf-8d7c-4f42-8454-08da49699452
x-ms-traffictypediagnostic: OSBPR01MB2197:EE_
x-microsoft-antispam-prvs: <OSBPR01MB2197F8FFC8A8DC3A1FF9A89786A49@OSBPR01MB2197.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ron6WBYb+EJw80Ji3rSg6xTWDmlU4eO9rn0UQB02jgpmBW4IAL+LfYoAHPcAA25IiAZj4gWrNlNjhtD7arzr+jVsnvZn0LLX8/DIZh74oZH1UBJZk0apx1L/TrYWg2Bc28Pna0TwM+Hjd3M3CHFhNObsa2eI0EcsT2UBICFhZL+hY1EJMA6X6RgmiHPl5pWprbSi+51I4rv/BI/DlDvCclFJks5Mo2Ldg8A6OxRn98RL9CGHJyb5SfC+QPjXAgcqK8OHaLok90DbV7AuVLr9GuS6VctAX2XzpykSBXIs7K16VEARn0DhZgIpHdBJDqpVgMjI1tIv6eaetgEh3j61dRMy6MOqgELkft70S84/0hN3DCBBNpidlOSI8PsNNIUqo3eS6bqpu9x+EDi6ayfFkNSojzPKbQ8NX/EPVv6ziFtxCcRxXMrFGXmu2xotCYppavuyBKS82O2IFOnDlV4fa4oNsJx3HKW9AetvA8eKhjhzLRaaDo+FBAH2ePLtKvTQivsxsSdCvQmfW9V3J6P82s3MZ0kHNKfIix4oKgaPBglKy3IygmXxJcQDQnhzxYkbiSJMD8Q24aQv+XYlNYCwRxwdLV4mR6RgXBH7VXTUEqVFXi5c1GCVK9bF0l6rAacZLyfqaGS3uz/nT7b/LNw0tR6vplIbc3xy6h11gN7wSwStiVPTjXnS+IZIQzeBFnP6ZCwvh/hw2OurySAE9iZSSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(66946007)(66446008)(8676002)(64756008)(52536014)(66556008)(7416002)(54906003)(86362001)(5660300002)(6916009)(508600001)(53546011)(6506007)(71200400001)(7696005)(66476007)(26005)(9686003)(76116006)(4326008)(122000001)(316002)(186003)(33656002)(2906002)(8936002)(83380400001)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ghSE/mJYtSQsX2YPioMcmsP7ES8XpVlFzjEbC/6iSaXXC4VOr9iE08slYr?=
 =?iso-8859-1?Q?ssSk7ejL26xyl4v0wGmysT6V9D+sdoPT2I4LcYwIAqTzkzU3uPilf5IyqL?=
 =?iso-8859-1?Q?vOaIIMCYNelrgm3uqAHo8M1MWBojszMxwMCS2uhD/s5YDM1IPyJL7FrlXB?=
 =?iso-8859-1?Q?YmiwHgcH0aRL8MfwhFNycNZ2T8T1cRi7/cZQ8sBe1ozQ5G3w+nuhX5ScZK?=
 =?iso-8859-1?Q?SIfCH6FJ/ZfVqxHD1gbwkuBuPNzIBHMExV7lFF+BYc+KjXYw3NXdXv53MT?=
 =?iso-8859-1?Q?7yt79jzs6jRS5RkOrpLYEeRCks4Jj2bSbrW3Wrrff5mVpnCzvRuBPYotWt?=
 =?iso-8859-1?Q?l2X1mV0yqV64ab5R8cMvE9m+NqJ7rr1oPBB1wjULiuKoT7TPtyvtERsWjX?=
 =?iso-8859-1?Q?Pl+0p7qii1wf/NhVI7YdNaTTkrkS+/3xGjjJx++J+AUQ5miHOufWVLNKAY?=
 =?iso-8859-1?Q?o+TnQFV6AxrdEe6BJLK335DZFLgUxP/PlNfXb3ZuXdFvbfW1AqtujC7jW/?=
 =?iso-8859-1?Q?hBdM4dGdnZW90uTyLo4dKxBpx7qAfqQ5GyMqGs2q7Ju23jLXEJKvBH4K9R?=
 =?iso-8859-1?Q?JkOa/UCjv4sGJCbEZ4x6q0B2c8in7colM4MiQkogmGwldvAdGUiz7PCaX4?=
 =?iso-8859-1?Q?6B6hX5toBQ1SlEoNnxHDgzcgUzrCSat+KRped9yrc0No+Ft6iWprfKyQOR?=
 =?iso-8859-1?Q?hOJBDYea1jiuv1UxNGvQftn75k7zKeLbS8nIc6Iu8awgLHIkphhWVl5vum?=
 =?iso-8859-1?Q?aFQhlpuF2dwGI61xkmd9T1iOAOAEfbnnD/a0y/uCvW3k9BrRacgu8ICcKo?=
 =?iso-8859-1?Q?8m8P+FFypCllNHN9UtaIPZgsYbqXPRIEHYaFwHukD9Wdwcl68UEjIaJDO/?=
 =?iso-8859-1?Q?1Ou82rQmMB0Dx6zSFQW4R0dcVtpw/S0i0m/FY5m2AEVlunWMvGWlzVjS83?=
 =?iso-8859-1?Q?UpNORR61/gJgsq9pdVUN0Fczh/aD4C3W7SzZT00OJg67Vwc88CiArcMHTK?=
 =?iso-8859-1?Q?ltwSFcNHABWXIe08HjH6aCzXU+oo9JdLHvlOps7LMFiTMXAjtFCaErPBTx?=
 =?iso-8859-1?Q?OlCDI8wabFMf829SsUnGK2qGn3PUOaigZyUV20ebtuWw/KRa0PRO7PNoF4?=
 =?iso-8859-1?Q?4XTQM9MVcNrlo5jqo9L7PUMRjNO8JY/RqcGd8scJj+QyYu54gRVZnfjSnT?=
 =?iso-8859-1?Q?0XO1QlDqfRnlzH4YqYbYRwK3Ic1P8u6z/zR5060ixbYoJNPUO0i/TWge0L?=
 =?iso-8859-1?Q?VsXADWNLWBgfn+vbV8yur3JjWDjI/lLImonMoG9LvAnJig4oF2geWr9v/Y?=
 =?iso-8859-1?Q?P0qm9S+JBLmABBfPWd5YmQLZqh2FTYrxxM6j9X7SY6pHaGDKhJMRdQXnR+?=
 =?iso-8859-1?Q?K03kDU0wFTrlU6p3TVeV5jC0ZgpLUVL5DOh1clg+5DgHuiiTgBWxdUNRvD?=
 =?iso-8859-1?Q?2f9z/TJWwFWwzbLaVpMExUv/l97LAnG6Lhuq356b1wc7ogZb6MkCkZwS+/?=
 =?iso-8859-1?Q?KRYgMA/kha4SboBTWj+OgI4G0XcKnbCqCcMlNCt06tqLKafVGfZgsUplA+?=
 =?iso-8859-1?Q?ccyGLjsTrYQjHZX07WQ180KMN4hE9LzLj95Nl8ayQPexxQFH1vr+mbYXoh?=
 =?iso-8859-1?Q?gKK7qgipH+Z5djcZEZMOPCCbIhpHO29RYsmXo3pGisxs1Q691JU40CbQCK?=
 =?iso-8859-1?Q?OioGiRglTVdmV/07OQyBNEzltNdYkD9vkSGJUnfTF+L8l/9cFkIUdPUwzV?=
 =?iso-8859-1?Q?uw0JhkMXf13r5yF0P6x3ZZQugtA/6h2Eg4NYH55ZIkGrVGNTMPoISBncla?=
 =?iso-8859-1?Q?48UWUK8Q40IOVRcbYOgr6xBcNP8NUOE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaf7abf-8d7c-4f42-8454-08da49699452
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 16:11:43.4551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PMVZh4mNggjkQVSz3RzBK3GOOz3duq+Z8p1/PUJWR7AZXqubVVM1ckkkF+6EeVz3TTJPNoT/n8f49YMG+O4Id46nDqjCo6Jc3u1i/UgmZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2197
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

Thanks for the feedback.

> Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG
> binding
>=20
> On Thu, May 19, 2022 at 09:30:19AM +0000, Biju Das wrote:
> > Hi Geert,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L POEG
> > > binding
> > >
> > > Hi Biju,
> > >
> > > On Wed, May 18, 2022 at 8:34 PM Biju Das
> > > <biju.das.jz@bp.renesas.com>
> > > wrote:
> > > > > Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L
> > > > > POEG binding On Wed, May 18, 2022 at 05:58:00AM +0000, Biju Das
> wrote:
> > > > > > > Subject: Re: [RFC 1/8] dt-bindings: soc: renesas: Add RZ/G2L
> > > > > > > POEG binding
> > > > > > >
> > > > > > > On Tue, May 10, 2022 at 04:11:05PM +0100, Biju Das wrote:
> > > > > > > > Add device tree bindings for the RZ/G2L Port Output Enable
> > > > > > > > for GPT
> > > > > > > (POEG).
> > > > > > > >
> > > > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > > > > > > +examples:
> > > > > > > > +  - |
> > > > > > > > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > > > > > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > > > > +
> > > > > > > > +    poeggd: poeg@10049400 {
> > > > > > > > +        compatible =3D "renesas,r9a07g044-poeg",
> > > > > > > > + "renesas,rzg2l-
> > > poeg";
> > > > > > > > +        reg =3D <0x10049400 0x4>;
> > > > > > >
> > > > > > > This looks like it is part of some larger block?
> > > > > >
> > > > > > There are 2 IP blocks GPT(PWM) and POEG with its own resources
> > > > > > like (register map, clk, reset and interrupts)
> > > > > >
> > > > > > Larger block is GPT, which has lot of functionalities. The
> > > > > > output from GPT block can be disabled by this IP either by
> > > > > > external trigger, request from GPT(Deadtime error, both output
> > > > > > low/high) or explicit software control). This IP has only a
> single register.
> > > > > > Currently I am not
> > > > > sure which framework to be used for this IP?? Or should it be
> > > > > merged with
> > >
> > > Yeah, POEG is a weird beast.
> > > Some of it fits under pin control, but not all of it.
> > > From a quick glance, most of its configuration is intended to be
> > > static, i.e. could be done from DT, like pin control?
> > > I have no idea how to use the POEG interrupts, though.
> >
> > If there is a GPT request(Dead time error or Both output low/high
> > condition) output is disabled automatically and we get an Interrupt.
> > May be to clear it , we need to implement interrupt. Otherwise output
> will be always disabled, even if the outputs are out of phase after the
> fault condition.
> >
> > I have done a quick test with interrupts previously for output disable
> using GPT request:-
> > 	Use both A and B in phase, output is disabled automatically and
> you get an interrupt in POEG block.
> >       If you inverse B, it is out of phase and fault condition is no
> more, but still output is disabled.
> >       In this condition, If we want to enable outputs, we need to
> clear interrupt status bits.
> >
> > >
> > > > > larger block GPT by combining the resources?
> > > > >
> > > > > Usually, IP blocks would have some minimum address alignment
> > > > > (typ 4K or 64K to be page aligned), but if there's no other IP
> > > > > in this address range as-is is fine. The question is what's
> > > > > before or after
> > > the above address?
> > > >
> > > > As per the HW manual, before GPT IP block and after POE3
> > > > block(Port
> > > Output Enable 3 (POE3) for MTU).
> > > >
> > > > Before
> > > > H'0_1004_8000 H'0_1004_87FF 2 Kbytes GPT
> > > >
> > > > After
> > > > H'0_1004_9800 H'0_1004_9BFF 1 Kbyte POE3
> > > >
> > > > Please find the address map for the IP blocks near to it.
> > > >
> > > > H'0_1004_A000 H'0_1004_A3FF 1 Kbyte SSIF ch1
> > > > H'0_1004_9C00 H'0_1004_9FFF 1 Kbyte SSIF ch0
> > > > H'0_1004_9800 H'0_1004_9BFF 1 Kbyte POE3
> > > > H'0_1004_9400 H'0_1004_97FF 1 Kbyte POEGD
> > > > H'0_1004_9000 H'0_1004_93FF 1 Kbyte POEGC
> > > > H'0_1004_8C00 H'0_1004_8FFF 1 Kbyte POEGB
> > > > H'0_1004_8800 H'0_1004_8BFF 1 Kbyte POEGA
> > > > H'0_1004_8000 H'0_1004_87FF 2 Kbytes GPT
> > >
> > > This is actually 8 x 256 bytes, for 8 GPT instances.
> >
> > Yes correct.
> >
> > >
> > > > H'0_1004_7000 H'0_1004_7FFF 4 Kbytes SRC (Reg)
> > > > H'0_1004_0000 H'0_1004_6FFF 28 Kbytes SRC (Memory)
> > >
> > > So you can combine GPT and POEG[A-D] into a single block.
> > > However, doing so will make life harder when reusing the driver on
> > > an SoC with a different layout, or a different number of POEG blocks
> > > and GPT channels.
> >
> > I agree. Modelling as a different driver gives lots of flexibility.
>=20
> The question is different h/w blocks or 1, not driver(s). It's
> convenient when the answer is the same (i.e. h/w node:driver is 1:1),
> but h/w is sometimes messy.
>=20
> In any case, that looks like different blocks to me.

OK, As Geert suggested will model this block as pinctrl.

Cheers,
Biju
