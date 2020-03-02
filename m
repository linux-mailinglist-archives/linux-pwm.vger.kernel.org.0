Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D36F175658
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Mar 2020 09:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCBI6P (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Mar 2020 03:58:15 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:56863 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgCBI6P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Mar 2020 03:58:15 -0500
Received: from [100.113.1.43] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id D9/83-54715-3AACC5E5; Mon, 02 Mar 2020 08:58:11 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUwTZxzHeXrX3uHodhQJzwiIKaibo13rWLz
  FLXFm6C1q9o4Jou6ASqulQFti2dRVeRkCgmaiUN4RmRSICDoBYY4SLG+TKfLihLFJiUBTjApu
  iGW746rb/nny+f6+v3zvm8vz4IioDPPFFQa9Qquh1WLBMlT5pjBEcrY7YrcscxYhZ4u6UbK9f
  BKQyWcvCMixuQ5A3nn0hE/2NxcKyNFRMyDnni1g5LcXC/hkToGdT870TmDk3y2NGNmTyScb6n
  MRcr65GCXvnvwObCSoB8OpGNVkGsWoevMxATUy2CKgZm7cwKjirk+oa0U1GHVu2IvKccqoib9
  aEepx/QqqN82BfuwRzldpIuMMX/KVTYVWNP77lwy30x2YEdTjGWAZDohzCLQ+ruFx4joKa0t/
  AJxoAHDh+LyAFSjRicCs9PNLQkTk8OBVRzWfE78BWH3zKJIB3HEBEQzv5V/gsbycSID2kT6UX
  UKI63zYd+QunzW8iA0wr/SOa+ldWHLFhnG8A45dnAYso0QQvDQ+sRQqJHbBvlETyrKIaEVget
  unLLsT78H2y81MDs6U9YcDg37sGCF84K+2kqV4SBCwoqUP4dgbTo0vLlUAxB5onC50zYPhz0M
  2wHEA7E9bwDj2h7dKMl3z7XA6/ZSL18IzTqOLSViRmYqyFSBTedGSxI3VMH1gyrWyGg486kA5
  9oMPp3IEHF9GYfng+yeAzPSf1hxL4XDuKQHHb8DKMjtiWvoRnrAr34aWAtQM3onUqmKU+lhap
  ZbIZTKJXP6WhDnXrZfSX0loqSJREqXQ6LU040rpAzqpLik2Sh0t1Sj09YC5rdEJbt80gobaB1
  ILeBXnib2F1uaI3aKXI+Oik5S0TrlHm6hW6CzAD8fFUGjpZDxPrSJGYdirUjN3/rkNcQ/xcmF
  aB2MLdfF0rE4Vw1ndQIKfmCoqR0SoJk6j8PURVnUxSwS7pEzUvIh4/nJuAX9fLyFwc3MTecQr
  tLEq/f/9aeCDA7GXsJlN8VBp9C++NM2U4DElsu7vZEvo6X8tXyMPkYdW0S2GsIKmQ3l1fMel3
  2Mz7DdDf5Lt3VZemKKcTAqGxZvjV8622oJCCsK3NgydDlvVFnQ8EQseqQgMjchwC7y/4t5HvT
  /O1WZbsw/3lJh1grnsceOmEI1knyMqddL8RHD+9sPX6o4N9kiuNilW1769jWc5uvnggf0HtxQ
  EDA+E619/Jb9ywHPNvIkYy+n8YleWrDd1/VNHXm7Qyis7QE21M9n9UAiv32NDu+7DjYfDEkwf
  LFq/Tvm8MSPZSg0tVj8rc9rBmcBNKW1PA6osv+D7yX1e17ZTudHGrlBvx5TCIf9zXe/pulUoV
  ddT6bRt/cNgtq9x9n1Wmik8MrNz5mStGNUpaflaRKuj/wE41IyftAQAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-34.tower-223.messagelabs.com!1583139490!345502!1
X-Originating-IP: [104.47.13.52]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31501 invoked from network); 2 Mar 2020 08:58:10 -0000
Received: from mail-he1eur04lp2052.outbound.protection.outlook.com (HELO EUR04-HE1-obe.outbound.protection.outlook.com) (104.47.13.52)
  by server-34.tower-223.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Mar 2020 08:58:10 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTDsmsMh8EokX4WZBKi4nX6YDaet4A/pnZeZQW405IBwMBV0JcfeEtCUE+KR7ZNrEyQV4coJDmQ5U0foPx3AL8UMWsSfzTYFlxdInPYpCP/6cn289BMkk1nOtCXtjtvvGdOI/qSAyRknsQm3duBvI1WkFm60rykkdzPcCqucHsnbY+TQgiu1GGrpIzS2yLy/4/+OF+3OaS2Nt4Qyb3Q8rTYp47CLsI84yBvlgLxBHr025SfWRZJDODQzK9glk9KvRrJVhLRICMWRcwopxB3hamHJtXUlbE945WGphebkvop5Y9o3e6ovTWO0JoXpuJsPIDFCjU+wmV8/91zpfp7Irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRG7d6pFK/mbHya4nAo9/W5/zvrkZNLXINHFOuuqxRM=;
 b=T9c57IY/ih22K8azy7sV7Ya6HaRZRDy3ePbWY4Ab3VfriD+fQ3OBD7QyEc4aBNmIu0NJdeAzTKkiDm9NJzj/w7E6T+hDE37kwTbk2FPG+Ho2b0EeyDvsS+iuyij71LjbexMSxL4qVlz/ZFgBQV/oxl4EgctBpix4sLSYDmtuULIt+gcuRxa/IYiPtulSsY4UXgFq2O3jXSRae8w5nMMd/QCFRpCI+0cq5CX+Ry0Hn76ozQsVIAcl7tYub75SJU0EmMTcP7KmM2E2mz8uXROV1204MCtOBbNBZ6fMK03TsbysJ7x1/6lf0cbhF+W5J6nO2+UxYlrrtkB/L58AgtKNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRG7d6pFK/mbHya4nAo9/W5/zvrkZNLXINHFOuuqxRM=;
 b=oRF3NTo277PSMpBzKwbgWBjMQKm0hkjHlRQ1pawvubd0/WfgbXUcNy7TqgdTitSBpeOTJVL3xcc75w9SOHs4/1S+BD6IWQkJPvpjePBjEH5yr3Ar+fskdXj2LKc0I+f6kG+FJa4H+RhKgTG8olWObjlo2Gdyv/6oIiesN2lSC2w=
