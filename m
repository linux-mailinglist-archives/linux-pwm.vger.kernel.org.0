Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9419A174407
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Feb 2020 01:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgB2A73 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Feb 2020 19:59:29 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:52443 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbgB2A73 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2020 19:59:29 -0500
Received: from [100.113.5.69] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 45/28-62111-A67B95E5; Sat, 29 Feb 2020 00:59:22 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUxTVxjGOb23vRdozaXY9VgBk266zdla2Id
  3Q+aymHmD0c1kc1GHrpVKq6WFfriybIpS2BwQUUYi5UsBJ2MsSAFBgh9jUqWAENAOBoVFihkQ
  PlIHwkDcbW9123+/932e857nnJyDI/wSTIQrzUalXivXiDlBqGojXyNRN+zZL5uxbCL/KnKg5
  K+lfwIyrayaQw7PtgKy3zPHJnubCjmky1UJyNmlRYz8pqaATZ4umGCTUx2jGPm0uREj2zPZZK
  0tDyEXmopRcuBMLniPoKb70jHqqtWFUbbKUxxq0NnMoabu3sWo4rZd1I2iKoy62BdKnX4io0b
  nryHUI1sE1ZExiX7E3ctWaxU68+ds1XJhRJJHZM6afTkVZAu+A0E4IC4i0NE0gjGFHYUnW0rZ
  TFEL4GL2AsdboMQdBP4y2o54Cz5xhgVnsidRphgG0HIli14TiHOIDfBBfjXLyyuJZDgx2OUzI
  YSdDbtODPhMoUQ0PHe+32/aDEsa3BjD78DZ8VbEyyixFi7ln0O9zCPiYMNNi3+3egDbL9T5Bg
  USMXAus5sWcDptOLzvDPO2EUIIf3eX+OZDgoDlzV0IwwI4NrLsWwqIAzB1vNDf3wA7f3MDhtf
  A3oxFjOFw2FOS6e/vgJ5bNzkMr4cN1la/h4Tlmem+CJB4CS63pDBtDZyatPot6+B9TyvKcBh0
  F5UD71EgUY/CBWs/kgNk1v/EZlgK+/K+5zD8GvzhwgRi9V1FCGzLd6PnAVoJNin06gSVMVGu1
  kgiZTJJZOTrkrckpFT+pUQhVZokB5Vao15Oa1L5FwapISXxoCZeqlUabYB+q/HJHLwR9Fyalr
  aAVThLLODZvt2zn79CoYtPUckNqgN6k0ZpaAFhOC6GvNw6WgvRKxOU5kNqDf3in8kQ54pX8sK
  raZlnSJInGtQJjOQAEjxnrKgU4aNanVYpEvLm6mkT4TWpTNrnI579mx4QLgrlgYCAAD43SalP
  VBv/r48DIQ7EobyzV+gpXLXW+HyncToEiw6h83zqDWGU/yuJUlkxxYLhxScFd2rU4/vuRTlfG
  DJcirCcrBqLu7FDmPHiQO7Pu2Mvmzs3jkUG3y6O+iD6+NfWmMPOrg8thXj67m09wjfsPzrTio
  9FLQlr9NvXDI1c08U5HvNCQq9nPUQKVlV0mGNUjviK2M25vDLu5cdby1yiVwsmHT1bPVW2s7v
  yzD9tq9MsGgfrsHCnvfswP7l/y+17cemr5+ddD6JHLb0zr1w9HqAKdCj+NoE3WWNbbr3/aF3Q
  Ie3Ril5XVM70J436pI+PJVx3VDmWjW17Wdsfev6wC1Z3LpXHpmXve3vUunwqm7vzs+ngr2rTu
  3VHZEdPvCtSBxf2iWeOlAyvMInd8U/nh8SoQSWPXI/oDfJ/ALJQh4KyBAAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-27.tower-249.messagelabs.com!1582937961!3178764!1
