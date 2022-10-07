Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4CE5F7815
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Oct 2022 14:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJGMk4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Oct 2022 08:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiJGMkz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Oct 2022 08:40:55 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2120.outbound.protection.outlook.com [40.107.114.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4497C90F8;
        Fri,  7 Oct 2022 05:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deKapQlstKjBZfF0pPhKxdGHI2UL7p4+WaTtUKX2ax1qBoNV8+YBPuQvv3l8TiNldlVS9SBdnKXsj7LcFQhH0GxzrB5xVnqDx+FpXtmS5JPSd0YciHxK9/pOEc6uNKoh29AoAqfMB1Yvw7sg4SxIW7NEaDgWgfIWDtJJ5HWurMz6fgYbP0xsimPeTHRQNx4BVQQAXWdY6jIOnTUqK4EGz3IdZ9bAPfzjUPVEoKnhjvqwL8vAibvt1pgXa/X0t1upLMjTzE/lK6GYMyrZ6TZgr70E1ag13z/RfGNZHMJr6n9PlLEqiwChiyU3lZSm+3nT8dJMjBvraia82UQKWuXU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY7qUvtEmR4l1AiP/mse8gZjDaWRG1O3R0lz9SRtZMM=;
 b=Vz44DlaF5lMFvVeebvv9AMkN0CPBpwFkIdG38DtgUbof77kZVH17q8kesp9ZiH0z2CM0CmXNZtwMcJzFhgtXuc2WLkfpr0+hus8wI5/M5D1926fwYv2qsdgsyizmUT6eeSDARHS8cjnZmmkPxtyr87dZ5h3936VB14JqwPamvvqL0fEX6d4sQxpYOoel/vM48gvzyCX243iupjcyK2K2EHr2P20vQhEvSdiZHK9OR3qDeHbbz25u8GgYyNSBa/z6QY5sOQM5gzBFxeUKAuwidPa0ssf/Rr1QufUHFC/yu40zHAqJuuIVMEndBA70NX92oeI3O09/I3RGZ36Y+rrBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY7qUvtEmR4l1AiP/mse8gZjDaWRG1O3R0lz9SRtZMM=;
 b=bTTvalALwoRKelui5bg7YPcWBvPfZRK6nQwCSzUOUV4ZHrm6qwzbBG7DXb4LkOMmHhEXQgtIIa8DEJnNQbv1I/NrJJruORFzzqlrk+/Hh7Q0zm9pPSFRNK/IGkCZTHxAArr4azndCr+pSckl6zWlc5dnKqoOueALHxaVQZ8DsjM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9738.jpnprd01.prod.outlook.com (2603:1096:604:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 12:40:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 12:40:50 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
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
Thread-Index: AQHY2YuXPmW6g+v5akyG0CoeRXz0kq4Bzk0AgAEPNNA=
Date:   Fri, 7 Oct 2022 12:40:50 +0000
Message-ID: <OS0PR01MB5922F8058FC8FD1E35C17755865F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-2-biju.das.jz@bp.renesas.com>
 <20221006201746.GA93297-robh@kernel.org>
In-Reply-To: <20221006201746.GA93297-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB9738:EE_
x-ms-office365-filtering-correlation-id: 45cbf276-7280-4db3-96a3-08daa8612a6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R2t44xAobZovy5rDMQ+XOnGFjZu3htPidq6sjAgNS/u/lGomQViRLZEej7UVbitScL4kD5OIWwWu40CPUc3naI6LyHBiYGIcJV2G7llrS3pSw065utekI6GNxJYx8NTB30uK8BGKj3MIN740rw8wRn6yleIOdVKnLeqczfJvEkenhfrtwsahZCNcwWzB7DzlTvZUWmjQ4M9uZI0ZuQn3naRW6IAj6D60IOd/OYkt1p+Ee7qZXpUwWhQLvifU34I4XrTcU2qfPmTbecg91IXry7dh546OMjLJX/cFQFc2ktjl6iSPzaWNJxHVKKndiGFvTpt3VSbZzF8j+8GQln15Bj8AMLMQDUhrjzxhxFisaWNVEmm8pnsiU/sgNtU7zUgBaVgPbycitzdw0mvfddwOSgtHVXRgCfkEwD7+XwxyJK0cb/rYx0CeIT8NH1o3tR69w+QKKGZjvx848zKnuoQ+wTP/54IlcQ02VeZd7OgzZQlrR8rzsKJknFcFzFFgDWbEndnQLCHfUqiWFjp+iJH2DAUSkm5ZNnoQQiNBiF8Bs+9KRQpAlnztBREIQHC81DfOMqCHnPbZn4zAjJ8i2fn9CXj/IumDkY/OcvQMDmd7wFH2st8g5jB7eHUI9jHqGHIqVAwkmIxSrp0ZG3jsQa3pmPYrhtuN0KtGne7d0uafYyU+jzBcUDiK5TDfcstxZhwJr/P6zmmNH1ZeqolO9iB5pn5uXwJDWhKBnvJ8r237BM8k6dPvNHH6hLTVlTDj7f1r9zXTIqLQh88iQKl+W42+OOiHaJtfrHuvVyByahGbYT0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(66476007)(8936002)(64756008)(52536014)(41300700001)(66556008)(86362001)(33656002)(83380400001)(38070700005)(122000001)(66446008)(38100700002)(76116006)(2906002)(6506007)(9686003)(7696005)(186003)(71200400001)(54906003)(316002)(5660300002)(4326008)(6916009)(26005)(8676002)(7416002)(66946007)(55016003)(478600001)(30864003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?erwPd2nahIgBt/55b5qaTAVJDSRgtvLB/q2M0/yVyHUrMQhQn0WSqtli1r?=
 =?iso-8859-1?Q?wJIo84F99hZN75qRGG7JDy2ff8oZoqsKIuB8Epb6odlp7d1MLzwbffYB1h?=
 =?iso-8859-1?Q?JFf9bUcyIJ7xWxb70UVP0CF0+JAlsl6E/Ep35ZaHwCqKKo3LMUhejQe+FK?=
 =?iso-8859-1?Q?5RV14BZlMT+iynncNKsau+b9x8S8AWK1uWQZjqGCot9SplqOpQRWh4Wpco?=
 =?iso-8859-1?Q?znB46Xu8NENvmI7iuyJg+mVO+9/OyAv1E3qgRZk5kARlFYp3Kty4ebQVQi?=
 =?iso-8859-1?Q?zeYZfuNt8ypUB9hs6ODZc8alk+wZqOv2bbw1tlMcA2np2p9nrsB/mj9hOk?=
 =?iso-8859-1?Q?+mEyi964yzXPzbOH5pDoDeaQYMmXF1wAKd3Y3xEA8g3eVEfsvz5lG5Mh5R?=
 =?iso-8859-1?Q?zjyL6ttkklUbCKpL7vx3TDtjQwUc6Atq4XvV3H9n3kYXSreD+e1dpAB77d?=
 =?iso-8859-1?Q?B9FPeULGTZU1jFpFoKi4xWzRb6JMHJU2kik/dF3uXRnbBR8C9WbDSZnB9m?=
 =?iso-8859-1?Q?arfaXuKrACEari48AJtQX4+UgHlE7qX+I32KMzgzg4zZzhRpf84jRO17Qs?=
 =?iso-8859-1?Q?1XyidvX0CZZbwz/NNjWJQyWfKLsGREpD2VTqc5dnr6qx0Sfp7LB7f+6JWP?=
 =?iso-8859-1?Q?KNZ6lDulhHIG6EPRYJ4fZA8iqa6iwdaPdvNxJRSa4AktVTXFco3nWyxyKz?=
 =?iso-8859-1?Q?xftvcDnUF4PeUe5MlVaHdmxB7pG37IhVnyjKeQMIkxhOr9X2fTOih7+7sB?=
 =?iso-8859-1?Q?KMWX2rO69KKCnhiiIVRFuMeMuDbpuOoYUo5qpsYm0JsHd5wp16CmFadv8x?=
 =?iso-8859-1?Q?rGxh91YtyY2UBxO6Md5EoqecBGGHUPKH4Iv+8S11XkutOXKWdU8FRFNexx?=
 =?iso-8859-1?Q?5W3lSlGG5kV/2Bt7OUQJh/JdmU8Vjm0ueEVQFOsxTdiIby7xlZ1d5S0FTU?=
 =?iso-8859-1?Q?14TRokZgnwXIafc7TMA0ek4YRTpzKlTXd46mdvBOF9RwP/gQMtozizziqD?=
 =?iso-8859-1?Q?YTSOv5YeZKe3Yd4HN9Zh50LCY9jv++gJfSuzVtQmXRsEEPsydKkn7Jbu3B?=
 =?iso-8859-1?Q?n4BQ5rT1uTzGZVsytbm2jSfYHkJBLp0h4fPt2EB/XbzqgtKCoFZsHWkZoH?=
 =?iso-8859-1?Q?j5nvuSbDaZqmIOAeqZFpRIudtzE6t/5SvWXfqFKjCC3s3oe/9wfn0gFSxj?=
 =?iso-8859-1?Q?xQpSwIpZh2unjTO5glW1fvcqm0UfrVpZnc8b6pylfnyNm0xnRpwQcOwZct?=
 =?iso-8859-1?Q?4Rzzp6ZOfui1ttKiSxFLBlPGpI1/RiOzfWGCjknnChWsXdNOQdBi+RbPKZ?=
 =?iso-8859-1?Q?qq7aTq7qJo55F0wX2OM6eC2K+sfOCpDkahTCArwqWlpudAMkqkJw6Onjgl?=
 =?iso-8859-1?Q?VQfjeyaHTAR9XAYgT4fnveZSpWc74+2DcB1G9qTwYhB2rbabKTwxCsu5ed?=
 =?iso-8859-1?Q?3MjemLAYpYaIiOMPWBYZ1d5c7eb+rcY5W3OUk9W3WzDukkM/aqExfhFn+c?=
 =?iso-8859-1?Q?yFa1ZENegC8OMHq3YCPCDPff/qSJNmDejH/ZsbRgA8w5VGb/6aV1aULfbc?=
 =?iso-8859-1?Q?S++ZT6NpNHbl5gJFO1GZPHk9kDKkYYXDVuLyKiTl81EPuu04uKBx8vLw3m?=
 =?iso-8859-1?Q?eeGe8/uUGZi1fr5Eiq/yzWf4XL3vURKPPK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cbf276-7280-4db3-96a3-08daa8612a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 12:40:50.1500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: be8zB8CO3BX+puWhVi5ZnOt6SBVnfea/VRo3StM38D5GFuEGjfl/XogGET5xB4VL/BhcyLjpj7LLLpYeDsK5hSRVCwx2prJtr9XtTtpjO1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9738
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

Thanks for the feedback.

> Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
> bindings
>=20
> On Thu, Oct 06, 2022 at 02:57:14PM +0100, Biju Das wrote:
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
> >  .../bindings/mfd/renesas,rz-mtu3.yaml         | 304
> ++++++++++++++++++
> >  .../bindings/pwm/renesas,rz-mtu3-pwm.yaml     |  50 +++
> >  2 files changed, 354 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/renesas,rz-mtu3-pwm.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > new file mode 100644
> > index 000000000000..44c952ad8d35
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > @@ -0,0 +1,304 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> > +
> > +title: Renesas RZ/G2L Multi-Function Timer Pulse Unit 3 (MTU3a)
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +description: |
> > +  This hardware block pconsisting of eight 16-bit timer channels
> and
> > +one
> > +  32- bit timer channel. It supports the following specifications:
> > +    - Pulse input/output: 28 lines max.
> > +    - Pulse input 3 lines
> > +    - Count clock 11 clocks for each channel (14 clocks for MTU0,
> 12 clocks
> > +      for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2
> combination
> > +      (when LWA =3D 1))
> > +    - Operating frequency Up to 100 MHz
> > +    - Available operations [MTU0 to MTU4, MTU6, MTU7, and MTU8]
> > +        - Waveform output on compare match
> > +        - Input capture function (noise filter setting available)
> > +        - Counter-clearing operation
> > +        - Simultaneous writing to multiple timer counters (TCNT)
> > +          (excluding MTU8).
> > +        - Simultaneous clearing on compare match or input capture
> > +          (excluding MTU8).
> > +        - Simultaneous input and output to registers in
> synchronization with
> > +          counter operations           (excluding MTU8).
> > +        - Up to 12-phase PWM output in combination with synchronous
> operation
> > +          (excluding MTU8)
> > +    - [MTU0 MTU3, MTU4, MTU6, MTU7, and MTU8]
> > +        - Buffer operation specifiable
> > +    - [MTU1, MTU2]
> > +        - Phase counting mode can be specified independently
> > +        - 32-bit phase counting mode can be specified for
> interlocked operation
> > +          of MTU1 and MTU2 (when TMDR3.LWA =3D 1)
> > +        - Cascade connection operation available
> > +    - [MTU3, MTU4, MTU6, and MTU7]
> > +        - Through interlocked operation of MTU3/4 and MTU6/7, the
> positive and
> > +          negative signals in six phases (12 phases in total) can
> be output in
> > +          complementary PWM and reset-synchronized PWM operation.
> > +        - In complementary PWM mode, values can be transferred from
> buffer
> > +          registers to temporary registers at crests and troughs of
> the timer-
> > +          counter values or when the buffer registers (TGRD
> registers in MTU4
> > +          and MTU7) are written to.
> > +        - Double-buffering selectable in complementary PWM mode.
> > +    - [MTU3 and MTU4]
> > +        - Through interlocking with MTU0, a mode for driving AC
> synchronous
> > +          motors (brushless DC motors) by using complementary PWM
> output and
> > +          reset-synchronized PWM output is settable and allows the
> selection
> > +          of two types of waveform output (chopping or level).
> > +    - [MTU5]
> > +        - Capable of operation as a dead-time compensation counter.
> > +    - [MTU0/MTU5, MTU1, MTU2, and MTU8]
> > +        - 32-bit phase counting mode specifiable by combining MTU1
> and MTU2 and
> > +          through interlocked operation with MTU0/MTU5 and MTU8.
> > +    - Interrupt-skipping function
> > +        - In complementary PWM mode, interrupts on crests and
> troughs of counter
> > +          values and triggers to start conversion by the A/D
> converter can be
> > +          skipped.
> > +    - Interrupt sources: 43 sources.
> > +    - Buffer operation:
> > +        - Automatic transfer of register data (transfer from the
> buffer
> > +          register to the timer register).
> > +    - Trigger generation
> > +        - A/D converter start triggers can be generated
> > +        - A/D converter start request delaying function enables A/D
> converter
> > +          to be started with any desired timing and to be
> synchronized with
> > +          PWM output.
> > +    - Low power consumption function
> > +        - The MTU3a can be placed in the module-stop state.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
> > +          - renesas,r9a07g054-mtu3  # RZ/V2L
> > +      - const: renesas,rz-mtu3
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    items:
> > +      - description: MTU0.TGRA input capture/compare match
> > +      - description: MTU0.TGRB input capture/compare match
> > +      - description: MTU0.TGRC input capture/compare match
> > +      - description: MTU0.TGRD input capture/compare match
> > +      - description: MTU0.TCNT overflow
> > +      - description: MTU0.TGRE compare match
> > +      - description: MTU0.TGRF compare match
> > +      - description: MTU1.TGRA input capture/compare match
> > +      - description: MTU1.TGRB input capture/compare match
> > +      - description: MTU1.TCNT overflow
> > +      - description: MTU1.TCNT underflow
> > +      - description: MTU2.TGRA input capture/compare match
> > +      - description: MTU2.TGRB input capture/compare match
> > +      - description: MTU2.TCNT overflow
> > +      - description: MTU2.TCNT underflow
> > +      - description: MTU3.TGRA input capture/compare match
> > +      - description: MTU3.TGRB input capture/compare match
> > +      - description: MTU3.TGRC input capture/compare match
> > +      - description: MTU3.TGRD input capture/compare match
> > +      - description: MTU3.TCNT overflow
> > +      - description: MTU4.TGRA input capture/compare match
> > +      - description: MTU4.TGRB input capture/compare match
> > +      - description: MTU4.TGRC input capture/compare match
> > +      - description: MTU4.TGRD input capture/compare match
> > +      - description: MTU4.TCNT overflow/underflow
> > +      - description: MTU5.TGRU input capture/compare match
> > +      - description: MTU5.TGRV input capture/compare match
> > +      - description: MTU5.TGRW input capture/compare match
> > +      - description: MTU6.TGRA input capture/compare match
> > +      - description: MTU6.TGRB input capture/compare match
> > +      - description: MTU6.TGRC input capture/compare match
> > +      - description: MTU6.TGRD input capture/compare match
> > +      - description: MTU6.TCNT overflow
> > +      - description: MTU7.TGRA input capture/compare match
> > +      - description: MTU7.TGRB input capture/compare match
> > +      - description: MTU7.TGRC input capture/compare match
> > +      - description: MTU7.TGRD input capture/compare match
> > +      - description: MTU7.TCNT overflow/underflow
> > +      - description: MTU8.TGRA input capture/compare match
> > +      - description: MTU8.TGRB input capture/compare match
> > +      - description: MTU8.TGRC input capture/compare match
> > +      - description: MTU8.TGRD input capture/compare match
> > +      - description: MTU8.TCNT overflow
> > +      - description: MTU8.TCNT underflow
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: tgia0
> > +      - const: tgib0
> > +      - const: tgic0
> > +      - const: tgid0
> > +      - const: tgiv0
> > +      - const: tgie0
> > +      - const: tgif0
> > +      - const: tgia1
> > +      - const: tgib1
> > +      - const: tgiv1
> > +      - const: tgiu1
> > +      - const: tgia2
> > +      - const: tgib2
> > +      - const: tgiv2
> > +      - const: tgiu2
> > +      - const: tgia3
> > +      - const: tgib3
> > +      - const: tgic3
> > +      - const: tgid3
> > +      - const: tgiv3
> > +      - const: tgia4
> > +      - const: tgib4
> > +      - const: tgic4
> > +      - const: tgid4
> > +      - const: tgiv4
> > +      - const: tgiu5
> > +      - const: tgiv5
> > +      - const: tgiw5
> > +      - const: tgia6
> > +      - const: tgib6
> > +      - const: tgic6
> > +      - const: tgid6
> > +      - const: tgiv6
> > +      - const: tgia7
> > +      - const: tgib7
> > +      - const: tgic7
> > +      - const: tgid7
> > +      - const: tgiv7
> > +      - const: tgia8
> > +      - const: tgib8
> > +      - const: tgic8
> > +      - const: tgid8
> > +      - const: tgiv8
> > +      - const: tgiu8
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  counter:
> > +    description:
> > +      There are two phase counting modes. 16-bit phase counting
> mode in which
> > +      MTU1 and MTU2 operate independently, and cascade connection
> 32-bit phase
> > +      counting mode in which MTU1 and MTU2 are cascaded.
> > +
> > +      In phase counting mode, the phase difference between two
> external input
> > +      clocks is detected and the corresponding TCNT is incremented
> or
> > +      decremented.
> > +      The below counters are supported
> > +        count0 - MTU1 16-bit phase counting
> > +        count1 - MTU2 16-bit phase counting
> > +        count2 - MTU1+ MTU2 32-bit phase counting
> > +
> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +        const: renesas,rz-mtu3-counter
> > +
> > +    required:
> > +      - compatible
> > +
> > +    additionalProperties: false
> > +
> > +  pwm:
> > +    $ref: /schemas/pwm/renesas,rz-mtu3-pwm.yaml
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - clocks
> > +  - power-domains
> > +  - resets
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    mtu3: timer@10001200 {
> > +      compatible =3D "renesas,r9a07g044-mtu3", "renesas,rz-mtu3";
> > +      reg =3D <0x10001200 0xb00>;
> > +      interrupts =3D <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 173 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 174 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 175 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 176 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 180 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 181 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 182 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 183 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 184 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 185 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 186 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 190 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 191 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 192 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 198 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 199 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 200 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 201 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 202 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 204 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 206 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 207 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 208 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 211 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
> > +                   <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
> > +      interrupt-names =3D "tgia0", "tgib0", "tgic0", "tgid0",
> "tgiv0", "tgie0",
> > +                        "tgif0",
> > +                        "tgia1", "tgib1", "tgiv1", "tgiu1",
> > +                        "tgia2", "tgib2", "tgiv2", "tgiu2",
> > +                        "tgia3", "tgib3", "tgic3", "tgid3",
> "tgiv3",
> > +                        "tgia4", "tgib4", "tgic4", "tgid4",
> "tgiv4",
> > +                        "tgiu5", "tgiv5", "tgiw5",
> > +                        "tgia6", "tgib6", "tgic6", "tgid6",
> "tgiv6",
> > +                        "tgia7", "tgib7", "tgic7", "tgid7",
> "tgiv7",
> > +                        "tgia8", "tgib8", "tgic8", "tgid8",
> "tgiv8", "tgiu8";
> > +      clocks =3D <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
> > +      power-domains =3D <&cpg>;
> > +      resets =3D <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
> > +
> > +      counter {
> > +        compatible =3D "renesas,rz-mtu3-counter";
>=20
> You don't have any resources for the counter in DT, so you don't even
> need a node here. Just have the parent driver instaniate the counter
> driver.

OK will remove the node and compatible(renesas,rz-mtu3-counter) and will ad=
d=20
support for parent driver Instaniate the counter driver by just using=20
"renesas,rz-mtu3" as it has resources.

>=20
> > +      };
> > +
> > +      pwm {
> > +        compatible =3D "renesas,rz-mtu3-pwm";
> > +        #pwm-cells =3D <2>;
>=20
> Here too, just declaring a PWM provider. Just move this to the parent
> node.

OK, will remove node and compatible. Will add support for parent driver ins=
taniate
the PWM driver and also declaring as a PWM provider.

Cheers,
Biju
