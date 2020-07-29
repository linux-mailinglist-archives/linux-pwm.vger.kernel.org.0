Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF8F231FF6
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 16:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgG2OJz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 10:09:55 -0400
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:26464
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbgG2OJy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Jul 2020 10:09:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqLlknl7Qwv01G4+i0+cBlgp5H7Oya6LTSNd6gYCwPvO6LO17bTGh/rSLaK27q22iQyXbYOjdYLA3uaRvKPoaDBPDGD/b+aZdehzykf7OhrD3s4iR/syBIMNyTIR76Orc/YsvzvuEnyiNr2qB0ken12OQWBtLG0D3J8SH7FW82TsCs0iRTbPm7iakUvgmgXUdpGjP5mI2yOr2CTKi02edW21VGyc3GjQU6JOCKpqlRtCEc2JSDonO7s7W4/4QkvgWpv12+vNQsDyekKESn05HDjMnVFeZx2DVdSLrsukOvmI10RKQhFWzaJNIlImesCYQytklWrSfislmb8IBPYmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G65j+EBYQCCzqyYl7kO4Np4SGW4aogHYXQXPd3ks1bU=;
 b=BbZbk5KPsd0CXW2vE+BUkjJl1FYCMGXh5zSMFE7fmTblXU65Ip/nS1q9Lc89c7tkXrb9Jd0hqppzT4X8lTMQLV3/ab4O7EqjYjNF4ZvZ1ZQj/2lqBbcvKvjrU+kMGyre9lRmNoPOVKXXwsahfBhYi39Q29hu6rYuKibCWwx3XeA4R9f4183kSFCfkhDTjEkZgHKAbXOIs2xJgMHbbF+kMRsx2tVTih64Qeuk4fFeEqSrzsKWVLWJQjgLG+g7ml77Fj6yh6czCqL1gua2oVia0ipFjniu5e1ymfE/pzZ+pQc0snKr7Zr044hSqNGG+Dc9sjvXD1zBKgSncdUZ2SSBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G65j+EBYQCCzqyYl7kO4Np4SGW4aogHYXQXPd3ks1bU=;
 b=RiKXtwmdFPwIBu8ZNAZbmhUvKFRO2cMTXe6Bepix0lApJrvS6A0pmCrF757eEYPLd+fAYydb8F0xZ5ucGbeUcysGvfCjlBEMUixRj7PS63j5jxNOdryoBSaxdZ8vKyiFvov5ijotqFPgXtQEn1UvK8gbPLGOhIuwKwACBHYY+ik=
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e9::10)
 by DB6PR10MB1558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Wed, 29 Jul
 2020 14:09:48 +0000
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620]) by DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620%6]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 14:09:48 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
CC:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
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
        Roy Im <roy.im.opensource@diasemi.com>
