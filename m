Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C682818159B
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2020 11:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgCKKPQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Mar 2020 06:15:16 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.65]:38281 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbgCKKPP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 06:15:15 -0400
Received: from [100.112.196.58] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-west-1.aws.symcld.net id 2A/E6-41576-F2AB86E5; Wed, 11 Mar 2020 10:15:11 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfVAUZRzHeW737haGrYe37pG3pkuHibzrzkK
  WopkwoY2pxv6yYQK9g4W9mePuujsCfJszBUJSUAIHhMNMFEiGASJerSBA5bWOQRAkUhAETERT
  oEPslkWr/z6/7/e33+c7zzxLYO4lYm+CSTEzRp1KKxW54OxrLiEyeRMbo7g8vpX6q7gLp345c
  xtQh76tElHjDzsAde3+IyE10FQkosbGKgD1cMUupjKqTwmp7FNzQupuzy0x9aSlQUx1Zwmp2p
  o8jFpusuLU6PFc8A6k54fTxHRj4ZiYrqnIFNHXr7aI6Lt9fWLaeuVj+qfiC2K6dNiDzn6soG8
  tXcToBzX+dE/6n/gO1yihRqfWp+wWsrn1uSLD734p9qZmzALOSY4AFwLAUgytlNXg/NCJI4vl
  JOCHWoDsR5dF3IDDyxiayzuPcYM7zBGg649mBPwwDlBreZ3wCHAmRHAzullQJeDYE9Lo2OqIk
  FvCYKcQ9R8cXVvygKEoZ+Ho+tLbaPnXa45YwsHb0I8NBCfjcBOarisTcjIJo9HSnQ38WRkCNJ
  7XKOB0ZxiDKns/5xBAPzR41Zf7EoMSNDJZshaOIERnW/oxnr3QzMTqWgEAdyHLbNG6vhn1Dk0
  Cnl9EA+l2Mc9+yFaSta5/iOovFazvB6KlP5rX8yl0NisN5yoguBGttqXyshadWPgN5zkAHV6w
  Cnn2RWnZ1rUrRLAIR1/caMVzgKLwP7V5lqPhvK9FPL+Kzn0zh3FMQjd0pWASPw1wx+tRGzUJr
  DlRpdHKlAqFTKncIlOGBMuUwcFy1R6ZWs4kyZIZk1mmlKuSTXJTamKsNk6uY8w1wPFW4wwd1Q
  2g7/y8vA1sIARSL3L4Ahvj/pxaH5fKqkzsLmOSljG1AV+CkCIytcHhuRmZBCYlXqN1vPinNiJ
  cpZ7ktkaHTZoMqkSTJoG3uoCMyJkpPoO54zq9jvGWkIFcBuSW2CTds4in/40N+Hl7kMDJycnd
  1cAYEzXm//uzQEIAqQcZwaW4anTmZyfNOkoIHCW+6kzgSphV/1reFoGynp1ut2bnh5fsc0X1Q
  Tc9pZbCcH2FVR0Y/ulQKAMru8MyB3+ACROhS/GRnw1G5QwZBspux61IfEp34lNtWnst2RSUmv
  7JjcWt95OjM47F+zOHfPIzooPfXS1X1B1bDIvNnZL/TDdPZUZGaEmbzw67sqVwZ9UrE/L9PXc
  WzRXfZc2MPHhZ7/xGAChv66nw29d9eG/f3/uTT9tA3ZfFHz2xbOxlY60R9N60F7IHI6eZkJWw
  oLcuHhBNu31/72D/8S3+tsr346vRiNeByKRm9KZhz6Xdr+f3iAMeFzS61T8ffHL7S7aoD7a3E
  +2tkq7Me7aOuMzoTYt5QfP69/pY66ialOImVqUMxIwm1T+4hkGhsgQAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-26.tower-292.messagelabs.com!1583921709!701981!1
