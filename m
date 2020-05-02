Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671E71C268B
	for <lists+linux-pwm@lfdr.de>; Sat,  2 May 2020 17:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEBPcM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 2 May 2020 11:32:12 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:23235 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727897AbgEBPcL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 2 May 2020 11:32:11 -0400
Received: from [100.113.2.218] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id 71/D5-08563-7729DAE5; Sat, 02 May 2020 15:32:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTe1AUdRznd7u3tzBcsxwSPxi46oYZUtyTgwl
  XzSnDcp1qChumGSlsgZXbPI57oYdWnhG9GOQAGRIEi3gMGDLycAQhHAoL5ZUK8jqTVwkMMHAS
  EKXtsqfVf5/X7/P9/mZ+PxxRlMr8cdZqYU16RqfCPFDtFo8I8nBOdWxodX8Ydb/oGkr9UHIPU
  Gnf1mBUVV4jSv261A6owcU/pNTNpjMY5XBUAWrprzUZ9dmFQimVVTgjpeY6J2XUw+ZLMup6hp
  Sqq81DqNWmYpQazs4FL3rR8wPpMrqxwCGja6u+wOiR/maMnuvultHFHVF0a9F3MrpswJvO+ju
  UnlxpQWhnrZLu/HQWfdNzv5TTxyVb35NqF0ahod7XOtWwjNlApeJL4IEDogyBjja7VCRXUdhS
  PS4TSR2Aa5mrmEBQ4mcE1v9+TyIQBVEsgUNf5fMxd56MAjh38n0BY8RmOHa6RiLgDYQRzoz0o
  MIBhFiWwqLLdzHB8CYi4YmcOldoN7SlzaMi3g67fryICBglgmBlTQefwXE5wcD8cVQc3ADg8l
  DO+mB3YiesqbCtZwARCPv6AwQZIXzh0MTZ9XpIELC0uQcRsQ+cGn/gumcegAvlg5hobIZdtye
  AiJ+CF5qmXQcC4Y2zGS79dVg/8jkizBLyfd3viDIFSzPSUVEOgg/aUkXZALMdk66WYPjJQrFU
  xAEwvWHZ1aiEVZmjqB1sKfjP1iJWw4G8U5iIQ2D5NzOIgOWEF+w4PYF+DdAqsC3OxCVqLUkMp
  yM1oaGkRhNOhpOasDA1c5Rk1GwKGc/qLSaGd9XMEbPanJoUr0tQ61lLLeAfbIIROXoJ/FIxr2
  4DfrhE5SN/bnt1rOKJuOSEVC1j1h4wpehYcxsIwHEVlH+cxXteJjaRtR7kdPyzf2RD3FO1Qf6
  nnbflZgOTZOYSResaIHH7VFEJokD1yXrW31deJoQIIaRN0T+uePR5boBAf285cHNzU3gaWFMS
  Z/m/Pw18caDyliuz+RZPTm95PGmaX0LCL0G4nxOWsDD/Wv42yeWrlWsvRPXHXGk/dPN8cMTxi
  HPF+SfTyLpbZStbc1vbhhf1nD5S92TRcGmjwmN1KuS69c5tK3cML/zI75huX6a3oRVrGeOih3
  LuBPvc/9C508j1tkZ/8MarIe3g5bJbfQvGUuPSkoG0yyaCT5W8dHijxlj+7iZycO+2V/LD98c
  eaNilRKrtb3U590U/33l82FDuk+P5fUjURecs+9PWgtHdHePzd1mrx5giprLX0nOlc1Hz7Kxz
  l19B2oBqOCpyx0qB/O3ciqnkE/F0n2TJmaUM9KEWm8mA8D0qOmj5kC3d9vT5Z+iDJSO9mphIt
  zN75neshGe4b3xYoTkCHFSK8rXfVKhZy2g2ISYz8w8eg918twQAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-10.tower-233.messagelabs.com!1588433526!515754!1
