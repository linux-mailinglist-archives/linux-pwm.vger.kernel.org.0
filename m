Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBD420B24F
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2020 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgFZNRe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Jun 2020 09:17:34 -0400
Received: from mail-am6eur05on2042.outbound.protection.outlook.com ([40.107.22.42]:23516
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726165AbgFZNRe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 26 Jun 2020 09:17:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifLUtfEfvANhNE3QDcZss4MdtR4gN26k5SnsH8cTRVjsqtp0SgnLy7AdyveDnRFqRxsGqvBlmk1nv9TPvYkL7sDjHeIwZNRbnlUKEQsXahlBff92Z/epNdprQlsB1RgkDk1FHD53HrnsRQB8gbnKryPuu/cSiQoOf+TA/rR24ctIXtjkikxNiMH7OCshnBVAJVnKgLmPZ8Rj+9jLNqyy5CV77Wq+BOb8FmpyZ3ZvnEBt4xzcVxePO2oy/ZrWeyRL2PabVfBCSa+jnks3jnd89pkXm/QG/rmum9RubTE/r+yfgv14MNpGu2PIljYCXS0zSzbrBwOclOfCbK7Gv+saig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m91G/Uj7AF9QPGjx6bWwCjYQjMFr+H+2xJzI8REW+WQ=;
 b=UwsS7SvHqllF3KHPpfK+6dLh/4AyMh5uAhxbYyNemSTujVWKoc8Wu2Y9vicfB3iBzAAPN6VKWhBk0tYgAQ2rYLg/arq8jPftGzwdWXS/j+y+84wlho9ZVaaduMWXom/ZF4L/VFlV17cAh2Hrz6OqkxVH3DpyzobLxsy2oZ+dMBh0aGY8+wzNvtEhnjhkjTh8HtYY8COWisLbdKmufQhh8Km1gWMIaiEoeEi4W7W0EDv1JiEjvolXydZuGDyPyryfY+8Y4GyHUusurZwIC6WOQsEGUgRV/t0ORFzI5WlbLid5frIA3czC4BF1awzv8updqA/Zum2wRzLMvrPeSYdQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m91G/Uj7AF9QPGjx6bWwCjYQjMFr+H+2xJzI8REW+WQ=;
 b=MsXRrqqcqQXTi1Rv8ChdW3DFN0HVOt14N2G/Cxz18FLiXdjUf2HSCipHO81JTiuFQK+KogGSQYUhJMhywn73m92g5tNugLs/A7sPuUQDTnA9NhbEix+S2sZYkqjWlLEm0t9W1gJZq3VgUvwPYoNtp5gVvWrq5Cp5zNQaR/Zh3zk=
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11c::13)
 by DB8PR10MB3226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 13:17:29 +0000
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56]) by DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56%8]) with mapi id 15.20.3131.023; Fri, 26 Jun 2020
 13:17:29 +0000
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
Subject: RE: [PATCH v14 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH v14 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWSttjHK/j6/E1ykmZ1XiOSN6cvKjqbZ2AgAAQPeA=
Date:   Fri, 26 Jun 2020 13:17:29 +0000
Message-ID: <DB8PR10MB33563278561DFC2E50420F1C85930@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1593017969.git.Roy.Im@diasemi.com>
 <8b05f5bd46eac415c628e965f59b2b57aff86bbe.1593017969.git.Roy.Im@diasemi.com>
 <20200626061853.hyb7dwta6ths2qo2@taurus.defre.kleine-koenig.org>
In-Reply-To: <20200626061853.hyb7dwta6ths2qo2@taurus.defre.kleine-koenig.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.240.7.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aff4573b-bf9d-4dff-7aab-08d819d34727
x-ms-traffictypediagnostic: DB8PR10MB3226:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB32262F35CA9DCA1120BE670CA2930@DB8PR10MB3226.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OQaOdM/e7CbPHZjZ7Q6YEUI3advqMlflSZAtY8P8CO/tlUBCjtfPdmsLvskabxpROprMVGaRBfXa2Hit7p6yXcWOenUW+RYX8kmqfZG+BqIye4CfbCltBXUUaw1ih7D3hWEQBgp0nlXV30/O7tfMFQjrYBY0xlBVRr6763S3/fxr2TFt7bTRHzQbJUGqtjWxBLyUsYvlHaq4/889so8iMtTuEmHa8NejGmqq4zXzalKxGmJCfVpDUjB0DUhFQL53pdITzDAqSDE0u3uItbcpTrFSndqt3Y4mrhnv6OozdbhCB+XVCf3IQukBOAY0flu/UzpFGOmAfV1VwJ9r8Oo4kzU96ft1G/BTKbQN/zOxVI651UmHTJJUzAfplyof/LlxYXfLU100FkG64kYCfClYKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(366004)(39850400004)(376002)(5660300002)(478600001)(64756008)(66446008)(66476007)(110136005)(8676002)(83080400001)(54906003)(52536014)(33656002)(9686003)(7696005)(83380400001)(2906002)(55016002)(26005)(4326008)(7416002)(966005)(76116006)(186003)(66574015)(71200400001)(66556008)(66946007)(86362001)(316002)(53546011)(6506007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WzR/mbyQv8reNzj30JJXyDuFCujCiYYSJ0ukItwk71eknRPXFzrKsxVoLlCo5H3Xxi/Qi7pjVqG9okrc0eHYfglbe7Pw8ReJdPhM3CMQbr8K/3H7DvLo31DwUvC7f1YNP1O601L/WbmQ5PvURGQwwx1eDVgvqeq8H4U3RizId7yvQAO+rS4BhvyYaRHDrcujWNerv7M3kEh80sLHNHaZ5w9526KssEim4FpzONttS4wY0PNuB7KIn700PyECo9u1+FfZzmu9aIfPIwCRFnpp01WCjL+kjOay0xaeirAkgCcQ7/2aEwezekfoJZ7+kk7BIZ8HDS6cDMyqmko6M6FEoha/dXT2ZtuW0ZqVzhO0g0BWQfxHQRmYTebbonc4j2Xv37BQqyZia1fO0o+4uyAYmuA4g3BdA21/Fadmzi4KMhOJXpsuUr92GT1FIVLvw/Zit/HPTjCyXAFpjc/GDdFdPU8kFSKDsxN9q5ykKfHvttY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aff4573b-bf9d-4dff-7aab-08d819d34727
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 13:17:29.3995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qa/1PsZBadEVpOnrUbxOw6dOrUm/et+HLFJl2vGGeHc9bEloPfJqklftrausJdCVQpOZov4wGWau8C1A4ElwpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3226
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> On Fri, June 26, 2020 3:19 PM, Uwe Kleine-K=F6nig wrote:
> Hello,
> from the PWM POV I'm happy now. Just a few minor comments that I noticed =
while checking the PWM details.

Many thanks for your comments.

>=20
> On Thu, Jun 25, 2020 at 01:59:29AM +0900, Roy Im wrote:
> > +		val =3D haptics->ps_seq_id << DA7280_PS_SEQ_ID_SHIFT |
> > +			haptics->ps_seq_loop << DA7280_PS_SEQ_LOOP_SHIFT;
>=20
> If you write this as:
>=20
> 	val =3D FIELD_PREP(DA7280_PS_SEQ_ID_MASK, haptics->ps_seq_id) |
> 		FIELD_PREP(DA7280_PS_SEQ_LOOP_MASK, haptics->ps_seq_loop);
>=20
> you get some additional checks for free and can drop all defines for ..._=
SHIFT .

It is not difficult to update that as you advise, but I think having the sh=
ift there explicitly makes it more readable, so most of the drivers from my=
 team have the defines(shift) up to now. I guess this is a kind of subjecti=
ve thing.=20
Do you think it is still necessary? Then I will update as you said.

>=20
> > +static u8 da7280_haptic_of_gpi_pol_str(struct device *dev,
> > +				       const char *str)
> > +{
> > +	if (!strcmp(str, "Rising-edge"))
> > +		return 0;
> > +	else if (!strcmp(str, "Falling-edge"))
> > +		return 1;
> > +	else if (!strcmp(str, "Both-edge"))
> > +		return 2;
> > +
> > +	dev_warn(dev, "Invalid string - set to default\n");
>=20
> Maybe mention "Rising-edge" being the default?

OK, I will change them to be clear.

>=20
> > +	return 0;
> > +}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
