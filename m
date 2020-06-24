Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089BC2077B6
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2020 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404186AbgFXPj5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 Jun 2020 11:39:57 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:12610
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404146AbgFXPj4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 24 Jun 2020 11:39:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X02CWtY53lPxxiJXAwxqEzxGECQMaqmn3w9fsav/adm1vWTtSRSXYyqQGFUiq3x7EZpb7b8495SFPN9RGsoBEe2YyXCskrKtt9zyamfa06V7uPUNL+p0dTLEgVBahYvxhAnqHbsvCWZ0mL2ZB/mv9Fi3mHpnttxCpIRqDyMKGPV6OMlyOJdoJc/ClgWWnsafN4ssfki7oWrDOP8jEtomL3mS3W36wgE2MBlbjrU3yEMeS0jgg5fz3Yr0+nB+Mz59gtfRZaIDszaGIbDbz6e8bpI9jQyio82uvdwFEyNm8O0PpRyX2gTURfUC2ynN9T0+epf4Y4cYSbu9xhDc11DB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwOZvlVsRWMJMgZT8h9H96L8M1l7MNIHx+OQX33OiBU=;
 b=mGAkdb5E2cbELW8goVcEZut+UFfOK4/+SLwf/UoytIj0aEKhk17qbawYGY3SjHu5tXR2zifoo7nUUXuRRgze0xgV3QhP3svqyG7DsdEblYfgCrCcbLoTg6suu/SQ2H6815WqM1BKsR6M3GymEvU08GTy2QlOTJPD6zVvKaKlpOT6Y0xmGbPnaXVE/3MrTunXZFQAl0ObLnVAtPdix95sApyEJ9WtzJzuX/60E2eKv6Tdu5AHK3VUljKJeMqE1aj8sAc5koD4OVWahBPShpqg/7QQvC3Vzcw+Q2NTcoGNWs28ciJW9FslyB9R22JgVf2WqgjfXiLeOjImN1EyUSTPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwOZvlVsRWMJMgZT8h9H96L8M1l7MNIHx+OQX33OiBU=;
 b=DoeXFyVcMpmTPoRHsZW3Mo1qCxTwf4FHm8YbMv5YqlZTm+boqgpSROQUEZDSZTws4MgOiiZgAvRlDQH4/9dg2RnzYvB7Xgif8CrFnOq2LQ9W6XZPSctf/aulmh6zeb10ZwJ4E1PchqwAK205G1ECZR/pgD+FK8fHQeU2hyrlzi8=
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11c::13)
 by DB8PR10MB3626.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 15:39:52 +0000
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56]) by DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56%8]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 15:39:52 +0000
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
Subject: RE: [RESEND PATCH V13 3/3] Input: new da7280 haptic driver
Thread-Topic: [RESEND PATCH V13 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWQwzBfFR7uhdm1kyQ3q9kXzA/B6jmUoyAgAFmjgCAABn+AIAAEtIA
Date:   Wed, 24 Jun 2020 15:39:52 +0000
Message-ID: <DB8PR10MB3356AFC38358881B471E76A285950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1592221223.git.Roy.Im@diasemi.com>
 <135761fd309eb9424faeb631b6e6c66147b57666.1592221223.git.Roy.Im@diasemi.com>
 <20200623144105.mxhcrtezbghjb2vb@taurus.defre.kleine-koenig.org>
 <DB8PR10MB3356697B41C0FB97F5FD330185950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
 <20200624133726.en7q52rpdtzvhajz@taurus.defre.kleine-koenig.org>
In-Reply-To: <20200624133726.en7q52rpdtzvhajz@taurus.defre.kleine-koenig.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e726fa5f-5a11-44ba-4e60-08d81854d654
x-ms-traffictypediagnostic: DB8PR10MB3626:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB36265FCABFBB530A8B509AEEA2950@DB8PR10MB3626.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /mQc4HiAK0xXsTp9qrVaB1514kVnjD8WezgkNQfUG3OGqpMEP8Wq1o6msyrMw5tGvom6nx/60jh23Pxl2vbWvbzw2qn9LesEdx9Pt53BHx3hw3KIHzRUYthMdzAENMI2M4oXdsl5PR8wUWvY520q0ZwpYsFZjHn2hvyXsCpwt4rN6BJ5TcP3u/gZCIEoLLhFUcwRN4BWdXxy4slFanBKtSaeDc8T2nQKb0urlCf9d31rzFf+zx4R/PV4sFsTN8Laj02pr0zeqmqCrhMcdfUpAkMTGVWwcNtcEURwHwMaBD3AAMDCIyBCUWIHo+MyZQbl5w2s6vuj7gUqDHkP/pIgFUiRtrc/WXIoAr9BJiZhKdVBLvPciA+5yp6v4ezeNUh2Fz2cuJK8+HviuZM45goy9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(83380400001)(316002)(966005)(54906003)(26005)(186003)(4326008)(110136005)(2906002)(478600001)(9686003)(64756008)(66946007)(66556008)(66446008)(66476007)(52536014)(76116006)(53546011)(6506007)(33656002)(8936002)(71200400001)(55016002)(86362001)(5660300002)(7696005)(66574015)(83080400001)(8676002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JKXhtqKgV0FB9vcm6fwLFh5J9D6Re18R/vSyHUrQPou695Ipi3ccZPUKvumzXzRD9tNpXTC/PoG10vkG2ItJeAWioxqTNPW3+iJ4V50hM5+hlsrJeNVGi3QBOi2AP/w3xigUhH7oVhi9JWY2F/Xp6X0HofvFQiEBRalHnv3uq4A4DwDn7yf2sSdZ/9WJ5hAEDcOIJLOzps1GhY5zElnOdQp1Q3UztiLa6cmrF1oc8T26+5FOkI2Y7PQG9vZLjEhfzHz39H4LKc6+sliVSgHeL/8HGg4mAe1ibvaMem9MXpftilfesLX/ctgw7qtmTB3yFzwTVfdSv49ZAHwBngn2QFEbnAR+IHfc5Zw7dRG51J5/qUtI1KvgywvfjIKhL1xHTbsxNXizBGLKtXdO9N6rxfQH0KIaa1CzeqFuh1nv4DM+WBgkTS+PXolIaoDLMaXwn+eTNa7sZcqMF+oqtmWb6DBkBHUkfjhFEvzhhrtBCok=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e726fa5f-5a11-44ba-4e60-08d81854d654
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 15:39:52.3730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVRTZYjq0CpYk3oAvRKIJbXqkyUwTuOrjVjzsDii6MNhZHJ8OECM/p7VaSQFat1rGmDALVt+CJU6M5IPaPhMeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3626
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jun 24, 2020 at 10:37 PM, Uwe Kleine-K=F6nig wrote:
> On Wed, Jun 24, 2020 at 12:04:24PM +0900, Roy Im wrote:
> > Hello Uwe,
> >
> > On Tue, June 23, 2020 11:41 PM, Uwe Kleine-K=F6nig wrote:
> > >
> > > Hello,
> > >
> > > On Mon, Jun 15, 2020 at 08:40:23PM +0900, Roy Im wrote:
> > > > Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> > > > multiple mode and integrated waveform memory and wideband support.
> > > > It communicates via an I2C bus to the device.
> > > >
> > > > Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> > > >
> > > > +		period2freq =3D 1000000 / state.period;
> > > > +		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > > > +		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > > > +			dev_err(dev, "Not supported PWM frequency(%d)\n",
> > > > +				period2freq);
> > >
> > > Doesn't the compiler warn here about period2freq being unsigned and %=
d being for signed int values?
> > >
> > > For my (non-native) English ear s/Not supported/Unsupported/ sounds
> > > better. Also my eyes would be pleases by a space before the opening b=
race.
> >
> > I didn't see any warning message, but I will change/improve them to pro=
per one and the log as below.
> >
> > 		period2freq =3D 1000000 / state.period;
> > 		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > 		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > 			dev_err(dev, "Unsupported PWM frequency (%u)\n",
> > 				period2freq);
> > 			return -EINVAL;
> > 		}
> > If you look ok, let me update this so.
>=20
> looks fine.
>=20
> Note that you don't need the division if you check for:
>=20
> 	if (state.period > 100000 || state.period < 4000) {
> 		...
>=20
> (maybe the compiler is already clever enough to get rid of the division f=
or you, but then the check is:
>=20
> 	if (state.period > 100000 || state.period < 3985) {
>=20
> because of rounding errors.)

OK, you are right, that will be better. So let me change that as below if y=
ou look fine.
	/* Check PWM period, PWM freq =3D 1000000 / state.period.
	 * The valid PWM freq range: 10k ~ 250kHz.
	 */
	if (state.period > 100000 || state.period < 3985) {
		dev_err(dev, "Unsupported PWM period (%u)\n",
			state.period);
		return -EINVAL;
	}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
