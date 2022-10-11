Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF205FB710
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 17:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiJKP2J (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiJKP1b (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 11:27:31 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2112.outbound.protection.outlook.com [40.107.113.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7D34B0D9;
        Tue, 11 Oct 2022 08:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C868asH0kl9CuDEEWpq7QNx1+oKCx/GuKWLhIMw/Gr2dreTxSEhhJyei4BeekX1pLbRKIuM/e7YsSr0aMOJdXBexB+JpMJBHKZ7AbhJNdZsOgKiKDeZiwoZD4oLR8x75xJEFxhNT64ywOUKhxdYEbC3SiXKWIDhLa0keYu19RnXc3zCF1xy4PitrPIGUT5UFKcsjr/CCUR5xZIIQ+TrTDwlFK89sSt3bMbNyj1N1qVdU3iZ94HGz7Z/ojV+tAnktWJUWW3z/7Ccra+kD/31VuaA8rpZTwG9WH2E00sm6P3kO5v9K4d0M/i5citDK8AQQSypsQfuQ5hLuk0HYomA5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0D7eWo5A6Y3r0HhUQiv2ncBhfiP0SSRbPDxd2vVBDE=;
 b=ny70xxXUIIdFKg8G5Peye7KJBzDEvRxm1T/zspLjtw6cMPaKfqyefkDeQJDaayHePRcRlLHbZMtaGDCCXtKPfrpX1/yPE5ooWvKWDM7nfBQASGZRwwhE3w5tVOSweG7RVRpiLSuFQh52Yu9ttGlm/XOo2KBfDkkf7dzKxCcK1k0Ec2xt549BZMwu0/0eN6HSfR0+TgFU0E6TsgfpGsuyTWycsehqYpFkBaX1r7NTuGk2naES8JD/XjQmAoThMcYcdq7SjumUPFjs70kfgBZNf3oh/O+5970EI/JZQCd8RbxoqJqe+PX0PLLtii38mPr8Z1/yycPuGQm/kDozCgQYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0D7eWo5A6Y3r0HhUQiv2ncBhfiP0SSRbPDxd2vVBDE=;
 b=TQa+NW4iXlZ6+cdJGosWEXYGlwIQHxlFcrTFMAlpNh53EHmNDNy+qhS4edN8Sj0elDJpAZT1FYM4XVaf2+UykX2AZHmLjplKk/sT8LYNA6uD5jhNS4tvPO9khgMAFTZPurRZejeY2PAxJTqVuOCibC47auIQ478LoPgsHMyjdEg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8799.jpnprd01.prod.outlook.com (2603:1096:604:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 14:55:31 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 14:55:30 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Lee Jones <lee@kernel.org>,
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
Subject: RE: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Topic: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Index: AQHY3LfvgCpXQRSGOUCqUs4Dd5zxEq4JRt6AgAAA/2A=
Date:   Tue, 11 Oct 2022 14:55:30 +0000
Message-ID: <OS0PR01MB592232C831CCA84FC302212F86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-2-biju.das.jz@bp.renesas.com>
 <8d6b8f0e-d9d7-0d77-aa99-379de768fd5d@linaro.org>
In-Reply-To: <8d6b8f0e-d9d7-0d77-aa99-379de768fd5d@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8799:EE_
x-ms-office365-filtering-correlation-id: 29fc9943-80ef-4633-c257-08daab98a47a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 602sPYr3+JX2TaEr11dOc7F6xd5eD2oTMeQkNHgePHl9N7kR0UOehnZcyMpcK8GxFPrLEI+X9mFam9uAQUjeL+RjJ55i5nF/1yHdygclG6JaH8jPm/4EkP+KEUY2w9HUp0ph9vSUVUYfSw0YAXriDftv4VzGVcXkqWtxaucTViuTzeviFvJHcryQoJuic64irc78UahDoM34jXfn+R2WK7WA5X9zJY54rmyFlSWKb7BuM/cgVIos1uYo64y2dNZB+MPmlXBaPe5VIunu6SVUggJmgFDN6jr+d9aicPciwpXCI9HoKKgIufiFj345bPVG2hm3QVsiXSpFsNWd4M6uZhC7R/7aM1TjywiyE3sC0qCzn6mWNWimNVVdBduOV8ylQhPq1bP8AEzyJR5cgMWT4Pg+Rw+fiOAkLrHjRhNFw1F/Gc6CjcGfN5ml/JKigzhxKJi+dNECpK88EXcvorMr+LF1tFYHNaA2SFaNIJt2qJDTZ0o5HjNI/UHILBUh1uwNNvawM+mpCgpiOxE7wuplfqfrA1+1N136+qVEjN0hO8DHxAimDkIhOwpIOv/Zbb2zGtXcVW/gZ0fqF9kL9N5PDWbN61v+OBfVLj05lI+lKPXGc7dch8knCo7bcHQpGSIHnWO2/+XEeVyJxqo3N45NdYmvMLaDdKhRvDcjNWULtOROLpdOQ/c1omJLMKqtq+JME+oQTbjxtSaiFs+nh1sxdlNziz9mobjfrduvhuFBw66re7o87Vf4XZE30XbOgfdPZ/smAgSAi9crkNz3QKeIs/syk0zHauo70A1Sybdw7o4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199015)(33656002)(5660300002)(52536014)(8676002)(7416002)(66446008)(4326008)(66946007)(76116006)(86362001)(41300700001)(478600001)(8936002)(6506007)(53546011)(26005)(9686003)(83380400001)(7696005)(122000001)(186003)(38100700002)(66476007)(38070700005)(55016003)(54906003)(316002)(64756008)(71200400001)(66556008)(110136005)(2906002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NgUJCajlPonEhK6D0Fs1p4GUs2lRg9QfO6AyJg2H0Y0c/+gW97g5YALXFv?=
 =?iso-8859-1?Q?9SooltILzkplLW0jUOH3fqEMP16n6y9NVB4oTLiu8W1RsxG16Wysiig7r7?=
 =?iso-8859-1?Q?O0x7nYdKrtyzHu4ye9kij0UjaJS5mKt4wm/hFsVOT/KxEfT6LuLhKte2ST?=
 =?iso-8859-1?Q?ssBHtSOt5mTNuKnCUfVV32SLGZC6xmfFAj/pIkk3ph0XdYpwJqLrb3BCZM?=
 =?iso-8859-1?Q?Z2FOhBNscmjmhEo0SdVSoMMeUgiwHc85cJRmKGzmr+6tBbQwlODr91zhiJ?=
 =?iso-8859-1?Q?+P2DurOnt+IVw/fzmLfdDTb8FYuOQpTRGiNbf83Yxv0MxTAOtCBIdclQ8H?=
 =?iso-8859-1?Q?NGSmcufdzDPkegUAhmPJb4YjMQjKewk/tqYXIzUjQxv9R9Y50rIcnwxXPL?=
 =?iso-8859-1?Q?1tfsT+9fD9GNXHV4rutth/9VnM0Z6QqTdFkn7dY3zfx7oNkx5yFp6eMI0j?=
 =?iso-8859-1?Q?HAb7jRXjCKAlpMqlPC0FIKXR8CIFn8N8iMZmK7omBa9iIATkSQ/uyvb+Kd?=
 =?iso-8859-1?Q?KBIcNwgstkMjT2cX4gqjCzXCHdYFC9h7GvYfHLUjpoyH2d364qWIUGjU+b?=
 =?iso-8859-1?Q?Uw0yRwl2vlbRARwsvPM7MLO3B4wMrjbWK2mG6Gax/CotY9HZYKqrDrxb2N?=
 =?iso-8859-1?Q?QS9RSzga+IMwc8SVTIgx85miREbYw116wFs8GTRdtugV5OAaX5gPh74CpU?=
 =?iso-8859-1?Q?OQDvOpjdXDb5fK/2GMcxPkpA/74JyNtBISuDzuUAJ33NE1vIXzPC+dK/jy?=
 =?iso-8859-1?Q?/cn9+d40ZwsKW9iD2dNYo1CySsGErMMy2Bu6rYeJRWWiOLVeplLTQzp9P8?=
 =?iso-8859-1?Q?IP2mbPUzJtXbNcrliw58x1jcA6cuIgx7m8rcSq3y9F+RIzT1BJFAPzZXdR?=
 =?iso-8859-1?Q?/ViXuQ8ttI//fvNVr1oJvDrFzS8w9MMXFvOZnngFEJwyBtyhPcP+Q2XcaT?=
 =?iso-8859-1?Q?8XUzp3P+5WZQyoMkt2q2fStkdaaCQHi7+xp5MkcnspW/7EjO6TYLNdcdNv?=
 =?iso-8859-1?Q?v0PYDZpwNtpHVxYOCQyQsDMy0L5MV1uS7ftHZCNKqCmNx/jS6aC2ibykA9?=
 =?iso-8859-1?Q?rmMbNv+BGeyoxsJpHqg+ETyc+r7nDXBvJI8WzscKkNeOXpK+97OWd12itn?=
 =?iso-8859-1?Q?8rJzkbLbhWmgVpoEpe0sIO7vCX+KA6vChC/Oy9xYPNfipvRKA3ytmh3FRt?=
 =?iso-8859-1?Q?OSYzlTuOvGbRdapyJ5BBo+3GI8Bi+6cIM8kTAVKYsYAsc1askKjxKZlRSU?=
 =?iso-8859-1?Q?q+wjImoHyBPQIhvF/bBi2pp4pUGD7iWzPxyxij3u5Sp5u62I802+AUMCIm?=
 =?iso-8859-1?Q?ff7+0n8Gm7fugB3/dba2wjlll665c/VXW2zzLuemc7Zk7GkvXcPHt1oMRw?=
 =?iso-8859-1?Q?Bgw5pT1FF2WK8uDhxY9uHSnCVvNzYrNs6gis/3yGxHuMfYVA7HY7YD0wZN?=
 =?iso-8859-1?Q?qs9Pbk6+NPphpcO4pcxnmrkPaMetv5x2sheMcPFE02cuUMOIBsDBCqwB35?=
 =?iso-8859-1?Q?743mzlzjfLzs22CkTpzkK41LmZRMbhjiK/DgTqRjYzDMvyncnQhHTwOtKp?=
 =?iso-8859-1?Q?N/jyAOOF0/DTmymK+/RrVSWLQC75Zn+aTh+4ckrpSJhggCLThZwTpH4WHm?=
 =?iso-8859-1?Q?VjUJDxAdyPWZnpZdjwc3cRaIuNaobo4ZUOokQtI5YkfvIomZMXRJSJGA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fc9943-80ef-4633-c257-08daab98a47a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 14:55:30.8608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lymPTnqPrlRcEeiRNWsMdlHLbLZmD0oiEichMYxXgOWlUdNZuWSCvdxWlLOatt7Z2rXnfkP1xLRiT+SSg35dm2Tuo/Uf4ZPU1j/zOhxGSgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8799
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Krzysztof Kozlowski,

> Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
> bindings
>=20
> On 10/10/2022 10:52, Biju Das wrote:
> > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> > the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
> > channels and one 32-bit timer channel. It supports the following
> > functions
> >  - Counter
> >  - Timer
> >  - PWM
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v3->v4:
> >  * Dropped counter and pwm compatibeles as they don't have any
> resources.
> >  * Made rz-mtu3 as pwm provider.
> >  * Updated the example and description.
> > v2->v3:
> >  * Dropped counter bindings and integrated with mfd as it has only
> one property.
> >  * Removed "#address-cells" and "#size-cells" as it do not have
> children with
> >    unit addresses.
> >  * Removed quotes from counter and pwm.
> >  * Provided full path for pwm bindings.
> >  * Updated the example.
> > v1->v2:
> >  * Modelled counter and pwm as a single device that handles
> >    multiple channels.
> >  * Moved counter and pwm bindings to respective subsystems
> >  * Dropped 'bindings' from MFD binding title.
> >  * Updated the example
> >  * Changed the compatible names.
> > ---
> >  .../bindings/mfd/renesas,rz-mtu3.yaml         | 305
> ++++++++++++++++++
> >  1 file changed, 305 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
>=20
> This should not be in MFD. Just because some device has few features,
> does not mean it should go to MFD... Choose either timer or pwm.

MFD is for multifunction device. This IP supports multiple functions
like timer, pwm, clock source/events. That is the reason I have added=20
here. MFD is core which provides register access for client devices.

For me moving it to pwm or counter is not a big problem.
Why do you think it cannot be MFD?

Cheers,
Biju

>=20
>=20
> >
> > diff --git
> > a/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > new file mode 100644
> > index 000000000000..1b0be9f5cd18
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > @@ -0,0 +1,305 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> > +title: Renesas RZ/G2L Multi-Function Timer Pulse Unit 3 (MTU3a)
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +description: |
> > +  This hardware block pconsisting of eight 16-bit timer channels
> and
> > +one
>=20
> "This hardware block consists of..."

OK, will fix this in next version.

Cheers,
Biju

