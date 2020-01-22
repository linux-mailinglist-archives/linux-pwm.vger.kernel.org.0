Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A868144A9E
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2020 04:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAVD4U (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Jan 2020 22:56:20 -0500
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:41953
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbgAVD4U (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 21 Jan 2020 22:56:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyiUpm+flJb2m7Mo2/FiOhIEhFkHB0aUKXQK4wWHaFI0INN+FuHqBFT9fNX/TyW5N2lQwxBBVMYHdUOSlr0QXerOf7o0BLZMVVqKOSX29gSVZJc2LgSb1DI85LpvEF4WoQDkp87hJwAVGJsyOxD30+Dq4kkLnrB8YKfxdeirSIkKHm0I8H1jF19zgPwYVNj/Tjjtt8UA2e40ZDP+oygarnoT/SeVyKp4ka0hwmMHZD3fUXCjTAG4jKbjNhXi11kHhoUIX9gZr++ugeluxoaUIkE4bcSwj26W1ybr2hVmkKudP9n+c9Vyq4jQZX+3Xndclra6N7lts2PWp2klIUmtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvmTVnaHOZLFF3+Hhd0mHOulTd7Zyhr0jgKrHws6wPg=;
 b=KsGZujNTZDgBtpwmYm4AiBfhAYW91NT+Ol0GNsN/7FsdrvOnXY96jzz26wACgHnVPIJfjB9igAVly/lbVrbN653PeRFW3T5yLW7woaiJFs00Y1bd/L1wxseMlrpRlqxxC1bcWe8ZENEqjvhnvhkRemtCW1QMnsimFZhT8mpo/WAsiVP7sIU5PwMD59aAYdGSxUml5UGgRF0W11sTUYqeORrOJEr3MEPI0df3WzfTGICUyDuBQ3OGonfBGvIahBUjru4dX9WK3lv3dkMopabPiFhGgTcFOpxTHsR6OlwRORVesNvFV28E6VDCyQlkQadkLf4jmxh9eFOAzWgNlN3PXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvmTVnaHOZLFF3+Hhd0mHOulTd7Zyhr0jgKrHws6wPg=;
 b=SqdoMyAcN/QQ5scPfGzmhhrc2jAFsnvJt1HpmGPOy5lNq4JrIntdf3rxgT7rhW+iEDa6uy16J0aAkpRYZsInSzuurhkKYqIHdYWrgcQjmM6VuzvPDjVbf3KbhLqdUFB9HKFDJK/N91qaryFwMOTBj+1egV10v7c1Sdnb5vJdJyw=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4384.namprd08.prod.outlook.com (52.135.73.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Wed, 22 Jan 2020 03:56:15 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2644.026; Wed, 22 Jan 2020
 03:56:15 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0501CA0075.namprd05.prod.outlook.com (2603:10b6:803:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.10 via Frontend Transport; Wed, 22 Jan 2020 03:56:13 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Topic: [PATCH v4 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Index: AQHVzN7ZeNwr91HvDUacFRX9W6PqAqfud1qAgAQwWwCAAIS9gIAC6ZEA
Date:   Wed, 22 Jan 2020 03:56:14 +0000
Message-ID: <20200122035608.GA1455@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-5-git-send-email-jeff@labundy.com>
 <20200117073427.ufrduwagvppeasgr@pengutronix.de>
 <20200119233234.GB28865@labundy.com>
 <20200120072739.sixr5e76uckrugvu@pengutronix.de>
In-Reply-To: <20200120072739.sixr5e76uckrugvu@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0075.namprd05.prod.outlook.com
 (2603:10b6:803:22::13) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 863d51db-90a7-4b50-ab49-08d79eef06d0
x-ms-traffictypediagnostic: SN6PR08MB4384:
x-microsoft-antispam-prvs: <SN6PR08MB43849D216E7DEC8312831F32D30C0@SN6PR08MB4384.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39830400003)(136003)(366004)(396003)(199004)(189003)(36756003)(966005)(66556008)(66446008)(508600001)(956004)(66946007)(5660300002)(33656002)(64756008)(66476007)(2616005)(7696005)(52116002)(8886007)(26005)(186003)(16526019)(54906003)(4326008)(81156014)(8936002)(8676002)(1076003)(81166006)(7416002)(66574012)(316002)(86362001)(71200400001)(55016002)(6916009)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4384;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: heZbGjfOZIoSOXspwt+wmhiAxhMPumaot3vJJl/d6FQj5uQzgnSGW6LdV6JZcaOo1UtNNPdSiMimKKdl8zf0vOHf3nymPFqKIBKIbpRQUsIyKu9LvCR7yL7fsKOpnA7xcVEcnegZTZqKAaMxXJibppUfRR/eo+Lbd2sBFYd5iODLRXirB34SEwyoLk/rCGQdGrZk4LfnSfJjJggF/tp1RuDC3ZrVedexmk4/+GXiJR+PMGoFGtno+4nwgCOQZH7aY/bUg0fXooXqAh9GTzacsivAbxLnSbSquGX3BoOtHcKYxUj/g+NEeyvtNI2W9zM7+fPRaaJHv2M4rsWAITPD9OUc2WXEi1ZhwvtmvmTVEvbJw7qT5zYEPes8gXqSuIo2fUx+DkREvf27Mr1jgWIGVaaEuEkqKADbuMUxGamu30UBN+wBinrPLiXuIfy0Ay8251kaLOTqB0aqYSnL571o/1P88rJdfwYRpH0F+V3zVIc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6BD2F8EB27C13248B19AE6EAD595CEA2@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863d51db-90a7-4b50-ab49-08d79eef06d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 03:56:14.9713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gXslqvsZjQxbH5F0RwVfGBi7mWpiFfLSXE9TEHYz3/0Ez04bmhnkMz9nTMC2KwQx9HkRzec2HlXfnmXanAr+WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4384
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> > However, you bring up a really interesting point about preserving what =
may
> > have been done by the bootloader. The device holds itself in POR until =
its
> > supply reaches a sufficient level, so there isn't necessarily a functio=
nal
> > reason to manually issue a soft reset from the parent MFD driver.
> >=20
> > I could get rid of the manual soft reset, and then simply sync both out=
_en
> > and duty_val in iqs620_pwm_probe which would allow iqs620_pwm_get_state=
 to
> > pick up any changes made by the bootloader prior to the kernel coming u=
p.
>=20
> That sounds good. This way the PWM driver is independent of the MFD
> driver and does the right thing no matter if parent resets the chip or
> not.

Agreed on all counts.

> =20
> > The only problem is that leds-pwm disables the pwm at start-up, so the =
end
> > result is the same anyway. Regardless of the behavior of any one consum=
er,
> > however, I'm slightly inclined to go with the second option as it seems=
 to
> > be less restrictive and more maintainable. Let me know if you disagree.
>=20
> With
>=20
> 	default-state =3D "keep";
>=20
> in your dt the LED shouldn't get disabled.

I see default-state defined as a common LED property, but leds-pwm doesn't
seem to use it unfortunately. Looking through its code, brightness is just
initialized to zero unconditionally.

This doesn't change what is the right thing to do, nor do I imagine it to
be a problem for typical use cases, just noting for completeness (however
if I am mistaken please let me know).

>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Kind regards,
Jeff LaBundy
