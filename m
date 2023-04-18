Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D394D6E5937
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Apr 2023 08:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDRGQz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Apr 2023 02:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjDRGQx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Apr 2023 02:16:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2113.outbound.protection.outlook.com [40.107.113.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B842B468E;
        Mon, 17 Apr 2023 23:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuxynTFoNnNauIKhNG1oo1nzk+qFD9T6SpO8iPC8rpmN3t6fFpupxc9aoI7ztmfhIlTrt7q8nDLIfz3NI+5W3ir/AHqAn8mujuj0wDBLD4zZtpNsbHh66K+fcc1XPHkZujt/93xatvvpLft1mL5yUNCbjxHaU5wHLTOo6UK5jqHhSY55CmoJ0fdTpDseveMG/TRORghd5Krvwd8UZ00Tzk6hqvqNlRwDfGQ/5Fx3lcBniP0Tg79s3aH+mvz4R+Z0YZQOAnKUIImwrpH6x5iUOdQXRebMi+SHdUG37YLIbhHL1NbHpR7/baJvoLWPx8BHdid1YSAyy52bSmht8gRe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRO0tW3s+c0RH7eC3uKE52jutzB21sSVC122K7IY6kA=;
 b=ND76isul5V8eEK17vUe2dIN4E2Wn8ML/TVJv9DXA6jRQfiuKIr3BL3eN+2bIkCyST5YNzw6YsjTijJOJvS5IGijhcyQtFLRsEBizBSfmbHxHNwtHydXyKGpel1WXU7zZ8WXL1k8vDnHRlvsFJ1W6YuaMEHnamGshw4mHrr2BSEYNJpkinGNRxkPekGv+eGcIhmGBuUHgYAeZSsDwI2Epf4aSlX+rPdSxpWGFLpiRRKy4RzLJEw0O9s+jrPMkzwyBXL/ODe+MHm03Bq2UqcVu0ON1WBTr+4e0CjL/dfeu/uxbas0sDdbY325x0gDCrdQCXycX9WQ83a+vla4PlHqmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRO0tW3s+c0RH7eC3uKE52jutzB21sSVC122K7IY6kA=;
 b=rh9+MeFRh8HGLbV8LgAYJ5uYoT/r0yvTu38hTl9s+qaFQz6sVrR1TdCFs8kzwlWd6Dsvgaxw10o7uN6ccbYGCXCyS7/4ycGE8FnBTVTjNrnlihx9wGFIALOEWDtUzx48x6tEbxOmEuncOadLn2CV6OxESyokC9MosjvD526VO1A=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8746.jpnprd01.prod.outlook.com (2603:1096:604:152::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 06:16:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%5]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 06:16:44 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Lee Jones <lee@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        William Breathitt Gray <william.gray@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZYvkq1tObMCxvvECDvU/oy9wfC68qbjSAgAA3iDCAAHg0AIAEVEYAgADDXQCAAH3A0A==
Date:   Tue, 18 Apr 2023 06:16:44 +0000
Message-ID: <OS0PR01MB592232A17C3B8B8A30DB8187869D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230330111632.169434-1-biju.das.jz@bp.renesas.com>
 <20230330111632.169434-7-biju.das.jz@bp.renesas.com>
 <20230414062641.76no7jz7uluixwdg@pengutronix.de>
 <OS0PR01MB5922824F09E1BC9FB9CECC9586999@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230414165540.bfquriyo6crnxj5q@pengutronix.de>
 <OS0PR01MB592260E8E4F583704C2844B0869C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230417224134.splsu7ipupttuila@pengutronix.de>
In-Reply-To: <20230417224134.splsu7ipupttuila@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8746:EE_
x-ms-office365-filtering-correlation-id: dde6060e-c939-4839-dd56-08db3fd47c04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BHLMea6Hk7MyLZ8WDy4ZCKGbbaQBPYSsODeNWpx1YXvTlrerjjxOPFnksnTqWhvKl16KaDi6H2K8HwOY/vyMfgcefaMxYweoGEeKhdC9et9Wc0t++FHrCqSPYu6mF1oOmZYdsrojvDgWBKL6QHmTtWeb6O23SxbNz6IKSfHamRHx5iVPZKTBuoZ/f8RJKqvk0Yv3Im5TlU9cmvKZv5gEuA6DQvYwJ6BANb9EOttuFyoxiP27S49bUkktFFd2/UjVBBLflfrctnObZPCOXYy6YTvEvpvCVqddVk0LSfZ74JX5nGwMAA9WzVLt1qpvmYFhMlAnqkAcpeqWsUNpp3nFQx//yV5LLufgWbTBtofpG1t/iIzqQabnjO/8lq8+KIuXPTaJPgl9BK9rpCfUXfb8NDObJEix/OT+LjS2MHBXnhcUlyrxJBpLsjdJUKxG7SwH17hgrYyhIVitzqyXjolsWsbSdjdqaeLvCgupHAwUWsggmjtGIl4usNig8P0+CanpD7QAfmUdZWkEub1YVgwvo+J/KWVmXJcM/9ZlfY8bkRXDjSEZOKpYDPt7Kj+k9MD5wItTdOWH8rYLtkfUAkFKMeZCn+Ufw7Gamt+Jb5Hau4K9VqLd+QNmt0gH1a5Es0fh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(52536014)(5660300002)(86362001)(83380400001)(966005)(186003)(9686003)(53546011)(122000001)(26005)(6506007)(38100700002)(8676002)(38070700005)(8936002)(33656002)(478600001)(54906003)(7696005)(71200400001)(316002)(55016003)(76116006)(41300700001)(66446008)(66476007)(66556008)(4326008)(6916009)(64756008)(66946007)(2906002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VpcHy0aCsB4nM9jV5RDkWP3AbVg17mM/vHUgFElT0cjZIFYokmmVjuWfuz?=
 =?iso-8859-1?Q?xHBgg003+dleOI6xtqkJudbBJGFa1reM2F4Iw3Yd0MJ65K5X84Cg3iM1WV?=
 =?iso-8859-1?Q?t1CmGvyZZym86r8rotm6Ls9UQk5/qSXkTYh9frRvrbRs5wELhrhcJgSQiq?=
 =?iso-8859-1?Q?tJVK0aBJFwaRLbvTAlU/4uTGCQWAS2ZOQvqsFt8JiyzST3boCItT2C8lig?=
 =?iso-8859-1?Q?1v3+iZRJfQMOoXLv7NDOFVoV5tmLiqkiUk1gZV1jAwiGvBDwyxV5g1zXRF?=
 =?iso-8859-1?Q?xp8nowyEmdUgjbEX58GuOAnm0zbT0sC/dt6b+BTOvUr9L09QOS5mV2565A?=
 =?iso-8859-1?Q?LrRzNtk56UsntLS3oSkuHxSUMuV2njsz5AVaLG3Sx7CQqiiwsgLa71+vMd?=
 =?iso-8859-1?Q?Ut7AOrzbVGwWOEFqSOoAJA8m8yvN4tlk5y/VB7dVssf+80xfexTkqfBFLy?=
 =?iso-8859-1?Q?RsWYgXghGNwx5eyGioK6zcagucwRIbR/mujlE7bl8dD2GfvBmdy3Xudzqw?=
 =?iso-8859-1?Q?CHuIoG+O31hnQn0/XLKOllqTEXs+BZMi7rMmSRyZ6y/fTQ+xQbBItoA2mk?=
 =?iso-8859-1?Q?NJxujMaSzRmWdAhn8GjuwD8zxr57565WjCVNeXwsCa5PeidWAaNdf+u3n6?=
 =?iso-8859-1?Q?wUiRE6VaJH8Z8Axs9HTS41+ewTOhkL+QL5pW9W2VSXCbmn2l0Ce2OtrsIB?=
 =?iso-8859-1?Q?93OpbztfOHlTOpHHZG2HMxNXZ6LolM6O1M1fWD7gkNO4NI8MiHJdWiI/h1?=
 =?iso-8859-1?Q?6kQevRRedI0Y2FkC50v6rMfZoK6EOubpm2uGKCFBJcaQiMZvr3Gouiv05S?=
 =?iso-8859-1?Q?E1d6cP7JfOackTfJ3QYBd06yvChK2K1GM3BasNfZ9l/WmgJY9shSXHrvX8?=
 =?iso-8859-1?Q?Fo4+prwW7P3CXLRnXhIVpWWyLt168cpuijO6B+KzAbpRNVqNyMx3YKI+l4?=
 =?iso-8859-1?Q?tlZx++ArgxTfIHCU/MFNSP8fUIK+9Ri3gok4rDmIBhIHICrfk48w6Ri7qt?=
 =?iso-8859-1?Q?xhGnVdDGN41RBx52Xa1MIOyn/j1hdknuTuCVhi+iTuIZIM12VvSs9ak3D8?=
 =?iso-8859-1?Q?2+ebUGhw/y6fvtkTv3UK/uzBQk/hakVFXJpkag+JfzcwbKFdgdKrTNvXZ7?=
 =?iso-8859-1?Q?/EzHizJyMgMhRRdQKvrlQdGn9txSSmFksfP0elLO/r4Eh3wuOk4mbhjKTE?=
 =?iso-8859-1?Q?YiDMzvOnQwjvkmdQwqGmkRlFSKCUrP/M+2845bNuEpu6PyDLTqOKZRBA9i?=
 =?iso-8859-1?Q?q0QWp+WLTUGb7tr5OfIb7qWV6RXzNexYfipwHFYI9H8cEVlO93URCmbEXv?=
 =?iso-8859-1?Q?KUCjHjhsJdd0luKnBkHS557Hpd4lqKp4irNu9iD8oWYd0BFTlfA+vIuVo3?=
 =?iso-8859-1?Q?1w+XKTfMCPD18qx+HEfae3zEia2pKaf2oAUtVLTR2uT2uXCtXvsL9qSyuP?=
 =?iso-8859-1?Q?aJJB20Uck3TRLT288Z0fAmuCxnxnfaArYM8CH73UJW17iB8+3Dz3HH1mVv?=
 =?iso-8859-1?Q?UNzqkcw+44z3JFbllfP83keFW8BOHO7uLtb6osbBs+AvuScjBHy4G+Xm8R?=
 =?iso-8859-1?Q?TVHJwsRFFjjtt9gMHTIvQVbWnI3adD5oXiCiDWst+ifqdl85FaYZSNu5+4?=
 =?iso-8859-1?Q?geZGzGscGEhja6Q6ekVpJXWtHO3w1QyoGZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde6060e-c939-4839-dd56-08db3fd47c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 06:16:44.9111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0SJsKJsY8B7glWh9o4q3aX4HYrwe5MafKySpno3Dklra8ckgDvgi7kVqJdgHThMwIHbv98GexgswpI/Leabx/ZtzD7+bt5Ed/9z8X0i+saA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8746
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Monday, April 17, 2023 11:42 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: linux-pwm@vger.kernel.org; Chris Paterson <Chris.Paterson2@renesas.co=
m>;
> Lee Jones <lee@kernel.org>; Geert Uytterhoeven <geert+renesas@glider.be>;
> William Breathitt Gray <william.gray@linaro.org>; Daniel Lezcano
> <daniel.lezcano@linaro.org>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org; Thierry Reding
> <thierry.reding@gmail.com>; kernel@pengutronix.de
> Subject: Re: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> Hello Biju,
>=20
> On Mon, Apr 17, 2023 at 11:06:59AM +0000, Biju Das wrote:
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM
> > > driver
> > >
> > > Hello,
> > >
> > > On Fri, Apr 14, 2023 at 09:53:09AM +0000, Biju Das wrote:
> > > > > On Thu, Mar 30, 2023 at 12:16:32PM +0100, Biju Das wrote:
> > > > > > +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> > > > > > +	if (priv->map->channel =3D=3D pwm->hwpwm) {
> > > > > > +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> > > > > > +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> > > > >
> > > > > If the sibling PWM on the same channel is on, you're overwriting
> > > > > its prescale value here, are you not?
> > > >
> > > > Yes, you are correct. Will cache prescale and add the below code
> > > > in rz_mtu3_pwm_config(). Is it ok?
> > > >
> > > > +        * Prescalar is shared by multiple channels, so prescale ca=
n
> > > > +        * NOT be modified when there are multiple channels in use
> with
> > > > +        * different settings.
> > > > +        */
> > > > +       if (prescale !=3D rz_mtu3_pwm->prescale[ch] && rz_mtu3_pwm-
> > > >user_count[ch] > 1)
> > > > +               return -EBUSY;
> > >
> > > If the other PWM is off, you can (and should) change the prescale val=
ue.
> > > Also if the current prescale value is less than the one you want to
> > > set, you can handle that.
> > >
> >
> > You mean like below??
> >
> > static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > 			      const struct pwm_state *state) {
> > 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > 	struct rz_mtu3_pwm_channel *priv;
> > 	u64 period_cycles;
> > 	u64 duty_cycles;
> > 	u8 prescale;
> > 	u16 pv, dc;
> > 	u8 val;
> > 	u32 ch;
> >
> > 	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> > 	ch =3D priv - rz_mtu3_pwm->channel_data;
> >
> > 	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> > 					NSEC_PER_SEC);
> > 	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm,
> > period_cycles);
> >
> > 	/*
> > 	 * Prescalar is shared by multiple channels, so prescale can
> > 	 * NOT be modified when there are multiple channels in use with
> > 	 * different settings. Modify prescalar if other PWM is off or current
> > 	 * prescale value is less than the one we want to set.
> > 	 */
> > 	if (rz_mtu3_pwm->enable_count[ch] > 1 &&
> > 	    rz_mtu3_pwm->prescale[ch] > prescale)
> > 		return -EBUSY;
> >
> > 	pv =3D rz_mtu3_pwm_calculate_pv_or_dc(period_cycles, prescale);
>=20
> Here it starts to get wrong. If rz_mtu3_pwm->enable_count[ch] > 1 you hav=
e
> to use rz_mtu3_pwm->prescale[ch] instead of prescale.

Thanks for correcting me. Will test with these changes and send v16 for PWM=
 alone
as core driver patch is already in Linux-next[1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?h=3Dnext-20230417&id=3Dbbd4013b44e6c21b997c1fa18ee635a9f3b1c4cc

Cheers,
Biju
