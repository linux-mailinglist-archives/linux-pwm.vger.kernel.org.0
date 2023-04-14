Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C826E1FE4
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 11:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjDNJxU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjDNJxS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 05:53:18 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2113.outbound.protection.outlook.com [40.107.114.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0C13C33;
        Fri, 14 Apr 2023 02:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHj8MA1Fk5TsHAiqTFM75Vx1brKnnaR/qOhGQHPRZ9TYg7JRAIQISK7PbZ9JdyPj6/OkImR1HcGv/Wht91h0CJgr8T1h/evOr29boLNfaZ7+/i6jv+RpgJ5hp1P04RGbG52ddG7NmbtgUB9Bgim43PYj5zdFhHX/ud0hTocHPH5d6lHqlEKJ5CGHTXn/vdm6WZbhKFqXopIHoTLlE4GNto4xCNUnLMHDE+aSF1uSYqt0akQwD2fy2BsObl14cLAu9lJbLDgGAuCZCHwofyjm+Ka9jSbWUoqpfUb4TMuJrpoyiowzcyXgaIM+ZJCGvsWpnASMNm1CJWSv8Oza/Q1Zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APzdFI9ukIYE3zi58rj1eRMxd+hk+uNx7dElV58iAlM=;
 b=JOjO0Ynplub2NoF5HGVHI7NrAhgu1PA3u2jsxlb8Dl9lYPZizsmYj//dn+ESDp7N3sag7sXsFMqxRANrun/5saubMVv7Ozes9TqOhkKDLTDYXpt3LA/UUbshTRL0G1Bd5WF2ArFVqrtYLFws2IrhViv1eIi3J/qdWlj2oJCJySIPe8InEkNTORqo8BZd6qh6eUD8NqmmZLrVEIsFX/WAjLGj4lxqsl/ezvupmyraurcDrhkUEwkVxVnR38erYzMVLMXCnJEOqC+tYeT8lEwGZi2/pR0v+DAyysE5/YQa9RPjuSCfJcVUtNzTkENadB8NcIL37FZCl76lWcMb74BJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APzdFI9ukIYE3zi58rj1eRMxd+hk+uNx7dElV58iAlM=;
 b=jtg/t2rc63dixxpJLkxaS8gGUqh9M5zcFirFkGdBqRnoxnpA9NUdI/vOUOhJ5SW1d3VZKqVknTv+y6rpRAR5c4CSY8bHumz6bibsQ1evIAOmeEBLhNLiK39C9iIh2FfuTQgKXlPRQSnEYPIesJTpdVnuFcHnyxqCWUWYSlQo4m8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8505.jpnprd01.prod.outlook.com (2603:1096:604:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 09:53:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%5]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 09:53:09 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lee Jones <lee@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZYvkq1tObMCxvvECDvU/oy9wfC68qbjSAgAA3iDA=
Date:   Fri, 14 Apr 2023 09:53:09 +0000
Message-ID: <OS0PR01MB5922824F09E1BC9FB9CECC9586999@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230330111632.169434-1-biju.das.jz@bp.renesas.com>
 <20230330111632.169434-7-biju.das.jz@bp.renesas.com>
 <20230414062641.76no7jz7uluixwdg@pengutronix.de>
In-Reply-To: <20230414062641.76no7jz7uluixwdg@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8505:EE_
x-ms-office365-filtering-correlation-id: c23b10bc-3c0e-47db-c35f-08db3cce0de3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wek/o+1iQJE8z1RWCgqcqQv9xraH6+Xn8XWLF9pM2QNW2OwqvnyoHHtrqRuxk+BERxHtJLxRYvV4T6UF/iL7Ohs3rpogByS574J8GV1N6Cjq61bJRzhw9ZcJJlHKuwi1XmY5/YeOhEG/5FGWBkhLOmzUWI+kQuo95TcEtlx1z4e+7P/ggNofF4pnGGbR5Xt8mNQhVBPok0mIdL11DxD9st5uByLjDTy3HLj3yre7iW2TdTkihl5IWJ9UODzUNX/wJyYlgxiK2mmGz3nvC8WF6vlwinjH7H3M4X0YHdz57mKnZgF+PFJuABNmreYoxDEqXkFh2dObiIYHzX1oONU/J5AK4vZ2G9PPa7ToAx/FMF42xCorGR3pcLapv4Nt/6RB5R6kznhN8W/bfryELQjGJbWngjnPOHXMjt27SOABm/KBaZWo/zT6fPXqxujaTKlbgRnwwMHHCdl4DTX6pvcAXBUoGfHQty/5SSs83a2/vZK5DZ0i0wAK37Zgk12Yw5GMGvRIaPrWAWDhHeJvbHzvpjb5W9r7XaaOyl11R9NKfyySl+Fl2jMNlQPTBtye2ljYwGamst+wwBMwrbRN2T495392CJlkfyBAyO7wjBxoakvf5HFxXpIfKkTtjcP81ggV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(38070700005)(9686003)(6506007)(186003)(26005)(54906003)(33656002)(478600001)(55016003)(122000001)(2906002)(8676002)(8936002)(83380400001)(41300700001)(52536014)(5660300002)(66574015)(66446008)(4326008)(6916009)(316002)(38100700002)(66946007)(66556008)(66476007)(76116006)(64756008)(86362001)(966005)(71200400001)(7696005)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S815R9RQXXA2xoieqMoboK4akwZrq97zHovVZthyP3kut2JglFLE0hK2JG?=
 =?iso-8859-1?Q?OmeX5l+PTA7C+sMfudxA9BfEuLEWxxnKEBptEdpBs/JX9u7E8D1o7wq2Ki?=
 =?iso-8859-1?Q?F4MJ7f2zLI2Q9uMyG/P3Tnow04+FiHlIXjNjWNBakJyIp5wzn8OWB6jau7?=
 =?iso-8859-1?Q?fFj1L+1+HMYnRo4aAfn7L+0D+mhUUy2DFnNuS1dSkL3vhYfaZegt0Tiyf+?=
 =?iso-8859-1?Q?qDC5glKL5SQRfnxjezKcsUZCn68DZVt6llCwho7+i/hX/aKzlzR6aTjIXH?=
 =?iso-8859-1?Q?3ZPT9YuJ8L6NE7q4bdsfEhOjDwnTV9FfEi5SUrKqbsFJ4FjuIu/sY7vJFm?=
 =?iso-8859-1?Q?TRWI9Gi56zcC3ATUYPK3StnP+kGVchGiW5fJQQu4qnLWV8XU12sV/K72Ml?=
 =?iso-8859-1?Q?vFb+iDng6JztG0XYzeRiQOMbfXRK+0cmJ3VBft6STFmK+68GD97e6yOug6?=
 =?iso-8859-1?Q?H3nwHRhqSExeH6lRnKDKnDWavY4Jr4Q7lGoxahyYXWjmZexhsHzZPCpQIo?=
 =?iso-8859-1?Q?eG3zLq3cdk3xL7CdQf65q2zylI95DYW7lZ1B91UguinYU3bj6IrMb9D+/j?=
 =?iso-8859-1?Q?bnDFrcV29OCUvDoEp+j33BBaO4umrhYgOLOz6Sz37FP0cFjlt/Ue3IkJmQ?=
 =?iso-8859-1?Q?F3beXdxHnFIJIsSsX3cqxqBkLOz4SI5rC3zgjFcZw/U+XcOGxVTCKnPsp1?=
 =?iso-8859-1?Q?tYOmG//jq13ux7hlQDmqbam4DYTfAC95ty6mHZuYCloSPfGSFyREI0CGx9?=
 =?iso-8859-1?Q?PbMxoMmK+Qxhq53PaCBiEug/Ohk8uA98r/R1tERhTu85qsJTQR/sWoDMko?=
 =?iso-8859-1?Q?+hLeXX87fqOEyb4vZmwG5o9pHyC4rbV2M+pZCwaHuwN2PVXWp5B5C3y4bp?=
 =?iso-8859-1?Q?928F4JOGxRU2Dt/Edv3WMLwkXRMj03nQ0QWf0IUgye8iqkqXjeUBDoiR2/?=
 =?iso-8859-1?Q?aw4/c2A+VVLWcGrZhI2dCx0l27hMrjQb+s4/0EOv4KuGy6t4xl6D4cJ7tv?=
 =?iso-8859-1?Q?TXHnl2NKHzoo1zv+Kx6up/0ddrwFdYDhLPZKtT8F7Xe0ErDoFvj8BXIlwT?=
 =?iso-8859-1?Q?4TYPRxz9loHgvPwY4wlRzXTJSm1lsrTPAO2sVrpHkFNDLJmt4suHi+oDfg?=
 =?iso-8859-1?Q?7l5Dsf/lEyFni+HMY25su8619m0C6S6saiE3kvQAd5y5QFd3x2EJQs1HSb?=
 =?iso-8859-1?Q?vhOIFKJ2cFZMXhqew8XSkJkn4vbu2pu72ar/V0i2QVq8xJIqbeA0j8hsj2?=
 =?iso-8859-1?Q?XWQ/X6EZazazkx82GlpmAUlX/CjqXqcl9y91NNbi4app9ewqBF34+roR4W?=
 =?iso-8859-1?Q?lsgCUmSNcZWN08FVaWiy9beS/EIOdQYc90je7V4P9CA/7PrCPk+ulzkTAx?=
 =?iso-8859-1?Q?pJ45+//DvdBZFKmcUShVy9qsDuwzov1EAtnujq9BCGqTVo0qrg2QsGvkwe?=
 =?iso-8859-1?Q?bgStq0jlHAPfXBb243xeaa31QjAuAjxQGxO4iX8qo4yWuDZb6d5ag/8bwm?=
 =?iso-8859-1?Q?d/nKrbHJSQNbix/9NtVDWzJ3A9w4pAX2odMnlu1EkCHIROxL4tgJWRRN9q?=
 =?iso-8859-1?Q?4X7sUfyHhlValSlHqoo/bayhaiHYcWqohqllvanLhMIj1JKR2YoQ+oXIbo?=
 =?iso-8859-1?Q?jhSCTUWajdRG/RHvC9xInVDjyDeTPuIwvL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23b10bc-3c0e-47db-c35f-08db3cce0de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 09:53:09.6646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYW0gErzXOzkYOzOJlqlMuv2EmrzQtoaRCwZOCiGbuWVVLKCSpqs4IBUoE2pcd+Q5GWKAPBFs/3paIZpZG3W8pPO4Y+n9kMhqQuHJEbpakA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8505
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> Hello,
>=20
> On Thu, Mar 30, 2023 at 12:16:32PM +0100, Biju Das wrote:
> > +static struct rz_mtu3_pwm_channel *
> > +rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32 hwpwm)
> > +{
> > +	struct rz_mtu3_pwm_channel *priv =3D rz_mtu3_pwm->channel_data;
> > +	unsigned int ch;
> > +
> > +	for (ch =3D 0; ch < RZ_MTU3_MAX_HW_CHANNELS; ch++, priv++) {
> > +		if (priv->map->channel + priv->map->num_channel_ios >  hwpwm)
>=20
> s/  / /

OK, will fix this.

>=20
> > +			break;
> > +	}
> > +
> > +	return priv;
> > +}
> > +
> > +static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip
> *rz_mtu3_pwm,
> > +				      u32 hwpwm)
> > +{
> > +	struct rz_mtu3_pwm_channel *priv;
> > +	bool is_channel_en;
> > +	u8 val;
> > +
> > +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, hwpwm);
> > +	is_channel_en =3D rz_mtu3_is_enabled(priv->mtu);
> > +	if (!is_channel_en)
> > +		return false;
> > +
> > +	if (priv->map->channel =3D=3D hwpwm)
> > +		val =3D rz_mtu3_8bit_ch_read(priv->mtu, RZ_MTU3_TIORH);
> > +	else
> > +		val =3D rz_mtu3_8bit_ch_read(priv->mtu, RZ_MTU3_TIORL);
> > +
> > +	return (is_channel_en && (val & RZ_MTU3_TIOR_IOA));
>=20
> Here you already know that is_channel_en =3D=3D true, so it can be droppe=
d here.

