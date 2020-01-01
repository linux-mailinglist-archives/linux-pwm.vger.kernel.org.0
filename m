Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71412E0D3
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jan 2020 23:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgAAWjl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Jan 2020 17:39:41 -0500
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com ([40.107.223.63]:15904
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727312AbgAAWjl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 1 Jan 2020 17:39:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M973YnASEB8mDyZurW66vhEC3GqM+y2HNKi+NMkBXN4EOSv8Fw90ROES0L+Npm7OjS+mxaLW5WTBChx3foB10mq9OH85XlDGKhyFOjHOfx5kcRqlRN1xO9Acz9VzPYIZQA6n/rB+YRYhJkFDFd5gNc9AQw/Y1iQisEoRZOQhTl3bonNgXerL7V0iXZk2IeS8Gbtw0hT+ZKREiwueE0dJF3uJ8isXIttre6uvDIxsxsPwU7GiMMU/R5OkM1lkoiR37yC1aX67fSH4rfPY3wGq4YrC7+zV8Q0tJ6kszXGTrPtAEk47A6NWCqqeqoHncr9lpSCH9ld7PkqyPK4kvTqkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0peHFhz4JsdRgZ001sffVjHiDQF1CukSGMEkAPuJHc=;
 b=P3iVsc0MDlmDqlvIZ9UeUjHEXLeqaZDihKcK8oS3nIAusmBSqFNN4O7aP/g6myYmqmrX8Mrb5L0QWW/G2UgAhrsS1+ms5oqNwqv3mcs/TyQedtfytVoX7kspL5LYSz289CvSuodt+owETFPA2G8rVpp7j8HNbwMMnCkCO2IEptKPBWxmtPaxPFZmD6XndQtPVFeVy1pbSS21Ohd9AcadfVpD8WopgmXrgvRXylM7QkMdV3+vhMhYCqjMdv18ZgzzeYcR2D4e9pLSBZsT4AI6x4kPX2pY3yj1SRjN6kwHPODVqw7e327qwDz0IyG3mP5PfKElB4DgWNk37//7jnzOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0peHFhz4JsdRgZ001sffVjHiDQF1CukSGMEkAPuJHc=;
 b=CG+My5AA55qI+WP7igu1Ybgy7A03CMlEV7TJvyjPzHLAGyXOFN0AClDTOQOqg0zkkj6zboCeWeMiigETmslQ5qGI/5He7DssshN+Sm122YxlroNzCj8c3tqF8cIngncrc277vXYNkOH3tCLYdPcCzWtOIabzKCabEfLN3WZVbyo=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB3967.namprd08.prod.outlook.com (52.132.123.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Wed, 1 Jan 2020 22:39:36 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2581.007; Wed, 1 Jan 2020
 22:39:36 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0701CA0017.namprd07.prod.outlook.com (2603:10b6:803:28::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12 via Frontend Transport; Wed, 1 Jan 2020 22:39:35 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Topic: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Index: AQHVrij+8yO8xEtV+ECzt9/U9i+G6qexaTEAgAEU0QCAAHrSgIAIuWeAgADVNACABeTNAIAAXxsAgAE1m4CAAsXugIAPxXqA
Date:   Wed, 1 Jan 2020 22:39:36 +0000
Message-ID: <20200101223933.GB14339@labundy.com>
References: <1575851866-18919-5-git-send-email-jeff@labundy.com>
 <20191209073206.6pftsak5v25jdepz@pengutronix.de>
 <20191210000252.GA6361@labundy.com>
 <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
 <20191215203607.GA31390@labundy.com>
 <20191216091912.r4onikojbkbmguag@pengutronix.de>
 <20191220031924.GA2658@labundy.com>
 <20191220085948.iagsdpjqd6ixdo7j@pengutronix.de>
 <20191221032755.GA3051@labundy.com>
 <20191222214851.kapsro6b6qylke43@pengutronix.de>
In-Reply-To: <20191222214851.kapsro6b6qylke43@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0017.namprd07.prod.outlook.com
 (2603:10b6:803:28::27) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd9bca75-ca53-4206-f1a9-08d78f0b7a7a
x-ms-traffictypediagnostic: SN6PR08MB3967:
x-microsoft-antispam-prvs: <SN6PR08MB39677A8B95C0F9332F6A7330D3210@SN6PR08MB3967.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02698DF457
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(34096005)(376002)(366004)(136003)(396003)(346002)(39830400003)(199004)(189003)(55674003)(1076003)(81166006)(66574012)(36756003)(8886007)(33656002)(54906003)(966005)(4326008)(6916009)(316002)(55016002)(71200400001)(8676002)(5660300002)(8936002)(81156014)(508600001)(7416002)(66556008)(66446008)(66476007)(66946007)(64756008)(2906002)(2616005)(186003)(52116002)(86362001)(26005)(7696005)(16526019)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB3967;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lMZ6SoMFUffWNRzxYouXnauoD0zUKGZBcoxlkEH/u8qURWzihZWOp87VDRbmvN9dJ50TCkK+1QcPVhhhiitZQXmk5/HokxAvA8tFRVoLrimMwdiFSHdPfDn7StJ6drEA+ZvD8Khu549vECp0+7WVvn7s6jUqydG7PgMYfq3z1LLLlZNZQrKy9+KgJLqQRGxPoTnJp8G4RCe1o2/lmdpn2/HZ7xjo/9HvT6x8YPIRBOo/iuC/MFe/86xezKvZ04fwMeIIZSKgGgPB7wtrMlkccwHatxn8fP0uquC1X7SUpsVKfpfa8g+Xa/4fGEKBwKTHWiG4kktajPq6mdRpsqIwHYjhRg54GCkDgU+rq+ZmHPL+U/tDQw1oweHNAtZFs/b3nsXIDc2V57lMilN/tNVae7sKACZCeUdTmn82ptH8ERMzJaYPjmA0HP1kDiz2HjH05sZ+UWpzbLt3DTN1lDSIbCTyr4+Nov4EP2QS7Dcrbp/7PF+gwiHQ5ruCVhRiDHgZ0LWXRTKZUiQ6l5nVh3xKMHKpT6T9SZYHjFA3TzaaQK8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6A177FE230B3CD40AEB33128657FCEBC@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9bca75-ca53-4206-f1a9-08d78f0b7a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2020 22:39:36.1223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBkBGL+Upgi3Bc0fz3E+IOwOcjNfCWIgBYaj3zQg2PdFakp7MYKfEqq0XMsqGFuXxFMpwoEjNXWhhHYL4S4lUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB3967
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Sun, Dec 22, 2019 at 10:48:51PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Jeff,
>=20
> On Sat, Dec 21, 2019 at 03:28:01AM +0000, Jeff LaBundy wrote:
> > I heard back from the vendor today; they've acknowledged the limitation=
 and
> > are considering adding support for 0% in a future ROM spin. In the mean=
time,
> > they've agreed to describe the high-impedance behavior in the data shee=
t as
> > well as include the pull-down resistor in an example schematic.
>=20
> Oh wow, seems like a good vendor then. :-)
>=20
> > > > Option (3) seems like overkill for such a simple PWM, and ultimatel=
y doesn't
> > > > add any value because I don't want to allow option (1) behavior in =
any case.
> > > > Whether the PWM is disabled because it is truly disabled or to simu=
late a 0%
> > > > duty cycle as in option (2), the pull-down is ultimately required r=
egardless
> > > > of whether or not the data sheet happens to go into such detail.
> > >=20
> > > Actually I like option 3 best.
> > > =20
> >=20
> > Based on your other feedback, I'm moving forward under the impression t=
hat
> > you'll still accept option (2); please let me know if I have misunderst=
ood
> > (thank you for being flexible).
>=20
> Yeah, that's fine. If in the end it shows that this is a bad idea we can
> still change to (3).
>=20

Sounds great. As soon as 5.5-rc5 lands this weekend, I'll rebase v3 and
send it out.

I failed to catch this in my previous reply, but the comment I've added
to iqs620_pwm_get_state actually reads as follows:

/*
 * Since the device cannot generate a 0% duty cycle, requests to do so
 * force subsequent calls to iqs620_pwm_get_state to report the output
 * as disabled with duty cycle equal to that which was in use prior to
 * the request. This is not ideal, but is the best compromise based on
 * the capabilities of the device.
 */

This matches the present implementation, not your proposed comment that
claims duty cycle is clamped to 1 / 256 ms following a request for a 0%
duty cycle.

This seems OK since the concept of a duty cycle or period aren't really
relevant if the output is disabled in my opinion. However if you prefer
I update iqs620_pwm_apply to clamp duty cycle to 1 / 256 ms (instead of
leaving it untouched) in this case, please let me know.

> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Wishing you a Happy New Year,
Jeff LaBundy
