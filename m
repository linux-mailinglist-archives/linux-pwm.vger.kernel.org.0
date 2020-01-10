Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD2D13661A
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jan 2020 05:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgAJE3N (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jan 2020 23:29:13 -0500
Received: from mail-mw2nam12on2078.outbound.protection.outlook.com ([40.107.244.78]:20813
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731162AbgAJE3N (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 Jan 2020 23:29:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EztRJQ6ynTVijnx8+6q5amTvheNrDvxRsTtUObp4afHJgQ/I0PCmDHyAGUQH0IdQomH9PzhQCTw8gkWkrycZ4A0XM8kgqbldKJmLhvCc/TpVK3JO0cQQgvFOkpbYHVHhNvwSDxniTNeu91KzD5r1bQj/1N8Sq3rOgNXpdDRa/fbJV/7QX56t6wPuMXwtp3fHdlemWWXjrqLtMJMCI2OKh/2TFxAGgpllSSvF1vnye0llLyCmP+2t4IFS5mnREnRquXT4We3/JyZgdbpCePProii+csb1GIwK90OTYclHck6oXvdGHKjoQJlEr6oDscJ9kAvtbluFpg1aJVTI5Vp3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFfuDWrzCVGvAfyLlmgKf/nyRqL2jQilEuiHFfbRoDA=;
 b=TihYqb4ahsDUBqZaSUdaK/Ah63vQ2bPVBqZKDzD2mGdLYnKGnb1D+ImjwFsCjClkia1JW3dHfA3BC4Q+BuU2d4o6lsvBO8vWAOzoxlBa1vujmfykK1fZzwPO3PVsu6oNqMTWQFjD5QOQW6DuPLoJvvAfaa0GhScpv4r1BtwbH4nD6ZAZbeHg/apbSyQWjK/mLJAItkFoC9oK4cMvDBoooOlHmkdjP4gU0D3o2WscyKGVQVqZxYoX9ZVsfMa1CZw2E9A0GehtnbaDvcngYkEGRTfDbMJVJ92tvhn4+uqcQs1xYfCCbheaD7FBgaqNaHFIeguyVpKFHUEva1IzL6JQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFfuDWrzCVGvAfyLlmgKf/nyRqL2jQilEuiHFfbRoDA=;
 b=xriLT65/4YAZIVAspSqJvxyMkhJbFtwqX3dZbsc/omXjStxgN9IABrj0gELXq2lAs3HryFe47hoRk5P7bQ5qZFSZV4XoervIQkHcVcPBqLrooYb8iGNcvYwJ2xPTk1gfvoZudc885DASG83vTJKpGXBphKSEJgBQLv5/1jPVxSA=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4480.namprd08.prod.outlook.com (52.135.71.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 10 Jan 2020 04:29:08 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2623.010; Fri, 10 Jan 2020
 04:29:08 +0000
Received: from labundy.com (136.49.227.119) by SN6PR16CA0068.namprd16.prod.outlook.com (2603:10b6:805:ca::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.11 via Frontend Transport; Fri, 10 Jan 2020 04:29:03 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Topic: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Thread-Index: AQHVrij+8yO8xEtV+ECzt9/U9i+G6qexaTEAgAEU0QCAAHrSgIAIuWeAgADVNACABeTNAIAAXxsAgAE1m4CAAsXugIAPxXqAgAiwCACABEQ3gA==
Date:   Fri, 10 Jan 2020 04:29:08 +0000
Message-ID: <20200110042851.GA23906@labundy.com>
References: <20191210000252.GA6361@labundy.com>
 <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
 <20191215203607.GA31390@labundy.com>
 <20191216091912.r4onikojbkbmguag@pengutronix.de>
 <20191220031924.GA2658@labundy.com>
 <20191220085948.iagsdpjqd6ixdo7j@pengutronix.de>
 <20191221032755.GA3051@labundy.com>
 <20191222214851.kapsro6b6qylke43@pengutronix.de>
 <20200101223933.GB14339@labundy.com>
 <20200107111940.ymiey7npx6rrppqz@pengutronix.de>
In-Reply-To: <20200107111940.ymiey7npx6rrppqz@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR16CA0068.namprd16.prod.outlook.com
 (2603:10b6:805:ca::45) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b42492d3-832d-49f4-33f6-08d79585a1ea
x-ms-traffictypediagnostic: SN6PR08MB4480:
x-microsoft-antispam-prvs: <SN6PR08MB448088F2923080493736E34BD3380@SN6PR08MB4480.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39830400003)(34096005)(366004)(396003)(346002)(136003)(199004)(189003)(4326008)(66446008)(66556008)(8676002)(16526019)(81156014)(8936002)(64756008)(2906002)(7416002)(52116002)(7696005)(66946007)(6916009)(55016002)(66476007)(186003)(26005)(966005)(54906003)(81166006)(316002)(33656002)(1076003)(36756003)(8886007)(66574012)(71200400001)(2616005)(86362001)(956004)(508600001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4480;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +34nBxNzacjjgFgExyPsoTGISBNRfBk9j0NvStgcdU6THundArt1o8brlwIJ8sfkxho+3g4wTtCXKC5U1VS6PwS3+C0BEaSYbgkOtAHTQgHnORM0cpzn+6NEFe7Lmq3UphlamNLMWTMyL28dSI9LqjwZoT/hl1Hkrx/s0ws6Urlu+rtfBFttTOAsdcqQ7Lj57y5EYfWdG/s4Ty62QYsjjaXVAHssJBhEpThirJ5qQ+LnNrnEzBmkdU82u1TYHb21tNDDkGgQgsBqta/KIY961y/8cO71IGIMzPsSPaszhq0Dddst9aQLsyZbD2ztVKAjllVgERyPBQxYdBYRqwctHR3pVKzANfc5DWa2q6G6Ap/lN4V4rnQ4bHRy67KU5R5nmbPVeZI83t4s8bue6m9R8/jazcSk9S1LOUpQJJNEsASb9G1lJYu5Z9KCOYTDJGdtD6zvHdAiWuxC1BrQ5/Vf6ZgXtRr0svMsQ70JRMKw6wY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0BD0E6A2A1A1C145924E6F804C26EE79@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42492d3-832d-49f4-33f6-08d79585a1ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 04:29:08.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ro7/kc+o+NMx/h+LZl3lVNfWKBD/ENE/1qAE9CGtJDCi6txZWey7FwpBoejOnPC790k4A8+l+pMzltH+Ea0BDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4480
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, Jan 07, 2020 at 12:19:40PM +0100, Uwe Kleine-K=F6nig wrote:
> Hi Jeff,
>=20
> On Wed, Jan 01, 2020 at 10:39:36PM +0000, Jeff LaBundy wrote:
> > On Sun, Dec 22, 2019 at 10:48:51PM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Sat, Dec 21, 2019 at 03:28:01AM +0000, Jeff LaBundy wrote:
> > > > Based on your other feedback, I'm moving forward under the impressi=
on that
> > > > you'll still accept option (2); please let me know if I have misund=
erstood
> > > > (thank you for being flexible).
> > >=20
> > > Yeah, that's fine. If in the end it shows that this is a bad idea we =
can
> > > still change to (3).
> >=20
> > Sounds great. As soon as 5.5-rc5 lands this weekend, I'll rebase v3 and
> > send it out.
> >=20
> > I failed to catch this in my previous reply, but the comment I've added
> > to iqs620_pwm_get_state actually reads as follows:
> >=20
> > /*
> >  * Since the device cannot generate a 0% duty cycle, requests to do so
> >  * force subsequent calls to iqs620_pwm_get_state to report the output
> >  * as disabled with duty cycle equal to that which was in use prior to
> >  * the request. This is not ideal, but is the best compromise based on
> >  * the capabilities of the device.
> >  */
> >=20
> > This matches the present implementation, not your proposed comment that
> > claims duty cycle is clamped to 1 / 256 ms following a request for a 0%
> > duty cycle.
>=20
> Yeah, if that's the mechanism that is actually implemented, that's fine
> of course.
>=20
> > This seems OK since the concept of a duty cycle or period aren't really
> > relevant if the output is disabled in my opinion. However if you prefer
> > I update iqs620_pwm_apply to clamp duty cycle to 1 / 256 ms (instead of
> > leaving it untouched) in this case, please let me know.
>=20
> For a disabled PWM the duty_cycle and period are not relevant, for an
> enabled PWM running with 0% the period matters (at least in theory)
> however.
>=20

Agreed in full. We should be covered here since we report the (fixed)
period in all cases.

> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

I managed to send out v3 this past weekend; please let me know if you
have any further feedback or you find it to be satisfactory.

Kind regards,
Jeff LaBundy