X-Originating-IP: [104.47.10.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 837 invoked from network); 2 May 2020 15:32:06 -0000
Received: from mail-db5eur03lp2054.outbound.protection.outlook.com (HELO EUR03-DB5-obe.outbound.protection.outlook.com) (104.47.10.54)
  by server-10.tower-233.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 May 2020 15:32:06 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6pWlVYXJU0PFEDbJhW0S5VgqTpUbFgjKlQBt237HE7S7n+ikmcivyYD9LyvRQAzphWAdsKlH+JEcFKyr0BxzSUdiKX17stp7tP9AkbAGI8CCaZ78lL8iuTmrEQGpMcD7/OI9UtVmQY9BpRD3FGyqY9YTc2yLJT1waNcvWBVFnDsBfwjbvWVfMpibvG0ylmZpVKWRzHTcMFvdLKVGmK+PAfZlIFI1NA9r/7TYDPAAiUb9VLmGSh6UyQq/UTXgkp/xKOOxPRU7HlOWKsTj4UnjMfOmJUoRcaIYixVz8ZP7tgZBfUzK66ZFxBci4HwZq/M7jJ3gtWeua6pUmqjFEqQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rORLoD/FvIa+vgss8HrGNIffXG++Y0BngWC5Y2xwz64=;
 b=lNMhfKR2PxylkF3m/ifXvRWRBJUxSr2pYvV3efRoBnzys2xbTU6748jXIitC6vOqk1uDVLVpIBuLYNY44Vh3ZV1fJ6asbU4/4gtiQ5RjUhg5+m/HA0LyO8F75oyKHvgeodaEbkUDYH0S1nubzVUrC7hpkHCLT3eQSRxXVqKmCCe84eEa/4A08iZ4tA9iHPmB7aqgLjQ0WU1UcVDrP/yywXZ5x1IsASFD6cO8ybBIj7Ekkuk6Li6ggHBK05K3XOwKVgIWEGr8d7V8hupsPTwPuxKeTBMtgarCeDgoxOTKradrdx68sG8iSsZAGIJr3jndS3DD84J0x251yFsGw0sG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rORLoD/FvIa+vgss8HrGNIffXG++Y0BngWC5Y2xwz64=;
 b=ts4dCgNRbJNR+CiJxuVdYAJ1GB8DQPXHrMFcWmbYdAGMIMm6mZLKrZeXBk7bGhm4SEi0QjMJBu+6pfiNbcHHLgUsUBHPFIeA0gwc5wAu/OirDacWtCW0ZRVxj565MwKOY+10sR0epvl/aat7d/1cxNF9sdlxRkC1bfS+baK05TI=
Received: from DB6PR1001MB1077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:58::12)
 by DB6PR1001MB1205.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Sat, 2 May
 2020 15:32:05 +0000