Received: from VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM (20.179.30.210) by
 VE1PR10MB3392.EURPRD10.PROD.OUTLOOK.COM (10.255.158.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Mon, 2 Mar 2020 08:58:06 +0000
Received: from VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::502e:bd5d:4232:4034]) by VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::502e:bd5d:4232:4034%3]) with mapi id 15.20.2750.027; Mon, 2 Mar 2020
 08:58:06 +0000
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
Thread-Index: AQHV6JB2B7xCrQY5cUWkQsJbkeg5B6gtriKAgAO3rwCAAueAgIAATAUAgABRboCAACTdYA==
Date:   Mon, 2 Mar 2020 08:58:05 +0000
Message-ID: <VE1PR10MB308535974F97C56B27172A2585E70@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1582270025.git.Roy.Im@diasemi.com>
 <1569958274d409298695cf86184c7b67aaf19bef.1582270025.git.Roy.Im@diasemi.com>
 <20200226161307.6tv5q2yh62cp7vk6@pengutronix.de>
 <VE1PR10MB30859CB04A6F9DB58D921F7485E90@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
 <20200301212025.lw4f6uv453oulu22@pengutronix.de>
 <VE1PR10MB30856D67BB5ED36BED574FBF85E70@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
 <20200302064357.ke57i2wchulph5f7@pengutronix.de>