X-Originating-IP: [104.47.10.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30917 invoked from network); 11 Mar 2020 10:15:10 -0000
Received: from mail-db5eur03lp2057.outbound.protection.outlook.com (HELO EUR03-DB5-obe.outbound.protection.outlook.com) (104.47.10.57)
  by server-26.tower-292.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Mar 2020 10:15:10 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b97CrMvKuqkf4Jh8V+loBy6l/+E0Fb9mndbC2RFDex7ayi0foap8Z/JaB/jVgFnEsj/J8IqOjMnHcu2efH7O3r6WrBKd2H2QGTQWOLQq2gd7TUYGoJZjI/DtH1+AgRJznoJMIf6F2JN9qOIGef8mA/LDYwxkiH9ow2qrAQiSimE/nUXbJT6gq6BZKKW0veh7I/pHCpCsgH5+aZA0HiRAhYkgdNSRlnnQ0vClH7OQsYv55d7FYdbBwOLfjpdbk7n+a2EsABMrsxyuUEEnpZunm2lae8Y9fOHwECeQTHkPCme2mONEk7JqqXJ2UO/27o62U0zBm3oPKFMkaIbp0g01tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbN1Nq5cpOzbMCy8YovdIJFP/SUTI7SJhyhJeIBo8ds=;
 b=LJmnvxFlr1gu2343Y6M+x7bOlSNvVsnzGEKaMZcdN+wrSyHGTFafk1FzA3xX0RQDB6zylkAIYBVgiHwScj5bxBYLEL4d4zUwyjzAeeH0zKH93If7bX7cw9zJjL0QDodDIwGkE9A1w7+pnE8NjLjKC0qnr+X7g3p4Tw+0QvVIZ3lne9JlFXrdMJIU4JLdwdyz8vsZuZWbxJEclvLFLlH5OFOYPvqcghuKxoijX2aPHbr3aJQ3IHzapYPv3H7DF2wazEem4q1KEXRq/Ij2sXcISDUBlrIWZgvNCDeVtEhsZz0Pk7M/V2ME3vUvP96QNN04hZbOMsMPtZOvINgT9D6DTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbN1Nq5cpOzbMCy8YovdIJFP/SUTI7SJhyhJeIBo8ds=;
 b=vApFFsdOQO5wrdzZ7t9N1oG2pVynWE0wL+TWnyvQBX3tZDkAH7x45FPVryBRGhD4gHSKX4JFCAmK68G6tHsdy+YFCOAsfVtvG8bciFwEfmuGlai/3GYRsb2Y9tTjcmUht/OD/ch5thUVynjuZ0i/n+CSEHQ01/n39ApJeEEPAhw=
Received: from VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM (20.179.30.210) by
 VE1PR10MB3439.EURPRD10.PROD.OUTLOOK.COM (20.179.31.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 10:15:06 +0000
Received: from VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::502e:bd5d:4232:4034]) by VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::502e:bd5d:4232:4034%3]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 10:15:06 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
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
Subject: RE: [PATCH V10 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH V10 3/3] Input: new da7280 haptic driver
Thread-Index: AQHV80yP7BLL0HDonUGoY+ejUtesAKg7JLUAgABxVOCAB586cA==
Date:   Wed, 11 Mar 2020 10:15:06 +0000
Message-ID: <VE1PR10MB3085C1E1B24EF93BA13DCB6285FC0@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1583425388.git.Roy.Im@diasemi.com>
 <fd7066d21e994de56b331d9320f9671356fac408.1583425388.git.Roy.Im@diasemi.com>
 <20200306070544.7rj5y44e23kiz65e@pengutronix.de>
 <VE1PR10MB30852BA3A8166D475940694985E30@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VE1PR10MB30852BA3A8166D475940694985E30@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84e0ecc3-8a29-4d75-2e50-08d7c5a5128b