X-Originating-IP: [104.47.18.108]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13785 invoked from network); 29 Feb 2020 00:59:21 -0000
Received: from mail-am6eur05lp2108.outbound.protection.outlook.com (HELO EUR05-AM6-obe.outbound.protection.outlook.com) (104.47.18.108)
  by server-27.tower-249.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Feb 2020 00:59:21 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwHWHAvvwQ2ntNVqkbMadrZP6y/jfv05Qav576vSJwKSySR5d3OQLeBTIB/Kq9LoHVObs/8WqGGcJdl3nVlU9p23Djj5nB0NXOpNELCavxIKj96MgqD7kEcdmu4y97dTbP5gszWmOcdmcmj0rRlDm5xSREy8E9W9jId0hH4+szJwn2yWDl2zmeBGxvwShediW/h+H/YTbxzsLRFROIfjmHVDZs+Tn9N2reAODtrCT7Knrr+jgc+Y5CqDY5ZikVYFB08W+G9B8Hui2Wp0QbT4LHUFHHvkJAmNGuFFIuuWebH7qdVvscH3y9qVtc6pPHFkQ8Be7DObEBckmfDtg9X0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKu6LTWwdlU3LVv9ok60hzW6Dt4saynPzP6Ks8ARz5k=;
 b=VcciatglA2jKeU4uu2SAZFVRzqoHIPK4Al7fIAZzBoA2rHeAF3aDu3BeGx+JfrABCPWZX0d3C7EAY+Xk1GgasISS7rZe+hGXvU15wYAuIKp2xIDioCYtKUY1bCimuK1JDE1+GGDWbb7AQDeDYwENKjIrU8C6bE7Jx5tIQrySU/feZg9pYUsgYOmOopg0BwitXfLcn5h4VwkgitGHucIw+D9Zpe35Iluxq+wJvQsoNs+vkmROAlA6ThAXbSHWDJvRY/kfY5F8YofCQ6yia+qrKFCn1izoVVJMsFCsZYIlU0+eSVaXSoLdFYfZN8o5AsenCZfQQjjFNd7c3k67ivYnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKu6LTWwdlU3LVv9ok60hzW6Dt4saynPzP6Ks8ARz5k=;
 b=JhWchhaT93m0PgmNzSSKLva7o4hc1pPccUsm1CyrXHbWnsJK2VSNySPGz/+GtNF55l2N9j2HpEnVQHFuXTS18xHsVm20t2bqR2cg/hZIt4pCaFCr1Jr6/zHCLfUDtTdnJQUari2saqJVI2fzlUXUOTFCp8kaZD4fAnrS74rdWUM=
Received: from VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM (20.179.30.210) by
 VE1PR10MB3950.EURPRD10.PROD.OUTLOOK.COM (20.180.116.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Sat, 29 Feb 2020 00:59:20 +0000
Received: from VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::502e:bd5d:4232:4034]) by VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::502e:bd5d:4232:4034%3]) with mapi id 15.20.2750.024; Sat, 29 Feb 2020
 00:59:20 +0000
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
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH V9 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH V9 3/3] Input: new da7280 haptic driver
Thread-Index: AQHV6JB2B7xCrQY5cUWkQsJbkeg5B6gtriKAgAMA54A=
Date:   Sat, 29 Feb 2020 00:59:20 +0000
Message-ID: <VE1PR10MB30859CB04A6F9DB58D921F7485E90@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1582270025.git.Roy.Im@diasemi.com>
 <1569958274d409298695cf86184c7b67aaf19bef.1582270025.git.Roy.Im@diasemi.com>
 <20200226161307.6tv5q2yh62cp7vk6@pengutronix.de>
In-Reply-To: <20200226161307.6tv5q2yh62cp7vk6@pengutronix.de>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b08c3c3-a197-49b9-b35f-08d7bcb29bfa
x-ms-traffictypediagnostic: VE1PR10MB3950:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR10MB3950BE4C7CA2DD29D7796D82A2E90@VE1PR10MB3950.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03283976A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39850400004)(136003)(366004)(199004)(189003)(81156014)(8936002)(81166006)(8676002)(7696005)(26005)(71200400001)(7416002)(55016002)(53546011)(6506007)(316002)(110136005)(86362001)(9686003)(54906003)(186003)(33656002)(4326008)(64756008)(66556008)(966005)(76116006)(5660300002)(66446008)(66946007)(478600001)(52536014)(2906002)(66476007)(66574012);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR10MB3950;H:VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rn2YHCeByHU4Fel0t8m1GKqXq3/upPJrgpzntv3vZs+WeJPetnVIiHQt4+kljYgP8G2yGcMlLMdoAys88ZzlBcla+M+Gs6NiyNPxRw088DMs9MgjUTj0686k9kqVqmcfAkBlEJStVBR6s2dOiVNYSirobqLPgM0tDUMdKrEPkX9mMjQ8V1esF3Kdoozn53qB6nbuUfHJW2Qp3/H0gr41esYVkgruCRLGX6d3Nxjdu1RcQqx6FgtDkt5B/cLj9c2ytUJSDcDqlJM1Oqlx/FPjw50r/51/QsbVqVl0cFFt1fXblJolmq4V5pdKnA4i0vqYuQv5XE969W2eYWnIp9wV/TM5caSWnDl+0fOXX/BGSmndNytHqDs04zF7s7ut593FgO6oz3KHJy//yrd2hwH43c7tytWsHspBORfPiBFkj62U7/ShInly8YxzC9AVAxqc7uV8hL0O6wFruCzo0+iSdxEGH4EKx0aKc5Kozd22IuQJSbAvlsNPaR/99G5ufMLsO9EgqD0CHmWWb4ZDmUslNA==
x-ms-exchange-antispam-messagedata: 7OEn82nAW8EajD15XbOkvFysT70oVL6gf3aAps4Rq1cCFcPveJPxgeZ08irzSSVPO6OyKeqxeXxxTiqokFK4bo7G+3iUhRXhyWDwZIsf/AfNTqIWudLTx4aknW2pgTnXqhAhzn6N2FOdr25yKJl1GQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b08c3c3-a197-49b9-b35f-08d7bcb29bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2020 00:59:20.1744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXpdGfX+HLYCYi8J8+OpLWXFmEVmV4S6BX5ln3bR3lAcLoK0TZSN7Mg0DskwB+KzmkySbfxDMFXVWterMOZ97w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3950
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thursday, Feb 27, 2020 at 1:13 AM, Uwe Kleine-K=F6nig wrote:=20

