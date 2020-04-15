Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8DB1A97C2
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2020 11:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393813AbgDOJDl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Apr 2020 05:03:41 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19191 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390645AbgDOJDi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Apr 2020 05:03:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e96cdaf0000>; Wed, 15 Apr 2020 02:02:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 02:03:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Apr 2020 02:03:37 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 09:03:37 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 15 Apr 2020 09:03:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE/qpHabCi3MErXPX8SkKPptgLwbfPWuoZ/JrKrF/S4F1k2CNx44RAuuCRL3/Q6z/ObGd4VLdchPevmAddVTD1TgBdg8oFYb+vQElaynPYGbFON9QW5aqyX53LHfBbyY36k+kNjRiFeHwRT/EIR5lYBCbhxwrG6mX6ck4NkHo9STTzmFN1OyzZk/mQZtY/xhEg4v9ixyasFTGC+vq+K8qSXnFZoo2+TYFqBfcgKSFlTOSJpqLYq4K6EZI3GHoimkG8tEm2qoeqS/Gz7S+0n+6qx+rOjDyAWdxfq99NAsqaOFpAzTHS9zEXBRp6E7yy/yHWfU3tKwKuUcNIoCqiDj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ErwnHNyvgGdZI0mgE4I9258OgFHcmKW+uAi3eap2T8=;
 b=jxxT4ngsFJqsGBakR1jHLjjWCBiShoSS6Ox837uKca7wDePyOCb+9SOgAOOqyTzJdp28Q2ngDwCXoV9B3/XI1ThK6Y31and4ZD7ZgMYLvdjLaWUZwUe23l+z3CeWWEhIk5mRaIvQsS+OZSxID5MmbMtpeYUgmy7iZJSMsT+ATTI5BFo08MET6t9AacoU63NixKjRJMDXR+X8V/zFPbZoC/a9lu0TxPwEz3UslWsgvYtZOcJHXaxu/QMnkad84sHm22L2Bk07Gy3wTHZeiYeON9sNpq8F6xB9csc2xKXqie+H5eBBIu4j9OLZv5sV7Pr2+e17kGF8acrkZFynaeyp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3014.namprd12.prod.outlook.com (2603:10b6:a03:d8::11)
 by BYAPR12MB2904.namprd12.prod.outlook.com (2603:10b6:a03:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Wed, 15 Apr
 2020 09:03:35 +0000
Received: from BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::5415:c583:e9b1:c13f]) by BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::5415:c583:e9b1:c13f%6]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 09:03:35 +0000
From:   Sandipan Patra <spatra@nvidia.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <treding@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bibek Basu <bbasu@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM driver
Thread-Topic: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM driver
Thread-Index: AQHWCbRZ2okaHtzUPk25uDpHZH29f6hngLeAgBJsA7A=
Date:   Wed, 15 Apr 2020 09:03:35 +0000
Message-ID: <BYAPR12MB3014C0178A7360662C6FA8B7ADDB0@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1585917303-10573-1-git-send-email-spatra@nvidia.com>
 <20200403151050.nh2mrffkqdqtkozq@pengutronix.de>
