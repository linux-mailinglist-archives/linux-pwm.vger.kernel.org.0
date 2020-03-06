Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5DF17C061
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2020 15:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFOh3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Mar 2020 09:37:29 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.116]:43619 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbgCFOh3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Mar 2020 09:37:29 -0500
Received: from [100.113.5.140] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-central-1.aws.symcld.net id 81/A0-42406-520626E5; Fri, 06 Mar 2020 14:37:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTa1ATZxTly26yCZLO8ipfIxQn46BVkybScba
  0FqYWZ39oBy3ajq1AApHEhoBJoAEcBwZRHuVhFUdBXkGqA3agATqQYtGAVECgihWUALYGKqBQ
  oFAYELqbjbb9d8499557vp27XMStHBNwFQa9QquRqYUcZ1T5Np8QbYyQh0kWykXEX8WdKNFqf
  AqItIoaDjEyfwsQD2cX2ESf+RKHGBqqAsT8yjJGnP6+iE3kFU2yiak7oxix1tyIEV3ZbKLOVI
  AQS+YSlBg8cxYE4eT0QDpGNhUOYaSpKpNDWh80c8ipnh6MLOnYR7YUX8PIygF3Mu+FhBxdvI6
  Qc6Y3yTunnqMhLofYKo081hDBVjbd7AJxUz6GovvXWSmg3isLOHMBXonAhupphCHtKLw5sYgx
  pA7A5ZwlDk1Q/DYCU1ItKE3c8FwWLC1PwxgyDOBo7RgrC/C4HHwb/P1ijR174MfgpLXXPoHg7
  WzYmzrIpgV3/H2YP5PjaNoJl355SG3nUjgAjn8jpcsovhFm3u0GNObjh2FuXgtgljUAuJaaYf
  fhUbM/nTdj9CzAfeCvD7zpMoJ7wUe2Urs9xHF4ubkXYbAnHH+yah8FeDhMmbjkqG+D3f02wGB
  f2HdqGWOwD7xXmu2o74V9N0Ydnlvgz6eXHLMEvJydjtIRIJV51ZLIlNXw6h8DjvZN8ORMCZvB
  3vDK33P2p0C8GoV1xiesfCAp/E9sBovhQME5DoO3wm/LJ5FC+6dwhR0XbWgZQKn7kWtV0Up9j
  EylFkklEpFU6i96R7Rjh1iWJJKLFfGiSIVGr5VRolj2lU6sS4yJVEeJNQq9CVDXGnUM/bARvL
  g2LbaAN7gsoSd/5S15mNtr8tioRKVMpwzXxqsVOgvw5nKFkB8cTmmuWkW0wnBEpaZu/qUMuS5
  CD35RGCXzdXGyGJ0qmpE6gYibP15sRNxQTaxGIfDih9IeON2kjNe8snj559wDPgJ3PnBycnJz
  iVNoY1T6/+sTwIsLhO58nHZxUWn0rzZNUCFYVIgRazgdQi/7VxKksJIinK1zq7O9tZFZzwReB
  280SJz/3LTHOm71v/2usanFZPyguqvRdZfPZAXRHFtxYd9217bA5KT9Ob/1P55FsMp0NPprge
  GsucJzQ6CHn+C9821HN59o+DRhPYqYVxvzD7gcr1sLqc8I5QUf35u25HvFFxta+ajs1vNWUdP
  WiQuhn4989/H27iORg8Y4S7Tt6B6LurB/YNfcmccnFmzrwv3aP7GV7Tf0HWz54dxwjkdASV7g
  TPOjnUER6LrOnu7y3ff5J3l6WXJtXFX+hgDejwm8vsVA8+vrvxy72yrOHetIbtMcCAn64qkF1
  /dK/QWW4cMZoXkJBYdMwfVJks/mnylr0v0yhahOKZNuQbQ62T9SJUGAtAQAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-24.tower-246.messagelabs.com!1583505444!371025!1
X-Originating-IP: [104.47.13.56]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9259 invoked from network); 6 Mar 2020 14:37:24 -0000
Received: from mail-he1eur04lp2056.outbound.protection.outlook.com (HELO EUR04-HE1-obe.outbound.protection.outlook.com) (104.47.13.56)
  by server-24.tower-246.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 6 Mar 2020 14:37:24 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2nq+5MuNk6tSL8SxSMe1QaiXRnLZGTYpyQFAB8HAzgRD2ChpkamUXZYarl/U4t3puAcs4hn16LABZreSMHNgDK3OdW6TtHILURjFPxhd/wU01YboHSbBEqoo3jRRDAc7SKSlxlQbbj69HSvioZXCjDkhVOmZwUMRYeo2ZO4nGlT9LRuW0Gx7K+8oJWawhwW8ZaUcj5eqEjGIej+hSPsFfJ1onuU2+M2PfeZrdApVkdJrWGYWAzNrICflNWlLyq63Pohpb7U3u19Mkgj8ozA7wLMiNPo5uascOK8bIAYEuLtGT6Y3Q2n5Zg/2ttFuQ7abLWd0+upZRX9j9vnJv/qrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff4PyzJHn2WT1PNcY9bWs0P1nDh1HjbmUcOkJU38Br4=;
 b=XjEW+AzUIojZ176hF32RJLfbxP4k2mD4zkhmYOHBKHxo1al2kH9CM3/0gwO9RTTi65Nhz5IvNtnGyL9t2/moEJbS2T8SdGypYOfh+K0diGe/w3kVUDDWJi+/tDCh5jckKMhji7zK62bPsFsdCzPj3/xJSHoxgCdnvxHyrBQBtxXN0usTK7lzeJwlAg/n/em+e8nMoe/zk4rlHim5AuacB8Acc5OeusjLMgCY8EVrYC7U0AtuZN3AETHPxFeGshFmbzYVqI9vIPvIsSZVpq8u7UxWshIrBOgjxUgfwrMGJt4MSyZEbVr7o4rTNBiHW7xLjpY4s17bSeXQeArEhc5u+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff4PyzJHn2WT1PNcY9bWs0P1nDh1HjbmUcOkJU38Br4=;
 b=JhxkTSrQPhOxtKw05UzAz6kLUvA5Kz12N+uV2hdRkIKC89BQaKwKpRDCc2OQ37L+t4AnT2bH8j6AWa0RknJJmljIU3gGqlnHWxsNLt+SdFZFTJ+VyFK6dTiP+OhIiwy12K6CQIX8r3d/yyXbVBp5sKfBgE9T75UpdCrql1X9paE=