> On Fri, Feb 21, 2020 at 04:27:05PM +0900, Roy Im wrote:
> > Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with multiple
> > mode and integrated waveform memory and wideband support.
> > It communicates via an I2C bus to the device.
> >
> > Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> >
> > ---
> > v9:
> > 	- Removed the header file and put the definitions into the c file.
> > 	- Updated the pwm code and error logs with %pE
> > +
> > +struct da7280_haptic {
> > +	struct regmap *regmap;
> > +	struct input_dev *input_dev;
> > +	struct device *dev;
> > +	struct i2c_client *client;
> > +	struct pwm_device *pwm_dev;
> > +
> > +	bool legacy;
> > +	int pwm_id;
>=20
> pwm_id is unused?

Okay, I will remove this.

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
> > +	}
> > +
> > +	pwm_get_state(haptics->pwm_dev, &state);
> > +	state.enabled =3D enabled;
> > +	period_mag_multi =3D enabled ? state.period * haptics->gain : 0;
>=20
> if .enabled is false .duty_cycle has no effect on the output. So there is=
 no good reason for setting the duty_cyle to
> something different for a disabled PWM.

Okay, I will add a condition for this.

> > +	state.duty_cycle  =3D (haptics->acc_en) ?
> > +		(unsigned int)(period_mag_multi >> 15) :
> > +		(unsigned int)((period_mag_multi >> 15)
> > +			+ state.period) / 2;
>=20
> This can be written in a more readable way:
>=20
> 	/* would be great to have a symbolic name for 15 */
> 	period_mag_multi >>=3D 15;
>=20
> 	/* comment with a rational here */
> 	if (!haptics->acc_en) {
> 		period_mag_multi +=3D state.period;
> 		period_mag_multi /=3D 2;
> 	}
>=20
> 	state.duty_cycle =3D period_mag_multi;

Okay, thanks. I have tried to update that as below.
Could I get your comment if you still see anything on this?

	/* Maximum gain is 0x7fff for PWM mode */
	#define MAX_MAGNITUDE_SHIFT		15
       [...]
	period_mag_multi >>=3D MAX_MAGNITUDE_SHIFT;

	/* The interpretation of duty cycle depends on the acc_en,
	* it should be from 50% to 100% for acc_en =3D 0.
	* See datasheet 'PWM mode' section for more details.
	*/
	if (!haptics->acc_en) {
		period_mag_multi +=3D state.period;
		period_mag_multi /=3D 2;
	}

> > [...]
> > +		pwm_init_state(haptics->pwm_dev, &state);
> > +		state.enabled =3D false;
> > +		error =3D pwm_apply_state(haptics->pwm_dev, &state);
> > +		if (error) {
> > +			dev_err(dev,
> > +				"failed to apply initial PWM state: %pE\n",
> > +				ERR_PTR(error));
> > +			return error;
> > +		}
> > +
> > +		/* Check PWM Period, it must be in 10k ~ 250kHz */
> > +		period2freq =3D 1000000 / pwm_get_period(haptics->pwm_dev);
>=20
> You already know the return value of pwm_get_period(), it's state.period.

Right, I will replace that to state.period.

> > +		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > +		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > [...]
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Hi Uwe,

Thanks a lot for your comments.

Best regards,
Roy