x-ms-traffictypediagnostic: VE1PR10MB3439:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR10MB34399B36472C65C41B5AECCAA2FC0@VE1PR10MB3439.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39850400004)(376002)(396003)(136003)(199004)(6916009)(5660300002)(64756008)(66946007)(6506007)(7696005)(76116006)(316002)(54906003)(966005)(7416002)(33656002)(66476007)(66556008)(66446008)(66574012)(52536014)(8936002)(86362001)(26005)(81166006)(8676002)(81156014)(4326008)(478600001)(186003)(9686003)(2906002)(55016002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR10MB3439;H:VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BhVHKrMozBhkd9VDk63E0jGrjjJLTiYJe3vtu1+k1INcHdK/GtJrDUYeVVTQZR//7fywSgCUhG+lCcsYw9u+RsHfhPSUlA+lDOs1PsblRQIg0mhVnWvIKhbORQdR9MOZlVQxuReDGSLqbGAS2B5IjVW2rjK/cZ4Kvew/ZKXNtkPyszCt/LFnqtpJD3xXlvUYehmTadbq32Fjt/Q9YI5B4vT7zFechlR4guHXv8OPQzsoWEEthp6D5oy/La8HL51t06ZcedYfR7H4EGgR1xIICfMx/qDNbbPTc+Qe27dOmxGel96x57GRx7L88y4y+x2TRmdJBC5nNs1uuXzYxG3Qd33UD/8EkLYnoQe1xAZkfl/GCR568AVACyCIBSRt8omzUCJiQnSHp/wo4g2gpwoF6K4sY7Kh9HA1Fy8PUcT83P9T2MwnKTyHXSZtbnnkVb1eAzGjQ9jx0O4t015NiEpjammSRSDmm6RnZMjAiV6vj0mftVw5yVTvon6IaSVh1fMriE6nfPxx9AJu+kem/9HvWg==
x-ms-exchange-antispam-messagedata: N0lM1oolM34gFrjJUQhoIDFAt1YxUOppY/1KicpdZgj/751qgiTAy2BaQwCoj2V4UTAM1MXtiG1n02/vJ/z+PCWpfpf60PeulZgvW8x6N6Y6bdGZVAh1wEDpKz+3mGyYJ6Nrq9NXizYybZK+TRk19w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e0ecc3-8a29-4d75-2e50-08d7c5a5128b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 10:15:06.5682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lR5uHWZHdRWDWMMG/chW/bbV5teIX7DpBYu470czkJHXxOXzVIOc+H8yqrbIpW3C4hSV229d3/P0l0TZvR0LSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3439
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Friday, Mar 06, 2020 at 4:06 PM, Uwe Kleine-K=F6nig wrote
> On Fri, Mar 06, 2020 at 01:23:08AM +0900, Roy Im wrote:
> > +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics,=20
> > +bool
> > +enabled) {
> > +	struct pwm_state state;
> > +	u64 period_mag_multi;
> > +	int error;
> > +
> > +	if (!haptics->gain) {
> > +		dev_err(haptics->dev,
> > +			"Please set the gain first for the pwm mode\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	pwm_get_state(haptics->pwm_dev, &state);
> > +	state.enabled =3D enabled;
> > +	if (enabled) {
> > +		period_mag_multi =3D state.period * haptics->gain;
> > +		period_mag_multi >>=3D MAX_MAGNITUDE_SHIFT;
> > +
> > +		/* The interpretation of duty cycle depends on the acc_en,
> > +		 * it should be form 50% to 100% for acc_en =3D 0.
>=20
> At least s/form/from/, but maybe better: it should be between 50% and 100=
% ...
Okay, got it and sorry for the typo, I will update as you advise..

> > +		 * See datasheet 'PWM mode' section.
> > +		 */
> > +		if (!haptics->acc_en) {
> > +			period_mag_multi +=3D state.period;
> > +			period_mag_multi /=3D 2;
> > +		}
> > +
> > +		state.duty_cycle  =3D (unsigned int)period_mag_multi;
>=20
> This cast is not needed. (Also it seems struct pwm_state::duty_cycle=20
> becomes u64 soon, after this happens the cast even
> hurts.)
Okay, I will remove the cast.

> > [...]
> > +	struct device *dev =3D &client->dev;
> > +	struct da7280_haptic *haptics;
> > +	struct input_dev *input_dev;
> > +	struct ff_device *ff;
> > +	struct pwm_state state;
> > +	unsigned int period2freq;
> > +	int error;
> > +
> > +	haptics =3D devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
> > +	if (!haptics)
> > +		return -ENOMEM;
> > +	haptics->dev =3D dev;
> > +
> > +	if (!client->irq) {
> > +		dev_err(dev, "No IRQ configured\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	da7280_parse_properties(dev, haptics);
> > +
> > +	if (haptics->const_op_mode =3D=3D DA7280_PWM_MODE) {
> > +		haptics->pwm_dev =3D devm_pwm_get(dev, NULL);
> > +		if (IS_ERR(haptics->pwm_dev)) {
> > +			dev_err(dev, "failed to get PWM device\n");
>=20
> Please use %pE to show the actual error and don't print if it is EPROBE_D=
EFER.
Okay, I will change as following:
		if (IS_ERR(haptics->pwm_dev)) {
			error =3D PTR_ERR(haptics->pwm_dev);
			if (error !=3D -EPROBE_DEFER)
				dev_err(dev, "unable to request PWM: %pE\n",
					ERR_PTR(error));
			return error;
		}
Do you still see anything on this changes?

> > +			return PTR_ERR(haptics->pwm_dev);
> > +		}
> > +
> > +		pwm_init_state(haptics->pwm_dev, &state);
> > +		state.enabled =3D false;
>=20
> This usuage is strange (which might be because pwm_init_state() is=20
> strange). I assume the goal here is to disable the PWM with the right=20
> polarity set, right? Ah, and initialize .period as this isn't touched lat=
er on. Hmm, no better idea, I guess we have to leave it as is for now.
Yes, that's right. I think so.

> Can it be that the PWM is already on at probe time and it might be useful=
l to keep it running as is?

I don't think it can be that the PWM is already on at probe time but it wou=
ld be useful to ensure that it is off.
Also I will add this comments on the pwm_init_state():

	/* Sync up PWM state and ensure it is off. */
	pwm_init_state(haptics->pwm_dev, &state);

Do you have any comments more on this?

> > +		error =3D pwm_apply_state(haptics->pwm_dev, &state);
> > +		if (error) {
> > +			dev_err(dev,
> > +				"failed to apply initial PWM state: %pE\n",
> > +				ERR_PTR(error));
> > +			return error;
> > +		}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Hello Uwe,

Thanks for your comments.

Kind regards,
Roy