Received: from DB6PR1001MB1077.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88f1:274:a471:30f2]) by DB6PR1001MB1077.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88f1:274:a471:30f2%11]) with mapi id 15.20.2958.027; Sat, 2 May 2020
 15:32:04 +0000
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
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [RESEND PATCH V11 3/3] Input: new da7280 haptic driver
Thread-Topic: [RESEND PATCH V11 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWHFzOCnPme+qW0kOr3EKTj/tsr6iSFzyAgALXqxA=
Date:   Sat, 2 May 2020 15:32:04 +0000
Message-ID: <DB6PR1001MB1077F44B22FD486B04AF21B185A80@DB6PR1001MB1077.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1587949032.git.Roy.Im@diasemi.com>
 <eb301aa028c877a71e60dc7493ee712e4599e8d9.1587949032.git.Roy.Im@diasemi.com>
 <20200430194603.ah3ytucf3fzxrfs5@pengutronix.de>
In-Reply-To: <20200430194603.ah3ytucf3fzxrfs5@pengutronix.de>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8844dedf-2871-4090-7638-08d7eeadf7ae
x-ms-traffictypediagnostic: DB6PR1001MB1205:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR1001MB12059C0D27788C8DDD90902CA2A80@DB6PR1001MB1205.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 039178EF4A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CHdTte+wVvyWxUZ8PqsyBQOJZ82wV5vVO1KhIpC+Yy5zjrTo0H8CS8Jnnr7Zf1umMaf+K091Ve7wn4msw2NuffNdfgTUTKa7zCVRyWnpMjcFOE2/5WcsEz3POO7WEyEvSn2Oz/QJZXVY7/YaQbIY8nvgsC7Gqs9WNnMhtBd1tbpywfTKMF0gybx/wlnFL/4NfgETAhiCyzOe5HKBO1AvE39essq/Dm369T8nCGYixGuSA4QrGqBZ1B8fmEIAZYnGauY31wT4Pw/j5kdUgscM3f0pMRzXrC6nTHCAjHO2+tkDrn5u7F8CI+EoZeRgxWG0WF7opRZUm3r0DIoLZoZyiHeitmueHiwKnTLlRby91vHik5XRPOpTGOl6dXN2ONYf7/koTle3ggLBeRZrpU1ezJxEGDIBRFektZYgcZSeKIqCOou8ENwIWEn1x5A3M1/rNVnDfn2pwhSMZ4iG6zoiQZmtRHAWnSKgzL9m3EA2wzbKyOD1Y5KHtoxv5It8jYN7rE4V0Gg7qN1KUzOwY1vY8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR1001MB1077.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39850400004)(396003)(366004)(346002)(376002)(478600001)(110136005)(55016002)(9686003)(83080400001)(7696005)(54906003)(66574012)(2906002)(33656002)(52536014)(966005)(66946007)(76116006)(66556008)(64756008)(66446008)(86362001)(8676002)(8936002)(316002)(71200400001)(66476007)(7416002)(5660300002)(26005)(6506007)(186003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qoft63FEgsgZClCbUheuA6KAAYNGvSk1e8UZ7aRZ8L4EG8Ar8Aye6KLdDRrHlefG+ka8VkadiOhYdrjiR13vBwnHELw7+WUwaY1ar7TunN1RmDUijN1Fj5WJFrErk/OlQq66uHrsSQkOkf1VYi8UUOG3EglnhxdbPjBuN7Bzaun2gvq669AZ+8UuiUZhzE5Sz20xBbhOuXZX8UN558MOisf5ZjTnMWqv/CXTuz+F+B1LCq/9ff6xCBK6xHgRcOR3nXjR6BhjkR9BZHbBjFevIKZ5CBvd4c01OXrI+cL717c7EaZc7ytiEBYFwo+NZ9YzvGHVVp5G/D76/WDz8Eu0LwvDF9LCfZ7WhKpHYZDxg7G3gDbSz+tA7jvZfGDS0WU9GpgersOlo5ZiOCujZS44nayZibSzgcbqe0t/+PC6FRKXsxybr0lwFIx/Wg7tJDZSjDpx5LqJIwyIywl0Mfk3BYaGOKULNHi+2MInSrxbDUuR+lhbxJaPfSEieaev1YRQiGhE0bRY80R1X8moE8cnh3egzD7Ywfc0FrbzrJJ/j4yuueyTVRiFYgBnQR3YiYzgKgnQAvPZotZGgY8gz2QwvLBkFJEBeyrphiGgz7gVqE1vVTATVRb/0AJI3C28oeaQSEHfY36WjTx3opHwT0k+pUcpO3Sf5aLrG6u0WlAPHrZRHGhD3ICKvySvNtTI2klsW0oo5awIgUWUiMUbLMEGXnscAC13roTPvjbIiBxLLLR2Zua+bgq01TroTEvzj9RXOpOhSWH/Se54NZdp5zUlkxTH0cJ/DaGnhm8VpiQKUfM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8844dedf-2871-4090-7638-08d7eeadf7ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2020 15:32:04.6724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TlMHDcesoG/mRIp9UipYs5gSXVmo+3Ok8o2NFvGMNYy/nLSQ6kOYlLhGb2H69pat/ROLKkmoMDyHgHW7+5E11A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1205
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Friday, May 1, 2020 4:46 AM, Uwe Kleine-K=F6nig wrote:
> On Mon, Apr 27, 2020 at 09:57:12AM +0900, Roy Im wrote:
> > +	/* It is recommended to update the patterns
> > +	 * during haptic is not working in order to avoid conflict
> > +	 */
>=20
> I thought only in net related code the comment style is like the above an=
d in all other areas the /* is on a line for itself.

OK, I will change the comment to a line.

[...]
> > +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics, bool
> > +enabled) {
> > +	struct pwm_state state;
> > +	u64 period_mag_multi;
> > +	int error;
> > +
> > +	if (!haptics->gain) {
> > +		dev_err(haptics->dev,
> > +			"Please set the gain first for the pwm mode\n");
> > +		return -EINVAL;
>=20
> If enabled =3D=3D false haptics->gain is unused. Does it make sense to on=
ly error out for enabled =3D=3D true?

Yes, you are right and it make sense, I will add the condition(enabled =3D=
=3D true) into that.

[...]
> > +static int da7280_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *id)
> > +{
> > +	struct device *dev =3D &client->dev;
> > +	struct da7280_haptic *haptics;
> > +	struct input_dev *input_dev;
> > +	struct ff_device *ff;
> > +	struct pwm_state state;
> > +	unsigned int period2freq;
>=20
> This variable could be local to the if body below.

Ok. That would be better. I will move it below(to Here).

>=20
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
		unsigned int period2freq;
Here.

> > +		haptics->pwm_dev =3D devm_pwm_get(dev, NULL);
> > +		if (IS_ERR(haptics->pwm_dev)) {
> > [...]

> > +	error =3D devm_request_threaded_irq(dev, client->irq, NULL,
> > +					  da7280_irq_handler,
> > +					  IRQF_ONESHOT,
> > +					  "da7280-haptics", haptics);
> > +	if (error)
> > +		dev_err(dev, "Failed to request IRQ : %d\n", client->irq);
>=20
> I'd say emitting the error code would be helpful here, the actual irq num=
ber not so.

I will do so

> > +static struct i2c_driver da7280_driver =3D {
> > +	.driver		=3D {
> > +		.name	=3D "da7280",
> > +		.of_match_table =3D of_match_ptr(da7280_of_match),
> > +		.pm	=3D &da7280_pm_ops,
> > +	},
> > +	.probe	=3D da7280_probe,
> > +	.id_table	=3D da7280_i2c_id,
>=20
> Inconsistent alignment of the =3D signs. My preference is a single space =
before the equal sign, but aligning them in the same
> column is another usual style.

I will align as your preference, it looks better in this case. Thanks for y=
our comments.

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Kind regards,
Roy