Subject: RE: [PATCH v18 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH v18 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWZVgP/N9464pJ20GmrAtQIjgduqkeGogAgAAEX3A=
Date:   Wed, 29 Jul 2020 14:09:48 +0000
Message-ID: <DB8PR10MB3436EF37E1F1581BDB7996C785700@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
 <20200729063638.GY1665100@dtor-ws>
In-Reply-To: <20200729063638.GY1665100@dtor-ws>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d85adb6-389b-431d-3800-08d833c90e05
x-ms-traffictypediagnostic: DB6PR10MB1558:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR10MB1558F5B3D30EDF1314FD913AA2700@DB6PR10MB1558.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8Ev1Kf30HT20qWPgLCnRF+/zLxi63Q4oFLZQbaUSyS3G4sEf2ch+yWEAOCDMJUyQv73XlXaktTiMRzUrm372Wr+7e6+Nn4Vnsf6EQ4y11lE3NyRBHDi5PgjL/qQd47EM8wyLK4Ne6fAdM5onXfIb1Hy+n8xwvxpa3VubvIGe4FVH6yhT7F1fnXmLofe/W/qHRlsp9gdsISdSRF3o3A4bxBGhwxeXRP4TFRYrEbfeHH4Mq5wc3ccIJxL6yyKNAp97xpArjl+Zbph6dqgfekHAQzrJOAcFACIViULWIfgqvUQ3tXdoErPyDh6SzQTdNjn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(66946007)(66556008)(66446008)(64756008)(66476007)(5660300002)(478600001)(8676002)(52536014)(9686003)(86362001)(76116006)(55016002)(6506007)(107886003)(7696005)(110136005)(316002)(54906003)(4326008)(8936002)(26005)(71200400001)(83380400001)(2906002)(33656002)(7416002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: YPoQe8R+wkUfK76nAGObbFKOWqGrqIqh9sZ4Xlcq49LT55d/Ct/d4immJtQRWt7RvX2vMR145+E8a7bxibHgVB5BhP/I37jBMqevZ0FrMEmNJEUcOlAeDf5+ElYYBFXKIfn8AV4gKb8ai3nikQykH+A02KZIJXkyC8hsLuHQ5DBHuY2LU58LtxOgdayHMb4wed8XJ9Ytk+7aJ5VfD3VjvENxDJDf37LyVt+eZc8Un4Tv1q/TThsilKVEn8DnyLYqHZqFVhi+7n8kigxk4DEX5tZ+I3VOxBjwwgsAvvo3w/72AAv4QjCG2+rUX07wUYWPUgFWWwhin2/maX+UoaajJVvCkChKQi6PVoXcLuQ8AQIAr0JaAiOJTnhwRCvGDq4sSFyH6inJi499xYVyvx8nK4VD2lF8ru+bXANlK6TazEN9Xt+6uFkd/lY3aphNgx41R8beLqiGFXuYGqpLp7lFmpJtyOA2Oe7AvUFbsUzHP3U=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d85adb6-389b-431d-3800-08d833c90e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 14:09:48.8501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qu5Qw5UpKNEXPYFqBRcuhIs12Fzsz3eh52bkbQBv/Uj0tQbUitMC+BQZLYUPpMT5Hg9oOfrI2fdiV1UbdIdEwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1558
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Dmitry and Uwe,

Wednesday, July 29, 2020 3:37 PM, Dmitry Torokhov wrote:=20

> On Wed, Jul 29, 2020 at 11:59:40AM +0900, Roy Im wrote:
> > Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with multiple
> > mode and integrated waveform memory and wideband support.
> > It communicates via an I2C bus to the device.
>=20
> A few questions/suggestions...
>=20
> >
> > Reviewed-by: Jes Sorensen <Jes.Sorensen@gmail.com>.
> >
> > Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> >
> > ---
> > v18:
> > 	- Corrected comments in Kconfig
> > 	- Updated to preferred style for multi line comments in c file.
> > v17:
> > 	- fixed an issue.
> > v16:
> > 	- Corrected some code and updated description in Kconfig.
> > v15:
> > 	- Removed some defines and updated some comments.
> > v14:
> > 	- Updated pwm related code, alignments and comments.
> > v13:
> > 	- Updated some conditions in pwm function and alignments.
> > v12: No changes.
> > v11:
> > 	- Updated the pwm related code, comments and typo.
> > v10:
> > 	- Updated the pwm related function and added some comments.
> > v9:
> > 	- Removed the header file and put the definitions into the c file.
> > 	- Updated the pwm code and error logs with %pE
>=20
> I believe the %pE is to format an escaped buffer, you probably want to %p=
e (lowercase) to print errors. I am also not quite sure
> if we want to use it in cases when we have non-pointer error, or we shoul=
d stick with %d as most of the kernel does.

Right, it should be %pe as you and Uwe said, Uwe suggested %pe to understan=
d easier.. do you still prefer to stick with %d?

>=20
> ...
> > +
> > +/* DA7280_ACTUATOR3 (Address 0x0e) */
> > +#define DA7280_IMAX_MASK			(31 << 0)
>=20
> We have GENMASK(h,l) macro in include/linux/bits.h that could be used her=
e and in other mask definitions.

I will do.

>=20
> > +
> > +	bool legacy;
> > +	struct delayed_work work_duration;
> > +	struct work_struct work_playback;
> > +	struct work_struct work_setgain;
>=20
> How do we ensure that all these works do not clash with each other?
> As far as I can see we could have the "duration" work executing simultane=
ously with playback...

You are right, I will use use cancel_delayed_work_sync()/duration and cance=
l_work_sync()/playback before scheduling playback work. And same as for the=
 work_setgain. For setgain, there is no problem to run this regardless the =
playback.

>=20
> > +static int da7280_haptics_playback(struct input_dev *dev,
> > +				   int effect_id, int val)
> > +{
> > +	struct da7280_haptic *haptics =3D input_get_drvdata(dev);
> > +
> > +	if (!haptics->op_mode) {
> > +		dev_warn(haptics->dev,
> > +			 "Any effects are not uploaded yet\n");
>=20
> "No effects have been uploaded"?

Ok, let me update so.

>=20
> > +		return -EPERM;
>=20
> I'd say EINVAL.

OK

>=20
> > +static DEVICE_ATTR_RW(ps_seq_id);
> > +static DEVICE_ATTR_RW(ps_seq_loop);
> > +static DEVICE_ATTR_RW(gpi_seq_id0);
> > +static DEVICE_ATTR_RW(gpi_seq_id1);
> > +static DEVICE_ATTR_RW(gpi_seq_id2);
> > +static DEVICE_ATTR_WO(patterns);
>=20
> Should this be a binary attribute instead of having string parsing in the=
 kernel?

I have carefully reviewed my driver again with your comments, now the uploa=
d effect covers this attributes, so I would like to remove them and add som=
e code more for gpi_seq_idx update.

Thanks for your comments.

Kinds regards,
Roy