Agreed.

>=20
> > +}
> > +
> > [...]
> > +static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> > +			      struct pwm_device *pwm)
> > +{
> > +	struct rz_mtu3_pwm_channel *priv;
> > +	u32 ch;
> > +	u8 val;
> > +	int rc;
> > +
> > +	rc =3D pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch =3D priv - rz_mtu3_pwm->channel_data;
> > +	val =3D RZ_MTU3_TIOR_OC_IOB_TOGGLE | RZ_MTU3_TIOR_OC_IOA_H_COMP_MATCH=
;
> > +
> > +	rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TMDR1,
> RZ_MTU3_TMDR1_MD_PWMMODE1);
> > +	if (priv->map->channel =3D=3D pwm->hwpwm)
>=20
> This condition identifies the first PWM of a channel. I was surprised her=
e
> that the channel numbering has a hole after each channel that manages two
> IOs. OTOH, in the comment at the top of the driver there is:
>=20
> 	(The channels are MTU{0..4, 6, 7}.)
>=20
> which I would have expected to see in channel_map. I think the first memb=
er
> of this struct is really the base pwm number and so is misnamed?

Ok will change the variable to base_pwm_number.

* @base_pwm_number: First PWM of a channel

and add the below comment in channel_map.

+/*
+ * The MTU channels are {0..4, 6, 7} and The number of IO on MTU1
+ * and MTU2 channel is 1 compared to 2 on others.
+ */