Received: from VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM (20.179.30.210) by
 VE1PR10MB3022.EURPRD10.PROD.OUTLOOK.COM (20.179.30.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Fri, 6 Mar 2020 14:37:21 +0000
Received: from VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::502e:bd5d:4232:4034]) by VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::502e:bd5d:4232:4034%3]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 14:37:21 +0000
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
Subject: RE: [PATCH V10 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH V10 3/3] Input: new da7280 haptic driver
Thread-Index: AQHV80yP7BLL0HDonUGoY+ejUtesAKg7JLUAgABxVOA=
Date:   Fri, 6 Mar 2020 14:37:21 +0000
Message-ID: <VE1PR10MB30852BA3A8166D475940694985E30@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1583425388.git.Roy.Im@diasemi.com>
 <fd7066d21e994de56b331d9320f9671356fac408.1583425388.git.Roy.Im@diasemi.com>
 <20200306070544.7rj5y44e23kiz65e@pengutronix.de>
In-Reply-To: <20200306070544.7rj5y44e23kiz65e@pengutronix.de>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c754dd7-cbf9-4206-6a48-08d7c1dbe15d
x-ms-traffictypediagnostic: VE1PR10MB3022:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR10MB302227B537DDE67BF123340FA2E30@VE1PR10MB3022.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(376002)(396003)(136003)(346002)(366004)(199004)(189003)(4326008)(478600001)(186003)(66574012)(26005)(7696005)(66556008)(66946007)(66476007)(8936002)(5660300002)(66446008)(9686003)(33656002)(64756008)(316002)(71200400001)(52536014)(8676002)(110136005)(76116006)(2906002)(55016002)(81166006)(81156014)(6506007)(7416002)(86362001)(54906003)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR10MB3022;H:VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /uwEILst024MpyqDp+4Aq9BSY40U4Hx4cDzfmXPqoW6poiIWJSAIIC01izDW95tm+vJnj18NsFvxlNxCyDh5YaKDiui4TVw7GXraOD13sMyG3mPMmtKW8sj9c0ePke7besmT1Ql3rmYlx32IceB77OmY5QOVS/WRedBr4Epaju7WSW0ES1xg9gVMOvzr12kmW+tpPr/8HBiDmwf5zKxGBXsMFXfndsbSmMk9eyXcdSU+i3CWhg2ca2FKrzEYJAnwGXZisA8WHUYxh38PEiAe/xynqwbmWcFDZkvczUxWYkhXtiBjuf2UTKq5l6d5+O3ua6NECkPXmNDyACPIputWwFjvS9R/LjJucUn9BnDG8OcCHzp+gcqKqMk4MIOeoF1+UNb/gPgj2vpYAD2kYyxpV6X09llWeTdqjvt8axuZVHEPEproqNWb4iunLL1qjrrU85Zz8hMqZptHdDJSfTTXp1PTt+n2zyV7VDdiE4ZLUhVkWCvXLxhZFoaTxw/4znKRh+kFhzv963liMHwh8Ga1YA==
x-ms-exchange-antispam-messagedata: lIbTYABJ/2k8DBJxq3lscEoGZa/F4NIOTotX30jLnIB2K2H6mUoKRPPyJ1w2woNwpyB9FVxZ91ItbRb4xY9aHZWnyPPLq+xCOvSGzkBZ2ari9TupasHztyEtzGHZNvPC36/M6K0PUEjjEctK7jE1jw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c754dd7-cbf9-4206-6a48-08d7c1dbe15d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 14:37:21.7999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syzBhCmHSzT43bbGa/vFOXC+GHlYR5fz9+m0SU5u48CmbKdqhFzJxJ06s9ozLi4lSTBu71YRxCdxrqycjbhN+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3022
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Friday, Mar 06, 2020 at 4:06 PM, Uwe Kleine-K=F6nig wrote
> On Fri, Mar 06, 2020 at 01:23:08AM +0900, Roy Im wrote:
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
> This cast is not needed. (Also it seems struct pwm_state::duty_cycle beco=
mes u64 soon, after this happens the cast even
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
> This usuage is strange (which might be because pwm_init_state() is strang=
e). I assume the goal here is to disable the PWM
> with the right polarity set, right? Ah, and initialize .period as this is=
n't touched later on. Hmm, no better idea, I guess we have to
> leave it as is for now.
>=20
> Can it be that the PWM is already on at probe time and it might be useful=
l to keep it running as is?

Yes, that's right. I think so too..
Although it may not be that the PWM is already on at probe time but it may =
be useful to ensure that it is off for something unexpected.
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