In-Reply-To: <20200403151050.nh2mrffkqdqtkozq@pengutronix.de>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=spatra@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-04-15T09:03:31.8430789Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=68557f3d-b094-4c62-9974-170143deacac;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=spatra@nvidia.com; 
x-originating-ip: [124.123.72.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ac335c7-bdd2-4a78-0000-08d7e11be11c
x-ms-traffictypediagnostic: BYAPR12MB2904:|BYAPR12MB2904:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB29043E8A57F7B0AE0E90C70FADDB0@BYAPR12MB2904.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3014.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(9686003)(316002)(66446008)(71200400001)(66556008)(64756008)(86362001)(33656002)(76116006)(4326008)(66476007)(66946007)(83080400001)(6506007)(2906002)(54906003)(55016002)(53546011)(8676002)(81156014)(966005)(7696005)(8936002)(478600001)(26005)(6916009)(66574012)(52536014)(186003)(5660300002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qu3rIgufZb311wowPcnNCpS53hXYfZZR1tOqYgZ89MZDJY3gPvhcRChAdGvOvZdg6DJqQuXrRUobabNjFuTk88iwPkeAU/AqO8+U7HpQ3c4VpIxXMzLTnRizYmPaTtSXyc5BfnvhMDhq+D94ixDcIYE1ckbIKx3azaQsukvjFIoyrlFV2Esu7mQ6XZlj2P7Em+DHWPoRtNIvZcT1OZYaWzpddwJgqcPB9sRH6CNiQwYo5dYdJHPAdSwP3cpSTRi4UksSbEq57B68LX9j5l+0Oq4x+s4wJglqgNDSyQyW4O6JZKEkY4kpRduYXmmC23soxRbPjfPHGP6MdlMMse4vzhP3rmkGD4SbuMWCZ0XHUBtgOl0ZJ4RrooNSSDxoMmAm0a4XVY8d+U2lHdvB5N9ySxq56BD+ZwftLMteQlQQFhdN+9OTvHemKVzvL7jJK7CneH6L1Sly5sp8GQcLRUI5V3CTFRH8F1QC5wYDhNNQT3R5MprPduHiLjgrkeP8iobes6tzqwSM9Zq/RGEtKEM0bQ==
x-ms-exchange-antispam-messagedata: N0njnwOiG+D2z51yLTkseF5bSuEDJFD87O6DNPAH925KFGQSg5OjmWe1Kmd7u8fh7ENuGP+dpwo6rT2b8J77X/TV4x86ylPupY+nAgZ3ArMngpVvKTlU4kCPy3GQZItfZLvErAeFW5uj1tPUcrhZ6g==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac335c7-bdd2-4a78-0000-08d7e11be11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 09:03:35.1750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QwlsH3mawFrWZ0AXKq8o9/FMC36GR9t1h1BJ9XsPAIwF11E1ij3UG3MDBiQN276TgXG/F0PZwYf+YBskWK+rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2904
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586941359; bh=4ErwnHNyvgGdZI0mgE4I9258OgFHcmKW+uAi3eap2T8=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:
         x-ms-exchange-antispam-messagedata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=jwp9CFmPT/K8Wh95O+hgLFvOC7Ixh9GarhCd3LczON1a2LhdoIzAC2VvYkxNsYuWI
         78UvlMzG2uIbGysjKdpzGVECF4cixSHJzp2fGh85Eo1A12pr9/MrFWVyg67VaTFYYc
         fkLomr4nfkWx+LHGUVcjZ8aIxP3fgw/DIhZDCbv4y5JAxgBOARJQewaNkY3xI9f0Oz
         NDwKK+evwCF/wDW523sSnVdXAAvzgsusSVVyIGWewxw8qqteVnd9nbs+xMlOHENvem
         0yQUMtXK201g0jlez/WnQWHTg8cG74i28p3Wc+rgWcZ7Yq1sSClq9aI6YxBU6XKarm
         1Upwa1oerL9vw==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Thank you Uwe for reviewing the changes.
And sorry for the delay in my response.
Please find the responses inline.


Thanks & Regards,
Sandipan

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Friday, April 3, 2020 8:41 PM
> To: Sandipan Patra <spatra@nvidia.com>
> Cc: Thierry Reding <treding@nvidia.com>; robh+dt@kernel.org; Jonathan
> Hunter <jonathanh@nvidia.com>; Bibek Basu <bbasu@nvidia.com>; Laxman
> Dewangan <ldewangan@nvidia.com>; linux-pwm@vger.kernel.org;
> devicetree@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM dr=
iver
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, Apr 03, 2020 at 06:05:03PM +0530, Sandipan Patra wrote:
> > Added support for dynamic clock freq configuration in pwm kernel driver=
.
> > Earlier the pwm driver used to cache boot time clock rate by pwm clock
> > parent during probe. Hence dynamically changing pwm frequency was not
> > possible for all the possible ranges. With this change, dynamic
> > calculation is enabled and it is able to set the requested period from
> > sysfs knob provided the value is supported by clock source.
>=20
> Without having looked closely at the patch (yet), just for my
> understanding: If the PWM is running and the frequency changes, the outpu=
t
> changes, too, right? If so, do we need a notifier that prevents a frequen=
cy
> change when the PWM is running?
Yes, frequency can be changed anytime but by the same process who has=20
acquired the channel. So if a process is already running/using the channel,
same process can only modify the frequency.

>=20
> And slightly orthogonal to this patch: The tegra driver needs some love t=
o make
> it use the atomic callback .apply() instead of
> .config()/.enable()/.disable() and a .get_state() implementation.
Understood to upgrade pwm-tegra driver with using .apply()
I will work on this with a new change request soon.
>=20
> > Changes mainly have 2 parts:
> >   - T186 and later chips [1]
> >   - T210 and prior chips [2]
> >
> > For [1] - Changes implemented to set pwm period dynamically and
> >           also checks added to allow only if requested period(ns) is
> >           below or equals to higher range.
> >
> > For [2] - Only checks if the requested period(ns) is below or equals
> >           to higher range defined by max clock limit. The limitation
> >           in T210 or prior chips are due to the reason of having only
> >           one pwm-controller supporting multiple channels. But later
> >           chips have multiple pwm controller instances each having
> >         single channel support.
> >
> > Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> > ---
> >  drivers/pwm/pwm-tegra.c | 45
> > +++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c index
> > aa12fb3..d3ba33c 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -4,7 +4,7 @@
> >   *
> >   * Tegra pulse-width-modulation controller driver
> >   *
> > - * Copyright (c) 2010, NVIDIA Corporation.
> > + * Copyright (c) 2010-2020, NVIDIA Corporation.
> >   * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer
> <s.hauer@pengutronix.de>
> >   */
> >
> > @@ -83,10 +83,51 @@ static int tegra_pwm_config(struct pwm_chip *chip,
> struct pwm_device *pwm,
> >       val =3D (u32)c << PWM_DUTY_SHIFT;
> >
> >       /*
> > +      * Its okay to ignore the fraction part since we will be trying t=
o set
> > +      * slightly lower value to rate than the actual required rate
>=20
> s/actual/actually/
Noted. I will update in the follow up patch.

>=20
> You round down the rate, that results in rounding up period and duty_cycl=
e,
> right? If so, that's wrong. (Note that if the driver would use the atomic=
 callbacks,
> the just introduced debug checks would tell you this.)
>=20
> > +      */
> > +     rate =3D NSEC_PER_SEC/period_ns;
>=20
> space around / please.
Noted. I will update in the follow up patch.

>=20
> > +
> > +     /*
> > +      *  Period in nano second has to be <=3D highest allowed period
> > +      *  based on the max clock rate of the pwm controller.
> > +      *
> > +      *  higher limit =3D max clock limit >> PWM_DUTY_WIDTH
> > +      */
> > +     if (rate > (pc->soc->max_frequency >> PWM_DUTY_WIDTH))
> > +             return -EINVAL;
>=20
> Related to my question above: What happens if the rate increases after th=
is
> check?
Discussed above with my understanding. Please help me understand if=20
you are referring to any other possibilities that rate can be changed.=20

>=20
> Also the division above is just done to compare the requested period valu=
e with
> the allowed range.
>=20
> Your check is:
>=20
>         NSEC_PER_SEC / period_ns > (max_frequency >> PWM_DUTY_WIDTH)
>=20
> This is equivalent to
>=20
>         period_ns <=3D NSEC_PER_SEC / (max_frequency >> PWM_DUTY_WIDTH)
>=20
> where the right side is constant per PWM type. (Rounding might need
> addressing.)
I will update this calculation in the probe since max_frequency value is
Different for each chip. Also please note that at this point the rate is no=
t
the actual pwm output rate. It's just a reference for what should be the
source clock rate and then requested with clk_set_rate();
Actual rounding is required while setting pwm controller output rate is
done later down in same function.=20

>=20
> > +
> > +     /*
> >        * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
> >        * cycles at the PWM clock rate will take period_ns nanoseconds.
> >        */
> > -     rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
> > +     if (pc->soc->num_channels =3D=3D 1) {
> > +             /*
> > +              * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it ma=
tches
> > +              * with the hieghest applicable rate that the controller
> > + can
>=20
> typo: s/hieghest/highest/
Noted. I will update in the follow up patch.=20

>=20
> > +              * provide. Any further lower value can be derived by set=
ting
> > +              * PFM bits[0:12].
> > +              * Higher mark is taken since BPMP has round-up mechanism
> > +              * implemented.
> > +              */
> > +             rate =3D rate << PWM_DUTY_WIDTH;
> > +
> > +             err =3D clk_set_rate(pc->clk, rate);
> > +             if (err < 0)
> > +                     return -EINVAL;
> > +
> > +             rate =3D clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
> > +     } else {
> > +             /*
> > +              * This is the case for SoCs who support multiple channel=
s:
>=20
> s/who/that/
Noted. I will update in the follow up patch.

>=20
> > +              *
> > +              * clk_set_rate() can not be called again in config becau=
se
> > +              * T210 or any prior chip supports one pwm-controller and
> > +              * multiple channels. Hence in this case cached clock rat=
e
> > +              * will be considered which was stored during probe.
>=20
> I don't understand that. If
The if part is for SoCs which have single channel per pwm instance. i.e. T1=
86,=20
T194 etc. For controllers with single channel, dynamic clock rate configura=
tion
is possible. The other part is for legacy controller which has multiple cha=
nnels
for single pwm instance. The pwm controllers having multiple channels share
the source clock. So it does not allow dynamic clock configuration since it
will affect users on the other channels.

> > +              */
> > +             rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
> > +     }
> >
> >       /* Consider precision in PWM_SCALE_WIDTH rate calculation */
> >       hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
>=20
> I took a deeper look into the driver now. Just to ensure, I understood th=
e PWMs
> behaviour right:
>=20
> There is an ENABLE bit (with obvious semantics), a 13-bit SCALE value and=
 an 8-
> bit DUTY value. There is an internal counter incrementing by one each (SC=
ALE +
> 1) clock cycles and resets at 256. The counter going from 0 to 256 define=
s the
> period length. On counter reset the output gets active and on reaching DU=
TY the
> output gets inactive.
>=20
> So we have:
>=20
>         .period =3D 256 * (SCALE + 1) / clkrate
>         .duty_cycle =3D DUTY * (SCALE + 1) / clkrate
>=20
> Right?
Yes. Right.

>=20
> There are a few things that could be improved in the driver:
>=20
>  - .config() does quite some divisions. This could be reduced which
>    probably even reduces rounding effects.
Explained above and will move the calculation to probe.=20
>=20
>  - When .duty_ns =3D=3D .period the assignment of DUTY overflows.
>    (Can the PWM provide 100% duty cycle at all?)
Yes, PWM controller is capable to provide 100% duty cycle.
Bits 30:16 are dedicated for pulse width out of which only 24:16 (9 bits)
are used. Only 8 bits are usable [23:16] for varying pulse width.
To achieve 100% duty cycle, Bit [24] needs to be programmed of this
register to 1'b1.

>=20
>  - The comment "Since the actual PWM divider is the register's frequency
>    divider field minus 1, we need to decrement to get the correct value
>    to write to the register." seems wrong. If I understand correctly, we
>    need to do s/minus/plus/. If the register holds a 0, the divider
>    isn't -1 for sure?!
Yes, you are right. The comment needs a correction. It will be plus 1=20
instead of minus 1. I will update the comment in the follow up patch.
Otherwise the calculation is correct.
rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
here rate is the divider value to be set.

>=20
> How does the PWM behave when it gets disabled? Does it complete the
> currently running period? Does the output stop at the inactive level, or =
where it
> just happens to be? How does a running PWM behave when the register is
> updated? Does it complete the currently running period?
Yes, it allows to write the bit during any active and inactive time of the
width. Hence the pwm gets disabled as soon as the enable bit is set to 0.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