>=20
> > +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORH, val);
> > +	else
> > +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORL, val);
> > +
> > +	mutex_lock(&rz_mtu3_pwm->lock);
> > +	if (!rz_mtu3_pwm->enable_count[ch])
> > +		rz_mtu3_enable(priv->mtu);
> > +
> > +	rz_mtu3_pwm->enable_count[ch]++;
> > +	mutex_unlock(&rz_mtu3_pwm->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> > +				struct pwm_device *pwm)
> > +{
> > +	struct rz_mtu3_pwm_channel *priv;
> > +	u32 ch;
> > +
> > +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch =3D priv - rz_mtu3_pwm->channel_data;
> > +
> > +	/* Return to normal mode and disable output pins of MTU3 channel */
> > +	if (rz_mtu3_pwm->user_count[ch] <=3D 1)
> > +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TMDR1,
> > +RZ_MTU3_TMDR1_MD_NORMAL);
>=20
> This never triggers if both PWMs of a channel are requested, even if both
> are disabled. Is this intended?

It is not required. Will take out this.

>=20
> > +	if (priv->map->channel =3D=3D pwm->hwpwm)
> > +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORH,
> RZ_MTU3_TIOR_OC_RETAIN);
> > +	else
> > +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORL,
> > +RZ_MTU3_TIOR_OC_RETAIN);
> > +
> > +	mutex_lock(&rz_mtu3_pwm->lock);
> > +	rz_mtu3_pwm->enable_count[ch]--;
> > +	if (!rz_mtu3_pwm->enable_count[ch])
> > +		rz_mtu3_disable(priv->mtu);
> > +
> > +	mutex_unlock(&rz_mtu3_pwm->lock);
> > +
> > +	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
> > +}
> > +
> > [...]
> > +static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			      const struct pwm_state *state) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > +	struct rz_mtu3_pwm_channel *priv;
> > +	unsigned long pv, dc;
> > +	u64 period_cycles;
> > +	u64 duty_cycles;
> > +	u8 prescale;
> > +	u8 val;
> > +
> > +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> > +					NSEC_PER_SEC);
> > +	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm,
> > +period_cycles);
> > +
> > +	if (period_cycles >> (2 * prescale) <=3D U16_MAX)
> > +		pv =3D period_cycles >> (2 * prescale);
> > +	else
> > +		pv =3D U16_MAX;
> > +
> > +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm->rate,
> > +				      NSEC_PER_SEC);
> > +	if (duty_cycles >> (2 * prescale) <=3D U16_MAX)
> > +		dc =3D duty_cycles >> (2 * prescale);
> > +	else
> > +		dc =3D U16_MAX;
> > +
> > +	/*
> > +	 * If the PWM channel is disabled, make sure to turn on the clock
> > +	 * before writing the register.
> > +	 */
> > +	if (!pwm->state.enabled)
> > +		pm_runtime_get_sync(chip->dev);
> > +
> > +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> > +	if (priv->map->channel =3D=3D pwm->hwpwm) {
> > +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> > +				      RZ_MTU3_TCR_CCLR_TGRA | val);
>=20
> If the sibling PWM on the same channel is on, you're overwriting its
> prescale value here, are you not?