In-Reply-To: <20200302064357.ke57i2wchulph5f7@pengutronix.de>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95c43891-d7d9-4803-91f1-08d7be87d2a7
x-ms-traffictypediagnostic: VE1PR10MB3392:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR10MB3392FDFD9135C97229D125EBA2E70@VE1PR10MB3392.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(189003)(199004)(55016002)(8936002)(9686003)(5660300002)(7416002)(81156014)(81166006)(66476007)(66946007)(8676002)(66556008)(64756008)(86362001)(66574012)(76116006)(4326008)(33656002)(66446008)(71200400001)(6506007)(53546011)(7696005)(316002)(54906003)(26005)(110136005)(186003)(966005)(52536014)(478600001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR10MB3392;H:VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5l8Cd5dEKL8J0rff1xAahKopulmahOA44U8IRb43RlronUvexf7kqeWL8tzM/vpQqdn3UcXuPz2xbtoCqG8EQESBZXR08qS0SwmrWS5cIgv3u/6OJYA1E41RHxt8RfEk34Bj20R7R2yPujWqIlApOq3GHky4Jm9Cl3aDa6MB/zN081ajxLl+ka19JGzWveaU9gZrZEQEH8im7qWB8bt94BAZi67qzxVb5peI5zJjmV8SEpge4rJja4mfgetYfsckJIvYd8Ww88kic+1htneqMpFM2r78oXwDZo8t77AX5hyRHsiGg+PWYvkTaGJormNeCKMqywTh3DetlaJa6HlGvDjzLach9npanh7hynkTppUmtgaTSfdMlr52ftcfl+lL+U/A+AIvySqEGp8XXSsiDQ/8xXuN/hlMDATmAvZ6hiOJdNrsOFBvj0bFB2sKgeV/o+l0LJD3AGOg3hTVsBnCGOyas/0YnBKmPptjXGScc+Hyrn+ztFdq4IFcc0kSwozNEFZu2OtCd7ej1SNW0KuO/g==
x-ms-exchange-antispam-messagedata: D6QHWVHsUKatsXbfUB3NL+6bqV2DD9ku6d9vOihnwsiOYWUEQyBRUvZF1m7BdUOj4aDNBi0pnuQI4HI0cHFKibFw2pSH6UpxaiLk0pNmHPvoWQF4lt5G/LcmLYcke4HHp8rmwM7YZFlZs7OwdV3tow==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c43891-d7d9-4803-91f1-08d7be87d2a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 08:58:05.8455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2VGbWiPua3SQU7jU9B+8VxAqKQBMVRObGUrHAnEeaF/YAl0s4SHYaJdwFn54760h5rr7MAutH02Deq7Ef9cgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3392
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Monday, March 2, 2020 3:44 PM, Uwe Kleine-K=F6nig Wrote:
> On Mon, Mar 02, 2020 at 01:52:30AM +0000, Roy Im wrote:
> > On Monday, March 2, 2020 6:20 AM, Uwe Kleine-K=F6nig wrote:
> > > On Sat, Feb 29, 2020 at 12:59:20AM +0000, Roy Im wrote:
> > > > Okay, thanks. I have tried to update that as below.
> > > > Could I get your comment if you still see anything on this?
> > > >
> > > > 	/* Maximum gain is 0x7fff for PWM mode */
> > > > 	#define MAX_MAGNITUDE_SHIFT		15
> > > >        [...]
> > > > 	period_mag_multi >>=3D MAX_MAGNITUDE_SHIFT;
> > > >
> > > > 	/* The interpretation of duty cycle depends on the acc_en,
> > > > 	* it should be from 50% to 100% for acc_en =3D 0.
> > > > 	* See datasheet 'PWM mode' section for more details.
> > > > 	*/
> > > > 	if (!haptics->acc_en) {
> > > > 		period_mag_multi +=3D state.period;
> > > > 		period_mag_multi /=3D 2;
> > > > 	}
> > >
> > > Much better. Extra points if you add a link to the datasheet at the
> > > top of the driver. I didn't look at the datasheet and assume that the=
 reasoning is obvious then.
> >
> > Okay, then do you think it would be better to remove that comment(the 3=
rd line - datasheet)?.
>=20
> No, please keep the reference.

Okay, I will do.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Thanks.

Kind regards,
Roy