Yes, you are correct. Will cache prescale and add the below code
in rz_mtu3_pwm_config(). Is it ok?

+        * Prescalar is shared by multiple channels, so prescale can
+        * NOT be modified when there are multiple channels in use with
+        * different settings.
+        */
+       if (prescale !=3D rz_mtu3_pwm->prescale[ch] && rz_mtu3_pwm->user_co=
unt[ch] > 1)
+               return -EBUSY;
+
+       /*
+        * Prescalar is shared by multiple channels, we cache the prescalar=
 value
+        * from the first enabled channel and use the same value for both
+        * channels.
+        */
+       rz_mtu3_pwm->prescale[ch] =3D prescale;
+

>=20
> > +		rz_mtu3_16bit_ch_write(priv->mtu, RZ_MTU3_TGRB, dc);
> > +		rz_mtu3_16bit_ch_write(priv->mtu, RZ_MTU3_TGRA, pv);
> > +	} else {
> > +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> > +				      RZ_MTU3_TCR_CCLR_TGRC | val);
> > +		rz_mtu3_16bit_ch_write(priv->mtu, RZ_MTU3_TGRD, dc);
> > +		rz_mtu3_16bit_ch_write(priv->mtu, RZ_MTU3_TGRC, pv);
> > +	}
> > +
> > +	/* If the PWM is not enabled, turn the clock off again to save power.
> */
> > +	if (!pwm->state.enabled)
> > +		pm_runtime_put(chip->dev);
> > +
> > +	return 0;
> > +}
> > +
> > [...]
> > +static int rz_mtu3_pwm_probe(struct platform_device *pdev) {
> > +	struct rz_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
>=20
> Nitpick: I would have called that parent_ddata.

Agreed.

Cheers,
Biju

>=20
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
> > +	struct device *dev =3D &pdev->dev;
> > +	unsigned int i, j =3D 0;
> > +	int ret;
> > +
> > +	rz_mtu3_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm),
> GFP_KERNEL);
> > +	if (!rz_mtu3_pwm)
> > +		return -ENOMEM;
> > +
> > +	rz_mtu3_pwm->clk =3D ddata->clk;
> > +
> > +	for (i =3D 0; i < RZ_MTU_NUM_CHANNELS; i++) {
> > +		if (i =3D=3D RZ_MTU3_CHAN_5 || i =3D=3D RZ_MTU3_CHAN_8)
> > +			continue;
> > +
> > +		rz_mtu3_pwm->channel_data[j].mtu =3D &ddata->channels[i];
> > +		rz_mtu3_pwm->channel_data[j].mtu->dev =3D dev;
> > +		rz_mtu3_pwm->channel_data[j].map =3D &channel_map[j];
> > +		j++;
> > +	}
> > +
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
